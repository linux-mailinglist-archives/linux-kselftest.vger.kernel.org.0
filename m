Return-Path: <linux-kselftest+bounces-39067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8D9B279FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 09:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D115116CBB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 07:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E1721B9C8;
	Fri, 15 Aug 2025 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0fP0n19"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0F31F1921;
	Fri, 15 Aug 2025 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755242330; cv=none; b=KCGyGfRM4rI8gKz6xud/v1KCsvmqGCCr0lxosZ0H6i6X6XTy8Zqp6ZtfE5A4cHdP6y9YPlduW2+3GAMpg5nL728HPR22Probn1uG7fjgToAT9andzo2skTDGvesLrLSPKam/u/bhf2tq4bLDVi0d7WHS4gqFZdpGOH2FMeC3F+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755242330; c=relaxed/simple;
	bh=Rz4uCSh5tIRgeZutDu1RjAsYU3kitky0kF/nmleGpDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUrdnpnOp6/nfNvH1TJ3q2/8LnBbxj9PB/uLIx8FHyhSqF7Ftyb44oJWT4OVuufbZiGePJsceryGXMs9OlPW14eljSrIzANZcI3NRASmMAsLOPLYY6ocG3AdeAP1/SHmm9tb1osemAmYGjohzRMoLFxWOGQsaxMOtF/CR6hsHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0fP0n19; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755242329; x=1786778329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rz4uCSh5tIRgeZutDu1RjAsYU3kitky0kF/nmleGpDo=;
  b=P0fP0n19MiYDzPcOLjA1MxTcwTNQWma/9QGmcdzjxz72vEtZUpgbBgZt
   ob36bRqxva5xNEXyCGlSbIEpMQzYHBBDSdgkTWQqXjHU+GcyGZyIZeA8w
   FUIfaCR6amA7tIrPtPBBgtRjKg8UQhPGV036mCvZ5BOT+d9WvZT3HNvyj
   JdCVO+1luqKCcc3a2QUt/5FMk/+O4X+ECmG4Q5rXFSSC9RElIdltbYVT9
   NHLztRU9633WljY5cnF8S5087gfKR2AXYS8woZjGqpFhdd5JKVoBplQEE
   yR2ldwHgAxHvkkHBoxc7mN/YST7RM/8Y5/TI4fC6DipMnxDTUYratJqP4
   g==;
X-CSE-ConnectionGUID: jftD8A3FR0GdQKrMUd7yQw==
X-CSE-MsgGUID: fs87vGJFSM+sSrmppvqwqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="83000016"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="83000016"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 00:18:48 -0700
X-CSE-ConnectionGUID: f034IAboTnKvDIID/HQNOA==
X-CSE-MsgGUID: jhuxWzuqRtiZtjlHYvaqBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="197806750"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 00:18:44 -0700
Message-ID: <d554355c-f678-4f90-a56b-675877be01e9@linux.intel.com>
Date: Fri, 15 Aug 2025 15:18:42 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 29/30] KVM: selftests: TDX: Add TDX UPM selftests for
 implicit conversion
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
 <20250807201628.1185915-30-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250807201628.1185915-30-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> This tests the use of guest memory without explicit TDG.VP.VMCALL<MapGPA>
> calls.
>
> Provide a 2MB memory region to the TDX guest with a 40KB focus area at
> offset 1MB intended to be shared between host and guest. The guest does
> not request memory to be shared or private using TDG.VP.VMCALL<MapGPA> but
> instead relies on memory to be converted automatically based on its
> access via shared or private mapping. The host automatically
> converts the memory when guest exits with KVM_EXIT_MEMORY_FAULT.
>
> The 2MB region starts out as private with the guest filling it with a
> pattern, followed by a check from the host to ensure the host is not able
> to see the pattern. The guest then accesses the 40KB focus area via
> its shared mapping to trigger implicit conversion followed by checks that
> the host and guest has the same view of the memory. Finally the guest
> accesses the 40KB memory via its private mapping to trigger the implicit
> conversion to private followed by checks to confirm this is the case.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../testing/selftests/kvm/x86/tdx_upm_test.c  | 88 ++++++++++++++++---
>   1 file changed, 76 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86/tdx_upm_test.c b/tools/testing/selftests/kvm/x86/tdx_upm_test.c
> index 387258ab1a62..2ea5bf6d24b7 100644
> --- a/tools/testing/selftests/kvm/x86/tdx_upm_test.c
> +++ b/tools/testing/selftests/kvm/x86/tdx_upm_test.c
> @@ -150,10 +150,10 @@ enum {
>    * Does vcpu_run, and also manages memory conversions if requested by the TD.
>    */
>   void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
> -					    struct kvm_vcpu *vcpu)
> +					    struct kvm_vcpu *vcpu, bool handle_conversions)
>   {
>   	for (;;) {
> -		vcpu_run(vcpu);
> +		_vcpu_run(vcpu);
Why this change?


>   		if (vcpu->run->exit_reason == KVM_EXIT_HYPERCALL &&
>   		    vcpu->run->hypercall.nr == KVM_HC_MAP_GPA_RANGE) {
>   			uint64_t gpa = vcpu->run->hypercall.args[0];
> @@ -164,6 +164,13 @@ void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
>   						  KVM_MAP_GPA_RANGE_ENCRYPTED);
>   			vcpu->run->hypercall.ret = 0;
>   			continue;
> +		} else if (handle_conversions &&
> +			vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT) {
> +			handle_memory_conversion(vm, vcpu->id, vcpu->run->memory_fault.gpa,
> +						 vcpu->run->memory_fault.size,
> +						 vcpu->run->memory_fault.flags ==
> +						  KVM_MEMORY_EXIT_FLAG_PRIVATE);
> +			continue;
>   		} else if (vcpu->run->exit_reason == KVM_EXIT_IO &&
>   			   vcpu->run->io.port == TDX_UPM_TEST_ACCEPT_PRINT_PORT) {
>   			uint64_t gpa = tdx_test_read_64bit(vcpu,
> @@ -241,8 +248,48 @@ static void guest_upm_explicit(void)
>   	tdx_test_success();
>   }
>   
>
[...]

