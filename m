Return-Path: <linux-kselftest+bounces-17001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF0968D96
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 20:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165B71C21E64
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597141C62BA;
	Mon,  2 Sep 2024 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p81gWxaR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4581AB6F0
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Sep 2024 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302260; cv=none; b=nVgBtKTyzSRJfeOWsLoxbWT8l4bcE/4WrYHlTp3noc63ihkyU7WAF5kpOnegjlkQp5KW8y/NsVV1+HKldC3gAXfLunOpVDSJmQZS3vrzx+LNNMqN5Xk2ZhuCmDjmDHptY+mCgfc/x1dEn1xataNhn/QU5P1zRBJ1rFryAzx3Yao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302260; c=relaxed/simple;
	bh=0f1aN9HLbWF92dFi99NsPlbmjKqZ++MNJBcwsjyzqWg=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=l6zNmU6CyHS/by5LiE8iShyzy8pGGwYGRnjPm6povQGABHza+T+QcKtRh84nSaQzerdFJmZLL6AiDrc3pegy+n8jje2krPG6rKPbP3OAyo3eVaDzm37C/6Qj19g3rf3G9pvWp5siSquJVXsS5/S5SI044SHyjs2aIg9RsQSB0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p81gWxaR; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-82a1fbaba4aso321000439f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Sep 2024 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725302257; x=1725907057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nAO/71uT5RCAsBJVu4g+dwe4+a2p2kFZ1jdndEbhd+o=;
        b=p81gWxaR6mfBj2uJUybRfMAov24UYxjpQVk+WPzMhg6b4ab+wFJGq5oJUdGcD1aKO1
         NjXiAWZVBr+8rLJwxpwubnA7izc6vBey+XXUluAtuRRF/zSBUPZ6TKV9hP5b10MIbuko
         obTrpFy7xsgEV2e2v0gom7RVSma4CJMQ8FT+WsVCuyHWZrQu4JDIv8uxbPtr8yeQOOj4
         yAhoLlep9fK71AaHD+x4U3uzBntIrngHn27rs1wbXMCQrz9+2UZgHmI53BRcg5Q8yH3t
         UmIfIdST5/8L5Z0/+Yx/OvCSyX+00DI9MzsIduTwxyrVUIkAJA1qvqm1ScX6jD4Z1wKr
         ZTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302257; x=1725907057;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAO/71uT5RCAsBJVu4g+dwe4+a2p2kFZ1jdndEbhd+o=;
        b=D27k16SL6lwQ4kbt4hrynW0BZAiGzrtRwDBESbDc+6HhXscDtgjJxQlUghf0OeaXWz
         Ye39Qjf0Z7sukS1uXuttK+9gQWUgVnrBFLCsOAqGg28T+MVCXdm+yqd//cs5/qNSg69I
         c2JnotwWTRMb3oOJ261tA4E/dyqZRyrS8XoCOY86CTA2N0Ge6bBhUGZ5b2sczk7AhM8I
         3knVka0FyuSctvokx05RfnzTvN+GJOqhn1/ztRAmh+Dckw4ECYakEouqj0d8CWTM2XqJ
         Htk7dzrKeq3XiPT2otIpIDgnAGIqoO9U9YKUwxY7mNXBlH+mrF8gHT4c0PmdLwS37DXg
         DMSw==
X-Forwarded-Encrypted: i=1; AJvYcCUnAWbIyXdveb5w4JilgNEGbhICgkXW9xZQO8/bLILrcAM/Wvvjm8KvgYvTKUn+7aNwg83zAqE9ixt6xh0C/go=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXstC4C9Id/cEPLcSt7LGdHbIHlj3ZRpThWWCzLYvPU+PxVbnu
	cRo0r943G8YTk0ObMGJJBcGCBUP2k2HKkvyKV+Tq4WH+BOq6dDhVSufwInwWYEs5G+U8E8oR8vU
	ohOolUvQRJK9DCqgdYgJHdQ==
X-Google-Smtp-Source: AGHT+IEklshSlPXSKl7m3pGgCZOFN2urZDLNUZ1eyTQmaZKHwzCs7QJN/43WSSevJlLHSgMuDO6x0IIt8x1YU2sS7w==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:3494:b0:4ce:928f:ad9a with
 SMTP id 8926c6da1cb9f-4d017a1e518mr490136173.1.1725302257619; Mon, 02 Sep
 2024 11:37:37 -0700 (PDT)
