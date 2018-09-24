
# ARC (Automatic Reference Counting)

Because ARC is “automatic”, you don’t have explicitly participate in the reference counting of objects. You do, however, need to consider relationships between objects to avoid memory leaks. This is a very important requirement often overlooked by new developers.

The five stages of a Swift object
1. Allocation (memory taken from stack or heap)
2. Initialization (init code runs)
3. Usage (the object is used)
4. Deinitialization (deinit code runs)
5. Deallocation (memory returned to stack or heap)

Reference counting is the mechanism by which an object is deallocated when it is no longer required. 
Reference counting manages this by keeping a usage count, also known as the reference count, inside each object instance.

## Reference cycles

reference cycles can cause memory leaks, we can explain this by having an example. Imagine two objects having a reference with each other, thus incrementing both of their reference counts. Even if when both are deallocated, they both are still alive in memory, thus creating a leak -- this is called a strong reference cycle.

## Weak References
To break strong reference cycles, you can specify the relationship between reference counted objects as weak. Unless otherwise specified, all references are strong. Weak references, by contrast, don’t increase the strong reference count of the object.

## Unowned References
Another modifier that does not increase the reference count. Unowned references are never optional types. If you try to access an unowned property that refers to a deinitialized object, you will trigger a runtime error.

## Reference Cycles in Closures
For example, if a closure is assigned to the property of a class, and that closure uses instance properties of that same class, you have a reference cycle.

Swift has a simple, elegant way to break strong reference cycles in closures. You declare a capture list in which you define the relationships between the closure and the objects it captures.




### References:
- https://www.raywenderlich.com/959-arc-and-memory-management-in-swift
