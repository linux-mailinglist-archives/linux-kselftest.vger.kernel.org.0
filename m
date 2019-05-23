Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F032D28D10
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 00:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbfEWWbP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 18:31:15 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60022 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388531AbfEWWbO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 18:31:14 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hTwEs-00062T-Ew; Thu, 23 May 2019 16:31:12 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hTwEq-0001SK-Bk; Thu, 23 May 2019 16:31:04 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 23 May 2019 16:30:57 -0600
Message-Id: <20190523223100.5526-8-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523223100.5526-1-logang@deltatee.com>
References: <20190523223100.5526-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, jdmason@kudzu.us, joro@8bytes.org, bhelgaas@google.com, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH v5 07/10] NTB: Introduce NTB MSI Test Client
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce a tool to test NTB MSI interrupts similar to the other
NTB test tools. This tool creates a debugfs directory for each
NTB device with the following files:

port
irqX_occurrences
peerX/port
peerX/count
peerX/trigger

The 'port' file tells the user the local port number and the
'occurrences' files tell the number of local interrupts that
have been received for each interrupt.

For each peer, the 'port' file and the 'count' file tell you the
peer's port number and number of interrupts respectively. Writing
the interrupt number to the 'trigger' file triggers the interrupt
handler for the peer which should increment their corresponding
'occurrences' file. The 'ready' file indicates if a peer is ready,
writing to this file blocks until it is ready.

The module parameter num_irqs can be used to set the number of
local interrupts. By default this is 4. This is only limited by
the number of unused MSI interrupts registered by the hardware
(this will require support of the hardware driver) and there must
be at least 2*num_irqs + 1 spads registers available.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
---
 drivers/ntb/test/Kconfig        |   9 +
 drivers/ntb/test/Makefile       |   1 +
 drivers/ntb/test/ntb_msi_test.c | 433 ++++++++++++++++++++++++++++++++
 3 files changed, 443 insertions(+)
 create mode 100644 drivers/ntb/test/ntb_msi_test.c

diff --git a/drivers/ntb/test/Kconfig b/drivers/ntb/test/Kconfig
index a5d0eda44438..a3f3e2638935 100644
--- a/drivers/ntb/test/Kconfig
+++ b/drivers/ntb/test/Kconfig
@@ -25,3 +25,12 @@ config NTB_PERF
 	 to and from the window without additional software interaction.
 
 	 If unsure, say N.
+
+config NTB_MSI_TEST
+	tristate "NTB MSI Test Client"
+	depends on NTB_MSI
+	help
+	  This tool demonstrates the use of the NTB MSI library to
+	  send MSI interrupts between peers.
+
+	  If unsure, say N.
diff --git a/drivers/ntb/test/Makefile b/drivers/ntb/test/Makefile
index 9e77e0b761c2..d2895ca995e4 100644
--- a/drivers/ntb/test/Makefile
+++ b/drivers/ntb/test/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_NTB_PINGPONG) += ntb_pingpong.o
 obj-$(CONFIG_NTB_TOOL) += ntb_tool.o
 obj-$(CONFIG_NTB_PERF) += ntb_perf.o
