Return-Path: <linux-kselftest+bounces-13589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5908692EB6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 17:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039611F24647
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED7E16C680;
	Thu, 11 Jul 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bs4wEg3D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB95015B11E
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710982; cv=none; b=MJiut9QVxwYqfxP16mhh4yYZxYux3pVJJxB+773pYj6CG+3BlkGSzzgTP2RM+tWxkEyG8GG+ieoo+1i1sFzXzqXTAGmWxvGekYc9HqKkQSNxasT4ioT+snVRvIDeo/O2CrIrg9TSP4cvPiJ9ro2wxME4GQkLqLPJSncZtmfpHxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710982; c=relaxed/simple;
	bh=ZT8r4jHQhDaBCzN3+aEtNsWoK9MhYoqizNljs+w6bDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Csql8u2vuSK5fwdYuMUWdTHtDdvbA3kcSq2aw0LXdqmO6t5jH/idXyB8gSE+HJZxPT/judisTRPOGVIlyVmgFQ7of4c8lXPFXrCASFCNwCXBTfLoPSwoWdGVzcucISBuEkpMeAWcS0lMGuSdaEYsLYHsCLXeppqrk3QOEhb2F1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bs4wEg3D; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42666b89057so83985e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 08:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720710979; x=1721315779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyJDEQBIS7qTi/nDqfXrdBXWCR7i7ojFDGlwfpekfoI=;
        b=Bs4wEg3D5q2c6efrE96XH59oUsQzUXWnGYsfurUc8IHesEIkg6C85dCiyRTlXKlbVp
         31TlqHuKoFOXiEG3j+RluCKJmpme2HlHJ6VhssnWb0E4IW/Gq9RSkcXkAzHlM/ONtwX4
         IfXegvkGre495sO8ysF9oOuKRVC+j8waID5RZRy+Vq6kNwvp02P0Spc6Lxf9pLGb21yQ
         5EAGz8OMForknCb8qWeDaxSuOMIFkmUxvSSRQhhSr9OQARsEV7S9kO2praMCnTvHUks7
         KNW80hLDs+IoNLkHHTiQKLzYVodEhSSwtOLNLFyD3CCaTIDwkJNIeUzx0cYFKHpfV+GB
         zXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710979; x=1721315779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyJDEQBIS7qTi/nDqfXrdBXWCR7i7ojFDGlwfpekfoI=;
        b=JD2SDSv57k+lMzr5Ycn7Nyj8TflMxv/C4c2ZhnoMUSmKbBgPomm6+JPCStN0jjPNUy
         odGNk6ruVjd1COEDjMrVOEJZ+oXklBEpwYjjYAju7GiJoBj806dfd9dH+3RBvbRnhkJL
         wbHwPh788uP/Y0HXHJPAZCTdAIGjNN8xZ81+ebyKRLt9djQyESBHeCmV4IsjVLnBAPzM
         hgsCIcCP3rYTR26FOX/612de2OWx/58WASuJn62mMIc/eMbebMSfrYH25CqGa4IPCwuK
         FH9JU73UnpgISKtu7r3D94rkTyEq3HCaUTtnnKdu1CuC9dbbbyIsq3emBkVAf2sXnc8h
         sMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl5hEt2LjETvAm4v78XDWpIHtL/1ZQxBn3LRgigQEl3zppxRvgEpfHwMjnZpYWBM5rmHIHt2x6cb+f5m92u0v6kcX3G126gXKoygNz67CT
X-Gm-Message-State: AOJu0YyOQKbk3IcfDOtIv9XwaVZIqb+1kQSaQpizLAklW8s/rCH/BSOI
	4YT4yfOQU0DmVFM/t4oV243hy3uwqRU/OpFi0i9JAwFs1iOYzXsaqx9AfADDTSlvc5OXZ5SPm+W
	wbxG12A//RJOljwG+DhGKYTh1GfBZKWZf5saW
X-Google-Smtp-Source: AGHT+IGyYy3GyAeAwJ7v4rMOuRzUatN1QEIvXg15T5400EWs8XL5YxyUZKvT+dfB4f5AwJxjdXJ5KxKcif0r6hYufcg=
X-Received: by 2002:a7b:cd95:0:b0:426:6e95:6ea7 with SMTP id
 5b1f17b1804b1-427986dc130mr2064645e9.0.1720710978801; Thu, 11 Jul 2024
 08:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com> <20240710220540.188239-2-pratikrajesh.sampat@amd.com>
In-Reply-To: <20240710220540.188239-2-pratikrajesh.sampat@amd.com>
From: Peter Gonda <pgonda@google.com>
Date: Thu, 11 Jul 2024 09:16:05 -0600
Message-ID: <CAMkAt6oc5YC8oLpvFDeCOrEH6Hm88M_U_eMBPXpQWvcqjL7nzg@mail.gmail.com>
Subject: Re: [RFC 1/5] selftests: KVM: Add a basic SNP smoke test
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, shuah@kernel.org, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, pbonzini@redhat.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:06=E2=80=AFPM Pratik R. Sampat
<pratikrajesh.sampat@amd.com> wrote:
>
> Extend sev_smoke_test to also run a minimal SEV-SNP smoke test that
> initializes and sets up private memory regions required to run a simple
> SEV-SNP guest.
>
> Similar to it's SEV-ES smoke test counterpart, this also does not support
> GHCB and ucall yet and uses the GHCB MSR protocol to trigger an exit of
> the type KVM_EXIT_SYSTEM_EVENT.
>
> Also, decouple policy and type and require functions to provide both
> such that there is no assumption regarding the type using policy.
>
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>

Tested-by: Peter Gonda <pgonda@google.com>

>
> -       test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
> -       test_sev(guest_sev_code, 0);
> +       test_sev(guest_sev_code, KVM_X86_SEV_VM, SEV_POLICY_NO_DBG);
> +       test_sev(guest_sev_code, KVM_X86_SEV_VM, 0);
>
>         if (kvm_cpu_has(X86_FEATURE_SEV_ES)) {
> -               test_sev(guest_sev_es_code, SEV_POLICY_ES | SEV_POLICY_NO=
_DBG);
> -               test_sev(guest_sev_es_code, SEV_POLICY_ES);
> +               test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY=
_ES | SEV_POLICY_NO_DBG);
> +               test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY=
_ES);
> +
> +               if (kvm_has_cap(KVM_CAP_XCRS) &&
> +                   (xgetbv(0) & XFEATURE_MASK_X87_AVX) =3D=3D XFEATURE_M=
ASK_X87_AVX) {
> +                       test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
> +                       test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES |=
 SEV_POLICY_NO_DBG);
> +               }
> +       }
> +
> +       if (kvm_cpu_has(X86_FEATURE_SNP) && is_kvm_snp_supported()) {
> +               test_sev(guest_snp_code, KVM_X86_SNP_VM, SNP_POLICY_SMT |=
 SNP_POLICY_RSVD_MBO);

I'd guess most systems have SMT enabled, but is there a way we can
check and toggle the SNP_POLICY_SMT policy bit programmatically?

Also should we have a base SNP policy so we don't have to read
`SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO` every time? Not sure I think
selftests prefer more verbosity.

