Return-Path: <linux-kselftest+bounces-6055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA0C8752BE
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 16:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFDE1C24541
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859C312EBE8;
	Thu,  7 Mar 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cH3cDvDb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB712D775;
	Thu,  7 Mar 2024 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824189; cv=none; b=UWKu6j9IUMk5VfAznU3XRW7YgEl6Yg/KsAx4avXI/MP3lFVtllVeX37GznpZNmvPJalV3aiHgtiNhxks3KHRCxwbnqOS8xiztqud7WAc6LBsSPHOXhSWnJA/Xh2ldh/lI6Rf/69AttoyZZ2PZaRTXznytki+TUy5nMZi7xDLOlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824189; c=relaxed/simple;
	bh=TOUq4+BzvbJ03xI0Ru4on6BK0VEShUhAYEA+2ftljxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JL+qxiTpjmpZ5109m0bG3sOloGnF+wzV0VOrFwj3ptlvtnz7M41BtF4n9zbrCOXPv2VpmLEi9a3O0Iry+t0z3Y4RsnD7WJ3Y4BcMJYrkEO1biM0Ttr9iaXSlU+zex6te/PNhIBfxniWvsmMrGeESEG6v2BJaO9HMNsXPF/rRgCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cH3cDvDb; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 517A640006;
	Thu,  7 Mar 2024 15:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709824184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2YO5EELAYFm2yHbvmttaH3RlP1nT/5fz22vnvi4dvY=;
	b=cH3cDvDbgBL0NwR+c5yiG07kGF1VG+NjMPxfv/14+x0dhsSeDGuEwKCeaNb6jdZFkyzY+D
	La574Nc459V7/R01jXDg65BqvQHSmDykxG1XN8qBEbR7CVyi5obOAsTVQOKGfwbfehbPte
	Mh0Rc0OW1+VPfm1pV4+gARrMcjXqI+AHkuJweh3vf/IXXHCsEAYopHtavTyWsjxj5Ymp3B
	qjyrtvBI56L6eAKynWEsBr24gr7YfyTIj8DST6C37GKAqfAlQlB+BAjVOshLXP7/h/36ne
	9dU5FIm9TCbBW0wYH2ekS1iqQOxe1zEUZ5Iak1MgQMMU5guelZJgniKPbafseA==
Date: Thu, 7 Mar 2024 16:09:40 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, linux-um@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand
 <frowand.list@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 5/7] arm64: Unconditionally call
 unflatten_device_tree()
Message-ID: <20240307160940.6484ef8d@bootlin.com>
In-Reply-To: <20240228162647.GA4086865-robh@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
 <20240217010557.2381548-6-sboyd@kernel.org>
 <20240223000317.GA3835346-robh@kernel.org>
 <20240223102345.GA10274@willie-the-truck>
 <CAL_JsqJSeSHeWV3YJE9n2NuY+s_iE6f7N5C_oguEJn7jTZ20xA@mail.gmail.com>
 <Zd4dQpHO7em1ji67@FVFF77S0Q05N.cambridge.arm.com>
 <20240228162647.GA4086865-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

On Wed, 28 Feb 2024 10:26:47 -0600
Rob Herring <robh@kernel.org> wrote:

...
> > > 
> > > Yes, that version unflattened the bootloader passed DT. Now within
> > > unflatten_devicetree(), the bootloader DT is ignored if ACPI is
> > > enabled and we unflatten an empty tree. That will prevent the kernel
> > > getting 2 h/w descriptions if/when a platform does such a thing. Also,
> > > kexec still uses the bootloader provided DT as before.  
> > 
> > That avoids the main instance of my concern, and means that this'll boot
> > without issue, but IIUC this opens the door to dynamically instantiating DT
> > devices atop an ACPI base system, which I think in general is something that's
> > liable to cause more problems than it solves.
> > 
> > I understand that's desireable for the selftests, though I still don't believe
> > it's strictly necessary -- there are plenty of other things that only work if
> > the kernel is booted in a specific configuration.  
> 
> Why add to the test matrix if we don't have to?
> 
> > Putting the selftests aside, why do we need to do this? Is there any other
> > reason to enable this?  
> 
> See my Plumbers talk...
> 
> Or in short, there's 3 main usecases:
> 
> - PCI FPGA card with devices instantiated in it 
> - SoCs which expose their peripherals via a PCI endpoint.
> - Injecting test devices with QEMU (testing, but not what this series 
>   does. Jonathan Cameron's usecase)
> 
> In all cases, drivers already exist for the devices, and they often only 
> support DT. DT overlays is the natural solution for this, and there's 
> now kernel support for it (dynamically generating PCI DT nodes when they 
> don't exist). The intent is to do the same thing on ACPI systems.
> 
> I don't see another solution other than 'go away, you're crazy'. There's 
> ACPI overlays, but that's only a debug feature. Also, that would 
> encourage more of the DT bindings in ACPI which I find worse than this 
> mixture. There's swnodes, but that's just board files and platform_data 
> 2.0.
> 
> I share the concerns with mixing, but I don't see a better solution. The 
> scope of what's possible is contained enough to avoid issues.
> 

I tested on a x86 system.
My use case is 'SoCs which expose their peripherals via a PCI endpoint'
described by Rob.
Indeed, I have a Microchip Lan9662 board (the one mentioned by Rob in his
Plumbers talk) and the root DT node creation is obviously needed.

I have previously used Frank Rowan's patches [1] that did this DT root node
creation. This series perfectly replace them and the root DT node is successfully
created.

Tested-by: Herve Codina <herve.codina@bootlin.com>

[1]: https://lore.kernel.org/all/20230317053415.2254616-1-frowand.list@gmail.com/

Best regards,
Hervé Codina
-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

