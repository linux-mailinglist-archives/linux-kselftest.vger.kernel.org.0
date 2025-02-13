Return-Path: <linux-kselftest+bounces-26550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 499EAA340C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 14:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A7F7A30AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098B24BC03;
	Thu, 13 Feb 2025 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npEbHu3t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285FA24BBE0;
	Thu, 13 Feb 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454487; cv=none; b=ndq4BG9MBYVNRWZlQKoMM35UNDSl0mQ3D0Wgu/ih4GH8mH7zE5EQIN5jo1Y3PRvsV+6XyA+QZRI1dFd83O4HNkRP8v9ZK6PmcJ1j+iTFIJFa71zbAywgR3pfQdaCP+ThtJFhmlrrYGUQTpnQBoalHkvYiBTwJsHXbCyYFOkg51Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454487; c=relaxed/simple;
	bh=867wMZfyYGgWQ1cuhrOhpL5F/n/DCChjt3xV3kORdUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q53jkstnf7Zp7WUWLz3WTIJ6SfuWRJAcotX/M7mrMt7tkfHtWF97bFFXGJcT0xkOreLBMJD1fcKxNZ5hRsCmMBm3nBNtqAMsiCtvYzmEkm3646B+Mx7+38of1X/pFLPcLj/Ruw/9HcichBQAM8NLupmYgxstv8WbxLHCf3WPAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npEbHu3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320E3C4CED1;
	Thu, 13 Feb 2025 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739454486;
	bh=867wMZfyYGgWQ1cuhrOhpL5F/n/DCChjt3xV3kORdUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npEbHu3tCW3MnPGceBw1oXid2Xn2XTZ+TduSosdzDsmlYjKEqH3YrcqP0F7bJQ3Ox
	 6GDAmBsbwf1R6YFOOM2JCDNDpcVCoL1eFe7WpDcCQSap7awNGzgJ7+0aLUcjyDccce
	 xmb3K9A31AnVwR4U4aX+tSXkU3hyHUnxhwFZ8enhxmz56ttX4hm5KnVU1QT+VjZiyb
	 3RyRprhJfYMHRt8JjYSuhLXWS1vRWozkq2RYeFKMe2eMUoNz5uVIEbKE8//+gmGW0/
	 kkgJL+C8fb3QEKpNdJrqIt8OZCERf9rXE2kxVpn1kMDeopKtMe4OuFR9Wpas2CpWgV
	 G11PpEsvO7FAw==
Date: Thu, 13 Feb 2025 14:48:02 +0100
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com, kw@linux.com
Cc: linux-pci@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH 1/2] misc: pci_endpoint_test: Give disabled BARs a
 distinct error code
Message-ID: <Z634EqRu3LhKoF7F@ryzen>
References: <20250123120147.3603409-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123120147.3603409-3-cassel@kernel.org>

On Thu, Jan 23, 2025 at 01:01:48PM +0100, Niklas Cassel wrote:
> The current code returns -ENOMEM if test->bar[barno] is NULL.
> 
> There can be two reasons why test->bar[barno] is NULL:
> 1) The pci_ioremap_bar() call in pci_endpoint_test_probe() failed.
> 2) The BAR was skipped, because it is disabled by the endpoint.
> 
> Many PCI endpoint controller drivers will disable all BARs in their
> init function. A disabled BAR will have a size of 0.
> 
> A PCI endpoint function driver will be able to enable any BAR that
> is not marked as BAR_RESERVED (which means that the BAR should not
> be touched by the EPF driver).
> 
> Thus, perform check if the size is 0, before checking if
> test->bar[barno] is NULL, such that we can return different errors.
> 
> This will allow the selftests to return SKIP instead of FAIL for
> disabled BARs.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Hello PCI maintainers.
> This patch might give a trivial conflict with:
> https://lore.kernel.org/linux-pci/20250123095906.3578241-2-cassel@kernel.org/T/#u
> because the context lines (lines that haven't been changed)
> might be different. If there is a conflict, simply look at
> this patch by itself, and resolution should be trivial.
> 
>  drivers/misc/pci_endpoint_test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d5ac71a49386..b95980b29eb9 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -292,11 +292,13 @@ static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
>  
> +	bar_size = pci_resource_len(pdev, barno);
> +	if (!bar_size)
> +		return -ENODATA;
> +
>  	if (!test->bar[barno])
>  		return -ENOMEM;
>  
> -	bar_size = pci_resource_len(pdev, barno);
> -
>  	if (barno == test->test_reg_bar)
>  		bar_size = 0x4;
>  
> -- 
> 2.48.1
> 

Gentle ping on this series.


Kind regards,
Niklas

