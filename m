Return-Path: <linux-kselftest+bounces-21417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8A79BC19D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 00:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9E42826CE
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 23:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB251F4FAA;
	Mon,  4 Nov 2024 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3WO+zhJo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B365D1A76A4
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Nov 2024 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764075; cv=none; b=XhDbM7x6vfxSiE8t3A49p06aLUTsMcL0hrTL0ln98dKXHh7MbI+Q0L4HkZG/wJsariNZ6dy0n5nuzK5LsBX4tRSJRh1QPMmPMaM3NroxHPkM3KrKPtA2gAevFauBTeltrXmQgkRgoY8C9+6cEfKBRxgApdeCJH4KksBkIt84UCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764075; c=relaxed/simple;
	bh=VuTrEz6B0CL5GysxR1XqZO55nsdBJCTkuJOlegC2ybk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YdLlWnVgNTK5JYaFsf8/xap2lWp2FNLyR6uohCdMj9RYtSIi2iAuXT47/mntzMSSD8lUm8ENK/PqzpYwF15PJnjOmqPn4s9kFfSwiTb81KYW12ap8Yhj4Fiw5hUm8cp3DniSktFBhu3DBUsZzbH8GgAJD2rxgnJe3AfYwpm5prs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3WO+zhJo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e330f65bcd9so4315475276.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 15:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730764073; x=1731368873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLgb93E3IdFKE55fub5g3LbNpslMgv2LsluELOEVe/A=;
        b=3WO+zhJoclvtWAwEuQ9gGryZ6B2GmLqkMaPgo12KNa3GYoHwy7vIbfhk5UXI8qTXx/
         5TJ2z5pZ2ruaBg7UShQrq1/G0uu8hQOdGnISD2LDqWZGXJH6MSkGFzsj8238j7GHb6yD
         vO3Pg5DOCezcrg4+WVohCDlX6vLetQThQC4lOXJp0NAuO/CHQ3+NWrf3rYDut5Pzamqd
         n0dNetfzOwlfHDTC8x4YOBdQVzO/YuUT5I9zvgaYkxmtAKAQ47JhD9sVwDi3ln7h5N41
         dOohCH+xcV2v6Gn7aW639ecTqX4vywYqzrwrlXePkiqmndKwDCior/V3XMfRW2f+RB1B
         lZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730764073; x=1731368873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLgb93E3IdFKE55fub5g3LbNpslMgv2LsluELOEVe/A=;
        b=Z1VuOgVugHk1wbtXhR7+yJ4tIGOhYeV6zdZx76xG2YUMIYjOpX8tJo9hsutBxv8+z9
         2ZfxYIq2k++bzEYwpU6wwyV/lLRbgIlRKpaNgQq7Sg1ofPVVRYIGENC95QcdeNsnzX33
         4uSf4ttb0MJcaWW4PROQdNBCuUj1yoApaHt+jhGd2ZW5KgWC+ymrUX3W+dWQJuDDMstU
         8Z5Susq7Bq3SZRr+9y/g7taEkGowcepBZKg6qQmyjhAbjY/fCfNlEuxe5vXhg8kQpmby
         b+isJafKoWCbva0yvckV+hx2cmVxzpMbs5fW8v6SYprSjeL4HB6wSGvD3cZlylYZYkmS
         Lnjw==
X-Forwarded-Encrypted: i=1; AJvYcCVcIJPNqtuO3wADBSU9GgWUOmzlLBNBgCDKXdpHbJ/b2jianEshLkcgtW8XACz1+LCgtAPFwgx3sjvEFwBgM5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ1/cwxKBfRtFTR9ZT9rMxIxxyELMME7iAb0OJbRGB5NYfhDM+
	pXa9RdTnADiNHtGPYHafGwxd4W19H9dP7xiOPd4QYcIlP+h6yyR3bbM+hhqpt552jAtxnEhkMZi
	Mbg==
X-Google-Smtp-Source: AGHT+IGlEaEwGXJLOuGe7dS/h+aYhSdJnamUhYbSPbu0dExqPSuu9RSvVN/ohcjekyhnvf4uwfUmNaCQo2Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:3617:0:b0:e30:d5cf:775a with SMTP id
 3f1490d57ef6-e30e8dbf785mr36896276.6.1730764072761; Mon, 04 Nov 2024 15:47:52
 -0800 (PST)
