Return-Path: <linux-kselftest+bounces-32970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 811EEAB77F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 23:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81557B29F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 21:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED055296D23;
	Wed, 14 May 2025 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ev23C4K3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CBDC8CE
	for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258165; cv=none; b=hRCTxwaADCti4gMAa69TjTVCJd2GWmC8eWAsjZQ8nCsxNGDPgOK2qFcYMdhV83QDfN4C6xLD8drj2EF8RokCaxykzlZx4PBIrrAxrZsq8MeFFiPz0R/ydy+WQp+X7s2V3AH2HQ7/mQ2GaOi42qm2WjBwe00Ib3qtNfHG4Nnf4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258165; c=relaxed/simple;
	bh=H6nUZsxGjiOGVIHyxpf5q9mNTETzbow/hvE9WPbCWeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sl/GFaTiK0SeQLzyr6uwSBdybJ673RvmCwhrc7P1IBMjA3nMmRwOnXZ+g1dp944N2LmR+OZXSL0o1g1/MM+JRUiSDidX6ejGnF6dop7j2rHtUjskz066/EcaBcd4I6WpT9IV9RglTu8dLP6fc4rKWnOim9d9wVvrQ+mqdgsDeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ev23C4K3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso20705e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747258161; x=1747862961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Slx4ccuRWaY0rxsjL8o0FXzUV7zpEZYUBzQCDU2r9rQ=;
        b=ev23C4K3cx39RmZ7a/Ml4F3SHeZixJ9kznNd//fgs+z31texeYxXFV0jXmzjOmVBWz
         OQoX49nvDQdCgIQHDaCORqsnKTpsWPe6ZhD51N+DXK6aBsJIKiADXVFPmkmHPVD/McEq
         HKgDbVYEoSM8/rZF1k1F3QSgLgTjPPbiQQKkDL1IXa4J5bt9ooytLeuGP84fQ09GTZv1
         daQW+NIZbzDii/7Y/42pxpdIpMF9+yhfu514aOJ643+FqSWBaIoHctwanr4yWAKKI6VY
         q/4KRUUvM9D6Z1VLUDhsti9JonVn9NYzKBUSPilO+4+r8lt/n2YOGEohHJ+f8uXsF8x5
         RSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747258161; x=1747862961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Slx4ccuRWaY0rxsjL8o0FXzUV7zpEZYUBzQCDU2r9rQ=;
        b=EiYugVtnX1Y81xc5WwBIpZM8vTuBKWAKcunNY490zR3h/6GloNZJPWLbWzmcg/Pr/I
         MKJftvxP8stqcxe2jazqw4E+PrlL+Gh9oBZr3fjQhQeysStKEhCv55fBoVo/fuOw5oos
         T+QenBs/GAdn6VuG54pD2rPti2CR275ZbITUVG29+6y8Enu/My6KuD4B37C1Fp0kR8bK
         4wWM9wEu12SyPF2hpiFKmJP8ekhFkYtfe23QpgUktoRNDsUuZpuYf5YdhYfXZx9dkquW
         sPyQDkY4FhUu+Z2HQego+TvKhTR+zf3i5wP/OUCBWUderulf0fRhTfX5T+gF6LzFYGNd
         D16Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFWOg4JPcx5VsHGaOAuEFrtx3+hMnxsNJ+/rCh5+YnHWGKFq4bi3UkUeNVi/+VFSc5P5B0Z7nTuaBu54r5gHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzztd2lpV1ZzO/PlYzRK4vrDSVfg2b9F/f8NgmKCDMVrrV5oyam
	uiyLIZKmebtSRWv93QP8fa+zFZYplsI4jz8ij/7nVeimi7YVFNL8/B1lmNJQ5Do1iCO/INB2y2g
	vQamy3SibeXvMU6uWfD+5XNLaNejtUeWxB8c1FquG
X-Gm-Gg: ASbGncvXGv+bZ1KRfz0huCRFjAQilJRWr1DKlnMAx8H4tnVqyAVqbPm6jKbrwnDiVgn
	TcR9MlJKP2l5FjmoqOhK/YAWFkmLXYtjza47oHr9puedTciLMeSDEEJJ1ukAVsChMlCLncSY5XZ
	p+7cDHI2gDmTRLOgi/Qni7ek0jbQcHAjy+mcups5QCqrcOimF061329zrfYlGjpA==
