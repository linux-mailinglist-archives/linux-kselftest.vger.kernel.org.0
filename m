Return-Path: <linux-kselftest+bounces-30916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776E1A8AC11
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 01:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811A444375D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D627D2D8DBC;
	Tue, 15 Apr 2025 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s55FM5NH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16F2D8DA3;
	Tue, 15 Apr 2025 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759676; cv=none; b=T3xTEz3ftC0usgrgMrUi3IwT/6Kqy4FW0ryyZcsBTnSsTVSmgoGr7iofPUWJH3vgzpR5awHClaX4lfMBwCP914PFYD/mHoNOcOdAbEOcf0qrx1aC4G6fGZLswKCV/J/JKv+NUxhGEePFw4jLUGN/aeICF7YXbktlgCCT1+Cnsng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759676; c=relaxed/simple;
	bh=xFZThZAwd6sgcs4jLPlvefAr9HMS2oFrx8khX6DALzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lz6UZp8+OHywzTANf01h353/3ZhLG7EjppU0fmfllUgJE62vXVZlW7XyYGqHypPdEM7jWidPPtQgfla+LyOxGbe11OBHK1TlDW+eIEBPtAimcsqQft/XP1GRSsvOWdYh7SQT90FTdH5a9R8Gd5xT33+/KHAPaCK4rpqsSAinM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s55FM5NH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5ACEC4CEE7;
	Tue, 15 Apr 2025 23:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744759676;
	bh=xFZThZAwd6sgcs4jLPlvefAr9HMS2oFrx8khX6DALzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s55FM5NHKn9UWkQGkkp3Lm71ct0k86m3v6URIEpcNFl91F7Um+aotyx9yOzTJEU/C
	 bCkdTGLxKsY6W+ndO+e6/hXMooFhnlfJY5LpwR1onOAYr0gBQ9DAV8V+Rr6jHBwZuC
	 X2W2XJ+xuH5aW8+bEM31KoE18yb94akbx2TcOPeuDe9V0PclQsAQqm1fnLMKy9FzFf
	 bmMiAYOSIqfORFs6S/iZaz5r3JImTARJzvxrhHxBZKVAOrOQyqBFmIg0S2CR9BAUAV
	 75QpbV+iJ8pN/TffgLnQF5hfJWho48CMjNbLQ4qrrjetIzhgLmvqhXgH4H97ZUpWms
	 aAp1Zzix7Hqcg==
Date: Tue, 15 Apr 2025 18:27:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>, imx@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, dlemoal@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <cassel@kernel.org>, jdmason@kudzu.us,
	Shawn Guo <shawnguo@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v18 04/15] dt-bindings: PCI: pci-ep: Add support for
 iommu-map and msi-map
Message-ID: <174475967369.1016540.6220438967935307132.robh@kernel.org>
References: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
 <20250414-ep-msi-v18-4-f69b49917464@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414-ep-msi-v18-4-f69b49917464@nxp.com>


On Mon, 14 Apr 2025 14:30:58 -0400, Frank Li wrote:
> Document the use of (msi|iommu)-map for PCI Endpoint (EP) controllers,
> which can use MSI as a doorbell mechanism. Each EP controller can support
> up to 8 physical functions and 65,536 virtual functions.
> 
> Define how to construct device IDs using function bits [2:0] and virtual
> function index bits [31:3], enabling (msi|iommu)-map to associate each
> child device with a specific (msi|iommu)-specifier.
> 
> The EP cannot rely on PCI Requester ID (RID) because the RID is determined
> by the PCI topology of the host system. Since the EP may be connected to
> different PCI hosts, the RID can vary between systems and is therefore not
> a reliable identifier.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v17 to v18
> - mask max value should 0x7ffff
> - order according to property name
> 
> Change from v16 to v17
> - new patch
> ---
>  Documentation/devicetree/bindings/pci/pci-ep.yaml | 68 +++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


