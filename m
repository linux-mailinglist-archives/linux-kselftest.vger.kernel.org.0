Return-Path: <linux-kselftest+bounces-19772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D1199F4E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 20:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FE1284895
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234E1FAF1E;
	Tue, 15 Oct 2024 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="12qg7+Sc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3DF1F76D9
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015855; cv=none; b=OjvQ+LnAeVQ9P9E8IrdHKQdXy6847efWYdsV8TAcKXisGoOqJCoeKuogFMRCUDh7MkqvDvDxh92OOd7mFT3Pss41SvsHon8hc44zYLgO0SA4NQ65+ae+wuJxFWLySGI+xh8Zc+5Jhm1d1TxlY3O4FW3gsdF0xDj51cLnOHURtJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015855; c=relaxed/simple;
	bh=onARMYvCe4MEVctCzTmFfC9c9hckqdb5NrW57WWe4fY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iAGS6V7PWLkGAkDlxo/O6EawDs08qddM1Qk62+wRr2LVQ53KJvSiaf355xUQvFpo24gnQiXSgTvdWj8KgUNS4gOf5tG8NHnTOFTRe7wwd4EMJmUHpONf/XQFL15QakX8DsQYMKMVzzD7SBokH5h2Sqrihkn/440DxIZX3a+2adA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=12qg7+Sc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e297a366304so370710276.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729015853; x=1729620653; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkQVBApGBnsFauh/NRUkLSuJKpKjtmpIspmB3NqO1qM=;
        b=12qg7+SclH3foH+QFnrlHYEJuVgiyun3lojQ8iMgUEnH2pp1k9JODEiCOBnn9I+QXs
         oO+AgTtVurJ5iGKtKuR82mJUoId9y004GYN9vHAJKNbRcRXRHwiA5Q6mRg7GTxm/JaLE
         xouHtQd0zFTjh/TiF7UmliYUY8lviLGeNo6AnIMwMsRVh4+ZsdEBJ+aJG5tw6PujGyi4
         c7OBAlLIvqBUj1zYdZXwVe7zysJgFCHE5wW4meftNq0Y6ugpLlyJk3Z5jT1NWgPq3p3M
         g7tK9GpcIWmdqH8Ro3GhEEGRUV3ypV/+oudjWYQQwzXgxZcCHW2iKiiWcV6rAEoJW7NX
         DtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729015853; x=1729620653;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkQVBApGBnsFauh/NRUkLSuJKpKjtmpIspmB3NqO1qM=;
        b=IibC5YJKhmIL/gA0ggkH4r91p1tjK+ZfQPgSRaWxO8nz9omnAm25D3y8E8MZUnYVc8
         N7apa9R+4D8jcTHfaIQfOeNj9wmuidsWgl4omU4cSiEL5TaWEHn5c+bx4/tAyr+rHRps
         rfqfkONq6e5pHYCF12j4bLLdNk8IzygeraMPtqHaBq72QEHC8WGIfpEbTi21BA6lTB0Y
         27Ql1egPrm6+5ugwKyu/mXB7sXn+9NiCbV5rZu71OO9JgHUmW7N2iKEEaGh8LeGOMv8c
         uanVxJL5u/FU6aKC2M3ZPezny2Ch2kNR+ybQiRXoCJy9CjVHOgFbP5VEnKNasbQ2tkIZ
         D5TA==
X-Forwarded-Encrypted: i=1; AJvYcCUK0lA6vkb3gSOid7A8H1x66ZexpIVPqAigUdXVgpbh6tLY9IS0GIOvERw0jzUCpz0bwZP/Gppsd32wZCUPOnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEooQcLF+Qa4cp74i9wv/bmiz1aVdbZelsvOlH4TPNZHtZG3wu
	mljeEEoqX2x9Eehxi6VMKTQww8LYVQP8yT4vScURDf4FGiitWfDZMaHElOpzeKh/szApiFN6IJE
	MeQ==
X-Google-Smtp-Source: AGHT+IG5g2O//zMCPKGiWKKREPFUIbatrbPoLXHOrf551PzbHYpXNxKLEQfE9nef7o/Ugk4b+yX13BYXYnc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:112:b0:e29:7587:66db with SMTP id
 3f1490d57ef6-e29782b20edmr1102276.2.1729015852814; Tue, 15 Oct 2024 11:10:52
 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:10:51 -0700
In-Reply-To: <058a6302-3444-4fd6-a154-b81f384b63fc@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004140810.34231-1-nikwip@amazon.de> <20241004140810.34231-3-nikwip@amazon.de>
 <875xq0gws8.fsf@redhat.com> <9ef935db-459a-4738-ab9a-4bd08828cb60@gmx.de>
 <87h69dg4og.fsf@redhat.com> <Zw6PlAv4H5rNZsBf@google.com> <058a6302-3444-4fd6-a154-b81f384b63fc@gmx.de>
