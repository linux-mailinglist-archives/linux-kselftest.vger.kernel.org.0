Return-Path: <linux-kselftest+bounces-21098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECF69B648C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0B11F216E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371F1EABAC;
	Wed, 30 Oct 2024 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gr5l+MEg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857161E260E
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295989; cv=none; b=KyrWhZk89FFxleq7pncUPYuwoZevepW+9d6mxsUH6azzW3518cYHpHyWkhncNohFPvgAtfLaNwROyyOgUzhflOTWXa/n3GWQJgi3I++KRJFIw0a6XKGHlM1/Ct3jCKJXPI5+3k522LctKyfWQStDea9P0b5fqtdOyDIz+E2aHts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295989; c=relaxed/simple;
	bh=Y1a9aM6tWWaV5uzVx8wzzg/C3IB0sCgO5AuemKo86Jo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rM4cgnzckftk7ZW4RPVnZ2c+HopGh3DrhQwobqPPvXmaZPmVJi69U5TPVnl9+WtFDrnWpSpIVAmc9yg4krJEjSyXszAqXd2QV3qKS96XLeAZiroHIupw53jixgVWkl1Ww2e99sTM5TL/ZAxOcLykP1F7N60IzUgzz+TxicV+DHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gr5l+MEg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7edbbc3a9f2so4496346a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730295986; x=1730900786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtfXzQfaJ/EYKD+CJMQGAg9z8wKP66O4MQ222guzR8o=;
        b=Gr5l+MEgTcxy1MB28zEiYeQDW7I6oTVbV++EJGlKny+0rQ0cKlEa7wbA9OARJxjWn7
         Bm1Cv1ioADW2pW5u7SdZtMGu8Qf//aTALXfsqpfAJaCQ/LBzzpMX6W8O4vx2iu7Nd0BD
         C+kGKHGGKzyKLj6qfgaDf+6Ed5dLcezCcbiXUc3XL11LAiym6nd4dRwRdVCOUQs5xsJo
         ePQQIIE6crzyH05Y/U6/tEgLBGr6jyAJ+DWat++QwQCW0pp1SyPwk+dZFo/MAejZeG+u
         U/17MudTLn5hqB207ZKFAzIch6+4t8wCN9b8g3b0GpImVe4Jy7LB/3erJJ8h/VZy4dF7
         CR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730295986; x=1730900786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtfXzQfaJ/EYKD+CJMQGAg9z8wKP66O4MQ222guzR8o=;
        b=MNcfkk9S6e4YO6y8mBgJDWod0dLmLZP7UkTyR5zNb/yWsWEVuF7Mi82Xfc3YIRiL4n
         TViuVGfpxYt/kLPJDwBUq7WyKNDc2qBK1cMPwTRX7L2s/jgHszCidPNaV03iu8WO4MRd
         PA9Jpk/sNL0SGSdBCOIMQXCMjeuizFAVR+8YNH4rXeQVv8w6SseOQPf0ucfch5P3EWiy
         Xb9RxAF733PglKdiDOenW6NbpRcAHt54o2u1DlGgn5KU8J1PPNzpC1iDkrEdkg3NnypU
         /9XQiV+90eZzKzzsXQEji7GuISAYjsF5pi9on3k7XmpajVPctc8xL5BOB0hP+oE5UzLf
         vQ9g==
X-Forwarded-Encrypted: i=1; AJvYcCWpH+DvH6pndMnJ3uYbCU5J/mfyLbxPd2F4mfDiE/2OkpfEMf6B6/DAmfFKouqaniilcPcIwfgphe1ePvhe9hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1bVgI6nxFYyQurjtHVvdNyz5A6vMEqRgahutC2+zBtTjQEui
	BJZqhH4D5zgPK7ltbPZ0ew1grtDQK86o1IoTf9SA6HCkNLxSpFd/hoD0EdLgZq2Iil1a9HwNz+r
	7hw==
X-Google-Smtp-Source: AGHT+IFm2Yxq+cP+3QVS7378b8ToiwEaMp35x6FfIFMaHRLEbNI+8XbUnisHEWBxThlhwzgcDC7XrtglZ9o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:4f62:0:b0:6d4:4eea:bd22 with SMTP id
 41be03b00d2f7-7edd7b857bfmr25632a12.4.1730295985486; Wed, 30 Oct 2024
 06:46:25 -0700 (PDT)
Date: Wed, 30 Oct 2024 06:46:24 -0700
In-Reply-To: <71f0fb41-d5a7-450b-ba47-ad6c39dce586@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
 <20240905124107.6954-3-pratikrajesh.sampat@amd.com> <Zw2fW2AJU-_Yi5U6@google.com>
 <4984cba7-427a-4065-9fcc-97b9f67163ed@amd.com> <Zx_QJJ1iAYewvP-k@google.com> <71f0fb41-d5a7-450b-ba47-ad6c39dce586@amd.com>
