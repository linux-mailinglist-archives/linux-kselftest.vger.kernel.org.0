Return-Path: <linux-kselftest+bounces-24074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60F9A064B0
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 19:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981AF167FDE
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 18:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D23202C40;
	Wed,  8 Jan 2025 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tSf/Xrbu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C620103A
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361316; cv=none; b=fytbHtjQ8g7jTAOAuShNn6kyPr3sm8jAG7arlYpDf1ArebTQHk95SwNEFh7Nc9AEramFJZCa6sAfkTSAB+4EW6ClCfJbsj1Q0UHms5qVxc5o50aSY6hr52pizoqW6piPsg8CKNvSvbpqnJqWWT2RqoOEu4VOQTgBf5jEhJnuCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361316; c=relaxed/simple;
	bh=2NVPFhLkeqohReHa5lOei9tnSr0humarNaSbYGs/bSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b0vNFHnFA/MHRdAUc4d0NPvyLrJZ8ePo3SCKNtqcxoI8Xus3WIyg1/sG7/+9El/5iAPhtHjnBqKIDFC8zjaIquF3xUKeC7scR8VYswGTc6TPGbatC6sbNnc9of998f+HaC39U2lGL6A8Rn0b3ndN+Ma0hvwhi1X7oiivOwVX05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tSf/Xrbu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21681a2c0d5so453895ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 10:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736361314; x=1736966114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bukfER009F+Z1ZXzjnWoHkM4/fO5m2gvqsvHWzsBrU=;
        b=tSf/XrbuzUusxMWKylUumZb3sZ5I+D1GYvv2mq74e2Ny4qi8AIlCsv+Az2oJM1xAs5
         ba/6sV6U90DOBjUbNDASteEL+gXzv1LRBkBltzsG8qUYVZHCwqKZL03+MnoJN2VjsfBq
         sMpLRvK2+kRuliGwuEGuIitnvQzpN9uu266e0yfa5yHw8UOVydq8EMnbbe3EdJAcJCw7
         3jscfdu647GDt6Z0RMvmvivPc/BzsdMtm5Q/h5JNy0WbOmbxj+foUGybSzTpEsjOKuKH
         F570pqi5LyaBSOYPBaGpTKWHiqp8iFJG519j6zMoUdVXYg5UX5rqFVwsZG+pUnJoNHiy
         9UTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736361314; x=1736966114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bukfER009F+Z1ZXzjnWoHkM4/fO5m2gvqsvHWzsBrU=;
        b=I51WBQfnlxWJ0yhUgx/cpSZDpRuf6T1t421rD/tmCkEam++CJ3h/w0Rh0tqkjg50Ea
         ZVUltuwpspeqleaBnMc9eVIpi8KS/tGf6cL1NDWtyLsS+c1KPVpMBTDReo/qfoaR5w+m
         SYXLmCxXA8fdgNzOACjdCkdrDuYwsQX145I4SR378HONfdteXzFOuQMMxjLeV0pT5YUn
         RsmRwUdd0EGurliAV5ZyQodW+N4xHvbRIOuOEShxYN0RfmnU7ct0F7JIKYmEYkIJM6jb
         etXQsq3fV/Xt+4Zl60hfEithL1XzY8y5BuU1gjIEd1qKgOgAhb7KiuJUGUkM87yyrHG5
         XIjw==
X-Forwarded-Encrypted: i=1; AJvYcCX++2O4BB+ab1YG3P1dJjptK7SlJz3OJrDpW4okXKsLTpiCJ91rKGyPSeHZgbQ/FETs1FiUDU8znWsgN1DATos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDj7z/8WwRsB+VLl4wRyu6g+V5e4EbWqSfGdO/EgCHiqaMaCQP
	MYNO7EnK+RzRD8T0uvxIUshS3weT1Fkr/kkUBtmHaYvpyvNXX38rF7y+3U3b9zTRZ+TPHo+kwJy
	0Lg==
X-Google-Smtp-Source: AGHT+IGFDkOY+8jnbMKX9qsqgyAmbRtxiAKHGzQrfUdVnvF6We8zNlv5NEixK2AddpqdQYShlzGaUUV/XjQ=
X-Received: from pghm11.prod.google.com ([2002:a63:f60b:0:b0:7fe:5385:5c99])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4393:b0:1e0:c56f:7db4
 with SMTP id adf61e73a8af0-1e88d0e0be1mr6542295637.2.1736361314442; Wed, 08
 Jan 2025 10:35:14 -0800 (PST)