Message-ID: <Zw6wKwHQJcGPfxwn@google.com>
Subject: Re: [PATCH 2/7] KVM: x86: Implement Hyper-V's vCPU suspended state
From: Sean Christopherson <seanjc@google.com>
To: Nikolas Wipper <nik.wipper@gmx.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Nikolas Wipper <nikwip@amazon.de>, 
	Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf <graf@amazon.de>, James Gowans <jgowans@amazon.com>, 
	nh-open-source@amazon.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 15, 2024, Nikolas Wipper wrote:
> On 15.10.24 17:58, Sean Christopherson wrote:
> > ...
> >
> > And from a performance perspective, synchronizing on kvm->srcu is going to be
> > susceptible to random slowdowns, because writers will have to wait until all vCPUs
> > drop SRCU, even if they have nothing to do with PV TLB flushes.  E.g. if vCPUs
> > are faulting in memory from swap, uninhibiting a TLB flushes could be stalled
> > unnecessarily for an extended duration.
> >
> 
> This should be an easy fix, right? Just create an SRCU only for the TLB flushes only.

Yes, this is a very solvable problem.  But while SRCU objects aren't expensive,
they aren't entirely free either.
 
> > Lastly, KVM_REQ_EVENT is a big hammer (triggers a lot of processing) and semantically
> > misleading (there is no event to process).  At a glance, KVM_REQ_UNBLOCK is likely
> > more appropriate.
> >
> > Before we spend too much time cleaning things up, I want to first settle on the
> > overall design, because it's not clear to me that punting HvTranslateVirtualAddress
> > to userspace is a net positive.  We agreed that VTLs should be modeled primarily
> > in userspace, but that doesn't automatically make punting everything to userspace
> > the best option, especially given the discussion at KVM Forum with respect to
> > mplementing VTLs, VMPLs, TD partitions, etc.
> >
> 
> I wasn't at the discussion, so maybe I'm missing something, but the hypercall
> still needs VTL awareness. 

Yeah, the KVM Forum discussion is relevant, because one of the key takeaways from
that discussion was that KVM will need some amount of VTL awareness.

> For one, it is primarily executed from VTL0 and primarily targets VTL1
> (primarily here means "thats what I see when I boot Windows Server 2019"), so
> it would need to know which vCPU is the corresponding VTL (this assumes one
> vCPU per VTL, as in the QEMU implementation).

Right, but even without the takeways from KVM Forum, we need to look at big picture
and come up with a design that makes the most sense.  E.g. if making KVM aware
of "struct kvm" objects that represent different VTLs in the same VM greatly
simplifies supporting HvTranslateVirtualAddress, then it's likely worth doing.

> To make matters worse, the hypercall can also arbitrarily choose to target a
> different VP.  This would require a way to map (VP index, VTL) -> (vcpu_id)
> within KVM.

I don't think so.  The TLFS definition for TlbFlushInhibit give KVM a _lot_ of
wiggle room, e.g. KVM can retry the hypercall as many times as necessary.  To
honor TlbFlushInhibit, KVM just needs to ensure that flushes are blocked if any
vCPU at the target VTL is blocking flushes.  And to avoid hanging a vCPU, KVM
only needs to ensure a vCPU is awakened if it _might_ be able to make forward
progress.

I.e. I don't think KVM needs to be super precise when waking blocking vCPUs, and
thus there's no need to precisely track who is blocking whom.  I think :-)
 
> > The cover letters for this series and KVM_TRANSLATE2 simply say they're needed
> > for HvTranslateVirtualAddress, but neither series nor Nicolas' patch to punt
> > HVCALL_TRANSLATE_VIRTUAL_ADDRESS[*] justifies the split between userspace and
> > KVM.  And it very much is a split, because there are obviously a lot of details
> > around TlbFlushInhibit that bleed into KVM.
> >
> > Side topic, what actually clears HvRegisterInterceptSuspend.TlbFlushInhibit?  The
> > TLFS just says
> >
> >   After the memory intercept routine performs instruction completion, it should
> >   clear the TlbFlushInhibit bit of the HvRegisterInterceptSuspend register.
> >
> > but I can't find anything that says _how_ it clears TlbFlushInhibit.
> >
> 
> The register cannot be accessed using the HvSetVpRegisters hypercall, but the TLFS
> talks about it elsewhere. I'm assuming this is a formatting issue (there are a few
> elsewhere). In 15.5.1.3 it says
> 
>   To unlock the TLB, the higher VTL can clear this bit. Also, once a VP returns
>   to a lower VTL, it releases all TLB locks which it holds at the time.
> 
> The QEMU implementation also just uninhibits on intercept exit, and that, at least,
> does not crash.

Hmm, it would be nice to bottom out on whether the higher VLT or the VMM/hypervisor
is responsible for clearing TlbFlushInhibit, because that may influence KVM's
design.

