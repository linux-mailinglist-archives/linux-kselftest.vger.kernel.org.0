Return-Path: <linux-kselftest+bounces-24639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AA7A137EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 11:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB87166DD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 10:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8771DDA17;
	Thu, 16 Jan 2025 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8s3vsPv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697DB1D7E4F;
	Thu, 16 Jan 2025 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023456; cv=none; b=Rc87et5+bX0Vz1mTfu4xKeCAnB8p0ueKGwD4p034737DajypruCs8bYaeJxt+/O9A30fg3SfqLrs/Hj1dMe84PnX0scFfqTrEqhm0PdEYG08dJ8/ioWLLzFdKnBmgRytbA2mrQOrNKURip5GEpJhMBiolSOc9gbauPBir75LZL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023456; c=relaxed/simple;
	bh=wlfP20++AfjWBWU6+BjcTU8VdaNrbUKD+zKb/eJeY+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3hxX87TlHKc8AQVHv9KSadQvLayeMWHidKi3CSNzAyyPQkDQe41w/w3Z/PAmCkkdw5ZHtcoL1q9WL9lttDWIy0zTc8Vzn6lnZDt8v543Q29OdjYbgiHPLJI1lEflX10xHEY17dxx7n1AX/XZkukOe505Tl14AH2ARLIFBhPt38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8s3vsPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E09C4CED6;
	Thu, 16 Jan 2025 10:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737023456;
	bh=wlfP20++AfjWBWU6+BjcTU8VdaNrbUKD+zKb/eJeY+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8s3vsPv3bTOW64kFyd85LWHYsm/bbinKNwqixy1CuOEIRPW7AbHbFV2UtlEn+QEN
	 jfiUgQCR/+/TOWK8z2PaionDMPUlO/TL4v06YCw/gkjgOA/Rqhy3ZZG+1VmrPmb86f
	 bTYRHIJihtOfmdmjYSrYwg8fCEx+PJ3Wmw/1DIIUk4k9J9DQrTocnXp0a5oYguEZVh
	 R1UuasJmEYcRxo6rxKDZ7n2dC0j/RmrFSRRuMUG5+jhYtHMnKonLyBCZl77IJ2vfyz
	 7ONcgSccq2JfzGPyygPwhSyizvfkyBrD8eooX62G8V7NNCkgqZ/4WvLyUb2WVTupvx
	 DfeElf3joPBUw==
Date: Thu, 16 Jan 2025 11:30:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, kw@linux.com, gregkh@linuxfoundation.org,
	arnd@arndb.de, lpieralisi@kernel.org, shuah@kernel.org,
	kishon@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Aman Gupta <aman1.gupta@samsung.com>,
	Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: Re: [PATCH v4 3/3] selftests: pci_endpoint: Migrate to Kselftest
 framework
Message-ID: <Z4jf2s5SaUu3wdJi@ryzen>
References: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
 <20241231131341.39292-4-manivannan.sadhasivam@linaro.org>
 <Z3QtEihbiKIGogWA@ryzen>
 <20241231191812.ymyss2dh7naz4oda@thinkpad>
 <2C16240A-28F8-4D9B-9FD7-33E4E6F0879E@kernel.org>
 <20250102070404.aempesitsqktfnle@thinkpad>
 <Z3ahUuSjRv66L_g9@ryzen>
 <20250116044725.ooskvqlh2lpdr2xx@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116044725.ooskvqlh2lpdr2xx@thinkpad>

