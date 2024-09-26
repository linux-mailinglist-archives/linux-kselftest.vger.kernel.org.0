Return-Path: <linux-kselftest+bounces-18379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FED986A33
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 02:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421A11F2216D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 00:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2244D8D1;
	Thu, 26 Sep 2024 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NANfeg3g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF24B5AE
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727309215; cv=none; b=RI3ujfC10/ojCq4BLXsDJrNOV8vOnUhdW96JLqM/d2L5NLc9I+72uHgO6KPodo9LxPA0kojkU9fa9/HHLYOMIzMwJN3tHxLvNhiCN+hpEXAFRsCya5tqxWfGVgV9GCJm1gLjYDPFr/sJ9VY57vlydD3YMkCtUXQKM0wcyvTDYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727309215; c=relaxed/simple;
	bh=tiaXzk/W2iQBTiuoW1hcUQOIKgM87mnnYdBHI0F8ZQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W8xbPCSiJMDcbRso+pHozo5SRBGgHuSMgMjjU60Cn7lryC1nIeEn4isltR7SHSv8UW+V8vHFaVUM8oRcQVytxawh3zKEDyICTlh6t4oTo1m84ei+0z++kGfDtsNPwofhaJIfMmYUC4wGKwUjS7QEi3bpbMukB9scCh75shwgFeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NANfeg3g; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-718f329aefdso470693b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 17:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727309213; x=1727914013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCa5WlnWfvKFPIfqyLnyQEnWt7jWzLhfWoMpM959Mxo=;
        b=NANfeg3gUVMln4RrZ02L7JUXBTW9nN4RvknTewO/tFxlEi0vp39DE06lmE+uHBc2WU
         DkFFn5VaGd23PfBAW7wmSNBJNEYPi38FJj+5ipcAsxBpK5FYpaeYJ3CSPvMebw8gwM6X
         b/9FrRZx7ki2iDhLZilFIg/ybslqPtXvIM79nbwnOcFZQ9SovTIGtQCx21eM+9mO37fZ
         qEb/vuMFoyf+EqD3aZIDBp+XPLvAOBwiwKyAjmGUbsSp67YRmapdLYs4iQsOCcpZJmV7
         nGg+7vG5Pt6KFovod8Lsbd67gKK+q5XmWQCGDZI+/Xd2KW1nJ6GR9IhHTdUgAO1tORs8
         gBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727309213; x=1727914013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCa5WlnWfvKFPIfqyLnyQEnWt7jWzLhfWoMpM959Mxo=;
        b=Pe6dpGIOUAZ/9uN68kpw0Vdbp7cHwsn4PSptWIq9k19lK0uyETxbR9sUItqQ087Xsk
         tcKfNYWrTAej9kaJMfuqJrW+bs08sQutsuc2+QLPX4iZm68YEBE5V6VhQw0OvS+H9VbN
         TZ/RyOYGPTKL6OppGTaJJRCxORXsOxE+yCY6zGe2RrVtJ3k4Dso5Xf1oWAZ0qjkUQ3gV
         BxGuLmh8K/R5lm6BndGe9byLoDX9IgY3iZbNFLmeNLA+k/E5GEJcR4hFyGZECM5/oQOi
         Ugi2O4w107FuFNsuKa1kUfJhPugrWYYj/TJhD8FJ/B0eRqep5GI/vsX2x3kl2p7jmVwR
         Yeww==
X-Forwarded-Encrypted: i=1; AJvYcCXJjvcf4OKxnhAkkmEaao0yD8AUvscQSk7IhIOxsMpU93pstIrOYQ5Qgv5Y3lnk8sLWQtoj1jlIGqV1Xef+Wco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBw2r1pIPDHwbYm8+47hlkKXjuKYH50ryWEkDEk/gbaBLtqacR
	147wyrRAO/ZrrqghArNOQrOcOYkvUl54BLnXjA92ae5MxQ8yan4OX2LyjMQyfeUfvoqLS8DsngA
	jvg==
X-Google-Smtp-Source: AGHT+IEh8OAvaVqV321JqbrtI5MQlQVyFC2h2qpEZTAVpMPaRd4jqfdepCyWJsj5AqhcGsOGLDaKqzP83vA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d14:b0:718:e9ab:d3e6 with SMTP id
 d2e1a72fcca58-71b0ae1a993mr12351b3a.6.1727309212829; Wed, 25 Sep 2024
 17:06:52 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:06:45 -0700
In-Reply-To: <20240924095422.GA66922@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240923141810.76331-1-iorlov@amazon.com> <ZvGfnARMqZS0mkg-@google.com>
 <cb06b33acdad04bef8c9541b4247a36f51cf2d36.camel@amazon.co.uk>
 <ZvHhqRWW04jmk8TW@google.com> <20240924095422.GA66922@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
