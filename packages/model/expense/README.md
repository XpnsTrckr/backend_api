# Expense

A single expense item.

Contains a [value] and a [time], in addition to [id] and [userId], detailing
further this [Expense] item.

[Expense]s are immutable and can be copied using [copyWith], in addition to
being json de/serializable.