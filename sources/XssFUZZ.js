log = [];
let anchor = document.createElement('a');
for (let i = 0; i <= 0x10ffff; i++) {
    anchor.href = `javascript${String.fromCodePoint(i)}:`;
    if (anchor.protocol === 'javascript:') {
        log.push(i);
    }
}
