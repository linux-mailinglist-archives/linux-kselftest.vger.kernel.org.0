Return-Path: <linux-kselftest+bounces-23369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2AD9F173D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 21:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22915166591
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145901953B0;
	Fri, 13 Dec 2024 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2DHYIITn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3AC190661
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120565; cv=none; b=ARFwcA3pBX+AKyEwBEFQd1chD1nxug29/fnkRQ3MRb196hMKLeCGijahBzLjnu0K5ubB2bve1uk5Aandv8hgmf+wt5d4Om7RPyGmzVuEM4Cxh3PBhTajfEYVq5BhovxWzw00o6IYO7wzHjDL1M/IzeMi90Xf21QbGdnk9Wnu4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120565; c=relaxed/simple;
	bh=zC9BTE/86XdOFOIMDJ2jwHIkedHbdzd5NbKps9y9TkY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qdoW0Dq8Z82mT/S4QzViYEwGnE0g7uQVBtXg2UZV12DpRG5veTgjqdoUldZ9+Wi+09HWVI/61aOqsdI/fgZjhjBBHSbFNYI37B7ltj+jjeUum82Lw6rnzA7DWlw98IvAyQFQ75PLaN8XAzKB9bCKeqgCaucsj53a4IXcKBhuizo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2DHYIITn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee36569f4cso1998513a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 12:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734120563; x=1734725363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWe44j1VIg6qYkfEWkPdzcvfPT6QWStum/CznGoFe/4=;
        b=2DHYIITne1PuECM3caXKH0QY60u+gf+wqHmJOGkOkKdPL5mh69Iw5ceDDrogeglIxa
         Rez+A94sWizI/YVTG43j5saJBhfVQ6lKNd430Ilc7myuQijGMYGn+Pft7ZtGdx1Xe7X5
         uS+AnpBHSA/Vp7DOSjEvsuBkofOC6oIDhK/wkd1jP8I+N4GkHNtLZMRTQUHEniVvfYR0
         Srj9hX/ivCLkWBfK3gYV+UfF1uzcsTaceOmD5+sStVswnWed2thtaJAngsrVcKgI5epm
         02XEKARl3UR4THnbuDRXUajaUy9HzZ7+uFbRG5m5CNECD+wT9g1fmkxeqUSFcmwLM1jK
         T8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120563; x=1734725363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWe44j1VIg6qYkfEWkPdzcvfPT6QWStum/CznGoFe/4=;
        b=sP6ckawF57tYig187Ol6LX9ILlOfBiM2mgc7hx7atVzhWtMyFPZnJ0pguBGn7gXgdq
         H/zqKmNM56Qdcz4e0OE6jIYUF+Bdpd2w5qPICUigvZln2zJy/+f7g/I8mKPZDCgJloVA
         CiCvPzgRRzhCVH5toDz3GW1OZWCBcCvIErILwCnOyLM6ITb2v5aP24TbjmIe2CI+G0ZY
         tPgy6JBVeI9NyLgZbWyPjnYbsGURwYeinPyDRwh8C1uTB1zvrqWJtawYRTn3cyCfrsYB
         cSI2jpUT68Fba8z1dlrGIYKhLPZnM60gQ101gZKF6jA2Z5t6pXLuK0ZXgBIzu58ezGJa
         0krg==
X-Forwarded-Encrypted: i=1; AJvYcCWx9eu7zvyaTo87nxyacnagDzENDER/kPzScib6Lm1BiVs5rvtt5p7HHPXUE0n57U6sU5NzF3tV20TkDXf+OUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKd+OBkw4yNwuHg9HfP1jfHHi46Sy3Scw59S0V+Wsc1z7tPIeJ
	r8tuyd/MZclM5LVa0hOaboUkIBp9VkpjskqLh6KlOGs1T9Ms4s4PAOP4EX9sxO/yod2J+R8Ipvz
	+AA==