Date: Mon, 4 Nov 2024 15:47:51 -0800
In-Reply-To: <99e64d8e-2d10-41c7-8b7e-cd059c7e7f29@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Zw2fW2AJU-_Yi5U6@google.com> <4984cba7-427a-4065-9fcc-97b9f67163ed@amd.com>
 <Zx_QJJ1iAYewvP-k@google.com> <71f0fb41-d5a7-450b-ba47-ad6c39dce586@amd.com>
 <ZyI4cRLsaTQ3FMk7@google.com> <de2a6758-a906-4dc0-b481-6ce73aba24b9@amd.com>
 <ZyJzcOCPJstrumbE@google.com> <11787a92-66ed-41ef-9623-d6c7220fb861@amd.com>
 <ZyOv5US9u22lAiPU@google.com> <99e64d8e-2d10-41c7-8b7e-cd059c7e7f29@amd.com>
Message-ID: <ZyldJ_ociCLg-b9a@google.com>
Subject: Re: [PATCH v3 2/9] KVM: selftests: Add a basic SNP smoke test
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, pgonda@google.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 04, 2024, Pratik R. Sampat wrote:
> 
> 
> On 10/31/2024 11:27 AM, Sean Christopherson wrote:
> > On Thu, Oct 31, 2024, Pratik R. Sampat wrote:
> >> Hi Sean,
> >>
> >> On 10/30/2024 12:57 PM, Sean Christopherson wrote:
> >>> On Wed, Oct 30, 2024, Pratik R. Sampat wrote:
> >>>> On 10/30/2024 8:46 AM, Sean Christopherson wrote:
> >>>>> +/* Minimum firmware version required for the SEV-SNP support */
> >>>>> +#define SNP_FW_REQ_VER_MAJOR   1
> >>>>> +#define SNP_FW_REQ_VER_MINOR   51
> >>>>>
> >>>>> Side topic, why are these hardcoded?  And where did they come from?  If they're
> >>>>> arbitrary KVM selftests values, make that super duper clear.
> >>>>
> >>>> Well, it's not entirely arbitrary. This was the version that SNP GA'd
> >>>> with first so that kind of became the minimum required version needed.
> >>>>
> >>>> I think the only place we've documented this is here -
> >>>> https://github.com/AMDESE/AMDSEV/tree/snp-latest?tab=readme-ov-file#upgrade-sev-firmware.
> >>>>
> >>>> Maybe, I can modify the comment above to say something like -
> >>>> Minimum general availability release firmware required for SEV-SNP support.
> >>>
> >>> Hmm, so if AMD says SNP is only supported for firmware version >= 1.51, why on
> >>> earth is that not checked and enforced by the kernel?  Relying on userspace to
> >>> not crash the host (or worse) because of unsupported firmware is not a winning
> >>> strategy.
> >>
> >> We do check against the firmware level 1.51 while setting things up
> >> first (drivers/crypto/ccp/sev-dev.c:__sev_snp_init_locked()) and we bail
> >> out if it's otherwise. From the userspace, calls to KVM_SEV_INIT2 or any
> >> other corresponding SNP calls should fail cleanly without any adverse
> >> effects to the host.
> > 
> > And I'm saying, that's not good enough.  If the platform doesn't support SNP,
> > the KVM *must not* advertise support for SNP.
> > 
> 
> Sure, fair to expect this. Currently, if the FW check fails, SNP is not
> setup and there is nothing that indicates in the KVM capabilities (apart
> from one dmesg error) that the support does not exist.
> 
> One thing I could do (as an independent patch) is to introduce a CC API
> that abstracts the FW version check made by the CCP module. Since sev
> platform status can be gotten before INIT to extract the major and minor
> version numbers, KVM can also call into this API and use that to decide
> if the KVM capabilities for SNP must be set or not.

Why is CC_ATTR_HOST_SEV_SNP set if hardware/firmware can't actually support SNP?
KVM shouldn't have to care about some arbitrary firmware API version, the whole
point of a driver is so that KVM doesn't have to deal with such details.

I'm a-ok with a KVM selftest *asserting* that the kernel isn't broken, but KVM
itself shouldn't need to manually check the firmware version.