Date: Mon, 02 Sep 2024 18:37:37 +0000
In-Reply-To: <ZtDd9YVc33b8Qt__@google.com> (message from Sean Christopherson
 on Thu, 29 Aug 2024 13:45:41 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntcyllaolq.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 3/6] KVM: x86: selftests: Set up AMD VM in pmu_counters_test
From: Colton Lewis <coltonlewis@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: mizhang@google.com, kvm@vger.kernel.org, ljr.kernel@gmail.com, 
	jmattson@google.com, aaronlewis@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Aug 28, 2024, Mingwei Zhang wrote:
>> > >> +static void test_core_counters(void)
>> > >> +{
>> > >> +    uint8_t nr_counters = nr_core_counters();
>> > >> +    bool core_ext = kvm_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
>> > >> +    bool perf_mon_v2 = kvm_cpu_has(X86_FEATURE_PERF_MON_V2);
>> > >> +    struct kvm_vcpu *vcpu;
>> > >> +    struct kvm_vm *vm;
>> >
>> > >> -    kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
>> > >> -    kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
>> > >> +    vm = vm_create_with_one_vcpu(&vcpu, guest_test_core_counters);
>> >
>> > >> -    test_intel_counters();
>> > >> +    /* This property may not be there in older underlying CPUs,
>> > >> +     * but it simplifies the test code for it to be set
>> > >> +     * unconditionally.

> But then the test isn't verifying that KVM is honoring the architecture.   
> I.e.
> backdooring information to the guest risks getting false passes because  
> KVM
> incorrectly peeks at the same information, which shouldn't exist.

>> > >> +     */

> 	/*
> 	 * Multi-line function comments should start on the line after the
> 	 * opening slash-asterisk, like so.
> 	 */

>> > >> +    vcpu_set_cpuid_property(vcpu, X86_PROPERTY_NUM_PERF_CTR_CORE,
>> > >> nr_counters);
>> > >> +    if (core_ext)
>> > >> +            vcpu_set_cpuid_feature(vcpu,  
>> X86_FEATURE_PERF_CTR_EXT_CORE);
>> > >> +    if (perf_mon_v2)
>> > >> +            vcpu_set_cpuid_feature(vcpu, X86_FEATURE_PERF_MON_V2);
>> >
>> > > hmm, I think this might not be enough. So, when the baremetal machine
>> > > supports Perfmon v2, this code is just testing v2. But we should be  
>> able
>> > > to test anything below v2, ie., v1, v1 without core_ext. So, three
>> > > cases need to be tested here: v1 with 4 counters; v1 with core_ext (6
>> > > counters); v2.
>> >
>> > > If, the machine running this selftest does not support v2 but it does
>> > > support core extension, then we fall back to test v1 with 4 counters  
>> and
>> > > v1 with 6 counters.
>> >
>> > This should cover all cases the way I wrote it. I detect the number of
>> > counters in nr_core_counters(). That tells me if I am dealing with 4 or
>> > 6 and then I set the cpuid property based on that so I can read that
>> > number in later code instead of duplicating the logic.

>> right. in the current code, you set up the counters properly according
>> to the hw capability. But the test can do more on a hw with perfmon
>> v2, right? Because it can test multiple combinations of setup for a
>> VM: say v1 + 4 counters and v1 + 6 counters etc. I am just following
>> the style of this selftest on Intel side, in which they do a similar
>> kind of enumeration of PMU version + PDCM capabilities. In each
>> configuration, it will invoke a VM and do the test.

> Ya.  This is similar my comments on setting NUM_PER_CTR_CORE when the  
> field
> shouldn't exist.  One of the main goals of this test is to verify the KVM  
> honors
> the architecture based on userspace's defined virtual CPU model, i.e.  
> guest
> CPUID.  That means testing all (or at least, within reason) possible  
> combinations
> that can feasibly be supported by KVM given the underlying hardware.

> As written, this essentially just tests the maximal configuration that  
> can be
> exposed to a guest, which isn't _that_ interesting because KVM tends to  
> get plenty
> of coverage for such setups, e.g. by running "real" VMs.

Ok. I get what you and Mingwei are saying. I can test those combinations.

