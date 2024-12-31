Return-Path: <linux-kselftest+bounces-23797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2309FF0C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 17:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8965E162507
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC491A38E3;
	Tue, 31 Dec 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3hrWioi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B11A0714;
	Tue, 31 Dec 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735664274; cv=none; b=uzof5HKpG/IR2YP0tX0Dd2rSRuPXP+MmCmbd88IQtAm4pNQH+M0D0Vn9rVp8bTNzig7l5OquMiWdboGt1gUGJNKFQcpzzqkvF34MgWRYQdzAzOPJl0axhnC5ELkjxC5WYAGqeS1Ie3Lt4nD+KgWEXyNAAuvVuuPRhRSbPoi1TGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735664274; c=relaxed/simple;
	bh=8sDY2rwKAXjQ0vNUX4nV9QOLHPsAoQ+a7w2JDmnOO3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dgf1q21GAeCxw34eErYJ5d5PacGb6Z0N/CvdAA4ZigeJr81JzpGY/sfDfMwK8mFmNFgVQqdNZ6xvPbRs16tXvibI0jI8gv2b4Uh+s0EacPz9Ew3XR0mGaIkuaeZT33kGqIeo76xjY/uGo6kB0jyMpqlq1MS+ID6rlb+2bThi8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3hrWioi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21D4C4CED2;
	Tue, 31 Dec 2024 16:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735664273;
	bh=8sDY2rwKAXjQ0vNUX4nV9QOLHPsAoQ+a7w2JDmnOO3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3hrWioiJvyrRJoKBFMSCncrGnoVg43CZp75itSiUDOeL7bPH2mKpWe7kfhLXYTq4
	 jBgg1NQGfo72F8fNOeNgaq9ZuoFftOX1UuFWTN/GFwi8KBhuAGqRUI7Pxr9sND53Fn
	 S2KkqKpqEtT6CvyWCEu/ej1jnzkOcJIVONhK5gAeK+hlxm1LwI+6SS2LTeNtxYgBHd
	 TymPojjerhu6s/f3DqjkiTu1OqZ3rmVH+O6yr4ty75yKnp7KChiihfw1qPDGhkwF+o
	 opBcZ6qmZMCFnFqJNDsOt0VTELjwK5xdFGNY5xRqZIZVyKnTC2+w2YJaHiWJ6jC6V2
	 HgSP7jpUGqYfg==
Date: Tue, 31 Dec 2024 17:57:47 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v4 1/3] misc: pci_endpoint_test: Fix the return value of
 IOCTL
Message-ID: <Z3Qii43XSnxvc4pp@ryzen>
References: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
 <20241231131341.39292-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231131341.39292-2-manivannan.sadhasivam@linaro.org>

On Tue, Dec 31, 2024 at 06:43:39PM +0530, Manivannan Sadhasivam wrote:
> IOCTLs are supposed to return 0 for success and negative error codes for
> failure. Currently, this driver is returning 0 for failure and 1 for
> success, that's not correct. Hence, fix it!
> 
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Closes: https://lore.kernel.org/all/YvzNg5ROnxEApDgS@kroah.com
> Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 250 +++++++++++++++----------------
>  tools/pci/pcitest.c              |  51 +++----
>  2 files changed, 148 insertions(+), 153 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 5c99da952b7a..7d3f78b6f854 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -169,43 +169,47 @@ static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
>  	test->irq_type = IRQ_TYPE_UNDEFINED;
>  }
>  
> -static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
> +static int pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
>  						int type)
>  {
> -	int irq = -1;
> +	int irq;
>  	struct pci_dev *pdev = test->pdev;
>  	struct device *dev = &pdev->dev;
> -	bool res = true;
>  
>  	switch (type) {
>  	case IRQ_TYPE_INTX:
>  		irq = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
> -		if (irq < 0)
> +		if (irq < 0) {
>  			dev_err(dev, "Failed to get Legacy interrupt\n");
> +			return -ENOSPC;
> +		}
> +
>  		break;
>  	case IRQ_TYPE_MSI:
>  		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
> -		if (irq < 0)
> +		if (irq < 0) {
>  			dev_err(dev, "Failed to get MSI interrupts\n");
> +			return -ENOSPC;
> +		}
> +
>  		break;
>  	case IRQ_TYPE_MSIX:
>  		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
> -		if (irq < 0)
> +		if (irq < 0) {
>  			dev_err(dev, "Failed to get MSI-X interrupts\n");
> +			return -ENOSPC;

From the pci_alloc_irq_vectors() kdoc:
 * Return: number of allocated vectors (which might be smaller than
 * @max_vecs), -ENOSPC if less than @min_vecs interrupt vectors are
 * available, other errnos otherwise.

So pci_alloc_irq_vectors() can return errors different than ENOSPC,
and in that case, you will overwrite that error.


> @@ -442,9 +444,12 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
>  	val = wait_for_completion_timeout(&test->irq_raised,
>  					  msecs_to_jiffies(1000));
>  	if (!val)
> -		return false;
> +		return -ETIMEDOUT;
>  
> -	return pci_irq_vector(pdev, msi_num - 1) == test->last_irq;
> +	if (!(pci_irq_vector(pdev, msi_num - 1) == test->last_irq))

if (pci_irq_vector(pdev, msi_num - 1) != test->last_irq) ?

Or perhaps even:

ret = pci_irq_vector();
if (ret < 0)
	return ret;

if (ret != test->last_irq)
	return -EIO;


Otherwise, this looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

