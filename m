Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B496039AB34
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jun 2021 22:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFCUCA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Jun 2021 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhFCUCA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Jun 2021 16:02:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC61C06174A;
        Thu,  3 Jun 2021 13:00:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 255AF1F434F9
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
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v4 00/15] Add futex2 syscalls
Date:   Thu,  3 Jun 2021 16:59:09 -0300
Message-Id: <20210603195924.361327-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This patch series introduces the futex2 syscalls.

* What happened to the current futex()?

For some years now, developers have been trying to add new features to
futex, but maintainers have been reluctant to accept then, given the
multiplexed interface full of legacy features and tricky to do big
changes. Some problems that people tried to address with patchsets are:
NUMA-awareness[0], smaller sized futexes[1], wait on multiple futexes[2].
NUMA, for instance, just doesn't fit the current API in a reasonable
way. Considering that, it's not possible to merge new features into the
current futex.

 ** The NUMA problem

 At the current implementation, all futex kernel side infrastructure is
 stored on a single node. Given that, all futex() calls issued by
 processors that aren't located on that node will have a memory access
 penalty when doing it.

 ** The 32bit sized futex problem

 Futexes are used to implement atomic operations in userspace.
 Supporting 8, 16, 32 and 64 bit sized futexes allows user libraries to
 implement all those sizes in a performant way. Thanks Boost devs for
 feedback: https://lists.boost.org/Archives/boost/2021/05/251508.php

 Embedded systems or anything with memory constrains could benefit of
 using smaller sizes for the futex userspace integer.

 ** The wait on multiple problem

 The use case lies in the Wine implementation of the Windows NT interface
 WaitMultipleObjects. This Windows API function allows a thread to sleep
 waiting on the first of a set of event sources (mutexes, timers, signal,
 console input, etc) to signal.  Considering this is a primitive
 synchronization operation for Windows applications, being able to quickly
 signal events on the producer side, and quickly go to sleep on the
 consumer side is essential for good performance of those running over Wine.

[0] https://lore.kernel.org/lkml/20160505204230.932454245@linutronix.de/
[1] https://lore.kernel.org/lkml/20191221155659.3159-2-malteskarupke@web.de/
[2] https://lore.kernel.org/lkml/20200213214525.183689-1-andrealmeid@collabora.com/

* The solution

As proposed by Peter Zijlstra and Florian Weimer[3], a new interface
is required to solve this, which must be designed with those features in
mind. futex2() is that interface. As opposed to the current multiplexed
interface, the new one should have one syscall per operation. This will
allow the maintainability of the API if it gets extended, and will help
users with type checking of arguments.

In particular, the new interface is extended to support the ability to
wait on any of a list of futexes at a time, which could be seen as a
vectored extension of the FUTEX_WAIT semantics.

[3] https://lore.kernel.org/lkml/20200303120050.GC2596@hirez.programming.kicks-ass.net/

* The interface

The new interface can be seen in details in the following patches, but
this is a high level summary of what the interface can do:

 - Supports wake/wait semantics, as in futex()
 - Supports requeue operations, similarly as FUTEX_CMP_REQUEUE, but with
   individual flags for each address
 - Supports waiting for a vector of futexes, using a new syscall named
   futex_waitv()
 - Supports variable sized futexes (8bits, 16bits, 32bits and 64bits)
 - Supports NUMA-awareness operations, where the user can specify on
   which memory node would like to operate

* Implementation

The internal implementation follows a similar design to the original futex.
Given that we want to replicate the same external behavior of current
futex, this should be somewhat expected. For some functions, like the
init and the code to get a shared key, I literally copied code and
comments from kernel/futex.c. I decided to do so instead of exposing the
original function as a public function since in that way we can freely
modify our implementation if required, without any impact on old futex.
Also, the comments precisely describes the details and corner cases of
the implementation.

Each patch contains a brief description of implementation, but patch 7
"docs: locking: futex2: Add documentation" adds a more complete document
about it.

* The patchset

This patchset can be also found at my git tree:

