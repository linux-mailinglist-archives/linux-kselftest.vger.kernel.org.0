Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7FE4A5517
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 03:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiBACD0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 21:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiBACCh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 21:02:37 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B454C061714
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 18:02:36 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 132so2949658pga.5
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 18:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=01yH3+D+ZMMlRa0Dsmw32+0XD6peGRIzOsnNsIRg0t0=;
        b=2M77J4X4S4nx31pXNwHwi4MO3VnCzaO5Lj3FmVbc+0paTL0BU4vcxclFV2PtO3gqdv
         Krm7x99XbLskwjH364IxLQy5CH4nDJYZNsdLhCkturpaAOi8RF+91hed2cVYLvMPJfKT
         Kwgxs1PG1Jp6UOHz98obYHkuRK3DlswTgWni754QxGZxwA7mNSR/BsdWLR/TBQR92lUI
         rhLaoQYXfn+Qq7R4C/hrkPB1QuaGcRuKDBNshOCl0z5r9v8W9tRk/yjLkhmTnnwAcYG9
         mExIa1L92Rq1cyxMH0yhcZ1962XX7GVwkdVWxOyNvRASiaczzcHaef6E9azm1hY7fm+C
         5low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=01yH3+D+ZMMlRa0Dsmw32+0XD6peGRIzOsnNsIRg0t0=;
        b=bt3kIXx1Gd88Oyhc1b+MdfAim2TdOEhUJtZuJQmN6dVPdEXMIdPCIDY4wjFOOK1edJ
         9U6Dyfubpp+GMtDFhoH/3OZLtwru+sRU3eT8RIWRgQOtYXTjheSD20KuVFJ9EG5qob/Q
         DkDhPSXtdpbRc/5a3A2RXP+JybbYhbohMidQ+kid+3Nkqsk3RvCVSg1w3LucoTarMnsI
         I9c7tWI75QEe7fczDk15pMqX9Rb8xTJm3qKEvhLlUSUNe9lgYTOxGvFSsdMnr08/qV4O
         FBz8PzMBib6Jsx2FEfkBi50U1MOAauyeMT621n/3soB028nJdchE6LPwh62Dn9rYF0pb
         VYxg==
X-Gm-Message-State: AOAM530sP47Kc+HblvpEh0DMfJ61VzlUhKMOT/oWF58r5c+mFo5NW6hy
        Z138ZDm0RP92KGSH8HOVmD5Hmw==
X-Google-Smtp-Source: ABdhPJwHEVQWfMvnP4kl58xFu74xZz6DdLLe6Blpys2n4pvaMdf5kavCSUgirYAp7OKgoY1nwlsrNg==
X-Received: by 2002:a63:18e:: with SMTP id 136mr13762609pgb.478.1643680955897;
        Mon, 31 Jan 2022 18:02:35 -0800 (PST)
Received: from [192.168.10.24] (203-7-124-83.dyn.iinet.net.au. [203.7.124.83])
        by smtp.gmail.com with ESMTPSA id l20sm20399023pfc.53.2022.01.31.18.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 18:02:35 -0800 (PST)
Message-ID: <71478222-c144-fe25-d24a-47ac9b418663@ozlabs.ru>
Date:   Tue, 1 Feb 2022 13:02:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:97.0) Gecko/20100101
 Thunderbird/97.0
Subject: Re: [PATCH 2/2] KVM: selftests: Add support for ppc64le
Content-Language: en-US
To:     Fabiano Rosas <farosas@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        pbonzini@redhat.com, shuah@kernel.org, mpe@ellerman.id.au,
        npiggin@gmail.com, paulus@samba.org
References: <20220120170109.948681-1-farosas@linux.ibm.com>
 <20220120170109.948681-3-farosas@linux.ibm.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20220120170109.948681-3-farosas@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 1/21/22 04:01, Fabiano Rosas wrote:
