Return-Path: <linux-kselftest+bounces-6475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D40588637E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 23:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B107A1C225AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 22:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042872FB6;
	Thu, 21 Mar 2024 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPIlOT3V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055617CD;
	Thu, 21 Mar 2024 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711061682; cv=none; b=ANBuT6w+cxaOy0QrQC0og3REYtfNGCuj8lJ5jjos56CF7yc0NXvIUZIa6oBV8PdC6RzpL5db4qV2WRyYoXhwOEP6/Lr91qakc0rqMO/37mbIkRP6OENnoAj/ZZbYax5zrEEiz7nvBFSYpXy45YwhLSpvOTehnQebhSOMoJtyljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711061682; c=relaxed/simple;
	bh=t5TEXfIMr1I/ad1wrhGzRX5+RmYvRfQT5//OK9rLC/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUvts6gWtJjrPIj8r7RvDlkw6g08KFmlyJWwaKtQQLDwLv6lpzQIVms4z7CDrnG5OCrg7TRDpNjtdUUFRA8Ba7HAWIP0TL5EiV5ioCtimn8nN82Zp3Fb5U/Hvw2uj23zzQ7fAXJLIxTC6E0iC/PwyJSbDh1uPbABOKz2IOJA0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPIlOT3V; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711061681; x=1742597681;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t5TEXfIMr1I/ad1wrhGzRX5+RmYvRfQT5//OK9rLC/k=;
  b=PPIlOT3VaX2qmqEXAiO33kHD/IUJX0yqF35KG0KEDQpH2ypqc7+ysMx6
   uuH7H8pGdMPah2i+muFCvu8uG4f713csiCKDyYaXrlsDMxLhd7+vm74UX
   U3fd7YrDxuZotlAlIgdT5diRa9AM+YQOxYtzOK0atLAWU3rk/kJJPu1IR
   cwkGOAX2flhipmkQgLuJQ4c1ypSghWQihYIb4+PpjNPJ+lroW/9LK6m61
   AbUEaCABZb1EBtOX5Fvz/aWL2VNMcx6YUtBmwaudxT2k1aK4HieRQVSFX
   TSo0t7kIJwL8RYm6wgVUa7KtNGs5PWMaECSDUhYZ1uEQ0q3Jia/6pRaAQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="17486121"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="17486121"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 15:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="14559782"
Received: from dongshen-mobl1.amr.corp.intel.com (HELO [10.212.116.150]) ([10.212.116.150])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 15:54:39 -0700
Message-ID: <3d69b44a-8542-4a11-b233-16487e980d54@intel.com>
Date: Thu, 21 Mar 2024 15:54:37 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 05/29] KVM: selftests: Add helper functions to
 create TDX VMs
To: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org,
 Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>,
 Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-6-sagis@google.com>
