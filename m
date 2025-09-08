Return-Path: <linux-kselftest+bounces-40921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F30B484F0
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 09:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DEC1B206CF
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 07:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42132E427C;
	Mon,  8 Sep 2025 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8DUp3jn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395813B2A4;
	Mon,  8 Sep 2025 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315964; cv=none; b=d/dkSed3MCybWnfxLzl6C1VsJVJvWL3TMMDk+BHMYHaHtDh5dlywKT9gJL3qWQPMfgVBtJ2JEO3r36Qn1ojLevyOmf7hcvkmyH05OI0od9R0jHIfB/K5InTeqC359xwtGuo/xqSOkAHv2Pa/rjH+yvv2oabcNAX3Edlo+yHcn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315964; c=relaxed/simple;
	bh=AHJgtSvk6J/owlbSxHpduLOtr7mfHnXiYwmWjmH+VVg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bhuXx615q5F+SDPOaIHP3n+AOLkrWD4W7A9Hpdm8VqNgsxeOgZQhHyIWlA6tbcHP6rIJ2Lj8keiHT1ue3mRtO6hYncCqtTOgY1tnYSbcUfqJxbYJd/A4oEGzHjPVJR4Wh4wGXzUuIjcEETwys0toj0gtP9q1HGxlKuK1Ldce6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8DUp3jn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757315962; x=1788851962;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=AHJgtSvk6J/owlbSxHpduLOtr7mfHnXiYwmWjmH+VVg=;
  b=W8DUp3jnn+uV/AVuhppUiv9fcD5G1W0jb/AxO5Jsq7OgQNHxbtG/qT0Z
   RVt1uZ6ZG+TxHPmGTTHKUAsMPTCLiXc6RHyw1EoeYnRwsoHfyvwL434RT
   Vy6Euh5ax5RNtElicn9YhGZe3H5GCRNES6uB6qaVl0gh3+H/+1OlgdJzq
   asDrPcEnaebvxJtYvXCgHbLUlaET+YSegK0B8kgrWM7CsfVyVo5bOhRy7
   nqd/aHIo/NuUwEa/5zzRoN9uHJG0rB7+usAG6SlCgJS6j7m6Bf/BmUiNs
   ddIYGa4EwqZeMccJalc1CU/xiPx6N+M1wUB6FQKsNmjZfr4K5nQxRx9Gz
   A==;
X-CSE-ConnectionGUID: GLZTz0QHT9SGDdlyIuwa4g==
X-CSE-MsgGUID: 8Mfsj75ORW+zZt18p+ej/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="69819260"
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="69819260"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 00:19:20 -0700
X-CSE-ConnectionGUID: 6bGxR7fLSmeljIMsyYxj7w==
X-CSE-MsgGUID: X9doTonrS7SR4ptR+DnP+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="172282934"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 00:19:16 -0700
Message-ID: <d6bd0dc3-7309-473f-b763-47c6b534bb56@linux.intel.com>
Date: Mon, 8 Sep 2025 15:19:13 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v10 07/21] KVM: selftests: Define structs to pass
 parameters to TDX boot code
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny
 <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
References: <20250904065453.639610-1-sagis@google.com>
 <20250904065453.639610-8-sagis@google.com>
Content-Language: en-US
In-Reply-To: <20250904065453.639610-8-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/4/2025 2:54 PM, Sagi Shahar wrote:
> TDX registers are inaccesible to KVM. Therefore we need a different

inaccesible -> inaccessible


> mechanism to load boot parameters for TDX code. TDX boot code will read
> the registers values from memory and set the registers manually.
>
> This patch defines the data structures used to communicate between c
> code and the TDX assembly boot code which will be added in a later
> patch.
>
> Use kbuild.h to expose the offsets into the structs from c code to
> assembly code.
>
> Co-developed-by: Ackerley Tng<ackerleytng@google.com>
> Signed-off-by: Ackerley Tng<ackerleytng@google.com>
> Signed-off-by: Sagi Shahar<sagis@google.com>

One typo above and one nit comment below.

