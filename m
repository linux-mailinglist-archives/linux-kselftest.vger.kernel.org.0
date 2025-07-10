Return-Path: <linux-kselftest+bounces-37039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0238B00BF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 21:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B34B37B9085
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 19:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA0D2FD86A;
	Thu, 10 Jul 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDqDZa/H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578752FD5AD;
	Thu, 10 Jul 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174838; cv=none; b=OLHM/VTsu2xcr39ruAJQPXhtHqFmi9pl6Y0UmRfmpAG6l2KY+8oUGt86QsTnwHsGm8DOtYSt6zgjOQ3N576OdNVHUoFT1aoFUivWE9QH7nTunr4bWu44crNr3tuQj7ekamXf8GnXK4ew/HhzWiV5LPb4oPlGt8j0mv41oCsTXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174838; c=relaxed/simple;
	bh=htJO8DNvMG8JfxhKULyjO956ceacV6C/omT3F7WroKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clT5nRXv0ekvR5F4Ojogiusk6Q01ufJqSSNP88y2avi42TrF430bH6FBhArTjwbFUGyk3gBOrJPCmMc0dqDlkfU0x0+0rAZNkmVe+IMxDqR1wpKSwclPK3D63ebQGO/CFvVni0K58m0MvfFGXgrJFHZFLRp2SezV02qHW+wUE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDqDZa/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1B9EC4CEFC;
	Thu, 10 Jul 2025 19:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752174838;
	bh=htJO8DNvMG8JfxhKULyjO956ceacV6C/omT3F7WroKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gDqDZa/HYADSuBS0ZXQcP5lEyyrst3Sk0XlI/GpM5xW9udm48YitXX492j2VEH7OW
	 xMVrs56m0fFtwqiZ9LFWw1JoJp0yKVNh131tz+6BQS+WrsmjaPMSfB9YX3h6oDwh5X
	 XLpmQm5spN+kDEFdDaOj6wbW0qg4JHFkQbiCD05EnVh5bI1GX8RbJyBe6MckGZIvxO
	 jcdtGiOyodOoyzRqja+Go4HPvzu5MZddj14uqunt245lay6PvVDq+3zE8NVjCutoiy
	 LbJPEpubuH/nltyVzBTad5WLNIPZroJrjnRhTxKWy8kFqA5p33su1D1BjN6wedVQUY
	 xIpSw3jyP3QIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5865C83F21;
	Thu, 10 Jul 2025 19:13:57 +0000 (UTC)
From: Frank Li via B4 Relay <devnull+Frank.Li.nxp.com@kernel.org>
Date: Thu, 10 Jul 2025 15:13:48 -0400
Subject: [PATCH v21 2/9] PCI: imx6: Add LUT configuration for MSI/IOMMU in
 Endpoint mode
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250710-ep-msi-v21-2-57683fc7fb25@nxp.com>
References: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>
In-Reply-To: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752174836; l=1837;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=undgD4r0xoItEmBKrD+Vrj1bBDbTL2OdUvPEHbj/82U=;
 b=l+XFGUURzdxzcmkKjct4/0IkcPsOSWsD8L8ONKwjhtN98Cagqt/z/sosYt8lYSneyYhenkY94
 WoOhFqexlkKCMETvGGhnYSvxKxjeW2v/K+qewEnrGs6JSOBN/ZdF3FV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-Endpoint-Received: by B4 Relay for Frank.Li@nxp.com/20240130 with
 auth_id=121
X-Original-From: Frank Li <Frank.Li@nxp.com>
Reply-To: Frank.Li@nxp.com

From: Frank Li <Frank.Li@nxp.com>

Add LUT entry for Endpoint mode by calling imx_pcie_add_lut_by_rid(0),
since only one physical function is supported. This sets up a single LUT
entry required for MSI or IOMMU.

The Endpoint function can operate without LUT if neither IOMMU nor MSI is
used. This LUT setup enables the EP doorbell feature by allowing the Root
Complex to trigger the EP’s MSI controller.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v20
- update commit message

change from v14 to v16
- none

change from v13 to v14
- new patch
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 032b906c44dfaa374a32f511098402a494ef5677..3123bf49e209cc0fc448d6e02a472e280d538033 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1063,7 +1063,10 @@ static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
 	data1 |= IMX95_PE0_LUT_VLD;
 	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
 
-	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
+	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
+		data2 = 0x7; /* EP side's RID from RC, only 'D' is meansful */
+	else
+		data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
 	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
 	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
 
@@ -1767,6 +1770,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
 			return ret;
+
+		/* Only support one physical function */
+		imx_pcie_add_lut_by_rid(imx_pcie, 0);
 	} else {
 		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);

-- 
2.34.1



