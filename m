Return-Path: <linux-kselftest+bounces-25599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF72AA263E6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 20:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F2818864D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC31E20AF7B;
	Mon,  3 Feb 2025 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cu5lf5Lt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E51DB958
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Feb 2025 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738611684; cv=none; b=PIsh56smowce/789AiLebhqHdieghAzoIy2JOJe4C0EhFiWHrZ0UrVvBtJrbMOyHslmnz4U1Fg4V3z1MDyXaRz/GbBYF5sDx1GD2jnAo7Z+zFJrpAvYO8R3x1/DYk2yUpzAJ7+dBivdetnO2Nu8Sbw124qp0DhOkxuNBkaGA9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738611684; c=relaxed/simple;
	bh=bmzPo8fjt8JOhc/1bHrIPMZFP8Y2muFcWZy4Ysux2lU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tFtVe+7ShiZ0PvoLg1XT3nFyIX0evbcExxkiUru19aOAeCZWUlPlgt04zJvq8Ihb17lH9W6wcYPmR8bAS/oyFDXg9qXxkLkyCe3NbEgGkvHsk2vjqai1ekfj6JUWpwW3I6E/qSyJ0S9mQ9ctMRXhKAxCjxYJA70/F+rq1+Kovig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cu5lf5Lt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2efc3292021so13272034a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2025 11:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738611682; x=1739216482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJXV2LQY26MqizxcjQXhtNRXXOMRYW+qm0imDYwsMvw=;
        b=Cu5lf5LtLxTxa/GXdUK7k6HYS89RYuoTJsSXOUkd1YWJ1CRns2Dv24VD+GQC1WCdx9
         SU/Dmie28f+2sAhXWZhXxNfhQTba8j3FGJbf96LsPhRKbGH1iDICxGvhcBBartou1FN8
         n2+8NNevuM+X2ijWyYLMKT+VJhaZnATrPzkphxXMZ2w0uALjmDj2qwuW6z/y3RlUyh98
         4JYUuARYARwHpGq6q7gwg5k9ZGHdkII6Le8jJGPxvB3gE6tNxzeFt16qTZ2vqQV76zP5
         37HyhsOyz4Tz+uanh+iSJRpX4vlqOAo/atRHozWIyUBynEKAWn880gOZt0ovSlavlBWW
         llIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738611682; x=1739216482;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VJXV2LQY26MqizxcjQXhtNRXXOMRYW+qm0imDYwsMvw=;
        b=IxQpcAZLf06qJWB8hxhkR1mabGfrLkE9GI0QuPJKRH5vrKilG6oVFV4ke8UDVOecXH
         SRWSeHKw9osky6jRPxiRxxSMDH5ZWAA0nXJqgTZjFiFulm5Q6YNprBYqoYxi0M10Kx2K
         zr66RtSYi0xwlt4f+YIdy2uWr/cmqTKB1yzZBNbowdFyyphGul1dW6vFHxVQUVgKJvas
         vI2XYPDKP0VbfxVJJdWVBGBk4/c6f8VRkSxQ1Vr7d0WvwQ0MYKxQElN97CaoSoqXxG7C
         26SS6NccBQcbX3OszfdBliqVSJCIO3lXFiky4/qWw2g4r+QskRL2Lj0q5wWAy3/aUjqh
         j3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4a7kbsGOLGIZNXFxr+zE9IUimHuiPEJiVtmxiuMBlyyKYX1SmGZjsQdhIuzEFlLdrnHmsoG55JytsHzo9EZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkpnCegSB1pttdpCxZJkj8mSzvhh0UBQaJmcbJYi4eN8s034G
	hCMUliFr+p3Lco7ojBqul3KntOO/PUhHn+cDcRQANDNcRShjLVdzmiYXH01N3VkBDNy3UsQqFQ3
	Sfw==
