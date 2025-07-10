Return-Path: <linux-kselftest+bounces-37044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C766AB00BFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 21:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1311764BCA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 19:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720182FE387;
	Thu, 10 Jul 2025 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTvVuHo+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2202FE36A;
	Thu, 10 Jul 2025 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174839; cv=none; b=fwsDXcm30cjtmCkySaUclS5iatl9S9DQ8y2Q5K/DSaAMcdGYOkVF7nYJpOvAL6gvTjZiPrX02TVLYuEESldj/iovh1hEOdQzGylXn6rqK63DaJ4w8pWKNvdA0JukbB/pc5O5XdjG7bI1obWPdVKcPj4g3dxiCsE205Izb6RgtrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174839; c=relaxed/simple;
	bh=ZhOpD4uE06bSl49Vy//uqz1o4AjQqGjxPfMTgkddWP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elHxgQp3LCWCu7rQ/VJVHh6LhdE8mr2QmucSmIkzOY5FO7g+mfAautQ7ij9bYsnn5xobg9BA94cGvU7unLPGMm+neVz7Ih7B8ygWiHHVbU08vv+jBvevyBdvBiKTmn6odLElt3y9neMnIJ3GjnbVMq6jF3eHJtUn30JUnv6DYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTvVuHo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54B29C2BCFA;
	Thu, 10 Jul 2025 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752174838;
	bh=ZhOpD4uE06bSl49Vy//uqz1o4AjQqGjxPfMTgkddWP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VTvVuHo+1QMcjvL4lBbivogileoz7xkPn/yJXZj0/lXYh8qolGRjMdO1EO9t3zf92
	 y05YYQDWvXbR2e7irt2TW1f3ncn65Fv9G7798JMHugJ0ueZrR0Jr7YnoFQshj55il/
	 cOTPVj7wQ80ChmxA8qrTUzfQ7gXKs3wsRbXWkbugtEeCtsM0gPGvyC+XM9UmarQtvw
	 ANLAXDQ/Co5x+H/Maxl5IhfbrhtJ4TrPQFHppDnj1DsU9bzBiNs19dumB2z6+WmRyd
	 SW9+tAgSMdvTr2ZBzRXbLxznC1r0XUQdBEwOl1F8YZSlETcy/izs5C2Tt3wKp+arcD
	 BT4B9SJldw7kg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A59BC83F21;
	Thu, 10 Jul 2025 19:13:58 +0000 (UTC)
From: Frank Li via B4 Relay <devnull+Frank.Li.nxp.com@kernel.org>
Date: Thu, 10 Jul 2025 15:13:54 -0400
Subject: [PATCH v21 8/9] selftests: pci_endpoint: Add doorbell test case
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-ep-msi-v21-8-57683fc7fb25@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752174836; l=2413;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DF/gzaI0MKU27j4SEtbbhXRg9y3PEJqjIqoano8U714=;
 b=6FIBzlhLvKK9PMtRFgv9fQ0u15RhOYaMaf9U560iK36vP7lgw6gVapL02c73Pu/nxmQww9moK
 MkPvMxbACpZBtrbLyQv46qo1NUMvbpVFKhdkfpsbE14aoTCK68v2+Op
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-Endpoint-Received: by B4 Relay for Frank.Li@nxp.com/20240130 with
 auth_id=121
X-Original-From: Frank Li <Frank.Li@nxp.com>
Reply-To: Frank.Li@nxp.com

From: Frank Li <Frank.Li@nxp.com>

Add doorbell test case.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v20
- update document

change from v14 to v16
- Add set IRQ type

change from v13 to v14
- merge to selftests framework
---
 Documentation/PCI/endpoint/pci-test-howto.rst      | 14 +++++++++++
 .../selftests/pci_endpoint/pci_endpoint_test.c     | 28 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/PCI/endpoint/pci-test-howto.rst b/Documentation/PCI/endpoint/pci-test-howto.rst
index aafc17ef3fd31f6ada38c82c8df133b87f7a1ae1..0cee35dcb29cc938823de53ef6e1a1cd81d49d52 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.rst
+++ b/Documentation/PCI/endpoint/pci-test-howto.rst
@@ -203,3 +203,17 @@ controllers, it is advisable to skip this testcase using this
 command::
 
 	# pci_endpoint_test -f pci_ep_bar -f pci_ep_basic -v memcpy -T COPY_TEST -v dma
+
+Kselftest EP Doorbell
+~~~~~~~~~~~~~~~~~~~~~
+
+If EP side have MSI controller, run below command to test doorbell function.
+
+	# pci_endpoint_test -f pcie_ep_doorbell
+
+	# Starting 1 tests from 1 test cases.
+	#  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
+	#            OK  pcie_ep_doorbell.DOORBELL_TEST
+	ok 1 pcie_ep_doorbell.DOORBELL_TEST
+	# PASSED: 1 / 1 tests passed.
+	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index ac26481d29d9dce5d07de563048850c55c58c22d..da0db0e7c9693f11b4975ca0e6830174229983ba 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -229,4 +229,32 @@ TEST_F(pci_ep_data_transfer, COPY_TEST)
 					 test_size[i]);
 	}
 }
+
+FIXTURE(pcie_ep_doorbell)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(pcie_ep_doorbell)
+{
+	self->fd = open(test_device, O_RDWR);
+
+	ASSERT_NE(-1, self->fd) TH_LOG("Can't open PCI Endpoint Test device");
+};
+
+FIXTURE_TEARDOWN(pcie_ep_doorbell)
+{
+	close(self->fd);
+};
+
+TEST_F(pcie_ep_doorbell, DOORBELL_TEST)
+{
+	int ret;
+
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
+
+	pci_ep_ioctl(PCITEST_DOORBELL, 0);
+	EXPECT_FALSE(ret) TH_LOG("Test failed for Doorbell\n");
+}
 TEST_HARNESS_MAIN

-- 
2.34.1



