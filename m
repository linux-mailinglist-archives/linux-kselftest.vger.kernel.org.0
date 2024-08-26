Return-Path: <linux-kselftest+bounces-16350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAD695FD3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 00:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB3B1F2243D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 22:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD62219DF64;
	Mon, 26 Aug 2024 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6QxZsnL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D7D19DF47
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712246; cv=none; b=OU+uL9ccQ5N2Fb9bEjM74DB7VRWvYfTDRfn6fGeD2itL+5Y76s5BfnEILhhSckkO/AizIJp/R+n7KN5RCVe8i2JNe7s+LTPuh3fpr74j4oTLXYkCB+rNo90X//qqLcKKOcxPv+tPXuUv0cxjVkAdIdxSAYNZVG778eZe53pALjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712246; c=relaxed/simple;
	bh=N5xpShV8hxv1Suunf5/qu8qIjX6JVQYB0UW2rOB1BG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFZgHfzx3r+JJVCNenyJyLbdi7yIrJ4WYlQE8lkvEaYb+K2qvBLMz1Y19hRcSh+rx5LZt/NSkvDtZhdnPJX70stt4g2atewzFAIUNbVCLljeq6o1eFhC64WYJNMyY/Es3KHz+MhoZ4tGlwgmjiSLLKIxsz8xw3LZ0Sail7LgaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6QxZsnL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-202146e93f6so49101265ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724712244; x=1725317044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XbsEy45tNGKxqPOba7WhHBnXFFVzyX5Xw86H90OePmE=;
        b=k6QxZsnL+xh2Mo4TeYmLimBQ0iY/tpmWtyYX+82c5g6GbNwZBCGJhUc9OoEeYIqbk+
         wN/lffANb0Svw/tXFqGSn33dR+0w+d1kOX/5a/0K7XRmQVS2OQMblcqjAOAoA9XNZsih
         0VMEoVEnL9uVBl+sj8ZL/VDiSklno2dZN9DQGukMgQ7y1NlBqGR5DuacqZXdhqRdo+gk
         gAOC67ajy5WfSGtDU+WnDAptLoSVTEKO68qzmuu0zkYu/FMcapMtnaMhf7LPKTH/wBkx
         bj7ComUlQCbkrBePJ6aWqMYejPbMSyT9Wdhq7B8Y6EdM/lBfpu9ksAH3QkWDsZgpjc3R
         E37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724712244; x=1725317044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbsEy45tNGKxqPOba7WhHBnXFFVzyX5Xw86H90OePmE=;
        b=Sw1NXwTFNPkzUa4qbG/Vpfl6iOuMWoer9fElnUEAtuT1JUFTVIgeFlW/fnWVNnLzMR
         OfADyzoxQIpOMNUhzl1OyK0bfsvW/uye7ldfpb0WA2h3RIp7gcjdtdi4pnqiWgS+Ok+h
         yUkzXcSuwtbb52e5niUr5saigteAlYaH7F+BA/lj7wb+aPfSLujBsRZyLbkrTqhZL2jy
         t8LK4SpJR3QsC2v/f+XJk/CoZh74Kg0PIA0uGC5gVprE62HNU4y/RpIpHofL0uhY9Mtc
         gA7THfeAhgNkA/C5twqWnBMNNb97XegRFcu+i1ig4sBUQLgibQC1xDFGysfYXk6TjMlU
         KNmA==
X-Forwarded-Encrypted: i=1; AJvYcCVvk+sF7lW8/yqnJXFbNXEru1NFze9COgEQBv2HnJGueIKqTEdEXGeI5t5XbHP7aHOPc824d4PD9LczYnAXROU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywasp/uOKhR99GVDlVSsbVGlCScGA7UJC9UvwxyoASUErjGCeZk
	XeKLUswI1SZZYOVJX8lmaTbj65YZ79dn+DGPazjURCn8fw21xe2pz4EqDuDEgg==
X-Google-Smtp-Source: AGHT+IHk44Av6SIPN3cZMGqkADnzfxNrcopMRGECylfz5dyTGJUoOgD5fF3Fm2z5xkuVKDzLsrLI3w==
X-Received: by 2002:a17:902:d4c8:b0:203:a20d:5857 with SMTP id d9443c01a7336-203a20d58a7mr133896465ad.5.1724712243956;
        Mon, 26 Aug 2024 15:44:03 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385581393sm72156735ad.102.2024.08.26.15.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 15:44:03 -0700 (PDT)
Date: Mon, 26 Aug 2024 22:43:58 +0000
From: Mingwei Zhang <mizhang@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Jinrong Liang <ljr.kernel@gmail.com>,
	Jim Mattson <jmattson@google.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] KVM: x86: selftests: Set up AMD VM in
 pmu_counters_test
Message-ID: <Zs0FLglChWqsGa6w@google.com>
References: <20240813164244.751597-1-coltonlewis@google.com>
 <20240813164244.751597-4-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813164244.751597-4-coltonlewis@google.com>