Message-ID: <ZyI4cRLsaTQ3FMk7@google.com>
Subject: Re: [PATCH v3 2/9] KVM: selftests: Add a basic SNP smoke test
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, pgonda@google.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 28, 2024, Pratik R. Sampat wro4te:
> On 10/28/2024 12:55 PM, Sean Christopherson wrote:
> > On Mon, Oct 21, 2024, Pratik R. Sampat wrote:
> >>>> +		if (unlikely(!is_smt_active()))
> >>>> +			snp_policy &= ~SNP_POLICY_SMT;
> >>>
> >>> Why does SNP_POLICY assume SMT?  And what is RSVD_MBO?  E.g. why not this?
> >>>
> >>> 		u64 policy = is_smt_active() ? SNP_POLICY_SMT : SNP_POLICY;
> >>>
> >>
> >> I think most systems support SMT so I enabled the bit in by default and
> >> only unset it when there isn't any support.
> > 
> > That's confusing though, because you're mixing architectural defines with semi-
> > arbitrary selftests behavior.  RSVD_MBO on the other is apparently tightly coupled
> > with SNP, i.e. SNP can't exist without that bit, so it makes sense that RSVD_MBO
> > needs to be part of SNP_POLICY
> > 
> > If you want to have a *software*-defined default policy, then make it obvious that
> > it's software defined.  E.g. name the #define SNP_DEFAULT_POLICY, not simply
> > SNP_POLICY, because the latter is too easily misconstrued as the base SNP policy,
> > which it is not.  That said, IIUC, SMT *must* match the host configuration, i.e.
> > whether or not SMT is set is non-negotiable.  In that case, there's zero value in
> > defining SNP_DEFAULT_POLICY, because it can't be a sane default for all systems.
> > 
> 
> Right, SMT should match the host configuration. Would a
> SNP_DEFAULT_POLICY work if we made it check for SMT too in the macro?
> 
> Instead of,
> #define SNP_POLICY	(SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO)
> 
> Have something like this instead to make it generic and less ambiguous?
> #define SNP_DEFAULT_POLICY()		 			       \
> ({								       \
> 	SNP_POLICY_RSVD_MBO | (is_smt_active() ? SNP_POLICY_SMT : 0);  \
> })

No, unless it's the least awful option, don't hide dynamic functionality in a macro
that looks like it holds static data.  The idea is totally fine, but put it in an
actual helper, not a macro, _if_ there's actually a need for a default policy.
If there's only ever one main path that creates SNP VMs, then I don't see the point
in specifying a default policy.

> > Side topic, I assume one of SEV_POLICY_NO_DBG or SNP_POLICY_DBG *must* be specified, 
> > and that they are mutualy exclusive?  E.g. what happens if the full policy is simply
> > SNP_POLICY_RSVD_MBO?
> 
> SEV_POLICY_NO_DBG is mainly for the guest policy structure of SEV and
> SEV-ES - pg 31, Table 2
> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/55766_SEV-KM_API_Specification.pdf
> 
> and, SNP_POLICY_DBG is a bit in the guest policy structure of SNP - pg
> 27, Table 9
> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56860.pdf
> 
> In the former, a SEV guest disables debugging if SEV_POLICY_NO_DBG is
> set. Similarly, a SNP guest enables debugging if SNP_POLICY_DBG is set.

Ugh, one is SEV_xxx, the other is SNP_xxx.  Argh!  And IIUC, they are mutually
exclusive (totally separate thigns?), because SNP guests use an 8-byte structure,
whereas SEV/SEV-ES use a 4-byte structure, and with different layouts.

That means this is _extremely_ confusing.  Separate the SEV_xxx defines from the
SNP_xxx defines, because other than a name, they have nothing in common.

+/* Minimum firmware version required for the SEV-SNP support */
+#define SNP_FW_REQ_VER_MAJOR   1
+#define SNP_FW_REQ_VER_MINOR   51

Side topic, why are these hardcoded?  And where did they come from?  If they're
arbitrary KVM selftests values, make that super duper clear.

+#define SNP_POLICY_MINOR_BIT   0
+#define SNP_POLICY_MAJOR_BIT   8

s/BIT/SHIFT.  "BIT" implies they are a single bit, which is obviously not the
case.  But I vote to omit the extra #define entirely and just open code the shift
in the SNP_FW_VER_{MAJOR,MINOR} macros.

 #define SEV_POLICY_NO_DBG      (1UL << 0)
 #define SEV_POLICY_ES          (1UL << 2)
+#define SNP_POLICY_SMT         (1ULL << 16)
+#define SNP_POLICY_RSVD_MBO    (1ULL << 17)
+#define SNP_POLICY_DBG         (1ULL << 19)
+#define SNP_POLICY             (SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO)
+
+#define SNP_FW_VER_MAJOR(maj)  ((uint8_t)(maj) << SNP_POLICY_MAJOR_BIT)
+#define SNP_FW_VER_MINOR(min)  ((uint8_t)(min) << SNP_POLICY_MINOR_BIT)

