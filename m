Return-Path: <linux-kselftest+bounces-37045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51506B00C03
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 21:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881757B8760
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 19:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F432FE390;
	Thu, 10 Jul 2025 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJDj8mYY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2A52FE36B;
	Thu, 10 Jul 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174839; cv=none; b=XmocBXoHtzSAIYfk6soFW0juCZ5aLgk6ZWhGPtXRYQw7VvryK0MnlPKm9OzAvcNuDse3M/dYoMNyHcRw4D2VijyBAs6zkex8fHqUNZTT9uSx733QF637qCLRUnqX0xrSvu0zEccltVRWOygFGlC2TckMmdMggFW8mozWXc3d080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174839; c=relaxed/simple;
	bh=Q8B1Dku/Ofi9wXT/6+cHHNsu15ChbWIvtmxnF+vBdXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CrM190NTB4hDA8pZEw48+2nUKr20EXYUBppu7oi/I7oOE6rFK5zRrmltmKaT/lqBGbsvfzhZvXT0Knsm+4iPwtUf6sBw1ZEcvQK/F16VTty9AXhS4kt9uQeQCJ9/+svY3PTMx6NiSMhwUxJ8rde+ZR5Qr417ugmGLM6yN0rd7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJDj8mYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33D27C2BCB7;
	Thu, 10 Jul 2025 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752174838;
	bh=Q8B1Dku/Ofi9wXT/6+cHHNsu15ChbWIvtmxnF+vBdXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BJDj8mYYiG6MzngJ9d5Ref1hr8BIUKVfAp+XAgm1gYQ8O5UGw0VVeeX8MXltqs+gc
	 VpcxjRlT18cGReKqxQNGwHxC3rKI3jAurocSq74HEIAHB8zZ1/RDmOJzJU6lYK5wsG
	 qVNQvqcYtFYcNtqk0MKWAs8wdOSKHT5yj1O+S/cQR/PiIQlTob+sGbbBEXI2uKXXEm
	 eGkgX1/Rh6V99+o2JMjirkslxsmNlJ8h+e75y3bpWqAdkY06mlJfxMv9YAE+JdFNh2
	 N/sowlgm2CjkAgNm2ow6vnibFKma6eqJN3t+edG02iaXuBpm5HiOM77h5tmVrDXoIK
	 lw3qvKs3OMN5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ADEC83F1A;
	Thu, 10 Jul 2025 19:13:58 +0000 (UTC)
From: Frank Li via B4 Relay <devnull+Frank.Li.nxp.com@kernel.org>
Date: Thu, 10 Jul 2025 15:13:52 -0400
Subject: [PATCH v21 6/9] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-ep-msi-v21-6-57683fc7fb25@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752174836; l=8374;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=h3fz11rXH/NSr5dAlWLYpR+aWlg/xF+Fa/15kBgdL7U=;
 b=PvcWb4jQzLWifjuXvJSL0yYesAGlfsSnCeHa4xorafY+4p55wcHo720uUJNLyXF9OZFmAT7F9
 Nfy07L3n4ctCugRuwcaUt5Y5DWbkFNtYmv6FYxLXDnj5KgykLQC4F0z
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-Endpoint-Received: by B4 Relay for Frank.Li@nxp.com/20240130 with
 auth_id=121
X-Original-From: Frank Li <Frank.Li@nxp.com>
Reply-To: Frank.Li@nxp.com

From: Frank Li <Frank.Li@nxp.com>

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data. Use
pci_epf_alloc_doorbell() to allocate a doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set STATUS_DOORBELL_SUCCESS in the doorbell callback to indicate
completion.

Avoid breaking compatibility between host and endpoint, add new command
COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL. Host side need send
COMMAND_ENABLE_DOORBELL to map one bar's inbound address to MSI space.
the command COMMAND_DISABLE_DOORBELL to recovery original inbound address
mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pci_endpoint_test -f pcie_ep_doorbell' return
success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pci_endpoint_test -f pcie_ep_doorbell' return failure, other case as
usual.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
changes in v20
- simple error handle by goto
- remove unecessary check
- remove Tested-by: Niklas Cassel <cassel@kernel.org>

change from v15 to v16
- use le32 for doorbell_* register and use cpu_to_le32() and le32_to_cpu()
when use it.

change from v14 to v15
- none

