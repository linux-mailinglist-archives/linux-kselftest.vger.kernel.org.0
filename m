Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA75B32CC2B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Mar 2021 06:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhCDFqB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Mar 2021 00:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbhCDFpt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Mar 2021 00:45:49 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B34C06175F
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Mar 2021 21:45:03 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id w5so142743uap.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Mar 2021 21:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PY+WEM/VlXd9pM78il9qIrlAGjifsQA5uRqkeR5T3bo=;
        b=bPC5WtKiQl5R4z7pCgPbMiXyamid23edLNu+a4WWCpPE17zWJxaBiVUK4XLj8frUfM
         1zy7+SxIiN7uyoEiQHvF8FbOufiVcMoUyijSI0Bws8W9gKndb71yS5x6vBQ4E38z9pVy
         qpebQkdfUcbj5pqDzeLmj6hTJCia/I5zNxkzVi6+AZWeyZ6dsfX/P9TbjRaSnFBYGa24
         j2zz73u0hSb/QyGSdfXr1vEmF6RF9chpIBn7Snc9Ir1mYtmkofG9R5ZSo/Om637PM85A
         9Sr2PgBMgAHIOOc5fAf2PtejHZtSvbzZHBV3RMIvr3yPe4l0xRIbSlZy44driv2+L+YN
         hsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PY+WEM/VlXd9pM78il9qIrlAGjifsQA5uRqkeR5T3bo=;
        b=GlTpDZs+c6YpqzcCcRrurhaJckE6ZJkVaw8XGKMbCHkOykvz3UUXE1JkLW206PWPdp
         2ZiUGw46YTbaKcCgnCXklQCBQw2uZ6a+VpIGHKCBzTe/TauaufGXz2yBKQPyMLVRM9KA
         ECewMYrARNFz5kfk3l+IoEpetqg8Rcfw6S/Q/wy2hqAmaI/rLWlqZx1hwCnIJ8x9p765
         xikCzsqGV0Vv64c4A2T9bsww78/MsIQ76zAgb8uvXFeI/6UqWNJXQyi2PdZvSK8Zt6lE
         RFg6N8H2ZbEobjBMbgDmFwmODfmQAK9oouIYN1MWbK41WLxAKvMNToMq8WyhLVYGcIfp
         R+mg==
X-Gm-Message-State: AOAM533bbFMP0x9JTfmxyOuG85iGsXAv3B7HjxKqsMmtcSPIdJ38f1YC
        QOjzZgcMt1/kaxblS4Sb9VFgZtytFd+9Xb1FtCYkSw==
X-Google-Smtp-Source: ABdhPJxBCh1so86IeSEksOTHkREeACqrYxAJ5MWydhl9Q3d9ZxvK8ERNVW1GMO4sGC1hd7+1VUQFnEOKxBj3BGdbUJ8=
X-Received: by 2002:ab0:16d3:: with SMTP id g19mr1420813uaf.17.1614836701437;
 Wed, 03 Mar 2021 21:45:01 -0800 (PST)
