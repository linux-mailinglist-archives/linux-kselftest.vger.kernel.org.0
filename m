Return-Path: <linux-kselftest+bounces-8740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F08AFD81
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EAE51F239CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 00:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0E24A24;
	Wed, 24 Apr 2024 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPM3EqdX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9728FB656
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713920320; cv=none; b=tMuzoVhTMdkmGqNpdRuid4c5YZjzgDzB3hwaPqvjt0eH0RU5KsSqMFePxy/aUgizeltP+iSDlLbScVBaYtWy7wPrzwdRM6pj/VYDN8lYZ/FLfwhQRjnevSBI7LRprugGGPrPmNf1tDSJotGxtsl1MZ1edaTDk7o/UhVH2v8edm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713920320; c=relaxed/simple;
	bh=mmJKzpn56Y05MfN/M7Ttwvc9Q1m+oN3OU+dsYQVNYzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EgPOeJi8jpBcdiESeLSkiNjlBGbI7Ctjc+iyKE2zhK/N8HR6FG9h/nFfS1HclAwPeU/cq2vsiGhSnC6NCbkHK3Fj8OwSxRzSG001Ew2r8uyXGtewx2QCbpzPa5OBy4nMRKebgXfNQ7u+R8M/r3NWnGORfQzKkR4rIxoAeWB5//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lPM3EqdX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so9003731276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 17:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713920317; x=1714525117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TnFfv2/q8HD4zI2T3k05GE/1OzMTYZ/cFvDzD1pFbjs=;
        b=lPM3EqdX9usy5i4BxZs60X0T1U1uzOBVuHsbEiL1Ef6R6q70HUNdU5AYUGvEKhdC+J
         sEdIKWkNBhsACpEeNWzM4hY3VzkNHUFJxxw/tNRJq2Z4BO6rLSkNK9S5F5VH7KBLsMmz
         IaFshJMY/BT94Folc61L31lkOO5g2J7ak4a0LhMhKWMyB5z5txP+1YHGsLeAcTdIScjj
         Wn9IKuiCyDogZv3NA9Nm2JoegRpK0If5gFFTFT7VVI+C9f4tApXsMZRPj61EmBRl8UtK
         VW1b4dnLnQ9O7gIVovlGj/ElQMZlKK7EAjQwaIIQ26PyZAHVtrGv9AWTNVsGts6gOZiQ
         sr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713920317; x=1714525117;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TnFfv2/q8HD4zI2T3k05GE/1OzMTYZ/cFvDzD1pFbjs=;
        b=An9iCHSNh7xAWm/HJF2sWi9tbdysCeR6DfyassIO9bQW1TObY9BlAVEZLmzEz57R5l
         d+GgSzS7Zs4A5xqXp5GElEEPfFWjdSqxMoVJ6OjjsUdWyojNb7Q0GmEZ0SWSryMEjIiQ
         KOKgjF3vwR1pZyPYqH34xMPDsbwbNtmwfVzVmuOF/MHAr7s71hH2k7fhPpucJpSVy5bo
         n7lMd6zW61zWKb4So1otbkuxnMI5bsiKjlPgi1D22YRAUY5N1ENuo1R8zcu6d6Sia2oB
         aAuC7A7ODlnYFKUu7/WOMdn2nOAY0gGwUaSUiVWpUjit4eTB8Ym1ERjIan0Nkym7oROz
         hUeg==
X-Forwarded-Encrypted: i=1; AJvYcCVHHkjfzhYnzTLWx2upxUbMQkj1WLqpt7hnmBd9ka/mQtLSKrmnsRLPdNNGwpHFRlsoq4MvC2HndCMzDvXcJVHOdlPjtMGSgBY7ewyUKXg4
X-Gm-Message-State: AOJu0Yy9eBdasdd3hQU/9a/fRplC73/6PzUR+JQFDLybd2bvW/hOvnCo
	tYxuIorNk5WKToBXzRnSFFP+bosbTlnUBVli/9YHbm635BijYXxygUoUrYrSHp0F0GSNx30C3+u
	n6Q==
X-Google-Smtp-Source: AGHT+IEvNw3J6I/yHHAfvdURbb8jj1wTGZNW3lbpolt8uCEne9ZqLnMsHy6ndjJrs5y4tOm7Z4sHLAK8DkM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ab2b:0:b0:dcc:8927:7496 with SMTP id
 u40-20020a25ab2b000000b00dcc89277496mr138421ybi.5.1713920317559; Tue, 23 Apr
 2024 17:58:37 -0700 (PDT)
