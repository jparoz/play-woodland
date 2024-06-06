export function append_child(selector, html) {
    const el = document.querySelector(selector);
    el.insertAdjacentHTML("beforeend", html);
}