https://gitlab.collabora.com/tonyk/linux/-/tree/futex2-dev

  - Patch 1: Implements wait/wake, and the basics foundations of futex2

  - Patches 2-5: Implement the remaining features (shared, waitv,
    requeue, sizes).

  - Patch 6:  Adds the x86_x32 ABI handling. I kept it in a separated
    patch since I'm not sure if x86_x32 is still a thing, or if it should
    return -ENOSYS.

  - Patch 7: Add a documentation file which details the interface and
    the internal implementation.

  - Patches 8-14: Selftests for all operations along with perf
    support for futex2.

  - Patch 15: While working on porting glibc for futex2, I found out
    that there's a futex_wake() call at the user thread exit path, if
    that thread was created with clone(..., CLONE_CHILD_SETTID, ...). In
    order to make pthreads work with futex2, it was required to add
    this patch. Note that this is more a proof-of-concept of what we
    will need to do in future, rather than part of the interface and
    shouldn't be merged as it is.

* Testing:

This patchset provides selftests for each operation and their flags.
Along with that, the following work was done:

 ** Stability

 To stress the interface in "real world scenarios":

 - glibc[4]: nptl's low level locking was modified to use futex2 API
   (except for robust and PI things). All relevant nptl/ tests passed.

 - Wine[5]: Proton/Wine was modified in order to use futex2() for the
   emulation of Windows NT sync mechanisms based on futex, called "fsync".
   Triple-A games with huge CPU's loads and tons of parallel jobs worked
   as expected when compared with the previous FUTEX_WAIT_MULTIPLE
   implementation at futex(). Some games issue 42k futex2() calls
   per second.

 - Full GNU/Linux distro: I installed the modified glibc in my host
   machine, so all pthread's programs would use futex2(). After tweaking
   systemd[6] to allow futex2() calls at seccomp, everything worked as
   expected (web browsers do some syscall sandboxing and need some
   configuration as well).

 - perf: The perf benchmarks tests can also be used to stress the
   interface, and they can be found in this patchset.

 ** Performance

 - For comparing futex() and futex2() performance, I used the artificial
   benchmarks implemented at perf (wake, wake-parallel, hash and
   requeue). The setup was 200 runs for each test and using 8, 80, 800,
   8000 for the number of threads, Note that for this test, I'm not using
   patch 14 ("kernel: Enable waitpid() for futex2") , for reasons explained
   at "The patchset" section.

 - For the first three ones, I measured an average of 4% gain in
   performance. This is not a big step, but it shows that the new
   interface is at least comparable in performance with the current one.

 - For requeue, I measured an average of 21% decrease in performance
   compared to the original futex implementation. This is expected given
   the new design with individual flags. The performance trade-offs are
   explained at patch 4 ("futex2: Implement requeue operation").

[4] https://gitlab.collabora.com/tonyk/glibc/-/tree/futex2
[5] https://gitlab.collabora.com/tonyk/wine/-/tree/proton_5.13
[6] https://gitlab.collabora.com/tonyk/systemd

* FAQ

 ** "Where's the code for NUMA?"

 NUMA will be implemented in future versions of this patch, and like the
 size feature, it will require work with users of futex to get feedback
 about it.

 ** "Where's the PI/robust stuff?"

 As said by Peter Zijlstra at [3], all those new features are related to
 the "simple" futex interface, that doesn't use PI or robust. Do we want
 to have this complexity at futex2() and if so, should it be part of
 this patchset or can it be future work?

Thanks,
	André

* Changelog

Changes from v3:
- Implemented variable sized futexes
v3: https://lore.kernel.org/lkml/20210427231248.220501-1-andrealmeid@collabora.com/

Changes from v2:
- API now supports 64bit futexes, in addition to 8, 16 and 32.
- This API change will break the glibc[4] and Proton[5] ports for now.
- Refactored futex2_wait and futex2_waitv selftests
v2: https://lore.kernel.org/lkml/20210304004219.134051-1-andrealmeid@collabora.com/