X-Google-Smtp-Source: AGHT+IG8Z8XXK8zlWOr0tzLqr/7Y+eTDpG0yEYtLy8WZ30WPxxdX4TRITnkAN6UZ0AGz++ZFXz5Zc2FUM4k=
X-Received: from pjbrr6.prod.google.com ([2002:a17:90b:2b46:b0:2d8:8d32:2ea3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2651:b0:2ee:7c65:ae8e
 with SMTP id 98e67ed59e1d1-2f28fb6f0c2mr5583098a91.11.1734120562799; Fri, 13
 Dec 2024 12:09:22 -0800 (PST)
Date: Fri, 13 Dec 2024 12:09:21 -0800
In-Reply-To: <20241213173816.GA7768@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111102749.82761-1-iorlov@amazon.com> <20241111102749.82761-4-iorlov@amazon.com>
 <Z1nWykQ3e4D5e2C-@google.com> <2b75550c-0dc7-4bcc-ac60-9ad4402c17f8@gmail.com>
 <Z1o1013dUex8w9hK@google.com> <20241212164137.GA71156@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
 <Z1s8rWBrDhQaUHuw@google.com> <20241213173816.GA7768@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
Message-ID: <Z1yHAAomsCdn5B8z@google.com>
Subject: Re: [PATCH v2 3/6] KVM: VMX: Handle vectoring error in check_emulate_instruction
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, pdurrant@amazon.co.uk, 
	dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Fri, Dec 13, 2024, Ivan Orlov wrote:
> On Thu, Dec 12, 2024 at 11:42:37AM -0800, Sean Christopherson wrote:
> > Unprotect and re-execute is fine, what I'm worried about is *successfully*
> > emulating the instruction.  E.g.
> > 
> >   1. CPU executes instruction X and hits a #GP.
> >   2. While vectoring the #GP, a shadow #PF is taken.
> >   3. On VM-Exit, KVM re-injects the #GP (see __vmx_complete_interrupts()).
> >   4. KVM emulates because of the write-protected page.
> >   5. KVM "successfully" emulates and also detects the #GP
> >   6. KVM synthesizes a #GP, and because the vCPU already has injected #GP,
> >      incorrectly escalates to a #DF.
> > 
> > The above is a bit contrived, but I think it could happen if the guest reused a
> > page that _was_ a page table, for a vCPU's kernel stack.
> > 
> 
> Does it work like that only for contributory exceptions / page faults?

The #DF case, yes.

> In case if it's not #GP but (for instance) #UD, (as far as I understand)
> KVM will queue only one of them without causing #DF so it's gonna be
> valid?

No, it can still be invalid.  E.g. initialize hit a #BP, replace it with a #UD,
but there may be guest-visibile side effects from the original #BP.

> > > However, I'm not sure what happens if vectoring is caused by external
> > > interrupt: if we unprotect the page and re-execute the instruction,
> > > will IRQ be delivered nonetheless, or it will be lost as irq is
> > > already in ISR? Do we need to re-inject it in such a case?
> > 
> > In all cases, the event that was being vectored is re-injected.  Restarting from
> > scratch would be a bug.  E.g. if the cause of initial exception was "fixed", say
> > because the initial exception was #BP, and the guest finished patching out the INT3,
> > then restarting would execute the _new_ instruction, and the INT3 would be lost.
> > 
> 
> Cool, that is what I was concerned about, glad that it is already
> implemented :)
> 
> > 
> > As far as unprotect+retry being viable, I think we're on the same page.  What I'm
> > getting at is that I think KVM should never allow emulating on #PF when the #PF
> > occurred while vectoring.  E.g. this:
> > 
> >   static inline bool kvm_can_emulate_event_vectoring(int emul_type)
> >   {
> >         return !(emul_type & EMULTYPE_PF);
> >   }
> > 
> 
> Yeah, I agree. I'll post a V3 with suggested fixes (after running all of the
> selftests to be sure that it doesn't break anything).
> 
> > and then I believe this?  Where this diff can be a separate prep patch (though I'm
> > pretty sure it's technically pointless without the vectoring angle, because shadow
> > #PF can't coincide with any of the failure paths for kvm_check_emulate_insn()).
> > 
> 
> Looks good. If you don't mind, I could add this patch to the series with `Suggested-by`
> tag since it's neccessary to allow unprotect+retry in case of shadow #PF during
> vectoring.

Ya, go for it.

