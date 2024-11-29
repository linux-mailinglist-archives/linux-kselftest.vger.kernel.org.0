Return-Path: <linux-kselftest+bounces-22633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28819DEB85
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 18:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619061636B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CA819ADA4;
	Fri, 29 Nov 2024 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUhopQuQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67151474A7;
	Fri, 29 Nov 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732900397; cv=none; b=WOjiOiGu4mWyBkRQHpfiXsPXoZVcsX1/Lb5+p18quHI/XirAcMy6UmWPPJn2aprfV99og0F/YgKTioxDzyaQ6WoJB1tSjynlzNNEI7SCPBf4wqifSDBzWyqwUH+EfvdtxdnF5kFdn1hqK+yfn7PHcRp3dZOQ/30XkAtLD9ngvcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732900397; c=relaxed/simple;
	bh=Vgr7lOkaswmLedMDgRZDhamnfpJagMy+vOT3spBC1xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzQje+jwdgCJm1vAdrLjxFt3WfDa0L1SKoVUtjemO15Lw9a8JTJ+rqcei43e8RLgLQgsSdGPGPDw0bQ0Qzy7mdlI0tN4G6RhCMLncvcBtPXOSGVtKTUutTInxztkfi202TsbDll8Wy93A/59DcndHwW7Cc2tu9mm6Bjdu4ivtQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUhopQuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ACAC4CECF;
	Fri, 29 Nov 2024 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732900397;
	bh=Vgr7lOkaswmLedMDgRZDhamnfpJagMy+vOT3spBC1xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUhopQuQX4r5wW8RtCykDvvqZL1u0CpBqAGvX+8rQVXCVKSDUwq/PMWMYUsPa4L5P
	 CQOQ93eeWX5IuW388PcEXe32TFNH1irNetfE0tuW8wWpsi5zIizaer7HtXd4YWYGYF
	 7xhwukANOF3JnaR+/wNvBluih1btCztOg/gT2mMiUmPgm4/LKh6hOBYUaU9u3XVtvj
	 EO1B0jkRGoEleVKAaGScc0fMLyr7fn/3inrD2HBDaXf+fdM5s0AnXFIAbsjVz8g7TO
	 u/nSi+GEECgbFUE5nE8JZDOLnonDtQqUR3K2MsnrCIUeM+/W+dYPg9J5RKvkngTX3P
	 GwKLADB5UvOBQ==
Date: Fri, 29 Nov 2024 18:13:12 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	aman1.gupta@samsung.com, p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests: pci_endpoint: Migrate to Kselftest
 framework
Message-ID: <Z0n2KIUVk2XqrH1p@ryzen>
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
 <20241129092415.29437-5-manivannan.sadhasivam@linaro.org>
 <Z0nG3oAx66plv4qI@ryzen>
 <20241129163555.apf35xa6x5joscha@thinkpad>
 <Z0nu8n5GEuZ0zaBD@ryzen>
 <20241129165256.dkzcbfdvmf2n4rxx@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129165256.dkzcbfdvmf2n4rxx@thinkpad>

On Fri, Nov 29, 2024 at 10:22:56PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 29, 2024 at 05:42:26PM +0100, Niklas Cassel wrote:
> > On Fri, Nov 29, 2024 at 10:05:55PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Nov 29, 2024 at 02:51:26PM +0100, Niklas Cassel wrote:
> > > > Hello Mani,
> > > > 
> > > > On Fri, Nov 29, 2024 at 02:54:15PM +0530, Manivannan Sadhasivam wrote:
> > > > > Migrate the PCI endpoint test to Kselftest framework. All the tests that
> > > > > were part of the previous pcitest.sh file were migrated.
> > > > > 
> > > > > Below is the exclusive list of tests:
> > > > > 
> > > > > 1. BAR Tests (BAR0 to BAR5)
> > > > > 2. Legacy IRQ Tests
> > > > > 3. MSI Interrupt Tests (MSI1 to MSI32)
> > > > > 4. MSI-X Interrupt Tests (MSI-X1 to MSI-X2048)
> > > > > 5. Read Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > > 6. Write Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > > 7. Copy Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > > 8. Read Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > > 9. Write Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > > 10. Copy Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > 
> > > > I'm not sure if it is a great idea to add test case number 10.
> > > > 
> > > > While it will work if you use the "dummy memcpy" DMA channel which uses
> > > > MMIO under the hood, if you actually enable a real DMA controller (which
> > > > often sets the DMA_PRIVATE cap in the DMA controller driver (e.g. if you
> > > > are using a DWC based PCIe EP controller and select CONFIG_DW_EDMA=y)),
> > > > pci_epf_test_copy() will fail with:
> > > > [   93.779444] pci_epf_test pci_epf_test.0: Cannot transfer data using DMA
> > > > 
> > > 
> > > So the idea is to exercise all the options provided by the epf-test driver. In
> > > that sense, we need to have the DMA COPY test. However, I do agree that the
> > > common DMA controllers will fail this case. So how about just simulating the DMA
> > > COPY for controllers implementing DMA_PRIVATE cap? I don't think it hurts to
> > > have this feature in test driver.
> > 
> > I guess you could modify pci-epf-test to simply do MMIO in test_copy(),
> > if USE_DMA && DMA_PRIVATE is set, as you suggest.
> > 
> 
> No not memcpy, but using the DMA to copy from src to local buf and then local
> buf to dst. This way, we do not need to fallback and at the same time simulate
> DMA COPY.

Sounds very slow :)

What would be the value to add such code to pci-epf-test?

Sounds like we would just add a lot of extra code in pci-epf-test.c that
would not test anything new. (It would basically just be the DMA read test
followed by the DMA write test. If those tests pass, this new simulated
test should be guaranteed to pass.)

Wouldn't it make more sense to simply do something like:

if (use_dma && dma_prive) {
	dev_warn(dev, "DEV_TO_DEV not supported with USE_DMA, falling back to MMIO\n");
	use_dma = 0;
}


Kind regards,
Niklas