Content-Language: en-US
From: "Zhang, Dongsheng X" <dongsheng.x.zhang@intel.com>
In-Reply-To: <20231212204647.2170650-6-sagis@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/12/2023 12:46 PM, Sagi Shahar wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> TDX requires additional IOCTLs to initialize VM and vCPUs to add
> private memory and to finalize the VM memory. Also additional utility
> functions are provided to manipulate a TD, similar to those that
> manipulate a VM in the current selftest framework.
> 
> A TD's initial register state cannot be manipulated directly by
> setting the VM's memory, hence boot code is provided at the TD's reset
> vector. This boot code takes boot parameters loaded in the TD's memory
> and sets up the TD for the selftest.
> 
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   2 +
>  .../kvm/include/x86_64/tdx/td_boot.h          |  82 ++++
>  .../kvm/include/x86_64/tdx/td_boot_asm.h      |  16 +
>  .../kvm/include/x86_64/tdx/tdx_util.h         |  16 +
>  .../selftests/kvm/lib/x86_64/tdx/td_boot.S    | 101 ++++
>  .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   | 434 ++++++++++++++++++
>  6 files changed, 651 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/td_boot.h
>  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/td_boot_asm.h
>  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/td_boot.S
>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index b11ac221aba4..a35150ab855f 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -50,6 +50,8 @@ LIBKVM_x86_64 += lib/x86_64/svm.c
>  LIBKVM_x86_64 += lib/x86_64/ucall.c
>  LIBKVM_x86_64 += lib/x86_64/vmx.c
>  LIBKVM_x86_64 += lib/x86_64/sev.c
> +LIBKVM_x86_64 += lib/x86_64/tdx/tdx_util.c
> +LIBKVM_x86_64 += lib/x86_64/tdx/td_boot.S
>  
>  LIBKVM_aarch64 += lib/aarch64/gic.c
>  LIBKVM_aarch64 += lib/aarch64/gic_v3.c
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/td_boot.h b/tools/testing/selftests/kvm/include/x86_64/tdx/td_boot.h
> new file mode 100644
> index 000000000000..148057e569d6
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/td_boot.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_TDX_TD_BOOT_H
> +#define SELFTEST_TDX_TD_BOOT_H
> +
> +#include <stdint.h>
> +#include "tdx/td_boot_asm.h"
> +
> +/*
> + * Layout for boot section (not to scale)
> + *
> + *                                  GPA
> + * ┌─────────────────────────────┬──0x1_0000_0000 (4GB)
> + * │   Boot code trampoline      │
> + * ├─────────────────────────────┼──0x0_ffff_fff0: Reset vector (16B below 4GB)
> + * │   Boot code                 │
> + * ├─────────────────────────────┼──td_boot will be copied here, so that the
> + * │                             │  jmp to td_boot is exactly at the reset vector
> + * │   Empty space               │
> + * │                             │
> + * ├─────────────────────────────┤
> + * │                             │
> + * │                             │
> + * │   Boot parameters           │
> + * │                             │
> + * │                             │
> + * └─────────────────────────────┴──0x0_ffff_0000: TD_BOOT_PARAMETERS_GPA
> + */
> +#define FOUR_GIGABYTES_GPA (4ULL << 30)
> +
> +/**
> + * The exact memory layout for LGDT or LIDT instructions.
> + */
> +struct __packed td_boot_parameters_dtr {
> +	uint16_t limit;
> +	uint32_t base;
> +};
> +
> +/**
> + * The exact layout in memory required for a ljmp, including the selector for
> + * changing code segment.
> + */
> +struct __packed td_boot_parameters_ljmp_target {
> +	uint32_t eip_gva;
> +	uint16_t code64_sel;
> +};
> +
> +/**
> + * Allows each vCPU to be initialized with different eip and esp.
> + */
> +struct __packed td_per_vcpu_parameters {
> +	uint32_t esp_gva;
> +	struct td_boot_parameters_ljmp_target ljmp_target;
> +};
> +
> +/**
> + * Boot parameters for the TD.
> + *
> + * Unlike a regular VM, we can't ask KVM to set registers such as esp, eip, etc
> + * before boot, so to run selftests, these registers' values have to be
> + * initialized by the TD.
> + *
> + * This struct is loaded in TD private memory at TD_BOOT_PARAMETERS_GPA.
> + *
> + * The TD boot code will read off parameters from this struct and set up the
> + * vcpu for executing selftests.
> + */
> +struct __packed td_boot_parameters {
> +	uint32_t cr0;
> +	uint32_t cr3;
> +	uint32_t cr4;
> +	struct td_boot_parameters_dtr gdtr;
> +	struct td_boot_parameters_dtr idtr;
> +	struct td_per_vcpu_parameters per_vcpu[];
> +};
> +
> +extern void td_boot(void);
> +extern void reset_vector(void);
> +extern void td_boot_code_end(void);
> +
> +#define TD_BOOT_CODE_SIZE (td_boot_code_end - td_boot)
> +
> +#endif /* SELFTEST_TDX_TD_BOOT_H */
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/td_boot_asm.h b/tools/testing/selftests/kvm/include/x86_64/tdx/td_boot_asm.h
> new file mode 100644
> index 000000000000..0a07104f7deb
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/td_boot_asm.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_TDX_TD_BOOT_ASM_H
> +#define SELFTEST_TDX_TD_BOOT_ASM_H
> +
> +/*
> + * GPA where TD boot parameters wil lbe loaded.

Typo: "wil lbe" ==> "will be"
 
> + *
> + * TD_BOOT_PARAMETERS_GPA is arbitrarily chosen to
> + *
> + * + be within the 4GB address space
> + * + provide enough contiguous memory for the struct td_boot_parameters such
> + *   that there is one struct td_per_vcpu_parameters for KVM_MAX_VCPUS
> + */
> +#define TD_BOOT_PARAMETERS_GPA 0xffff0000
> +
> +#endif  // SELFTEST_TDX_TD_BOOT_ASM_H
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
> new file mode 100644
> index 000000000000..274b245f200b
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTESTS_TDX_KVM_UTIL_H
> +#define SELFTESTS_TDX_KVM_UTIL_H
> +
> +#include <stdint.h>
> +
> +#include "kvm_util_base.h"
> +
> +struct kvm_vcpu *td_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id, void *guest_code);
> +
> +struct kvm_vm *td_create(void);
> +void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
> +		   uint64_t attributes);
> +void td_finalize(struct kvm_vm *vm);
> +
> +#endif // SELFTESTS_TDX_KVM_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/td_boot.S b/tools/testing/selftests/kvm/lib/x86_64/tdx/td_boot.S
> new file mode 100644
> index 000000000000..800e09264d4e
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/td_boot.S
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include "tdx/td_boot_asm.h"
> +
> +/* Offsets for reading struct td_boot_parameters */
> +#define TD_BOOT_PARAMETERS_CR0         0
> +#define TD_BOOT_PARAMETERS_CR3         4
> +#define TD_BOOT_PARAMETERS_CR4         8
> +#define TD_BOOT_PARAMETERS_GDT         12
> +#define TD_BOOT_PARAMETERS_IDT         18
> +#define TD_BOOT_PARAMETERS_PER_VCPU    24
> +
> +/* Offsets for reading struct td_per_vcpu_parameters */
> +#define TD_PER_VCPU_PARAMETERS_ESP_GVA     0
> +#define TD_PER_VCPU_PARAMETERS_LJMP_TARGET 4
> +
> +#define SIZEOF_TD_PER_VCPU_PARAMETERS      10
> +
> +.code32
> +
> +.globl td_boot
> +td_boot:
> +	/* In this procedure, edi is used as a temporary register */
> +	cli
> +
> +	/* Paging is off */
> +
> +	movl $TD_BOOT_PARAMETERS_GPA, %ebx
> +
> +	/*
> +	 * Find the address of struct td_per_vcpu_parameters for this
> +	 * vCPU based on esi (TDX spec: initialized with vcpu id). Put
> +	 * struct address into register for indirect addressing
> +	 */
> +	movl $SIZEOF_TD_PER_VCPU_PARAMETERS, %eax
> +	mul %esi
> +	leal TD_BOOT_PARAMETERS_PER_VCPU(%ebx), %edi
> +	addl %edi, %eax
> +
> +	/* Setup stack */
> +	movl TD_PER_VCPU_PARAMETERS_ESP_GVA(%eax), %esp
> +
> +	/* Setup GDT */
> +	leal TD_BOOT_PARAMETERS_GDT(%ebx), %edi
> +	lgdt (%edi)
> +
> +	/* Setup IDT */
> +	leal TD_BOOT_PARAMETERS_IDT(%ebx), %edi
> +	lidt (%edi)
> +
> +	/*
> +	 * Set up control registers (There are no instructions to
> +	 * mov from memory to control registers, hence we need to use ebx
> +	 * as a scratch register)
> +	 */
> +	movl TD_BOOT_PARAMETERS_CR4(%ebx), %edi
> +	movl %edi, %cr4
> +	movl TD_BOOT_PARAMETERS_CR3(%ebx), %edi
> +	movl %edi, %cr3
> +	movl TD_BOOT_PARAMETERS_CR0(%ebx), %edi
> +	movl %edi, %cr0
> +
> +	/* Paging is on after setting the most significant bit on cr0 */
> +
> +	/*
> +	 * Jump to selftest guest code. Far jumps read <segment
> +	 * selector:new eip> from <addr+4:addr>. This location has
> +	 * already been set up in boot parameters, and we can read boot
> +	 * parameters because boot code and boot parameters are loaded so
> +	 * that GVA and GPA are mapped 1:1.
> +	 */
> +	ljmp *TD_PER_VCPU_PARAMETERS_LJMP_TARGET(%eax)
> +
> +.globl reset_vector
> +reset_vector:
> +	jmp td_boot
> +	/*
> +	 * Pad reset_vector to its full size of 16 bytes so that this
> +	 * can be loaded with the end of reset_vector aligned to GPA=4G
> +	 */
> +	int3
> +	int3
> +	int3
> +	int3
> +	int3
> +	int3
> +	int3
> +	int3
> +	int3
> +	int3
> +	int3
> +	int3
> +	int3
> +	int3
> +
> +/* Leave marker so size of td_boot code can be computed */
> +.globl td_boot_code_end
> +td_boot_code_end:
> +
> +/* Disable executable stack */
> +.section .note.GNU-stack,"",%progbits
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> new file mode 100644
> index 000000000000..9b69c733ce01
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> @@ -0,0 +1,434 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define _GNU_SOURCE
> +#include <asm/kvm.h>
> +#include <asm/kvm_host.h>
> +#include <errno.h>
> +#include <linux/kvm.h>
> +#include <stdint.h>
> +#include <sys/ioctl.h>
> +
> +#include "kvm_util.h"
> +#include "test_util.h"
> +#include "tdx/td_boot.h"
> +#include "kvm_util_base.h"
> +#include "processor.h"
> +
> +/*
> + * TDX ioctls
> + */
> +
> +static char *tdx_cmd_str[] = {
> +	"KVM_TDX_CAPABILITIES",
> +	"KVM_TDX_INIT_VM",
> +	"KVM_TDX_INIT_VCPU",
> +	"KVM_TDX_INIT_MEM_REGION",
> +	"KVM_TDX_FINALIZE_VM"
> +};
> +#define TDX_MAX_CMD_STR (ARRAY_SIZE(tdx_cmd_str))
> +
> +static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
> +{
> +	struct kvm_tdx_cmd tdx_cmd;
> +	int r;
> +
> +	TEST_ASSERT(ioctl_no < TDX_MAX_CMD_STR, "Unknown TDX CMD : %d\n",
> +		    ioctl_no);
> +
> +	memset(&tdx_cmd, 0x0, sizeof(tdx_cmd));
> +	tdx_cmd.id = ioctl_no;
> +	tdx_cmd.flags = flags;
> +	tdx_cmd.data = (uint64_t)data;
> +
> +	r = ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
> +	TEST_ASSERT(r == 0, "%s failed: %d  %d", tdx_cmd_str[ioctl_no], r,
> +		    errno);
> +}
> +
> +#define XFEATURE_MASK_CET (XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERNEL)
> +
> +static void tdx_apply_cpuid_restrictions(struct kvm_cpuid2 *cpuid_data)
> +{
> +	for (int i = 0; i < cpuid_data->nent; i++) {
> +		struct kvm_cpuid_entry2 *e = &cpuid_data->entries[i];
> +
> +		if (e->function == 0xd && e->index == 0) {
> +			/*
> +			 * TDX module requires both XTILE_{CFG, DATA} to be set.
> +			 * Both bits are required for AMX to be functional.
> +			 */
> +			if ((e->eax & XFEATURE_MASK_XTILE) !=
> +			    XFEATURE_MASK_XTILE) {
> +				e->eax &= ~XFEATURE_MASK_XTILE;
> +			}
> +		}
> +		if (e->function == 0xd && e->index == 1) {
> +			/*
> +			 * TDX doesn't support LBR yet.
> +			 * Disable bits from the XCR0 register.
> +			 */
> +			e->ecx &= ~XFEATURE_MASK_LBR;
> +			/*
> +			 * TDX modules requires both CET_{U, S} to be set even
> +			 * if only one is supported.
> +			 */
> +			if (e->ecx & XFEATURE_MASK_CET)
> +				e->ecx |= XFEATURE_MASK_CET;
> +		}
> +	}
> +}
> +
> +static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
> +{
> +	const struct kvm_cpuid2 *cpuid;
> +	struct kvm_tdx_init_vm *init_vm;
> +
> +	cpuid = kvm_get_supported_cpuid();
> +
> +	init_vm = malloc(sizeof(*init_vm) +
> +			 sizeof(init_vm->cpuid.entries[0]) * cpuid->nent);

Can add a sanity checking for init_vm here like the following:
TEST_ASSERT(init_vm, "vm allocation failed");

> +
> +	memset(init_vm, 0, sizeof(*init_vm));

Can use calloc instead:
init_vm = calloc(1, sizeof(*init_vm));
    
         
> +	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
> +
> +	init_vm->attributes = attributes;
> +
> +	tdx_apply_cpuid_restrictions(&init_vm->cpuid);
> +
> +	tdx_ioctl(vm->fd, KVM_TDX_INIT_VM, 0, init_vm);
> +}
> +
> +static void tdx_td_vcpu_init(struct kvm_vcpu *vcpu)
> +{
> +	const struct kvm_cpuid2 *cpuid = kvm_get_supported_cpuid();
> +
> +	vcpu_init_cpuid(vcpu, cpuid);
> +	tdx_ioctl(vcpu->fd, KVM_TDX_INIT_VCPU, 0, NULL);
> +}
> +
> +static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
> +				uint64_t gpa, uint64_t size)
> +{
> +	struct kvm_tdx_init_mem_region mem_region = {
> +		.source_addr = (uint64_t)source_pages,
> +		.gpa = gpa,
> +		.nr_pages = size / PAGE_SIZE,
> +	};
> +	uint32_t metadata = KVM_TDX_MEASURE_MEMORY_REGION;
> +
> +	TEST_ASSERT((mem_region.nr_pages > 0) &&
> +			    ((mem_region.nr_pages * PAGE_SIZE) == size),
> +		    "Cannot add partial pages to the guest memory.\n");
> +	TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) == 0,
> +		    "Source memory buffer is not page aligned\n");
> +	tdx_ioctl(vm->fd, KVM_TDX_INIT_MEM_REGION, metadata, &mem_region);
> +}
> +
> +static void tdx_td_finalizemr(struct kvm_vm *vm)
> +{
> +	tdx_ioctl(vm->fd, KVM_TDX_FINALIZE_VM, 0, NULL);
> +}
> +

