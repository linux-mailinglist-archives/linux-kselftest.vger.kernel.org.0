Return-Path: <linux-kselftest+bounces-20827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E72E9B3851
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 18:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958791F21891
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83B21DF276;
	Mon, 28 Oct 2024 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E68YPmt1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3801DED40
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138152; cv=none; b=oXx/IVZjhvWWvTO8p1gJfAIdA+PQ628YERiml+hVD6uCAgEkSO3y2pY+SSZ95+9HnhdP8vh/IC3tTNvU93DwPl54UJ+x42u+uuI98l9CGVj7fCgIT9Zly8neYZQ96dRDKoBg/VP5YYigBavb+89iBY/UVG0uB/BkMHRpKubX99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138152; c=relaxed/simple;
	bh=rRpF3iwXmieYU7/4JfV8CgzmrhbxJaCee8QQYCWdaU4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JG+stG/pFOBGOju/dCvISPOfS3jrNJvNwTLbUjHd9pbIH1fo9J8RMal7Ia3lw5J6VUBBrmfdNTOaamKfCxPd2tOQmZEkdDc3Nn68r/n/put2WFZk4URtM4+17Ies4z9B8fyQrFx1O2qZ0LRsY3oTsmIbl179xCzjTpKtG1R83g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E68YPmt1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2e3f8dc62cso6119279276.0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 10:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730138150; x=1730742950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FrqO78IIQ3uzDC61CyWRYSNvlD33ikL6CxGnPLAkt6o=;
        b=E68YPmt1rkxkQAzY4fcpeSsqKZBCHWUIReGBJaT0/dKTC4qYY/emto5aqw/fEhp6ys
         q7oU5D/dzuaIWWLHUTMZVh1HnEJ0EeUIUG6jZ2Ln0LPGZP+RgNxm4HKRSv0faXj4N5qj
         gFtERnuhRNnFCpAc52MiYCJJi5jd94X5qruxYtf+NqWNFN5it1e2DCb76pPLFSx3cE7H
         IWWKLQkjqLycXgBIGL+ovi3hSNPBigihCBlIA08YUqR6jd0p3TU/2jHcpvDO5OGSBLnb
         eiGOc4vzZbzhNU6C3QqTPOoGks4hXc44SSrRVUU5iEJC3nlNgt1UskzeF45VZ50VwYTT
         RL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730138150; x=1730742950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrqO78IIQ3uzDC61CyWRYSNvlD33ikL6CxGnPLAkt6o=;
        b=Gv2H+CD6w2TucIGlrEAx8BZDSw/Hlx4ORhIzuB9jaya9eQvCeqpuaewWcIKp3h9xaX
         vV052hPbDtT3RxN+WWR+mCxxCrYPbZessJDbkMIiTCTuoANCdAFsMTBKLqERDaDsmu8e
         k/oowYv2QKrAkJuXTs4nIUVP3AEeWw/uBvB5wIzPmUIZsju40m0iTC1aFPB4l+VriSEr
         o0F1ib6SXUccdCkIvD3ONOAJNKMpb/fV+E9ppljqRxlGKJlM5J094oH/hEj5jzlxR8p8
         E/ozAWO828usmCbP2cwQbI7BvkEoJBFhAjbVCvLmdzcCSbyNvfMxi4ESFhdq4Gu8fBOL
         D7Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWM4Y4X1PyLNq4zl8852iIC3bs8Jm601l+cECNR//Y1iviNh4bYqJTcGHRehHf6jcklfheU5X4QXyKA9yGgiOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6y750sN1DqMlMfqlh1vOcL8NNCyl6oyyrRyAaCeaZhdHc08Cm
	UMeJpLMwSburBB+a9+j+zNAjehuM2z7JhQUC2UEIwcKazSsjCuA4iJJqIorMKk0C4qgVu6aogTO
	Qzg==
