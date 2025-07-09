Return-Path: <linux-kselftest+bounces-36889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BF3AFF398
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 23:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E41956195F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 21:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2000256C73;
	Wed,  9 Jul 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etFZRhC0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA34251795;
	Wed,  9 Jul 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094971; cv=none; b=lr48/nBZaocD+fTZ0gQsEC37NfD4zGEUepxrOBTm7LAqaS0vpCe23/DtceQ+O5ORYbSLb7k1DhXPVYF/2bnRUdxsqli3TOi30W9OWktCncFngoBoM3+rRFYIjSxG7EBFoa7q+KoCRUnhXm7kcmyEPFvQQi+OWoxSo7gxcjvnunA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094971; c=relaxed/simple;
	bh=AyOagcGSXpBuGhg+sk+h2sw3geLwEXSyFxwH/3Qmsrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ejDOpt3H5r6aIS3YGrKmBHwlaw43muiV9FJzV9jevnZJysakFnvC1c8aJTEeuJJ9fOvZ17wbdgIKJTmRN44nqwE4KLNyVy55V+gxOc4I5TNtkSQzw+hccWgWQYOzB+zqVLKWMG7Cj5QVaMnioUahUKGlMc1LW2eIapbUqhUeNJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etFZRhC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83955C116D0;
	Wed,  9 Jul 2025 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752094970;
	bh=AyOagcGSXpBuGhg+sk+h2sw3geLwEXSyFxwH/3Qmsrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=etFZRhC0miN9k1CNzmvqIvCJXGO8tZfDdYMCz/bLC1LFJXNDXLlqbL68MV6Ze8TIw
	 /4g8t2xPkNWiaNUSPlRAE3x59UQMpTxDJrCSbo+bW5sIKwtjml1U5JALNuuw2yY7YM
	 RCkq3aCkAj1MLPv7mmQZ338Kq5s1h9GQO1MAKHJmNeukpUY/AEzcTiLabjFS8X+2PC
	 lltIdxXbepB/tGZJ2a3FyfyRzanlD94BCdv0Z/qSFauX7Zf0D4GK4t++2w9s2u/jKx
	 sC633r7OmS5pe44vv4JZGuc6fncA7fwhEpjsb/C4RWLAQwIt6zKld0OZ5mmzJo6dTB
	 Vnz12DHrcJMIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE6EC83F17;
	Wed,  9 Jul 2025 21:02:50 +0000 (UTC)
From: Frank Li via B4 Relay <devnull+Frank.Li.nxp.com@kernel.org>
Date: Wed, 09 Jul 2025 17:02:16 -0400
Subject: [PATCH v20 4/9] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-ep-msi-v20-4-43d56f9bd54a@nxp.com>
References: <20250709-ep-msi-v20-0-43d56f9bd54a@nxp.com>
In-Reply-To: <20250709-ep-msi-v20-0-43d56f9bd54a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752094968; l=1452;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5GnLijRH62gBTUdnVBRu9d7hyvLf0+eT6hrBiV+MYG4=;
 b=HvRi8kQvdqnVkTHpFheFfUswDpWAOk2mmjMD4QrLCXKcebMd+wAbQs2SSaRVAXaK81OU/Ydl8
 tj21xJvXeNOCewquYk7BcQpWGKsTS3AIuM60F2BsH0CCcpZXcB8y8uQ
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



