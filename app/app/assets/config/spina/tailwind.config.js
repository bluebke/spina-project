module.exports = {
  content: [
    '/usr/local/bundle/gems/spina-2.20.0/app/views/**/*.*',
'/usr/local/bundle/gems/spina-2.20.0/app/components/**/*.*',
'/usr/local/bundle/gems/spina-2.20.0/app/helpers/**/*.*',
'/usr/local/bundle/gems/spina-2.20.0/app/assets/javascripts/**/*.js',
'/usr/local/bundle/gems/spina-2.20.0/app/**/application.tailwind.css'
  ],
  theme: {
    fontFamily: {
      body: ['Metropolis'],
      mono: ['ui-monospace', 'SFMono-Regular', 'Menlo', 'Monaco', 'Consolas', "Liberation Mono", "Courier New", 'monospace']
    },
    extend: {
      colors: {
        spina: {
          light: '#797ab8',
          DEFAULT: '#6865b4',
          dark: '#3a3a70'
        }
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
	require('@tailwindcss/aspect-ratio'),
	require('@tailwindcss/typography')
  ]
}