Nit: tdx_td_finalizemr ==> tdx_td_finalize_mr

> +/*
> + * TD creation/setup/finalization
> + */
> +
> +static void tdx_enable_capabilities(struct kvm_vm *vm)
> +{
> +	int rc;
> +
> +	rc = kvm_check_cap(KVM_CAP_X2APIC_API);
> +	TEST_ASSERT(rc, "TDX: KVM_CAP_X2APIC_API is not supported!");
> +	rc = kvm_check_cap(KVM_CAP_SPLIT_IRQCHIP);
> +	TEST_ASSERT(rc, "TDX: KVM_CAP_SPLIT_IRQCHIP is not supported!");
> +
> +	vm_enable_cap(vm, KVM_CAP_X2APIC_API,
> +		      KVM_X2APIC_API_USE_32BIT_IDS |
> +			      KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK);
> +	vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
> +}
> +
> +static void tdx_configure_memory_encryption(struct kvm_vm *vm)
> +{
> +	/* Configure shared/enCrypted bit for this VM according to TDX spec */
> +	vm->arch.s_bit = 1ULL << (vm->pa_bits - 1);
> +	vm->arch.c_bit = 0;
> +	/* Set gpa_protected_mask so that tagging/untagging of GPAs works */
> +	vm->gpa_protected_mask = vm->arch.s_bit;
> +	/* This VM is protected (has memory encryption) */
> +	vm->protected = true;
> +}
> +
> +static void tdx_apply_cr4_restrictions(struct kvm_sregs *sregs)
> +{
> +	/* TDX spec 11.6.2: CR4 bit MCE is fixed to 1 */
> +	sregs->cr4 |= X86_CR4_MCE;
> +
> +	/* Set this because UEFI also sets this up, to handle XMM exceptions */
> +	sregs->cr4 |= X86_CR4_OSXMMEXCPT;
> +
> +	/* TDX spec 11.6.2: CR4 bit VMXE and SMXE are fixed to 0 */
> +	sregs->cr4 &= ~(X86_CR4_VMXE | X86_CR4_SMXE);
> +}
> +
> +static void load_td_boot_code(struct kvm_vm *vm)
> +{
> +	void *boot_code_hva = addr_gpa2hva(vm, FOUR_GIGABYTES_GPA - TD_BOOT_CODE_SIZE);
> +
> +	TEST_ASSERT(td_boot_code_end - reset_vector == 16,
> +		"The reset vector must be 16 bytes in size.");
> +	memcpy(boot_code_hva, td_boot, TD_BOOT_CODE_SIZE);
> +}
> +
> +static void load_td_per_vcpu_parameters(struct td_boot_parameters *params,
> +					struct kvm_sregs *sregs,
> +					struct kvm_vcpu *vcpu,
> +					void *guest_code)
> +{
> +	/* Store vcpu_index to match what the TDX module would store internally */
> +	static uint32_t vcpu_index;
> +
> +	struct td_per_vcpu_parameters *vcpu_params = &params->per_vcpu[vcpu_index];

I think we can use vcpu->id in place of vcpu_index in this function, thus removing vcpu_index

> +
> +	TEST_ASSERT(vcpu->initial_stack_addr != 0,
> +		"initial stack address should not be 0");
> +	TEST_ASSERT(vcpu->initial_stack_addr <= 0xffffffff,
> +		"initial stack address must fit in 32 bits");
> +	TEST_ASSERT((uint64_t)guest_code <= 0xffffffff,
> +		"guest_code must fit in 32 bits");
> +	TEST_ASSERT(sregs->cs.selector != 0, "cs.selector should not be 0");
> +
> +	vcpu_params->esp_gva = (uint32_t)(uint64_t)vcpu->initial_stack_addr;
> +	vcpu_params->ljmp_target.eip_gva = (uint32_t)(uint64_t)guest_code;
> +	vcpu_params->ljmp_target.code64_sel = sregs->cs.selector;
> +
> +	vcpu_index++;
> +}
> +
> +static void load_td_common_parameters(struct td_boot_parameters *params,
> +				struct kvm_sregs *sregs)
> +{
> +	/* Set parameters! */
> +	params->cr0 = sregs->cr0;
> +	params->cr3 = sregs->cr3;
> +	params->cr4 = sregs->cr4;
> +	params->gdtr.limit = sregs->gdt.limit;
> +	params->gdtr.base = sregs->gdt.base;
> +	params->idtr.limit = sregs->idt.limit;
> +	params->idtr.base = sregs->idt.base;
> +
> +	TEST_ASSERT(params->cr0 != 0, "cr0 should not be 0");
> +	TEST_ASSERT(params->cr3 != 0, "cr3 should not be 0");
> +	TEST_ASSERT(params->cr4 != 0, "cr4 should not be 0");
> +	TEST_ASSERT(params->gdtr.base != 0, "gdt base address should not be 0");
> +}
> +
> +static void load_td_boot_parameters(struct td_boot_parameters *params,
> +				struct kvm_vcpu *vcpu, void *guest_code)
> +{
> +	struct kvm_sregs sregs;
> +
> +	/* Assemble parameters in sregs */
> +	memset(&sregs, 0, sizeof(struct kvm_sregs));
> +	vcpu_setup_mode_sregs(vcpu->vm, &sregs);
> +	tdx_apply_cr4_restrictions(&sregs);
> +	kvm_setup_idt(vcpu->vm, &sregs.idt);
> +
> +	if (!params->cr0)
> +		load_td_common_parameters(params, &sregs);
> +
> +	load_td_per_vcpu_parameters(params, &sregs, vcpu, guest_code);
> +}
> +
> +/**
> + * Adds a vCPU to a TD (Trusted Domain) with minimum defaults. It will not set
> + * up any general purpose registers as they will be initialized by the TDX. In
> + * TDX, vCPUs RIP is set to 0xFFFFFFF0. See Intel TDX EAS Section "Initial State
> + * of Guest GPRs" for more information on vCPUs initial register values when
> + * entering the TD first time.
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vcpuid - The id of the VCPU to add to the VM.
> + */
> +struct kvm_vcpu *td_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id, void *guest_code)
> +{
> +	struct kvm_vcpu *vcpu;
> +
> +	/*
> +	 * TD setup will not use the value of rip set in vm_vcpu_add anyway, so
> +	 * NULL can be used for guest_code.
> +	 */
> +	vcpu = vm_vcpu_add(vm, vcpu_id, NULL);
> +
> +	tdx_td_vcpu_init(vcpu);
> +
> +	load_td_boot_parameters(addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA),
> +				vcpu, guest_code);
> +
> +	return vcpu;
> +}
> +
> +/**
> + * Iterate over set ranges within sparsebit @s. In each iteration,
> + * @range_begin and @range_end will take the beginning and end of the set range,
> + * which are of type sparsebit_idx_t.
> + *
> + * For example, if the range [3, 7] (inclusive) is set, within the iteration,
> + * @range_begin will take the value 3 and @range_end will take the value 7.
> + *
> + * Ensure that there is at least one bit set before using this macro with
> + * sparsebit_any_set(), because sparsebit_first_set() will abort if none are
> + * set.
> + */
> +#define sparsebit_for_each_set_range(s, range_begin, range_end)		\
> +	for (range_begin = sparsebit_first_set(s),			\
> +		     range_end = sparsebit_next_clear(s, range_begin) - 1; \
> +	     range_begin && range_end;					\
> +	     range_begin = sparsebit_next_set(s, range_end),		\
> +		     range_end = sparsebit_next_clear(s, range_begin) - 1)
> +/*
> + * sparsebit_next_clear() can return 0 if [x, 2**64-1] are all set, and the -1
> + * would then cause an underflow back to 2**64 - 1. This is expected and
> + * correct.
> + *
> + * If the last range in the sparsebit is [x, y] and we try to iterate,
> + * sparsebit_next_set() will return 0, and sparsebit_next_clear() will try and
> + * find the first range, but that's correct because the condition expression
> + * would cause us to quit the loop.
> + */
> +
> +static void load_td_memory_region(struct kvm_vm *vm,
> +				  struct userspace_mem_region *region)
> +{
> +	const struct sparsebit *pages = region->protected_phy_pages;
> +	const uint64_t hva_base = region->region.userspace_addr;
> +	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
> +	const sparsebit_idx_t lowest_page_in_region = gpa_base >>
> +						      vm->page_shift;
> +
> +	sparsebit_idx_t i;
> +	sparsebit_idx_t j;
> +
> +	if (!sparsebit_any_set(pages))
> +		return;
> +
> +	sparsebit_for_each_set_range(pages, i, j) {
> +		const uint64_t size_to_load = (j - i + 1) * vm->page_size;
> +		const uint64_t offset =
> +			(i - lowest_page_in_region) * vm->page_size;
> +		const uint64_t hva = hva_base + offset;
> +		const uint64_t gpa = gpa_base + offset;
> +		void *source_addr;
> +
> +		/*
> +		 * KVM_TDX_INIT_MEM_REGION ioctl cannot encrypt memory in place,
> +		 * hence we have to make a copy if there's only one backing
> +		 * memory source
> +		 */
> +		source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
> +				   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +		TEST_ASSERT(
> +			source_addr,
> +			"Could not allocate memory for loading memory region");
> +
> +		memcpy(source_addr, (void *)hva, size_to_load);
> +
> +		tdx_init_mem_region(vm, source_addr, gpa, size_to_load);
> +
> +		munmap(source_addr, size_to_load);
> +	}
> +}
> +
> +static void load_td_private_memory(struct kvm_vm *vm)
> +{
> +	int ctr;
> +	struct userspace_mem_region *region;
> +
> +	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
> +		load_td_memory_region(vm, region);
> +	}
> +}
> +
> +struct kvm_vm *td_create(void)
> +{
> +	struct vm_shape shape;
> +
> +	shape.mode = VM_MODE_DEFAULT;
> +	shape.type = KVM_X86_TDX_VM;
> +	return ____vm_create(shape);

Nit:
init shape to 0s:
struct vm_shape shape = {};

Pass pointer of share to ____vm_create() instead:
____vm_create(&shape)

> +}
> +
> +static void td_setup_boot_code(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type)
> +{
> +	vm_vaddr_t addr;
> +	size_t boot_code_allocation = round_up(TD_BOOT_CODE_SIZE, PAGE_SIZE);
> +	vm_paddr_t boot_code_base_gpa = FOUR_GIGABYTES_GPA - boot_code_allocation;
> +	size_t npages = DIV_ROUND_UP(boot_code_allocation, PAGE_SIZE);
> +
> +	vm_userspace_mem_region_add(vm, src_type, boot_code_base_gpa, 1, npages,
> +				    KVM_MEM_PRIVATE);
> +	addr = vm_vaddr_alloc_1to1(vm, boot_code_allocation, boot_code_base_gpa, 1);
> +	TEST_ASSERT_EQ(addr, boot_code_base_gpa);
> +
> +	load_td_boot_code(vm);
> +}
> +
> +static size_t td_boot_parameters_size(void)
> +{
> +	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
> +	size_t total_per_vcpu_parameters_size =
> +		max_vcpus * sizeof(struct td_per_vcpu_parameters);
> +
> +	return sizeof(struct td_boot_parameters) + total_per_vcpu_parameters_size;
> +}
> +
> +static void td_setup_boot_parameters(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type)
> +{
> +	vm_vaddr_t addr;
> +	size_t boot_params_size = td_boot_parameters_size();
> +	int npages = DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
> +	size_t total_size = npages * PAGE_SIZE;
> +
> +	vm_userspace_mem_region_add(vm, src_type, TD_BOOT_PARAMETERS_GPA, 2,
> +				    npages, KVM_MEM_PRIVATE);
> +	addr = vm_vaddr_alloc_1to1(vm, total_size, TD_BOOT_PARAMETERS_GPA, 2);
> +	TEST_ASSERT_EQ(addr, TD_BOOT_PARAMETERS_GPA);
> +}
> +
> +void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
> +		   uint64_t attributes)
> +{
> +	uint64_t nr_pages_required;
> +
> +	tdx_enable_capabilities(vm);
> +
> +	tdx_configure_memory_encryption(vm);
> +
> +	tdx_td_init(vm, attributes);
> +
> +	nr_pages_required = vm_nr_pages_required(VM_MODE_DEFAULT, 1, 0);
> +
> +	/*
> +	 * Add memory (add 0th memslot) for TD. This will be used to setup the
> +	 * CPU (provide stack space for the CPU) and to load the elf file.
> +	 */
> +	vm_userspace_mem_region_add(vm, src_type, 0, 0, nr_pages_required,
> +				    KVM_MEM_PRIVATE);
> +
> +	kvm_vm_elf_load(vm, program_invocation_name);
> +
> +	vm_init_descriptor_tables(vm);
> +
> +	td_setup_boot_code(vm, src_type);
> +	td_setup_boot_parameters(vm, src_type);
> +}
> +
> +void td_finalize(struct kvm_vm *vm)
> +{
> +	sync_exception_handlers_to_guest(vm);
> +
> +	load_td_private_memory(vm);
> +
> +	tdx_td_finalizemr(vm);
> +}

