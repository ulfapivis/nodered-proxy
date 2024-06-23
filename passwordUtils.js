// passwordUtils.js
const bcrypt = require('bcrypt');

async function hashPassword(password) {
    const saltRounds = 10; // You can adjust the number of salt rounds as needed
    try {
        const hashedPassword = await bcrypt.hash(password, saltRounds);
        return hashedPassword;
    } catch (error) {
        console.error('Error hashing password:', error);
        throw error;
    }
}

module.exports = { hashPassword };