X-Google-Smtp-Source: AGHT+IHtyqQCkUrNJiUCv4rKrRfdaVNrxqYbN3dpp1JTn37YnHa0lc60bhCiTqHmnbfcp5FYiIwPf8xUOcF9xc4J1CY=
X-Received: by 2002:a7b:cb0b:0:b0:439:9434:1b66 with SMTP id
 5b1f17b1804b1-442f96918d2mr1145e9.1.1747258160984; Wed, 14 May 2025 14:29:20
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505161412.1926643-1-jiaqiyan@google.com> <20250505161412.1926643-7-jiaqiyan@google.com>
 <830ecd3d-13d4-4f12-9fea-e20cc69d0a5c@oracle.com>
In-Reply-To: <830ecd3d-13d4-4f12-9fea-e20cc69d0a5c@oracle.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 14 May 2025 14:29:09 -0700
X-Gm-Features: AX0GCFsv8ezjBmFZxLF3RCnN2B0FNrLKw7sWOsaJ5KQNDume-9PaaiuTEgpZ5b8
Message-ID: <CACw3F53-SaPccosPqYcXWGEpwfKj-VbSJ5nJa3f82oFMbHAy2Q@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] Documentation: kvm: new uAPI for handling SEA
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	duenwen@google.com, rananta@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks ALOK, for pointing out the typos! Queued the fixes to V2 while
awaiting for reviews on other patches.

On Wed, May 7, 2025 at 12:25=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
>
> ...
> > +Inject SError
> > +~~~~~~~~~~~~~
> > +
> >   Set the pending SError exception state for this VCPU. It is not possi=
ble to
> >   'cancel' an Serror that has been made pending.
> >
> > -If the guest performed an access to I/O memory which could not be hand=
led by
> > -userspace, for example because of missing instruction syndrome decode
> > -information or because there is no device mapped at the accessed IPA, =
then
> > -userspace can ask the kernel to inject an external abort using the add=
ress
> > -from the exiting fault on the VCPU. It is a programming error to set
> > -ext_dabt_pending after an exit which was not either KVM_EXIT_MMIO or
> > -KVM_EXIT_ARM_NISV. This feature is only available if the system suppor=
ts
> > -KVM_CAP_ARM_INJECT_EXT_DABT. This is a helper which provides commonali=
ty in
> > -how userspace reports accesses for the above cases to guests, across d=
ifferent
> > -userspace implementations. Nevertheless, userspace can still emulate a=
ll Arm
> > -exceptions by manipulating individual registers using the KVM_SET_ONE_=
REG API.
> > +Inject SEA (synchronous external abort)
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +- If the guest performed an access to I/O memory which could not be ha=
ndled by
> > +  userspace, for example because of missing instruction syndrome decod=
e
> > +  information or because there is no device mapped at the accessed IPA=
.
> > +
> > +- If the guest consumed an uncorrected memory error, and RAS extension=
 in the
> > +  Trusted Firmware choose to notify PE with SEA, KVM has to handle it =
when
> > +  host APEI is unable to claim the SEA. For the following types of fau=
lts,
> > +  if userspace enabled KVM_CAP_ARM_SEA_TO_USER, KVM returns to userspa=
ce with
> > +  KVM_EXIT_ARM_SEA:
> > +
> > +  - Synchronous external abort, not on translation table walk or hardw=
are
> > +    update of translation table.
> > +
> > +  - Synchronous external abort on translation table walk or hardware u=
pdate of
> > +    translation table, including all levels.
> > +
> > +  - Synchronous parity or ECC error on memory access, not on translati=
on table
> > +    walk.
> > +
> > +  - Synchronous parity or ECC error on memory access on translation ta=
ble walk
> > +    or hardware update of translation table, including all levels.
> > +
> > +For the cases above, userspace can ask the kernel to replay either an =
external
> > +data abort (by setting ext_dabt_pending) or an external instruciton ab=
ort
>
> typo instruciton -> instruction
>
> > +(by setting ext_iabt_pending) into the faulting VCPU. KVM will use the=
 address
