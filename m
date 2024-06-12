Return-Path: <linux-kselftest+bounces-11758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DE490512E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 13:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639CAB2105B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 11:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B4816F0F9;
	Wed, 12 Jun 2024 11:13:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E680716F0D1;
	Wed, 12 Jun 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718190837; cv=none; b=QJvZ0SNYFvcETct08XKnbnjRgYTRVMm2vaPMwb3gpf1UGMitsKpUQ8c+/bR5/yLclilURNqdLtl2ACbfuQn8YSwoybs0pmsLyL2a6b4+fbVuNycUu1jC3AvrXrFj39qvKkSOfohdvg5HS8ciM3x+qQWmUQe9G2/pKcnaM2cvjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718190837; c=relaxed/simple;
	bh=tGPupE+j4PNoFUUhCfT2XJ/QhRvNfK0mEe6nInmY/cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnpMBYhcXl89SILb98yESXpxa7CoU68IpcjtkQ6rXkd4PM0duWRkqr5xXm1cb7pIw/KZN1pbJ0rHMbfKtwPuIIn2R4/SpV7S1c5Vafjj56q5ts3V6GPu5yED5DrhgMug7qRUWWYDuAlSRRs+db71QOO2W2IwTPlR0XjbTfIWt/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5F421595;
	Wed, 12 Jun 2024 04:14:18 -0700 (PDT)
Received: from [10.162.42.15] (e116581.arm.com [10.162.42.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 471543F73B;
	Wed, 12 Jun 2024 04:13:45 -0700 (PDT)
Message-ID: <6bd821a3-9dbe-499c-ae17-afce70076299@arm.com>
Date: Wed, 12 Jun 2024 16:43:41 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: kvm: remove print_skip()
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Anup Patel <anup@brainfault.org>, Andrew Jones <ajones@ventanamicro.com>,
 Aaron Lewis <aaronlewis@google.com>, Thomas Huth <thuth@redhat.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dev Jain <dev.jain@arm.com>
References: <20240612104500.425012-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240612104500.425012-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/12/24 16:14, Muhammad Usama Anjum wrote:
>
>
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
> index 4f5881d4ef66d..695c45635d257 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
> @@ -144,10 +144,9 @@ int main(int argc, char *argv[])
>   	free((void *)hv_cpuid_entries);
>   
>   	if (!kvm_cpu_has(X86_FEATURE_VMX) ||
> -	    !kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS)) {
> -		print_skip("Enlightened VMCS is unsupported");
> -		goto do_sys;
> -	}
> +	    !kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS))
> +		ksft_exit_skip("Enlightened VMCS is unsupported\n");
> +

Isn't it incorrect to delete 'goto do_sys'? ksft_exit_skip() will exit and the
program will never jump to that label. At other places too you have deleted the 'goto'.


>   	vcpu_enable_evmcs(vcpu);
>   	hv_cpuid_entries = vcpu_get_supported_hv_cpuid(vcpu);
>   	test_hv_cpuid(hv_cpuid_entries, true);
> @@ -155,10 +154,8 @@ int main(int argc, char *argv[])
>   
>   do_sys:
>   	/* Test system ioctl version */
> -	if (!kvm_has_cap(KVM_CAP_SYS_HYPERV_CPUID)) {
> -		print_skip("KVM_CAP_SYS_HYPERV_CPUID not supported");
> -		goto out;
> -	}
> +	if (!kvm_has_cap(KVM_CAP_SYS_HYPERV_CPUID))
> +		ksft_exit_skip("KVM_CAP_SYS_HYPERV_CPUID not supported\n");
>   
>   	test_hv_cpuid_e2big(vm, NULL);
>   
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c b/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c
> index 949e08e98f315..d37212a27990b 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c
> @@ -47,10 +47,8 @@ int main(void)
>   
>   	/* Verify if extended hypercalls are supported */
>   	if (!kvm_cpuid_has(kvm_get_supported_hv_cpuid(),
> -			   HV_ENABLE_EXTENDED_HYPERCALLS)) {
> -		print_skip("Extended calls not supported by the kernel");
> -		exit(KSFT_SKIP);
> -	}
> +			   HV_ENABLE_EXTENDED_HYPERCALLS))
> +		ksft_exit_skip("Extended calls not supported by the kernel\n");
>   
>   	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
>   	run = vcpu->run;
> diff --git a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
> index 57f157c06b393..1dcb37a1f0be9 100644
> --- a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
> @@ -273,10 +273,8 @@ int main(int argc, char *argv[])
>   	kvm_ioctl(vm->kvm_fd, KVM_X86_GET_MCE_CAP_SUPPORTED,
>   		  &supported_mcg_caps);
>   
> -	if (!(supported_mcg_caps & MCG_CMCI_P)) {
> -		print_skip("MCG_CMCI_P is not supported");
> -		exit(KSFT_SKIP);
> -	}
> +	if (!(supported_mcg_caps & MCG_CMCI_P))
> +		ksft_exit_skip("MCG_CMCI_P is not supported\n");
>   
>   	ucna_vcpu = create_vcpu_with_mce_cap(vm, 0, true, ucna_injection_guest_code);
>   	cmcidis_vcpu = create_vcpu_with_mce_cap(vm, 1, false, cmci_disabled_guest_code);