Change from v9 to v14
- update commit message by use pci_endpoint_test -f pcie_ep_doorbell

Change from v8 to v9
- move pci_epf_alloc_doorbell() into pci_epf_{enable/disable}_doorbell().
- remove doorbell_done in commit message.
- rename pci_epf_{enable/disable}_doorbell() to
pci_epf_test_{enable/disable}_doorbell() to align corrent code style.

Change from v7 to v8
- rename to pci_epf_align_inbound_addr_lo_hi()

Change from v6 to v7
- use help function pci_epf_align_addr_lo_hi()

Change from v5 to v6
- rename doorbell_addr to doorbell_offset

Chagne from v4 to v5
- Add doorbell free at unbind function.
- Move msi irq handler to here to more complex user case, such as differece
doorbell can use difference handler function.
- Add Niklas's code to handle fixed bar's case. If need add your signed-off
tag or co-developer tag, please let me know.

change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 136 ++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 50eb4106369f41afa00ed3ae58c84922e0a49e51..dfdd25cfc003948fbb54a4313f1759994e67df99 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -66,6 +75,7 @@ struct pci_epf_test {
 	bool			dma_supported;
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
+	struct pci_epf_bar	db_bar;
 };
 
 struct pci_epf_test_reg {
@@ -80,6 +90,9 @@ struct pci_epf_test_reg {
 	__le32 irq_number;
 	__le32 flags;
 	__le32 caps;
+	__le32 doorbell_bar;
+	__le32 doorbell_offset;
+	__le32 doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -667,6 +680,121 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	u32 status = le32_to_cpu(reg->status);
+
+	status |= STATUS_DOORBELL_SUCCESS;
+	reg->status = cpu_to_le32(status);
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return IRQ_HANDLED;
+}
+
+static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
+{
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
+	struct pci_epf *epf = epf_test->epf;
+
+	free_irq(epf->db_msg[0].virq, epf_test);
+	reg->doorbell_bar = cpu_to_le32(NO_BAR);
+
+	pci_epf_free_doorbell(epf);
+}
+
+static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
+					 struct pci_epf_test_reg *reg)
+{
+	u32 status = le32_to_cpu(reg->status);
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct msi_msg *msg;
+	enum pci_barno bar;
+	size_t offset;
+	int ret;
+
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (ret)
+		goto set_status_err;
+
+	msg = &epf->db_msg[0].msg;
+	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
+	if (bar < BAR_0)
+		goto err_doorbell;
+
+	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+			  "pci-ep-test-doorbell", epf_test);
+	if (ret) {
+		dev_err(&epf->dev,
+			"Failed to request doorbell IRQ: %d\n",
+			epf->db_msg[0].virq);
+		goto err_doorbell;
+	}
+
+	reg->doorbell_data = cpu_to_le32(msg->data);
+	reg->doorbell_bar = cpu_to_le32(bar);
+
+	msg = &epf->db_msg[0].msg;
+	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
+					 &epf_test->db_bar.phys_addr, &offset);
+
+	if (ret)
+		goto err_doorbell;
+
+	reg->doorbell_offset = cpu_to_le32(offset);
+
+	epf_test->db_bar.barno = bar;
+	epf_test->db_bar.size = epf->bar[bar].size;
+	epf_test->db_bar.flags = epf->bar[bar].flags;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+	if (ret)
+		goto err_doorbell_set_bar;
+
+	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	reg->status = cpu_to_le32(status);
+	return;
+
+err_doorbell_set_bar:
+	pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+err_doorbell:
+	pci_epf_test_doorbell_cleanup(epf_test);
+set_status_err:
+	status |= STATUS_DOORBELL_ENABLE_FAIL;
+	reg->status = cpu_to_le32(status);
+}
+
+static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
+					  struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = le32_to_cpu(reg->doorbell_bar);
+	u32 status = le32_to_cpu(reg->status);
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0)
+		goto set_status_err;
+
+	pci_epf_test_doorbell_cleanup(epf_test);
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		goto set_status_err;
+
+	status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+	reg->status = cpu_to_le32(status);
+
+	return;
+
+set_status_err:
+	status |= STATUS_DOORBELL_DISABLE_FAIL;
+	reg->status = cpu_to_le32(status);
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -714,6 +842,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_test_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_test_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;

-- 
2.34.1



