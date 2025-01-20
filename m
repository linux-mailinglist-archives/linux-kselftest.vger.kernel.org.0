Return-Path: <linux-kselftest+bounces-24803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97BA17283
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 19:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 750F87A34DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 18:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784501EE7B6;
	Mon, 20 Jan 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJVeEfca"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E06C186E58
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737396210; cv=none; b=swgKuTneNB+Bm/v/uis1LgNfmXRHTp9qdjLiyVEc/tH80Y11FbPBHhOiHn930CGYJnEwrjoYB7k8HD0DcLAKkLsCqj1giwNWhGLh/Lp8dcujZQekL/aYDN3XzCSP4XkJUQERITRw1r1lpwyJ/7+FuueY1ixlUZWny226ulbXxFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737396210; c=relaxed/simple;
	bh=OnYOBlwRt2h+lGmMJjZPrgCtqhuuDo3+rXHXvQquy5A=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=iCIAZlG+ra19/AK2qrzgnCjpIe4qwGeSqq8EXMCtsQ90uihw3DdR2t2mfdDyMLEV01wTFRTklB1qxn1Yx5zVrmaswxa7EJQsf1pfe6yg7wRuINBPxjv5D5l5pYTb88OYEZOyfCN97b09mvSvH+2mGeDKhS+HXDBqiEBcVmKV+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJVeEfca; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2addd5053bfso3567657fac.3
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 10:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737396206; x=1738001006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xAielVBxCJ6WhBq7MgTSaFFDOlTnnMStQX3hT8+4ErI=;
        b=OJVeEfcaQKTB26E/kRp3YcVZY4rgRzWsxFRP0PawMLi7FGk/hcVvOkLrKdieusgYZ7
         HjOEnQ1sXD4xSh9T5nf2s1/HpJTZ5PG6t+VeDuEt9M++ZJF6hpJOXgvxMnuuJGAsrA5w
         8birdADgbeSvYlaIUGp4coWWj2k2d+gmEqOlTga1P9lKmtSrlzVzc8nWaqlp0qYUdkUA
         W4KBlyp5rzu+Ba7+PfHyYyygjX9+A8T5A2ZQdfJrV8d0k/5Hep0Lfc+P2MD5fuvYWwxM
         6SOIwlsslQtXPi6D3flRedkLBGVVJyxm0HvuIYLky3c6825CBpZUCX12MkoNzS2sBg8Q
         KEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737396206; x=1738001006;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAielVBxCJ6WhBq7MgTSaFFDOlTnnMStQX3hT8+4ErI=;
        b=o9y2qQmx4A9/poaXbiKfjxklTsgZlLrPY7R1irlxE5G7VbxdH3PfwF5RIj/JmsB3xz
         TuvRLlS/4doNw3UnVeRs4WvpDbaBkQeKZoHmjC0dY8lC8ltbWqP8yBv7f4pESPSkIg1O
         P1tMONEIJ1iPWw7dNDuDKz1XPSbi0EX+wYanU6KJIbKqO0z2Yp9yogv4Z+8rq/y9wQUm
         lqqfL4w5feFu6az52EJHYLVbjt6nt9DcB2Xt7HhhPdTUKIm696sVz/PfMBI0K25WgrU1
         B5T08peDdvTwzeRXmkJEgdmF3pZE6wuBzIMT/p7KljflVexAY/at+/TrzNPsA9dGzVuu
         zfCw==
X-Forwarded-Encrypted: i=1; AJvYcCXDRyueccvSsviQNpSKY2IpIRlsKW2sMv4SLrNa0ESm/yMjacuzzf8KHAo7HtijUhSkUG/gvmBI1jh2+iThqFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfCcCQWLL5TUrI2xoxwBtdv3YActcXZ5WmTfZ+NXWLcU7oNSKS
	A7jd7EVIYUnO8wO91Y93WJm3lySofQBV+no7T1qcl73RpOdUCMst3Uf46qT7kLIW4dlvmDkcn+c
	yiyVXXSoh3vlkXrAqh0IwKw==
