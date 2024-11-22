Return-Path: <linux-kselftest+bounces-22461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8CD9D639A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 18:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DC2282755
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7731DF974;
	Fri, 22 Nov 2024 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3EUfFrz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3FF224CC;
	Fri, 22 Nov 2024 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298091; cv=none; b=g1MRJ83qbiP1VT+2sXHBu5DjvVkwJ/0PLSQ9cg/Kmq8Erb7yYgUlwhbXvFQQZc6ZXNVdk+3YCr8AVWuwwN/wojSlrYzO8vPzrWM35iB+WxiyPMCgZF1KvoFoxH0aLW0SMHtDRvYiUWtjVapory5Ecz4KkRm7KADrDk7stI2+uYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298091; c=relaxed/simple;
	bh=sP8GnPMMnf3sjQ7ceImITYA+fvSSpdmMigpOF5UCgrY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FFk7uHkBl/KhlGmCAaDpkwipO80IntMfirrFYuCOHF7Y+zb9l2Tomt4gzp9kQgUNo41K5hNKE5Xzbkfev41fqmJAlqsoXzHnH9bcqBOU75sL4yaK3owIu6odctD7dfjRO2XQOGPH6gtSas4hgCQ13svBHrPC+rukz0MTiItTFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3EUfFrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDDEC4CECE;
	Fri, 22 Nov 2024 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732298091;
	bh=sP8GnPMMnf3sjQ7ceImITYA+fvSSpdmMigpOF5UCgrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N3EUfFrzeDpzvD9ErDAIiuO4dbSRbtRl3q2wnf004bJLuwK9lMQsixxey2kwvIMZf
	 rEWI9C5EX+9guwLZKyhhovd/+1ymk37d34UoXHeFxoTe2tZuEAul1W7NiuYzqshxsm
	 eMdGeDNIrV8eFdw5Ez90f/B4zHySnRZryHGnP0GbHUpib/yhujEDaqGC1lsymy8rqH
	 QKjHUbIQzoBPce3Rx32XZuIeFPJwLRtgjor6sgSnMSfy3naciiEB6yOfX79RU4x+Fp
	 ZifpaDCt/0acv+vaexz0B0UiSVydDT/7PSZeL9++/8a3Uiqrrgk8nRxu06JhbTsw6p
	 ZldeUHH+buSvw==
Date: Fri, 22 Nov 2024 11:54:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joseph Jang <jjang@nvidia.com>
Cc: shuah@kernel.org, tglx@linutronix.de, mochs@nvidia.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH] selftest: drivers: Add support to check duplicate hwirq
Message-ID: <20241122175449.GA2433467@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dec53919-034b-4f0e-b415-1bc1de9b0916@nvidia.com>

On Mon, Nov 11, 2024 at 03:21:36PM +0800, Joseph Jang wrote:
> On 2024/10/19 3:34 AM, Bjorn Helgaas wrote:
> > On Tue, Sep 03, 2024 at 06:44:26PM -0700, Joseph Jang wrote:
> > > Validate there are no duplicate hwirq from the irq debug
> > > file system /sys/kernel/debug/irq/irqs/* per chip name.
> > > 
> > > One example log show 2 duplicated hwirq in the irq debug
> > > file system.
> > > 
> > > $ sudo cat /sys/kernel/debug/irq/irqs/163
> > > handler:  handle_fasteoi_irq
> > > device:   0019:00:00.0
> > >       <SNIP>
> > > node:     1
> > > affinity: 72-143
> > > effectiv: 76
> > > domain:  irqchip@0x0000100022040000-3
> > >   hwirq:   0xc8000000
> > >   chip:    ITS-MSI
> > >    flags:   0x20
> > > 
> > > $ sudo cat /sys/kernel/debug/irq/irqs/174
> > > handler:  handle_fasteoi_irq
> > > device:   0039:00:00.0
> > >      <SNIP>
> > > node:     3
> > > affinity: 216-287
> > > effectiv: 221
> > > domain:  irqchip@0x0000300022040000-3
> > >   hwirq:   0xc8000000
> > >   chip:    ITS-MSI
> > >    flags:   0x20
> > > 
> > > The irq-check.sh can help to collect hwirq and chip name from
> > > /sys/kernel/debug/irq/irqs/* and print error log when find duplicate
> > > hwirq per chip name.
> > > 
> > > Kernel patch ("PCI/MSI: Fix MSI hwirq truncation") [1] fix above issue.
> > > [1]: https://lore.kernel.org/all/20240115135649.708536-1-vidyas@nvidia.com/
> > 
> > I don't know enough about this issue to understand the details.  It
> > seems like you look for duplicate hwirqs in chips with the same name,
> > e.g., "ITS-MSI" in this case?  That name seems too generic to me
> > (might there be several instances of "ITS-MSI" in a system?)
> 
> As I know, each PCIe device typically has only one ITS-MSI controller.
> Having multiple ITS-MSI instances for the same device would lead to
> confusion and potential conflicts in interrupt routing.
> 
> > Also, the name may come from chip->irq_print_chip(), so it apparently
> > relies on irqchip drivers to make the names unique if there are
> > multiple instances?
> > 
> > I would have expected looking for duplicates inside something more
> > specific, like "irqchip@0x0000300022040000-3".  But again, I don't
> > know enough about the problem to speak confidently here.
> 
> In our case, If we look for duplicates by different irq domains like
> "irqchip@0x0000100022040000-3" and "irqchip@0x0000300022040000-3" as
> following example.
> 
>     $ sudo cat /sys/kernel/debug/irq/irqs/163
>     handler:  handle_fasteoi_irq
>     device:   0019:00:00.0
>          <SNIP>
>     node:     1
>     affinity: 72-143
>     effectiv: 76
>     domain:  irqchip@0x0000100022040000-3
>      hwirq:   0xc8000000
>      chip:    ITS-MSI
>       flags:   0x20
>     $ sudo cat /sys/kernel/debug/irq/irqs/174
>     handler:  handle_fasteoi_irq
>     device:   0039:00:00.0
>         <SNIP>
>     node:     3
>     affinity: 216-287
>     effectiv: 221
>     domain:  irqchip@0x0000300022040000-3
>      hwirq:   0xc8000000
>      chip:    ITS-MSI
>       flags:   0x20
> 
> We could not detect the duplicated hwirq number (0xc8000000) in this
> case.

Again, this is really out of my area, but based on
Documentation/core-api/irq/irq-domain.rst, I assumed the point of
hwirq was that hwirq numbers were local to an interrupt controller,
i.e., to an irq_domain.

If that's the case, it should not be a problem if hwirq number
0xc8000000 is used in two separate irq_domains.

Bjorn

