Return-Path: <linux-kselftest+bounces-16726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7229650E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 22:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83CE1F23E8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79EF18A92F;
	Thu, 29 Aug 2024 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkTXxSPP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DAC15DBC1
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964345; cv=none; b=PvdVPMFpL1j9WycU66Hh+BhowyJaB1+hGZr3VqhXMVah34PHetJ2ys70xSVw2aBfmyFDlZrCEgr3+wL3KBHDWtoPyF5cpi2nEZAK/zjhZXB7FrWy8PxWTayAKbCgE9osVjr/UKHOHhLKQw7ee0WobbmO3JOmeHO9mbtxtvAvx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964345; c=relaxed/simple;
	bh=4TZEqBx7eWCdocTsLXNrFut7vdn8ko9P9heYPOQxy4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W3QwtkbTdFaXCFyE25+aon5IAfqixo1RAan+O5l0wPIAOU86mtu7RiLqEz5sQqtV2SvNKd3pYnvC321YOpo7L7duBZ1n67H6L8BQznentLgRabgpvQVgLyBdGTS+kRH5SwhUG3jj/3XYG7nTmSdLG+x0HANRjmqzdA/hI+YQuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkTXxSPP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ac83a71d45so18100517b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724964343; x=1725569143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rF0JnnhJ+6UUAp3OAAeI13+/dbW5hEBVYSBB7nknrZM=;
        b=wkTXxSPPWuTdbJwzK+wH0pG6X9mTeI/WqPtDHCCXeI01rzQliZQBj3plWJFQBZwdBH
         Y+BeE0WPlkCK1MsUXjV2bL0YWQjkqMrJi61MM2rPPE7FNrPjLhYlTGkfY0FrIDqnO4CN
         ogbybt4LPnj25Q5jer/mXPk4fdVz2J5/oT0e0DtK2Oz+5OOMZp+JmdbQT8Zef8NctcZF
         TqXbGdZExySf46TDGHkCvFiVFGH/EmsDY92qIspI49nDkqM4vbgM2jcpNab8g30pEfSH
         wV6cbIvyXxuQAKAfUyEr7qMnANubqkXznw4Aoc5q1XY5nnzfJiYa/qRZhIe/ohnMy5WW
         Lxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724964343; x=1725569143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rF0JnnhJ+6UUAp3OAAeI13+/dbW5hEBVYSBB7nknrZM=;
        b=czCRzoSk2JXDfDj+8mS6yutczPYHl+Pg6zjQvDTo4gcfq55Gx33vTwqIDb/F7iljXU
         Dq/dh/OugUytiNmTVvm/XVSTDvNkipwSfkCzFyYIK3C0iR0kgqVFtjcb/2V8NUYtyvw1
         l0zvYI9QgLHoGmOGUXVS2193hr1YLU+m/XoYllW1m/XLftUWgzqhvMb2q3WCtAIY4Ti9
         rnlGBrORGxd1g2KgoHDZiS07rbmrMu867NMlldYnnLeesjccBDh20ieqUopxplWS+oun
         Ty/2BB18wWuZJ95BQTSAdkUCOCy47rirlpO0Yhr52f9d4KVGwjDK4+G12KEk8yP1yZRj
         7TZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq8fIEjleLZbf1QpuaYCP+bWJBF4fJ0lppGFFVa9xa0Fkn4hQVWKVVNWCyKuqzhoPbe1HPqH9CRhOZcDew6p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEecrdz6Ed35vRKKG69LyXFSLVRoob3ctIZz7fWHVzha4ZDqIe
	S42UwhXr6Fomo2wK/QIZreAVi9ULOsipS9pmxq7J8wcbgb/L4SrQjkqGnntUhVvZHv/YUw3DZlK
	Kww==
X-Google-Smtp-Source: AGHT+IGVP3HvwnzOqRNa87UbyRnTdSkHHKG6AQXQsUhHE0H0PT9PCKyy3tNykxqKPYyhE/+825Ajpugsias=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:d10b:0:b0:6ad:feb0:d010 with SMTP id
 00721157ae682-6d2e94d0921mr569377b3.6.1724964342802; Thu, 29 Aug 2024
 13:45:42 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:45:41 -0700
