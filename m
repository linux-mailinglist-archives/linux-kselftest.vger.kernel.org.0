Return-Path: <linux-kselftest+bounces-40922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30E9B4854F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 09:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A1A3A940D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B4C296BC8;
	Mon,  8 Sep 2025 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ec47b4dH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE06374D1;
	Mon,  8 Sep 2025 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316823; cv=none; b=FhM9YrH65kZ2QZefQU39uwuoVRfLXuGf5P5EChvaOgf6zdPXP8FjrNW2nPW7DNuZ9TQQD0Zca7kiG1DDeUZ/CTZtMievYNE0RkMDqRubv0hrn7PdWcyxShBVT2nWwiJJ0MIxfD4s9c9cd4aJVvLQMsNjWqkxX6gbJbHXi5J/zl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316823; c=relaxed/simple;
	bh=hAVybpA7H/anoeTQK8EGJDw5HRCYRiseoHk0IZr37l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/IXwvoEZ5AlNWnUzlt1+ydn+gqNNobID5gKykNX3MW/RNNYfrBDw8Tb1or8qsRmxDLc3bHE3/eoLYZORPWtZ3AAYcZqUBsCF72X3iUln4oiwgrSB1+n1Ko07Gce09KRe7Mr8yq0opk04xEO18P2FFE2hRZr6xbZs6lxPorsfJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ec47b4dH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757316821; x=1788852821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hAVybpA7H/anoeTQK8EGJDw5HRCYRiseoHk0IZr37l8=;
  b=Ec47b4dH2BmGsEGRlUgucyPQHXQvicqw1Ru6xCrRM08DRESUgo/EzVG6
   +ATOPWhJrmWb1SmwLXKOI62YA4XQl2L3IXQofSuz6LHdyHMKEq0DbyQkf
   4siHrZbLCvRkZKjT0N8QnqmdCOu7apWSRFAe4LVroNDW11teq23/Jit1L
   QFB/ua7+AYdEt1D3vIsmbyQw1lDzaYQ3NWs8cJaRDEjAmTM+aGA2hCksA
   fszqPOWCM84aX00pHg4powqPJPbCHqpFolYhLWyot7pD36t1g3s7wy33Q
   yckbytf66+j9+zaQR4f1WI5ZGCDbbyzkkDrkHhKKTVprKbDLlTUClQLLR
   A==;
X-CSE-ConnectionGUID: b/5jc/8ESYCBGB7KNN9NxA==
X-CSE-MsgGUID: qDJymgQ3Qd2XwW1Qz3Sv5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="58780321"
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="58780321"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 00:33:19 -0700
X-CSE-ConnectionGUID: 8ySfjysOQraQTtpHdtyifg==
X-CSE-MsgGUID: XmjGRSziRyes797oyNd4Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="177951390"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 00:33:08 -0700
Message-ID: <9232bfac-e3a3-49a1-a956-31e13e3ef6bf@linux.intel.com>
Date: Mon, 8 Sep 2025 15:33:05 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/21] KVM: selftests: Add TDX boot code
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
 <20250904065453.639610-9-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250904065453.639610-9-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/2025 2:54 PM, Sagi Shahar wrote:
> From: Erdem Aktas <erdemaktas@google.com>
>
> Add code to boot a TDX test VM. Since TDX registers are inaccesible to

inaccesible -> inaccessible