Message-ID: <ZvSllYdtddzHv7vM@google.com>
Subject: Re: [PATCH 0/4] Process some MMIO-related errors without KVM exit
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: Jack Allister <jalliste@amazon.co.uk>, Ivan Orlov <iorlov@amazon.co.uk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 24, 2024, Ivan Orlov wrote:
> On Mon, Sep 23, 2024 at 02:46:17PM -0700, Sean Christopherson wrote:
>  > >
> > > > No.  This is not architectural behavior.  It's not even remotely
> > > > close to
> > > > architectural behavior.  KVM's behavior isn't great, but making up
> > > > _guest visible_
> > > > behavior is not going to happen.
> > >
> > > Is this a no to the whole series or from the cover letter?
> > 
> > The whole series.
> > 
> > > For patch 1 we have observed that if a guest has incorrectly set it's
> > > IDT base to point inside of an MMIO region it will result in a triple
> > > fault (bare metal Cascake Lake Intel).
> > 
> > That happens because the IDT is garbage and/or the CPU is getting master abort
> > semantics back, not because anything in the x86 architectures says that accessing
> > MMIO during exception vectoring goes straight to shutdown.
> >
> 
> Hi Sean, thank you for the detailed reply.
> 
> Yes, I ran the reproducer on my AMD Ryzen 5 once again, and it seems like
> pointing the IDT descriptor base to a framebuffer works perfectly fine,
> without any triple faults, so injecting it into guest is not a correct
> solution.
> 
> However, I believe KVM should demonstrate consistent behaviour in
> handling MMIO during event delivery on vmx/svm, so either by returning
> an event delivery error in both cases or going into infinite loop in
> both cases. I'm going to test the kvm/next with the commits you
> mentioned, and send a fix if it still hits an infinite loop on SVM.
> 
> Also, I reckon as detecting such an issue on the KVM level doesn't
> introduce much complexity, returning a sane error flag would be nice. For
> instance, we could set one of the 'internal.data' elements to identify
> that the problem occured due to MMIO during event delivery
> 
> > > Yes a sane operating system is not really going to be doing setting it's IDT
> > > or GDT base to point into an MMIO region, but we've seen occurrences.
> > > Normally when other external things have gone horribly wrong.
> > >
> > > Ivan can clarify as to what's been seen on AMD platforms regarding the
> > > infinite loop for patch one. This was also tested on bare metal
> > > hardware. Injection of the #UD within patch 2 may be debatable but I
> > > believe Ivan has some more data from experiments backing this up.
> > 
> > I have no problems improving KVM's handling of scenarios that KVM can't emulate,
> > but there needs to be reasonable justification for taking on complexity, and KVM
> > must not make up guest visible behavior.
> 
> Regarding the #UD-related change: the way how I formulated it in the
> cover letter and the patch is confusing, sorry. We are _alredy_ enqueuing
> an #UD when fetching from MMIO, so I believe it is already architecturally
> incorrect (see handle_emulation_failure in arch/x86/kvm/x86.c). However,
> we return an emulation failure after that,

Yeah, but only because the alternative sucks worse.  If KVM unconditionally exited
with an emulation error, then unsuspecting (read: old) VMMs would likely terminate
the guest, which gives guest userspace a way to DoS the entire VM, especially on
older CPUs where KVM needs to emulate much more often.

	if (kvm->arch.exit_on_emulation_error ||
	    (emulation_type & EMULTYPE_SKIP)) {
		prepare_emulation_ctxt_failure_exit(vcpu);
		return 0;
	}

	kvm_queue_exception(vcpu, UD_VECTOR);

	if (!is_guest_mode(vcpu) && kvm_x86_call(get_cpl)(vcpu) == 0) {
		prepare_emulation_ctxt_failure_exit(vcpu);
		return 0;
	}

	return 1;

And that's exactly why KVM_CAP_EXIT_ON_EMULATION_FAILURE exists.  VMMs that know
they won't unintentionally give guest userspace what amounts to a privilege
escalation can trap the emulation failure, do some logging or whatever, and then
take whatever action it wants to take.

> and I believe how we do this
> is debatable. I maintain we should either set a flag in emulation_failure.flags
> to indicate that the error happened due to fetch from mmio (to give more
> information to VMM),

Generally speaking, I'm not opposed to adding more information along those lines.
Though realistically, I don't know that an extra flag is warranted in this case,
as it shouldn't be _that_ hard for userspace to deduce what went wrong, especially
if KVM_TRANSLATE2[*] lands (though I'm somewhat curious as to why QEMU doesn't do
the page walks itself).

[*] https://lore.kernel.org/all/20240910152207.38974-1-nikwip@amazon.de

> or we shouldn't return an error at all... Maybe it should be KVM_EXIT_MMIO with
> some flag set? What do you think?

It'd be a breaking change and added complexity, for no benefit as far as I can
tell.  KVM_EXIT_INTERNAL_ERROR is _not_ a death sentence, or at least it doesn't
have to be.  Most VMMs do terminate the guest, but nothing is stopping userspace
from grabbing RIP and emulating the instruction.  I.e. userspace doesn't need
"permission" in the form of KVM_EXIT_MMIO to try and keep the guest alive.