In-Reply-To: <CAL715W+NPP+mw=_C4b-4iUhML6yVZ=G3uMqXQgY+tjqRrNQusg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Zs0FLglChWqsGa6w@google.com> <gsnth6b49srd.fsf@coltonlewis-kvm.c.googlers.com>
 <CAL715W+NPP+mw=_C4b-4iUhML6yVZ=G3uMqXQgY+tjqRrNQusg@mail.gmail.com>
Message-ID: <ZtDd9YVc33b8Qt__@google.com>
Subject: Re: [PATCH 3/6] KVM: x86: selftests: Set up AMD VM in pmu_counters_test
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org, ljr.kernel@gmail.com, 
	jmattson@google.com, aaronlewis@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 28, 2024, Mingwei Zhang wrote:
> > >> +static void test_core_counters(void)
> > >> +{
> > >> +    uint8_t nr_counters = nr_core_counters();
> > >> +    bool core_ext = kvm_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
> > >> +    bool perf_mon_v2 = kvm_cpu_has(X86_FEATURE_PERF_MON_V2);
> > >> +    struct kvm_vcpu *vcpu;
> > >> +    struct kvm_vm *vm;
> >
> > >> -    kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
> > >> -    kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
> > >> +    vm = vm_create_with_one_vcpu(&vcpu, guest_test_core_counters);
> >
> > >> -    test_intel_counters();
> > >> +    /* This property may not be there in older underlying CPUs,
> > >> +     * but it simplifies the test code for it to be set
> > >> +     * unconditionally.

But then the test isn't verifying that KVM is honoring the architecture.  I.e.
backdooring information to the guest risks getting false passes because KVM
incorrectly peeks at the same information, which shouldn't exist.

> > >> +     */

	/*
	 * Multi-line function comments should start on the line after the
	 * opening slash-asterisk, like so.
	 */

> > >> +    vcpu_set_cpuid_property(vcpu, X86_PROPERTY_NUM_PERF_CTR_CORE,
> > >> nr_counters);
> > >> +    if (core_ext)
> > >> +            vcpu_set_cpuid_feature(vcpu, X86_FEATURE_PERF_CTR_EXT_CORE);
> > >> +    if (perf_mon_v2)
> > >> +            vcpu_set_cpuid_feature(vcpu, X86_FEATURE_PERF_MON_V2);
> >
> > > hmm, I think this might not be enough. So, when the baremetal machine
> > > supports Perfmon v2, this code is just testing v2. But we should be able
> > > to test anything below v2, ie., v1, v1 without core_ext. So, three
> > > cases need to be tested here: v1 with 4 counters; v1 with core_ext (6
> > > counters); v2.
> >
> > > If, the machine running this selftest does not support v2 but it does
> > > support core extension, then we fall back to test v1 with 4 counters and
> > > v1 with 6 counters.
> >
> > This should cover all cases the way I wrote it. I detect the number of
> > counters in nr_core_counters(). That tells me if I am dealing with 4 or
> > 6 and then I set the cpuid property based on that so I can read that
> > number in later code instead of duplicating the logic.
> 
> right. in the current code, you set up the counters properly according
> to the hw capability. But the test can do more on a hw with perfmon
> v2, right? Because it can test multiple combinations of setup for a
> VM: say v1 + 4 counters and v1 + 6 counters etc. I am just following
> the style of this selftest on Intel side, in which they do a similar
> kind of enumeration of PMU version + PDCM capabilities. In each
> configuration, it will invoke a VM and do the test.

Ya.  This is similar my comments on setting NUM_PER_CTR_CORE when the field
shouldn't exist.  One of the main goals of this test is to verify the KVM honors
the architecture based on userspace's defined virtual CPU model, i.e. guest
CPUID.  That means testing all (or at least, within reason) possible combinations
that can feasibly be supported by KVM given the underlying hardware.

As written, this essentially just tests the maximal configuration that can be
exposed to a guest, which isn't _that_ interesting because KVM tends to get plenty
of coverage for such setups, e.g. by running "real" VMs.

