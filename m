Return-Path: <linux-kselftest+bounces-24807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E25A17361
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 20:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CCE37A1774
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 19:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C5F1F03E3;
	Mon, 20 Jan 2025 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvDEIPi3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D590B1EF0B4
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402897; cv=none; b=SsfcA+tGmeUP+8fP7GPnF4KkIfGmXQrFPbAz7UI0DDwuZv1LvqvK/Hxs1kH7Sl6VTsX1YVIJysnTvF6g+qU2aDdztxbdUlgA0ddRvTPjHJ4z2hg4BEj58EJ9pWOinKjWjL6SGuBH/VGepjPsqnG7AMJABfMTKouw1ITZkIsB9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402897; c=relaxed/simple;
	bh=buzX0uIYG2OYi7c4J/JURtXULgKORQkXEsZYmZeZOAg=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=uR8G2w5PEz/SGVDV6bfulJBms9xtyr6Az6MPqeDdq9svDULt7DxlJxjDuCfePS4ee1LDNwlR0ZePPiV49/ngvgQHw0mpYPYaQtxwVKS9U9XNKDrhvEmPMsjtJ9Yo9UkedGZmcWWrZCbdee9z24KutfBfsqs+Yh4eDNUgNFN63KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZvDEIPi3; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-844e3943987so328455739f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 11:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737402895; x=1738007695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WJCTAYCrgGEytrV0OJwIpIhqe3JDy+IiCXHqoWVAPSU=;
        b=ZvDEIPi3SCPJH70RX80EgceuVZY8xrQZUTTD2n+KscBKZDjZ+BHm5cmMS/eaBoq94c
         NtP5CNgGSuhPjbswKG3Sj6ACc8GY2DSq/G/GDHZRlSOnJaPHXoDNmQ6SJtXmpFoAaTsJ
         nCbQMjCLA+8LuAU7echu1kMnQwgjIyIiAFudz0HBFTcvGld3uXxS8HIL35JVhBDRhnql
         5sf5WFfIAfxHYLJzIjAbe7w/iWnLawq41apwC7cCqvz9VbjqGvsgbzH8Rd9H3U9jSShL
         etmtka4uRvrPH2lFbzFvHZT8nfjslAzpfzmyjz96AcOZE+RNTQH4fRYZmZUDprnpqnR8
         kHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737402895; x=1738007695;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJCTAYCrgGEytrV0OJwIpIhqe3JDy+IiCXHqoWVAPSU=;
        b=bGAQ1JmCWck6m7rEViJR+ooWgZrqKbas1+aNcbO43LZR+0F3GJmqIP4PdW2ulnOhXh
         OvoHx5OhIXe/atQd2l2lRmAG56KsZpdW+xufdWwrIBmvfx5szLN4w/S7t4LyhhsH1zAo
         V89xf42l/ehUUqDu6rOWuFICQBOwxH16Eb79rEDNDNPyDEFJShjX9bdwVcxeti3YiIlP
         gu9yhnuct2O2PvCJFx2UCumLpngbXlcRPUCQ32hxCdCrvJhKnUjLGR87spVVspkqSvOZ
         DEizRiFX0cP6Ww5q3j1dGYqXx3UiOg4xBLWJLHLqvI8bPvJ+MwRLfRup92YHnwnX8rAb
         MNbA==
X-Forwarded-Encrypted: i=1; AJvYcCUmXNHy6/ugiJdBTl04ida1ZMmh+2OrA0mbtcQ7QgKJ2QS9Szozy/D8AdGdkeYZm32arB79LY4ggpZpaUmFxGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0iL55BdSp8gpXe/p4r4KXyrAcwK2KKl/8w1iF6DJlWw+p4SWC
	lrEywjDtwLMowsiTvlz3GgNiUwUGvNXdQO3wrtbEYBOwmXn02zMnokWxImN0kKrui7WWq03pOXN
	pFNLRp5S1vo6ObX7JdxDJOg==
X-Google-Smtp-Source: AGHT+IGdUIcldOfOqdxMvphi8DxIREObcU7xus5HY8t4YpLAf0zybKTtrAqvkVxhHADo3zSyFQ4jHO+hkXijAJe+Xg==
X-Received: from jaat21.prod.google.com ([2002:a05:6638:c115:b0:4e8:1778:12dc])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:6408:b0:84f:2929:5ec0 with SMTP id ca18e2360f4ac-851b618c4b5mr1201581239f.4.1737402894953;
 Mon, 20 Jan 2025 11:54:54 -0800 (PST)
Date: Mon, 20 Jan 2025 19:54:54 +0000
In-Reply-To: <Z37J1jJCTBZk-0cs@google.com> (message from Sean Christopherson
 on Wed, 8 Jan 2025 10:54:14 -0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntmsfl2rch.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2 4/6] KVM: x86: selftests: Test read/write core counters
From: Colton Lewis <coltonlewis@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, mizhang@google.com, ljr.kernel@gmail.com, 
	jmattson@google.com, aaronlewis@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Sep 18, 2024, Colton Lewis wrote:
>> Run a basic test to ensure we can write an arbitrary value to the core
>> counters and read it back.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   .../selftests/kvm/x86_64/pmu_counters_test.c  | 54 +++++++++++++++++++
>>   1 file changed, 54 insertions(+)

>> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c  
>> b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
>> index 5b240585edc5..79ca7d608e00 100644
>> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
>> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
>> @@ -641,11 +641,65 @@ static uint8_t nr_core_counters(void)
>>   		return AMD_NR_CORE_EXT_COUNTERS;

