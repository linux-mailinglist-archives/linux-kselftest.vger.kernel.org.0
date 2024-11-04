Return-Path: <linux-kselftest+bounces-21386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0267B9BB8A3
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 16:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4432838F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8881BC065;
	Mon,  4 Nov 2024 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxceTN5N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407D4A08;
	Mon,  4 Nov 2024 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733096; cv=none; b=KEnJpt3f8QHCEV6AttZFYTsAr5voZ5++aWHrEtSmxGw468dfa8lIjKXpr2XlL4zKWZZMVW07fJTtCETZJ4elgnhQTINg+a7OVgdlBF9XB9/zg9onRGhZKyhzGWYhuQF2DfkWMaYINi+o1yyj5SfFZl82Gw6dSg7Th6tn6sipj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733096; c=relaxed/simple;
	bh=kTcIvo7yioetmpNQbu0IC5h4s6IrPCBWdMVl5D73t7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/4MfXs2h+9gsFfPmilwtAYpQkgUwk6S05C5oHqmpFIz0Z9ZYutPwMQ+02wIfwFjKa/SJePEV8nX4ww7DplNcppNQMooYqFZBBLZJrISpYPeYMGfTWodu6hbYc9zeoLV6UvkhQrCFz9FLv94WDE4yj9jV1tO49q6IgZ/Fc1KT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxceTN5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3BEC4CECE;
	Mon,  4 Nov 2024 15:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730733095;
	bh=kTcIvo7yioetmpNQbu0IC5h4s6IrPCBWdMVl5D73t7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxceTN5NoMnOb7R/VPtFgRQBTl8fQIQGc+4Gk8OT4K//G+8yFdf1m763nh4hbSYjQ
	 Q8L0dM+aIbjCHQBdLLToU6JHIkL0xE1N1MhABdTFa4no5VZJo28LxZQQBoWB/t2irM
	 h5+K4mIJXpoBeCpFomfpoaJA0yVQ95MKtcPaM1xFuLRiXCcZpu4o9nJ6qlaqTN5121
	 YfE8P7UqD3VEHAvSGFS2dsG4TFkL6XuDxtv562XTMv3j6/0Cdx0wFHXFycCvk81Ndz
	 w+K2Nd4Qks64XUx2V2qChbExvIWBEDSFoFlvjbEWoQUHMeDg67rC+qPPhYHGReiBK2
	 bN5bKB2JDwa6w==
Date: Mon, 4 Nov 2024 16:11:23 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, sami.mujawar@arm.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: Re: [PATCH v6 6/6] arm64: Use SYSTEM_OFF2 PSCI call to power off for
 hibernate
Message-ID: <ZyjkGwkrQ+R+fI8m@lpieralisi>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
 <20241019172459.2241939-7-dwmw2@infradead.org>
 <ZyPEn4qhaYyYqrzk@lpieralisi>
 <ZyUUh6KawapLkj0z@lpieralisi>
 <CAMj1kXFma8-GqKuOs5-UAQY9asbq2p9EubSjjbywaURa4T4WnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFma8-GqKuOs5-UAQY9asbq2p9EubSjjbywaURa4T4WnA@mail.gmail.com>

On Mon, Nov 04, 2024 at 02:54:12PM +0100, Ard Biesheuvel wrote:
> On Fri, 1 Nov 2024 at 18:49, Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> >
> > [+Ard, Sami, for EFI]
> >
> > On Thu, Oct 31, 2024 at 06:55:43PM +0100, Lorenzo Pieralisi wrote:
> > > On Sat, Oct 19, 2024 at 06:15:47PM +0100, David Woodhouse wrote:
> > >
> > > [...]
> > >
> > > > +#ifdef CONFIG_HIBERNATION
> > > > +static int psci_sys_hibernate(struct sys_off_data *data)
> > > > +{
> > > > +   /*
> > > > +    * Zero is an acceptable alternative to PSCI_1_3_OFF_TYPE_HIBERNATE_OFF
> > > > +    * and is supported by hypervisors implementing an earlier version
> > > > +    * of the pSCI v1.3 spec.
> > > > +    */
> > >
> > > It is obvious but with this patch applied a host kernel would start executing
> > > SYSTEM_OFF2 too if supported in firmware to hibernate, it is not a hypervisor
> > > only code path.
> > >
> > > Related to that: is it now always safe to override
> > >
> > > commit 60c0d45a7f7a ("efi/arm64: use UEFI for system reset and poweroff")
> > >
> > > for hibernation ? It is not very clear to me why overriding PSCI for
> > > poweroff was the right thing to do - tried to follow that patch history but
> > > the question remains (it is related to UpdateCapsule() but I don't know
> > > how that applies to the hibernation use case).
> >
> > RFC: It is unclear to me what happens in current mainline if we try to
> > hibernate with EFI runtime services enabled and a capsule update pending (we
> > issue EFI ResetSystem(EFI_RESET_SHUTDOWN,..) which might not be compatible
> > with the reset required by the pending capsule update request) what happens
> > in this case I don't know but at least the choice is all contained in
> > EFI firmware.
> >
> > Then if in the same scenario now we are switching to PSCI SYSTEM_OFF2 for the
> > hibernate reset I suspect that what happens to the in-flight capsule
> > update requests strictly depends on what "reset" PSCI SYSTEM_OFF2 will
> > end up doing ?
> >
> > I think this is just a corner case and it is unlikely it has been ever
> > tested (is it even possible ? Looking at EFI folks) - it would be good
> > to clarify it at least to make sure we understand this code path.
> >
> 
> I'm not aware of any OS that actually uses capsule update at runtime
> (both Windows and Linux queue up the capsule and call the
> UpdateCapsule() runtime service at boot time after a reboot).
> 
> So it is unlikely that this would break anything, and I'd actually be
> inclined to disable capsule update at runtime altogether.
> 
> I will also note that hibernation with EFI is flaky in general, given
> that EFI memory regions may move around

Thank you for chiming in, I think we are OK (I don't think this patch
will create more issues than the ones that are already there for hibernate
anyway) - the reasoning behind the change is in the commit logs.

Lorenzo