> This adds the infrastructure for writing tests for the powerpc
> platform (Only Radix MMU for now).
> 
> This patch also enables two tests:
> 
> - a dummy sample test that creates a guest with one vcpu, issues
>    hypercalls and reads/writes test values from memory.
> 
> - the kvm_page_table test, although at this point I'm not using it to
>    test KVM, but mostly as a way to stress test this code.
> 
> $ make -C tools/testing/selftests TARGETS=kvm
> $ make -C tools/testing/selftests TARGETS=kvm run_tests
> 
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>   MAINTAINERS                                   |   3 +
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |  14 +-
>   .../selftests/kvm/include/kvm_util_base.h     |   7 +
>   .../selftests/kvm/include/ppc64le/processor.h |  43 +++
>   tools/testing/selftests/kvm/lib/kvm_util.c    |   5 +
>   .../testing/selftests/kvm/lib/powerpc/hcall.S |   6 +
>   .../selftests/kvm/lib/powerpc/processor.c     | 343 ++++++++++++++++++
>   .../testing/selftests/kvm/lib/powerpc/ucall.c |  67 ++++
>   .../selftests/kvm/powerpc/sample_test.c       | 144 ++++++++
>   10 files changed, 630 insertions(+), 3 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/include/ppc64le/processor.h
>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.S
>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
>   create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
>   create mode 100644 tools/testing/selftests/kvm/powerpc/sample_test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a76e7558b151..15c89d33d584 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10537,6 +10537,9 @@ F:	arch/powerpc/include/asm/kvm*
>   F:	arch/powerpc/include/uapi/asm/kvm*
>   F:	arch/powerpc/kernel/kvm*
>   F:	arch/powerpc/kvm/
> +F:	tools/testing/selftests/kvm/include/ppc64le/
> +F:	tools/testing/selftests/kvm/lib/powerpc/
> +F:	tools/testing/selftests/kvm/powerpc/
>   
>   KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)
>   M:	Anup Patel <anup@brainfault.org>
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 8c129961accf..45ab993e2845 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -46,6 +46,7 @@
>   /x86_64/xen_vmcall_test
>   /x86_64/xss_msr_test
>   /x86_64/vmx_pmu_msrs_test
> +/powerpc/sample_test
>   /access_tracking_perf_test
>   /demand_paging_test
>   /dirty_log_test
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 556da71c33b8..5ae27109e9b9 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -17,9 +17,9 @@ KSFT_KHDR_INSTALL := 1
>   # LINUX_TOOL_ARCH_INCLUDE is set using ARCH variable.
>   #
>   # x86_64 targets are named to include x86_64 as a suffix and directories
> -# for includes are in x86_64 sub-directory. s390x and aarch64 follow the
> -# same convention. "uname -m" doesn't result in the correct mapping for
> -# s390x and aarch64.
> +# for includes are in x86_64 sub-directory. s390x, aarch64 and ppc64le
> +# follow the same convention. "uname -m" doesn't result in the correct
> +# mapping for s390x, aarch64 and ppc64le.
>   #
>   # No change necessary for x86_64
>   UNAME_M := $(shell uname -m)
> @@ -36,12 +36,17 @@ endif
>   ifeq ($(ARCH),riscv)
>   	UNAME_M := riscv
>   endif
> +# Set UNAME_M for ppc64le compile/install to work
> +ifeq ($(ARCH),powerpc)
> +	UNAME_M := ppc64le
> +endif
>   
>   LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
>   LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
>   LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c lib/aarch64/vgic.c
>   LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
>   LIBKVM_riscv = lib/riscv/processor.c lib/riscv/ucall.c
> +LIBKVM_ppc64le = lib/powerpc/processor.c lib/powerpc/ucall.c lib/powerpc/hcall.S
>   
>   TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
>   TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
> @@ -133,6 +138,9 @@ TEST_GEN_PROGS_riscv += kvm_page_table_test
>   TEST_GEN_PROGS_riscv += set_memory_region_test
>   TEST_GEN_PROGS_riscv += kvm_binary_stats_test
>   
> +TEST_GEN_PROGS_ppc64le += powerpc/sample_test
> +TEST_GEN_PROGS_ppc64le += kvm_page_table_test
> +
>   TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
>   LIBKVM += $(LIBKVM_$(UNAME_M))
>   
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 66775de26952..a930d663fe67 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -54,6 +54,7 @@ enum vm_guest_mode {
>   	VM_MODE_P36V48_16K,
>   	VM_MODE_P36V48_64K,
>   	VM_MODE_P36V47_16K,
> +	VM_MODE_P51V52_64K,
>   	NUM_VM_MODES,
>   };
>   
> @@ -87,6 +88,12 @@ extern enum vm_guest_mode vm_mode_default;
>   #define MIN_PAGE_SHIFT			12U
>   #define ptes_per_page(page_size)	((page_size) / 8)
>   
> +#elif defined(__powerpc__)
> +
> +#define VM_MODE_DEFAULT			VM_MODE_P51V52_64K
> +#define MIN_PAGE_SHIFT			16U
> +#define ptes_per_page(page_size)	((page_size) / 8)
> +
>   #endif
>   
>   #define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
> diff --git a/tools/testing/selftests/kvm/include/ppc64le/processor.h b/tools/testing/selftests/kvm/include/ppc64le/processor.h
> new file mode 100644
> index 000000000000..fbc1332b2b80
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/ppc64le/processor.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * powerpc processor specific defines
> + */
> +#ifndef SELFTEST_KVM_PROCESSOR_H
> +#define SELFTEST_KVM_PROCESSOR_H
> +
> +#define PPC_BIT(x) (1ULL << (63 - x))