X-Google-Smtp-Source: AGHT+IG9ii1JO8QU6byqwcTmDP437YmYaXev3Cr2KOs3EWfVC/KlKymtDWFXgBz6J3IpTWlDXM21MiBsfxPyj6mkxw==
X-Received: from oabhb18.prod.google.com ([2002:a05:6870:7812:b0:2a8:47f:e4e2])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:e07:b0:297:28ec:9b26 with SMTP id 586e51a60fabf-2b1c0e5233cmr8307141fac.33.1737396206701;
 Mon, 20 Jan 2025 10:03:26 -0800 (PST)
Date: Mon, 20 Jan 2025 18:03:25 +0000
In-Reply-To: <Z37FYUU4ppiZsa68@google.com> (message from Sean Christopherson
 on Wed, 8 Jan 2025 10:35:13 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntplkh2wia.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2 3/6] KVM: x86: selftests: Set up AMD VM in pmu_counters_test
From: Colton Lewis <coltonlewis@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, mizhang@google.com, ljr.kernel@gmail.com, 
	jmattson@google.com, aaronlewis@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hey Sean,

Thanks for the review.

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Sep 18, 2024, Colton Lewis wrote:
>> Branch in main() depending on if the CPU is Intel or AMD. They are
>> subject to vastly different requirements because the AMD PMU lacks
>> many properties defined by the Intel PMU including the entire CPUID
>> 0xa function where Intel stores all the PMU properties. AMD lacks this
>> as well as any consistent notion of PMU versions as Intel does. Every
>> feature is a separate flag and they aren't the same features as Intel.

>> Set up a VM for testing core AMD counters and ensure proper CPUID
>> features are set.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   .../selftests/kvm/x86_64/pmu_counters_test.c  | 104 ++++++++++++++----
>>   1 file changed, 83 insertions(+), 21 deletions(-)

>> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c  
>> b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
>> index 0e305e43a93b..5b240585edc5 100644
>> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
>> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
>> @@ -30,10 +30,21 @@
>>   #define NUM_INSNS_RETIRED		(NUM_LOOPS * NUM_INSNS_PER_LOOP +  
>> NUM_EXTRA_INSNS)


>> +/*
>> + * Limit testing to MSRs that are actually defined by Intel (in the  
>> SDM).  MSRs
>> + * that aren't defined counter MSRs *probably* don't exist, but there's  
>> no
>> + * guarantee that currently undefined MSR indices won't be used for  
>> something
>> + * other than PMCs in the future.
>> + */
>> +#define MAX_NR_GP_COUNTERS	8
>> +#define MAX_NR_FIXED_COUNTERS	3
>> +#define AMD_NR_CORE_COUNTERS	4
>> +#define AMD_NR_CORE_EXT_COUNTERS	6
>> +
>>   static uint8_t kvm_pmu_version;
>>   static bool kvm_has_perf_caps;

