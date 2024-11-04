Return-Path: <linux-kselftest+bounces-21384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B28C9BB6D2
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 14:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F371F235C8
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495AD14D719;
	Mon,  4 Nov 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5BDM4Xi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FF13635C;
	Mon,  4 Nov 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728467; cv=none; b=RNJGeo+48g5MNp+O+7VYMciM2OchzA1kck9ahzcEo2ZUsLg59vnFuJj/7u+90/FRmgCcAyJrH4SIkSzQTwKZ8wQ/HTQyM3tuZBil+vu5EOzUXION6SOj4QBXEn9pddc5vARB6xO7POJWwlZlkcB4Dmm1UWDNwWglUD0IwTBio0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728467; c=relaxed/simple;
	bh=sZurbIwzYuS4yLWi6DkfdRraXzSZGcCRAs9+v0qzfrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBFyaQzISKaXg6IFeptik/cdyjeCyIz5nhhSJvfdjS9XGDBk+t8ChaCOghTizF7L9Cym88DCrnSIMrMfPyod7IiNLwSotgK6KAgnffQNZ9AUSmmP75LJRWXF02qXUdBD7uTmqIQNDQJrux2+EY/ROLtFxkqKyFJPg23rUGFQNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5BDM4Xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25CFC4CEDB;
	Mon,  4 Nov 2024 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730728466;
	bh=sZurbIwzYuS4yLWi6DkfdRraXzSZGcCRAs9+v0qzfrE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q5BDM4Xi1gOJwvFZTupaLks/gQGYzcECQMKtb1FIfjgKOhTka1GRmJOghSmpApkE0
	 EFJJrzoY8sI0C2SiN/3TkUZEwWSa0zsJ/fStV4D4BHtp3C+ua1QWa03YjFdQm1W6pr
	 sjaxAwpqEhYb6xm8YBtIDy/P08x3jYzLbYAV/182HZcvh+G4JXSawt5TIBJpUi3Pdh
	 ILgi2kqTxQzGA3eqx1VLHy5LdFwJXCOtZX3+cRs4c1/RFB1uaMzobP+6RKn46xIVgC
	 MmQk1THwQSl8VvLYoEqqbzVyLlX+CYxykHAKFYnqghs7LsRhHe61DGjbbTejdNUJBJ
	 nQSsKoC141iaw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso62217391fa.3;
        Mon, 04 Nov 2024 05:54:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqYSm1bl0Q3ryqkoMTfTIaCt8iajfUFoh4jaMtCj4DRYzg4CRB91Xrp3OvLDSQt2vwNDWVcuUBTBzgIj+0/Jnv@vger.kernel.org, AJvYcCUtyJ7f5RshiMba/X7XAFDVIkwAMymFgOdyYMo7rUzxlQW0fT+v0wFEG/ZicUDgtfZBOqr/DmPTApnk@vger.kernel.org, AJvYcCVZaij/4smfQa7FJyzJsrvEIc+HYmBuVmeUbkvgemM5ZH1+EeFS4Rh8aQtYX5b35nIK80Q=@vger.kernel.org, AJvYcCVbZkHH4xFp69CFqbGyUfCVYY+OnzQTkE7KgCJV8aFB5H1Mjq6BuoUeyQidx2hZNOW4OaBMpjcY5ic=@vger.kernel.org, AJvYcCX9PC+RbPqg7F0I+qEGKmxQd0Fi/0GsuD0s//sjHw4nAnoueb91aBGnnk4NGqegOD4eEG1N3BPd6MnTX0qo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6gX2BAMt6dFDy3Iccq22rCOgojJDLyFpVXULmqebOUnTw15Wq
	83GG3Vup7v87Az+nHpNr3KyguRENdF3OE3Q+SjLP4ajJHLgLA8nb+ZHJ0zX/7oEttPlBm7SgurA
	SbIFafLxpGzYOhV3S7gLQeb99Ycw=
