Return-Path: <linux-kselftest+bounces-22629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BD99DEB3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 17:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4A0B23140
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E58B14F9F9;
	Fri, 29 Nov 2024 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eayyeRzy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8314831E;
	Fri, 29 Nov 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898553; cv=none; b=MmM9zT5MH7VGnxMflIr6uDSmipN57dhvB7xjRzLJw94ennH9V5SfKv2UtbiXMp96sN7DBekMmZzy6MTCbwbn3Sv8yde1gQ0K+Ia3QqnKblM9cSa2zQZzw5/mpLawv+SeL0RDFgiWUuT1IuXYwZ1k547w6DXYVixd2sJ2aYBsQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898553; c=relaxed/simple;
	bh=xxNabAbcgstwbL0tRWMiMIovBUW3hgX7zwFwHTaklUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmtPb4xiwRr2CAPAe8TJCFuqT7yIPs3LA+alAaCmVxFdLr4WZDeVxZLpxt9I2k/nWNzPpxgcWRoykV7Dj8OrgtlCw3R9noECz27mDCZtpbEFpy1rvM3WWMOSIyXY9uhClPt15k6sSI9tzBdqrh59ekqIEEgiaNlcFNiO9ekZgQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eayyeRzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D45C4CECF;
	Fri, 29 Nov 2024 16:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732898552;
	bh=xxNabAbcgstwbL0tRWMiMIovBUW3hgX7zwFwHTaklUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eayyeRzyzjsYKhiT/ZaTOiWqduOcECBuDLrNr3MX4bigGlI3pj6oKhyf/16jWE9ZG
	 K/ZCeEAyhrwkS+aoT996LrCe2abYYrvb6CpZeccYfvP8mik3ipPzyzMV5aQhzPlfdj
	 whko+5f2IHsz/Hiz4sIbzSZddcmd7fZJHPF6AVthpXQXODbQjfpkESuJavs62HVZsM
	 2TwI4XD4sf2PdKWy2KMkOp5hhVgG9KNm80NoCUjczwIX5/PqrPw1MntzYuXb0wC35U
	 YU/wj/NX5FMY5t/MWRTK736fo6dGYZW3BT3RvWj1cQJg2gdIvcl8zxQusFDhBQJ9PZ
	 qqm+MfRY+VN+A==
Date: Fri, 29 Nov 2024 17:42:26 +0100
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
Message-ID: <Z0nu8n5GEuZ0zaBD@ryzen>
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
 <20241129092415.29437-5-manivannan.sadhasivam@linaro.org>
 <Z0nG3oAx66plv4qI@ryzen>
 <20241129163555.apf35xa6x5joscha@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129163555.apf35xa6x5joscha@thinkpad>

On Fri, Nov 29, 2024 at 10:05:55PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 29, 2024 at 02:51:26PM +0100, Niklas Cassel wrote:
> > Hello Mani,
> > 
> > On Fri, Nov 29, 2024 at 02:54:15PM +0530, Manivannan Sadhasivam wrote:
> > > Migrate the PCI endpoint test to Kselftest framework. All the tests that
> > > were part of the previous pcitest.sh file were migrated.
> > > 
> > > Below is the exclusive list of tests:
> > > 
> > > 1. BAR Tests (BAR0 to BAR5)
> > > 2. Legacy IRQ Tests
> > > 3. MSI Interrupt Tests (MSI1 to MSI32)
> > > 4. MSI-X Interrupt Tests (MSI-X1 to MSI-X2048)
> > > 5. Read Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > 6. Write Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > 7. Copy Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > 8. Read Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > 9. Write Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > 10. Copy Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > 
> > I'm not sure if it is a great idea to add test case number 10.
> > 
> > While it will work if you use the "dummy memcpy" DMA channel which uses
> > MMIO under the hood, if you actually enable a real DMA controller (which
> > often sets the DMA_PRIVATE cap in the DMA controller driver (e.g. if you
> > are using a DWC based PCIe EP controller and select CONFIG_DW_EDMA=y)),
> > pci_epf_test_copy() will fail with:
> > [   93.779444] pci_epf_test pci_epf_test.0: Cannot transfer data using DMA
> > 
> 
> So the idea is to exercise all the options provided by the epf-test driver. In
> that sense, we need to have the DMA COPY test. However, I do agree that the
> common DMA controllers will fail this case. So how about just simulating the DMA
> COPY for controllers implementing DMA_PRIVATE cap? I don't think it hurts to
> have this feature in test driver.

I guess you could modify pci-epf-test to simply do MMIO in test_copy(),
if USE_DMA && DMA_PRIVATE is set, as you suggest.

We should probably print a warning/info that we are falling back to MMIO
in that case though.


Kind regards,
Niklas

