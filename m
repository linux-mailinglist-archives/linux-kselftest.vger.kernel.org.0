Return-Path: <linux-kselftest+bounces-39905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43580B35391
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 07:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542EB1B62FDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 05:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3002F1FC2;
	Tue, 26 Aug 2025 05:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihfwBdc3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614102F0688;
	Tue, 26 Aug 2025 05:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187506; cv=none; b=iPpeoFyMZgtw9pjxrJMvB74A/CuhiMZcitrY6eDpXLZe0iPw9sFh9x6S7hD4IIhpYN9+/SNNdqNxTdaOmJplG0xoYfsxV2bOYGG7cbXPEr/CDZVkrHHBgZWSoQuIkiD0kRpvBY64xE4RU1gGpSHnNePX3VlyWqDoK4hSl+Ca+8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187506; c=relaxed/simple;
	bh=S8YR0Rk1hMRnRkLxiltLd6vcjaOaMt81cEXJbL0+Kco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzib50mQI4CXQ+NzfnyKAwsEikyBjorb5nMI5MUh62FpVrGSW+VB0nciAft//Au/q+lpszUHbNQ+AavhtvcvojzAs69RChB96LEv59C5cTkPG/FJrP1yLxSgMnDc311uOiua4JkCPiES6tbbdlK6fyysfmXdI5a2lWa31HQTKRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihfwBdc3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756187505; x=1787723505;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S8YR0Rk1hMRnRkLxiltLd6vcjaOaMt81cEXJbL0+Kco=;
  b=ihfwBdc3R6J4AHReXNRv9S2FlTNMumtwVetsU83FsSicmH2JmMyZG0zY
   0bHytuEBji+eslypOPkCuelxu4PWCUkTBtmAyjx6RMcxSuNFu+SvFTXcM
   vqJ8+lsVSpnUUAiRFzUEjyajcn+gj7iuyLVQth7HTLCfwj18b6tGDvc3b
   vvM+Yf3/A2jplzcGTMQTkpa4OLfyxkvxZplGhwjo5e0uxr8P9Jzc7xEiP
   bGrkHOOoCWsfRoXLHuOg2+MNL0f8GfCmNXplJPDtB7JohqfKSNdzal1pL
   emsNxD9VVQtIvz5LZRonpr2FNj+pYtliL0sG9lMZFHnf6sDqxiI8VZz42
   w==;
X-CSE-ConnectionGUID: ahaMHbbISZeLWg8/xGZOJw==
X-CSE-MsgGUID: sYUNtaq0RwSV4lLqIpxMzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68682888"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68682888"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 22:51:44 -0700
X-CSE-ConnectionGUID: Wf7+/qZTRg+fabfNexeY9A==
X-CSE-MsgGUID: AD1qFAIuTnOnYpqmer9K4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="170312763"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 22:51:39 -0700
Message-ID: <176247c7-6801-4e06-860e-4a6b8e77ba20@linux.intel.com>
Date: Tue, 26 Aug 2025 13:51:36 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/19] KVM: selftests: Update
 kvm_init_vm_address_properties() for TDX
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
 kvm@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-6-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250821042915.3712925-6-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/2025 12:28 PM, Sagi Shahar wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Let kvm_init_vm_address_properties() initialize vm->arch.{s_bit, tag_mask}
> similar to SEV.
>
> TDX sets the shared bit based on the guest physical address width and
> currently supports 48 and 52 widths.
>
> Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/include/x86/tdx/tdx_util.h       | 14 ++++++++++++++
>   tools/testing/selftests/kvm/lib/x86/processor.c    | 12 ++++++++++--
>   2 files changed, 24 insertions(+), 2 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
>
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> new file mode 100644
> index 000000000000..286d5e3c24b1
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTESTS_TDX_TDX_UTIL_H
> +#define SELFTESTS_TDX_TDX_UTIL_H
> +
> +#include <stdbool.h>
> +
> +#include "kvm_util.h"
> +
> +static inline bool is_tdx_vm(struct kvm_vm *vm)
> +{
> +	return vm->type == KVM_X86_TDX_VM;
> +}

If the branch "vm->type != KVM_X86_TDX_VM" in patch 04/19
is still needed, this helper could be added earlier and used instead of
open code.

> +
> +#endif // SELFTESTS_TDX_TDX_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 1eae92957456..6dbf40cbbc2a 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -8,6 +8,7 @@
>   #include "kvm_util.h"
>   #include "processor.h"
>   #include "sev.h"
> +#include "tdx/tdx_util.h"
>   
>   #ifndef NUM_INTERRUPTS
>   #define NUM_INTERRUPTS 256
> @@ -1190,12 +1191,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
>   
>   void kvm_init_vm_address_properties(struct kvm_vm *vm)
>   {
> +	uint32_t gpa_bits = kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY_ADDR);
> +
> +	vm->arch.sev_fd = -1;
> +
>   	if (is_sev_vm(vm)) {
>   		vm->arch.sev_fd = open_sev_dev_path_or_exit();
>   		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
>   		vm->gpa_tag_mask = vm->arch.c_bit;
> -	} else {
> -		vm->arch.sev_fd = -1;
> +	} else if (is_tdx_vm(vm)) {
> +		TEST_ASSERT(gpa_bits == 48 || gpa_bits == 52,
> +			    "TDX: bad X86_PROPERTY_GUEST_MAX_PHY_ADDR value: %u", gpa_bits);
> +		vm->arch.s_bit = 1ULL << (gpa_bits - 1);

Nit: Use BIT_ULL().

> +		vm->gpa_tag_mask = vm->arch.s_bit;
>   	}
>   }
>   


