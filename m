Return-Path: <linux-kselftest+bounces-37047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659D0B00C07
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 21:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 255387B9B33
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 19:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893E82FE399;
	Thu, 10 Jul 2025 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhZZ3o+B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDE92FE36D;
	Thu, 10 Jul 2025 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174839; cv=none; b=NcbGZEODEM9gYceUwkvXzLFnPgbloI6wJqt1rWtehb57zlq9EAIwam7Uwm4Gw1oad76b8oAGkAP+J4l8hJ/fYhhziCCPEqRqLNQ6v6LAZ7ZXCyGuJUBXpEcpkGLntW78F0OxAizhEKSG7WFP4T9cWsV5L9CbkPRKqi0seaVY54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174839; c=relaxed/simple;
	bh=UfZBgPNXsNVvIoKoizlLf9l//dyhqb8DPMRaq9LzZjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjQQzBVkZw93Cd8TN3Steza+S5dTDRkK2KLesJc3hSYqj/Xm8GoLyz+tdRmBXRGouUGOIZR0jRnY7Wj2Qzm+tPgN30zh4Sbk8OB6eCoi4Z1cyhJZ6bv5wC+3Sw2xDDpt0YP3IZaAfDOGTZFO7LtJD2VGRZN95TT/vKP7oD7Tkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhZZ3o+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65B66C4CEF4;
	Thu, 10 Jul 2025 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752174838;
	bh=UfZBgPNXsNVvIoKoizlLf9l//dyhqb8DPMRaq9LzZjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fhZZ3o+B1YOtPqq/GZDBQRyKrQ3TA+FY7IoW3Vu6T9SZCiKzb77vnw8i9XEQipqI8
	 WMqg8ezFZbAY1pc+/AIQxlfckXGS2K3ISIu+WtoFIWTrHQY1mZNvEzTXDGJXQh19vx
	 6b8xfhJpsa/fCfIJbxjJm01axbc1fwN8gfUXhUdyVRY9qxvGS9/1dQEKwLKJQsEhNn
	 e5ZN2V8W73yZkCLaWqGkx8DZlBF9jrDLv5P0EZk8CyE9O8UEsmxdSQh7KLT9Y8b/Ou
	 U90yI9q9WncbdbxEoX5jPprj2N1ZEpuu0AD8iqg3Dgb9idLWQfhfuTEAZ2JuPxDVeV
	 2a91VLn1XDq4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B55AC83F22;
	Thu, 10 Jul 2025 19:13:58 +0000 (UTC)
From: Frank Li via B4 Relay <devnull+Frank.Li.nxp.com@kernel.org>
Date: Thu, 10 Jul 2025 15:13:55 -0400
Subject: [PATCH v21 9/9] arm64: dts: imx95: Add msi-map for pci-ep device
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-ep-msi-v21-9-57683fc7fb25@nxp.com>
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
 Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752174836; l=973;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wW9Nwm5vAKtBf5Pux9lo/+uSvITxDxxhF8J82uPpSQ8=;
 b=VtcLSyohMB2FbPRKwdeAd1gT+yHIS4yjiZLuRPs9oX0oesyANEabrauubaRWQWZI0Hoa9Tyqq
 pt88S7wZQTQB5u0CTEtvjMU/70Lk/gnk03eIJ59F7pIgZX/e5D2tHlw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-Endpoint-Received: by B4 Relay for Frank.Li@nxp.com/20240130 with
 auth_id=121
X-Original-From: Frank Li <Frank.Li@nxp.com>
Reply-To: Frank.Li@nxp.com

From: Frank Li <Frank.Li@nxp.com>

Add msi-map for pci-ep device.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v20
- add Manivannan's ACK

change from v14 to v16
- none

change from v13 to v14
- new patch
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 632631a2911224cadc16a943cdb467e091e43384..c59d11eb7a581a500d381ef96f1e44533052c2a2 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1797,6 +1797,7 @@ pcie1_ep: pcie-ep@4c380000 {
 			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
 			assigned-clock-parents = <0>, <0>,
 						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			msi-map = <0x0 &its 0x98 0x1>;
 			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
 			status = "disabled";
 		};

-- 
2.34.1



