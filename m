Return-Path: <linux-kselftest+bounces-8636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABCC8AD3DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 20:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866261F21A03
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CA6154444;
	Mon, 22 Apr 2024 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XbPXvMan"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A70154425;
	Mon, 22 Apr 2024 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810328; cv=none; b=RaaU79cFzuH+7CBE93GtlXZjsIg1FJVNq2J1q7qastulr95MHz1I0rfJSJ1G2sFuAHDPMROwoZcseC9YN4m+nG3d8gd6SBpFkJ7Ql9DIkJjFdB2d84/B682wrkJkSyT2Q20mdY/hZH6bthvJLG3KqCpEPE9jcSx65I8ErDgJbgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810328; c=relaxed/simple;
	bh=o1hXBNFQhk3Raoc8Qpn5NozSUJ8tOq1fMWu4006yBQc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Svd7RLiCVG9NhB4BPkU2dEWxXkqK2wd1ro5sPZNUQLjIeCyfXXU5+T4htgLvQL6v69Lfo6+kalDDcqfZvoDqbSSRbiGtN0BBl+qd24ipFDbCHTcFWDZKVYp/zLFgVB2xnJa5p9HKk3s48QTP6J7fDLFT+4SL1ajUByxuJuYm/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XbPXvMan; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713810323;
	bh=o1hXBNFQhk3Raoc8Qpn5NozSUJ8tOq1fMWu4006yBQc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XbPXvMandlP3nJr7evea4jU4oVUdGjnw5GJVCzsi2CY9V2/v9Bhq5Nm8gC99hezax
	 3EXnTmZL8OZQvGjZksCDbk2o7vEKnEZ4VhphiXX2Ch2hImDatZ4/mhjech51D9El+C
	 UBhni87Zybb3sJh0Ik7w/AggOC37Tk9jTztwABwadyns6N5P8gv2SMXuQ6IdtnwgrF
	 W20QFSbckVT4TnZzpsoM/Us8sbht3K0G3a3H8d3vJ7knsEueniZEOiDHLnD66MsJEr
	 qsC64KE+PLLgkmYJGl01194wKzy3yCKsFLgFV9SBGdSOJMmMtJGQNB1aDJxCV9lGKJ
	 VwCLzatXrlGKQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E43B03782134;
	Mon, 22 Apr 2024 18:25:18 +0000 (UTC)
Message-ID: <7c1a3acb-9e96-48c9-8473-eeaa6af6b0d4@collabora.com>
Date: Mon, 22 Apr 2024 23:25:48 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 kernel@collabora.com, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests: kvm: fix undeclared function error
To: Sean Christopherson <seanjc@google.com>
References: <20240422170842.2073979-1-usama.anjum@collabora.com>
 <ZiarFpdLZFusHCO1@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZiarFpdLZFusHCO1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Subject: [PATCH] KVM: selftest: Define _GNU_SOURCE for all selftests code
