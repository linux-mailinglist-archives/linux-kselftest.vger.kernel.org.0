Return-Path: <linux-kselftest+bounces-36890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E1AFF395
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 23:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898E1567996
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF54E2586CE;
	Wed,  9 Jul 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNqZPwwF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E62528E1;
	Wed,  9 Jul 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094971; cv=none; b=mu3FO+UgB1e1eXhUG4gipBcYPOjsMkTg2mf7ygNLpluabSyU8JZZEdnX4Axrb1Oxpgy6ZGJJKKBaL7NpPCwuadyepVuv84VPIZuw8P/fqluAYfgqGGk66myy7+grKnMzLksHudgDnOySPBt1Dqvl6+yJUogZqxGZVbTy3qqtyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094971; c=relaxed/simple;
	bh=ZhOpD4uE06bSl49Vy//uqz1o4AjQqGjxPfMTgkddWP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aYUyvqRCIA1Dn00QTMI5hgmNQufYe1/oFtVM/oVsDftpDTUQeOVtm604ihsBYxbwEr+IUDC4DqddgTObPZLCBD+iUo3j8yD68cppCKo6vfIBwGKXRMEf6DAVnw6yMSDg7/cn8lVli0VM5/KZQXxafmuFUxY4eqT8gJ4Jr24kooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNqZPwwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0186C4CEF4;
	Wed,  9 Jul 2025 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752094970;
	bh=ZhOpD4uE06bSl49Vy//uqz1o4AjQqGjxPfMTgkddWP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KNqZPwwFz684W2wPS+PjJuhnS/W4TE8vkqqAyGZaynUqWToZcKV34tpW4Xz0jjVsp
	 hH8DFlp1lRI4eV+FnVimzRCX5+s8yG3hN8Axn09k5KZNKhHEhBT8f5XLUz04N+WK8p
	 ETP7/9ZINBCj7g1SHtiXX1drGFkTG0ZsAt90QpDeNwhr3MKDRPjQhAfOdeE4m0ocrt
	 jP1szQX6q0yAwGS6MwYQ+t0YqpiXUSq8mGbLdsynO7JM+dWf94zShdgELnDLtd3AGX
	 /f/RhI+YeS0D92mcC2I8N6JnVhcuXkYGstd+QCd5LuKfyK0lPRsw27alRhQkSrF9st
	 e0heJEPtWCIhQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11EEC83F18;
	Wed,  9 Jul 2025 21:02:50 +0000 (UTC)
From: Frank Li via B4 Relay <devnull+Frank.Li.nxp.com@kernel.org>
Date: Wed, 09 Jul 2025 17:02:20 -0400
Subject: [PATCH v20 8/9] selftests: pci_endpoint: Add doorbell test case
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-ep-msi-v20-8-43d56f9bd54a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752094968; l=2413;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DF/gzaI0MKU27j4SEtbbhXRg9y3PEJqjIqoano8U714=;
 b=a6gnp8u8O795/R0p6ZjiJhEZA5Qk09eT8q9NFI2+fCPfzc1F/KrDN6Ov4sdeNa2sfEKPQH5Wz
 sUKXPYdiqrcCtzdhAnea1XzTNhJ6/G+CWFkrildTnmpbPr/23Dp9+MG
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



