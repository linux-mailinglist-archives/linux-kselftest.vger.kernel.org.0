Return-Path: <linux-kselftest+bounces-40927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8536FB48834
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 11:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4602E16B6AC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 09:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB862EE61D;
	Mon,  8 Sep 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yk24scfG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC821C4A13;
	Mon,  8 Sep 2025 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323384; cv=none; b=Is9LxSOUDFpWCrXI8WyVTY//BUxCr4sQJWiFC+7CwycGLyR/ZVCqVYw2CHqc6KaVx3ijD4DNl/Po3KyvtvAUpMJhLYSXtPNOzh+wLUDLPBJWehftn6AwQlEiyaQCBi3LJ5696d8ZxZ1ldQMLS4KXM8FtHo0p8A8pBvI6Xnne79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323384; c=relaxed/simple;
	bh=r6CEOEZhGguz+T46D0YNklZcEc/4ZVQ7i6sW/89ApFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5dNEWJ5UyyV2KY19DiUtONIPZYOjGRZllw4q3TUeWxSq4P7ZlpQxfuViCxAdi5pyB5g6Q6OHOWgH26l4BzNIoym2f0A0/HNzn6FNvBROPPh7LtqumwO7Pc2tkTKqsm0/nrnYGcq4unKcLsH6N8uSB8egWkGqXzZRymPtfIyXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yk24scfG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757323383; x=1788859383;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r6CEOEZhGguz+T46D0YNklZcEc/4ZVQ7i6sW/89ApFg=;
  b=Yk24scfGXBuiFiNQJayaDKSIY/Fhe6S2NQNHOdl2VBw1KwIjY6XP/DVr
   a3UbQ0wvX8csKCUdTScnERZ09AnfgvIoyo/pe8DTIstFQNwIoSrcjgeIM
   tI7m2VGzvu73dSUp94oJhBR85v/jJrdQ5BTcHkxw5QKOQV0n0EKoFBqyW
   O2Y7uYymk7zbPtetkIJKIaljM38jlqkAoLOGwCDWAuWBK83FgS5jPA5cu
   8E+QgxbOArqg/4dMNuM6L+fikOLJJGPtKVd5MLhADjuZEYuwp2QiQnaWC
   jHXg2ipM4VWb+y2Hpg8mQYY7u+z8v2mQ/Kg/z6COmzqZkfelIUmukXNBp
   g==;
X-CSE-ConnectionGUID: fHrEZ3z5QHeL75XQ2Y4hlA==
X-CSE-MsgGUID: jwCNdX/rRxemuhDC+lCm4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="70278518"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="70278518"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 02:23:02 -0700
X-CSE-ConnectionGUID: XWxThIliTqeVbgU08JP15A==
X-CSE-MsgGUID: QWTScLrHQjGPlZSWcE063w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="209904131"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 02:22:57 -0700
Message-ID: <0b176a5a-958d-4fb7-b4d3-e8aae2b5cf5c@linux.intel.com>
Date: Mon, 8 Sep 2025 17:22:54 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/21] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES
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
References: <20250904065453.639610-1-sagis@google.com>
 <20250904065453.639610-13-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250904065453.639610-13-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/2025 2:54 PM, Sagi Shahar wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Make sure that all the attributes enabled by the test are reported as
> supported by the TDX module.
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
> index aa0cb6c2205b..1b5c01faf1cd 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -234,6 +234,18 @@ static void vm_tdx_filter_cpuid(struct kvm_vm *vm,
>   	free(tdx_cap);
>   }
>   
> +static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attributes)
> +{
> +	struct kvm_tdx_capabilities *tdx_cap;
> +
> +	tdx_cap = tdx_read_capabilities(vm);
> +
> +	/* Make sure all the attributes are reported as supported by the TDX module */

I think "by the TDX module" can be dropped, since KVM only reports the
attributes it supports.

> +	TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes);
> +
> +	free(tdx_cap);
> +}
> +
>   void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
>   {
>   	struct kvm_tdx_init_vm *init_vm;
> @@ -253,6 +265,8 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
>   	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
>   	free(cpuid);
>   
> +	tdx_check_attributes(vm, attributes);
> +
>   	init_vm->attributes = attributes;
>   
>   	vm_tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);


