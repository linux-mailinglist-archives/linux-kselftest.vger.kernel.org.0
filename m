Return-Path: <linux-kselftest+bounces-23822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB09FFA75
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 15:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58490160B4D
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019AA374CB;
	Thu,  2 Jan 2025 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJTdpopN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB63AAD51;
	Thu,  2 Jan 2025 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827800; cv=none; b=XLcW3LeHh2psG9NVeaiyhBOTWn6NDe1rPnSkSOF7MMWhwkhGC8C+yvKA/b4EK53jlLqAD9DBeexNiIcjZXVKKvw9kAfRmSbdaUHU3N6gjEYhj43x0nK9ebuu1BgRoUQhYEj3YJewtpEa/saeZqme3F44HDasxZ8/O/f03xZwstA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827800; c=relaxed/simple;
	bh=WBASArHNWuzDRkBlzLrre+5pUpttJP04ha3ml0jtfCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2IYBj9EurKjW8fPPOenwbuaDqR1T4IDFMp87DGDYusi9upM/tj4ycNRtz+tEkv59vmJUS8z5bs3LBsTFp80BtzixZMwk9nx/a46wM0G1BAID8/2pLK5QPNXzZ00P2eM3Y+qXbtX+QjwdIHG03yI9JlqG0al2MpkvirbytFm6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJTdpopN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0884CC4CED0;
	Thu,  2 Jan 2025 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735827800;
	bh=WBASArHNWuzDRkBlzLrre+5pUpttJP04ha3ml0jtfCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJTdpopNJ8Vj/ZLQ+tn7e1QU4O0Wl0nN6iLW8fcuhsETsiToAynXzvl01EdD3PM4M
	 zUvWDEgp0z8fKFKBYtIL2XqB3GxlLhI3kZpmWvpXV7ONrsEOE8nfdEa003xw97t5QX
	 jJEW+U/CfV4q8re1wf+223LksgBfYgj6WUZ86ACCp08KpZEU8Vx1wIk0cKUzmBxpMR
	 BSwFtQMo00zb1XPCKkUWaH4k9nKxS5PT+81SXVgPXahXc40jHlbZFgqo/rn4wlurGr
	 SklXJ73W/VNXkOluc9BirsLEIDaqDRg9u5AJF46rZJxph5QOPDRvx8bDyBjX+3KO7D
	 Gjg1R5XKD2deA==
Date: Thu, 2 Jan 2025 15:23:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Aman Gupta <aman1.gupta@samsung.com>,
	Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: Re: [PATCH v4 3/3] selftests: pci_endpoint: Migrate to Kselftest
 framework
Message-ID: <Z3ahUuSjRv66L_g9@ryzen>
References: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
 <20241231131341.39292-4-manivannan.sadhasivam@linaro.org>
 <Z3QtEihbiKIGogWA@ryzen>
 <20241231191812.ymyss2dh7naz4oda@thinkpad>
 <2C16240A-28F8-4D9B-9FD7-33E4E6F0879E@kernel.org>
 <20250102070404.aempesitsqktfnle@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102070404.aempesitsqktfnle@thinkpad>

Hello Mani, Vinod,

On Thu, Jan 02, 2025 at 12:34:04PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Dec 31, 2024 at 08:33:57PM +0100, Niklas Cassel wrote:
> > 
> > I have some patches that adds DMA_MEMCPY to dw-edma, but I'm not sure if the DWC eDMA hardware supports having both src and dst as PCI addresses, or if only one of them can be a PCI address (with the other one being a local address).
> > 
> > If only one of them can be a PCI address, then I'm not sure if your suggested patch is correct.
> > 
> 
> I don't see why that would be an issue. DMA_MEMCPY is independent of PCI/local
> addresses. If a dmaengine driver support doing MEMCPY, then the dma cap should
> be sufficient. As you said, if a controller supports both SLAVE and MEMCPY, the
> test currently errors out, which is wrong.

While I am okay with your suggested change to pci-epf-test.c:
> >-               if (epf_test->dma_private) {
> >+               if (!dma_has_cap(DMA_MEMCPY, epf_test->dma_chan_tx->device->cap_mask)) {

Since this will ensure that a DMA driver implementing DMA_MEMCPY,
which cannot be shared (has DMA_PRIVATE set), will not error out.


What I'm trying to explain is that in:
https://lore.kernel.org/linux-pci/Z2BW4CjdE1p50AhC@vaman/
https://lore.kernel.org/linux-pci/20241217090129.6dodrgi4tn7l3cod@thinkpad/

Vinod (any you) suggested that we should add support for prep_memcpy()
(which implies also setting cap DMA_MEMCPY) in the dw-edma DMA driver.

However, from section "6.3 Using the DMA" in the DWC databook,
the DWC eDMA hardware only supports:
- Transfer (copy) of a block of data from local memory to remote memory.
- Transfer (copy) of a block of data from remote memory to local memory.


Currently, we have:
https://github.com/torvalds/linux/blob/v6.13-rc5/include/linux/dmaengine.h#L843-L844
https://github.com/torvalds/linux/blob/v6.13-rc5/drivers/dma/dw-edma/dw-edma-core.c#L215-L231

Where we can expose per-channel capabilities, so we set MEM_TO_DEV/DEV_TO_MEM
per channel, however, these are returned in a struct dma_slave_caps *caps,
so this is AFAICT only for DMA_SLAVE, not for DMA_MEMCPY.

Looking at:
https://github.com/torvalds/linux/blob/v6.13-rc5/include/linux/dmaengine.h#L975-L979
it seems that DMA_MEMCPY is always assumed to be MEM_TO_MEM.

To me, it seems that we would either need a new dma_transaction_type (e.g. DMA_COPY)
where we can set dir:
MEM_TO_DEV, DEV_TO_MEM, or DEV_TO_DEV. (dw-edma would not support DEV_TO_DEV.)

Or, if we should stick with DMA_MEMCPY, we would need another way of telling
client drivers that only src or dst can be a remote address.

Until this is solved, I think I will stop my work on adding DMA_MEMCPY to the
dw-edma driver.


Kind regards,
Niklas