X-Google-Smtp-Source: AGHT+IHIYGRKmxvk5oPu2A0suF66uGk8H4k5Ozqbh+vJ6wiElZtGw7G9xTqE/r5KkgQjLE8DDx5d6KFo/zU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:2b05:0:b0:e29:ad0:a326 with SMTP id
 3f1490d57ef6-e30bc242b68mr6490276.0.1730138149734; Mon, 28 Oct 2024 10:55:49
 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:55:48 -0700
In-Reply-To: <4984cba7-427a-4065-9fcc-97b9f67163ed@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
 <20240905124107.6954-3-pratikrajesh.sampat@amd.com> <Zw2fW2AJU-_Yi5U6@google.com>
 <4984cba7-427a-4065-9fcc-97b9f67163ed@amd.com>
Message-ID: <Zx_QJJ1iAYewvP-k@google.com>
Subject: Re: [PATCH v3 2/9] KVM: selftests: Add a basic SNP smoke test
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, pgonda@google.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 21, 2024, Pratik R. Sampat wrote:
> >> +		test_sev(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
> >>  
> >>  		test_sev_es_shutdown();
> >>  
> >>  		if (kvm_has_cap(KVM_CAP_XCRS) &&
> >>  		    (xgetbv(0) & XFEATURE_MASK_X87_AVX) == XFEATURE_MASK_X87_AVX) {
> >> -			test_sync_vmsa(0);
> >> -			test_sync_vmsa(SEV_POLICY_NO_DBG);
> >> +			test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
> >> +			test_sync_vmsa(KVM_X86_SEV_ES_VM, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
> >> +		}
> >> +	}
> >> +
> >> +	if (kvm_cpu_has(X86_FEATURE_SNP) && is_kvm_snp_supported()) {
> > 
> > Why do we need both?  KVM shouldn't advertise SNP if it's not supported.
> 
> My rationale behind needing this was that the feature can be advertised
> but it may not have the right API major or minor release which could be
> updated post boot and could determine it's support during runtime.

KVM will never determine support after KVM has been loaded.  If *KVM* has a
dependency on the API major.minor, then X86_FEATURE_SNP must be set if and only
if the supported API version is available.

If the API major.minor is purely a userspace thing, then is_kvm_snp_supported()
is misnamed, because the check has nothing to do with KVM.  E.g. something like
is_snp_api_version_supported() would be more appropriate.

> >> +		unsigned long snp_policy = SNP_POLICY;
> > 
> > u64, no?
> 
> Yes, sorry for the oversight. Will change it to u64.
> 
> > 
> >> +
> >> +		if (unlikely(!is_smt_active()))
> >> +			snp_policy &= ~SNP_POLICY_SMT;
> > 
> > Why does SNP_POLICY assume SMT?  And what is RSVD_MBO?  E.g. why not this?
> > 
> > 		u64 policy = is_smt_active() ? SNP_POLICY_SMT : SNP_POLICY;
> > 
> 
> I think most systems support SMT so I enabled the bit in by default and
> only unset it when there isn't any support.

That's confusing though, because you're mixing architectural defines with semi-
arbitrary selftests behavior.  RSVD_MBO on the other is apparently tightly coupled
with SNP, i.e. SNP can't exist without that bit, so it makes sense that RSVD_MBO
needs to be part of SNP_POLICY

If you want to have a *software*-defined default policy, then make it obvious that
it's software defined.  E.g. name the #define SNP_DEFAULT_POLICY, not simply
SNP_POLICY, because the latter is too easily misconstrued as the base SNP policy,
which it is not.  That said, IIUC, SMT *must* match the host configuration, i.e.
whether or not SMT is set is non-negotiable.  In that case, there's zero value in
defining SNP_DEFAULT_POLICY, because it can't be a sane default for all systems.

Side topic, I assume one of SEV_POLICY_NO_DBG or SNP_POLICY_DBG *must* be specified, 
and that they are mutualy exclusive?  E.g. what happens if the full policy is simply
SNP_POLICY_RSVD_MBO?

