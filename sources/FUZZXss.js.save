log = [];
let anchor = document.createElement('a');
for (let i = 0; i <= 0x10ffff; i++) {
    anchor.href = `${String.fromCodePoint(i)}javascript:`;
    if (anchor.protocol === 'javascript:') {
        log.push(i);
    }
} 