MIME-Version: 1.0
References: <20210304004219.134051-1-andrealmeid@collabora.com>
In-Reply-To: <20210304004219.134051-1-andrealmeid@collabora.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Wed, 3 Mar 2021 21:44:49 -0800
Message-ID: <CAFTs51XAr2b3DmcSM4=qeU5cNuh0mTxUbhG66U6bc63YYzkzYA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] Add futex2 syscall
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 3, 2021 at 5:22 PM Andr=C3=A9 Almeida <andrealmeid@collabora.co=
m> wrote:
>
> Hi,
>
> This patch series introduces the futex2 syscalls.
>
> * What happened to the current futex()?
>
> For some years now, developers have been trying to add new features to
> futex, but maintainers have been reluctant to accept then, given the
> multiplexed interface full of legacy features and tricky to do big
> changes. Some problems that people tried to address with patchsets are:
> NUMA-awareness[0], smaller sized futexes[1], wait on multiple futexes[2].
> NUMA, for instance, just doesn't fit the current API in a reasonable
> way. Considering that, it's not possible to merge new features into the
> current futex.
>
>  ** The NUMA problem
>
>  At the current implementation, all futex kernel side infrastructure is
>  stored on a single node. Given that, all futex() calls issued by
>  processors that aren't located on that node will have a memory access
>  penalty when doing it.
>
>  ** The 32bit sized futex problem
>
>  Embedded systems or anything with memory constrains would benefit of
>  using smaller sizes for the futex userspace integer. Also, a mutex
>  implementation can be done using just three values, so 8 bits is enough
>  for various scenarios.
>
>  ** The wait on multiple problem
>
>  The use case lies in the Wine implementation of the Windows NT interface
>  WaitMultipleObjects. This Windows API function allows a thread to sleep
>  waiting on the first of a set of event sources (mutexes, timers, signal,
>  console input, etc) to signal.  Considering this is a primitive
>  synchronization operation for Windows applications, being able to quickl=
y
>  signal events on the producer side, and quickly go to sleep on the
>  consumer side is essential for good performance of those running over Wi=
ne.
>
> [0] https://lore.kernel.org/lkml/20160505204230.932454245@linutronix.de/
> [1] https://lore.kernel.org/lkml/20191221155659.3159-2-malteskarupke@web.=
de/
> [2] https://lore.kernel.org/lkml/20200213214525.183689-1-andrealmeid@coll=
abora.com/
>
> * The solution
>
> As proposed by Peter Zijlstra and Florian Weimer[3], a new interface
> is required to solve this, which must be designed with those features in
> mind. futex2() is that interface. As opposed to the current multiplexed
> interface, the new one should have one syscall per operation. This will
> allow the maintainability of the API if it gets extended, and will help
> users with type checking of arguments.
>
> In particular, the new interface is extended to support the ability to
> wait on any of a list of futexes at a time, which could be seen as a
> vectored extension of the FUTEX_WAIT semantics.
>
> [3] https://lore.kernel.org/lkml/20200303120050.GC2596@hirez.programming.=
kicks-ass.net/
>
> * The interface
>
> The new interface can be seen in details in the following patches, but
> this is a high level summary of what the interface can do:
>
>  - Supports wake/wait semantics, as in futex()
>  - Supports requeue operations, similarly as FUTEX_CMP_REQUEUE, but with
>    individual flags for each address
>  - Supports waiting for a vector of futexes, using a new syscall named
>    futex_waitv()
>  - Supports variable sized futexes (8bits, 16bits and 32bits)
>  - Supports NUMA-awareness operations, where the user can specify on
>    which memory node would like to operate
>
> * Implementation
>
> The internal implementation follows a similar design to the original fute=
x.
> Given that we want to replicate the same external behavior of current
> futex, this should be somewhat expected. For some functions, like the
> init and the code to get a shared key, I literally copied code and
> comments from kernel/futex.c. I decided to do so instead of exposing the
> original function as a public function since in that way we can freely
> modify our implementation if required, without any impact on old futex.
> Also, the comments precisely describes the details and corner cases of
> the implementation.
>
> Each patch contains a brief description of implementation, but patch 6
> "docs: locking: futex2: Add documentation" adds a more complete document
> about it.
>
> * The patchset
>
> This patchset can be also found at my git tree:
>
> https://gitlab.collabora.com/tonyk/linux/-/tree/futex2-dev
>
>   - Patch 1: Implements wait/wake, and the basics foundations of futex2
>
>   - Patches 2-4: Implement the remaining features (shared, waitv, requeue=
).
>
>   - Patch 5:  Adds the x86_x32 ABI handling. I kept it in a separated
>     patch since I'm not sure if x86_x32 is still a thing, or if it should
>     return -ENOSYS.
>
>   - Patch 6: Add a documentation file which details the interface and
>     the internal implementation.
>
>   - Patches 7-13: Selftests for all operations along with perf
>     support for futex2.
>
>   - Patch 14: While working on porting glibc for futex2, I found out
>     that there's a futex_wake() call at the user thread exit path, if
>     that thread was created with clone(..., CLONE_CHILD_SETTID, ...). In
>     order to make pthreads work with futex2, it was required to add
>     this patch. Note that this is more a proof-of-concept of what we
>     will need to do in future, rather than part of the interface and
>     shouldn't be merged as it is.
>
> * Testing:
>
> This patchset provides selftests for each operation and their flags.
> Along with that, the following work was done:
>
>  ** Stability
>
>  To stress the interface in "real world scenarios":
>
>  - glibc[4]: nptl's low level locking was modified to use futex2 API
>    (except for robust and PI things). All relevant nptl/ tests passed.
>
>  - Wine[5]: Proton/Wine was modified in order to use futex2() for the
>    emulation of Windows NT sync mechanisms based on futex, called "fsync"=
.
>    Triple-A games with huge CPU's loads and tons of parallel jobs worked
>    as expected when compared with the previous FUTEX_WAIT_MULTIPLE
>    implementation at futex(). Some games issue 42k futex2() calls
>    per second.
>
>  - Full GNU/Linux distro: I installed the modified glibc in my host
>    machine, so all pthread's programs would use futex2(). After tweaking
>    systemd[6] to allow futex2() calls at seccomp, everything worked as
>    expected (web browsers do some syscall sandboxing and need some
>    configuration as well).
>
>  - perf: The perf benchmarks tests can also be used to stress the
>    interface, and they can be found in this patchset.
>
>  ** Performance
>
>  - For comparing futex() and futex2() performance, I used the artificial
>    benchmarks implemented at perf (wake, wake-parallel, hash and
>    requeue). The setup was 200 runs for each test and using 8, 80, 800,
>    8000 for the number of threads, Note that for this test, I'm not using
>    patch 14 ("kernel: Enable waitpid() for futex2") , for reasons explain=
ed
>    at "The patchset" section.
>
>  - For the first three ones, I measured an average of 4% gain in
>    performance. This is not a big step, but it shows that the new
>    interface is at least comparable in performance with the current one.
>
>  - For requeue, I measured an average of 21% decrease in performance
>    compared to the original futex implementation. This is expected given
>    the new design with individual flags. The performance trade-offs are
>    explained at patch 4 ("futex2: Implement requeue operation").
>
> [4] https://gitlab.collabora.com/tonyk/glibc/-/tree/futex2
> [5] https://gitlab.collabora.com/tonyk/wine/-/tree/proton_5.13
> [6] https://gitlab.collabora.com/tonyk/systemd
>
> * FAQ
>
>  ** "Where's the code for NUMA and FUTEX_8/16?"
>
>  The current code is already complex enough to take some time for
>  review, so I believe it's better to split that work out to a future
>  iteration of this patchset. Besides that, this RFC is the core part of t=
he
>  infrastructure, and the following features will not pose big design
>  changes to it, the work will be more about wiring up the flags and
>  modifying some functions.
>
>  ** "And what's about FUTEX_64?"
>
>  By supporting 64 bit futexes, the kernel structure for futex would
>  need to have a 64 bit field for the value, and that could defeat one of
>  the purposes of having different sized futexes in the first place:
>  supporting smaller ones to decrease memory usage. This might be
>  something that could be disabled for 32bit archs (and even for
>  CONFIG_BASE_SMALL).
>
>  Which use case would benefit for FUTEX_64? Does it worth the trade-offs?