>> -static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu  
>> **vcpu,
>> +static struct kvm_vm *intel_pmu_vm_create(struct kvm_vcpu **vcpu,
>>   						  void *guest_code,

> When renaming things, please fixup the alignment as needed.  Yes, it's  
> more
> churn, but one-time pain is preferable to living indefinitely with funky  
> formatting.

Understood

> I also don't like renaming just one symbol.  E.g. the above  
> MAX_NR_GP_COUNTERS
> and MAX_NR_FIXED_COUNTERS #defines are Intel specific, but that's not at  
> all
> clear from the code.  Ditto for guest_rd_wr_counters() vs.
> guest_test_rdwr_core_counters().

> Given how little code is actually shared between Intel and AMD, I think  
> it makes
> sense to have the bulk of the code live in separate .c files.  Since
> tools/testing/selftests/kvm/lib/x86/pmu.c is already a thing, the best  
> option is
> probably to rename pmu_counters_test.c to intel_pmu_counters_test.c, and  
> then
> extract the common bits to lib/x86/pmu.c (or include/x86/pmu.h as  
> appropriate).

Yeah I see what you mean about making processor-specific functions more
obvious and think separating to different files would help a lot with
that.

>>   						  uint8_t pmu_version,
>>   						  uint64_t perf_capabilities)
>> +static void test_core_counters(void)
>> +{
>> +	uint8_t nr_counters = nr_core_counters();
>> +	bool core_ext = kvm_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
>> +	bool perfmon_v2 = kvm_cpu_has(X86_FEATURE_PERFMON_V2);
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvm_vm *vm;
>> +
>> +	for (uint8_t ce = 0; ce <= core_ext; ce++) {

> Kernel style is to not declared variables inside for-loops.

I ran it through checkpatch and it didn't complain.

>> +		for (uint8_t pm = 0; pm <= perfmon_v2; pm++) {

> Iterating over booleans is decidedly odd, the indentation levels are  
> painful and
> will only get worse as more features are added, and the "ce" and "pm"  
> variables
> aren't all that intuitive.  More below.
>> +			for (uint8_t nc = 0; nc <= nr_counters; nc++) {

> I also find "nc" to be unintuitive.  Either use a fully descriptive name,  
> or
> make it obvious that the variables is an iterator.  E.g. either

> 	uint8_t max_nr_counters = nr_core_counters();

> 	...

> 		for (nr_counters = 0; nr_counters < max_nr_counters; nr_counters++) {


> or

> 		for (j = 0; j < nr_counters; j++) {


> 'j' is obviously not descriptive, but when reading the usage, it's more  
> obvious
> that it's a loop iterator (if you choose

Ok I'll go with the generic loop iterator name.

>> +				vm = vm_create_with_one_vcpu(&vcpu, guest_test_core_counters);
>> +
>> +				if (nc)

> Is '0' not a legal number of counters?

AMD64 Architecture Programmers Manual Volume 2 Chapter 13.2.2 states
that only nonzero values for that property are meaningful.

With 0, you are supposed to assume either 4 or 6 counters depending on
the CoreExt feature.

I could make 0 mean 0 counters inside the guest but that would break
what hardware does.

>> +					vcpu_set_cpuid_property(

> Google3!  (Never, ever wrap immediately after the opening paranethesis).

Checkpatch didn't complain.

>> +						vcpu, X86_PROPERTY_NUM_PERF_CTR_CORE, nc);
>> +				if (ce)
>> +					vcpu_set_cpuid_feature(
>> +						vcpu, X86_FEATURE_PERF_CTR_EXT_CORE);

> This likely doesn't do what you want.  By default, vm_arch_vcpu_add()  
> initializes
> CPUID to KVM's supported CPUID.  So only _setting_ the feature means that  
> that
> the test is likely only ever running with the full set of supported  
> features.

Ok, so I have to explicitly unset the feature if I don't want it.

> Jumping back to my complaints with the for-loops, if the features to  
> interate on
> are collected in an array, then the test can generate a mask of all  
> possible
> combinations and iterate over that (plus the array itself).  That keeps  
> the
> indentation bounded and eliminates the copy+paste needed to add a new  
> feature.
> The only downside is that the test is limited to 64 features, but we'll  
> run into
> run time issues long before that limit is reached.

> 	const struct kvm_x86_cpu_feature pmu_features[] = {
> 		X86_FEATURE_PERF_CTR_EXT_CORE,
> 		X86_FEATURE_PERFMON_V2,
> 	};

> 	const u64 pmu_features_mask = BIT_ULL(ARRAY_SIZE(pmu_features)) - 1;

> 	for (mask = 0; mask <= pmu_features_mask; mask++) {
> 		for (nr_counters = 0; nr_counters < max_nr_counters; nr_counters++) {
> 			vm = vm_create_with_one_vcpu(&vcpu, guest_test_core_counters);

> 			vcpu_set_cpuid_property(vcpu, X86_PROPERTY_NUM_PERF_CTR_CORE,
> 						nr_counters);

> 			/* Comment goes here */
> 			for (i = 0; i < ARRAY_SIZE(pmu_features); i++)
> 				vcpu_set_or_clear_cpuid_feature(vcpu, pmu_features[i],
> 								mask & BIT_ULL(i));

> 			...
> 	}

I thought of putting the features in a bitmask but worried it obscured
the intent too much. Listing features in an array and constructing the
bitmask seems clear enough to me so I will use that technique now.

>> +				if (pm)
>> +					vcpu_set_cpuid_feature(
>> +						vcpu, X86_FEATURE_PERFMON_V2);
>> +
>> +				pr_info("Testing core counters: CoreExt = %u, PerfMonV2 = %u,  
>> NumCounters = %u\n",
>> +					ce, pm, nc);
>> +				run_vcpu(vcpu);
>> +
>> +				kvm_vm_free(vm);
>> +			}
>> +		}
>> +	}
>> +}

