Return-Path: <linux-kselftest+bounces-40004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B32B1B373F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 22:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A42363ED9
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 20:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B88F2F5329;
	Tue, 26 Aug 2025 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="paPjtZTY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C92E228D
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240900; cv=none; b=jHkwi6uyFmQfalUv3jwrVJRs+pH8gwmERvuGQWHdkHkcVisrDTFlKflaak6xWjYTl5T6Viw7iof/lQHVxIL8xdiDW79hnklU5+lc3S+iX2Pe06kw/OqR8mSmFu2r+d0si49hHqR5oopa/uM+BtuY7JDj+87pYAyj6tvFjD3Dr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240900; c=relaxed/simple;
	bh=T+a/BbQYUpxBjBCMc7qHsSqNFjpz2fZdg6cp2+uqwiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NEZEzyInIhGdI5wc8Laqw2K/RebbKyDRwRJzxUNJiUUJJTn4OJbJEJGkdFZd6d8rpFesV2ufnmmpi4glTskUNSAu4ry0Dk2VV5AWVDUQ5jb2fELZrImbD1pFnF9wR7kqnJ6jXgJ8J2loa0UIPUEyZoaNyweqA/WHznlF4vb15Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=paPjtZTY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-246bcd0a112so22582625ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 13:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756240898; x=1756845698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jxHPfEnTfM31bordW/xAmN05KZGENuYbEfdQSBjX92E=;
        b=paPjtZTYOgecFcS8X3E7o8w7uLiAnnyTu35DcM0rYh0FboUFv17XUcGEx+2E9PwTMn
         XEDHaRNSchdyLQEJaqREA3H1Py2vUeoVwNkZtfk6PwUg7i0ZeVtMob//YlTb45JDQ/VT
         BimVZkQvrBm890B2Uh8DNLQQ92wBLf4kkP+3EBMbR1k4xuHc7HDGDDt7f0iGEwkkcrgg
         C6vprEru/Bezbaf8n+ZLB0ehv+S3jzo0s+IDQxlNuPCH/w1R+iSqccYiRtoBovxj0Uim
         ZhXshik+mIvy+qTISSa3B+d7yYu8QQ6jhPgA0ulr5brOCwnSD3276s3kHDm9O9x7wFDC
         GMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756240898; x=1756845698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxHPfEnTfM31bordW/xAmN05KZGENuYbEfdQSBjX92E=;
        b=K9hVrNfL1rJS+27sbuU37XqDAg/4livUqwzqWix3MNbSiy2d7+Q5DgCdXdaMJLqKFv
         gi5rOWF00LkJ7Ch29ivZ2oCBOGTlSZGg8mVIT77+/eRF2d0csAACv5PQ7Iz2/b5PZuK2
         M4N+1hWy8pFhI2RluNvY0Z5bvaNF2Lx2SqgYE+hRC/cUiP5S9uYuZ8chhetoF4bowIoP
         KDJAxVXBSRj1Ioql08FrEGEXT0xUv3JV887f6EHLXdrkA4NfOuGSUTobldBE+X2xV+XY
         lAOTKACBYQKr6xjyjy3IiLS5wDNqmvQ2x1yyQAAx17etma+0Kcqetazb8Ui0/H3540AT
         /l8A==
X-Forwarded-Encrypted: i=1; AJvYcCVcRFfzib/PDe585qxaFxPfzfV9/VkSDeceJng/rob//ZR35uNPbLs4VOACwrHY9H4tjIkQ4z09hd2PoMjM8gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHg6HzLVlrpzGV6XBHo5VGkVEbNDzVAITmxcRu2bFwNn8OOGG
	DblghWBH2W9aKIlOj0CufecWrCCKK1aspAPIb69q/9imOHs844i21S/+hYLxDR6+Qi0tMzOs3XO
	436rCSQ==
