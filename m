Return-Path: <linux-kselftest+bounces-36323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FB3AF58BB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 15:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDA54A7845
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF1327D77D;
	Wed,  2 Jul 2025 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1fKOICr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D350A26FD8F;
	Wed,  2 Jul 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462422; cv=none; b=Q5vKmRVJb6emzIHFHCpvr/WCri786KNXX+P7Lg41diUBMeikdFOtClrx3fRQtTqHAADqPJT6/RzEPd+Dgm4cCwow/kdHT6OiZh2xtQbAVBZyczN13OVeg1TpbW/tVV1iNm1WOg9iaO/8A+V/yUaqHMKXU17XCgZeoxaU3O5OHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462422; c=relaxed/simple;
	bh=Vw+TK6BmCACUGzgvGFj2GeLrvABo3wOiWncJZBGBnxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+A2SO9nXF5gY6WISO08y47p4D0UOFVV9URoXE0st5FTuxr8VyYlaoxFPTYiW4P8emG6uPZwmCwJ6w7jw+GkO4q47DOqm8P6UCG2AWZf9XizQMr5bIefuL7mp/pDH+/prMpUMhIXVnNAwc2c634v0rljNt6yqbaCGpb0X4ouAFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1fKOICr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0E9C4CEED;
	Wed,  2 Jul 2025 13:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751462421;
	bh=Vw+TK6BmCACUGzgvGFj2GeLrvABo3wOiWncJZBGBnxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1fKOICrttxn/1HT2v5kxU/WySxxo4X9A+Cr+GbsuBkSPKO0J4MxTupYq3LJa+cdh
	 4IGb3a6rWpdZi+AMS4jEzeYgqdh8tzYFLGbkY7wjLoc9P3aBtfQm6t09FLg0Lm01Gq
	 jkGTdfgJF2Lxp0yji0nM/xl+KDpLOj4mtKWRrqm7iJOKpIDG8HgzsLYChQfT0Bm/uo
	 MD8jMkxcYbRMETnsvqGpi5nJIEmVAZFB1rvgzWmPcZVa19+Vcyixoi2JUhe1c6YM6j
	 5XZ0YuC6vk7NY7QGH/bADWMYgPj8J2VR88K4Gg/qxP+CFHdrisjL+TPxOO8YjHGiWS
	 wzu2l721Fdwfg==
Date: Wed, 2 Jul 2025 18:50:02 +0530
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
Subject: Re: [PATCH v19 08/10] pci: imx6: Add helper function
 imx_pcie_add_lut_by_rid()
Message-ID: <s6uvv5yotunkzmmc7hoxsxccihuoze5e6hkzdpmgqjaq7otlh6@uazl74vzsweg>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-8-77362eaa48fa@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-ep-msi-v19-8-77362eaa48fa@nxp.com>

On Mon, Jun 09, 2025 at 12:34:20PM GMT, Frank Li wrote:
> Add helper function imx_pcie_add_lut_by_rid(), which will be used for
> Endpoint mode in the future. No functional change.
> 

What do you mean by 'used for Endpoint mode'? Endpoint mode is already supported
by this driver. So be explicit on how the new helper is going to be used.

Also, looks like this patch is independent of the doorbell patches. So this and
9/10 should come first.

- Mani

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v14 to v16
> - none
> 
> change from v13 to v14
> - new patch
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b1..032b906c44dfa 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1096,18 +1096,14 @@ static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
>  	}
>  }
>  
> -static int imx_pcie_enable_device(struct pci_host_bridge *bridge,
> -				  struct pci_dev *pdev)
> +static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
>  {
> -	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> -	u32 sid_i, sid_m, rid = pci_dev_id(pdev);
> +	struct device *dev = imx_pcie->pci->dev;
>  	struct device_node *target;
> -	struct device *dev;
> +	u32 sid_i, sid_m;
>  	int err_i, err_m;
>  	u32 sid = 0;
>  
> -	dev = imx_pcie->pci->dev;
> -
>  	target = NULL;
>  	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
>  			  &target, &sid_i);
> @@ -1182,6 +1178,13 @@ static int imx_pcie_enable_device(struct pci_host_bridge *bridge,
>  	return imx_pcie_add_lut(imx_pcie, rid, sid);
>  }
>  
> +static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> +{
> +	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> +
> +	return imx_pcie_add_lut_by_rid(imx_pcie, pci_dev_id(pdev));
> +}
> +
>  static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
>  				    struct pci_dev *pdev)
>  {
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

