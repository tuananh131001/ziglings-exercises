const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    //
    // Let's continue our journey into Zig builtins!
    //
    // This time, we’ll meet:
    //   @subWithOverflow(a, b)
    //     → Returns a tuple (result, overflow_bit)
    //     → overflow_bit == 1 means subtraction overflowed
    //
    //   @bitCast(T, value)
    //     → Reinterprets the bits of `value` as type `T`
    //       (no conversion, just bit reinterpretation)
    //

    const a: u4 = 0b0011; // 3
    const b: u4 = 0b0101; // 5
    const sub_result = @subWithOverflow(a, b);

    print("Subtracting {b:0>4} - {b:0>4} = {b:0>4} (overflow: {s})\n",
        .{ a, b, sub_result[0], if (sub_result[1] == 1) "true" else "false" });

    //
    // Can you reason about the result?
    // Since u4 can only hold values 0–15, subtracting 5 from 3
    // underflows (wraps around to 14, since 3 - 5 = -2, and -2 mod 16 = 14).
    //

    // ----------------------------------------------------------
    // Now, let’s play with @bitCast:
    //
    // Imagine we have the bits 01000001 (which represent the ASCII
    // letter 'A' if interpreted as a u8), but what if we reinterpret
    // them as a signed integer (i8)?
    const byte: u8 = 0b01000001;
    const reinterpreted: i8 = @bitCast(byte);

    print("Bits {b:0>8} as unsigned is {} and as signed is {}.\n",
        .{ byte, byte, reinterpreted });

    //
    // TASK:
    // 1️⃣ Change `byte` to 0b10000001 and re-run. What happens?
    //     (Hint: signed i8 uses two’s complement representation)
    //
    // 2️⃣ Try using @bitReverse on the same byte and see what character code it becomes!
    //     For example:
    //        const reversed = @bitReverse(byte);
    //        print("Reversed bits: {b:0>8} (decimal: {})\n", .{ reversed, reversed });
    //
}