> KVM, the boot code loads the relevant values from memory into the
> registers before jumping to the guest code.
>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>   tools/testing/selftests/kvm/Makefile.kvm      |  3 +
>   .../selftests/kvm/include/x86/tdx/td_boot.h   |  5 ++
>   .../kvm/include/x86/tdx/td_boot_asm.h         | 16 +++++
>   .../selftests/kvm/lib/x86/tdx/td_boot.S       | 60 +++++++++++++++++++
>   4 files changed, 84 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
>   create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
>
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 3f93c093b046..d11d02e17cc5 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -31,6 +31,7 @@ LIBKVM_x86 += lib/x86/sev.c
>   LIBKVM_x86 += lib/x86/svm.c
>   LIBKVM_x86 += lib/x86/ucall.c
>   LIBKVM_x86 += lib/x86/vmx.c
> +LIBKVM_x86 += lib/x86/tdx/td_boot.S
>   
>   LIBKVM_arm64 += lib/arm64/gic.c
>   LIBKVM_arm64 += lib/arm64/gic_v3.c
> @@ -336,6 +337,8 @@ $(LIBKVM_ASM_DEFS_OBJ): $(OUTPUT)/%.s: %.c FORCE
>   $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>   	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
>   
> +$(OUTPUT)/lib/x86/tdx/td_boot.o: $(OUTPUT)/include/x86/tdx/td_boot_offsets.h
> +
>   $(OUTPUT)/include/x86/tdx/td_boot_offsets.h: $(OUTPUT)/lib/x86/tdx/td_boot_offsets.s FORCE
>   	$(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
>   
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> index 8eda3ce10220..17c3083da9ca 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
> @@ -66,4 +66,9 @@ struct td_boot_parameters {
>   	struct td_per_vcpu_parameters per_vcpu[];
>   };
>   
> +void td_boot(void);
> +void td_boot_code_end(void);
> +
> +#define TD_BOOT_CODE_SIZE (td_boot_code_end - td_boot)
> +
>   #endif /* SELFTEST_TDX_TD_BOOT_H */
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
> new file mode 100644
> index 000000000000..10b4b527595c
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_TDX_TD_BOOT_ASM_H
> +#define SELFTEST_TDX_TD_BOOT_ASM_H
> +
> +/*
> + * GPA where TD boot parameters will be loaded.
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
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
> new file mode 100644
> index 000000000000..7aa33caa9a78
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include "tdx/td_boot_asm.h"
> +#include "tdx/td_boot_offsets.h"
> +#include "processor_asm.h"
> +
> +.code32
> +
> +.globl td_boot
> +td_boot:
> +	/* In this procedure, edi is used as a temporary register. */
> +	cli
> +
> +	/* Paging is off. */
> +
> +	movl $TD_BOOT_PARAMETERS_GPA, %ebx
> +
> +	/*
> +	 * Find the address of struct td_per_vcpu_parameters for this
> +	 * vCPU based on esi (TDX spec: initialized with vCPU id). Put
> +	 * struct address into register for indirect addressing.
> +	 */
> +	movl $SIZEOF_TD_PER_VCPU_PARAMETERS, %eax
> +	mul %esi
> +	leal TD_BOOT_PARAMETERS_PER_VCPU(%ebx), %edi
> +	addl %edi, %eax
> +
> +	/* Setup stack. */
> +	movl TD_PER_VCPU_PARAMETERS_ESP_GVA(%eax), %esp
> +
> +	/* Setup GDT. */
> +	leal TD_BOOT_PARAMETERS_GDT(%ebx), %edi
> +	lgdt (%edi)
> +
> +	/* Setup IDT. */
> +	leal TD_BOOT_PARAMETERS_IDT(%ebx), %edi
> +	lidt (%edi)
> +
> +	/*
> +	 * Set up control registers (There are no instructions to mov from
> +	 * memory to control registers, hence use edi as a scratch register).
> +	 */
> +	movl TD_BOOT_PARAMETERS_CR4(%ebx), %edi
> +	movl %edi, %cr4
> +	movl TD_BOOT_PARAMETERS_CR3(%ebx), %edi
> +	movl %edi, %cr3
> +	movl TD_BOOT_PARAMETERS_CR0(%ebx), %edi
> +	movl %edi, %cr0
> +
> +	/* Switching to 64bit mode after ljmp and then jump to guest code */
> +	ljmp $(KERNEL_CS),$1f
> +1:
> +	jmp *TD_PER_VCPU_PARAMETERS_GUEST_CODE(%eax)
> +
> +/* Leave marker so size of td_boot code can be computed. */
> +.globl td_boot_code_end
> +td_boot_code_end:
> +
> +/* Disable executable stack. */
> +.section .note.GNU-stack,"",%progbits


