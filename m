Return-Path: <linux-kselftest+bounces-21313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CAB9B96D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 18:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810FC1F2151E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 17:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FED41CEAB0;
	Fri,  1 Nov 2024 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjtBASiJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89201CDA1E;
	Fri,  1 Nov 2024 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483343; cv=none; b=tZY3HUMapFdNO77K7KQYxXlnU9j/FnKICgpCqKybG39nOh8Nx4HtjqsS5ugcPYmJ2dk7qq1y8gzfHuobZrf9pyq7SfFGZ2tqSe+gQTiCpL1oRwcGIml4fSCCUId4FSQnbpigAq3p+UdNtDzPnKxHlJEkoZYvy1j1DYnFOMaCr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483343; c=relaxed/simple;
	bh=/b91CoH0L4+ZOxrMGr0zsD4PKr5FuOWyhTBccBHPH7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY862RUOU+qViJAjj52Nv2gVmc4W5gp2DCC8UZV54Gn3TF9TcjTxI2PEQg0+W8cXl6wPIt+I7AwA/3Z3ZAqS1azIiIGimxWA5gPFVOPHu423TM7ciklJfpNEhRC1A7Aqnyt0dkrzDYv+u9FdaZeWR1sB1QEpPm8Bd5/80yVondc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjtBASiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E5DC4CECD;
	Fri,  1 Nov 2024 17:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730483343;
	bh=/b91CoH0L4+ZOxrMGr0zsD4PKr5FuOWyhTBccBHPH7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LjtBASiJpj3wSWJdTJkZgQD3yarqRwCy6apE0QFm4Yo6QoTSPUahEDoXH/eZR5Wd6
	 loXUanal2E/JmK4aF1aCq61B4EkINhFbMdzBp21IbCNAnSVmM7wQEdroXQVurZg9Dl
	 WdjtXYLh3YN+FlE7SojVKHollfTiMWZ3WUSCE/Vnl5hbcudFjg+YsV6bwC5VhD2hdW
	 rwHsJ3S7bKIes/RzbFtfxPjx4qZDEoueK/xypG9lfrEjtOe5CpRmzRrkkS/a6RqPht
	 so5a9ymD7x0VWkisb6FJTR0pGEnM+OYO8duhU05uFutMCvjJPGgA6Rl7Jdg6rGQ/lB
	 ukMPsfwBG2mTg==
Date: Fri, 1 Nov 2024 18:48:55 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, sami.mujawar@arm.com,
	ardb@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
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
Message-ID: <ZyUUh6KawapLkj0z@lpieralisi>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
 <20241019172459.2241939-7-dwmw2@infradead.org>
 <ZyPEn4qhaYyYqrzk@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyPEn4qhaYyYqrzk@lpieralisi>

[+Ard, Sami, for EFI]

On Thu, Oct 31, 2024 at 06:55:43PM +0100, Lorenzo Pieralisi wrote:
> On Sat, Oct 19, 2024 at 06:15:47PM +0100, David Woodhouse wrote:
> 
> [...]
> 
> > +#ifdef CONFIG_HIBERNATION
> > +static int psci_sys_hibernate(struct sys_off_data *data)
> > +{
> > +	/*
> > +	 * Zero is an acceptable alternative to PSCI_1_3_OFF_TYPE_HIBERNATE_OFF
> > +	 * and is supported by hypervisors implementing an earlier version
> > +	 * of the pSCI v1.3 spec.
> > +	 */
> 
> It is obvious but with this patch applied a host kernel would start executing
> SYSTEM_OFF2 too if supported in firmware to hibernate, it is not a hypervisor
> only code path.
> 
> Related to that: is it now always safe to override
> 
> commit 60c0d45a7f7a ("efi/arm64: use UEFI for system reset and poweroff")
> 
> for hibernation ? It is not very clear to me why overriding PSCI for
> poweroff was the right thing to do - tried to follow that patch history but
> the question remains (it is related to UpdateCapsule() but I don't know
> how that applies to the hibernation use case).

RFC: It is unclear to me what happens in current mainline if we try to
hibernate with EFI runtime services enabled and a capsule update pending (we
issue EFI ResetSystem(EFI_RESET_SHUTDOWN,..) which might not be compatible
with the reset required by the pending capsule update request) what happens
in this case I don't know but at least the choice is all contained in
EFI firmware.

Then if in the same scenario now we are switching to PSCI SYSTEM_OFF2 for the
hibernate reset I suspect that what happens to the in-flight capsule
update requests strictly depends on what "reset" PSCI SYSTEM_OFF2 will
end up doing ?

I think this is just a corner case and it is unlikely it has been ever
tested (is it even possible ? Looking at EFI folks) - it would be good
to clarify it at least to make sure we understand this code path.

Thanks,
Lorenzo

