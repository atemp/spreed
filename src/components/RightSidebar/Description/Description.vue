<!--
  - @copyright Copyright (c) 2020 Marco Ambrosini <marcoambrosini@pm.me>
  -
  - @author Marco Ambrosini <marcoambrosini@pm.me>
  -
  - @license GNU AGPL version 3 or any later version
  -
  - This program is free software: you can redistribute it and/or modify
  - it under the terms of the GNU Affero General Public License as
  - published by the Free Software Foundation, either version 3 of the
  - License, or (at your option) any later version.
  -
  - This program is distributed in the hope that it will be useful,
  - but WITHOUT ANY WARRANTY; without even the implied warranty of
  - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  - GNU Affero General Public License for more details.
  -
  - You should have received a copy of the GNU Affero General Public License
  - along with this program. If not, see <http://www.gnu.org/licenses/>.
-->

<template>
	<!-- Description -->
	<div class="description">
		<!-- Title of the description section -->
		<h3 class="description__title">
			{{ descriptionTitle }}
		</h3>
		<!-- Text of the description -->
		<div class="description__body">
			<RichContentEditable v-model="descriptionText"
				class="description__contenteditable"
				:maxlength="100"
				:multiline="true"
				:contenteditable="isEditingDescription"
				:placeholder="descriptionPlaceholder"
				@submit="handleSubmitDescription" />
			<div class="description__buttons">
				<button
					v-if="!isEditingDescription"
					class="description__button"
					:aria-label="t('spreed','Edit description')"
					@click="handleEditDescription">
					<Pencil decorative
						:size="20" />
				</button>
				<button
					v-if="isEditingDescription"
					class="description__button"
					:aria-label="t('spreed','Submit')"
					@click="handleSubmitDescription">
					<Close decorative
						:size="20" />
				</button>
				<button
					v-if="isEditingDescription"
					class="description__button primary"
					:aria-label="t('spreed','Submit')"
					@click="handleSubmitDescription">
					<Check decorative
						:size="20" />
				</button>
			</div>
		</div>
	</div>
</template>

<script>
import RichContentEditable from '@nextcloud/vue/dist/Components/RichContenteditable'
import Pencil from 'vue-material-design-icons/Pencil'
import Check from 'vue-material-design-icons/Check'
import Close from 'vue-material-design-icons/Close'

export default {
	name: 'Description',
	components: {
		RichContentEditable,
		Pencil,
		Check,
		Close,
	},

	props: {
		/**
		 * The description (An editable paragraph just above the sidebar tabs)
		 */
		descriptionTitle: {
			type: String,
			default: 'Description',
		},

		/**
		 * A paragraph below the title.
		 */
		description: {
			type: String,
			default: '',
		},

		/**
		 * Toggles the description editing state on and off
		 */
		isEditingDescription: {
			type: Boolean,
			default: false,
		},

		/**
		 * Placeholder for the contenteditable element
		 */
		descriptionPlaceholder: {
			type: String,
			default: '',
		},
	},

	data() {
		return {
			descriptionText: this.description,
		}
	},

	computed: {

	},

	watch: {
		// Each time the prop changes, reflect the chandes in the value stored in this component
		description() {
			this.descriptionText = this.description
		},
	},

	methods: {
		handleEditDescription() {
			this.$emit('update:isEditingDescription', true)
		},

		handleSubmitDescription() {
			this.$emit('submit:description', this.descriptionText)
		},
		handleDescriptionKeydown(event) {
			event.stopPropagation()
			if (event.key === 'Escape') {
				this.isEditingDescription = false
				return
			}
			if (event.key === 'Enter') {
				this.handleSubmitDescription()
			}

		},
	},
}
</script>

<style lang="scss" scoped>

.description {
	margin: 8px 0 20px 16px;
	width: 100%;
	&__title {
		color: var(--color-primary);
		font-weight: bold;
	}
	&__body {
		display:flex;
		justify-content: space-between;
		align-items: stretch;
	}
	&__contenteditable{
		max-height: 100px;
		overflow-y: scroll;
		width: 100%;
		&--editing {
			border: 1px solid var(--color-border-dark);
			border-radius: var(--border-radius-large);
			padding: 12px;
			margin-right: 4px;

		}
	}
	&__buttons{
		margin-left: 8px;
		display: flex;
		flex-direction: column;
	}
	&__button {
		width: 44px;
		height: 44px;
		border: 0;
		padding: 0;
		margin: 0 0 4px 0;
		&:not(.primary) {
			background-color: transparent;
		}

		&:hover {
			background-color: var(--color-background-hover);
		}
	}
}

</style>
