Return-Path: <linux-kselftest+bounces-42153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A97B96CB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 18:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0694A441B24
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1284B32129C;
	Tue, 23 Sep 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK2g3lz9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83131E0E4;
	Tue, 23 Sep 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644466; cv=none; b=hvZD4LFDL3P5ITKR0KO75nDKfCSDrBrRrEhWxJPqm1axNPpnu2p6CaWmN3L9K4VIbXLGMK5Ah5kGbxhPQXZUb3zjVPFdmCLW4BLAdxMzzDlpiDH7cew2HbqL5OErEnKQmsNmOnD0wu2HEs13w23Q4MeYxo3103W+1uj499FLwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644466; c=relaxed/simple;
	bh=qXVz/hDVPsuZNQA18ppIjdhpvEqnsfHeZE0v2amdRuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfPyLJ6db76iX/CkAwYNQY3ci5rzlvz4bQfmlosohHh4CeGqbXGOak52LBJdGAk2WVa0M3tLztJaVfVA6yOI8k6VFq/xEZgqwuNS43qRy4WdEF1jwK5cpqZfLfWuNO3i5TNN7yg1p8IvG+Ip70TQzZSaLWWPXBcOSToEhauzLOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK2g3lz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9B7C4CEF5;
	Tue, 23 Sep 2025 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758644465;
	bh=qXVz/hDVPsuZNQA18ppIjdhpvEqnsfHeZE0v2amdRuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VK2g3lz9szCECiQtGmt2X/Zi+uw6ZAgz8SmH6kPHKDyIVnmJOTI2XRa49z4z4BAI3
	 H6v6QR2EoLEU0O6RqvzjhdUyGlXsvKjBXaYSotr6EFTSEcJwM2vrt8ymdgyA1sSufx
	 LiXz0qKEgVBoNKR6YOYzky7sUe3LrcWGit4t6bOKGWVsdOM7COl2qdatHm6IRd5Azn
	 4iGmR4y+wimk3HNOsdyC5q/WcfWtd56jwzk+PGefLZuQFZTOyyUf8x341vzzAMtioB
	 vrgpmNS4I7U+5DyKMTPXtFZxMRdNuJs9EJLkTdwUFGP2JWOLr14rRW36xoKwmcrytv
	 vM0HMkfQptj4w==
Date: Tue, 23 Sep 2025 21:50:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Brian Norris <briannorris@chromium.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>, Sami Tolvanen <samitolvanen@google.com>, 
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in
 modules
Message-ID: <sb6o4y5ymss3ko73ruwsdgr2dnv2etbg6zq5muaw2vyhlm52bc@zl4uswmomakz>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <aMgZJgU7p57KC0DL@infradead.org>
 <aMhd4REssOE-AlYw@google.com>
 <aNGR0x185VGHxSde@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNGR0x185VGHxSde@infradead.org>

On Mon, Sep 22, 2025 at 11:13:39AM -0700, Christoph Hellwig wrote:
> On Mon, Sep 15, 2025 at 11:41:37AM -0700, Brian Norris wrote:
> > I see fixups in controller drivers here:
> > 
> > drivers/pci/controller/dwc/pci-imx6.c
> > drivers/pci/controller/dwc/pci-keystone.c
> > drivers/pci/controller/dwc/pcie-qcom.c
> > drivers/pci/controller/pci-loongson.c
> > drivers/pci/controller/pci-tegra.c
> > drivers/pci/controller/pcie-iproc-bcma.c
> > drivers/pci/controller/pcie-iproc.c
> > 
> > Are any of those somehow wrong?
> 
> When did we allow modular
> controller drivers anyway?  That feels like a somewhat bad idea, too.
> 

Why not? We currently only restrict the controller drivers implementing the
irqchip controller from being *removed* because of the IRQ disposal concern.
Other than that, I don't see why kernel should restrict building them as
modules.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

