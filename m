Return-Path: <linux-kselftest+bounces-37042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C55B00BF1
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 21:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407E8764BFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 19:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8042FE33B;
	Thu, 10 Jul 2025 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxYJwpnO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1A2FE327;
	Thu, 10 Jul 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174838; cv=none; b=UL6SGlXd8nNC+17oftGY5KrXoCmqzuWw+ujzyeSvKc/alF7DsL+2LViZdLWAio5WYnVjGB/MjSqnJhH8wZpZP7ok+cfpN7rVK72seMJY7T8OZ6aHzG4sKcz/VqA3+dM0VC6SHjPSEF/YAK1lKLjRUYR+WwYSQgj5XuS+gVHrob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174838; c=relaxed/simple;
	bh=AyOagcGSXpBuGhg+sk+h2sw3geLwEXSyFxwH/3Qmsrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=usArHRmZYI1YlXJKx7zWJBjep6+STb4D0O/DOVKXb0xedZVdgbPMIY20LAPnFGUyDiuVmlpffCOFIWoSgzArRwaR5+YM9wEnlDmO0Sm4LPUqojHYbA5LZSPHLd4HItzd1bLR8+9L/+3f0txheOqQVl9YwRLty7ln5ngSXtkIei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxYJwpnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15046C19421;
	Thu, 10 Jul 2025 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752174838;
	bh=AyOagcGSXpBuGhg+sk+h2sw3geLwEXSyFxwH/3Qmsrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qxYJwpnOgdp6i/MsXiIMVeKPHmcOAStOalVJORjViqAZwcx93yEY9E4sECOQe2xXO
	 b5BNma3tA6SSWESJCbyehXvXk+aY3kVWZUzDUx09WCT3GlKWyHvTY/wvoklUSQBt5O
	 oucoCsK8h/hGLa4FiSReOk/OOsJ0FnM2FjfVBbs+JkkIoHKRQXUa62078JksXi3Q2s
	 R4p11NrYhBcreehDBPgxlD5AwAHcI1wwQs4NE9/qfhP/13YobcANccpk0DYX9r0sLn
	 qtiaWDExu7UU4MPh2PFDMeOMPDG+0rXLKhZCkZI08eYiWcfKG7U4hnW3MfPVEpcLE5
	 ATSr+C5Z8um0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E53C83F1B;
	Thu, 10 Jul 2025 19:13:58 +0000 (UTC)
From: Frank Li via B4 Relay <devnull+Frank.Li.nxp.com@kernel.org>
Date: Thu, 10 Jul 2025 15:13:50 -0400
Subject: [PATCH v21 4/9] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-ep-msi-v21-4-57683fc7fb25@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752174836; l=1452;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5GnLijRH62gBTUdnVBRu9d7hyvLf0+eT6hrBiV+MYG4=;
 b=L2fisuczw40QBhMHVWvKZlHl+ivJhSeTrPDRL1yujDkngHoAuZxODt+gGwgTwwaumwaPHxAJ8
 IIude4pEMWeALEBm43Q6meOerlETZX6WDL9ailiwfhENDBtlJl0z8Dr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-Endpoint-Received: by B4 Relay for Frank.Li@nxp.com/20240130 with
 auth_id=121
X-Original-From: Frank Li <Frank.Li@nxp.com>
Reply-To: Frank.Li@nxp.com

From: Frank Li <Frank.Li@nxp.com>

Some MSI controller change address/data pair when irq_set_affinity().
Current PCI endpoint can't support this type MSI controller. Call
irq_domain_is_msi_immutable() check if address/data pair immutable.

Also ensure it is parent MSI domains, not device-specific MSI domains,
since device MSI domains do not allocate address/data pairs.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v20
- update commit message
- change return error code to ENODEV

change in v18
- update commit message. remove 'include/linux/msi.h' part.

change from v14 to v17
- none

change from  v13 to v14
- bring v10 back

Change from v9 to v10
- new patch
---
 drivers/pci/endpoint/pci-ep-msi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index de610c16f68986eb0a5f4a0f23bd0136aa169f97..2b4405cfeb6f8f3cbe9782c793604a10dcaa4eb7 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -55,6 +55,14 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 		return -ENODEV;
 	}
 
+	if (!irq_domain_is_msi_parent(dom))
+		return -ENODEV;
+
+	if (!irq_domain_is_msi_immutable(dom)) {
+		dev_err(dev, "MSI controller not supported\n");
+		return -ENODEV;
+	}
+
 	dev_set_msi_domain(epc->dev.parent, dom);
 
 	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);

-- 
2.34.1



