Return-Path: <linux-kselftest+bounces-24808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C24A17367
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 21:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1182E165A44
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 20:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA11190067;
	Mon, 20 Jan 2025 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="as0lxDLB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7726715383D
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737403290; cv=none; b=d4U9kgO/L6oWgxhhiAC55C8t287ErgjjE6GH/+meYtY5BkS39W9qVFO5Ow4e7K4z9hQ5mqkaB4JqSELlmiXBLe+qohmU/1q/YCTR83EK/J+m/DCrufWnoCh5BZKmCln3r5ot7BUAqor2Kv+HoETNKB7aDVnS3IFjo/kM1k8zU/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737403290; c=relaxed/simple;
	bh=PHWY2uvzGN37282AE4ERA3p9Pnm9vk8rgspqvIwNJ8k=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=QvvOpgZN5+WP6oeWAlG46ls1pf6EKcfgVcFnR0W4L9cnn4TzHTiXUIMrxlnpINay/0RX7eywdSWSRjlWgMuqHjQ1Ou2Y1OPg2k+b+K8Uk3fBTnIPcrOR9diIAc5vr6pGkG6SWEQabQj99Z71Xnj/rZK16LrQSFhWBnxfQFIk96Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=as0lxDLB; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3cdd61a97easo31234545ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 12:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737403287; x=1738008087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WNXuBPht1maGexi4zynW+vVCVHRQJ6NZXZE7tXqnJpk=;
        b=as0lxDLB90XRZKWNwUMxjTrGiSgA3e/OsaIO3w5zWYg+jydB/DtCM1ZmB2eL5W5jaW
         w40Wj3DFaiGHkr27XKDc+Mv4UlaBwUI72Hoyl1ilZiUHITdR3veHrxQbd+lJ9CQakA3j
         cpvdtCFHuOjEjyMFEjkxmjnXVew7bvhBHfWYVuM/4pTE3mKPm55WNmh5z5bFTjtSR0Gn
         clqIZeHeNKZn5WNG8oG8N8NItnL90fxcH68Wtag3jmwVes/wa9pyRTOynyRkqDR+dbgj
         kFFDizk0HkvTpV39BVXHaoWy1CCEPCbDy5D0BIcYsakxC1tYfKwlobNLgAead30HyZLd
         LYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737403287; x=1738008087;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNXuBPht1maGexi4zynW+vVCVHRQJ6NZXZE7tXqnJpk=;
        b=RHPyUsJyrxGqIfLjpvxJcKVhFJncOFJeAklzNLIOAf5wFCk8XYOpAwrBY4IZChu+bs
         GaGo3zV7Xs7sJth/IbWUHbH8/276srXsuaPTcF8hXYvFWy53POPFMHAN6RMi6DNzX3CK
         MMnzDCKFgwoHnqKwnx4fUWH71JgYtJApF9f9ZEOgJo0sc/m0WgYidSeYs+RZ2czJ0qen
         0sp1RBOV1w6ZObMyklLv8pmbTjcEHF04lr+ikCojta6vKkch5MTPXtxbWeLwidPWXmos
         n0bGWs5QqFKuoLF8KPrmVSSLUXSD3B4Peg3DWTK9WiYglRusNrYZdX/fKSro9v2EVAsM
         JUOg==
X-Forwarded-Encrypted: i=1; AJvYcCX3woWnWYPkicKEwpCKPsYFFKhYouYWkDenWm2nywwCsZ1085q1MK6VXrbvaRYqQ8U+M+m8Z6SVW47lP8nvAOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVTHwzPnySttpbyAUgkj399lN9wah0CZioAm3zSsEzdSe9RO/
	8GulaVQG/QYH8+7v97jtXKnN4SK6wpd7x5tIpXWqWB0EF9rBqoz3An9/z0x2Pji1VvBRsgvruS9
	SyxvZttw5rhJrsCfZxEP0yw==
X-Google-Smtp-Source: AGHT+IHJpGRzZY5y6d+QpJKXm03fM4OTcwUVm4zk6Z6Hcm85yj5drejBntwLUCDvalX41wtf28gtHfxChfOIxFk3+Q==
X-Received: from ilbcc10.prod.google.com ([2002:a05:6e02:98a:b0:3cf:a082:8561])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:3f0b:b0:3ce:a676:5cec with SMTP id e9e14a558f8ab-3cf743aba5bmr122858875ab.1.1737403287633;
 Mon, 20 Jan 2025 12:01:27 -0800 (PST)
Date: Mon, 20 Jan 2025 20:01:26 +0000
In-Reply-To: <Z37Seos1zVHk0-p7@google.com> (message from Sean Christopherson
 on Wed, 8 Jan 2025 11:31:06 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntjzap2r1l.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2 5/6] KVM: x86: selftests: Test core events
From: Colton Lewis <coltonlewis@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, mizhang@google.com, ljr.kernel@gmail.com, 
	jmattson@google.com, aaronlewis@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Sep 18, 2024, Colton Lewis wrote:
>> Test events on core counters by iterating through every combination of
>> events in amd_pmu_zen_events with every core counter.

>> For each combination, calculate the appropriate register addresses for
>> the event selection/control register and the counter register. The
>> base addresses and layout schemes change depending on whether we have
>> the CoreExt feature.

>> To do the testing, reuse GUEST_TEST_EVENT to run a standard known
>> workload. Decouple it from guest_assert_event_count (now
>> guest_assert_intel_event_count) to generalize to AMD.