On Thu, Jan 16, 2025 at 10:17:25AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jan 02, 2025 at 03:23:14PM +0100, Niklas Cassel wrote:
> > Hello Mani, Vinod,
> > 
> > On Thu, Jan 02, 2025 at 12:34:04PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Dec 31, 2024 at 08:33:57PM +0100, Niklas Cassel wrote:
> > > > 
> > > > I have some patches that adds DMA_MEMCPY to dw-edma, but I'm not sure if the DWC eDMA hardware supports having both src and dst as PCI addresses, or if only one of them can be a PCI address (with the other one being a local address).
> > > > 
> > > > If only one of them can be a PCI address, then I'm not sure if your suggested patch is correct.
> > > > 
> > > 
> > > I don't see why that would be an issue. DMA_MEMCPY is independent of PCI/local
> > > addresses. If a dmaengine driver support doing MEMCPY, then the dma cap should
> > > be sufficient. As you said, if a controller supports both SLAVE and MEMCPY, the
> > > test currently errors out, which is wrong.
> > 
> > While I am okay with your suggested change to pci-epf-test.c:
> > > >-               if (epf_test->dma_private) {
> > > >+               if (!dma_has_cap(DMA_MEMCPY, epf_test->dma_chan_tx->device->cap_mask)) {
> > 
> > Since this will ensure that a DMA driver implementing DMA_MEMCPY,
> > which cannot be shared (has DMA_PRIVATE set), will not error out.
> > 
> > 
> > What I'm trying to explain is that in:
> > https://lore.kernel.org/linux-pci/Z2BW4CjdE1p50AhC@vaman/
> > https://lore.kernel.org/linux-pci/20241217090129.6dodrgi4tn7l3cod@thinkpad/
> > 
> > Vinod (any you) suggested that we should add support for prep_memcpy()
> > (which implies also setting cap DMA_MEMCPY) in the dw-edma DMA driver.
> > 
> > However, from section "6.3 Using the DMA" in the DWC databook,
> > the DWC eDMA hardware only supports:
> > - Transfer (copy) of a block of data from local memory to remote memory.
> > - Transfer (copy) of a block of data from remote memory to local memory.
> > 
> > 
> > Currently, we have:
> > https://github.com/torvalds/linux/blob/v6.13-rc5/include/linux/dmaengine.h#L843-L844
> > https://github.com/torvalds/linux/blob/v6.13-rc5/drivers/dma/dw-edma/dw-edma-core.c#L215-L231
> > 
> > Where we can expose per-channel capabilities, so we set MEM_TO_DEV/DEV_TO_MEM
> > per channel, however, these are returned in a struct dma_slave_caps *caps,
> > so this is AFAICT only for DMA_SLAVE, not for DMA_MEMCPY.
> > 
> > Looking at:
> > https://github.com/torvalds/linux/blob/v6.13-rc5/include/linux/dmaengine.h#L975-L979
> > it seems that DMA_MEMCPY is always assumed to be MEM_TO_MEM.
> > 
> > To me, it seems that we would either need a new dma_transaction_type (e.g. DMA_COPY)
> > where we can set dir:
> > MEM_TO_DEV, DEV_TO_MEM, or DEV_TO_DEV. (dw-edma would not support DEV_TO_DEV.)
> > 
> > Or, if we should stick with DMA_MEMCPY, we would need another way of telling
> > client drivers that only src or dst can be a remote address.
> > 
> > Until this is solved, I think I will stop my work on adding DMA_MEMCPY to the
> > dw-edma driver.
> > 
> 
> I think your concern is regarding setting the DMA transfer direction for MEMCPY,
> right? And you are saying that even if we use tx/rx channels, currently we
> cannot set DEV_TO_DEV like directions?
> 
> But I'm somewhat confused about what is blocking you from adding MEMCPY support
> to the dw-edma driver since that driver cannot support DEV_TO_DEV. In your WIP
> driver, you were setting the direction based on the channel. Isn't that
> sufficient enough?

What I did in the WIP driver patches was to set the direction to either
DEV_TO_MEM, or MEM_TO_DEV.

But that is wrong, since the prep_memcpy() API doesn't take a direction.

In fact, it appears that memcpy is always assumed to be MEM_TO_MEM:
https://github.com/torvalds/linux/blob/v6.13-rc7/include/linux/dmaengine.h#L74


E.g. the dw-edma driver cannot have both src address and dst address as a
local address (MEM_TO_MEM), so using DMA_MEMCPY API feels totally wrong.

Either dst or src has to be a local address (MEM), and the one that isn't
a local address has to be a PCI address (DEV). Sure, calling a PCI address
DEV might not be 100% correct, but I cannot think of a better way...

We also cannot treat a PCI address as MEM, as dw-edma cannot do PCI to PCI
transfers.

I think the best way forward would be to create a new _prep_slave_memcpy()
or similar, that does take a direction, and thus does not require
dmaengine_slave_config() to be called before every _prep_slave_memcpy() call,
since that is basically what is not allowing us to have multiple transactions
outstanding in parallel.


Kind regards,
Niklas

