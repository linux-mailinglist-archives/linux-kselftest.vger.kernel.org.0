Return-Path: <linux-kselftest+bounces-32474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CA8AAB8D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34153B81BE
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCC0297A5B;
	Tue,  6 May 2025 03:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GC0W/wrL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED035014B
	for <linux-kselftest@vger.kernel.org>; Tue,  6 May 2025 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493019; cv=none; b=hP8hQdNrW/huyXl3OXdCRNZNaLR5K32VGOAerEcWYngM9FAgO/KFmjrv4ncAlaLtB5QVOOpgticqvAF/B6be8qo0GTAoUulWzkn/pxRgsusX2PZtuBvN+9/iKAXCZp4T6J8KMdIlRCVizsBQvpVJjGXrnEF6qVG165sXanISsi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493019; c=relaxed/simple;
	bh=ngL4kRBDSkUECBjfvf99fVbKuQB+N/pMrty5zeTZWKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OAKmfzDJrBYovc+eoFwjB4aAoiNTl7ymKU1EFXnntOATZMDlIi+xG4U9mADtgO/FopdO1+jl+s+I5jMmwsdaxxv/IrI3zNP8IFu1KkEV3agwEvTgP57mj/A4d9StqkpU856Mxr7/O3rB9DeWPq4PA1kIaPfAVqAc4C59bLG+3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GC0W/wrL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7391d68617cso5380231b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 17:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746493017; x=1747097817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6g8LwLWU5GDBk+Jxwq24ldANiEHpbz8sPHgcvAyac8A=;
        b=GC0W/wrL5IPTmN4CQdjePsy54ZP1W36G5lL5Fqp/fFfaHayyIehzFz53KNiyJ+v0w2
         5HY1xlr4gDBdr2S6LF4gyjBvlYfRQ3p0hOOvf/KPIddIq3mBkx4RXu6p4jUMGJKHUGQM
         5/m1dMRyQDE+5i0vhu4ip5e3ffd9mvoHnuGAbQBi8bwaAxt3UW5lInrLi7rVdV349neW
         NHIFpOh1DpoDjyInaR4FXcv6LFdZv0d43b3qU5mdp9kXxJT0blfzLHjS/HJv5s1p3XHH
         1QRZXRFyn+opFohhzDQ8BS2+pE2Fb3Lxj4NUCoABWSzjTgWYwSm+NAEyOjKhUT+94IwG
         02vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746493017; x=1747097817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6g8LwLWU5GDBk+Jxwq24ldANiEHpbz8sPHgcvAyac8A=;
        b=gM0iwPKBvVYkcauMD69PO+7aVziJCt9+Fjf7e9UmuzokV+FSCibtOH5dKXAeHf+BVs
         pqDcdvzbyg3uodaKEKnBh5uBC6XFvD6IdQjHOLVC4x058nOd3SGt6cQ3h3dYuO0UAC2R
         HoU5cSVNGx5gJPf3x25soJqbvUrYJ9ap81Vq0+gIXitmiCk5/Pp6bpI/2zr8mm8QLH2P
         Wzk8kpu6roB07kk9i9x8sTj33MO2ivmyXoCStlApMLWufd2w5sIU/zP9zaAghhQ3G4Ik
         bURPCsxpUu4EDPFx8KlqpirBiTJrHKXSiN+tWE1LD1bi8y2vd4yoYT1qdVvl+nacBwA4
         GQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOO6Bv1h+ZBmZAgS/BnXvF2D0GWF611VaK6VoxEOLSToSba67276lQdrI9Ribssx+OhwWrtlYB+LQ2Vu48Nd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1gnytJjhSqwwFPMKMach7wQlySYcqy87cdIgQEtnRxkazHGXo
	vPRcdtryIHpCysp6wAitUJPS6wzbSJLswNJXn3YZq7MgAOtlpGBrTU0rOWWBpxhGqKyJyc6/g68
	hFA==
