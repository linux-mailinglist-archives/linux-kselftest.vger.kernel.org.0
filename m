Return-Path: <linux-kselftest+bounces-21228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A93A89B8007
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 17:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDF81C21B2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9FC1BCA1C;
	Thu, 31 Oct 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LOU5OBPZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4F1BBBD8
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392042; cv=none; b=dYdqlongQs0rp7oHxpQDrw7ouK0CZo3fKNwN+cPk637g8JwEJF5yhOG7IlmO3RVX4+L6jRwyIlp8A1nMR1i+X9E7hGOeX+Vmz/GPJeR3u3xeSC7T5kGzdpb60GED+beq6rSWhLFGTJr3+L3oeNuO0aVc9wo9IN9KcOVQ2+dm5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392042; c=relaxed/simple;
	bh=NU0xaNlNHGmQK844TSiXuj7X7LIE06A9gv89YXL980A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zd/ja0VBUaTAJdFEIFGKtTeaiQP2Ae7CEiwbgEEDEOOaLm7MtwaGrptAW8By1s1KpLkx0wFf6m4RTGE+r7HwbkL+BxEpqosWIW+nmQri1KwPwbjqSqHLbP6C7ULpMWBSalWC03NBKJW/PLUFX+/4S7eS8MVUCJ7QCdHhi//8dEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LOU5OBPZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so1914153276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730392039; x=1730996839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=htdto3GIHZjF9NL40XLaFDklPXk3MFHaGDKHh7lyDhU=;
        b=LOU5OBPZCwQ5iAoVwdK3D1TD2xjn2WRD3mZQ+w2ba27CfTsUlcKqx0GHwYi/ZnWt1t
         PeX3zRMC7N08oVkRvqwFKWr74pZw9CJf8LRNacbphbwnF3HAw3L4UY8aWwzdqsuCACi4
         cwBJV4h7r5hSN3sDC0Bt53gFyZ1xhex+om4RWKdULsCweWTwpWxIlpX2vTq5HRC3EC3k
         tPtOY4f0dMaIcKZ3D07ezduFkjwDD8jJE92IPH9nL7Lrwc6OjP2geq8xVyOvA17mVHOs
         1Ds1npT6Euzjvobccg/HKftvewLli7gg+mXgaIkNaI06eFxbHm2S5MoBcP8rVrjvVYCM
         5Tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730392039; x=1730996839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htdto3GIHZjF9NL40XLaFDklPXk3MFHaGDKHh7lyDhU=;
        b=CUBrutjKXR8BcmlEjZcF05/i0ty2fMX8JFll7Ut/jll2fYITgmq2NFM39t/1qZJt+8
         bIwW6D7+42vGJ9RvZ6xFPzSDd8jWrIZd5FwW/Spa8tV+hFklsHFcaO8drALpk9vYJts+
         7UvyjgPQaynUsl7K/Ioi9o9T9p+cfNKFgPw0d48jyJcn9gWdyNpcnRw8hmPIUm/LBYU/
         jrm7K2Zu9WxbB1yHZwKCR2KoEJXcPVpa/qYbYKEsJv98MKKG1f5Sk2vV3MQVTV1lW/3n
         zBePJK72T88b3KVHObX+X9LDnmQxHk/Mf4hBMGu5WdweTk6ssEdjGn+bVNvKAeT3M8Kl
         Pv9A==
X-Forwarded-Encrypted: i=1; AJvYcCXKbWaw/gND2dgMP/voQ9s6ZhCfKWDwQ7YpYkBPYghHHJoNszhdRiPJb6vFe/n1Kc2JNNGQMHoydRm86TVSDzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvZ+xrJ1eSngkQQfQwxQ8fTzMAvBFsIRVM2luvlQK16Sp1yM1U
	mK79sSJjVesZRU+z/x9FNxYnq/lvyw4PHorfm0wTMggDAOSZJO/HSveZqPWgTOrnZXnaoxc7j+v
	+9g==
