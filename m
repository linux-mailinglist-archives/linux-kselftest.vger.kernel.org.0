Return-Path: <linux-kselftest+bounces-22635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35EB9DEC90
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 20:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BD36B219D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 19:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F293155391;
	Fri, 29 Nov 2024 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRzevYF+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DDF15AF6;
	Fri, 29 Nov 2024 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732910139; cv=none; b=Jpw+uJEcxK5DXOJ212S+6QmZzHGyVtBNjV6TgfJGK+Ozw3OX6R8XT35JV7F8HXY3EpANgWlSY+UEwmWOtw5M69N3HfNtgpwZaZ4NWPsvBREVdlAEGyFW6p5RiLj6SVm05sHAYkg76FiJx8iWgR+hizEwKkcCEdlDxy38TJiijEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732910139; c=relaxed/simple;
	bh=QgPr2KbA1m5SASDhjMe9rxnKS5wNsj8DTXHscwQGniQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qewbXTDbbQY+0yVf65HkcDblbpFb3BpbHSQY+55dauWj+JgBwxscS4isqigFNoZaUwpFjOsmtqoeZPeRBtVcTZRid1xFzkyCY8a/eW4gTkBfwQn+uAYQQKFKuVx2DfSc4c1azBQ09FwGWGp0H9zFW6Tzc9Rxrj0MIsNQxxE1uCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRzevYF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B039EC4CECF;
	Fri, 29 Nov 2024 19:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732910138;
	bh=QgPr2KbA1m5SASDhjMe9rxnKS5wNsj8DTXHscwQGniQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MRzevYF+2OY5SSW4Ix/KHVpQOF67UlBFka9imFkzWURDQV/B57ur0TtMXYgNxjTRQ
	 +6qZvYxlJdlXnVMkVLQDgrzmIbU3uhJM3toKuxqas+ERWBBgInmeweruRkK0Y2TyCU
	 NLfpYa6PbZJGWT7Sgs8+BcDCxtSgAd4+jTOw4eZbVgJTdvYM0ocYgijHIGPb/mstY7
	 05ek5KsbxfQmKQ+cPo5c2DDkOO6QEuO7qei+p34Q04QG6OnQHaNxCS2cCt9ZRnTckC
	 GUxZfdfwLmYY9o5rU56vWiIPRquKOL5zWPtvU9JfLvxvJw7RJIgaZAzUkEjK5UnSiK
	 gaXx7Nscm0syQ==
Date: Fri, 29 Nov 2024 13:55:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	aman1.gupta@samsung.com, p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org, stable+noautosel@kernel.org
Subject: Re: [PATCH v2 1/4] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and
 BAR1/BAR3 as RESERVED
Message-ID: <20241129195537.GA2770926@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129092415.29437-2-manivannan.sadhasivam@linaro.org>

On Fri, Nov 29, 2024 at 02:54:12PM +0530, Manivannan Sadhasivam wrote:
> On all Qcom endpoint SoCs, BAR0/BAR2 are 64bit BARs by default and software
> cannot change the type. So mark the those BARs as 64bit BARs and also mark
> the successive BAR1/BAR3 as RESERVED BARs so that the EPF drivers cannot
> use them.

"Default" implies an initial setting that can be changed, but you say
"by default" and also "software cannot change the type."  Can they be
anything *other* than 64-bit BARs?

If they're hardwired to be 64-bit BARs, I would just say that.

> Cc: stable+noautosel@kernel.org # depends on patch introducing only_64bit flag

If stable maintainers need to act on this, do they need to search for
the patch introducing only_64bit flag?  That seems onerous; is there a
SHA1 that would make it easier?

> Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index e588fcc54589..f925c4ad4294 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -823,6 +823,10 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
>  	.msi_capable = true,
>  	.msix_capable = false,
>  	.align = SZ_4K,
> +	.bar[BAR_0] = { .only_64bit = true, },
> +	.bar[BAR_1] = { .type = BAR_RESERVED, },
> +	.bar[BAR_2] = { .only_64bit = true, },
> +	.bar[BAR_3] = { .type = BAR_RESERVED, },
>  };
>  
>  static const struct pci_epc_features *
> -- 
> 2.25.1
> 

