Return-Path: <linux-kselftest+bounces-23237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D171E9EDCE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 02:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E021889049
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 01:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE7629CFB;
	Thu, 12 Dec 2024 01:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YlKJYTxC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4F1CFA9
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2024 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733965270; cv=none; b=BrjEZJB7bb+s3l/pR9aU6Mi4dXAd21ExmSs9ZIBmwZ4Ds1Z4R6QCX50F3YQBmKc3yRlrq21YFQIHt/KZv/fmAT3HHg6dviD/4zDMyb5KeujFaxDjQ+QT455+M0oPjaso9bgd7/3TL6akWkp+35Bf5N5DpGmGTJMwcaJ5sbysKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733965270; c=relaxed/simple;
	bh=MsWUkv0rRpydxtGAUs5cP9cm3RSN578+vWRHQI0XJbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NyQMc0INi0infvbsrHnXUwxGnhP925aRoSzipQB6YYqqg+PeHoF8jdXd7aRtGpX4ijjczlZzvCaAPgKhxrrMCbBqgmd3qNaB/pjWcxTcKnPoNtdU2c/lpkXuJZdAPBuXS9MCe5X0aEcUJHgdKuJAllRFJJwk7kJFvVFpoxOOhA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YlKJYTxC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee46799961so51357a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 17:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733965269; x=1734570069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7cpfZyNODHfiskmCxH+bHRLp/oczpA9P3snJG2D86I=;
        b=YlKJYTxCf113SHA/13Av3q+2mfX9WZRqGAxZede/fHq1/VtKtfJeyMy7Tto/eF9V2z
         5cPD+OocgNHSVXRZ1rnkW6+1Cy+WW4n3uyYtPunzO0kpT1vaNBiManane2SNvfdfp3Pu
         XdShN7MMN4Klfeb+/DEKctzXup3nxCpWKWOZJXKUVDHelnFb9+Iv+CwxrBb5y+P26hob
         jfBa43WN434nP2OnKzIZEmne6BnfyjM0tCsweXecN2X8xFCYGWq8RQqe1oJFJWXWXkbS
         Nz6TfUNXBKKbINvMWgdWqMTW0KtrL9YB+b+0vaXGrinSOBq6+UQmSmc5wpBagIaMhsyY
         LI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733965269; x=1734570069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7cpfZyNODHfiskmCxH+bHRLp/oczpA9P3snJG2D86I=;
        b=SPyZNoo1uzmm6NU0tG4XIaWrxZHqWAoaRgJ9diTG93GhOyPcyZPHH0YMIt5s1Uowk4
         GFaNsYYP/G89Jv2Kwnqet3wr4ae3R4mfMrw2Dv3s6owtvXBmKatYgY0FmTBvwtPjP24h
         fDIegmAvBk5xvuOP9YHNNxMezAocyXuId0ng3crQCcTgcjBRNM3GqJRZI0hL3Jre4msb
         kny2H9mEesYQmlviwdqQgerRi9y8MmJwU2eC+FvOrbRlxkcf9/22Krk1JdR1qUAOsnXu
         9dhWAifEmMOkcv0oKG0ieQHfZYklpgaVZK83Zc/Dvelnos0dqdrqdcVl8SnkuQHPriSp
         kzZA==
X-Forwarded-Encrypted: i=1; AJvYcCUdRsapNdKarizooOy1w/tZw2MutkQo5bU94iC6DTkoa0SqYUlm4n4H6fuIkUOA4El2Cy+HVflPBWnOIin0WnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXy2pGeZ3BaPP3fLoMs6djxA7CwcyxFeEn42mi3rEMOBCvJCHY
	uhmPfri8bIh9PHi7cRE2kzISWZuwJ/7VkSHfiQCG8m4XcfHvJdO8rLV/vXtNzHosg+fejai/66D
	PhA==
X-Google-Smtp-Source: AGHT+IGoACptyZ2sMkDPPNC8IEQ1JeBJZZlRK3M9NSG7oG6xCWK4QqffIe8975REaYQKJeQ/fFVy1B8fJig=
X-Received: from pjf3.prod.google.com ([2002:a17:90b:3f03:b0:2d3:d4ca:5fb0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:268e:b0:2ee:5edc:489
 with SMTP id 98e67ed59e1d1-2f13930c56bmr2863220a91.26.1733965268793; Wed, 11
 Dec 2024 17:01:08 -0800 (PST)
Date: Wed, 11 Dec 2024 17:01:07 -0800
In-Reply-To: <2b75550c-0dc7-4bcc-ac60-9ad4402c17f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111102749.82761-1-iorlov@amazon.com> <20241111102749.82761-4-iorlov@amazon.com>
 <Z1nWykQ3e4D5e2C-@google.com> <2b75550c-0dc7-4bcc-ac60-9ad4402c17f8@gmail.com>
Message-ID: <Z1o1013dUex8w9hK@google.com>
Subject: Re: [PATCH v2 3/6] KVM: VMX: Handle vectoring error in check_emulate_instruction
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Ivan Orlov <iorlov@amazon.com>, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, pdurrant@amazon.co.uk, 
	dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Wed, Dec 11, 2024, Ivan Orlov wrote:
> On 12/11/24 18:15, Sean Christopherson wrote:
> > Hmm, this should probably be "pf_mmio", not just "mmio".  E.g. if KVM is emulating
> > large swaths of guest code because unrestricted guest is disabled, then can end up
> > emulating an MMIO access for "normal" emulation.
> > 
> > Hmm, actually, what if we go with this?
> > 
> >    static inline bool kvm_can_emulate_event_vectoring(int emul_type)
> >    {
> > 	return !(emul_type & EMULTYPE_PF) ||
> > 	       (emul_type & EMULTYPE_WRITE_PF_TO_SP);
> >    }
> > 
> 
> Hm, by the way, what is the desired behaviour if EMULTYPE_ALLOW_RETRY_PF is
> set? Is it correct that we return an internal error if it is set during
> vectoring? Or KVM may try to unprotect the page and re-execute?

Heh, it's sneaky, but EMULTYPE_ALLOW_RETRY_PF can be set if and only if
RET_PF_WRITE_PROTECTED is set.  Hmm, that makes me think we should do the below
(EMULTYPE_WRITE_PF_TO_SP was a recent addition).

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2e713480933a..de5f6985d123 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9077,7 +9077,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
        if ((emulation_type & EMULTYPE_ALLOW_RETRY_PF) &&
            (WARN_ON_ONCE(is_guest_mode(vcpu)) ||
-            WARN_ON_ONCE(!(emulation_type & EMULTYPE_PF))))
+            WARN_ON_ONCE(!(emulation_type & EMULTYPE_WRITE_PF_TO_SP))))
                emulation_type &= ~EMULTYPE_ALLOW_RETRY_PF;
 
        r = kvm_check_emulate_insn(vcpu, emulation_type, insn, insn_len);

That said, let me get back to you on this when my brain is less tired.  I'm not
sure emulating when an exit occurred during event delivery is _ever_ correct.

> If so, we may need something like
> 
> static inline bool kvm_can_emulate_event_vectoring(int emul_type)
> {
> 	return !(emul_type & EMULTYPE_PF) ||
> 	       (emul_type & ~(EMULTYPE_PF));
> }
> 
> So it returns true if EMULTYPE_PF is not set or if it's not the only set
> bit.