X-Google-Smtp-Source: AGHT+IH9PK36u636nwxFPXdS66ZnSfGY1YetAREPu6oHLX8U7RtYCb075OWMHk0HfgZtYlvRJ+T+jRRWWLs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:df8e:0:b0:e30:d896:dde3 with SMTP id
 3f1490d57ef6-e33026cf50fmr1278276.11.1730392039328; Thu, 31 Oct 2024 09:27:19
 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:27:17 +0000
In-Reply-To: <11787a92-66ed-41ef-9623-d6c7220fb861@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
 <20240905124107.6954-3-pratikrajesh.sampat@amd.com> <Zw2fW2AJU-_Yi5U6@google.com>
 <4984cba7-427a-4065-9fcc-97b9f67163ed@amd.com> <Zx_QJJ1iAYewvP-k@google.com>
 <71f0fb41-d5a7-450b-ba47-ad6c39dce586@amd.com> <ZyI4cRLsaTQ3FMk7@google.com>
 <de2a6758-a906-4dc0-b481-6ce73aba24b9@amd.com> <ZyJzcOCPJstrumbE@google.com> <11787a92-66ed-41ef-9623-d6c7220fb861@amd.com>
Message-ID: <ZyOv5US9u22lAiPU@google.com>
Subject: Re: [PATCH v3 2/9] KVM: selftests: Add a basic SNP smoke test
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, pgonda@google.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 31, 2024, Pratik R. Sampat wrote:
> Hi Sean,
> 
> On 10/30/2024 12:57 PM, Sean Christopherson wrote:
> > On Wed, Oct 30, 2024, Pratik R. Sampat wrote:
> >> On 10/30/2024 8:46 AM, Sean Christopherson wrote:
> >>> +/* Minimum firmware version required for the SEV-SNP support */
> >>> +#define SNP_FW_REQ_VER_MAJOR   1
> >>> +#define SNP_FW_REQ_VER_MINOR   51
> >>>
> >>> Side topic, why are these hardcoded?  And where did they come from?  If they're
> >>> arbitrary KVM selftests values, make that super duper clear.
> >>
> >> Well, it's not entirely arbitrary. This was the version that SNP GA'd
> >> with first so that kind of became the minimum required version needed.
> >>
> >> I think the only place we've documented this is here -
> >> https://github.com/AMDESE/AMDSEV/tree/snp-latest?tab=readme-ov-file#upgrade-sev-firmware.
> >>
> >> Maybe, I can modify the comment above to say something like -
> >> Minimum general availability release firmware required for SEV-SNP support.
> > 
> > Hmm, so if AMD says SNP is only supported for firmware version >= 1.51, why on
> > earth is that not checked and enforced by the kernel?  Relying on userspace to
> > not crash the host (or worse) because of unsupported firmware is not a winning
> > strategy.
> 
> We do check against the firmware level 1.51 while setting things up
> first (drivers/crypto/ccp/sev-dev.c:__sev_snp_init_locked()) and we bail
> out if it's otherwise. From the userspace, calls to KVM_SEV_INIT2 or any
> other corresponding SNP calls should fail cleanly without any adverse
> effects to the host.

And I'm saying, that's not good enough.  If the platform doesn't support SNP,
the KVM *must not* advertise support for SNP.

> From the positive selftest perspective though, we want to make sure it's
> both supported and enabled, and skip the test if not.

No, we want the test to assert that KVM reports SNP support if and only if SNP
is 100% supported.

> I believe we can tell if it's supported by the platform using the MSR -
> MSR_AMD64_SEV_SNP_ENABLED or the X86_FEATURE_SEV_SNP from the KVM
> capabilities. However, to determine if it's enabled from the kernel, I
> made this check here. Having said that, I do agree that there should
> probably be a better way to expose this support to the userspace.
> 
> Thanks
> Pratik