> > +from the exiting fault on the VCPU. Setting both ext_dabt_pending and
> > +ext_iabt_pending at the same time will return -EINVAL.
> > +
> > +It is a programming error to set ext_dabt_pending or ext_iabt_pending =
after an
> > +exit which was not KVM_EXIT_MMIO, KVM_EXIT_ARM_NISV or KVM_EXIT_ARM_SE=
A.
> > +Injecting SEA for data and instruction abort is only available if KVM =
supports
> > +KVM_CAP_ARM_INJECT_EXT_DABT and KVM_CAP_ARM_INJECT_EXT_IABT respective=
ly.
> > +
> > +This is a helper which provides commonality in how userspace reports a=
ccesses
> > +for the above cases to guests, across different userspace implementati=
ons.
> > +Nevertheless, userspace can still emulate all Arm exceptions by manipu=
lating
> > +individual registers using the KVM_SET_ONE_REG API.
> >
> >   See KVM_GET_VCPU_EVENTS for the data structure.
> >
> > @@ -7151,6 +7184,55 @@ The valid value for 'flags' is:
> >     - KVM_NOTIFY_CONTEXT_INVALID -- the VM context is corrupted and not=
 valid
> >       in VMCS. It would run into unknown result if resume the target VM=
.
> >
> > +::
> > +
> > +    /* KVM_EXIT_ARM_SEA */
> > +    struct {
> > +      __u64 esr;
> > +  #define KVM_EXIT_ARM_SEA_FLAG_GVA_VALID   (1ULL << 0)
> > +  #define KVM_EXIT_ARM_SEA_FLAG_GPA_VALID   (1ULL << 1)
> > +      __u64 flags;
> > +      __u64 gva;
> > +         __u64 gpa;
> > +    } arm_sea;
> > +
> > +Used on arm64 systems. When the VM capability KVM_CAP_ARM_SEA_TO_USER =
is
> > +enabled, a VM exit is generated if guest caused a synchronous external=
 abort
> > +(SEA) and the host APEI fails to handle the SEA.
> > +
> > +Historically KVM handles SEA by first delegating the SEA to host APEI =
as there
> > +is high chance that the SEA is caused by consuming uncorrected memory =
error.
> > +However, not all platforms support SEA handling in APEI, and KVM's fal=
lback
> > +handling is to inject an async SError into the guest, which usually pa=
nics
> > +guest kernel unpleasantly. As an alternative, userspace can participat=
e into
> > +the SEA handling by enabling KVM_CAP_ARM_SEA_TO_USER at VM creation, a=
fter
> > +querying the capability. Once enabled, when KVM has to handle the gues=
t
> > +caused SEA, it returns to userspace with KVM_EXIT_ARM_SEA, with detail=
s
> > +about the SEA available in 'arm_sea'.
> > +
> > +The 'esr' filed holds the value of the exception syndrome register (ES=
R) while
>
> 'esr' filed holds -> 'esr' field hold
>
> > +KVM taking the SEA, which tells userspace the character of the current=
 SEA,
> > +such as its Exception Class, Synchronous Error Type, Fault Specific Co=
de and
> > +so on. For more details on ESR, check the Arm Architecture Registers
> > +documentation.
> > +
> > +The 'flags' field indicates if the faulting addresses are available wh=
ile
> > +taking the SEA:
> > +
> > +  - KVM_EXIT_ARM_SEA_FLAG_GVA_VALID -- the faulting guest virtual addr=
ess
> > +    is valid and userspace can get its value in the 'gva' field.
>
> the 'gpa' filed -> the 'gpa' field.
>
> > +  - KVM_EXIT_ARM_SEA_FLAG_GPA_VALID -- the faulting guest physical add=
ress
> > +    is valid and userspace can get its value in the 'gpa' filed.
> > +
> > +Userspace needs to take actions to handle guest SEA synchronously, nam=
ely in
> > +the same thread that runs KVM_RUN and receives KVM_EXIT_ARM_SEA. One o=
f the
> > +encouraged approaches is to utilize the KVM_SET_VCPU_EVENTS to inject =
the SEA
> > +to the faulting VCPU. This way, the guest has the opportunity to keep =
running
> > +and limit the blast radius of the SEA to the particular guest applicat=
ion that
> > +caused the SEA. If the Exception Class indicated by 'esr' field in 'ar=
m_sea'
> > +is data abort, userspace should inject data abort. If the Exception Cl=
ass is
> > +instruction abort, userspace should inject instruction abort.
>
>
> Thanks,
> Alok

