Return-Path: <linux-kselftest+bounces-30145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 305A9A7C4B3
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 22:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E05E7A5091
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 20:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7338121507F;
	Fri,  4 Apr 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAmhRw7N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0FB20ADC9;
	Fri,  4 Apr 2025 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743797502; cv=none; b=aAMvSdfiNTa0qGpELOquPvZyuoMBcIvS4ejo/lZ1nHP/VjKz4bR0n9tuWd+T2WudD0WboFHwbCsQVuLop7Caslg/rjonA1boP4u5AWQKAvzAp7/m4MkF68bL9ay2wt66n02utS2U7yU6iYNKLCNWMViD7ZF4ROkm1s0yrDKTtdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743797502; c=relaxed/simple;
	bh=VHeRdeU1SaiFj8DJEwuhTtm9mNs5SIztyxEFxics7os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZB+LyrNiaoC0VhJdZMyV5L8sEgkDfzEG/bkOuNuhW2h7QZISDX99P6S4s+P+JQhy28XvvRbPbosW29vtc5QdDOwHhnWKtz7kcbhkT6wXS9kkx89MSyDdsXZ5raWaZsNnO1rZ43SoNiMBPEUDp34SsDhNtLaAjXYDXa60vfEt7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAmhRw7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B142C4CEDD;
	Fri,  4 Apr 2025 20:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743797501;
	bh=VHeRdeU1SaiFj8DJEwuhTtm9mNs5SIztyxEFxics7os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAmhRw7Nz52NW/mVabsCa688AdBJSVdZkV1u1WrVh4Ig1it56SoT6FD/MZv5N6aj2
	 Ttq1X3XOJkzXfty8JVHMdmJA7mfW8hangGrm80Ra7FDXShmQXXfpXZC2P8qgC5Jp+s
	 uT0vlIO1IWcTxTTQNffblOjXVclF9rOn9xkb5OLCMH3RRzgn11MwOHniYCR2wV4tLD
	 9dcXkPLT1uewh810i7xpoIW7iBxu+bSFZlLBfuG9AvUcgpbfmqRECY74Rm0HGT6GLr
	 Pvccpg3Vra1Bfv2lTc+sZHuctyRI/NFIZAKZjA1CL0P5GdvdS6Mw60hPa4pydOKfu/
	 EF9kclGKQM1QA==
Date: Fri, 4 Apr 2025 15:11:40 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v16 04/15] dt-bindings: pci: pci-msi: Add support for PCI
 Endpoint msi-map
Message-ID: <20250404201140.GA236599-robh@kernel.org>
References: <20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com>
 <20250404-ep-msi-v16-4-d4919d68c0d0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404-ep-msi-v16-4-d4919d68c0d0@nxp.com>

On Fri, Apr 04, 2025 at 03:01:05PM -0400, Frank Li wrote:
> Document the use of msi-map for PCI Endpoint (EP) controllers, which can
> use MSI as a doorbell mechanism. Each EP controller can support up to 8
> physical functions and 65,536 virtual functions.
> 
> Define how to construct device IDs using function bits [2:0] and virtual
> function index bits [31:3], enabling msi-map to associate each child device
> with a specific msi-specifier.
> 
> Include a device tree example illustrating this configuration.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v15 to v16
> - new patch
> ---
>  Documentation/devicetree/bindings/pci/pci-msi.txt | 51 +++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Please don't add to .txt files.

Rob