Put the "x" in braces.


> +
> +#define MSR_SF  PPC_BIT(0)
> +#define MSR_IR  PPC_BIT(58)
> +#define MSR_DR  PPC_BIT(59)
> +#define MSR_LE  PPC_BIT(63)
> +
> +#define LPCR_UPRT  PPC_BIT(41)
> +#define LPCR_EVIRT PPC_BIT(42)
> +#define LPCR_HR    PPC_BIT(43)
> +#define LPCR_GTSE  PPC_BIT(53)
> +
> +#define PATB_GR	PPC_BIT(0)
> +
> +#define PTE_VALID PPC_BIT(0)
> +#define PTE_LEAF  PPC_BIT(1)
> +#define PTE_R	  PPC_BIT(55)
> +#define PTE_C	  PPC_BIT(56)
> +#define PTE_RC	  (PTE_R | PTE_C)
> +#define PTE_READ  0x4
> +#define PTE_WRITE 0x2
> +#define PTE_EXEC  0x1
> +#define PTE_RWX   (PTE_READ|PTE_WRITE|PTE_EXEC)
> +
> +extern uint64_t hcall(uint64_t nr, ...);
> +
> +static inline uint32_t mfpvr(void)
> +{
> +	uint32_t pvr;
> +
> +	asm ("mfpvr %0"
> +	     : "=r"(pvr));
> +	return pvr;
> +}
> +
> +#endif
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index c22a17aac6b0..cc5247c2cfeb 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -205,6 +205,7 @@ const char *vm_guest_mode_string(uint32_t i)
>   		[VM_MODE_P36V48_16K]	= "PA-bits:36,  VA-bits:48, 16K pages",
>   		[VM_MODE_P36V48_64K]	= "PA-bits:36,  VA-bits:48, 64K pages",
>   		[VM_MODE_P36V47_16K]	= "PA-bits:36,  VA-bits:47, 16K pages",
> +		[VM_MODE_P51V52_64K]    = "PA-bits:51,  VA-bits:52, 64K pages",
>   	};
>   	_Static_assert(sizeof(strings)/sizeof(char *) == NUM_VM_MODES,
>   		       "Missing new mode strings?");
> @@ -230,6 +231,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
>   	[VM_MODE_P36V48_16K]	= { 36, 48,  0x4000, 14 },
>   	[VM_MODE_P36V48_64K]	= { 36, 48, 0x10000, 16 },
>   	[VM_MODE_P36V47_16K]	= { 36, 47,  0x4000, 14 },
> +	[VM_MODE_P51V52_64K]    = { 51, 52, 0x10000, 16 },
>   };
>   _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
>   	       "Missing new mode params?");
> @@ -331,6 +333,9 @@ struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>   	case VM_MODE_P44V64_4K:
>   		vm->pgtable_levels = 5;
>   		break;
> +	case VM_MODE_P51V52_64K:
> +		vm->pgtable_levels = 4;
> +		break;
>   	default:
>   		TEST_FAIL("Unknown guest mode, mode: 0x%x", mode);
>   	}
> diff --git a/tools/testing/selftests/kvm/lib/powerpc/hcall.S b/tools/testing/selftests/kvm/lib/powerpc/hcall.S
> new file mode 100644
> index 000000000000..a78b88f3b207
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/powerpc/hcall.S
> @@ -0,0 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +.globl hcall;
> +
> +hcall:
> +	sc	1
> +	blr
> diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
> new file mode 100644
> index 000000000000..2ffd5423a968
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * KVM selftest powerpc library code
> + *
> + * Copyright (C) 2021, IBM Corp.


