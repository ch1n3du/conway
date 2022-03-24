# Helper functions for manipulating the board
%lang starknet
%builtins pedersen range_check 

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import (
    assert_nn_le,
    unsigned_div_rem)
from pow2 import pow2

# Function to do a right shift
func right_shift{range_check_ptr}(
    val, n) -> (res):
    let (divisor) = pow2(n)
    let (res, _) = unsigned_div_rem(val, divisor)

    return (res)
end

func left_shift{}(
    val, n) -> (res):
    let (multiplier) = pow2(n)
    let res = val * multiplier

    return (res)
end

# Function to convert x, y coordinate to an index
func point_to_index{range_check_ptr}(
    x, y, width) -> (index):
    # Check that x index is valid
    assert_nn_le(x, width)
    let index = x + (y * width)

    return (index)
end

# Function to convert indexa in array to a point of a board of given width
func index_to_point{range_check_ptr}(
    index, width) -> (x, y):
    let (y, x) = unsigned_div_rem(index, width)

    return (x, y)
end

func get_bit{range_check}(
    val, index) -> (res):
    assert_nn_le(index, 224)

    let (temp) = left_shift(val, index+27)
    let res = right_shift(temp, 251)

    return (res)
end