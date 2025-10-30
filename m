Return-Path: <linux-kselftest+bounces-44372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A5C1E07A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 02:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3367C34B2A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 01:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D328727F;
	Thu, 30 Oct 2025 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNII6Rx3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D03D286D63;
	Thu, 30 Oct 2025 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761788116; cv=none; b=sPXW/WD20pgoecDM0j534tIHJGOnWAABzWjdY2w5RPlkMvtQbR9dO+p5A6JASy//HYuJD98Jjb65Mk1B5roKBfz/eZCLu8iWls9xJBn5+NZmWiblWxzX2/EGSWLgmeybAXZV7P5XDkddRzDRQqImSuA8/vzA//iAKX/KNMdGArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761788116; c=relaxed/simple;
	bh=h5HItmxxtllaa4qYDcONQvigJygCAvXadjZ6K1zn5fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUbjweMPSw5W1qRwXnb5Fc5caOLly9UJ+kg9w8pFrnwpabQrCe/2wRSrcVYCR6+A2OHeQH2UybnXWzeoqBb2w04ax18e9IRvQbB/KsQza8UKeVKGF1BSyfPzZ3vcdCPoCQY52LtVmKWb9dcYr6qAp17NfPjf7bL/H3M57UnJc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNII6Rx3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761788112; x=1793324112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h5HItmxxtllaa4qYDcONQvigJygCAvXadjZ6K1zn5fY=;
  b=nNII6Rx3SNi3Q3iBTdkwKg2H0pUiZhF+0lhXb4HlS75ypfAwoUXt6Z0a
   SxiHuCfPRzWTfhH+FOAXPj76KjSPn4MPw2bZVqdlF38HvCa4iT293lfpe
   XhSY3eInL02dtqzTSeCscvOUzGkPHSJyMQyL/Vl5wXt+7Dq9UTxK5tq3S
   j8/mMWL8sT8HkejUYzQbMnBz0KRrqRUQECT/6mZspaHRdoT6H4sSFazIh
   vriR2B/OETV4fdaRdxeaaJI6p+D0WQVscMMiO1KYdBevnZCcqNeRo1obp
   T+9r8iEDoBZPL1n0UlpLgEU8a+AvgSouGygoz/beIM7PiEl4n+3Aqq3bR
   w==;
X-CSE-ConnectionGUID: as8z8MheT7ecwESeW1fpmw==
X-CSE-MsgGUID: ljvtp64pRLeFsbpsNTHjUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75371548"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="75371548"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 18:35:12 -0700
X-CSE-ConnectionGUID: RC5MJzwKQhCcmrUa93TuXA==
X-CSE-MsgGUID: 2O29+gOkRDGwcrhrp2Ga4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185075296"
Received: from yinghaoj-desk.ccr.corp.intel.com (HELO [10.238.1.225]) ([10.238.1.225])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 18:35:07 -0700
Message-ID: <d5b23bf0-aa77-4f11-9026-e664a8257a16@linux.intel.com>
Date: Thu, 30 Oct 2025 09:35:05 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 13/23] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES
 to validate TDs' attribute configuration
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
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-14-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20251028212052.200523-14-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/2025 5:20 AM, Sagi Shahar wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Make sure that all the attributes enabled by the test are reported as
> supported by the TDX module.
More accurately, supported by both the TDX module and KVM.
KVM filters out the attributes not supported by itself.

Otherwise,
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

>
> This also exercises the KVM_TDX_CAPABILITIES ioctl.
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 7a622b4810b1..2551b3eac8f8 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -231,6 +231,18 @@ static void vm_tdx_filter_cpuid(struct kvm_vm *vm,
>   	free(tdx_cap);
>   }
>   
> +static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attributes)
> +{
> +	struct kvm_tdx_capabilities *tdx_cap;
> +
> +	tdx_cap = tdx_read_capabilities(vm);
> +
> +	/* Make sure all the attributes are reported as supported */
> +	TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes);
> +
> +	free(tdx_cap);
> +}
> +
>   void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
>   {
>   	struct kvm_tdx_init_vm *init_vm;
> @@ -250,6 +262,8 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
>   	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
>   	free(cpuid);
>   
> +	tdx_check_attributes(vm, attributes);
> +
>   	init_vm->attributes = attributes;
>   
>   	vm_tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);


