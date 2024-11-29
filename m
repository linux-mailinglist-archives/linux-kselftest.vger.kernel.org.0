Return-Path: <linux-kselftest+bounces-22621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683ED9DE80B
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 14:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD2FB20BCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D97319F430;
	Fri, 29 Nov 2024 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rF25SOae"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CCC19F128;
	Fri, 29 Nov 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732888292; cv=none; b=c71VYiFCNmbTpHYHU66ZRMZUc09Wa9ICNNawAswTnB0KnLv2VYskocT1HaV55TewaVnqdLDe/NHg/FML8Lof6toDPhY+36yCiQug7N/2dWDHHyJyR9A2ioeuL5vGiiaoMQ4dIOjlwmI6XwBu6dnSP51zTdwNy0e8QbbSR2K6J6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732888292; c=relaxed/simple;
	bh=deRs1hGG1PSs4SEPBRCBgk0scOn/My5DCIijGShN4gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCJJKOx5K5Y2NSol/7TF79e7AwD8krhNTAHLQoPY/lmcOkhWiyk2W6dByvJNJzIFMdSfd9SIkUpVtbF5gD4Zhv1jjZhHZr64llB9VSJvikuKu/VqstoRcHqr7jsXAdozVj0d+BMoV6ND1x45g4mn7HmoLlkzL+EM5jw8nEKbF/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rF25SOae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B935EC4CED2;
	Fri, 29 Nov 2024 13:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732888291;
	bh=deRs1hGG1PSs4SEPBRCBgk0scOn/My5DCIijGShN4gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rF25SOaeNaT4zEs5vVRievv9ZSpIQNcUYbhfGsqmXNXCVaEPsgA97B3+7kPggmBHz
	 Cylu/N6nRe5oekpMqzJzQlklJ02puBRPDBuqhGWSrGKHO/4V56+IIurdjsxkiRnrOk
	 Uoy6P2/zxJR1a43Q0WPOzllZaE4FripkGV7/1uSk2b3LSpzyt83IYnJTwv81I5eDnB
	 KTpMnRGroPS8Qm2T27zBi3wuV1i7sGwagwhOYWP5i00XJDiK1p/s/XGW8EIAt9sJEM
	 PCZRwqA43jSP/SO6eutNECYUGZKeHziXxY/E9M/x3stxPblr4C3ceBlqcp55eeBOsQ
	 714s4LRhUEfzg==
Date: Fri, 29 Nov 2024 14:51:26 +0100
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
Message-ID: <Z0nG3oAx66plv4qI@ryzen>
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
 <20241129092415.29437-5-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129092415.29437-5-manivannan.sadhasivam@linaro.org>

Hello Mani,

On Fri, Nov 29, 2024 at 02:54:15PM +0530, Manivannan Sadhasivam wrote:
> Migrate the PCI endpoint test to Kselftest framework. All the tests that
> were part of the previous pcitest.sh file were migrated.
> 
> Below is the exclusive list of tests:
> 
> 1. BAR Tests (BAR0 to BAR5)
> 2. Legacy IRQ Tests
> 3. MSI Interrupt Tests (MSI1 to MSI32)
> 4. MSI-X Interrupt Tests (MSI-X1 to MSI-X2048)
> 5. Read Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> 6. Write Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> 7. Copy Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> 8. Read Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> 9. Write Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> 10. Copy Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)

I'm not sure if it is a great idea to add test case number 10.

While it will work if you use the "dummy memcpy" DMA channel which uses
MMIO under the hood, if you actually enable a real DMA controller (which
often sets the DMA_PRIVATE cap in the DMA controller driver (e.g. if you
are using a DWC based PCIe EP controller and select CONFIG_DW_EDMA=y)),
pci_epf_test_copy() will fail with:
[   93.779444] pci_epf_test pci_epf_test.0: Cannot transfer data using DMA

See:
https://github.com/torvalds/linux/blob/v6.12/drivers/pci/endpoint/functions/pci-epf-test.c#L363-L368


Kind regards,
Niklas

