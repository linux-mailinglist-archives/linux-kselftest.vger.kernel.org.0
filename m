Return-Path: <linux-kselftest+bounces-40923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FD3B485DC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 09:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DE4166508
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 07:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0552EA75A;
	Mon,  8 Sep 2025 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLE8PUSP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39862EAB60;
	Mon,  8 Sep 2025 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317159; cv=none; b=BhNCUdW0LLsniZDU1Q4bMG2b4jyl6Zr42Fc17t2FtbEp+PC9KTb9UcySWuyVA7yNgqAlLxUE4qOzMkaTtuznLedLfLNt4wq2VmWSFoctvMFHtAUNajreq1GgrQK8yRlY44JMPgKV9ukNMl8CE5+pG93QsLR59ya9bc1r/xpZ178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317159; c=relaxed/simple;
	bh=vvDisUrzXniDZ2UuL2xPxozwkB5ElxDwixP1w5ErZq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNrGo5e0HuVO1Q3vxPLu2cJsSWOA/4QbPiILdn4z6Eg1xBpFKSN7I3Btc847tIrW6PrX4VGiZlqJ8H7gVRA6twcCO0sih/jzg5iobgDtzk5lLauwUGWXKbZoAB60o+jTrWCo7gMfuOEPJQvWmPQXlq1940nO+HR/8nu0SRmiHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLE8PUSP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757317158; x=1788853158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vvDisUrzXniDZ2UuL2xPxozwkB5ElxDwixP1w5ErZq4=;
  b=CLE8PUSPNh12WqbOGBjq3MXVYIrGQ3hiLuo7J7O6vgpfuFj8mi52uGkW
   Jmpp8Pn2hFVzAfWgSr4IFftKjrXr1zqsDwkqZdfjWJans1DTRQ8cvDgf8
   m6MOI/SGwo3hSoYrm+p0sMbWxPNnxtAlqVMB4weNr77aSehJwCSJGKJxD
   PGvlXsBp3yHriH4pXqbawackV295XBUkluqy4i58O60o2KVTCBZUq8Wuy
   DWVIpzpU0fU9muhM1xfE6Kf++e9LRf8Pr4WmTt+AuZ8CA1ClPP11+Vhuz
   9IdbExEaoTBIwppeGb16MZwu7Nl/g5lhxh03z/8o88iaHDBYjpLx5wqqn
   g==;
X-CSE-ConnectionGUID: JX6rcWBISLONsMHSxkD/2A==
X-CSE-MsgGUID: iQmETyLEQnCuNfjZFnSHnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63396031"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63396031"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 00:39:15 -0700
X-CSE-ConnectionGUID: JW2M+b+3T1imC2mICNTArw==
X-CSE-MsgGUID: DIB4J4uWSXigkWJrWgocQw==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 00:39:10 -0700
Message-ID: <abbf92ae-3d43-4297-a4be-6f383e10bfa0@linux.intel.com>
Date: Mon, 8 Sep 2025 15:39:08 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/21] KVM: selftests: Set up TDX boot code region
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
 <20250904065453.639610-10-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250904065453.639610-10-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/2025 2:54 PM, Sagi Shahar wrote:
> Add memory for TDX boot code in a separate memslot.
>
> Use virt_map() to get identity map in this memory region to allow for
> seamless transition from paging disabled to paging enabled code.
>
> Copy the boot code into the memory region and set up the reset vectors

vectors -> vector?

> at this point. While it's possible to separate the memory allocation and
> boot code initialization into separate functions, having all the
> calculations for memory size and offsets in one place simplifies the
> code and avoids duplications.
>
> Handcode the reset vector as suggested by Sean Christopherson.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>   tools/testing/selftests/kvm/Makefile.kvm      |  1 +
>   .../selftests/kvm/include/x86/tdx/tdx_util.h  |  2 +
>   .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 54 +++++++++++++++++++
>   3 files changed, 57 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index d11d02e17cc5..52c90f1c0484 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -31,6 +31,7 @@ LIBKVM_x86 += lib/x86/sev.c
>   LIBKVM_x86 += lib/x86/svm.c
>   LIBKVM_x86 += lib/x86/ucall.c
>   LIBKVM_x86 += lib/x86/vmx.c
> +LIBKVM_x86 += lib/x86/tdx/tdx_util.c
>   LIBKVM_x86 += lib/x86/tdx/td_boot.S
>   
>   LIBKVM_arm64 += lib/arm64/gic.c
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index 286d5e3c24b1..ec05bcd59145 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -11,4 +11,6 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>   	return vm->type == KVM_X86_TDX_VM;
>   }
>   
> +void vm_tdx_setup_boot_code_region(struct kvm_vm *vm);
> +
>   #endif // SELFTESTS_TDX_TDX_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> new file mode 100644
> index 000000000000..a1cf12de9d56
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <stdint.h>
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "tdx/td_boot.h"
> +#include "tdx/tdx_util.h"
> +
> +/* Arbitrarily selected to avoid overlaps with anything else */
> +#define TD_BOOT_CODE_SLOT	20
> +
> +#define X86_RESET_VECTOR	0xfffffff0ul
> +#define X86_RESET_VECTOR_SIZE	16
> +
> +void vm_tdx_setup_boot_code_region(struct kvm_vm *vm)
> +{
> +	size_t total_code_size = TD_BOOT_CODE_SIZE + X86_RESET_VECTOR_SIZE;
> +	vm_paddr_t boot_code_gpa = X86_RESET_VECTOR - TD_BOOT_CODE_SIZE;
> +	vm_paddr_t alloc_gpa = round_down(boot_code_gpa, PAGE_SIZE);
> +	size_t nr_pages = DIV_ROUND_UP(total_code_size, PAGE_SIZE);
> +	vm_paddr_t gpa;
> +	uint8_t *hva;
> +
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> +				    alloc_gpa,
> +				    TD_BOOT_CODE_SLOT, nr_pages,
> +				    KVM_MEM_GUEST_MEMFD);
> +
> +	gpa = vm_phy_pages_alloc(vm, nr_pages, alloc_gpa, TD_BOOT_CODE_SLOT);
> +	TEST_ASSERT(gpa == alloc_gpa, "Failed vm_phy_pages_alloc\n");
> +
> +	virt_map(vm, alloc_gpa, alloc_gpa, nr_pages);
> +	hva = addr_gpa2hva(vm, boot_code_gpa);
> +	memcpy(hva, td_boot, TD_BOOT_CODE_SIZE);
> +
> +	hva += TD_BOOT_CODE_SIZE;
> +	TEST_ASSERT(hva == addr_gpa2hva(vm, X86_RESET_VECTOR),
> +		    "Expected RESET vector at hva 0x%lx, got %lx",
> +		    (unsigned long)addr_gpa2hva(vm, X86_RESET_VECTOR), (unsigned long)hva);
> +
> +	/*
> +	 * Handcode "JMP rel8" at the RESET vector to jump back to the TD boot
> +	 * code, as there are only 16 bytes at the RESET vector before RIP will
> +	 * wrap back to zero.  Insert a trailing int3 so that the vCPU crashes
> +	 * in case the JMP somehow falls through.  Note!  The target address is
> +	 * relative to the end of the instruction!
> +	 */
> +	TEST_ASSERT(TD_BOOT_CODE_SIZE + 2 <= 128,
> +		    "TD boot code not addressable by 'JMP rel8'");
> +	hva[0] = 0xeb;
> +	hva[1] = 256 - 2 - TD_BOOT_CODE_SIZE;
> +	hva[2] = 0xcc;
> +}


