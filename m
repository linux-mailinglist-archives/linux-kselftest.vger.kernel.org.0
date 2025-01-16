Return-Path: <linux-kselftest+bounces-24655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05213A13D4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 16:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17081164763
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413431DE886;
	Thu, 16 Jan 2025 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNnXJU0M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB7817578;
	Thu, 16 Jan 2025 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040242; cv=none; b=jcFA3PbUL9scdOdmbbQ32kh+yyAbOyZYGbBiAgUj8uTJeudSxcxyvYyCgeDvGyl5wHZLhLAtcMU2TKDvPSN+M7quf23NNLz8t4MS4Irh9PHxnDXwMYsnibDDGhcbIXmaY131GcPIad+eycWs0chL/47KjUPO+8I27hgPaWsY+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040242; c=relaxed/simple;
	bh=j5GydOiByw82/v7rG0aVDenUFRHV9aFpzCVemAPHuOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNnJkUIORotEZHG5/YaFpxPt+i2YnSdvEUjsXIttta/g1Ce0w3Xej+ONmrZPG2CWyRKzl/X/8/mYSfq2+rmrYeXkrsJOk2lXsTwzrA6dtmoR+PYl1dhOZMOjgwZdQQUPD4N6eCnXHsY4b1t3ciP7Kq24ry9utzWi/IunQTvkFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNnXJU0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07085C4CEE1;
	Thu, 16 Jan 2025 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737040241;
	bh=j5GydOiByw82/v7rG0aVDenUFRHV9aFpzCVemAPHuOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNnXJU0MmlWxQpY+7XezWb6gikDC5udtX3yDpO3Lbu8uf4EMIuxHxGQ4UM151/Ce1
	 QkFrbGWhLEYEpiCSuHxMDwrD2cBrF0HvqpM97+V/eakBd95xwgz2x+kWaCrQjyvirU
	 1D1uUmLnV6HA63hqbJ5ggBHAk+kJb1f4fcVyzh0XCGxli/uZQPIZC8G6jWqPxPHR4d
	 qAiXJyNOR3h9ERbEgFZAQthASK67gNgcBQdLuo54q3JBTvj1Omzehj/u8a1ygd0i4X
	 qb807CQEYVLh2Nz2+Ap4hejkDEAZb1WmANDig9+BsrCZoiTGp1qW/ZBx16GkANmCjb
	 tsOeAn35c+Nnw==
Date: Thu, 16 Jan 2025 16:10:36 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 1/4] PCI: endpoint: pci-epf-test: Fix the check for
 DMA MEMCPY test
Message-ID: <Z4khbO_kQC8S2kQX@ryzen>
References: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
 <20250116135106.19143-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116135106.19143-2-manivannan.sadhasivam@linaro.org>

On Thu, Jan 16, 2025 at 07:21:03PM +0530, Manivannan Sadhasivam wrote:
> Currently, if DMA MEMCPY test is requested by the host, and if the endpoint
> DMA controller supports DMA_PRIVATE, the test will fail. This is not
> correct since there is no check for DMA_MEMCPY capability and the DMA
> controller can support both DMA_PRIVATE and DMA_MEMCPY.
> 
> So fix the check and also reword the error message.
> 
> Reported-by: Niklas Cassel <cassel@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/Z3QtEihbiKIGogWA@ryzen
> Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index ffb534a8e50a..b94e205ae10b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -331,8 +331,8 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  	void *copy_buf = NULL, *buf;
>  
>  	if (reg->flags & FLAG_USE_DMA) {
> -		if (epf_test->dma_private) {
> -			dev_err(dev, "Cannot transfer data using DMA\n");
> +		if (!dma_has_cap(DMA_MEMCPY, epf_test->dma_chan_tx->device->cap_mask)) {
> +			dev_err(dev, "DMA controller doesn't support MEMCPY\n");
>  			ret = -EINVAL;
>  			goto set_status;
>  		}
> -- 
> 2.25.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

