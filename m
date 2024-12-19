Return-Path: <linux-kselftest+bounces-23588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE209F7D31
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0DD167672
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB80222589;
	Thu, 19 Dec 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSRTFOk0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99C78F47;
	Thu, 19 Dec 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618687; cv=none; b=e2jabraB3hsxHpGOhogdD9pPmnYiHbVVIFfZ8qflKfLYLuBZykQcx4ThkwjaZp5drCvS04IcuffBawhd6+sHKRMWHxE67ewk/43ZGsgl8JT++P0Mbf1ZnC1G6Uzz4kzPbSJs9Yv+tLz28GS/XEisVI9uyNFmHEC6iAhtSjflmYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618687; c=relaxed/simple;
	bh=AQNB3IZcwD9rOfdfKyc5+rPRa42g1Y9eH/XQhTMkGso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1LzBqvYVyk3Gyo8GxVhfdWsYAcUveO+ZW5rQjuFgN/QZD9xoLKeXu6zLGrS1glLJqBBBjPPxQ8OICFBMPbpkQPmyAjd/cpBQLjxGh3x8JCALgI8Zva6L3zoxFitQfizZ6cvEPHtL9OlAdhs3AY3e2TZ2/vUqaJugoq9DzGnTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSRTFOk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF6FC4CECE;
	Thu, 19 Dec 2024 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734618686;
	bh=AQNB3IZcwD9rOfdfKyc5+rPRa42g1Y9eH/XQhTMkGso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSRTFOk0xzWL3N2izqlKGZvIraDwiJJZhugV+eBaXXeB/xlQwTTnKy7SlllkYzIr/
	 NTd/c4i/7CKKEQeq6UEZBr8XBLYNAawCLsH+aI0dQ0PYmdh4XRBJZAy6XLV6g7sRne
	 PUdHoXt2M1kOfRxI9/IfH9zOIBBUFyLJxY58eUa1prXuwUsTtCmXmnlqmy5d+38hRk
	 p3lUpbSf0TJ2XT7aSWHsmUHng14OIKfJmcartStdpAqS4aV7n9OmD2/TDPQE22o7xE
	 6/WiUbw6MCS6oocMqbVGOjPY0+ssjmdaSF0/R7WjhAPLAo1pnV1d7XFHslJrfQu19Y
	 Ahh0/e21RC1Bg==
Date: Thu, 19 Dec 2024 15:31:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	gregkh@linuxfoundation.org, arnd@arndb.de, lpieralisi@kernel.org,
	shuah@kernel.org, kishon@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Message-ID: <Z2QuORW5kXSrc1AX@ryzen>
References: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
 <20241219000112.GE1444967@rocinante>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241219000112.GE1444967@rocinante>

On Thu, Dec 19, 2024 at 09:01:12AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > This series carries forward the effort to add Kselftest for PCI Endpoint
> > Subsystem started by Aman Gupta [1] a while ago. I reworked the initial version
> > based on another patch that fixes the return values of IOCTLs in
> > pci_endpoint_test driver and did many cleanups. Since the resulting work
> > modified the initial version substantially, I took over the authorship.
> > 
> > This series also incorporates the review comment by Shuah Khan [2] to move the
> > existing tests from 'tools/pci' to 'tools/testing/kselftest/pci_endpoint' before
> > migrating to Kselftest framework. I made sure that the tests are executable in
> > each commit and updated documentation accordingly.
> > 
> > NOTE: Patch 1 is strictly not related to this series, but necessary to execute
> > Kselftests with Qualcomm Endpoint devices. So this can be merged separately.
> 
> Applied to selftests, thank you!
> 
> [01/04] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED
>         https://git.kernel.org/pci/pci/c/71ae1c3a342c
> 
> [02/04] misc: pci_endpoint_test: Fix the return value of IOCTL
>         https://git.kernel.org/pci/pci/c/7908208a2f6a
> 
> [03/04] selftests: Move PCI Endpoint tests from tools/pci to Kselftests
>         https://git.kernel.org/pci/pci/c/5c892b60e4c6
> 
> [04/04] selftests: pci_endpoint: Migrate to Kselftest framework
>         https://git.kernel.org/pci/pci/c/62f966e676b5
> 
> 	Krzysztof

I'm a bit surprised that this series was picked up,
since as you could see earlier in this same thread:
https://lore.kernel.org/linux-pci/20241219000112.GE1444967@rocinante/T/#m7bb0e624a4bf88f5cc13dc3804972c4fa9a79bcd

Mani suggested that my patch (which conflicts with this),
should be picked up first.

Is there a reason for the sudden chance of plans?

Please advice on how to proceed.


Kind regards,
Niklas

