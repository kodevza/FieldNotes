document.addEventListener("click", async (event) => {
  const button = event.target.closest("[data-copy-button]");
  if (!button) return;

  const block = button.closest("[data-code-copy]");
  const code = block && block.querySelector("code");
  if (!code) return;

  const previousText = button.textContent;

  try {
    await navigator.clipboard.writeText(code.innerText);
    button.textContent = "Copied";
    window.setTimeout(() => {
      button.textContent = previousText;
    }, 1400);
  } catch {
    button.textContent = "Failed";
    window.setTimeout(() => {
      button.textContent = previousText;
    }, 1400);
  }
});
