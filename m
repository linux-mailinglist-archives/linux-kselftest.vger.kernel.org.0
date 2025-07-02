Return-Path: <linux-kselftest+bounces-36325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B38AF5936
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 15:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59072189DD21
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 13:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE1E28640A;
	Wed,  2 Jul 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeDxSl+x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17573275AFC;
	Wed,  2 Jul 2025 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462590; cv=none; b=gEg6h72pd7eRaGe0IG7S66q48+wiD7HFIM5KPbwC87dSkW6M8AS3cotMcFrnyKngKQ8jcN6EghaKKvWb+tvPjZguPq+8ABKY+Uco/sw72DaHGmDNj37/8jiaVScjWYNx+6HD1jOw+3Umy/m5AyOnefjrTgDVSZA9cIolATas8VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462590; c=relaxed/simple;
	bh=ls4BL36XpqMPgnaxs3/5LeyK2gWf65Q7J7Cm9qsCR0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PorDKKa/IPCU2wQjY5pS/SgK0Os+ZGt69CHaAOPvXxDKYvbXnqgLb7hxZGFjGxeurtH0fxl+VJyfzdit5on8ccUceIhGgsD52UYotT7TRZuMdEsp2nGiYYZDpcQFTnPdf1bLpMmr03jRZshkS+E1OW488zMMTHS9ZXtWaP42mJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeDxSl+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062A1C4CEEF;
	Wed,  2 Jul 2025 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751462589;
	bh=ls4BL36XpqMPgnaxs3/5LeyK2gWf65Q7J7Cm9qsCR0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eeDxSl+xNClQVxv20D4Rit498gd6NsuBF07Q3IsZYTmNyOmfwCeCXuIhM3VckYOSZ
	 Cvwcrd9Dz5Y2jRUqKEJyePhP3BQMbH2G77Ad1/1srRM9IfYoroheUkfoNLtmlbxgSe
	 dLkvkoQd6MM+o74wfUBnQn93oa5RSHv0QtnYYZOTUAnxJ3AyiM6Bw6O7GPSROEczno
	 rQBRLC6/NaMxPoJr/50Y08r8plR7Rp1AucGzZw3NXlwLcMIAwLsJfNa7/gh3dt1Em0
	 qhghTqlW+40+Bmp8ifRogASz3K4AQRDHTm6/YpJy4Eqk3UsOKk5O1karwhlFxv53fx
	 kAUaXBY3Xqg/A==
Date: Wed, 2 Jul 2025 18:52:52 +0530
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
Subject: Re: [PATCH v19 10/10] arm64: dts: imx95: Add msi-map for pci-ep
 device
Message-ID: <qk62dx7jxtcs5xhzy6bbyxnao6gmcnstgb4rmlk3ccoxqxdvlf@nulfy4ryaudg>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-10-77362eaa48fa@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-ep-msi-v19-10-77362eaa48fa@nxp.com>

On Mon, Jun 09, 2025 at 12:34:22PM GMT, Frank Li wrote:
> Add msi-map for pci-ep device.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> change from v14 to v16
> - none
> 
> change from v13 to v14
> - new patch
> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 632631a291122..c59d11eb7a581 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -1797,6 +1797,7 @@ pcie1_ep: pcie-ep@4c380000 {
>  			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
>  			assigned-clock-parents = <0>, <0>,
>  						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> +			msi-map = <0x0 &its 0x98 0x1>;
>  			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
>  			status = "disabled";
>  		};
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