>>   	return AMD_NR_CORE_COUNTERS;
>> +}
>> +
>> +static uint8_t guest_nr_core_counters(void)
>> +{
>> +	uint8_t nr_counters =  
>> this_cpu_property(X86_PROPERTY_NUM_PERF_CTR_CORE);
>> +	bool core_ext = this_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);

> For both this and nr_core_counters(), there's no need to read  
> PERF_CTR_EXT_CORE
> if nr_counters is non-zero, and then no need to capture it in a local  
> variable.

Sure but since I might need it and don't see why the performance cost
matters for a test that is only calling it a few times, I thought the
code looked nicer to just read it up front when I declare the variable.

I can change it.

>> +
>> +	if (nr_counters != 0)
>> +		return nr_counters;
>> +
>> +	if (core_ext)
>> +		return AMD_NR_CORE_EXT_COUNTERS;
>> +
>> +	return AMD_NR_CORE_COUNTERS;

> This is *painfully* similar to nr_core_counters().  It actually took me  
> almost
> a minute of staring to see the difference.  One option would be to add a  
> helper
> to dedup the if-statements, but while somewhat gross, I actually think a  
> macro
> is the way to go.

> #define nr_core_counters(scope)								\
> ({											\
> 	uint8_t nr_counters =  
> scope##_cpu_property(X86_PROPERTY_NR_PERFCTR_CORE);	\
> 											\
> 	if (!nr_counters) {								\
> 		if (scope##_cpu_has(X86_FEATURE_PERFCTR_CORE))				\
> 			nr_counters = AMD_NR_CORE_EXT_COUNTERS;				\
> 		else									\
> 			nr_counters = AMD_NR_CORE_COUNTERS;				\
> 	}										\
> 	nr_counters;									\
> })

> static uint8_t kvm_nr_core_counters(void)
> {
> 	return nr_core_counters(kvm);
> }

> static uint8_t guest_nr_core_counters(void)
> {
> 	return nr_core_counters(this);

> }

Point taken. I'll go with the macro.

>> +

> Unnecessary newline.

Will delete

>> +}

>> +static void guest_test_rdwr_core_counters(void)
>> +{
>> +	bool core_ext = this_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
>> +	uint8_t nr_counters = guest_nr_core_counters();
>> +	uint8_t i;
>> +	uint32_t esel_msr_base = core_ext ? MSR_F15H_PERF_CTL :  
>> MSR_K7_EVNTSEL0;

> Please don't concoct new abbreviations.  "esel" isn't used anywhere in  
> KVM, and
> AFAICT it's not used in perf either.

I'll avoid that in the future

> I would also prefer to have consistent naming between the Intel and AMD  
> tests
> (the Intel test uses base_<name>_msr).

Done

> base_eventsel_msr is all of four characters more.

>> +	uint32_t cnt_msr_base = core_ext ? MSR_F15H_PERF_CTR : MSR_K7_PERFCTR0;

> For better or worse, the Intel version uses "base_pmc_msr".  I see no  
> reason to
> diverage from that.


Done

>> +	uint32_t msr_step = core_ext ? 2 : 1;
>> +
>> +	for (i = 0; i < AMD_NR_CORE_EXT_COUNTERS; i++) {
>> +		uint64_t test_val = 0xffff;
>> +		uint32_t esel_msr = esel_msr_base + msr_step * i;
>> +		uint32_t cnt_msr = cnt_msr_base + msr_step * i;

> And then
> 		uint32_t eventsel_msr = ...;
> 		uint32_t pmc_msr = ...;

>> +		bool expect_gp = !(i < nr_counters);

> Uh, isn't that just a weird way of writing:

> 		bool expect_gp = i >= nr_counters;

Yes they are logically equivalent. I thought it was clearer by
emphasizing it was the negation of "i is a valid counter" (i <
nr_counters)

But I'll change it

>> +		uint8_t vector;
>> +		uint64_t val;
>> +
>> +		/* Test event selection register. */

> This is pretty obvious if the MSR is named eventsel_msr.

Will delete

>> +		vector = wrmsr_safe(esel_msr, test_val);
>> +		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, esel_msr, expect_gp, vector);
>> +
>> +		vector = rdmsr_safe(esel_msr, &val);
>> +		GUEST_ASSERT_PMC_MSR_ACCESS(RDMSR, esel_msr, expect_gp, vector);
>> +
>> +		if (!expect_gp)
>> +			GUEST_ASSERT_PMC_VALUE(RDMSR, esel_msr, val, test_val);
>> +
>> +		/* Test counter register. */

> Same thing here.  If there is novel information/behavior, then by all  
> means add
> a comment.

Will delete

>> +		vector = wrmsr_safe(cnt_msr, test_val);
>> +		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, cnt_msr, expect_gp, vector);
>> +
>> +		vector = rdmsr_safe(cnt_msr, &val);
>> +		GUEST_ASSERT_PMC_MSR_ACCESS(RDMSR, cnt_msr, expect_gp, vector);
>> +
>> +		if (!expect_gp)
>> +			GUEST_ASSERT_PMC_VALUE(RDMSR, cnt_msr, val, test_val);
>> +	}
>>   }

>>   static void guest_test_core_counters(void)
>>   {
>> +	guest_test_rdwr_core_counters();
>>   	GUEST_DONE();
>>   }

>> --
>> 2.46.0.662.g92d0881bb0-goog