X-Google-Smtp-Source: AGHT+IEDPSajd0Ijul/NTdTCOsnUC5WH3yaxWxO7av85XXQJwq7H6ghrIewBObwz96ILox5H6B1VjAJt6rSncXXA+ys=
X-Received: by 2002:a05:651c:506:b0:2fc:9869:2e0b with SMTP id
 38308e7fff4ca-2fedb7c7dc2mr79712841fa.20.1730728464965; Mon, 04 Nov 2024
 05:54:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019172459.2241939-1-dwmw2@infradead.org> <20241019172459.2241939-7-dwmw2@infradead.org>
 <ZyPEn4qhaYyYqrzk@lpieralisi> <ZyUUh6KawapLkj0z@lpieralisi>
In-Reply-To: <ZyUUh6KawapLkj0z@lpieralisi>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 4 Nov 2024 14:54:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFma8-GqKuOs5-UAQY9asbq2p9EubSjjbywaURa4T4WnA@mail.gmail.com>
Message-ID: <CAMj1kXFma8-GqKuOs5-UAQY9asbq2p9EubSjjbywaURa4T4WnA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] arm64: Use SYSTEM_OFF2 PSCI call to power off for hibernate
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, sami.mujawar@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Shuah Khan <shuah@kernel.org>, 
	David Woodhouse <dwmw@amazon.co.uk>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	Francesco Lavra <francescolavra.fl@gmail.com>, Miguel Luis <miguel.luis@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 18:49, Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
>
> [+Ard, Sami, for EFI]
>
> On Thu, Oct 31, 2024 at 06:55:43PM +0100, Lorenzo Pieralisi wrote:
> > On Sat, Oct 19, 2024 at 06:15:47PM +0100, David Woodhouse wrote:
> >
> > [...]
> >
> > > +#ifdef CONFIG_HIBERNATION
> > > +static int psci_sys_hibernate(struct sys_off_data *data)
> > > +{
> > > +   /*
> > > +    * Zero is an acceptable alternative to PSCI_1_3_OFF_TYPE_HIBERNATE_OFF
> > > +    * and is supported by hypervisors implementing an earlier version
> > > +    * of the pSCI v1.3 spec.
> > > +    */
> >
> > It is obvious but with this patch applied a host kernel would start executing
> > SYSTEM_OFF2 too if supported in firmware to hibernate, it is not a hypervisor
> > only code path.
> >
> > Related to that: is it now always safe to override
> >
> > commit 60c0d45a7f7a ("efi/arm64: use UEFI for system reset and poweroff")
> >
> > for hibernation ? It is not very clear to me why overriding PSCI for
> > poweroff was the right thing to do - tried to follow that patch history but
> > the question remains (it is related to UpdateCapsule() but I don't know
> > how that applies to the hibernation use case).
>
> RFC: It is unclear to me what happens in current mainline if we try to
> hibernate with EFI runtime services enabled and a capsule update pending (we
> issue EFI ResetSystem(EFI_RESET_SHUTDOWN,..) which might not be compatible
> with the reset required by the pending capsule update request) what happens
> in this case I don't know but at least the choice is all contained in
> EFI firmware.
>
> Then if in the same scenario now we are switching to PSCI SYSTEM_OFF2 for the
> hibernate reset I suspect that what happens to the in-flight capsule
> update requests strictly depends on what "reset" PSCI SYSTEM_OFF2 will
> end up doing ?
>
> I think this is just a corner case and it is unlikely it has been ever
> tested (is it even possible ? Looking at EFI folks) - it would be good
> to clarify it at least to make sure we understand this code path.
>

I'm not aware of any OS that actually uses capsule update at runtime
(both Windows and Linux queue up the capsule and call the
UpdateCapsule() runtime service at boot time after a reboot).

So it is unlikely that this would break anything, and I'd actually be
inclined to disable capsule update at runtime altogether.

I will also note that hibernation with EFI is flaky in general, given
that EFI memory regions may move around