Changes from v1:
- Unified futex_set_timer_and_wait and __futex_wait code
- Dropped _carefull from linked list function calls
- Fixed typos on docs patch
- uAPI flags are now added as features are introduced, instead of all flags
  in patch 1
- Removed struct futex_single_waiter in favor of an anon struct
v1: https://lore.kernel.org/lkml/20210215152404.250281-1-andrealmeid@collabora.com/

André Almeida (15):
  futex2: Implement wait and wake functions
  futex2: Add support for shared futexes
  futex2: Implement vectorized wait
  futex2: Implement requeue operation
  futex2: Implement support for different futex sizes
  futex2: Add compatibility entry point for x86_x32 ABI
  docs: locking: futex2: Add documentation
  selftests: futex2: Add wake/wait test
  selftests: futex2: Add timeout test
  selftests: futex2: Add wouldblock test
  selftests: futex2: Add waitv test
  selftests: futex2: Add requeue test
  selftests: futex2: Add futex sizes test
  perf bench: Add futex2 benchmark tests
  kernel: Enable waitpid() for futex2

 Documentation/locking/futex2.rst              |  198 +++
 Documentation/locking/index.rst               |    1 +
 MAINTAINERS                                   |    2 +-
 arch/arm/tools/syscall.tbl                    |    4 +
 arch/arm64/include/asm/unistd.h               |    2 +-
 arch/arm64/include/asm/unistd32.h             |    8 +
 arch/x86/entry/syscalls/syscall_32.tbl        |    4 +
 arch/x86/entry/syscalls/syscall_64.tbl        |    4 +
 fs/inode.c                                    |    1 +
 include/linux/compat.h                        |   26 +
 include/linux/fs.h                            |    1 +
 include/linux/syscalls.h                      |   17 +
 include/uapi/asm-generic/unistd.h             |   14 +-
 include/uapi/linux/futex.h                    |   34 +
 init/Kconfig                                  |    7 +
 kernel/Makefile                               |    1 +
 kernel/fork.c                                 |    2 +
 kernel/futex2.c                               | 1289 +++++++++++++++++
 kernel/sys_ni.c                               |    9 +
 tools/arch/x86/include/asm/unistd_64.h        |   12 +
 tools/include/uapi/asm-generic/unistd.h       |   11 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |    4 +
 tools/perf/bench/bench.h                      |    4 +
 tools/perf/bench/futex-hash.c                 |   24 +-
 tools/perf/bench/futex-requeue.c              |   57 +-
 tools/perf/bench/futex-wake-parallel.c        |   41 +-
 tools/perf/bench/futex-wake.c                 |   37 +-
 tools/perf/bench/futex.h                      |   47 +
 tools/perf/builtin-bench.c                    |   18 +-
 .../selftests/futex/functional/.gitignore     |    4 +
 .../selftests/futex/functional/Makefile       |    7 +-
 .../futex/functional/futex2_requeue.c         |  164 +++
 .../selftests/futex/functional/futex2_sizes.c |  146 ++
 .../selftests/futex/functional/futex2_wait.c  |  195 +++
 .../selftests/futex/functional/futex2_waitv.c |  154 ++
 .../futex/functional/futex_wait_timeout.c     |   58 +-
 .../futex/functional/futex_wait_wouldblock.c  |   33 +-
 .../testing/selftests/futex/functional/run.sh |    6 +
 .../selftests/futex/include/futex2test.h      |  113 ++
 39 files changed, 2707 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/locking/futex2.rst
 create mode 100644 kernel/futex2.c
 create mode 100644 tools/testing/selftests/futex/functional/futex2_requeue.c
 create mode 100644 tools/testing/selftests/futex/functional/futex2_sizes.c
 create mode 100644 tools/testing/selftests/futex/functional/futex2_wait.c
 create mode 100644 tools/testing/selftests/futex/functional/futex2_waitv.c
 create mode 100644 tools/testing/selftests/futex/include/futex2test.h

-- 
2.31.1

