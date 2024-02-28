Return-Path: <linux-kselftest+bounces-5545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29CE86B4D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 17:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143E01C2244E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E194A3FBB2;
	Wed, 28 Feb 2024 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVqn6QUE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28943FBA9;
	Wed, 28 Feb 2024 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137610; cv=none; b=ccJq6f9D+yLH0pwMh/AIGPYaRu/QJW06klzC5mij8DWEH4u+CmLhgiRTeMA2seQfTDDXse8E5ZctzM8BGepGafhGEEKEXJiVtQjNjRAJsfe8StNT9k87ev6i83LGIuLiiYBNOyitOVO4Nfpc/BjmxyR7loE2SvbX5DZY8Ek+rsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137610; c=relaxed/simple;
	bh=1mSJiKFveQIcxWUIOdkvzQ2W+3D7jbH1bL69Ehdc/yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcdeET4XmV8RAeEUhztc34VBXp25TMImMmbW85NCZXXo1qV8e3QJhy9RB2wL22pek38LT5USdapTRg7cnZpro3F9BycSBqXTzwGzRGVZ45XR3zPZgjNWBGBGbIuoxasDj1WqYPfEwe5rh3w/aI14AMiA+2vRVqBZzy8e/RUBWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVqn6QUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155E1C433C7;
	Wed, 28 Feb 2024 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709137610;
	bh=1mSJiKFveQIcxWUIOdkvzQ2W+3D7jbH1bL69Ehdc/yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVqn6QUEeQbM2a4tYvbqKYOaLr8t7uOwvVSd3bqV+lsvDt9tkYSR8xnsdKr+lOCiU
	 CZOf9vQt2KEnN4bveiKcvGMJTXjxm2PhqkAsnz5WypOWq7OwnrpyTX58fEfNwX7J8l
	 eG9bQXiTQ1jwb0FPIjcsrBj+coy8kR3/3ZL5mtHjIuspJ8SlbH949BMqZudWeekl23
	 1jKX3aYwVPEcGT4aXxac6TXOf2h+HJSnkv4I388UUZPlt+TAiDSx4mPJorTFR+6tKd
	 3B8oABI8qB8/gfrybDKR/LttigggdNps8lLOUx5kQwegY6B5PBenGShBGh26yMAG/4
	 dax5em0LZHBrA==
Date: Wed, 28 Feb 2024 10:26:47 -0600
From: Rob Herring <robh@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 5/7] arm64: Unconditionally call
 unflatten_device_tree()
Message-ID: <20240228162647.GA4086865-robh@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
 <20240217010557.2381548-6-sboyd@kernel.org>
 <20240223000317.GA3835346-robh@kernel.org>
 <20240223102345.GA10274@willie-the-truck>
 <CAL_JsqJSeSHeWV3YJE9n2NuY+s_iE6f7N5C_oguEJn7jTZ20xA@mail.gmail.com>
 <Zd4dQpHO7em1ji67@FVFF77S0Q05N.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd4dQpHO7em1ji67@FVFF77S0Q05N.cambridge.arm.com>

On Tue, Feb 27, 2024 at 05:34:58PM +0000, Mark Rutland wrote:
> On Fri, Feb 23, 2024 at 11:17:02AM -0700, Rob Herring wrote:
> > On Fri, Feb 23, 2024 at 3:23 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Thu, Feb 22, 2024 at 05:03:17PM -0700, Rob Herring wrote:
> > > > On Fri, Feb 16, 2024 at 05:05:54PM -0800, Stephen Boyd wrote:
> > > > > Call this function unconditionally so that we can populate an empty DTB
> > > > > on platforms that don't boot with a firmware provided or builtin DTB.
> > > > > When ACPI is in use, unflatten_device_tree() ignores the
> > > > > 'initial_boot_params' pointer so the live DT on those systems won't be
> > > > > whatever that's pointing to. Similarly, when kexec copies the DT data
> > > > > the previous kernel to the new one on ACPI systems,
> > > > > of_kexec_alloc_and_setup_fdt() will ignore the live DT (the empty root
> > > > > one) and copy the 'initial_boot_params' data.
> > > > >
> > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: <linux-arm-kernel@lists.infradead.org>
> > > > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > > > ---
> > > > >  arch/arm64/kernel/setup.c | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > Catalin, Will, Can I get an ack on this so I can take the series via the
> > > > DT tree.
> > >
> > > Mark had strong pretty strong objections to this in version one:
> > 
> > Yes, I had concerns with it as well.
> > 
> > > https://lore.kernel.org/all/ZaZtbU9hre3YhZam@FVFF77S0Q05N/
> > >
> > > and this patch looks the same now as it did then. Did something else
> > > change?
> > 
> > Yes, that version unflattened the bootloader passed DT. Now within
> > unflatten_devicetree(), the bootloader DT is ignored if ACPI is
> > enabled and we unflatten an empty tree. That will prevent the kernel
> > getting 2 h/w descriptions if/when a platform does such a thing. Also,
> > kexec still uses the bootloader provided DT as before.
> 
> That avoids the main instance of my concern, and means that this'll boot
> without issue, but IIUC this opens the door to dynamically instantiating DT
> devices atop an ACPI base system, which I think in general is something that's
> liable to cause more problems than it solves.
> 
> I understand that's desireable for the selftests, though I still don't believe
> it's strictly necessary -- there are plenty of other things that only work if
> the kernel is booted in a specific configuration.

Why add to the test matrix if we don't have to?

> Putting the selftests aside, why do we need to do this? Is there any other
> reason to enable this?

See my Plumbers talk...

Or in short, there's 3 main usecases:

- PCI FPGA card with devices instantiated in it 
- SoCs which expose their peripherals via a PCI endpoint.
- Injecting test devices with QEMU (testing, but not what this series 
  does. Jonathan Cameron's usecase)

In all cases, drivers already exist for the devices, and they often only 
support DT. DT overlays is the natural solution for this, and there's 
now kernel support for it (dynamically generating PCI DT nodes when they 
don't exist). The intent is to do the same thing on ACPI systems.

I don't see another solution other than 'go away, you're crazy'. There's 
ACPI overlays, but that's only a debug feature. Also, that would 
encourage more of the DT bindings in ACPI which I find worse than this 
mixture. There's swnodes, but that's just board files and platform_data 
2.0.

I share the concerns with mixing, but I don't see a better solution. The 
scope of what's possible is contained enough to avoid issues.

Rob

