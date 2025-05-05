Return-Path: <linux-kselftest+bounces-32457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22F2AAAC7E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 04:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 168977AC2BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 02:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21FB28C2DD;
	Mon,  5 May 2025 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRYIDiiS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A496F2F47AC
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486957; cv=none; b=p25q59lKz8G80ZWacUOoIMR0QtZbDA4Lmj6+tk/NvCOo9GV0L5irJdZDo8iadg/Ad7txGSyIoIG+f9t6UnaZLf3/ePS1Q4pCWrqXvLGNUVRpNDFLgoA/j6tAPh5qruqbB0cAZmCN+Ix8wqhZHwPseN+gIS0sacZ+F34E6GHLL00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486957; c=relaxed/simple;
	bh=FOf0phkAo0jTZUx4cTd2EAquLqa9kmlIuubRcG1DIvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tPE0B1zFUvKD4ltnMruuuEuQ/mfn4MH27ivyfr/eWcugbrOGyLko8OQhSzum4o8N3HTwwTgSMs9BqZkE+shZ7HTZLyxaQxAIC9TgVc0av29KW5FA2YUZ+f3mzW9NGMTvTvVasCPkxoQUj8l3wjyXyPApPucNgpa5b0vZT/WewHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BRYIDiiS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c7df9b6cso6774574b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 16:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746486953; x=1747091753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzmWvtp9U4UZ+ZB+aWa866i4TSOZqljMe82DBGfpzvc=;
        b=BRYIDiiSMISLAFnT9Hqm3UjlZMNW89iG6gN2iTNoVNJ5azPXbx9+aOwJC/wvKKGzL2
         GAlMja3u1UwRmTYwMGDYKJZREDXfpLxhg4OTktoVGsViHt37+Tn0LF3ElFM0/JXCh1UJ
         DHvm6E8Fki039PPVGRysyCtv2+3PMb+LurHRWyN5S5lnLk12rZWfV4yrQYLCCqjQ+CJe
         AgDpwJIqLLZlomCTbZrBuPaKH0BlFOkSX5coTOhf8T5ytgYtiWBcjCN2+WK/+paw7LjU
         o9XD8P6kA4L1xUS9g0MfNbzV9lf9We8O2NX7x2aYUvdQE6Rjk4le7R9uF+UGgS5/VRV6
         fIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746486953; x=1747091753;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rzmWvtp9U4UZ+ZB+aWa866i4TSOZqljMe82DBGfpzvc=;
        b=PeGKoGJLRLVCXDz6po7fb/XdGuEDNBeekQCDnOwq3JCyjXqphBbfN7/5+B+rWO8ifO
         6oU0PIeMGULO3C2VJy0zEp9YXTmhnw8KgRcOKLRqWorRk8EyNLokUGf/LlRgtjBsED6x
         dNNWsbAfmjaE0mTmCQvRptVp3pPEsbG7vuqdG5TvqPZftah84Q2CDZFj/ucewvUxJKa/
         VWcsFYAS67/nmEABTwCVGcVcmnlNb7Iya7JEpUfBQdrs+1dmAO8k2Cv7SGPW74f+3jZL
         5Z0E5KBFWcn0cuWQFHbwOiFYKFkP5sKEoJP4c0exrBZyEQ/twFINM473IaRdWSfugbS5
         UlXw==
X-Forwarded-Encrypted: i=1; AJvYcCUWRi/dpG6otMeOKx6wEMThQcEEIIgsTTVWyr8FKJkUsrqshOa1SDCUBRDqH/MJJyd9S8kONnNZEj3T/4ivZD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtyxtYcCGO0ccFt7ZcbKwg4I92dn7NpIInajju4tEo02Rk31V
	tNGfEud+FzIfG6LSbaUV490P74jzn10NVJFfkmr5OTiNtV131hY1tiEEKgU+ctMCrGIfSY5bAs6
	iYA==
