## DBMS Indexing

---

搜索最快：

- Hash Map

  O(1)

为什么不用Hash Table，而用Hash Map

hash table没有用数据本身顺序的特点

动态查找更适用于Tree，如果是有序的用Binary tree(order)

Balance binary tree O(logn) 

Red-black tree

当index足够大， disk I/O



### 1. Sparse Index(稀疏索引)

1. index is ordered
2.  tow entries:
   1. index field 
   2. block pointer
3. keep only one key per data block
4. some keys in the data file will not have index file

在稀疏索引中，只为一部分Value建立索引index，稀疏索引也是聚集索引的一种。每一个索引项包括索引值和指针

#### Advantage:

1. less space at the expense of index, more time to find a record given its key
2. support multi_level indexing structure

#### Disadvantage:

给定一个键定位一个record，有不同的value表现

在稀疏index中，不会对每个搜索key创建搜索索引记录。索引记录也包含搜索键和指向磁盘上数据的实际指针。

### 2. Dense Index(稠密索引)

1. Data File中的每个键都在Index File中表示
2. 在给定key的情况下能够很有效定位到record
3. too big fit into the memory

DB中的每个搜索键值都有一个index。这样可以加快搜索速度，但需要更多空间来存储索引记录本身。Index包含搜索键值和指向磁盘上实际记录的指针

---

这两种索引都要通过折半查找或者叫做二分查找来确定数据位置，不同的是密集索引，只需要通过二分查找到搜索值=索引的索引记录就能确定准确的数据位置，而稀疏索引则需要先定位到搜索值>索引值的最小的那个，然后在通过起始位置去定位具体的偏移量。

这是两种不同的索引实现，一种建立了索引值与数据位置的1:1的关系，一种建立了索引值与数据位置1:n的关系。在大多数场景密集索引查询效率更高，在大多数场景稀疏索引占用空间更小。

### Single Level Index(单级索引)

1. Signle level index是一个辅助文件，可以更有效地search data file中的record
2. index通常在文件的一个字段上指定
3. index的一种形式：
   - `<field value, pointer to block>`,按field value排序

### Multi-Level Indexes(多级索引)

多级索引以因子`bfr`来减小需要继续搜索的索引文件的长度。`bfr`是索引文件的块因此，也被称之为多级索引的fan-out;

to reduce number of disk accesses to index records. Treat primary index kept on disk as a sequential file and construct a sparse index on it

- outer index: a sparse index of primary index
- inner index: the primary index file

---



- Search Key: attribute to set of attributes used to look up records in a file

用于在file中查找attribute的attribute

- Index file consists of records(index entries) of the form:

  `Search_key || pointer`

- Two basic kinds of implementations:

  - Tree
  - Hash 

hash function 能够将任意长度的输入值转变成固定长度的值输出，输出值为散列值，由字母与数字组合。



Full Tree: 

- every node has exactly two children
- all the leaves are on the same level



B Tree可以作为动态多级索引用来引导在数据文件中查找记录。B Tree的节点保持在半满和全满之间，在这种结构中，内部节点和叶节点都存放指向数据块的指针。

B+Tree只有叶节点存放指向文件中数据块的指针，因此它可以使索引具有更少的层级和更高的容量

### 搜索树

p阶搜索树的每个node包括p-1个key value和p个 pointer。

排序顺序为`<P1,K1,P2,K2,...,Pq-1,Kq-1,Pq>`;每个Pi是指向一个子节点的指针(或者指向一个NULL指针)。每个Ki是一个搜索值，来自值的某个有序集合

搜索树必须满足的条件：

- 对每个节点中：

1. K1<K2<...<Kq-1

- 对于Pi指向的子树中的所有值X

1. Ki-1<X<Ki

2. Ki-1<X
3. X<Ki

向搜索树中插入或者从中删除搜索值 需要使搜索树仍然满足约束条件。一般来说，无法保证搜索树的平衡，平衡是指所有leaf node处于同一层。

保持树的平衡，可以保证没有节点位于很高的层次上，以至于在树的搜索中需要更多的块访问次数。

搜索树的另外一个问题是当记录删除时会使树中的一些节点几乎变空，浪费存储空间，同时增加了树的层次

### B树

B Tree使用附加条件保证树总是平衡的，并且保证由于删除而造成的空间浪费在一定范围内。

大多数insert和delete操作处理仍然简单，只有在特殊情况下会复杂。包括：向一个已满的node中执行insert，从一个node中delete导致该节点不足半满。

B-tree of order p的定义：