Date: Tue, 23 Apr 2024 17:58:35 -0700
In-Reply-To: <20240409133959.2888018-5-pgonda@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com> <20240409133959.2888018-5-pgonda@google.com>
Message-ID: <ZihZOygvuDs1wIrh@google.com>
Subject: Re: [PATCH 4/6] Add GHCB allocations and helpers
From: Sean Christopherson <seanjc@google.com>
To: Peter Gonda <pgonda@google.com>
Cc: linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024, Peter Gonda wrote:
> Add GHCB management functionality similar to the ucall management.
> Allows for selftest vCPUs to acquire GHCBs for their usage.

Do we actually need a dedicated pool of GHCBs?  The conundrum with ucalls i=
s that
we have no place in the guest to store the pointer on all architectures.  O=
r rather,
we were too lazy to find one. :-)

But for SEV-ES, we have MSR_AMD64_SEV_ES_GHCB, and any test that clobbers t=
hat
obviously can't use ucalls anyways.  Argh, but we can't get a value in that=
 MSR
from the host.

Hmm, that seems like a KVM flaw.  KVM should advertise its supported GHCB p=
rotocol
to *userspace*, but userspace should control the actual information exposed=
 to
the guest.

Oof, and doesn't SNP support effectively *require* version 2?  I.e. shouldn=
't
the KVM patch[*] that adds support for the AP reset MSR protocol bump the v=
ersion?
The GHCB spec very cleary states that that's v2+.

And what if userspace wants to advertise v2 to an SEV-ES guest?  KVM should=
n't
switch *all* SEV-ES guests to v2, without a way back.  And the GHCB spec cl=
early
states that some of the features are in scope for SEV-ES, e.g.

  In addition to hypervisor feature advertisement, version 2 provides:

  SEV-ES enhancements:
     o GHCB Format Version 2:
        =E2=96=AA The addition of the XSS MSR value (if supported) when CPU=
ID 0xD is
          requested.
        =E2=96=AA The shared area specified in the GHCB SW_SCRATCH field mu=
st reside in the
          GHCB SharedBuffer area of the GHCB.
     o MSR protocol support for AP reset hold.

So I'm pretty sure KVM needs to let userspace set the initial value for
MSR_AMD64_SEV_ES_GHCB.  I suppose we could do that indirectly, e.g. through=
 a
capability.  Hrm, but even if userspace can set the initial value, KVM woul=
d need
to parse the min/max version so that KVM knows what *it* should support, wh=
ich
means that throwing in a GPA for selftests would screw things up.

Blech.  Why do CPU folks insist on using ascending version numbers to bundl=
e
features?

Anyways, back to selftests.  Since we apparently can't stuff MSR_AMD64_SEV_=
ES_GHCB
from host userspace, what if we instead use a trampoline?  Instead having
vcpu_arch_set_entry_point() point directly at guest_code, point it at a tra=
mpoline
for SEV-ES guests, and then have the trampoline set MSR_AMD64_SEV_ES_GHCB t=
o
the vCPU-specific GHCB before invoking guest_code().

Then we just need a register to stuff the GHCB into.  Ah, and the actual gu=
est=20
entry point.  GPRs are already part of selftest's "ABI", since they're set =
by
vcpu_args_set().  And this is all 64-bit only, so we can use r10+.

Ugh, the complication is that the trampoline would need to save/restore RAX=
, RCX,
and RDX in order to preserve the values from vcpu_args_set(), but that's ju=
st
annoying, not hard.  And I think it'd be less painful overall than
having to create a GHCB pool?

In rough pseudo-asm, something like this?

static void vcpu_sev_es_guest_trampoline(void)
{
	asm volatile(<save rax, rcx, rdx>
		     "mov %%r15d, %%eax\n\t"
		     "shr %%r15, $32\n\t"
		     "mov %%r15d, %%eax\n\t"
		     "mov $MSR_AMD64_SEV_ES_GHCB, %%ecx\n\t"
		     <restore rax, rcx, rdx>
		     "jmp %%r14")
}

[*] https://lore.kernel.org/all/20240421180122.1650812-3-michael.roth@amd.c=
om