Date: Wed, 8 Jan 2025 10:35:13 -0800
In-Reply-To: <20240918205319.3517569-4-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918205319.3517569-1-coltonlewis@google.com> <20240918205319.3517569-4-coltonlewis@google.com>
Message-ID: <Z37FYUU4ppiZsa68@google.com>
Subject: Re: [PATCH v2 3/6] KVM: x86: selftests: Set up AMD VM in pmu_counters_test
From: Sean Christopherson <seanjc@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Jinrong Liang <ljr.kernel@gmail.com>, Jim Mattson <jmattson@google.com>, 
	Aaron Lewis <aaronlewis@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 18, 2024, Colton Lewis wrote:
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
>  .../selftests/kvm/x86_64/pmu_counters_test.c  | 104 ++++++++++++++----
>  1 file changed, 83 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> index 0e305e43a93b..5b240585edc5 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> @@ -30,10 +30,21 @@
>  #define NUM_INSNS_RETIRED		(NUM_LOOPS * NUM_INSNS_PER_LOOP + NUM_EXTRA_INSNS)
>  
>  
> +/*
> + * Limit testing to MSRs that are actually defined by Intel (in the SDM).  MSRs
> + * that aren't defined counter MSRs *probably* don't exist, but there's no
> + * guarantee that currently undefined MSR indices won't be used for something
> + * other than PMCs in the future.
> + */
> +#define MAX_NR_GP_COUNTERS	8
> +#define MAX_NR_FIXED_COUNTERS	3
> +#define AMD_NR_CORE_COUNTERS	4
> +#define AMD_NR_CORE_EXT_COUNTERS	6
> +
>  static uint8_t kvm_pmu_version;
>  static bool kvm_has_perf_caps;
>  
> -static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
> +static struct kvm_vm *intel_pmu_vm_create(struct kvm_vcpu **vcpu,
>  						  void *guest_code,

When renaming things, please fixup the alignment as needed.  Yes, it's more
churn, but one-time pain is preferable to living indefinitely with funky formatting.

I also don't like renaming just one symbol.  E.g. the above MAX_NR_GP_COUNTERS
and MAX_NR_FIXED_COUNTERS #defines are Intel specific, but that's not at all
clear from the code.  Ditto for guest_rd_wr_counters() vs.
guest_test_rdwr_core_counters().

Given how little code is actually shared between Intel and AMD, I think it makes
sense to have the bulk of the code live in separate .c files.  Since
tools/testing/selftests/kvm/lib/x86/pmu.c is already a thing, the best option is
probably to rename pmu_counters_test.c to intel_pmu_counters_test.c, and then
extract the common bits to lib/x86/pmu.c (or include/x86/pmu.h as appropriate).

>  						  uint8_t pmu_version,
>  						  uint64_t perf_capabilities)
> +static void test_core_counters(void)
> +{
> +	uint8_t nr_counters = nr_core_counters();
> +	bool core_ext = kvm_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
> +	bool perfmon_v2 = kvm_cpu_has(X86_FEATURE_PERFMON_V2);
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +
> +	for (uint8_t ce = 0; ce <= core_ext; ce++) {

Kernel style is to not declared variables inside for-loops.

> +		for (uint8_t pm = 0; pm <= perfmon_v2; pm++) {

Iterating over booleans is decidedly odd, the indentation levels are painful and
will only get worse as more features are added, and the "ce" and "pm" variables
aren't all that intuitive.  More below.

> +			for (uint8_t nc = 0; nc <= nr_counters; nc++) {

I also find "nc" to be unintuitive.  Either use a fully descriptive name, or
make it obvious that the variables is an iterator.  E.g. either

	uint8_t max_nr_counters = nr_core_counters();

	...

		for (nr_counters = 0; nr_counters < max_nr_counters; nr_counters++) {


or

		for (j = 0; j < nr_counters; j++) {


'j' is obviously not descriptive, but when reading the usage, it's more obvious
that it's a loop iterator (if you choose

> +				vm = vm_create_with_one_vcpu(&vcpu, guest_test_core_counters);
> +
> +				if (nc)

Is '0' not a legal number of counters?

> +					vcpu_set_cpuid_property(

Google3!  (Never, ever wrap immediately after the opening paranethesis).

> +						vcpu, X86_PROPERTY_NUM_PERF_CTR_CORE, nc);
> +				if (ce)
> +					vcpu_set_cpuid_feature(
> +						vcpu, X86_FEATURE_PERF_CTR_EXT_CORE);

This likely doesn't do what you want.  By default, vm_arch_vcpu_add() initializes
CPUID to KVM's supported CPUID.  So only _setting_ the feature means that that
the test is likely only ever running with the full set of supported features.

Jumping back to my complaints with the for-loops, if the features to interate on
are collected in an array, then the test can generate a mask of all possible
combinations and iterate over that (plus the array itself).  That keeps the
indentation bounded and eliminates the copy+paste needed to add a new feature.
The only downside is that the test is limited to 64 features, but we'll run into
run time issues long before that limit is reached.

	const struct kvm_x86_cpu_feature pmu_features[] = {
		X86_FEATURE_PERF_CTR_EXT_CORE,
		X86_FEATURE_PERFMON_V2,
	};

	const u64 pmu_features_mask = BIT_ULL(ARRAY_SIZE(pmu_features)) - 1;

	for (mask = 0; mask <= pmu_features_mask; mask++) {
		for (nr_counters = 0; nr_counters < max_nr_counters; nr_counters++) {
			vm = vm_create_with_one_vcpu(&vcpu, guest_test_core_counters);

			vcpu_set_cpuid_property(vcpu, X86_PROPERTY_NUM_PERF_CTR_CORE,
						nr_counters);

			/* Comment goes here */
			for (i = 0; i < ARRAY_SIZE(pmu_features); i++)
				vcpu_set_or_clear_cpuid_feature(vcpu, pmu_features[i],
								mask & BIT_ULL(i));

			...			
	}	

> +				if (pm)
> +					vcpu_set_cpuid_feature(
> +						vcpu, X86_FEATURE_PERFMON_V2);
> +
> +				pr_info("Testing core counters: CoreExt = %u, PerfMonV2 = %u, NumCounters = %u\n",
> +					ce, pm, nc);
> +				run_vcpu(vcpu);
> +
> +				kvm_vm_free(vm);
> +			}
> +		}
> +	}
> +}