>> Then assert the most specific detail that can be reasonably known
>> about the counter result. Exact count is defined and known for some
>> events and for other events merely asserted to be nonzero.

>> Note on exact counts: AMD counts one more branch than Intel for the
>> same workload. Though I can't confirm a reason, the only thing it
>> could be is the boundary of the loop instruction being counted
>> differently. Presumably, when the counter reaches 0 and execution
>> continues to the next instruction, AMD counts this as a branch and
>> Intel doesn't

> IIRC, VMRUN is counted as a branch instruction for the guest.  Assuming  
> my memory
> is correct, that means this test is going to be flaky as an asynchronous  
> exit,
> e.g. due to a host IRQ, during the measurement loop will inflate the  
> count.  I'm
> not entirely sure what to do about that :-(

:-( but thanks for the explanation

>> +static void __guest_test_core_event(uint8_t event_idx, uint8_t  
>> counter_idx)
>> +{
>> +	/* One fortunate area of actual compatibility! This register

> 	/*
> 	 * This is the proper format for multi-line comments.  We are not the
> 	 * crazy net/ folks.
> 	 */

Will do. As with some other formatting comments, checkpatch didn't
complain.

>> +	 * layout is the same for both AMD and Intel.

> It's not, actually.  There are differences in the layout, it just so  
> happens that
> the differences don't throw a wrench in things.

> The comments in tools/testing/selftests/kvm/include/x86_64/pmu.h document  
> this
> fairly well, I don't see any reason to have a comment here.

Will delete the comment

>> +	 */
>> +	uint64_t eventsel = ARCH_PERFMON_EVENTSEL_OS |
>> +		ARCH_PERFMON_EVENTSEL_ENABLE |
>> +		amd_pmu_zen_events[event_idx];

> Align the indentation.

> 	uint64_t eventsel = ARCH_PERFMON_EVENTSEL_OS |
> 			    ARCH_PERFMON_EVENTSEL_ENABLE |
> 			    amd_pmu_zen_events[event_idx];

Will do

>> +	bool core_ext = this_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
>> +	uint64_t esel_msr_base = core_ext ? MSR_F15H_PERF_CTL :  
>> MSR_K7_EVNTSEL0;
>> +	uint64_t cnt_msr_base = core_ext ? MSR_F15H_PERF_CTR : MSR_K7_PERFCTR0;
>> +	uint64_t msr_step = core_ext ? 2 : 1;
>> +	uint64_t esel_msr = esel_msr_base + msr_step * counter_idx;
>> +	uint64_t cnt_msr = cnt_msr_base + msr_step * counter_idx;

> This pattern of code is copy+pasted in three functions.  Please add  
> macros and/or
> helpers to consolidate things.  These should also be uint32_t, not 64.

Will do

> It's a bit evil, but one approach would be to add a macro to iterate over  
> all
> PMU counters.  Eating the VM-Exit for the CPUID to get  
> X86_FEATURE_PERF_CTR_EXT_CORE
> each time is unfortunate, but I doubt/hope it's not problematic in  
> practice.  If
> the cost is meaningful, we could figure out a way to cache the info, e.g.  
> something
> awful like this might work:

> 	/* Note, this relies on guest state being recreated between each test. */
> 	static int has_perfctr_core = -1;

> 	if (has_perfctr_core == -1)
> 		has_perfctr_core = this_cpu_has(X86_FEATURE_PERFCTR_CORE);

> 	if (has_perfctr_core) {

> static bool get_pmu_counter_msrs(int idx, uint32_t *eventsel, uint32_t  
> *pmc)
> {
> 	if (this_cpu_has(X86_FEATURE_PERFCTR_CORE)) {
> 		*eventsel = MSR_F15H_PERF_CTL + idx * 2;
> 		*pmc = MSR_F15H_PERF_CTR + idx * 2;
> 	} else {
> 		*eventsel = MSR_K7_EVNTSEL0 + idx;
> 		*pmc = MSR_K7_PERFCTR0 + idx;
> 	}
> 	return true;
> }

> #define for_each_pmu_counter(_i, _nr_counters, _eventsel, _pmc)		\
> 	for (_i = 0; i < _nr_counters; _i++)				\
> 		if (get_pmu_counter_msrs(_i, &_eventsel, _pmc))		\

> static void guest_test_core_events(void)
> {
> 	uint8_t nr_counters = guest_nr_core_counters();
> 	uint32_t eventsel_msr, pmc_msr;
> 	int i, j;

> 	for (i = 0; i < NR_AMD_ZEN_EVENTS; i++) {
> 		for_each_pmu_counter(j, nr_counters, eventsel_msr, pmc_msr) {
> 			uint64_t eventsel = ARCH_PERFMON_EVENTSEL_OS |
> 					    ARCH_PERFMON_EVENTSEL_ENABLE |
> 					    amd_pmu_zen_events[event_idx];

> 			GUEST_TEST_EVENT(pmc_msr, eventsel_msr, eventsel, "");
> 			guest_assert_amd_event_count(i, j, pmc_msr);

> 			if (!is_forced_emulation_enabled)
> 				continue;

> 			GUEST_TEST_EVENT(pmc_msr, eventsel_msr, eventsel, KVM_FEP);
> 			guest_assert_amd_event_count(i, j, pmc_msr);
> 		}
> 	}
> }

I'll experiment with this