2022?

Otherwise looks good and works well and we have another test for 
instruction emilation on top of this which highlighted a bug so this is 
useful stuff.


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> + */
> +
> +#define _GNU_SOURCE
> +//#define DEBUG
> +
> +#include "kvm_util.h"
> +#include "../kvm_util_internal.h"
> +#include "processor.h"
> +
> +/*
> + * 2^(12+PRTS) = Process table size
> + *
> + * But the hardware doesn't seem to care, so 0 for now.
> + */
> +#define PRTS 0
> +#define RTS ((0x5UL << 5) | (0x2UL << 61)) /* 2^(RTS+31) = 2^52 */
> +#define RPDS 0xd
> +#define RPDB_MASK 0x0fffffffffffff00UL
> +#define RPN_MASK  0x01fffffffffff000UL
> +
> +#define MIN_FRAME_SZ 32
> +
> +static const int radix_64k_index_sizes[4] = { 5, 9, 9, 13 };
> +
> +static inline uint64_t mk_pte(uint64_t pte_val)
> +{
> +	return cpu_to_be64(PTE_VALID | pte_val);
> +}
> +
> +static inline uint64_t get_pte(uint64_t pte)
> +{
> +	return be64_to_cpu(pte);
> +}
> +
> +static inline uint64_t pte_rpn(uint64_t entry)
> +{
> +	return get_pte(entry) & RPN_MASK;
> +}
> +
> +static inline uint64_t next_pde(uint64_t entry)
> +{
> +	return get_pte(entry) & RPDB_MASK;
> +}
> +
> +static inline uint64_t ptrs_per_pgd(int level)
> +{
> +	return 1UL << radix_64k_index_sizes[level];
> +}
> +
> +static inline uint64_t level_size(int level)
> +{
> +	return sizeof(vm_paddr_t) << (radix_64k_index_sizes[level] + 3);
> +}
> +
> +static vm_paddr_t alloc_pgd(struct kvm_vm *vm, int level)
> +{
> +	static vm_paddr_t base;
> +	vm_paddr_t addr;
> +	uint64_t size = level_size(level);
> +
> +	if (!base || (base + size) >> vm->page_shift != base >> vm->page_shift)
> +		addr = vm_alloc_page_table(vm);
> +	else
> +		addr = base;
> +	base = addr + size;
> +
> +	return addr;
> +}
> +
> +static vm_paddr_t pgtable_walk(struct kvm_vm *vm, vm_vaddr_t gva, uint64_t gpa,
> +			       bool alloc)
> +{
> +	uint64_t index_bits, shift, base, index;
> +	uint64_t *ptep, ptep_gpa;
> +	int level;
> +
> +	if (!vm->pgd_created)
> +		goto unmapped_gva;
> +
> +	pr_debug("%s %#lx ", (alloc ? "mapping" : "lookup "), gva);
> +
> +	base = vm->pgd;
> +	shift = vm->va_bits;
> +
> +	for (level = 3; level >= 0; --level) {
> +
> +		index_bits = radix_64k_index_sizes[level];
> +		shift -= index_bits;
> +
> +		index = (gva >> shift) & ((1UL << index_bits) - 1);
> +		ptep_gpa = base + index * sizeof(*ptep);
> +		ptep = addr_gpa2hva(vm, ptep_gpa);
> +
> +		if (!*ptep) {
> +			if (!alloc)
> +				goto unmapped_gva;
> +			if (level)
> +				*ptep = mk_pte(alloc_pgd(vm, level - 1) |
> +					       radix_64k_index_sizes[level - 1]);
> +		}
> +
> +		if (get_pte(*ptep) & PTE_LEAF)
> +			break;
> +
> +		base = next_pde(*ptep);
> +	}
> +
> +	if (alloc)
> +		*ptep = mk_pte(PTE_LEAF | gpa | PTE_RC | PTE_RWX);
> +	else
> +		gpa = pte_rpn(*ptep);
> +
> +	pr_debug("-> %#lx pte: %#lx (@%#lx)\n", gpa, get_pte(*ptep), ptep_gpa);
> +
> +	return gpa | (gva & (vm->page_size - 1));
> +
> +unmapped_gva:
> +	TEST_FAIL("No mapping for vm virtual address, gva: %#lx", gva);
> +	exit(1);
> +}
> +
> +void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
> +{
> +	TEST_ASSERT((vaddr % vm->page_size) == 0,
> +		    "Virtual address not on page boundary,\n"
> +		    "  vaddr: 0x%lx vm->page_size: 0x%x", vaddr, vm->page_size);
> +
> +	TEST_ASSERT(sparsebit_is_set(vm->vpages_valid,
> +				     (vaddr >> vm->page_shift)),
> +		    "Invalid virtual address, vaddr: 0x%lx", vaddr);
> +
> +	TEST_ASSERT((paddr % vm->page_size) == 0,
> +		    "Physical address not on page boundary,\n"
> +		    "  paddr: 0x%lx vm->page_size: 0x%x", paddr, vm->page_size);
> +
> +	TEST_ASSERT((paddr >> vm->page_shift) <= vm->max_gfn,
> +		    "Physical address beyond maximum supported,\n"
> +		    "  paddr: 0x%lx vm->max_gfn: 0x%lx vm->page_size: 0x%x",
> +		    paddr, vm->max_gfn, vm->page_size);
> +
> +	TEST_ASSERT(vm->pgd_created, "Page table not created\n");
> +
> +	pgtable_walk(vm, vaddr, paddr, true);
> +}
> +
> +vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
> +{
> +	return pgtable_walk(vm, gva, 0, false);
> +}
> +
> +void virt_pgd_alloc(struct kvm_vm *vm)
> +{
> +	struct kvm_ppc_mmuv3_cfg cfg = { 0 };
> +	vm_paddr_t proc_tb;
> +	uint64_t *proc_tb_hva;
> +
> +	if (!kvm_check_cap(KVM_CAP_PPC_MMU_RADIX)) {
> +		print_skip("Tests only support Radix MMU");
> +		exit(KSFT_SKIP);
> +	}
> +
> +	if (!kvm_check_cap(KVM_CAP_PPC_PAPR)) {
> +		print_skip("Tests only support Book3s");
> +		exit(KSFT_SKIP);
> +	}
> +
> +	if (vm->pgd_created)
> +		return;
> +
> +	/*
> +	 * Allocate the process table in guest memory and set the
> +	 * first doubleword of the pid 0 entry.
> +	 */
> +	proc_tb = vm_alloc_page_table(vm);
> +	vm->pgd = vm_alloc_page_table(vm);
> +
> +	proc_tb_hva = addr_gpa2hva(vm, proc_tb);
> +	*proc_tb_hva = cpu_to_be64(RTS | vm->pgd | RPDS);
> +
> +	pr_debug("process table gpa: %#lx\n", proc_tb);
> +	pr_debug("process table hva: %p\n", proc_tb_hva);
> +	pr_debug("process table entry 0 dw0: %#lx\n", *proc_tb_hva);
> +
> +	/* Register the process table with the HV */
> +	cfg.process_table = PATB_GR | proc_tb | PRTS;
> +	cfg.flags = KVM_PPC_MMUV3_RADIX | KVM_PPC_MMUV3_GTSE;
> +
> +	pr_debug("MMU config proc table: %#llx\n", cfg.process_table);
> +
> +	vm_ioctl(vm, KVM_PPC_CONFIGURE_V3_MMU, &cfg);
> +	vm->pgd_created = true;
> +}
> +
> +void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
> +{
> +	struct kvm_enable_cap cap = { 0 };
> +	struct kvm_regs regs;
> +	struct kvm_sregs sregs;
> +	vm_vaddr_t stack_vaddr;
> +	size_t stack_sz;
> +
> +	vm_vcpu_add(vm, vcpuid);
> +
> +	cap.cap = KVM_CAP_PPC_PAPR;
> +	vcpu_enable_cap(vm, vcpuid, &cap);
> +
> +	stack_sz = DEFAULT_STACK_PGS * vm->page_size;
> +	stack_vaddr = vm_vaddr_alloc(vm, stack_sz,
> +				     DEFAULT_GUEST_STACK_VADDR_MIN);
> +
> +	regs.msr = MSR_SF | MSR_LE;
> +	regs.msr |= MSR_IR | MSR_DR;
> +	regs.pc = (unsigned long) guest_code;
> +	regs.pid = 0;
> +	regs.gpr[1] = stack_vaddr + stack_sz - MIN_FRAME_SZ;
> +
> +	pr_debug("stack - low: %#lx high: %#lx size: %#lx SP: %#llx\n",
> +		 stack_vaddr, stack_vaddr + stack_sz, stack_sz, regs.gpr[1]);
> +
> +	vcpu_regs_set(vm, vcpuid, &regs);
> +
> +	sregs.pvr = mfpvr();
> +	vcpu_sregs_set(vm, vcpuid, &sregs);
> +
> +	if (kvm_check_cap(KVM_CAP_ONE_REG)) {
> +		uint64_t lpcr = LPCR_UPRT | LPCR_HR | LPCR_GTSE;
> +		struct kvm_one_reg reg = {
> +			.id = KVM_REG_PPC_LPCR_64,
> +			.addr = (uintptr_t) &lpcr,
> +		};
> +
> +		vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, &reg);
> +	}
> +}
> +
> +void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
> +{
> +	va_list ap;
> +	struct kvm_regs regs;
> +	int i;
> +
> +	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
> +		    "  num: %u\n", num);
> +
> +	va_start(ap, num);
> +	vcpu_regs_get(vm, vcpuid, &regs);
> +
> +	for (i = 0; i < num; i++)
> +		regs.gpr[i + 3] = va_arg(ap, uint64_t);
> +
> +	vcpu_regs_set(vm, vcpuid, &regs);
> +	va_end(ap);
> +}
> +
> +static void pte_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent,
> +		     uint64_t addr, int level)
> +{
> +	static const char * const type[] = { "pte", "pmd", "pud", "pgd" };
> +	uint64_t pde, *hva;
> +
> +	if (level < 0)
> +		return;
> +
> +	fprintf(stream, "%*s (%#lx):\n", indent, type[level], addr);
> +
> +	for (pde = addr; pde < addr + (ptrs_per_pgd(level) * sizeof(vm_paddr_t));
> +	     pde += sizeof(vm_paddr_t)) {
> +
> +		hva = addr_gpa2hva(vm, pde);
> +		if (!*hva)
> +			continue;
> +		fprintf(stream, "%*s %#lx: %#lx\n", indent + 1, "", pde,
> +			get_pte(*hva));
> +		pte_dump(stream, vm, indent + 2, next_pde(*hva), level - 1);
> +	}
> +}
> +
> +void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
> +{
> +	if (!vm->pgd_created)
> +		return;
> +
> +	pte_dump(stream, vm, indent, vm->pgd, 3);
> +}
> +
> +void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
> +{
> +	struct kvm_regs regs;
> +
> +	fprintf(stream, "%*scpuid: %u\n", indent, "", vcpuid);
> +
> +	vcpu_regs_get(vm, vcpuid, &regs);
> +	fprintf(stream, "%*sregs:\n", indent + 2, "");
> +
> +	fprintf(stream, "%*spc: %#llx\n", indent + 4, "", regs.pc);
> +	fprintf(stream, "%*smsr: %#llx\n", indent + 4, "", regs.msr);
> +	fprintf(stream, "%*ssrr0: %#llx\n", indent + 4, "", regs.srr0);
> +	fprintf(stream, "%*ssrr1: %#llx\n", indent + 4, "", regs.srr1);
> +
> +	fprintf(stream, "\n%*sr1: %#llx\n", indent + 4, "", regs.gpr[1]);
> +	fprintf(stream, "%*sr2: %#llx\n", indent + 4, "", regs.gpr[2]);
> +	fprintf(stream, "%*sr3: %#llx\n", indent + 4, "", regs.gpr[3]);
> +	fprintf(stream, "%*sr4: %#llx\n", indent + 4, "", regs.gpr[4]);
> +
> +	if (kvm_check_cap(KVM_CAP_ONE_REG)) {
> +		uint64_t lpcr;
> +		struct kvm_one_reg reg = {
> +			.id = KVM_REG_PPC_LPCR_64,
> +			.addr = (uintptr_t) &lpcr,
> +		};
> +
> +		vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, &reg);
> +		fprintf(stream, "%*slpcr: %#lx\n", indent + 4, "", lpcr);
> +	}
> +	fprintf(stream, "%*slr: %#llx\n", indent + 4, "", regs.lr);
> +}
> +
> +void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid)
> +{
> +	struct kvm_run *run;
> +
> +	run = vcpu_state(vm, vcpuid);
> +	if (run) {
> +		switch (run->exit_reason) {
> +		case KVM_EXIT_PAPR_HCALL:
> +		case KVM_EXIT_MMIO:
> +			return;
> +		default:
> +			printf("reason: %s\n",
> +			       exit_reason_str(run->exit_reason));
> +			break;
> +		}
> +	}
> +#ifdef DEBUG
> +	vm_dump(stderr, vm, 2);
> +#endif
> +	TEST_ASSERT(false, "Unhandled exception");
> +}
> diff --git a/tools/testing/selftests/kvm/lib/powerpc/ucall.c b/tools/testing/selftests/kvm/lib/powerpc/ucall.c
> new file mode 100644
> index 000000000000..fc76ef796f02
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/powerpc/ucall.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "kvm_util.h"
> +#include "processor.h"
> +
> +/*
> + * Using this hypercall for now because it is already defined. It is
> + * used by SLOF to ask QEMU to copy memory regions, so it is close
> + * enough for our purposes.
> + */
> +#define KVMPPC_H_LOGICAL_MEMOP 0xf001
> +
> +
> +void ucall_init(struct kvm_vm *vm, void *arg)
> +{
> +}
> +
> +void ucall_uninit(struct kvm_vm *vm)
> +{
> +}
> +
> +static inline int __ucall(uint64_t args)
> +{
> +	return hcall(KVMPPC_H_LOGICAL_MEMOP, args);
> +}
> +
> +/*
> + * This function runs inside the guest, so avoid optimizations that
> + * could add an indirect call via PLT and disable vector instructions
> + * like the kernel does.
> + */
> +__attribute__((optimize(0), target("no-altivec,no-vsx")))
> +void ucall(uint64_t cmd, int nargs, ...)
> +{
> +	struct ucall uc = {
> +		.cmd = cmd,
> +	};
> +	va_list va;
> +	int i;
> +
> +	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> +
> +	va_start(va, nargs);
> +	for (i = 0; i < nargs; ++i)
> +		uc.args[i] = va_arg(va, uint64_t);
> +	va_end(va);
> +
> +	__ucall((uint64_t)&uc);
> +}
> +
> +uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
> +{
> +	struct kvm_run *run = vcpu_state(vm, vcpu_id);
> +	struct ucall ucall = {};
> +
> +	if (uc)
> +		memset(uc, 0, sizeof(*uc));
> +
> +	if (run->exit_reason == KVM_EXIT_PAPR_HCALL &&
> +	    run->papr_hcall.nr == KVMPPC_H_LOGICAL_MEMOP) {
> +		memcpy(&ucall, addr_gva2hva(vm, run->papr_hcall.args[0]),
> +					    sizeof(ucall));
> +		if (uc)
> +			memcpy(uc, &ucall, sizeof(ucall));
> +	}
> +
> +	return ucall.cmd;
> +}
> diff --git a/tools/testing/selftests/kvm/powerpc/sample_test.c b/tools/testing/selftests/kvm/powerpc/sample_test.c
> new file mode 100644
> index 000000000000..16f0df920d98
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/powerpc/sample_test.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +#include <pthread.h>
> +#include <stdio.h>
> +#include <signal.h>
> +
> +#define DEBUG
> +#include "kvm_util.h"
> +#include "test_util.h"
> +#include "processor.h"
> +
> +#define H_PUT_TERM_CHAR 0x58
> +#define TEST_VAL 0x8badf00d
> +#define PASS_VAL 0xdeadbeef
> +#define FAIL_VAL 0x2badd00d
> +
> +
> +struct kvm_vm *vm;
> +
> +/*
> + * Call the hypervisor to write a character to the console. KVM does
> + * not handle this hypercall so it goes out to userspace. Which in
> + * this case is the vcpu_worker() below.
> + */
> +static inline void put_char(char c)
> +{
> +	hcall(H_PUT_TERM_CHAR, 0, 1, cpu_to_be64(c));
> +}
> +
> +static void guest_code(uint64_t *ptr, uint64_t val)
> +{
> +	/*
> +	 * Test making a hypercall and give a visual indication that
> +	 * the guest code is running.
> +	 */
> +	put_char('.');
> +
> +	/* Make sure we can receive values */
> +	GUEST_ASSERT(ptr);
> +	GUEST_ASSERT(val == TEST_VAL);
> +
> +	put_char('.');
> +
> +	/* Read/write to memory */
> +	if (*ptr == val)
> +		*ptr = PASS_VAL;
> +	else
> +		*ptr = FAIL_VAL;
> +
> +	put_char('.');
> +
> +	/* Signal we're done */
> +	GUEST_DONE();
> +}
> +
> +static bool guest_done(struct kvm_vm *vm)
> +{
> +	struct ucall uc;
> +	bool done;
> +
> +	switch (get_ucall(vm, 0, &uc)) {
> +	case UCALL_ABORT:
> +		TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
> +			  __FILE__, uc.args[1]);
> +		/* not reached */
> +	case UCALL_DONE:
> +		done = true;
> +		break;
> +	default:
> +		done = false;
> +		break;
> +	}
> +
> +	return done;
> +}
> +
> +static void *vcpu_worker(void *data)
> +{
> +	struct kvm_vm *vm = data;
> +	struct kvm_run *run;
> +	uint64_t *hva;
> +	static uint64_t test_buf = TEST_VAL;
> +
> +	/* Pass arguments to the guest code */
> +	vcpu_args_set(vm, 0, 2, &test_buf, TEST_VAL);
> +
> +	run = vcpu_state(vm, 0);
> +	while (1) {
> +		vcpu_run(vm, 0);
> +
> +		if (guest_done(vm))
> +			break;
> +
> +		switch (run->exit_reason) {
> +		case KVM_EXIT_PAPR_HCALL:
> +			if (run->papr_hcall.nr == H_PUT_TERM_CHAR) {
> +				char c = be64_to_cpu(run->papr_hcall.args[2]);
> +
> +				pr_debug("%c", c);
> +			}
> +			break;
> +		default:
> +			printf("exit reason: %s\n", exit_reason_str(run->exit_reason));
> +			break;
> +		}
> +	}
> +
> +	hva = addr_gva2hva(vm, (vm_vaddr_t)&test_buf);
> +	TEST_ASSERT(*hva != FAIL_VAL,
> +		    "Guest failed to read test value at gva %p", &test_buf);
> +	TEST_ASSERT(*hva == PASS_VAL,
> +		    "Guest failed to write test value to gva %p", &test_buf);
> +
> +	pr_debug("PASS\n");
> +
> +	return NULL;
> +}
> +
> +void dump_vm(int sig)
> +{
> +	vm_dump(stderr, vm, 2);
> +	exit(1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	pthread_t vcpu_thread;
> +
> +	signal(SIGINT, dump_vm);
> +
> +	/*
> +	 * Do not buffer stdout so we can implement put_char without
> +	 * flushing.
> +	 */
> +	setbuf(stdout, NULL);
> +
> +	vm = vm_create_default(0, 0, guest_code);
> +	pthread_create(&vcpu_thread, NULL, vcpu_worker, vm);
> +
> +	pthread_join(vcpu_thread, NULL);
> +	kvm_vm_free(vm);
> +
> +	return 0;
> +}
