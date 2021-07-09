Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9C63C1C78
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 02:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhGIARE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 20:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhGIARE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 20:17:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9139BC061574;
        Thu,  8 Jul 2021 17:14:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 4E9701F41790
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net,
        Peter Oskolkov <posk@posk.io>,
        Andrey Semashev <andrey.semashev@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v5 04/11] docs: locking: futex2: Add documentation
Date:   Thu,  8 Jul 2021 21:13:21 -0300
Message-Id: <20210709001328.329716-5-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709001328.329716-1-andrealmeid@collabora.com>
References: <20210709001328.329716-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new documentation file specifying both userspace API and internal
implementation details of futex2 syscalls.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 Documentation/locking/futex2.rst | 185 +++++++++++++++++++++++++++++++
 Documentation/locking/index.rst  |   1 +
 2 files changed, 186 insertions(+)
 create mode 100644 Documentation/locking/futex2.rst

diff --git a/Documentation/locking/futex2.rst b/Documentation/locking/futex2.rst
new file mode 100644
index 000000000000..2bf40f2abd00
--- /dev/null
+++ b/Documentation/locking/futex2.rst
@@ -0,0 +1,185 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======
+futex2
+======
+
+:Author: André Almeida <andrealmeid@collabora.com>
+
+futex, or fast user mutex, is a set of syscalls to allow userspace to create
+performant synchronization mechanisms, such as mutexes, semaphores and
+conditional variables in userspace. C standard libraries, like glibc, uses it
+as a means to implement more high level interfaces like pthreads.
+
+The interface
+=============
+
+uAPI functions
+--------------
+
+.. kernel-doc:: kernel/futex2.c
+   :identifiers: sys_futex_wait sys_futex_wake sys_futex_waitv sys_futex_requeue
+
+uAPI structures
+---------------
+
+.. kernel-doc:: include/uapi/linux/futex.h
+
+The ``flag`` argument
+---------------------
+
+The flag is used to specify the size of the futex word
+(FUTEX_[8, 16, 32, 64]). It's mandatory to define one, since there's no
+default size.
+
+By default, the timeout uses a monotonic clock, but can be used as a realtime
+one by using the FUTEX_REALTIME_CLOCK flag.
+
+By default, futexes are of the private type, that means that this user address
+will be accessed by threads that share the same memory region. This allows for
+some internal optimizations, so they are faster. However, if the address needs
+to be shared with different processes (like using ``mmap()`` or ``shm()``), they
+need to be defined as shared and the flag FUTEX_SHARED_FLAG is used to set that.
+
+By default, the operation has no NUMA-awareness, meaning that the user can't
+choose the memory node where the kernel side futex data will be stored. The
+user can choose the node where it wants to operate by setting the
+FUTEX_NUMA_FLAG and using the following structure (where X can be 8, 16, 32 or
+64)::
+
+ struct futexX_numa {
+         __uX value;
+         __sX hint;
+ };
+
+This structure should be passed at the ``void *uaddr`` of futex functions. The
+address of the structure will be used to be waited on/waken on, and the
+``value`` will be compared to ``val`` as usual. The ``hint`` member is used to
+define which node the futex will use. When waiting, the futex will be
+registered on a kernel-side table stored on that node; when waking, the futex
+will be searched for on that given table. That means that there's no redundancy
+between tables, and the wrong ``hint`` value will lead to undesired behavior.
+Userspace is responsible for dealing with node migrations issues that may
+occur. ``hint`` can range from [0, MAX_NUMA_NODES), for specifying a node, or
+-1, to use the same node the current process is using.
+
+When not using FUTEX_NUMA_FLAG on a NUMA system, the futex will be stored on a
+global table on allocated on the first node.
+
+The ``timo`` argument
+---------------------
+
+As per the Y2038 work done in the kernel, new interfaces shouldn't add timeout
+options known to be buggy. Given that, ``timo`` should be a 64-bit timeout at
+all platforms, using an absolute timeout value.
+
+Implementation
+==============
+
+Kernel side implementation is made on top of current futex codebase.
+
+Waiting
+-------
+
+We have a hash table, where waiters register themselves before sleeping. Then
+the wake function checks this table looking for waiters at uaddr. The hash
+bucket to be used is determined by a struct futex_key, that stores information
+to uniquely identify an address from a given process. Given the huge address
+space, there'll be hash collisions, so we store information to be later used on
+collision treatment.
+
+First, for every futex we want to wait on, we check if (``*uaddr == val``).
+This check is done holding the bucket lock, so we are correctly serialized with
+any futex_wake() calls. If any waiter fails the check above we return. For
+futex_waitv() calls, we dequeue all futexes queue until this point. The check
+(``*uaddr == val``) can fail for two reasons:
+
+- The values are different, and we return -EAGAIN. However, if while
+  dequeueing we found that some futexes were awakened, we prioritize this
+  and return success.
+
+- When trying to access the user address, we do so with page faults
+  disabled because we are holding a bucket's spin lock (and can't sleep
+  while holding a spin lock). If there's an error, it might be a page
+  fault, or an invalid address. We release the lock, dequeue everyone if it's a
+  futex_waitv() call (because it's illegal to sleep while there are futexes
+  enqueued, we could lose wakeups) and try again with page fault enabled. If we
+  succeed, this means that the address is valid, but we need to do all the work
+  again. For serialization reasons, we need to have the spin lock when getting
+  the user value. Additionally, for shared futexes, we also need to recalculate
+  the hash, since the underlying mapping mechanisms could have changed when
+  dealing with page fault.  If, even with page fault enabled, we can't access
+  the address, it means it's an invalid user address, and we return -EFAULT.
+
+If the check is OK, they are enqueued on a linked list in our bucket, and
+proceed to the next one. If all waiters succeed, we put the thread to sleep
+until a futex_wake() call, timeout expires or we get a signal. After waking up,
+we dequeue everyone, and check if some futex was awakened.
+
+All enqueuing/dequeuing operations requires to hold the bucket lock, to avoid
+racing while modifying the list.
+
+Waking
+------
+
+We get the bucket that's storing the waiters at uaddr, and wake the required
+number of waiters, checking for hash collision.
+
+There's an optimization that makes futex_wake() not take the bucket lock if
+there's no one to be woken on that bucket. It checks an atomic counter that each
+bucket has, if it says 0, then the syscall exits. In order for this to work, the
+waiter thread increases it before taking the lock, so the wake thread will
+correctly see that there's someone waiting and will continue the path to take
+the bucket lock. To get the correct serialization, the waiter issues a memory
+barrier after increasing the bucket counter and the waker issues a memory
+barrier before checking it.
+
+Requeuing
+---------
+
+The requeue path first checks for each struct futex_requeue and their flags.
+Then, it will compare the expected value with the one at rq1::uaddr.
+Following the same serialization explained at Waking_, we increase the atomic
+counter for the bucket of rq2::uaddr before taking the lock. We need to have
+both buckets locks at same time so we don't race with other futex operation. To
+ensure the locks are taken in the same order for all threads (and thus avoiding
+deadlocks), every requeue operation takes the "smaller" bucket first, when
+comparing both addresses.
+
+If the compare with user value succeeds, we proceed by waking ``nr_wake``
+futexes, and then requeuing ``nr_requeue`` from bucket of uaddr1 to the uaddr2.
+This consists in a simple list deletion/addition and replacing the old futex key
+with the new one.
+
+Futex keys
+----------
+
+There are two types of futexes: private and shared ones. The private are futexes
+meant to be used by threads that share the same memory space, are easier to be
+uniquely identified and thus can have some performance optimization. The
+elements for identifying one are: the start address of the page where the
+address is, the address offset within the page and the current->mm pointer.
+
+Now, for uniquely identifying a shared futex:
+
+- If the page containing the user address is an anonymous page, we can
+  just use the same data used for private futexes (the start address of
+  the page, the address offset within the page and the current->mm
+  pointer); that will be enough for uniquely identifying such futex. We
+  also set one bit at the key to differentiate if a private futex is
+  used on the same address (mixing shared and private calls does not
+  work).
+
+- If the page is file-backed, current->mm maybe isn't the same one for
+  every user of this futex, so we need to use other data: the
+  page->index, a UUID for the struct inode and the offset within the
+  page.
+
+Note that members of futex_key don't have any particular meaning after they
+are part of the struct - they are just bytes to identify a futex.
+
+Source code documentation
+=========================
+
+.. kernel-doc:: kernel/futex2.c
+   :no-identifiers: sys_futex_wait sys_futex_wake sys_futex_waitv sys_futex_requeue
diff --git a/Documentation/locking/index.rst b/Documentation/locking/index.rst
index 7003bd5aeff4..9bf03c7fa1ec 100644
--- a/Documentation/locking/index.rst
+++ b/Documentation/locking/index.rst
@@ -24,6 +24,7 @@ locking
     percpu-rw-semaphore
     robust-futexes
     robust-futex-ABI
+    futex2
 
 .. only::  subproject and html
 
-- 
2.32.0