> 
> Define _GNU_SOURCE is the base CFLAGS instead of relying on selftests to
> manually #define _GNU_SOURCE, which is repetitive and error prone.  E.g.
> kselftest_harness.h requres _GNU_SOURCE for asprintf(), but if a selftest
> includes kvm_test_harness.h after stdio.h, the include guards result in
> the effective version of stdio.h consumed by kvm_test_harness.h not
> defining asprintf():
> 
>   In file included from x86_64/fix_hypercall_test.c:12:
>   In file included from include/kvm_test_harness.h:11:
>  ../kselftest_harness.h:1169:2: error: call to undeclared function
>   'asprintf'; ISO C99 and later do not support implicit function declarations
>   [-Wimplicit-function-declaration]
>    1169 |         asprintf(&test_name, "%s%s%s.%s", f->name,
>         |         ^
> 
> When including the rseq selftest's "library" code, #undef _GNU_SOURCE so
> that rseq.c controls whether or not it wants to build with _GNU_SOURCE.
> 
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
LGM

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/kvm/Makefile                 |  4 ++--
>  tools/testing/selftests/kvm/aarch64/arch_timer.c     |  2 --
>  .../testing/selftests/kvm/aarch64/page_fault_test.c  |  1 -
>  tools/testing/selftests/kvm/aarch64/psci_test.c      |  3 ---
>  tools/testing/selftests/kvm/aarch64/vgic_init.c      |  1 -
>  tools/testing/selftests/kvm/arch_timer.c             |  3 ---
>  tools/testing/selftests/kvm/demand_paging_test.c     |  3 ---
>  tools/testing/selftests/kvm/dirty_log_test.c         |  3 ---
>  tools/testing/selftests/kvm/guest_memfd_test.c       |  2 --
>  tools/testing/selftests/kvm/hardware_disable_test.c  |  3 ---
>  tools/testing/selftests/kvm/include/kvm_util_base.h  | 12 ++++++------
>  .../testing/selftests/kvm/include/userfaultfd_util.h |  3 ---
>  tools/testing/selftests/kvm/kvm_binary_stats_test.c  |  2 --
>  tools/testing/selftests/kvm/kvm_create_max_vcpus.c   |  2 --
>  tools/testing/selftests/kvm/kvm_page_table_test.c    |  3 ---
>  tools/testing/selftests/kvm/lib/assert.c             |  3 ---
>  tools/testing/selftests/kvm/lib/kvm_util.c           |  2 --
>  tools/testing/selftests/kvm/lib/memstress.c          |  2 --
>  tools/testing/selftests/kvm/lib/test_util.c          |  2 --
>  tools/testing/selftests/kvm/lib/userfaultfd_util.c   |  3 ---
>  tools/testing/selftests/kvm/lib/x86_64/sev.c         |  1 -
>  tools/testing/selftests/kvm/max_guest_memory_test.c  |  2 --
>  .../selftests/kvm/memslot_modification_stress_test.c |  3 ---
>  tools/testing/selftests/kvm/riscv/arch_timer.c       |  3 ---
>  tools/testing/selftests/kvm/rseq_test.c              | 12 +++++++++---
>  tools/testing/selftests/kvm/s390x/cmma_test.c        |  2 --
>  tools/testing/selftests/kvm/s390x/sync_regs_test.c   |  2 --
>  tools/testing/selftests/kvm/set_memory_region_test.c |  1 -
>  tools/testing/selftests/kvm/steal_time.c             |  1 -
>  tools/testing/selftests/kvm/x86_64/amx_test.c        |  2 --
>  .../kvm/x86_64/exit_on_emulation_failure_test.c      |  3 ---
>  tools/testing/selftests/kvm/x86_64/hwcr_msr_test.c   |  2 --
>  tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c    |  2 --
>  tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c    |  1 -
>  tools/testing/selftests/kvm/x86_64/hyperv_ipi.c      |  2 --
>  tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c |  1 -
>  .../testing/selftests/kvm/x86_64/hyperv_tlb_flush.c  |  2 --
>  .../selftests/kvm/x86_64/nested_exceptions_test.c    |  2 --
>  .../selftests/kvm/x86_64/nx_huge_pages_test.c        |  3 ---
>  .../selftests/kvm/x86_64/platform_info_test.c        |  2 --
>  .../testing/selftests/kvm/x86_64/pmu_counters_test.c |  2 --
>  .../selftests/kvm/x86_64/pmu_event_filter_test.c     |  3 ---
>  .../kvm/x86_64/private_mem_conversions_test.c        |  1 -
>  tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c |  1 -
>  tools/testing/selftests/kvm/x86_64/set_sregs_test.c  |  1 -
>  .../kvm/x86_64/smaller_maxphyaddr_emulation_test.c   |  3 ---
>  tools/testing/selftests/kvm/x86_64/smm_test.c        |  1 -
>  tools/testing/selftests/kvm/x86_64/state_test.c      |  1 -
>  tools/testing/selftests/kvm/x86_64/sync_regs_test.c  |  2 --
>  .../selftests/kvm/x86_64/ucna_injection_test.c       |  2 --
>  .../selftests/kvm/x86_64/userspace_msr_exit_test.c   |  2 --
>  .../selftests/kvm/x86_64/vmx_dirty_log_test.c        |  3 ---
>  .../testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c |  1 -
>  .../selftests/kvm/x86_64/vmx_preemption_timer_test.c |  1 -
>  tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c  |  2 --
>  .../testing/selftests/kvm/x86_64/xapic_state_test.c  |  1 -
>  tools/testing/selftests/kvm/x86_64/xss_msr_test.c    |  2 --
>  57 files changed, 17 insertions(+), 120 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 741c7dc16afc..4f30296e0bbb 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -225,8 +225,8 @@ LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
>  endif
>  CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>  	-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
> -	-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset \
> -	-fno-builtin-strnlen \
> +	-D_GNU_SOURCE -fno-builtin-memcmp -fno-builtin-memcpy \
> +	-fno-builtin-memset -fno-builtin-strnlen \
>  	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
>  	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
>  	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index 4eaba83cdcf3..5369959e9fc2 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -5,8 +5,6 @@
>   *
>   * Copyright (c) 2021, Google LLC.
>   */
> -#define _GNU_SOURCE
> -
>  #include "arch_timer.h"
>  #include "delay.h"
>  #include "gic.h"
> diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> index a2a158e2c0b8..d29b08198b42 100644
> --- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> +++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> @@ -7,7 +7,6 @@
>   * hugetlbfs with a hole). It checks that the expected handling method is
>   * called (e.g., uffd faults with the right address and write/read flag).
>   */
> -#define _GNU_SOURCE
>  #include <linux/bitmap.h>
>  #include <fcntl.h>
>  #include <test_util.h>
> diff --git a/tools/testing/selftests/kvm/aarch64/psci_test.c b/tools/testing/selftests/kvm/aarch64/psci_test.c
> index 9b004905d1d3..1c8c6f0c1ca3 100644
> --- a/tools/testing/selftests/kvm/aarch64/psci_test.c
> +++ b/tools/testing/selftests/kvm/aarch64/psci_test.c
> @@ -10,9 +10,6 @@
>   *  - A test for KVM's handling of PSCI SYSTEM_SUSPEND and the associated
>   *    KVM_SYSTEM_EVENT_SUSPEND UAPI.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <linux/psci.h>
>  
>  #include "kvm_util.h"
> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
> index eef816b80993..e93022870cac 100644
> --- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
> +++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
> @@ -4,7 +4,6 @@
>   *
>   * Copyright (C) 2020, Red Hat, Inc.
>   */
> -#define _GNU_SOURCE
>  #include <linux/kernel.h>
>  #include <sys/syscall.h>
>  #include <asm/kvm.h>
> diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/selftests/kvm/arch_timer.c
> index ae1f1a6d8312..fcebd8d81ce4 100644
> --- a/tools/testing/selftests/kvm/arch_timer.c
> +++ b/tools/testing/selftests/kvm/arch_timer.c
> @@ -19,9 +19,6 @@
>   *
>   * Copyright (c) 2021, Google LLC.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdlib.h>
>  #include <pthread.h>
>  #include <linux/sizes.h>
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 056ff1c87345..bc5c4ada5f0d 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -6,9 +6,6 @@
>   * Copyright (C) 2018, Red Hat, Inc.
>   * Copyright (C) 2019, Google, Inc.
>   */
> -
> -#define _GNU_SOURCE /* for pipe2 */
> -
>  #include <inttypes.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index eaad5b20854c..bf1ebc29f22a 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -4,9 +4,6 @@
>   *
>   * Copyright (C) 2018, Red Hat, Inc.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_name */
> -
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index 92eae206baa6..309fe84b84ad 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -4,8 +4,6 @@
>   *
>   * Author: Chao Peng <chao.p.peng@linux.intel.com>
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
> index decc521fc760..bce73bcb973c 100644
> --- a/tools/testing/selftests/kvm/hardware_disable_test.c
> +++ b/tools/testing/selftests/kvm/hardware_disable_test.c
> @@ -4,9 +4,6 @@
>   * kvm_arch_hardware_disable is called and it attempts to unregister the user
>   * return notifiers.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <fcntl.h>
>  #include <pthread.h>
>  #include <semaphore.h>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 3e0db283a46a..0c004036309d 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -27,12 +27,12 @@
>  
>  /*
>   * Provide a version of static_assert() that is guaranteed to have an optional
> - * message param.  If _ISOC11_SOURCE is defined, glibc (/usr/include/assert.h)
> - * #undefs and #defines static_assert() as a direct alias to _Static_assert(),
> - * i.e. effectively makes the message mandatory.  Many KVM selftests #define
> - * _GNU_SOURCE for various reasons, and _GNU_SOURCE implies _ISOC11_SOURCE.  As
> - * a result, static_assert() behavior is non-deterministic and may or may not
> - * require a message depending on #include order.
> + * message param.  _GNU_SOURCE is defined for all KVM selftests, _GNU_SOURCE
> + * implies _ISOC11_SOURCE, and if _ISOC11_SOURCE is defined, glibc #undefs and
> + * #defines static_assert() as a direct alias to _Static_assert() (see
> + * usr/include/assert.h).  Define a custom macro instead of redefining
> + * static_assert() to avoid creating non-deterministic behavior that is
> + * dependent on include order.
>   */
>  #define __kvm_static_assert(expr, msg, ...) _Static_assert(expr, msg)
>  #define kvm_static_assert(expr, ...) __kvm_static_assert(expr, ##__VA_ARGS__, #expr)
> diff --git a/tools/testing/selftests/kvm/include/userfaultfd_util.h b/tools/testing/selftests/kvm/include/userfaultfd_util.h
> index 24f2cc5f4292..60f7f9d435dc 100644
> --- a/tools/testing/selftests/kvm/include/userfaultfd_util.h
> +++ b/tools/testing/selftests/kvm/include/userfaultfd_util.h
> @@ -5,9 +5,6 @@
>   * Copyright (C) 2018, Red Hat, Inc.
>   * Copyright (C) 2019-2022 Google LLC
>   */
> -
> -#define _GNU_SOURCE /* for pipe2 */
> -
>  #include <inttypes.h>
>  #include <time.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> index 698c1cfa3111..f02355c3c4c2 100644
> --- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> +++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> @@ -6,8 +6,6 @@
>   *
>   * Test the fd-based interface for KVM statistics.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> index b9e23265e4b3..c78f34699f73 100644
> --- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> +++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> @@ -6,8 +6,6 @@
>   *
>   * Test for KVM_CAP_MAX_VCPUS and KVM_CAP_MAX_VCPU_ID.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
> index e0ba97ac1c56..7759c685086b 100644
> --- a/tools/testing/selftests/kvm/kvm_page_table_test.c
> +++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
> @@ -8,9 +8,6 @@
>   * page size have been pre-allocated on your system, if you are planning to
>   * use hugepages to back the guest memory for testing.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_name */
> -
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <time.h>
> diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
> index 2bd25b191d15..b49690658c60 100644
> --- a/tools/testing/selftests/kvm/lib/assert.c
> +++ b/tools/testing/selftests/kvm/lib/assert.c
> @@ -4,9 +4,6 @@
>   *
>   * Copyright (C) 2018, Google LLC.
>   */
> -
> -#define _GNU_SOURCE /* for getline(3) and strchrnul(3)*/
> -
>  #include "test_util.h"
>  
>  #include <execinfo.h>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index b2262b5fad9e..1eaf001d0ad4 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -4,8 +4,6 @@
>   *
>   * Copyright (C) 2018, Google LLC.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_name */
>  #include "test_util.h"
>  #include "kvm_util.h"
>  #include "processor.h"
> diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
> index cf2c73971308..555e3932e529 100644
> --- a/tools/testing/selftests/kvm/lib/memstress.c
> +++ b/tools/testing/selftests/kvm/lib/memstress.c
> @@ -2,8 +2,6 @@
>  /*
>   * Copyright (C) 2020, Google LLC.
>   */
> -#define _GNU_SOURCE
> -
>  #include <inttypes.h>
>  #include <linux/bitmap.h>
>  
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index 5a8f8becb129..8ed0b74ae837 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -4,8 +4,6 @@
>   *
>   * Copyright (C) 2020, Google LLC.
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdarg.h>
>  #include <assert.h>
> diff --git a/tools/testing/selftests/kvm/lib/userfaultfd_util.c b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> index 0ba866c4af69..7c9de8414462 100644
> --- a/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> +++ b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> @@ -6,9 +6,6 @@
>   * Copyright (C) 2018, Red Hat, Inc.
>   * Copyright (C) 2019-2022 Google LLC
>   */
> -
> -#define _GNU_SOURCE /* for pipe2 */
> -
>  #include <inttypes.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> index e248d3364b9c..e83809febae1 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <stdint.h>
>  #include <stdbool.h>
>  
> diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/max_guest_memory_test.c
> index 6628dc4dda89..9b7fc3908be6 100644
> --- a/tools/testing/selftests/kvm/max_guest_memory_test.c
> +++ b/tools/testing/selftests/kvm/max_guest_memory_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
> -
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> index 156361966612..05fcf902e067 100644
> --- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> +++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> @@ -6,9 +6,6 @@
>   * Copyright (C) 2018, Red Hat, Inc.
>   * Copyright (C) 2020, Google, Inc.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_name */
> -
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <sys/syscall.h>
> diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
> index 0f9cabd99fd4..4b5004ef9c6b 100644
> --- a/tools/testing/selftests/kvm/riscv/arch_timer.c
> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> @@ -7,9 +7,6 @@
>   *
>   * Copyright (c) 2024, Intel Corporation.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include "arch_timer.h"
>  #include "kvm_util.h"
>  #include "processor.h"
> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index 28f97fb52044..0728b15b5d3a 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -1,5 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define _GNU_SOURCE /* for program_invocation_short_name */
> +
> +/*
> + * Include rseq.c without _GNU_SOURCE defined, before including any headers, so
> + * that rseq.c is compiled with its configuration, not KVM selftests' config.
> + */
> +#undef _GNU_SOURCE
> +#include "../rseq/rseq.c"
> +#define _GNU_SOURCE
> +
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <pthread.h>
> @@ -20,8 +28,6 @@
>  #include "processor.h"
>  #include "test_util.h"
>  
> -#include "../rseq/rseq.c"
> -
>  /*
>   * Any bug related to task migration is likely to be timing-dependent; perform
>   * a large number of migrations to reduce the odds of a false negative.
> diff --git a/tools/testing/selftests/kvm/s390x/cmma_test.c b/tools/testing/selftests/kvm/s390x/cmma_test.c
> index 626a2b8a2037..84ba79c42ab1 100644
> --- a/tools/testing/selftests/kvm/s390x/cmma_test.c
> +++ b/tools/testing/selftests/kvm/s390x/cmma_test.c
> @@ -7,8 +7,6 @@
>   * Authors:
>   *  Nico Boehr <nrb@linux.ibm.com>
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> index 43fb25ddc3ec..53def355ccba 100644
> --- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> +++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> @@ -10,8 +10,6 @@
>   *
>   * Test expected behavior of the KVM_CAP_SYNC_REGS functionality.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index 06b43ed23580..4a436a40e4b0 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <pthread.h>
>  #include <sched.h>
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
> index 4be5a1ffa06a..b6938bd2442c 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -4,7 +4,6 @@
>   *
>   * Copyright (C) 2020, Red Hat, Inc.
>   */
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <time.h>
>  #include <sched.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> index eae521f050e0..8e5713e36d4b 100644
> --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> @@ -6,8 +6,6 @@
>   *
>   * Tests for amx #NM exception and save/restore.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c b/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c
> index 6c2e5e0ceb1f..9c21b6bccc38 100644
> --- a/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c
> @@ -4,9 +4,6 @@
>   *
>   * Test for KVM_CAP_EXIT_ON_EMULATION_FAILURE.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
> -
>  #include "flds_emulation.h"
>  
>  #include "test_util.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/hwcr_msr_test.c b/tools/testing/selftests/kvm/x86_64/hwcr_msr_test.c
> index df351ae17029..10b1b0ba374e 100644
> --- a/tools/testing/selftests/kvm/x86_64/hwcr_msr_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/hwcr_msr_test.c
> @@ -2,8 +2,6 @@
>  /*
>   * Copyright (C) 2023, Google LLC.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <sys/ioctl.h>
>  
>  #include "test_util.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
> index 5c27efbf405e..4f5881d4ef66 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
> @@ -7,8 +7,6 @@
>   * This work is licensed under the terms of the GNU GPL, version 2.
>   *
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
> index 4c7257ecd2a6..4f3f3a9b038b 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
> @@ -4,7 +4,6 @@
>   *
>   * Tests for Enlightened VMCS, including nested guest state.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c b/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
> index f1617762c22f..8206f5ef42dd 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
> @@ -5,8 +5,6 @@
>   * Copyright (C) 2022, Red Hat, Inc.
>   *
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <pthread.h>
>  #include <inttypes.h>
>  
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
> index c9b18707edc0..b987a3d79715 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
> @@ -4,7 +4,6 @@
>   *
>   * Tests for Hyper-V extensions to SVM.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c b/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c
> index 05b56095cf76..077cd0ec3040 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c
> @@ -5,8 +5,6 @@
>   * Copyright (C) 2022, Red Hat, Inc.
>   *
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <asm/barrier.h>
>  #include <pthread.h>
>  #include <inttypes.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c
> index 3670331adf21..3eb0313ffa39 100644
> --- a/tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define _GNU_SOURCE /* for program_invocation_short_name */
> -
>  #include "test_util.h"
>  #include "kvm_util.h"
>  #include "processor.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> index 17bbb96fc4df..e7efb2b35f8b 100644
> --- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> @@ -5,9 +5,6 @@
>   *
>   * Copyright (C) 2022, Google LLC.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <fcntl.h>
>  #include <stdint.h>
>  #include <time.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/platform_info_test.c b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
> index 87011965dc41..2165b1ad8b38 100644
> --- a/tools/testing/selftests/kvm/x86_64/platform_info_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
> @@ -9,8 +9,6 @@
>   * Verifies expected behavior of controlling guest access to
>   * MSR_PLATFORM_INFO.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> index 29609b52f8fa..842d87c8d6b6 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> @@ -2,8 +2,6 @@
>  /*
>   * Copyright (C) 2023, Tencent, Inc.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <x86intrin.h>
>  
>  #include "pmu.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> index 3c85d1ae9893..5ce53b8c46e0 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> @@ -9,9 +9,6 @@
>   * Verifies the expected behavior of allow lists and deny lists for
>   * virtual PMU events.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
> -
>  #include "kvm_util.h"
>  #include "pmu.h"
>  #include "processor.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
> index e0f642d2a3c4..82a8d88b5338 100644
> --- a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
> @@ -2,7 +2,6 @@
>  /*
>   * Copyright (C) 2022, Google LLC.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <limits.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
> index 366cf18600bc..d691d86e5bc3 100644
> --- a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
> +++ b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
> @@ -4,7 +4,6 @@
>   *
>   * Copyright (C) 2020, Red Hat, Inc.
>   */
> -#define _GNU_SOURCE /* for program_invocation_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
> index 3610981d9162..c021c0795a96 100644
> --- a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
> @@ -10,7 +10,6 @@
>   * That bug allowed a user-mode program that called the KVM_SET_SREGS
>   * ioctl to put a VCPU's local APIC into an invalid state.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
> index 416207c38a17..362be40fc00d 100644
> --- a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
> @@ -5,9 +5,6 @@
>   * Test that KVM emulates instructions in response to EPT violations when
>   * allow_smaller_maxphyaddr is enabled and guest.MAXPHYADDR < host.MAXPHYADDR.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
> -
>  #include "flds_emulation.h"
>  
>  #include "test_util.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
> index e18b86666e1f..55c88d664a94 100644
> --- a/tools/testing/selftests/kvm/x86_64/smm_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
> @@ -4,7 +4,6 @@
>   *
>   * Tests for SMM.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
> index 88b58aab7207..1c756db329e5 100644
> --- a/tools/testing/selftests/kvm/x86_64/state_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/state_test.c
> @@ -6,7 +6,6 @@
>   *
>   * Tests for vCPU state save/restore, including nested guest state.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
> index adb5593daf48..8fa3948b0170 100644
> --- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
> @@ -8,8 +8,6 @@
>   * including requesting an invalid register set, updates to/from values
>   * in kvm_run.s.regs when kvm_valid_regs and kvm_dirty_regs are toggled.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
> index dcbb3c29fb8e..abe71946941f 100644
> --- a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
> @@ -17,8 +17,6 @@
>   * delivered into the guest or not.
>   *
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <pthread.h>
>  #include <inttypes.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
> index f4f61a2d2464..53afbea4df88 100644
> --- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
> @@ -4,8 +4,6 @@
>   *
>   * Tests for exiting into userspace on registered MSRs
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <sys/ioctl.h>
>  
>  #include "kvm_test_harness.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> index 7f6f5f23fb9b..a39cba19c058 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> @@ -4,9 +4,6 @@
>   *
>   * Copyright (C) 2018, Red Hat, Inc.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_name */
> -
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <linux/bitmap.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> index ea0cb3cae0f7..3b93f262b797 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> @@ -10,7 +10,6 @@
>   * and check it can be retrieved with KVM_GET_MSR, also test
>   * the invalid LBR formats are rejected.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <sys/ioctl.h>
>  
>  #include <linux/bitmap.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
> index affc32800158..00dd2ac07a61 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
> @@ -9,7 +9,6 @@
>   * value instead of partially decayed timer value
>   *
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
> index 725c206ba0b9..c78e5f755116 100644
> --- a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
> @@ -19,8 +19,6 @@
>   * Migration is a command line option. When used on non-numa machines will 
>   * exit with error. Test is still usefull on non-numa for testing IPIs.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <getopt.h>
>  #include <pthread.h>
>  #include <inttypes.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
> index ab75b873a4ad..69849acd95b0 100644
> --- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/xss_msr_test.c b/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
> index 167c97abff1b..f331a4e9bae3 100644
> --- a/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
> @@ -4,8 +4,6 @@
>   *
>   * Tests for the IA32_XSS MSR.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <sys/ioctl.h>
>  
>  #include "test_util.h"
> 
> base-commit: 9f92c06e184074930174e469205f4e78338651f8

-- 
BR,
Muhammad Usama Anjum

