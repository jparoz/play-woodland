export function append_child(selector, html) {
    const el = document.querySelector(selector);
    el.insertAdjacentHTML("beforeend", html);
}

export async function open_json(path, fn) {
    const response = await fetch(".." + path);
    const json = await response.text();
    fn(json);
}
