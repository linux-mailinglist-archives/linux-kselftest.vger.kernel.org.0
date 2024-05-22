Return-Path: <linux-kselftest+bounces-10579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DBD8CC06A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 13:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D75B28413C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE01B8288C;
	Wed, 22 May 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fExDxptm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5E982872;
	Wed, 22 May 2024 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377956; cv=none; b=bAf9L0//9GHs6d8H5pkgRgqYz0K+C9g0Lp3+DhDB4CjYNprCx+DtTJ8QpHfDZXv2Jjz5/HCWr55PazaHvFvCMsafvexR1HJzgUnCc4OmDHU+9RABK1rD0VpqSg2jkPpAPDZ8WUo/U0R6dlbMGnY4bMUNIizedbtVs05akTqc5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377956; c=relaxed/simple;
	bh=qzeEhLTzs3eTNWP52PvPXTOCTVAC4cnYjnTvXRJDqSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ksndL9fNv0o8ivjaJ38hZ0Gvsjo/OAWQBqpX34QB+hpwc089WamECMdnUb1ytJ5KH8ILLf0dOG11uW0MZwQKNcvj4kJnCbld8mAJPqRfisJ9ckPtm5C3Vjckvke+0jajtZ2OFspXPEc670jkRQoZxGgh1jut9/TZCN5LcYPlrOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=fExDxptm; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716377949;
	bh=T7hwOciwEG7iW2YNr+Xb5zEpDJdYct6VLjO7wu3h6+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fExDxptmOA1ZSBB8xILHuo+g5d9pnDr+gR2+aReyz1hwAEBlwW/3iwjUlD1hnTEmG
	 eA1vZxGg0bxdqYvvOme893JMvPZDyjRFLSpiuLAzyZ0iZWGnIpVKyKWWtIVKma2G7/
	 Rg7co25wUK9x9Ebrx0r4DW6dLKAI05Whuh3dd1ZXpPI4GpQHa4mSzt77UKIHiY2eWT
	 UBhjxtb8tn0I/wMw2U11NeLoZUX6EpTI1FkeqVv9+iwKVttRBgMvWg95hcwSqTTluh
	 5+tm4FjS5taa9sbuplMiXUFrc95YTPe5HoXH4OmQ8ha6sGO6z0ioAemRHxTrq+mQWz
	 4SD7rY3kvZpPA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vkq893BX3z4wyY;
	Wed, 22 May 2024 21:39:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org, =?utf-8?Q?Micka?=
 =?utf-8?Q?=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
 Christian Brauner
 <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Edward Liaw <edliaw@google.com>,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 44/68] selftests/powerpc: Drop define _GNU_SOURCE
In-Reply-To: <20240522005913.3540131-45-edliaw@google.com>
References: <20240522005913.3540131-1-edliaw@google.com>
 <20240522005913.3540131-45-edliaw@google.com>
Date: Wed, 22 May 2024 21:39:01 +1000
Message-ID: <87r0du2i0a.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Edward Liaw <edliaw@google.com> writes:
> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> redefinition warnings.

Most of these tests build with -Werror, so the duplicate define is
actually a hard error. Can you put this patch earlier in the series at
least?

cheers

> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/powerpc/benchmarks/context_switch.c    | 2 --
>  tools/testing/selftests/powerpc/benchmarks/exec_target.c       | 2 --
>  tools/testing/selftests/powerpc/benchmarks/fork.c              | 2 --
>  tools/testing/selftests/powerpc/benchmarks/futex_bench.c       | 3 ---
>  tools/testing/selftests/powerpc/dexcr/hashchk_test.c           | 3 ---
>  tools/testing/selftests/powerpc/dscr/dscr_default_test.c       | 3 ---
>  tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c      | 3 ---
>  tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c  | 1 -
>  tools/testing/selftests/powerpc/mm/exec_prot.c                 | 2 --
>  tools/testing/selftests/powerpc/mm/pkey_exec_prot.c            | 2 --
>  tools/testing/selftests/powerpc/mm/pkey_siginfo.c              | 2 --
>  tools/testing/selftests/powerpc/mm/tlbie_test.c                | 2 --
>  tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c            | 1 -
>  tools/testing/selftests/powerpc/pmu/count_instructions.c       | 3 ---
>  tools/testing/selftests/powerpc/pmu/count_stcx_fail.c          | 3 ---
>  tools/testing/selftests/powerpc/pmu/ebb/ebb.c                  | 3 ---
>  .../testing/selftests/powerpc/pmu/ebb/instruction_count_test.c | 3 ---
>  tools/testing/selftests/powerpc/pmu/event.c                    | 2 --
>  tools/testing/selftests/powerpc/pmu/lib.c                      | 3 ---
>  tools/testing/selftests/powerpc/pmu/per_event_excludes.c       | 3 ---
>  tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c          | 3 ---
>  tools/testing/selftests/powerpc/ptrace/ptrace-syscall.c        | 2 --
>  tools/testing/selftests/powerpc/signal/sig_sc_double_restart.c | 1 -
>  tools/testing/selftests/powerpc/signal/sigreturn_kernel.c      | 3 ---
>  tools/testing/selftests/powerpc/signal/sigreturn_vdso.c        | 3 ---
>  tools/testing/selftests/powerpc/syscalls/ipc_unmuxed.c         | 2 --
>  tools/testing/selftests/powerpc/tm/tm-exec.c                   | 2 --
>  tools/testing/selftests/powerpc/tm/tm-poison.c                 | 2 --
>  .../testing/selftests/powerpc/tm/tm-signal-context-force-tm.c  | 2 --
>  tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c    | 2 --
>  tools/testing/selftests/powerpc/tm/tm-tmspr.c                  | 2 --
>  tools/testing/selftests/powerpc/tm/tm-trap.c                   | 2 --
>  tools/testing/selftests/powerpc/tm/tm-unavailable.c            | 2 --
>  tools/testing/selftests/powerpc/utils.c                        | 3 ---
>  34 files changed, 79 deletions(-)
>
> diff --git a/tools/testing/selftests/powerpc/benchmarks/context_switch.c b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
> index 96554e2794d1..0b245572bd45 100644
> --- a/tools/testing/selftests/powerpc/benchmarks/context_switch.c
> +++ b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
> @@ -4,8 +4,6 @@
>   *
>   * Copyright (C) 2015 Anton Blanchard <anton@au.ibm.com>, IBM
>   */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <sched.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/powerpc/benchmarks/exec_target.c b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
> index c14b0fc1edde..8646540037d8 100644
> --- a/tools/testing/selftests/powerpc/benchmarks/exec_target.c
> +++ b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
> @@ -5,8 +5,6 @@
>   *
>   * Copyright 2018, Anton Blanchard, IBM Corp.
>   */
> -
> -#define _GNU_SOURCE
>  #include <unistd.h>
>  #include <sys/syscall.h>
>  
> diff --git a/tools/testing/selftests/powerpc/benchmarks/fork.c b/tools/testing/selftests/powerpc/benchmarks/fork.c
> index d312e638cb37..327231646a2a 100644
> --- a/tools/testing/selftests/powerpc/benchmarks/fork.c
> +++ b/tools/testing/selftests/powerpc/benchmarks/fork.c
> @@ -5,8 +5,6 @@
>   *
>   * Copyright 2018, Anton Blanchard, IBM Corp.
>   */
> -
> -#define _GNU_SOURCE
>  #include <assert.h>
>  #include <errno.h>
>  #include <getopt.h>
> diff --git a/tools/testing/selftests/powerpc/benchmarks/futex_bench.c b/tools/testing/selftests/powerpc/benchmarks/futex_bench.c
> index 017057090490..0483a13c88f9 100644
> --- a/tools/testing/selftests/powerpc/benchmarks/futex_bench.c
> +++ b/tools/testing/selftests/powerpc/benchmarks/futex_bench.c
> @@ -2,9 +2,6 @@
>  /*
>   * Copyright 2016, Anton Blanchard, Michael Ellerman, IBM Corp.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdio.h>
>  #include <sys/syscall.h>
>  #include <time.h>
> diff --git a/tools/testing/selftests/powerpc/dexcr/hashchk_test.c b/tools/testing/selftests/powerpc/dexcr/hashchk_test.c
> index 645224bdc142..2499ab7fe563 100644
> --- a/tools/testing/selftests/powerpc/dexcr/hashchk_test.c
> +++ b/tools/testing/selftests/powerpc/dexcr/hashchk_test.c
> @@ -1,7 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0+
> -
> -#define _GNU_SOURCE
> -
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <limits.h>
> diff --git a/tools/testing/selftests/powerpc/dscr/dscr_default_test.c b/tools/testing/selftests/powerpc/dscr/dscr_default_test.c
> index 60ab02525b79..fe6aff1e5dad 100644
> --- a/tools/testing/selftests/powerpc/dscr/dscr_default_test.c
> +++ b/tools/testing/selftests/powerpc/dscr/dscr_default_test.c
> @@ -9,9 +9,6 @@
>   * Copyright 2012, Anton Blanchard, IBM Corporation.
>   * Copyright 2015, Anshuman Khandual, IBM Corporation.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include "dscr.h"
>  
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c b/tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c
> index e2268e9183a8..93b6efdc2eef 100644
> --- a/tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c
> +++ b/tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c
> @@ -15,9 +15,6 @@
>   * Copyright 2012, Anton Blanchard, IBM Corporation.
>   * Copyright 2015, Anshuman Khandual, IBM Corporation.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include "dscr.h"
>  #include "utils.h"
>  
> diff --git a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c
> index 191ed126f118..ace7d23492c1 100644
> --- a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c
> +++ b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c
> @@ -9,7 +9,6 @@
>   *
>   * Copyright 2015, Anshuman Khandual, IBM Corporation.
>   */
> -#define _GNU_SOURCE
>  #include "dscr.h"
>  
>  static int test_thread_dscr(unsigned long val)
> diff --git a/tools/testing/selftests/powerpc/mm/exec_prot.c b/tools/testing/selftests/powerpc/mm/exec_prot.c
> index db75b2225de1..65712597cc68 100644
> --- a/tools/testing/selftests/powerpc/mm/exec_prot.c
> +++ b/tools/testing/selftests/powerpc/mm/exec_prot.c
> @@ -6,8 +6,6 @@
>   *
>   * Test if applying execute protection on pages works as expected.
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
> index 0af4f02669a1..5cf72cd9694d 100644
> --- a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
> +++ b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
> @@ -6,8 +6,6 @@
>   * Test if applying execute protection on pages using memory
>   * protection keys works as expected.
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/powerpc/mm/pkey_siginfo.c b/tools/testing/selftests/powerpc/mm/pkey_siginfo.c
> index 2db76e56d4cb..fcaa591abf88 100644
> --- a/tools/testing/selftests/powerpc/mm/pkey_siginfo.c
> +++ b/tools/testing/selftests/powerpc/mm/pkey_siginfo.c
> @@ -8,8 +8,6 @@
>   * attempted to be protected by two different keys from two competing
>   * threads at the same time.
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/powerpc/mm/tlbie_test.c b/tools/testing/selftests/powerpc/mm/tlbie_test.c
> index 48344a74b212..512cd405de92 100644
> --- a/tools/testing/selftests/powerpc/mm/tlbie_test.c
> +++ b/tools/testing/selftests/powerpc/mm/tlbie_test.c
> @@ -14,8 +14,6 @@
>   * and copy it back to the original area. This helps us to detect if any
>   * store continued to happen after we marked the memory PROT_READ.
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <sys/mman.h>
>  #include <sys/types.h>
> diff --git a/tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c b/tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c
> index d6f99eb9be65..0b9b20668fa4 100644
> --- a/tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c
> +++ b/tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/powerpc/pmu/count_instructions.c b/tools/testing/selftests/powerpc/pmu/count_instructions.c
> index a3984ef1e96a..57d63ff75397 100644
> --- a/tools/testing/selftests/powerpc/pmu/count_instructions.c
> +++ b/tools/testing/selftests/powerpc/pmu/count_instructions.c
> @@ -2,9 +2,6 @@
>  /*
>   * Copyright 2013, Michael Ellerman, IBM Corp.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdio.h>
>  #include <stdbool.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c b/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
> index 2070a1e2b3a5..5d3bbd38528d 100644
> --- a/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
> +++ b/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
> @@ -2,9 +2,6 @@
>   * Copyright 2013, Michael Ellerman, IBM Corp.
>   * Licensed under GPLv2.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdio.h>
>  #include <stdbool.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
> index 21537d6eb6b7..e99a455e8c2e 100644
> --- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
> +++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
> @@ -2,9 +2,6 @@
>  /*
>   * Copyright 2014, Michael Ellerman, IBM Corp.
>   */
> -
> -#define _GNU_SOURCE	/* For CPU_ZERO etc. */
> -
>  #include <sched.h>
>  #include <sys/wait.h>
>  #include <setjmp.h>
> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c b/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
> index eed338b18e11..ab3f888922d6 100644
> --- a/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
> +++ b/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
> @@ -2,9 +2,6 @@
>  /*
>   * Copyright 2014, Michael Ellerman, IBM Corp.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdio.h>
>  #include <stdbool.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/powerpc/pmu/event.c b/tools/testing/selftests/powerpc/pmu/event.c
> index 0c1c1bdba081..5468bd2c3c5b 100644
> --- a/tools/testing/selftests/powerpc/pmu/event.c
> +++ b/tools/testing/selftests/powerpc/pmu/event.c
> @@ -2,8 +2,6 @@
>  /*
>   * Copyright 2013, Michael Ellerman, IBM Corp.
>   */
> -
> -#define _GNU_SOURCE
>  #include <unistd.h>
>  #include <sys/syscall.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/powerpc/pmu/lib.c b/tools/testing/selftests/powerpc/pmu/lib.c
> index 321357987408..fa208701dbdc 100644
> --- a/tools/testing/selftests/powerpc/pmu/lib.c
> +++ b/tools/testing/selftests/powerpc/pmu/lib.c
> @@ -2,9 +2,6 @@
>  /*
>   * Copyright 2014, Michael Ellerman, IBM Corp.
>   */
> -
> -#define _GNU_SOURCE	/* For CPU_ZERO etc. */
> -
>  #include <errno.h>
>  #include <sched.h>
>  #include <setjmp.h>
> diff --git a/tools/testing/selftests/powerpc/pmu/per_event_excludes.c b/tools/testing/selftests/powerpc/pmu/per_event_excludes.c
> index ad32a09a6540..066e0c4799fd 100644
> --- a/tools/testing/selftests/powerpc/pmu/per_event_excludes.c
> +++ b/tools/testing/selftests/powerpc/pmu/per_event_excludes.c
> @@ -2,9 +2,6 @@
>  /*
>   * Copyright 2014, Michael Ellerman, IBM Corp.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <elf.h>
>  #include <limits.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
> index e374c6b7ace6..1f7e3c63742d 100644
> --- a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
> +++ b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
> @@ -16,9 +16,6 @@
>   *
>   * Copyright (C) 2018 Michael Neuling, IBM Corporation.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <unistd.h>
>  #include <assert.h>
>  #include <sched.h>
> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-syscall.c b/tools/testing/selftests/powerpc/ptrace/ptrace-syscall.c
> index 3353210dcdbd..6e5294c1b60b 100644
> --- a/tools/testing/selftests/powerpc/ptrace/ptrace-syscall.c
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace-syscall.c
> @@ -8,8 +8,6 @@
>   * test, and it was adapted to run on Powerpc by
>   * Breno Leitao <leitao@debian.org>
>   */
> -#define _GNU_SOURCE
> -
>  #include <sys/ptrace.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
> diff --git a/tools/testing/selftests/powerpc/signal/sig_sc_double_restart.c b/tools/testing/selftests/powerpc/signal/sig_sc_double_restart.c
> index e3972264615b..8bad5e65bbb7 100644
> --- a/tools/testing/selftests/powerpc/signal/sig_sc_double_restart.c
> +++ b/tools/testing/selftests/powerpc/signal/sig_sc_double_restart.c
> @@ -18,7 +18,6 @@
>   *  that sucker at the same time.  Same for multiple signals of any kind
>   *  interrupting that sucker on 64bit...
>   */
> -#define _GNU_SOURCE
>  #include <sys/types.h>
>  #include <sys/wait.h>
>  #include <sys/syscall.h>
> diff --git a/tools/testing/selftests/powerpc/signal/sigreturn_kernel.c b/tools/testing/selftests/powerpc/signal/sigreturn_kernel.c
> index 0a1b6e591eee..772c3373560f 100644
> --- a/tools/testing/selftests/powerpc/signal/sigreturn_kernel.c
> +++ b/tools/testing/selftests/powerpc/signal/sigreturn_kernel.c
> @@ -2,9 +2,6 @@
>  /*
>   * Test that we can't sigreturn to kernel addresses, or to kernel mode.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdio.h>
>  #include <signal.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/powerpc/signal/sigreturn_vdso.c b/tools/testing/selftests/powerpc/signal/sigreturn_vdso.c
> index e282fff0fe25..d5aecd2c4b95 100644
> --- a/tools/testing/selftests/powerpc/signal/sigreturn_vdso.c
> +++ b/tools/testing/selftests/powerpc/signal/sigreturn_vdso.c
> @@ -5,9 +5,6 @@
>   *
>   * See handle_rt_signal64() and setup_trampoline() in signal_64.c
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <errno.h>
>  #include <stdio.h>
>  #include <signal.h>
> diff --git a/tools/testing/selftests/powerpc/syscalls/ipc_unmuxed.c b/tools/testing/selftests/powerpc/syscalls/ipc_unmuxed.c
> index 4c582524aeb3..a49c699d86d4 100644
> --- a/tools/testing/selftests/powerpc/syscalls/ipc_unmuxed.c
> +++ b/tools/testing/selftests/powerpc/syscalls/ipc_unmuxed.c
> @@ -5,8 +5,6 @@
>   * This test simply tests that certain syscalls are implemented. It doesn't
>   * actually exercise their logic in any way.
>   */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <stdio.h>
>  #include <unistd.h>
> diff --git a/tools/testing/selftests/powerpc/tm/tm-exec.c b/tools/testing/selftests/powerpc/tm/tm-exec.c
> index c59919d6710d..8cfc859dcf37 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-exec.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-exec.c
> @@ -8,8 +8,6 @@
>   * It makes little sense for after an exec() call for the previously
>   * suspended transaction to still exist.
>   */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <libgen.h>
> diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c b/tools/testing/selftests/powerpc/tm/tm-poison.c
> index a7bbf034b5bb..1b3a596a6a51 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-poison.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
> @@ -11,8 +11,6 @@
>   * present child's poison will leak into parent's f31 or vr31 registers,
>   * otherwise, poison will never leak into parent's f31 and vr31 registers.
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c
> index 421cb082f6be..f28ba2828df6 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c
> @@ -15,8 +15,6 @@
>   * This test never fails (as returning EXIT_FAILURE). It either succeeds,
>   * or crash the kernel (on a buggy kernel).
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <signal.h>
> diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c b/tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c
> index 06b801906f27..73f8e7dd5a1a 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-nt.c
> @@ -8,8 +8,6 @@
>   * It returns from the signal handler with the CPU at suspended state, but
>   * without setting usercontext MSR Transaction State (TS) fields.
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <signal.h>
> diff --git a/tools/testing/selftests/powerpc/tm/tm-tmspr.c b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
> index dd5ddffa28b7..01118f7db1b2 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-tmspr.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
> @@ -22,8 +22,6 @@
>   *    	(b) abort transaction
>   *	(c) check TEXASR to see if FS has been corrupted
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> diff --git a/tools/testing/selftests/powerpc/tm/tm-trap.c b/tools/testing/selftests/powerpc/tm/tm-trap.c
> index 97cb74768e30..164b345b5bd3 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-trap.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-trap.c
> @@ -26,8 +26,6 @@
>   * the endianness is verified on subsequent traps to determine if the
>   * endianness "flipped back" to the native endianness (BE).
>   */
> -
> -#define _GNU_SOURCE
>  #include <error.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/powerpc/tm/tm-unavailable.c b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
> index 6bf1b65b020d..712267831112 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-unavailable.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
> @@ -13,8 +13,6 @@
>   * corruption, but only for registers vs0 and vs32, which are respectively
>   * representatives of FP and VEC/Altivec reg sets.
>   */
> -
> -#define _GNU_SOURCE
>  #include <error.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/powerpc/utils.c b/tools/testing/selftests/powerpc/utils.c
> index e5f2d8735c64..664722a01636 100644
> --- a/tools/testing/selftests/powerpc/utils.c
> +++ b/tools/testing/selftests/powerpc/utils.c
> @@ -2,9 +2,6 @@
>  /*
>   * Copyright 2013-2015, Michael Ellerman, IBM Corp.
>   */
> -
> -#define _GNU_SOURCE	/* For CPU_ZERO etc. */
> -
>  #include <elf.h>
>  #include <errno.h>
>  #include <fcntl.h>
> -- 
> 2.45.1.288.g0e0cd299f1-goog

