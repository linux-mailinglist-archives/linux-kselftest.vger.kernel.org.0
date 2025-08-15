Return-Path: <linux-kselftest+bounces-39051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAC4B27897
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 07:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC975E4861
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 05:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1277729E0F7;
	Fri, 15 Aug 2025 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcHM5PiT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D862877C7;
	Fri, 15 Aug 2025 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236321; cv=none; b=MeiD0kvzcUgLBKX5qyUEcgRVSvn4OtuA7yhjS0pzNoiIoBuC4+N0SmIDClUW0sy2yJM8mFoW8UfAmIJ4NaiCulCPJu+gUJyqFK8NSxtzEwoAdNYNgdBNxxVFTT1z0GdCVoBtAoDET9c82q85rYi/MeKv79sLIl/EgWEIXoV/z9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236321; c=relaxed/simple;
	bh=TohMWBdcbYnEEUSw3DTmVLG9f0ly5WylwkYngG7FL6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saEwN6D/eJzus+bDHlcG881OF7euTCCdJVRiGeTgKS4fz/b5L2NaIaGHLVOxIFMqAosR/ftL2pjXDkzSklS6ENBY6UVkeV72lKcLAVddv2YWH4FBYgpDDS3xlEZRPXdukboMYKMOB9dALAQ8DS1GBohC1aV/0E/JxnkQI1sj168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcHM5PiT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755236321; x=1786772321;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TohMWBdcbYnEEUSw3DTmVLG9f0ly5WylwkYngG7FL6U=;
  b=LcHM5PiTa4olcbOpN+k2eOklE6/oIbg7jBoEL2aDtc98wOeF7iSfOqPM
   X1+wMebT4oMx0V+GnFTK3v7/kkuebOXv1MfavefsxAQtjXiRJXuXGlNKE
   8JlWRROZv2Fh/Bw9ywlVgyEWNQVyZC/woorbF3O+lq7al1uWk2XIIPt1N
   9+LWECco7jAiyVQxh8HHYn2UZYUT8jaGpzqygmd+NTWg+XP74TnctkXGi
   Pvs5kjpZjCrhUtJJuigg1gUP9/GtM0CGZEPpjAbE7SfchUqwc/7LGxZwd
   HIPE5Qa4y+f4aSy+DcWb8Hqww8qi0ae4+d1f9akcfFhb44xPFdvnZDYkg
   w==;
X-CSE-ConnectionGUID: 713fo/BHSSu3bj4yvtWm3w==
X-CSE-MsgGUID: GHiJMx5lTJe8eUu69+fH1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57423514"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57423514"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 22:38:40 -0700
X-CSE-ConnectionGUID: dCUFVluuQAqK0yjbFfXE+g==
X-CSE-MsgGUID: YSVWm2DlQiGD4EnzGs87BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="197935613"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 22:38:35 -0700
Message-ID: <c64b90c9-ee7f-4ca3-b199-24b4927d5608@linux.intel.com>
Date: Fri, 15 Aug 2025 13:38:33 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 26/30] KVM: selftests: TDX: Add support for
 TDG.MEM.PAGE.ACCEPT
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
 <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-27-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250807201628.1185915-27-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> Add support for TDG.MEM.PAGE.ACCEPT that the guest uses to accept
> a pending private page, previously added by TDH.MEM.PAGE.AUG or after
> conversion using the KVM_SET_MEMORY_ATTRIBUTES ioctl().

KVM_SET_MEMORY_ATTRIBUTES does the invalidation and attribute change, but it
doesn't add pending private pages.

Actually, pending pages are still added by TDH.MEM.PAGE.AUG during fault path.

>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   tools/testing/selftests/kvm/include/x86/tdx/tdx.h | 2 ++
>   tools/testing/selftests/kvm/lib/x86/tdx/tdx.c     | 7 +++++++
>   2 files changed, 9 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> index 88f3571df16f..53637159fa12 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> @@ -7,6 +7,7 @@
>   #include "kvm_util.h"
>   
>   #define TDG_VP_INFO 1
> +#define TDG_MEM_PAGE_ACCEPT 6
>   
>   #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
>   #define TDG_VP_VMCALL_MAP_GPA 0x10001
> @@ -40,5 +41,6 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
>   		     uint64_t *r8, uint64_t *r9,
>   		     uint64_t *r10, uint64_t *r11);
>   uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
> +uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level);
>   
>   #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> index bae84c34c19e..a51ab7511936 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> @@ -3,6 +3,7 @@
>   #include <linux/kvm_para.h>
>   #include <string.h>
>   
> +#include "processor.h"
>   #include "tdx/tdcall.h"
>   #include "tdx/tdx.h"
>   #include "tdx/tdx_util.h"
> @@ -215,3 +216,9 @@ uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_o
>   		*data_out = args.r11;
>   	return ret;
>   }
> +
> +uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level)
> +{
> +	return __tdx_module_call(TDG_MEM_PAGE_ACCEPT, (gpa & PAGE_MASK) | level,
> +				 0, 0, 0, NULL);
> +}


