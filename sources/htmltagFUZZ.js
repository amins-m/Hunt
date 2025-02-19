const div = document.createElement('div');
const result = [];
const worked = p => result.push(p);
for (let i = 0; i < 0x10ffff; ++i) {
    div.innerHTML = `<img${String.fromCodePoint(i)}src${String.fromCodePoint(i)}onerror=worked(${i})>`;
}
document.body.appendChild(div);