Otherwise,
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>   tools/testing/selftests/kvm/Makefile.kvm      | 18 +++++
>   .../selftests/kvm/include/x86/tdx/td_boot.h   | 69 +++++++++++++++++++
>   .../kvm/lib/x86/tdx/td_boot_offsets.c         | 21 ++++++
>   3 files changed, 108 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
>   create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 41b40c676d7f..3f93c093b046 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -19,6 +19,8 @@ LIBKVM += lib/userfaultfd_util.c
>   
>   LIBKVM_STRING += lib/string_override.c
>   
> +LIBKVM_ASM_DEFS += lib/x86/tdx/td_boot_offsets.c
> +
>   LIBKVM_x86 += lib/x86/apic.c
>   LIBKVM_x86 += lib/x86/handlers.S
>   LIBKVM_x86 += lib/x86/hyperv.c
> @@ -230,6 +232,10 @@ OVERRIDE_TARGETS = 1
>   include ../lib.mk
>   include ../cgroup/lib/libcgroup.mk
>   
> +# Enable Kbuild tools.
> +include $(top_srcdir)/scripts/Kbuild.include
> +include $(top_srcdir)/scripts/Makefile.lib
> +
>   INSTALL_HDR_PATH = $(top_srcdir)/usr
>   LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
>   LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
> @@ -282,6 +288,7 @@ LIBKVM_S := $(filter %.S,$(LIBKVM))
>   LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
>   LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
>   LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
> +LIBKVM_ASM_DEFS_OBJ += $(patsubst %.c, $(OUTPUT)/%.s, $(LIBKVM_ASM_DEFS))
>   LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) $(LIBCGROUP_O)
>   SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
>   SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(ARCH)/%.o, $(SPLIT_TESTS))
> @@ -308,6 +315,7 @@ $(SPLIT_TEST_GEN_OBJ): $(OUTPUT)/$(ARCH)/%.o: $(ARCH)/%.c
>   
>   EXTRA_CLEAN += $(GEN_HDRS) \
>   	       $(LIBKVM_OBJS) \
> +	       $(LIBKVM_ASM_DEFS_OBJ) \
>   	       $(SPLIT_TEST_GEN_OBJ) \
>   	       $(TEST_DEP_FILES) \
>   	       $(TEST_GEN_OBJ) \
> @@ -319,18 +327,28 @@ $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
>   $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
>   	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>   
> +$(LIBKVM_ASM_DEFS_OBJ): $(OUTPUT)/%.s: %.c FORCE
> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -S $< -o $@
> +
>   # Compile the string overrides as freestanding to prevent the compiler from
>   # generating self-referential code, e.g. without "freestanding" the compiler may
>   # "optimize" memcmp() by invoking memcmp(), thus causing infinite recursion.
>   $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>   	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
>   
> +$(OUTPUT)/include/x86/tdx/td_boot_offsets.h: $(OUTPUT)/lib/x86/tdx/td_boot_offsets.s FORCE
> +	$(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
> +
> +EXTRA_CLEAN += $(OUTPUT)/include/x86/tdx/td_boot_offsets.h
> +
>   $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
>   $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
>   $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
>   $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
>   $(TEST_GEN_OBJ): $(GEN_HDRS)
>   
> +FORCE:
> +
>   cscope: include_paths = $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) include lib ..
>   cscope:
>   	$(RM) cscope.*
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> new file mode 100644
> index 000000000000..8eda3ce10220
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_TDX_TD_BOOT_H
> +#define SELFTEST_TDX_TD_BOOT_H
> +
> +#include <stdint.h>
> +
> +#include <linux/compiler.h>
> +#include <linux/sizes.h>
> +
> +/*
> + * Layout for boot section (not to scale)
> + *
> + *                                   GPA
> + * _________________________________ 0x1_0000_0000 (4GB)
> + * |   Boot code trampoline    |
> + * |___________________________|____ 0x0_ffff_fff0: Reset vector (16B below 4GB)
> + * |   Boot code               |
> + * |___________________________|____ td_boot will be copied here, so that the
> + * |                           |     jmp to td_boot is exactly at the reset vector
> + * |   Empty space             |
> + * |                           |
> + * |───────────────────────────|
> + * |                           |
> + * |                           |
> + * |   Boot parameters         |
> + * |                           |
> + * |                           |
> + * |___________________________|____ 0x0_ffff_0000: TD_BOOT_PARAMETERS_GPA
> + */
> +#define FOUR_GIGABYTES_GPA (SZ_4G)
> +
> +/*
> + * The exact memory layout for LGDT or LIDT instructions.
> + */
> +struct __packed td_boot_parameters_dtr {
> +	uint16_t limit;
> +	uint32_t base;
> +};
> +
> +/*
> + * Allows each vCPU to be initialized with different eip and esp.
Nit:
Since guest_code is 64bit and the value is used when the vCPU is in 64bit mode,
eip -> rip?

> + */
> +struct td_per_vcpu_parameters {
> +	uint32_t esp_gva;
> +	uint64_t guest_code;
> +};
> +
> +/*
> + * Boot parameters for the TD.
> + *
> + * Unlike a regular VM, KVM cannot set registers such as esp, eip, etc
> + * before boot, so to run selftests, these registers' values have to be
> + * initialized by the TD.
> + *
> + * This struct is loaded in TD private memory at TD_BOOT_PARAMETERS_GPA.
> + *
> + * The TD boot code will read off parameters from this struct and set up the
> + * vCPU for executing selftests.
> + */
> +struct td_boot_parameters {
> +	uint32_t cr0;
> +	uint32_t cr3;
> +	uint32_t cr4;
> +	struct td_boot_parameters_dtr gdtr;
> +	struct td_boot_parameters_dtr idtr;
> +	struct td_per_vcpu_parameters per_vcpu[];
> +};
> +
> +#endif /* SELFTEST_TDX_TD_BOOT_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
> new file mode 100644
> index 000000000000..7f76a3585b99
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define COMPILE_OFFSETS
> +
> +#include <linux/kbuild.h>
> +
> +#include "tdx/td_boot.h"
> +
> +static void __attribute__((used)) common(void)
> +{
> +	OFFSET(TD_BOOT_PARAMETERS_CR0, td_boot_parameters, cr0);
> +	OFFSET(TD_BOOT_PARAMETERS_CR3, td_boot_parameters, cr3);
> +	OFFSET(TD_BOOT_PARAMETERS_CR4, td_boot_parameters, cr4);
> +	OFFSET(TD_BOOT_PARAMETERS_GDT, td_boot_parameters, gdtr);
> +	OFFSET(TD_BOOT_PARAMETERS_IDT, td_boot_parameters, idtr);
> +	OFFSET(TD_BOOT_PARAMETERS_PER_VCPU, td_boot_parameters, per_vcpu);
> +	OFFSET(TD_PER_VCPU_PARAMETERS_ESP_GVA, td_per_vcpu_parameters, esp_gva);
> +	OFFSET(TD_PER_VCPU_PARAMETERS_GUEST_CODE, td_per_vcpu_parameters,
> +	       guest_code);
> +	DEFINE(SIZEOF_TD_PER_VCPU_PARAMETERS,
> +	       sizeof(struct td_per_vcpu_parameters));
> +}


