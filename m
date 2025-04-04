Return-Path: <linux-kselftest+bounces-30147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D515A7C5CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 23:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE186189F1A6
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C721A4F2D;
	Fri,  4 Apr 2025 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJLbDe1U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766B182BC;
	Fri,  4 Apr 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743803565; cv=none; b=M2GfQ6Gu0VI8xZdoo8Yl0lCs9XWjBjA9FYUEU0XCRmTjlo6PtVJv2UHMaFBVAscJChqdoK/ZKJzGpt6vCqEe06Ik6q3N+pf8sly22wIr8d0z+2z/1/m719TQjForpqERI5p6nzxn+whMGvck4nt+YFN6lAmIJnynbaGgoPw97Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743803565; c=relaxed/simple;
	bh=zfKuyAqEThSpITUsQxukfzwj1EOtZMLMZc21pVrK58U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0UbaV2cq9eZCGbKqzsV3+FD/xqfwMZAPHI5xgetSCqnHog2C2oNGb2gCUiFiryp/RbVX7zVPq9M20xjL7xx3FVYkcv5t3938bFTUvSbHMkYxZcxdwyoI6sNloU/LQXMeALJWUcWNxLWKoqb0jUZQvml3q2/bRLzLdDX/qHcTwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJLbDe1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572D5C4CEDD;
	Fri,  4 Apr 2025 21:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743803564;
	bh=zfKuyAqEThSpITUsQxukfzwj1EOtZMLMZc21pVrK58U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJLbDe1UWCik0+X07dueePSGryP67mZMHCTK2OzoZPKRioPAbyPo+4gCEfNLSf/eJ
	 6Qp/fWuBKrJZcXMd9IBvlrMC7FDFLvFwYuHitO3LfWNKxm4RJBKVnp7hMAQE+tzITt
	 69k+1zH8kTEd28hZmQfjiOn9K8j6bLQE+0Uvbs0+QcmhRs1SR11IH9Hmv0VB3QH/uW
	 FiuzBA7y52ebnEEM/TyOrp7u58pqPS7CqUwVi0vd5I9IXodxKzKb6QlvgMe121GNPr
	 j4sgKOfZ5dHAnqMYTvJHCltafWgeDABxruiSkEoUaAizrenp3zqr0t2kNnm9w/nyQ1
	 qeQkrB9FIcjRg==
Date: Fri, 4 Apr 2025 16:52:43 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
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
Message-ID: <20250404215243.GA412761-robh@kernel.org>
References: <20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com>
 <20250404-ep-msi-v16-4-d4919d68c0d0@nxp.com>
 <20250404201140.GA236599-robh@kernel.org>
 <Z/BB/Maq4253H7N2@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/BB/Maq4253H7N2@lizhi-Precision-Tower-5810>

On Fri, Apr 04, 2025 at 04:33:00PM -0400, Frank Li wrote:
> On Fri, Apr 04, 2025 at 03:11:40PM -0500, Rob Herring wrote:
> > On Fri, Apr 04, 2025 at 03:01:05PM -0400, Frank Li wrote:
> > > Document the use of msi-map for PCI Endpoint (EP) controllers, which can
> > > use MSI as a doorbell mechanism. Each EP controller can support up to 8
> > > physical functions and 65,536 virtual functions.
> > >
> > > Define how to construct device IDs using function bits [2:0] and virtual
> > > function index bits [31:3], enabling msi-map to associate each child device
> > > with a specific msi-specifier.
> > >
> > > Include a device tree example illustrating this configuration.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > change from v15 to v16
> > > - new patch
> > > ---
> > >  Documentation/devicetree/bindings/pci/pci-msi.txt | 51 +++++++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> >
> > Please don't add to .txt files.
> 
> where should put?

Where ever you are putting the schema for msi-map for endpoints... Looks 
like that's nowhere currently. The endpoint side is documented in 
pci-ep.yaml, so there I suppose.

What's in pci-msi.txt already has mostly moved to dtschema 
dtschema/schemas/pci/pci-host-bridge.yaml. 

Rob

