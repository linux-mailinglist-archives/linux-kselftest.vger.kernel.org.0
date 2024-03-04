Return-Path: <linux-kselftest+bounces-5829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A65870378
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 14:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30A91C215F2
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB933FB96;
	Mon,  4 Mar 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVlbScCm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1322A3F9FE;
	Mon,  4 Mar 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560653; cv=none; b=mscVYHEYvyT9z43RnI6HgTCVQLRpyqUVKkrSuDEQqjgcP6/Hy820+YmbSvnjbgQyy78n/6/+DbeU9YMvf+a5BTOaTMeoRz+LpjNeGujMdf4qF02GE9tfm48cgh4QDXqW5aJ8JogXEz8XzoOKNipircKa9YNKU+de/Z0gQDqhFpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560653; c=relaxed/simple;
	bh=GMWrlxz2sTYpPhx3ekf7oQgX2MpEth+T8xxra+NmSyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAKMCyYVosiQa81JEDoJFCISegkbSgl3ktTeEZN38Ig4RESbL7QnMUEDRj135VCqaDzkm4SZEXyhe5nfmonnAZ4s8wlUSBdubp5/vcNXEXE9h6+uisaPyGubbGZuunnb9QmIphMVAMlIxTXIJCPaOSN47Y8TLd53NmwHb2BaxOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVlbScCm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709560651; x=1741096651;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GMWrlxz2sTYpPhx3ekf7oQgX2MpEth+T8xxra+NmSyw=;
  b=YVlbScCmAvxz4oi6BTBX3pXYTURtNkh4+i/CUo0GQLMlKEnsSVTEny2U
   XBecBBpUZ4H5W7SsaeKJUyoqDZJvk+Pmi0eARYaQxDvW4d0APvJ+jMpQb
   jNAvOI0PkXd57/CyjCtetm1AqRb+v+kd+xHnjhM6YDmLpelrdzw/Pi6/h
   IW5Zb4zClLW71qFOS1e5VWGYFcyRoIhaqIZ775AKgnqIW0itXv1GUD0hk
   0VN93VoahueEcpqCexgBxVzaKLV09AYtN32+YrSzQG4Jp23B/6J4APwBH
   VSp4mL+y0OAqKBRJm1G2BDIh0f5u9Sw65f6aN8vOOGk2tfQSP+TUrSdvg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3977533"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3977533"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:57:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="46512380"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.125.242.247]) ([10.125.242.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:57:00 -0800
Message-ID: <0059c183-eb4f-42f5-8f1e-7eef6b0a4bcd@linux.intel.com>
Date: Mon, 4 Mar 2024 21:56:57 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 26/29] KVM: selftests: TDX: Add support for
 TDG.VP.VEINFO.GET
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>,
 Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>,
 Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-27-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-27-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/include/x86_64/tdx/tdx.h    | 21 +++++++++++++++++++
>   .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 19 +++++++++++++++++
>   2 files changed, 40 insertions(+)

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> index b71bcea40b5c..12863a8beaae 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> @@ -6,6 +6,7 @@
>   #include "kvm_util_base.h"
>   
>   #define TDG_VP_INFO 1
> +#define TDG_VP_VEINFO_GET 3
>   #define TDG_MEM_PAGE_ACCEPT 6
>   
>   #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
> @@ -41,4 +42,24 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
>   uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
>   uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level);
>   
> +/*
> + * Used by the #VE exception handler to gather the #VE exception
> + * info from the TDX module. This is a software only structure
> + * and not part of the TDX module/VMM ABI.
> + *
> + * Adapted from arch/x86/include/asm/tdx.h
> + */
> +struct ve_info {
> +	uint64_t exit_reason;
> +	uint64_t exit_qual;
> +	/* Guest Linear (virtual) Address */
> +	uint64_t gla;
> +	/* Guest Physical Address */
> +	uint64_t gpa;
> +	uint32_t instr_len;
> +	uint32_t instr_info;
> +};
> +
> +uint64_t tdg_vp_veinfo_get(struct ve_info *ve);
> +
>   #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> index d8c4ab635c06..71d9f55007f7 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> @@ -241,3 +241,22 @@ uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level)
>   {
>   	return __tdx_module_call(TDG_MEM_PAGE_ACCEPT, gpa | level, 0, 0, 0, NULL);
>   }
> +
> +uint64_t tdg_vp_veinfo_get(struct ve_info *ve)
> +{
> +	uint64_t ret;
> +	struct tdx_module_output out;
> +
> +	memset(&out, 0, sizeof(struct tdx_module_output));
> +
> +	ret = __tdx_module_call(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
> +
> +	ve->exit_reason = out.rcx;
> +	ve->exit_qual   = out.rdx;
> +	ve->gla         = out.r8;
> +	ve->gpa         = out.r9;
> +	ve->instr_len   = out.r10 & 0xffffffff;
> +	ve->instr_info  = out.r10 >> 32;
> +
> +	return ret;
> +}