The ability to store a pointer value on 64bit platforms is an
important use case.
Imagine a simple producer/consumer scenario, with the producer updating
some shared memory data and waking the consumer. Storing the pointer
in the futex makes it so that only one shared memory location needs to be
accessed "atomically", etc. With two atomics synchronization becomes
more involved (=3D slower).

>
>  ** "Where's the PI/robust stuff?"
>
>  As said by Peter Zijlstra at [3], all those new features are related to
>  the "simple" futex interface, that doesn't use PI or robust. Do we want
>  to have this complexity at futex2() and if so, should it be part of
>  this patchset or can it be future work?
>
> Thanks,
>         Andr=C3=A9
>
> * Changelog
>
> Changes from v1:
> - Unified futex_set_timer_and_wait and __futex_wait code
> - Dropped _carefull from linked list function calls
> - Fixed typos on docs patch
> - uAPI flags are now added as features are introduced, instead of all fla=
gs
>   in patch 1
> - Removed struct futex_single_waiter in favor of an anon struct
> v1: https://lore.kernel.org/lkml/20210215152404.250281-1-andrealmeid@coll=
abora.com/
>
>
> Andr=C3=A9 Almeida (13):
>   futex2: Implement wait and wake functions
>   futex2: Add support for shared futexes
>   futex2: Implement vectorized wait
>   futex2: Implement requeue operation
>   futex2: Add compatibility entry point for x86_x32 ABI
>   docs: locking: futex2: Add documentation
>   selftests: futex2: Add wake/wait test
>   selftests: futex2: Add timeout test
>   selftests: futex2: Add wouldblock test
>   selftests: futex2: Add waitv test
>   selftests: futex2: Add requeue test
>   perf bench: Add futex2 benchmark tests
>   kernel: Enable waitpid() for futex2
>
>  Documentation/locking/futex2.rst              |  198 +++
>  Documentation/locking/index.rst               |    1 +
>  MAINTAINERS                                   |    2 +-
>  arch/arm/tools/syscall.tbl                    |    4 +
>  arch/arm64/include/asm/unistd.h               |    2 +-
>  arch/arm64/include/asm/unistd32.h             |    8 +
>  arch/x86/entry/syscalls/syscall_32.tbl        |    4 +
>  arch/x86/entry/syscalls/syscall_64.tbl        |    4 +
>  fs/inode.c                                    |    1 +
>  include/linux/compat.h                        |   23 +
>  include/linux/fs.h                            |    1 +
>  include/linux/syscalls.h                      |   18 +
>  include/uapi/asm-generic/unistd.h             |   14 +-
>  include/uapi/linux/futex.h                    |   31 +
>  init/Kconfig                                  |    7 +
>  kernel/Makefile                               |    1 +
>  kernel/fork.c                                 |    2 +
>  kernel/futex2.c                               | 1239 +++++++++++++++++
>  kernel/sys_ni.c                               |    6 +
>  tools/arch/x86/include/asm/unistd_64.h        |   12 +
>  tools/include/uapi/asm-generic/unistd.h       |   11 +-
>  .../arch/x86/entry/syscalls/syscall_64.tbl    |    4 +
>  tools/perf/bench/bench.h                      |    4 +
>  tools/perf/bench/futex-hash.c                 |   24 +-
>  tools/perf/bench/futex-requeue.c              |   57 +-
>  tools/perf/bench/futex-wake-parallel.c        |   41 +-
>  tools/perf/bench/futex-wake.c                 |   37 +-
>  tools/perf/bench/futex.h                      |   47 +
>  tools/perf/builtin-bench.c                    |   18 +-
>  .../selftests/futex/functional/.gitignore     |    3 +
>  .../selftests/futex/functional/Makefile       |    8 +-
>  .../futex/functional/futex2_requeue.c         |  164 +++
>  .../selftests/futex/functional/futex2_wait.c  |  209 +++
>  .../selftests/futex/functional/futex2_waitv.c |  157 +++
>  .../futex/functional/futex_wait_timeout.c     |   58 +-
>  .../futex/functional/futex_wait_wouldblock.c  |   33 +-
>  .../testing/selftests/futex/functional/run.sh |    6 +
>  .../selftests/futex/include/futex2test.h      |  121 ++
>  38 files changed, 2527 insertions(+), 53 deletions(-)
>  create mode 100644 Documentation/locking/futex2.rst
>  create mode 100644 kernel/futex2.c
>  create mode 100644 tools/testing/selftests/futex/functional/futex2_reque=
ue.c
>  create mode 100644 tools/testing/selftests/futex/functional/futex2_wait.=
c
>  create mode 100644 tools/testing/selftests/futex/functional/futex2_waitv=
.c
>  create mode 100644 tools/testing/selftests/futex/include/futex2test.h
>
> --
> 2.30.1
>
