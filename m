Return-Path: <linux-kselftest+bounces-40810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9770B44D44
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 07:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392323BA19B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 05:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DC528D82A;
	Fri,  5 Sep 2025 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRwfikYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98D728D8E8;
	Fri,  5 Sep 2025 05:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049591; cv=none; b=ICHWPxI7gEBz4O9fd0p6jJ6LIuIzuoLaSyLV16tmI+5lSL91ihNAi4uTyDWNTf3BSRrGymGHBfsreIMATeH4TktZqE4sAkrvx/KlAtlxVRyav812hO/OwzGKr20ifOb1Qv1WE7iK/whtM/hsAcIKei62ibmQIlS+LZ99n+EPgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049591; c=relaxed/simple;
	bh=j5sOyuZKyh/HWp7+7rk5nhLwxGNTgWGNr08IHfPCTqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9M7G6kkWM4HcB+TVHpqMKpRUPE9d22DEKf1iVR5JY/KxVG2AwjMzgd+uOf0jPeHqflsF+o9uA+xbtZZF6wY0fgszhNCCNpDwBk6sUS+QStMAHWAjkZs573O8n+lXt6z7AitgOsbIn0TbJ/G/EoZbRMzjjkq4HySDrrsDq3EeLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRwfikYB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757049590; x=1788585590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j5sOyuZKyh/HWp7+7rk5nhLwxGNTgWGNr08IHfPCTqY=;
  b=NRwfikYBMp7KXDLhTfbnH4EB9sywMV5gZzGuNKrYmoq19qGVZ8YbcoKv
   5lnvY5UlSwbnv4qD+ztyloCwwOxrmIrWp+ZXqzoChW3z4hbFFSeB2NOqE
   AEIVge6lV+5y8mQB0m+G94GNZ4wIOc7GDsXPzWaDuwT5ezg+M2nFwhgWK
   f4ss2nj0oXiq5OFszEJzyLbf6Lz/j1p9zUqyydzXcL40bXacwbLuI0ReA
   m46sUg66G+wIDPmd3onU3OJEOdeN14WNxYGO+Fjhqdh5qYqm9VzJxmDWe
   He/pc2IvkcGN9bfTXUon60yKLEuDlp40VdQM3f0WtsM7MQPcVBCm1+B7t
   w==;
X-CSE-ConnectionGUID: NArD58CVTKuu7pHTYHOlYg==
X-CSE-MsgGUID: IhrakSuARfaTu902Aw8WPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="84829394"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="84829394"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 22:19:49 -0700
X-CSE-ConnectionGUID: Yk5GqpLHSuCJXDnOvzBvGA==
X-CSE-MsgGUID: scbqSEOcT0KJbxSRSIhC3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="171296749"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 22:19:44 -0700
Message-ID: <84bccc75-6e5e-4c08-aba6-1d9219eacfaa@linux.intel.com>
Date: Fri, 5 Sep 2025 13:19:41 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/21] KVM: selftests: Update
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
References: <20250904065453.639610-1-sagis@google.com>
 <20250904065453.639610-5-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250904065453.639610-5-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/2025 2:54 PM, Sagi Shahar wrote:
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

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

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
> +
> +#endif // SELFTESTS_TDX_TDX_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 82369373e843..2a44831e0cc9 100644
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
> @@ -1160,12 +1161,19 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
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
> +		vm->arch.s_bit = BIT_ULL(gpa_bits - 1);
> +		vm->gpa_tag_mask = vm->arch.s_bit;
>   	}
>   }
>   