+obj-$(CONFIG_NTB_MSI_TEST) += ntb_msi_test.o
diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
new file mode 100644
index 000000000000..99d826ed9c34
--- /dev/null
+++ b/drivers/ntb/test/ntb_msi_test.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+#include <linux/module.h>
+#include <linux/debugfs.h>
+#include <linux/ntb.h>
+#include <linux/pci.h>
+#include <linux/radix-tree.h>
+#include <linux/workqueue.h>
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_VERSION("0.1");
+MODULE_AUTHOR("Logan Gunthorpe <logang@deltatee.com>");
+MODULE_DESCRIPTION("Test for sending MSI interrupts over an NTB memory window");
+
+static int num_irqs = 4;
+module_param(num_irqs, int, 0644);
+MODULE_PARM_DESC(num_irqs, "number of irqs to use");
+
+struct ntb_msit_ctx {
+	struct ntb_dev *ntb;
+	struct dentry *dbgfs_dir;
+	struct work_struct setup_work;
+
+	struct ntb_msit_isr_ctx {
+		int irq_idx;
+		int irq_num;
+		int occurrences;
+		struct ntb_msit_ctx *nm;
+		struct ntb_msi_desc desc;
+	} *isr_ctx;
+
+	struct ntb_msit_peer {
+		struct ntb_msit_ctx *nm;
+		int pidx;
+		int num_irqs;
+		struct completion init_comp;
+		struct ntb_msi_desc *msi_desc;
+	} peers[];
+};
+
+static struct dentry *ntb_msit_dbgfs_topdir;
+
+static irqreturn_t ntb_msit_isr(int irq, void *dev)
+{
+	struct ntb_msit_isr_ctx *isr_ctx = dev;
+	struct ntb_msit_ctx *nm = isr_ctx->nm;
+
+	dev_dbg(&nm->ntb->dev, "Interrupt Occurred: %d",
+		isr_ctx->irq_idx);
+
+	isr_ctx->occurrences++;
+
+	return IRQ_HANDLED;
+}
+
+static void ntb_msit_setup_work(struct work_struct *work)
+{
+	struct ntb_msit_ctx *nm = container_of(work, struct ntb_msit_ctx,
+					       setup_work);
+	int irq_count = 0;
+	int irq;
+	int ret;
+	uintptr_t i;
+
+	ret = ntb_msi_setup_mws(nm->ntb);
+	if (ret) {
+		dev_err(&nm->ntb->dev, "Unable to setup MSI windows: %d\n",
+			ret);
+		return;
+	}
+
+	for (i = 0; i < num_irqs; i++) {
+		nm->isr_ctx[i].irq_idx = i;
+		nm->isr_ctx[i].nm = nm;
+
+		if (!nm->isr_ctx[i].irq_num) {
+			irq = ntbm_msi_request_irq(nm->ntb, ntb_msit_isr,
+						   KBUILD_MODNAME,
+						   &nm->isr_ctx[i],
+						   &nm->isr_ctx[i].desc);
+			if (irq < 0)
+				break;
+
+			nm->isr_ctx[i].irq_num = irq;
+		}
+
+		ret = ntb_spad_write(nm->ntb, 2 * i + 1,
+				     nm->isr_ctx[i].desc.addr_offset);
+		if (ret)
+			break;
+
+		ret = ntb_spad_write(nm->ntb, 2 * i + 2,
+				     nm->isr_ctx[i].desc.data);
+		if (ret)
+			break;
+
+		irq_count++;
+	}
+
+	ntb_spad_write(nm->ntb, 0, irq_count);
+	ntb_peer_db_set(nm->ntb, BIT(ntb_port_number(nm->ntb)));
+}
+
+static void ntb_msit_desc_changed(void *ctx)
+{
+	struct ntb_msit_ctx *nm = ctx;
+	int i;
+
+	dev_dbg(&nm->ntb->dev, "MSI Descriptors Changed\n");
+
+	for (i = 0; i < num_irqs; i++) {
+		ntb_spad_write(nm->ntb, 2 * i + 1,
+			       nm->isr_ctx[i].desc.addr_offset);
+		ntb_spad_write(nm->ntb, 2 * i + 2,
+			       nm->isr_ctx[i].desc.data);
+	}
+
+	ntb_peer_db_set(nm->ntb, BIT(ntb_port_number(nm->ntb)));
+}
+
+static void ntb_msit_link_event(void *ctx)
+{
+	struct ntb_msit_ctx *nm = ctx;
+
+	if (!ntb_link_is_up(nm->ntb, NULL, NULL))
+		return;
+
+	schedule_work(&nm->setup_work);
+}
+
+static void ntb_msit_copy_peer_desc(struct ntb_msit_ctx *nm, int peer)
+{
+	int i;
+	struct ntb_msi_desc *desc = nm->peers[peer].msi_desc;
+	int irq_count = nm->peers[peer].num_irqs;
+
+	for (i = 0; i < irq_count; i++) {
+		desc[i].addr_offset = ntb_peer_spad_read(nm->ntb, peer,
+							 2 * i + 1);
+		desc[i].data = ntb_peer_spad_read(nm->ntb, peer, 2 * i + 2);
+	}
+
+	dev_info(&nm->ntb->dev, "Found %d interrupts on peer %d\n",
+		 irq_count, peer);
+
+	complete_all(&nm->peers[peer].init_comp);
+}
+
+static void ntb_msit_db_event(void *ctx, int vec)
+{
+	struct ntb_msit_ctx *nm = ctx;
+	struct ntb_msi_desc *desc;
+	u64 peer_mask = ntb_db_read(nm->ntb);
+	u32 irq_count;
+	int peer;
+
+	ntb_db_clear(nm->ntb, peer_mask);
+
+	for (peer = 0; peer < sizeof(peer_mask) * 8; peer++) {
+		if (!(peer_mask & BIT(peer)))
+			continue;
+
+		irq_count = ntb_peer_spad_read(nm->ntb, peer, 0);
+		if (irq_count == -1)
+			continue;
+
+		desc = kcalloc(irq_count, sizeof(*desc), GFP_ATOMIC);
+		if (!desc)
+			continue;
+
+		kfree(nm->peers[peer].msi_desc);
+		nm->peers[peer].msi_desc = desc;
+		nm->peers[peer].num_irqs = irq_count;
+
+		ntb_msit_copy_peer_desc(nm, peer);
+	}
+}
+
+static const struct ntb_ctx_ops ntb_msit_ops = {
+	.link_event = ntb_msit_link_event,
+	.db_event = ntb_msit_db_event,
+};
+
+static int ntb_msit_dbgfs_trigger(void *data, u64 idx)
+{
+	struct ntb_msit_peer *peer = data;
+
+	if (idx >= peer->num_irqs)
+		return -EINVAL;
+
+	dev_dbg(&peer->nm->ntb->dev, "trigger irq %llu on peer %u\n",
+		idx, peer->pidx);
+
+	return ntb_msi_peer_trigger(peer->nm->ntb, peer->pidx,
+				    &peer->msi_desc[idx]);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(ntb_msit_trigger_fops, NULL,
+			 ntb_msit_dbgfs_trigger, "%llu\n");
+
+static int ntb_msit_dbgfs_port_get(void *data, u64 *port)
+{
+	struct ntb_msit_peer *peer = data;
+
+	*port = ntb_peer_port_number(peer->nm->ntb, peer->pidx);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(ntb_msit_port_fops, ntb_msit_dbgfs_port_get,
+			 NULL, "%llu\n");
+
+static int ntb_msit_dbgfs_count_get(void *data, u64 *count)
+{
+	struct ntb_msit_peer *peer = data;
+
+	*count = peer->num_irqs;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(ntb_msit_count_fops, ntb_msit_dbgfs_count_get,
+			 NULL, "%llu\n");
+
+static int ntb_msit_dbgfs_ready_get(void *data, u64 *ready)
+{
+	struct ntb_msit_peer *peer = data;
+
+	*ready = try_wait_for_completion(&peer->init_comp);
+
+	return 0;
+}
+
+static int ntb_msit_dbgfs_ready_set(void *data, u64 ready)
+{
+	struct ntb_msit_peer *peer = data;
+
+	return wait_for_completion_interruptible(&peer->init_comp);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(ntb_msit_ready_fops, ntb_msit_dbgfs_ready_get,
+			 ntb_msit_dbgfs_ready_set, "%llu\n");
+
+static int ntb_msit_dbgfs_occurrences_get(void *data, u64 *occurrences)
+{
+	struct ntb_msit_isr_ctx *isr_ctx = data;
+
+	*occurrences = isr_ctx->occurrences;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(ntb_msit_occurrences_fops,
+			 ntb_msit_dbgfs_occurrences_get,
+			 NULL, "%llu\n");
+
+static int ntb_msit_dbgfs_local_port_get(void *data, u64 *port)
+{
+	struct ntb_msit_ctx *nm = data;
+
+	*port = ntb_port_number(nm->ntb);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(ntb_msit_local_port_fops,
+			 ntb_msit_dbgfs_local_port_get,
+			 NULL, "%llu\n");
+
+static void ntb_msit_create_dbgfs(struct ntb_msit_ctx *nm)
+{
+	struct pci_dev *pdev = nm->ntb->pdev;
+	char buf[32];
+	int i;
+	struct dentry *peer_dir;
+
+	nm->dbgfs_dir = debugfs_create_dir(pci_name(pdev),
+					   ntb_msit_dbgfs_topdir);
+	debugfs_create_file("port", 0400, nm->dbgfs_dir, nm,
+			    &ntb_msit_local_port_fops);
+
+	for (i = 0; i < ntb_peer_port_count(nm->ntb); i++) {
+		nm->peers[i].pidx = i;
+		nm->peers[i].nm = nm;
+		init_completion(&nm->peers[i].init_comp);
+
+		snprintf(buf, sizeof(buf), "peer%d", i);
+		peer_dir = debugfs_create_dir(buf, nm->dbgfs_dir);
+
+		debugfs_create_file_unsafe("trigger", 0200, peer_dir,
+					   &nm->peers[i],
+					   &ntb_msit_trigger_fops);
+
+		debugfs_create_file_unsafe("port", 0400, peer_dir,
+					   &nm->peers[i], &ntb_msit_port_fops);
+
+		debugfs_create_file_unsafe("count", 0400, peer_dir,
+					   &nm->peers[i],
+					   &ntb_msit_count_fops);
+
+		debugfs_create_file_unsafe("ready", 0600, peer_dir,
+					   &nm->peers[i],
+					   &ntb_msit_ready_fops);
+	}
+
+	for (i = 0; i < num_irqs; i++) {
+		snprintf(buf, sizeof(buf), "irq%d_occurrences", i);
+		debugfs_create_file_unsafe(buf, 0400, nm->dbgfs_dir,
+					   &nm->isr_ctx[i],
+					   &ntb_msit_occurrences_fops);
+	}
+}
+
+static void ntb_msit_remove_dbgfs(struct ntb_msit_ctx *nm)
+{
+	debugfs_remove_recursive(nm->dbgfs_dir);
+}
+
+static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
+{
+	struct ntb_msit_ctx *nm;
+	size_t struct_size;
+	int peers;
+	int ret;
+
+	peers = ntb_peer_port_count(ntb);
+	if (peers <= 0)
+		return -EINVAL;
+
+	if (ntb_spad_is_unsafe(ntb) || ntb_spad_count(ntb) < 2 * num_irqs + 1) {
+		dev_err(&ntb->dev, "NTB MSI test requires at least %d spads for %d irqs\n",
+			2 * num_irqs + 1, num_irqs);
+		return -EFAULT;
+	}
+
+	ret = ntb_spad_write(ntb, 0, -1);
+	if (ret) {
+		dev_err(&ntb->dev, "Unable to write spads: %d\n", ret);
+		return ret;
+	}
+
+	ret = ntb_db_clear_mask(ntb, GENMASK(peers - 1, 0));
+	if (ret) {
+		dev_err(&ntb->dev, "Unable to clear doorbell mask: %d\n", ret);
+		return ret;
+	}
+
+	ret = ntb_msi_init(ntb, ntb_msit_desc_changed);
+	if (ret) {
+		dev_err(&ntb->dev, "Unable to initialize MSI library: %d\n",
+			ret);
+		return ret;
+	}
+
+	struct_size = sizeof(*nm) + sizeof(*nm->peers) * peers;
+
+	nm = devm_kzalloc(&ntb->dev, struct_size, GFP_KERNEL);
+	if (!nm)
+		return -ENOMEM;
+
+	nm->isr_ctx = devm_kcalloc(&ntb->dev, num_irqs, sizeof(*nm->isr_ctx),
+				   GFP_KERNEL);
+	if (!nm->isr_ctx)
+		return -ENOMEM;
+
+	INIT_WORK(&nm->setup_work, ntb_msit_setup_work);
+	nm->ntb = ntb;
+
+	ntb_msit_create_dbgfs(nm);
+
+	ret = ntb_set_ctx(ntb, nm, &ntb_msit_ops);
+	if (ret)
+		goto remove_dbgfs;
+
+	if (!nm->isr_ctx)
+		goto remove_dbgfs;
+
+	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
+
+	return 0;
+
+remove_dbgfs:
+	ntb_msit_remove_dbgfs(nm);
+	devm_kfree(&ntb->dev, nm->isr_ctx);
+	devm_kfree(&ntb->dev, nm);
+	return ret;
+}
+
+static void ntb_msit_remove(struct ntb_client *client, struct ntb_dev *ntb)
+{
+	struct ntb_msit_ctx *nm = ntb->ctx;
+	int i;
+
+	ntb_link_disable(ntb);
+	ntb_db_set_mask(ntb, ntb_db_valid_mask(ntb));
+	ntb_msi_clear_mws(ntb);
+
+	for (i = 0; i < ntb_peer_port_count(ntb); i++)
+		kfree(nm->peers[i].msi_desc);
+
+	ntb_clear_ctx(ntb);
+	ntb_msit_remove_dbgfs(nm);
+}
+
+static struct ntb_client ntb_msit_client = {
+	.ops = {
+		.probe = ntb_msit_probe,
+		.remove = ntb_msit_remove
+	}
+};
+
+static int __init ntb_msit_init(void)
+{
+	int ret;
+
+	if (debugfs_initialized())
+		ntb_msit_dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME,
+							   NULL);
+
+	ret = ntb_register_client(&ntb_msit_client);
+	if (ret)
+		debugfs_remove_recursive(ntb_msit_dbgfs_topdir);
+
+	return ret;
+}
+module_init(ntb_msit_init);
+
+static void __exit ntb_msit_exit(void)
+{
+	ntb_unregister_client(&ntb_msit_client);
+	debugfs_remove_recursive(ntb_msit_dbgfs_topdir);
+}
+module_exit(ntb_msit_exit);
-- 
2.20.1