X-Google-Smtp-Source: AGHT+IHeMOXp2eUqIo91Z2v4BMrNwcYqIw4g1PHvTLgYii5R2aPOJF8QNAZePSzs6Tddg5PSxQIyvzZa0UY=
X-Received: from pfbde4.prod.google.com ([2002:a05:6a00:4684:b0:740:41eb:5856])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2793:b0:736:5c8e:baaa
 with SMTP id d2e1a72fcca58-740919b43a1mr1231292b3a.2.1746486952976; Mon, 05
 May 2025 16:15:52 -0700 (PDT)
Date: Mon, 5 May 2025 16:15:51 -0700
In-Reply-To: <b1cc7366-bd30-46ee-ac6e-35c2b08ffdb5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250305230000.231025-1-prsampat@amd.com> <174622216534.881262.8086472919667553138.b4-ty@google.com>
 <b1cc7366-bd30-46ee-ac6e-35c2b08ffdb5@amd.com>
Message-ID: <aBlGp8i_zzGgKeIl@google.com>
Subject: Re: [PATCH v8 00/10] Basic SEV-SNP Selftests
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, thomas.lendacky@amd.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, shuah@kernel.org, pgonda@google.com, 
	ashish.kalra@amd.com, nikunj@amd.com, pankaj.gupta@amd.com, 
	michael.roth@amd.com, sraithal@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025, Pratik R. Sampat wrote:
> Hi Sean,
>=20
> On 5/2/25 4:50 PM, Sean Christopherson wrote:
> > On Wed, 05 Mar 2025 16:59:50 -0600, Pratik R. Sampat wrote:
> >> This patch series extends the sev_init2 and the sev_smoke test to
> >> exercise the SEV-SNP VM launch workflow.
> >>
> >> Primarily, it introduces the architectural defines, its support in the
> >> SEV library and extends the tests to interact with the SEV-SNP ioctl()
> >> wrappers.
> >>
> >> [...]
> >=20
> > Applied 2-9 to kvm-x86 selftests.  AIUI, the KVM side of things should =
already
> > be fixed.  If KVM isn't fixed, I want to take that discussion/patch to =
a
> > separate thread.
> >=20
>=20
> Thanks for pulling these patches in.
>=20
> For 1 - Ashish's commit now returns failure for this case [1].
> Although, it appears that the return code isn't checked within
> sev_platform_init()[2], so it shouldn't change existing behavior. In the
> kselftest case, if platform init fails, the selftest will also fail =E2=
=80=94 just as
> it does currently too.

Argh, now I remember the issue.  But _sev_platform_init_locked() returns '0=
' if
psp_init_on_probe is true, and I don't see how deferring __sev_snp_init_loc=
ked()
will magically make it succeed the second time around.

So shouldn't the KVM code be this?

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e0f446922a6e..dd04f979357d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3038,6 +3038,14 @@ void __init sev_hardware_setup(void)
        sev_snp_supported =3D sev_snp_enabled && cc_platform_has(CC_ATTR_HO=
ST_SEV_SNP);
=20
 out:
+       if (sev_enabled) {
+               init_args.probe =3D true;
+               if (sev_platform_init(&init_args))
+                       sev_supported =3D sev_es_supported =3D sev_snp_supp=
orted =3D false;
+               else
+                       sev_snp_supported &=3D sev_is_snp_initialized();
+       }
+
        if (boot_cpu_has(X86_FEATURE_SEV))
                pr_info("SEV %s (ASIDs %u - %u)\n",
                        sev_supported ? min_sev_asid <=3D max_sev_asid ? "e=
nabled" :
@@ -3067,12 +3075,6 @@ void __init sev_hardware_setup(void)
=20
        if (!sev_enabled)
                return;
-
-       /*
-        * Do both SNP and SEV initialization at KVM module load.
-        */
-       init_args.probe =3D true;
-       sev_platform_init(&init_args);
 }
=20
 void sev_hardware_unsetup(void)
--

Ashish, what am I missing?

> Regardless of what we decide on what the right behavior is, fail vs skip =
(I
> don't mind the former) we can certainly do that over new patches rebased =
over
> the new series.

FAIL, for sure.  Unless someone else pipes up with a good reason why they n=
eed
to defer INIT_EX, that's Google's problem to solve.

