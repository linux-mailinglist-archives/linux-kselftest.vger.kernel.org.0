Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F49A3C1C6C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 02:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhGIAQh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 20:16:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44598 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGIAQh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 20:16:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id C9C9E1F4212B
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
Subject: [PATCH v5 00/11] Add futex2 syscalls
Date:   Thu,  8 Jul 2021 21:13:17 -0300
Message-Id: <20210709001328.329716-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset is an implementation of futex2 interface on top of existing
futex.c code.

* What happened to the current futex()?

The futex() is implemented using a multiplexed interface that doesn't
scale well and gives headaches to people. We don't want to add more
features there.

* New features at futex2()

 ** NUMA-awareness

 At the current implementation, all futex kernel side infrastructure is
 stored on a single node. Given that, all futex() calls issued by
 processors that aren't located on that node will have a memory access
 penalty when doing it.

 ** Variable sized futexes

 Futexes are used to implement atomic operations in userspace.
 Supporting 8, 16, 32 and 64 bit sized futexes allows user libraries to
 implement all those sizes in a performant way. Thanks Boost devs for
 feedback: https://lists.boost.org/Archives/boost/2021/05/251508.php

 Embedded systems or anything with memory constrains could benefit of
 using smaller sizes for the futex userspace integer.

 ** Wait on multiple futexes

 Proton's (a set of compatibility tools to run Windows games) fork of Wine
 benefits of this feature to implement WaitForMultipleObjects from Win32 in 
 a performant way. Native game engines will benefit from this as well,
 given that this is  a common wait pattern for games.

* The interface

The new interface has one syscall per operation as opposed to the
current multiplexing one. The details can be found in the following
patches, but this is a high level summary of what the interface can do:

 - Supports wake/wait semantics, as in futex()
 - Supports requeue operations, similarly as FUTEX_CMP_REQUEUE, but with
   individual flags for each address
 - Supports waiting for a vector of futexes, using a new syscall named
   futex_waitv()

 - The following features will be implemented in next patchset versions:
    - Supports variable sized futexes (8bits, 16bits, 32bits and 64bits)
    - Supports NUMA-awareness operations, where the user can specify on
      which memory node would like to operate

* The patchset

Given that futex2 reuses futex code, the patches make futex.c functions
public and modify them as needed.

This patchset can be also found at my git tree:

https://gitlab.collabora.com/tonyk/linux/-/tree/futex2-dev

  - Patch 1: Implements 32bit wait/wake

  - Patches 2-3: Implement waitv and requeue.

  - Patch 4: Add a documentation file which details the interface and
    the internal implementation.

  - Patches 5-10: Selftests for all operations along with perf
    support for futex2.

  - Patch 11: Proof of concept of waking threads at waitpid(), not to be
  merged as it is.

* Testing

 ** Stability

 - glibc[1]: nptl's low level locking was modified to use futex2 API
   (except for PI). All nptl/ tests passed.

 - Proton's Wine: Proton/Wine was modified in order to use futex2() for the
   emulation of Windows NT sync mechanisms based on futex, called "fsync".
   Triple-A games with huge CPU's loads and tons of parallel jobs worked
   as expected when compared with the previous FUTEX_WAIT_MULTIPLE
   implementation at futex(). Some games issue 42k futex2() calls
   per second.

 - perf: The perf benchmarks tests can also be used to stress the
   interface, and they can be found in this patchset.

[1] https://gitlab.collabora.com/tonyk/glibc/-/tree/futex2-dev

 ** Performance

 - Using perf, no significant difference was measured when comparing
 futex() and futex2() for the following benchmarks: hash, wake and
 wake-parallel.

 - I measured a 15% overhead for the perf's requeue benchmark, comparing
 futex2() to futex(). Requeue patch provides more details about why this
 happens and how to overcome this.

* Changelog

Changes from v4:
- Use existing futex.c code when possible
- Cleaned up cover letter, check v4 for a more verbose version
v4: https://lore.kernel.org/lkml/20210603195924.361327-1-andrealmeid@collabora.com/

André Almeida (11):
  futex2: Implement wait and wake functions
  futex2: Implement vectorized wait
  futex2: Implement requeue operation
  docs: locking: futex2: Add documentation
  selftests: futex2: Add wake/wait test
  selftests: futex2: Add timeout test
  selftests: futex2: Add wouldblock test
  selftests: futex2: Add waitv test
  selftests: futex2: Add requeue test
  perf bench: Add futex2 benchmark tests
  kernel: Enable waitpid() for futex2

 Documentation/locking/futex2.rst              | 185 ++++++
 Documentation/locking/index.rst               |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   4 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   4 +
 include/linux/compat.h                        |  23 +
 include/linux/futex.h                         | 103 ++++
 include/linux/syscalls.h                      |   8 +
 include/uapi/asm-generic/unistd.h             |  11 +-
 include/uapi/linux/futex.h                    |  27 +
 init/Kconfig                                  |   7 +
 kernel/Makefile                               |   1 +
 kernel/fork.c                                 |   2 +
 kernel/futex.c                                | 111 +---
 kernel/futex2.c                               | 566 ++++++++++++++++++
 kernel/sys_ni.c                               |   9 +
 tools/arch/x86/include/asm/unistd_64.h        |  12 +
 tools/perf/bench/bench.h                      |   4 +
 tools/perf/bench/futex-hash.c                 |  24 +-
 tools/perf/bench/futex-requeue.c              |  57 +-
 tools/perf/bench/futex-wake-parallel.c        |  41 +-
 tools/perf/bench/futex-wake.c                 |  37 +-
 tools/perf/bench/futex.h                      |  47 ++
 tools/perf/builtin-bench.c                    |  18 +-
 .../selftests/futex/functional/.gitignore     |   3 +
 .../selftests/futex/functional/Makefile       |   6 +-
 .../futex/functional/futex2_requeue.c         | 164 +++++
 .../selftests/futex/functional/futex2_wait.c  | 195 ++++++
 .../selftests/futex/functional/futex2_waitv.c | 154 +++++
 .../futex/functional/futex_wait_timeout.c     |  24 +-
 .../futex/functional/futex_wait_wouldblock.c  |  33 +-
 .../testing/selftests/futex/functional/run.sh |   6 +
 .../selftests/futex/include/futex2test.h      | 112 ++++
 32 files changed, 1865 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/locking/futex2.rst
 create mode 100644 kernel/futex2.c
 create mode 100644 tools/testing/selftests/futex/functional/futex2_requeue.c
 create mode 100644 tools/testing/selftests/futex/functional/futex2_wait.c
 create mode 100644 tools/testing/selftests/futex/functional/futex2_waitv.c
 create mode 100644 tools/testing/selftests/futex/include/futex2test.h

--
2.32.0