X-Google-Smtp-Source: AGHT+IHFmda6X8o9RIOywhrl2OVnmBig/U1gYTcE5RpM7e9/kZR0UFvMp2Wr8+1YMfiISVdVsUDJl6tvD78=
X-Received: from pgnb2.prod.google.com ([2002:a63:7142:0:b0:b1f:8cc1:95c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d04c:b0:1e1:a449:ff71
 with SMTP id adf61e73a8af0-2116f13cb94mr2312715637.1.1746493017283; Mon, 05
 May 2025 17:56:57 -0700 (PDT)
Date: Mon, 5 May 2025 17:56:55 -0700
In-Reply-To: <34890707-201a-44f9-afb3-b065ae71b246@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250305230000.231025-1-prsampat@amd.com> <174622216534.881262.8086472919667553138.b4-ty@google.com>
 <b1cc7366-bd30-46ee-ac6e-35c2b08ffdb5@amd.com> <aBlGp8i_zzGgKeIl@google.com> <34890707-201a-44f9-afb3-b065ae71b246@amd.com>
Message-ID: <aBleV3TlvA1QwcSZ@google.com>
Subject: Re: [PATCH v8 00/10] Basic SEV-SNP Selftests
From: Sean Christopherson <seanjc@google.com>
To: Ashish Kalra <ashish.kalra@amd.com>
Cc: "Pratik R. Sampat" <prsampat@amd.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, shuah@kernel.org, pgonda@google.com, 
	nikunj@amd.com, pankaj.gupta@amd.com, michael.roth@amd.com, sraithal@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, May 05, 2025, Ashish Kalra wrote:
> On 5/5/2025 6:15 PM, Sean Christopherson wrote:
> > @@ -3067,12 +3075,6 @@ void __init sev_hardware_setup(void)
> >  
> >         if (!sev_enabled)
> >                 return;
> > -
> > -       /*
> > -        * Do both SNP and SEV initialization at KVM module load.
> > -        */
> > -       init_args.probe = true;
> > -       sev_platform_init(&init_args);
> >  }
> >  
> >  void sev_hardware_unsetup(void)
> > --
> > 
> > Ashish, what am I missing?
> > 
> 
> As far as setting sev*_enabled is concerned, i believe they are more specific
> to SNP/SEV/SEV-ES being enabled in the system, which is separate from
> SEV_INIT/SNP_INIT (SNP_INIT success indicates that RMP been initialized, SNP
> has to be already enabled via MSR_SYSCFG before SNP_INIT is called), though
> SEV_INIT/SNP_INIT may fail but SEV/SNP support will still be enabled on the
> system.

No, if SNP_INIT fails and has zero chance of succeeding, then SNP is *NOT*
supported *by KVM*.  The platform may be configured to support SNP, but that
matters not at all if KVM can't actually use the functionality.

> Additionally as SEV_INIT/SNP_INIT during sev_platform_init() have failed, so
> any SEV/SEV-ES/SNP VM launch will fail as the firmware will return invalid
> platform state as INITs have failed.

Yeah, and that's *awful* behavior for KVM.  Imagine if KVM did that for every
feature, i.e. enumerated hardware support irrespective of KVM support.

The API is KVM_GET_SUPPORTED_CPUID, not KVM_GET_MOSTLY_SUPPORTED_CPUID.

> >From my understanding, sev*_enabled indicates the user support to
> >enable/disable support for SEV/SEV-ES/SEV-SNP, 

Yes, and they're also used to reflect and enumerate KVM support:

	if (sev_enabled) {
		kvm_cpu_cap_set(X86_FEATURE_SEV);
		kvm_caps.supported_vm_types |= BIT(KVM_X86_SEV_VM);
	}
	if (sev_es_enabled) {
		kvm_cpu_cap_set(X86_FEATURE_SEV_ES);
		kvm_caps.supported_vm_types |= BIT(KVM_X86_SEV_ES_VM);
	}
	if (sev_snp_enabled) {
		kvm_cpu_cap_set(X86_FEATURE_SEV_SNP);
		kvm_caps.supported_vm_types |= BIT(KVM_X86_SNP_VM);
	}

> as the sev*_enabled are the KVM module parameters, while sev*_supported
> indicates if platform has that support enabled.

sev*_supported are completely irrelevant.  They are function local scratch variables
that exist so that KVM doesn't clobber userspace's inputs while computing what is
fully supported and enabled.

> And before the SEV/SNP init support was moved to KVM from CCP module, doing
> SEV/SNP INIT could fail but that still had KVM detecting SEV/SNP support
> enabled, so this moving SEV/SNP init stuff to KVM module from CCP driver is
> consistent with the previous behavior.

And one of my driving motivations for getting the initialization into KVM was to
fix that previous behavior.

