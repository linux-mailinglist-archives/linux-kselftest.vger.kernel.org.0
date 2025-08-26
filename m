Return-Path: <linux-kselftest+bounces-39938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA5CB358B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 11:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFB077AEA2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2513306D48;
	Tue, 26 Aug 2025 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bV3Im/U9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CC42FCBE1;
	Tue, 26 Aug 2025 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200160; cv=none; b=Zl2BDT2KBJqDjD69Spn928aEkErTfYxbbkMUyWgqKVMJKTVumMJOUVb2xUcgybH4sjE0xp/dopww02XIqQPBax6aJEDaL3Q1774WFnpyTWcSULVwM0D6NonHWP0dS5G4JJdj/gXSXtLKUyID7oFJBOwjfqevOf8oIqYliixNdaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200160; c=relaxed/simple;
	bh=cgpeH3OJ9IMzHQv7eqVKmXsfFLPmqH7KEzaiB3mfS3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EV+bcyjXvSlcKz0bhouTRM4LgQR8IoHR9S3Xg4J3Ar+7ap/wxxvGHqc68hgegS2iDaM1FcC3qjIKciLBHffwQNfbD5cE0JEjzq0OHSfwb3uimhjIW/seAnMxY9iLa1G9Y5gC4NNjtTPKHC6wIehAJkl3Nwc91LBsTIvVfONTGO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bV3Im/U9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756200159; x=1787736159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cgpeH3OJ9IMzHQv7eqVKmXsfFLPmqH7KEzaiB3mfS3k=;
  b=bV3Im/U96bmZN2pUWeIes1uSsLc6E+5eocJRj8SgJ59Jwulu3um1fr0O
   Zv5s1oeA1zaR8KZh0EATSH7IoH4f/5/tolvFjIxvT1YFM24amPMqO9eZA
   xNxva4oRqFhhnocaY4TBJL/mXaRwfJ7C1pK8JsrQWx/JcRfyrbHhRpw82
   7vBeMoPcCGA2260jx68y0CsiqovlxvjC0BtbYAmjpSSwb3ddiPKTw1iKm
   8vdBweRAEcvFxvDCizm66sKYVcQVNR0l/yS9saeU39GPtlc0hJQXnSfCm
   4c0OX/Zb0FKu/gQ5Jp7MfK1iqnQVlm/eAW6Nm2O15sQzcl3YgMZxQAYO0
   g==;
X-CSE-ConnectionGUID: nH9v1KEeRyG1w9kOQK9tHA==
X-CSE-MsgGUID: 3qm9dteVTUezFLQUOZMSkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58136510"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58136510"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 02:22:37 -0700
X-CSE-ConnectionGUID: j5KBEwrISP+w4PX/VdVrTQ==
X-CSE-MsgGUID: DQtltgzwT7Cm44/mBwIF1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168738016"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 02:22:32 -0700
Message-ID: <4306ca85-1dcd-47c1-bb36-b76a2efe061f@linux.intel.com>
Date: Tue, 26 Aug 2025 17:22:29 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/19] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
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
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-14-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250821042915.3712925-14-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/2025 12:29 PM, Sagi Shahar wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> This also exercises the KVM_TDX_CAPABILITIES ioctl.

That commit message should describe what the patch does instead of relying on
the title/short log.

>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/lib/x86/tdx/tdx_util.c        | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 3869756a5641..d8eab99d9333 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -232,6 +232,21 @@ static void vm_tdx_filter_cpuid(struct kvm_vm *vm,
>   	free(tdx_cap);
>   }
>   
> +static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attributes)
> +{
> +	struct kvm_tdx_capabilities *tdx_cap;
> +
> +	tdx_cap = tdx_read_capabilities(vm);
> +
> +	/* TDX spec: any bits 0 in supported_attrs must be 0 in attributes */
> +	TEST_ASSERT_EQ(attributes & ~tdx_cap->supported_attrs, 0);
> +
> +	/* TDX spec: any bits 1 in attributes must be 1 in supported_attrs */

The comments are not accurate.

The descriptions in TDX spec are for ATTRIBUTES_ FIXED0 and ATTRIBUTES_ FIXED1.
They are related to tdx_cap->supported_attrs returned by KVM, but they are not
the same.


> +	TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes);
> +
> +	free(tdx_cap);
> +}
> +
>   void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
>   {
>   	struct kvm_tdx_init_vm *init_vm;
> @@ -251,6 +266,8 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
>   	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
>   	free(cpuid);
>   
> +	tdx_check_attributes(vm, attributes);
> +
>   	init_vm->attributes = attributes;
>   
>   	vm_tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);