X-Google-Smtp-Source: AGHT+IGcEY16oN3aex7QCo8rxntT+v0xmLo7K0x8S2drWCxpjUutztQRaAT/c6jmhnfhVhYFkmYgpyMZlK8=
X-Received: from pjtu5.prod.google.com ([2002:a17:90a:c885:b0:2ee:3128:390f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b88:b0:2f8:34df:564e
 with SMTP id 98e67ed59e1d1-2f83abf3506mr38263640a91.14.1738611682399; Mon, 03
 Feb 2025 11:41:22 -0800 (PST)
Date: Mon, 3 Feb 2025 11:41:20 -0800
In-Reply-To: <CADH9ctAzffvDByS1s2PJoD63On-b+pCnCmER4Nf4Zc=62vkbMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABgObfZrTyft-3vqMz5w0ZiAhp-v6c32brgftynZGJO8OafrdA@mail.gmail.com>
 <CADH9ctBYp-LMbW4hm3+QwNoXvAc5ryVeB0L1jLY0uDWSe3vbag@mail.gmail.com>
 <b1ddb439-9e28-4a58-ba86-0395bfc081e0@redhat.com> <CADH9ctCFYtNfhn3SSp2jp0fzxu6s_X1A+wBNnzvHZVb8qXPk=g@mail.gmail.com>
 <CADH9ctB0YSYqC_Vj2nP20vMO_gN--KsqOBOu8sfHDrkZJV6pmw@mail.gmail.com>
 <Z2IXvsM0olS5GvbR@google.com> <CABgObfadZZ5sXYB0xR5OcLDw_eVUmXTOTFSWkVpkgiCJmNnFRQ@mail.gmail.com>
 <CADH9ctAGt_VriKA7Ch1L9U+xud-6M54GzaPOM_2sSA780TpAYw@mail.gmail.com>
 <CABgObfb3Ttfg6H+_RpNQGSYKw9BLEwx3+EysXdL-wbpd1pkGHQ@mail.gmail.com> <CADH9ctAzffvDByS1s2PJoD63On-b+pCnCmER4Nf4Zc=62vkbMA@mail.gmail.com>
Message-ID: <Z6Eb4PfmmHWFTR9A@google.com>
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific hypercalls
From: Sean Christopherson <seanjc@google.com>
To: Doug Covelli <doug.covelli@broadcom.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zack Rusin <zack.rusin@broadcom.com>, 
	kvm <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Joel Stanley <joel@jms.id.au>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025, Doug Covelli wrote:
> On Mon, Feb 3, 2025 at 1:22=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> >
> > On Mon, Feb 3, 2025 at 5:35=E2=80=AFPM Doug Covelli <doug.covelli@broad=
com.com> wrote:
> > > OK.  It seems like fully embracing the in-kernel APIC is the way to g=
o
> > > especially considering it really simplifies using KVM's support for n=
ested
> > > virtualization.  Speaking of nested virtualization we have been worki=
ng on
> > > adding support for that and would like to propose a couple of changes=
:
> > >
> > > - Add an option for L0 to handle backdoor accesses from CPL3 code run=
ning in L2.
> > > On a #GP nested_vmx_l0_wants_exit can check if this option is enabled=
 and KVM
> > > can handle the #GP like it would if it had been from L1 (exit to user=
level iff
> > > it is a backdoor access otherwwise deliver the fault to L2).  When co=
mbined with
> > > enable_vmware_backdoor this will allow L0 to optionally handle backdo=
or accesses
> > > from CPL3 code running in L2.  This is needed for cases such as runni=
ng VMware
> > > tools in a Windows VM with VBS enabled.  For other cases such as runn=
ing tools
> > > in a Windows VM in an ESX VM we still want L1 to handle the backdoor =
accesses
> > > from L2.
> >
> > I think this makes sense and could be an argument to KVM_ENABLE_CAP.
> >
> > > - Extend KVM_EXIT_MEMORY_FAULT for permission faults (e.g the guest a=
ttempting
> > > to write to a page that has been protected by userlevel calling mprot=
ect).  This
> > > is useful for cases where we want synchronous detection of guest writ=
es such as
> > > lazy snapshots (dirty page tracking is no good for this case).  Curre=
ntly
> > > permission faults result in KVM_RUN returning EFAULT which we handle =
by
> > > interpreting the instruction as we do not know the guest physical add=
ress
> > > associated with the fault.
> >
> > Yes, this makes sense too, though you might want to look into
> > userfaultfd as well.
> >
> > We had something planned using attributes, but I don't see any issue
> > extending it to EFAULT. Maybe it would have to be yet another
> > KVM_ENABLE_CAP; considering that it would break your existing code,
> > there might be someone else in the wild doing it.
>=20
> It looks like KVM_EXIT_MEMORY_FAULT was implemented in such a way that it
> won't break existing code:
>=20
> Note! KVM_EXIT_MEMORY_FAULT is unique among all KVM exit reasons in
> that it accompanies a return code of =E2=80=98-1=E2=80=99, not =E2=80=980=
=E2=80=99! errno will always
> be set to EFAULT or EHWPOISON when KVM exits with
> KVM_EXIT_MEMORY_FAULT, userspace should assume kvm_run.exit_reason is
> stale/undefined for all other error numbers.
>=20
> That being said we could certainly make this opt-in if that is preferable=
.

-EFAULT isn't the problem, KVM not being able to return useful information =
in
all situations is the issue.  Specifically, "guest" accesses that are emula=
ted
by KVM are problematic, because the -EFAULT from e.g. __kvm_write_guest_pag=
e()
is disconnected from the code that actually kicks out to userspace.  In tha=
t
case, userspace will get KVM_EXIT_MMIO, not -EFAULT.  There are more proble=
ms
beyond KVM_EXIT_MMIO vs. -EFAULT, e.g. instructions that perform multiple m=
emory
accesses, "failures" that are squashed and never propagated to userspace (P=
V
features tend to do this), page splits, etc.

In general, I don't expect most KVM access to guest memory to Just Work, as=
 I
doubt KVM will behave as you want.

We spent a lot of time trying to sort out a viable approach in the context =
of the
USERFAULT_ON_MISSING series[1], and ultimately gave up (ignoring that we po=
stponed
the entire series)[2], because we decided that fully solving KVM accesses w=
ould
require an absurd amount of effort and churn, and wasn't at all necessary f=
or the
userfault use case.

What exactly needs to happen on "synchronous detection of guest writes"?  O=
ne
idea (which may be horribly flawed as I have put *very* little thought into=
 it)
would be to implement a module (or KVM extension) that utilizes KVM's "exte=
rnal"
write-tracking APIs to get the synchronous notifications (see
arch/x86/include/asm/kvm_page_track.h).

[1] https://lore.kernel.org/all/ZIn6VQSebTRN1jtX@google.com
[2] https://lore.kernel.org/all/ZR88w9W62qsZDro-@google.com