On Tue, Aug 13, 2024, Colton Lewis wrote:
> Branch in main() depending on if the CPU is Intel or AMD. They are
> subject to vastly different requirements because the AMD PMU lacks
> many properties defined by the Intel PMU including the entire CPUID
> 0xa function where Intel stores all the PMU properties. AMD lacks this
> as well as any consistent notion of PMU versions as Intel does. Every
> feature is a separate flag and they aren't the same features as Intel.
> 
> Set up a VM for testing core AMD counters and ensure proper CPUID
> features are set.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  .../selftests/kvm/x86_64/pmu_counters_test.c  | 80 ++++++++++++++++---
>  1 file changed, 68 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> index 0e305e43a93b..a11df073331a 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> @@ -33,7 +33,7 @@
>  static uint8_t kvm_pmu_version;
>  static bool kvm_has_perf_caps;
>  
> -static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
> +static struct kvm_vm *intel_pmu_vm_create(struct kvm_vcpu **vcpu,
>  						  void *guest_code,
>  						  uint8_t pmu_version,
>  						  uint64_t perf_capabilities)
> @@ -303,7 +303,7 @@ static void test_arch_events(uint8_t pmu_version, uint64_t perf_capabilities,
>  	if (!pmu_version)
>  		return;
>  
> -	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_arch_events,
> +	vm = intel_pmu_vm_create(&vcpu, guest_test_arch_events,
>  					 pmu_version, perf_capabilities);
>  
>  	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH,
> @@ -463,7 +463,7 @@ static void test_gp_counters(uint8_t pmu_version, uint64_t perf_capabilities,
>  	struct kvm_vcpu *vcpu;
>  	struct kvm_vm *vm;
>  
> -	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_gp_counters,
> +	vm = intel_pmu_vm_create(&vcpu, guest_test_gp_counters,
>  					 pmu_version, perf_capabilities);
>  
>  	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_GP_COUNTERS,
> @@ -530,7 +530,7 @@ static void test_fixed_counters(uint8_t pmu_version, uint64_t perf_capabilities,
>  	struct kvm_vcpu *vcpu;
>  	struct kvm_vm *vm;
>  
> -	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_fixed_counters,
> +	vm = intel_pmu_vm_create(&vcpu, guest_test_fixed_counters,
>  					 pmu_version, perf_capabilities);
>  
>  	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK,
> @@ -627,18 +627,74 @@ static void test_intel_counters(void)
>  	}
>  }
>  
> -int main(int argc, char *argv[])
> +static uint8_t nr_core_counters(void)
>  {
> -	TEST_REQUIRE(kvm_is_pmu_enabled());
> +	const uint8_t nr_counters = kvm_cpu_property(X86_PROPERTY_NUM_PERF_CTR_CORE);
> +	const bool core_ext = kvm_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
> +	/* The default numbers promised if the property is 0 */
> +	const uint8_t amd_nr_core_ext_counters = 6;
> +	const uint8_t amd_nr_core_counters = 4;
> +
> +	if (nr_counters != 0)
> +		return nr_counters;
> +
> +	if (core_ext)
> +		return amd_nr_core_ext_counters;
> +
> +	return amd_nr_core_counters;
> +}
> +
> +static void guest_test_core_counters(void)
> +{
> +	GUEST_DONE();
> +}
>  
> -	TEST_REQUIRE(host_cpu_is_intel);
> -	TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
> -	TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
> +static void test_core_counters(void)
> +{
> +	uint8_t nr_counters = nr_core_counters();
> +	bool core_ext = kvm_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
> +	bool perf_mon_v2 = kvm_cpu_has(X86_FEATURE_PERF_MON_V2);
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
>  
> -	kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
> -	kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_test_core_counters);
>  
> -	test_intel_counters();
> +	/* This property may not be there in older underlying CPUs,
> +	 * but it simplifies the test code for it to be set
> +	 * unconditionally.
> +	 */
> +	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_NUM_PERF_CTR_CORE, nr_counters);
> +	if (core_ext)
> +		vcpu_set_cpuid_feature(vcpu, X86_FEATURE_PERF_CTR_EXT_CORE);
> +	if (perf_mon_v2)
> +		vcpu_set_cpuid_feature(vcpu, X86_FEATURE_PERF_MON_V2);

hmm, I think this might not be enough. So, when the baremetal machine
supports Perfmon v2, this code is just testing v2. But we should be able
to test anything below v2, ie., v1, v1 without core_ext. So, three
cases need to be tested here: v1 with 4 counters; v1 with core_ext (6
counters); v2.

If, the machine running this selftest does not support v2 but it does
support core extension, then we fall back to test v1 with 4 counters and
v1 with 6 counters.
> +
> +	pr_info("Testing core counters: CoreExt = %u, PerfMonV2 = %u, NumCounters = %u\n",
> +		core_ext, perf_mon_v2, nr_counters);
> +	run_vcpu(vcpu);
> +
> +	kvm_vm_free(vm);
> +}
> +
> +static void test_amd_counters(void)
> +{
> +	test_core_counters();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	TEST_REQUIRE(kvm_is_pmu_enabled());
> +
> +	if (host_cpu_is_intel) {
> +		TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
> +		TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
> +		kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
> +		kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
> +		test_intel_counters();
> +	} else if (host_cpu_is_amd) {
> +		/* AMD CPUs don't have the same properties to look at. */
> +		test_amd_counters();
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.46.0.76.ge559c4bf1a-goog
> 