X-Google-Smtp-Source: AGHT+IEGhZVQdVOygMYUI+v0tbctNCqb/0OYTa/y1v5d+8e0x9RnEZH1nApMHZtssGIweK5cKyTUcocTcSY=
X-Received: from plez4.prod.google.com ([2002:a17:902:ccc4:b0:246:1ef:f07c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:38c4:b0:240:5bde:532d
 with SMTP id d9443c01a7336-2462ef4c8eemr216737005ad.38.1756240897935; Tue, 26
 Aug 2025 13:41:37 -0700 (PDT)
Date: Tue, 26 Aug 2025 13:41:36 -0700
In-Reply-To: <aK4J5EA10ufKJZsU@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825155203.71989-1-sebott@redhat.com> <aKy-9eby1OS38uqM@google.com>
 <87zfbnyvk9.wl-maz@kernel.org> <aKzRgp58vU6h02n6@google.com>
 <aKzX152737nAo479@linux.dev> <aK4CJnNxB6omPufp@google.com> <aK4J5EA10ufKJZsU@linux.dev>
Message-ID: <aK4cAPeGgy0kXY98@google.com>
Subject: Re: [PATCH] KVM: selftests: fix irqfd_test on arm64
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Sebastian Ott <sebott@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 26, 2025, Oliver Upton wrote:
> On Tue, Aug 26, 2025 at 11:51:18AM -0700, Sean Christopherson wrote:
> > On Mon, Aug 25, 2025, Oliver Upton wrote:
> > > The majority of selftests don't even need an irqchip anyway.
> > 
> > But it's really, really nice for developers if they can assume a certain level of
> > configuration is done by the infrastructure, i.e. don't have worry about doing
> > what is effectively "basic" VM setup.
> 
> The more we pile behind what a "basic" VM configuration is the less
> expressive the tests become. Being able to immediately grok the *intent*
> of a test from reading it first pass is a very good thing. Otherwise I
> need to go figure out what the definition of "basic" means when I need
> to write a test and decide if that is compatible with what I'm trying to
> do.

Eh, I don't buy that argument, not as a blanket statement.

The existence of code doesn't always communicate intent, e.g. the _only_ instance
I can think of where doing more setup by default caused problems was a few crusty
x86 tests that relied on an int3 to cause SHUTDOWN due to lack of an IDT.  OMG was
I increduluous when I figured out what those tests were doing.

And in that case, _not_ doing the "basic" setup hid the intent of the test.  Aside
from the fact that deliberately triggering SHUTDOWN was completely unnecessary in
those tests, IMO forcing such a test to use vm_create_barebones() would better
capture that the test is doing something odd, i.e. has unusual intent.

And explicitly doing something doesn't necessarily communicate the intent of the
test.  E.g. the intent of the irqfd_test is to verify that KVM_IRQFD assign and
deassign behaves as expected.  The test never generates IRQs, i.e. doesn't actually
need an IRQCHIP beyond satisfying KVM's requirements for KVM_IRQFD.

There are undoubtedly other tests that have similar "intent".  E.g. the in-progress
mediated PMU support for x86 requires an in-kernel local APIC, and so tests like
pmu_counters_test.c, pmu_event_filter_test.c, and vmx_pmu_caps_test.c will need
to instantiate an IRQCHIP.  None of those tests actually touch the local APIC in
any way, e.g. don't generate PMU interrupts, so creating an IRQCHIP is once again
nothing more than a means to an end, and not indicative of the test's main intent.

I think the use of vgic_v3_setup() in dirty_log_perf_test.c is also a case where
the existence of code fails to communicate intent.  Without the comment in
arch_setup_vm() to explain that having GICv3 somehow reduces the number of exits,
I would be very confused as to why the test cares about GICv3.

I agree there's a balance to be had in terms of doing too much.  Unfortunately in
this case, it sounds like the fundamental problem is that the balance is simply
different for x86 versus arm64.  Having an in-kernel local APIC is tables stakes
for x86, to the point where I'm looking for any excuse to have KVM create a local
APIC by default.  But for arm64, there's tremendous value in having tests do the
lifting.

> vm_create_with_irqchip() is delightfully unambiguous.
>
> > E.g. x86 selftests creates an IRQCHIP, sets up descriptor tables and exception
> > handlers, and a handful of other "basic" things, and that has eliminated soooo
> > much boilerplate code and the associated friction with having to know/discover
> > that e.g. sending IRQs in a test requires additional setup beyond the obvious
> > steps like wiring up a handler.
> 
> That simply isn't going to happen on arm64. On top of the fact that the
> irqchip configuration depends on the intent of the test (e.g. wired IRQs
> v. MSIs), there's a bunch of guest-side initialization that needs to
> happen too.
> 
> We can add an extremely barebones GIC when asked for (although guest
> init isn't addressed) but batteries are not included on this architecture
> and I'd rather not attempt to abstract that.

What about providing an API to do exactly that, instantiate and initialize a
barebones GIC?  E.g.

	void kvm_arch_init_barebones_irqchip(struct kvm_vm *vm)

Hmm, then we'd also need

	void kvm_arch_vm_free(struct kvm_vm *vm)

to gracefully free the GIC, as done by dirty_log_perf_test.c.  Blech.  Though
maybe we'll end up with that hook sooner or later?

All in all, I have no strong preference at this point.

