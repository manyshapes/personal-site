<script>
	import Home from './components/Home.svelte';
	export let name;

</script>

<main>
	<h1>Landing Page</h1>
	<p>Last Updated 2023/11/28</p>
	<Home />

</main>

<footer>
  <a href="https://github.com/manyshapes/personal-site/">
  <p>Built with Svelte, Go, Terraform | Hosted on AWS</p>
  </a>
</footer>

<style>

	body {
		display: flex;
		flex-direction: column;
		min-height: 200vh;
		margin: 0;

	}

	main {
		flex: 1;
		text-align: center;
		padding: 1em;
		max-width: 240px;
		margin: 0 auto;
	}

	h1 {
		color: #ff3e00;
	/*	text-transform: uppercase; */
		font-size: 4em;
		font-weight: 100;
	}


	footer {
		text-align: center;
		margin-top: auto; /* Push the footer to the bottom */
		padding: 10;
	}

	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>