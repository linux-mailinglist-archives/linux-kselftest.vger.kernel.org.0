Return-Path: <linux-kselftest+bounces-36324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D35BAF594C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24B14E421B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 13:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387B22C08C9;
	Wed,  2 Jul 2025 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2u8efaZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C4275AE0;
	Wed,  2 Jul 2025 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462542; cv=none; b=dilENyXI7M4Dmo7//TvgwW2oUgbCEcpbm5F7dyzCyyGKIwRTAZcybOkjzJZHGs9iqD9kZimsAuVxeNnlb82KE6WJUOwAwoRkzHYpoDzqwULd9LPsdWWlaSrR3Uf0JZTMqpm8euj73ifNGCJB8SiPdFMinIH3lJG0cgyErdSOi64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462542; c=relaxed/simple;
	bh=+F+WeI0oEJBGsbflJro9BGxIEygspR5aMMF725YqjYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoZ1y3Ct9en7LqGJA0CEoWXirBsjDQObdn/vGRuGypKWBRMwUk5qx0plK1bRksuLNjOstM8MCt2gjJ+ImLvz08u9vMNSHUz79qCZAik8r3pM0uu0m0JsS5TaZEFBsrsn4YJ8yNp+ammLY56UkKJaep0ImQbaPrlovLbr6mZ52f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2u8efaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4762C4CEF2;
	Wed,  2 Jul 2025 13:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751462541;
	bh=+F+WeI0oEJBGsbflJro9BGxIEygspR5aMMF725YqjYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2u8efaZ7FVf5+05KuTyWvyE/L3l04+Hwi6w2URjIz4j15idOzOBWyKp8DT1RESXw
	 VUoay1cpjze3DfM4cZ4e7ZpaZzYgcB4NCRsHO4ZXCyjm2prJ872S77wk3D4oB6Wk5O
	 n06ZmS5KDPRp6o/UExgePsja02Oad+EqfAe0s1u9X34esJIlXfcBUgCYPNF1ZqRAjJ
	 NWiXow+CodmA9L8ooyz+6yBASfC5VFmb+lR7Oi1+pdndNw5irQ+dPOShn13++Qe81h
	 ivsSvjRmgo8U9ijzFIoEGWImg6+huvTj3kcRpCGhPzDzt8dneygx2LbxjwaykP6t5C
	 FfmjZPv67/nvw==
Date: Wed, 2 Jul 2025 18:52:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v19 09/10] pci: imx6: Add LUT setting for MSI/IOMMU in
 Endpoint mode
Message-ID: <tovqcf6mjrajaie26t7gvl6uuoniqyturogzyaef6bksjm2nux@ggsmbgudgf7n>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-9-77362eaa48fa@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-ep-msi-v19-9-77362eaa48fa@nxp.com>

On Mon, Jun 09, 2025 at 12:34:21PM GMT, Frank Li wrote:
> Support only one physical function, so call imx_pcie_add_lut_by_rid(0)
> to add a single LUT entry when operating in EP mode.
> 

So previously LUT config was not present and endpoint mode continued to work?
Please explain why this is necessary now.

- Mani

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v14 to v16
> - none
> 
> change from v13 to v14
> - new patch
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 032b906c44dfa..3123bf49e209c 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1063,7 +1063,10 @@ static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
>  	data1 |= IMX95_PE0_LUT_VLD;
>  	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
>  
> -	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
> +	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
> +		data2 = 0x7; /* EP side's RID from RC, only 'D' is meansful */
> +	else
> +		data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
>  	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
>  	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
>  
> @@ -1767,6 +1770,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		ret = imx_add_pcie_ep(imx_pcie, pdev);
>  		if (ret < 0)
>  			return ret;
> +
> +		/* Only support one physical function */
> +		imx_pcie_add_lut_by_rid(imx_pcie, 0);
>  	} else {
>  		pci->pp.use_atu_msg = true;
>  		ret = dw_pcie_host_init(&pci->pp);
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

