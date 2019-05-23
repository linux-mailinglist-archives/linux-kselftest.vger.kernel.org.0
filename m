Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC79A28D19
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 00:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbfEWWbd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 18:31:33 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60052 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388537AbfEWWbO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 18:31:14 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hTwEs-00062V-Ex; Thu, 23 May 2019 16:31:12 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hTwEq-0001SQ-IC; Thu, 23 May 2019 16:31:04 -0600
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
Date:   Thu, 23 May 2019 16:30:59 -0600
Message-Id: <20190523223100.5526-10-logang@deltatee.com>
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
Subject: [PATCH v5 09/10] NTB: Add MSI interrupt support to ntb_transport
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce the module parameter 'use_msi' which, when set, uses
MSI interrupts instead of doorbells for each queue pair (QP). The
parameter is only available if NTB MSI support is configured into
the kernel. We also require there to be more than one memory window
(MW) so that an extra one is available to forward the APIC region.

To use MSIs, we request one interrupt per QP and forward the MSI address
and data to the peer using scratch pad registers (SPADS) above the MW
SPADS. (If there are not enough SPADS the MSI interrupt will not be used.)

Once registered, we simply use ntb_msi_peer_trigger and the receiving
ISR simply queues up the rxc_db_work for the queue.

This addition can significantly improve performance of ntb_transport.
In a simple, untuned, apples-to-apples comparision using ntb_netdev
and iperf with switchtec hardware, I see 3.88Gb/s without MSI
interrupts and 14.1Gb/s wit MSI, which is a more than 3x improvement.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
---
 drivers/ntb/ntb_transport.c | 169 +++++++++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index d4f39ba1d976..f1cf0942cb99 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -93,6 +93,12 @@ static bool use_dma;
 module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
 
+static bool use_msi;
+#ifdef CONFIG_NTB_MSI
+module_param(use_msi, bool, 0644);
+MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
+#endif
+
 static struct dentry *nt_debugfs_dir;
 
 /* Only two-ports NTB devices are supported */
@@ -188,6 +194,11 @@ struct ntb_transport_qp {
 	u64 tx_err_no_buf;
 	u64 tx_memcpy;
 	u64 tx_async;
+
+	bool use_msi;
+	int msi_irq;
+	struct ntb_msi_desc msi_desc;
+	struct ntb_msi_desc peer_msi_desc;
 };
 
 struct ntb_transport_mw {
@@ -221,6 +232,10 @@ struct ntb_transport_ctx {
 	u64 qp_bitmap;
 	u64 qp_bitmap_free;
 
+	bool use_msi;
+	unsigned int msi_spad_offset;
+	u64 msi_db_mask;
+
 	bool link_is_up;
 	struct delayed_work link_work;
 	struct work_struct link_cleanup;
@@ -667,6 +682,114 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	return 0;
 }
 
+static irqreturn_t ntb_transport_isr(int irq, void *dev)
+{
+	struct ntb_transport_qp *qp = dev;
+
+	tasklet_schedule(&qp->rxc_db_work);
+
+	return IRQ_HANDLED;
+}
+
+static void ntb_transport_setup_qp_peer_msi(struct ntb_transport_ctx *nt,
+					    unsigned int qp_num)
+{
+	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
+	int spad = qp_num * 2 + nt->msi_spad_offset;
+
+	if (!nt->use_msi)
+		return;
+
+	if (spad >= ntb_spad_count(nt->ndev))
+		return;
+
+	qp->peer_msi_desc.addr_offset =
+		ntb_peer_spad_read(qp->ndev, PIDX, spad);
+	qp->peer_msi_desc.data =
+		ntb_peer_spad_read(qp->ndev, PIDX, spad + 1);
+
+	dev_dbg(&qp->ndev->pdev->dev, "QP%d Peer MSI addr=%x data=%x\n",
+		qp_num, qp->peer_msi_desc.addr_offset, qp->peer_msi_desc.data);
+
+	if (qp->peer_msi_desc.addr_offset) {
+		qp->use_msi = true;
+		dev_info(&qp->ndev->pdev->dev,
+			 "Using MSI interrupts for QP%d\n", qp_num);
+	}
+}
+
+static void ntb_transport_setup_qp_msi(struct ntb_transport_ctx *nt,
+				       unsigned int qp_num)
+{
+	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
+	int spad = qp_num * 2 + nt->msi_spad_offset;
+	int rc;
+
+	if (!nt->use_msi)
+		return;
+
+	if (spad >= ntb_spad_count(nt->ndev)) {
+		dev_warn_once(&qp->ndev->pdev->dev,
+			      "Not enough SPADS to use MSI interrupts\n");
+		return;
+	}
+
+	ntb_spad_write(qp->ndev, spad, 0);
+	ntb_spad_write(qp->ndev, spad + 1, 0);
+
+	if (!qp->msi_irq) {
+		qp->msi_irq = ntbm_msi_request_irq(qp->ndev, ntb_transport_isr,
+						   KBUILD_MODNAME, qp,
+						   &qp->msi_desc);
+		if (qp->msi_irq < 0) {
+			dev_warn(&qp->ndev->pdev->dev,
+				 "Unable to allocate MSI interrupt for qp%d\n",
+				 qp_num);
+			return;
+		}
+	}
+
+	rc = ntb_spad_write(qp->ndev, spad, qp->msi_desc.addr_offset);
+	if (rc)
+		goto err_free_interrupt;
+
+	rc = ntb_spad_write(qp->ndev, spad + 1, qp->msi_desc.data);
+	if (rc)
+		goto err_free_interrupt;
+
+	dev_dbg(&qp->ndev->pdev->dev, "QP%d MSI %d addr=%x data=%x\n",
+		qp_num, qp->msi_irq, qp->msi_desc.addr_offset,
+		qp->msi_desc.data);
+
+	return;
+
+err_free_interrupt:
+	devm_free_irq(&nt->ndev->dev, qp->msi_irq, qp);
+}
+
+static void ntb_transport_msi_peer_desc_changed(struct ntb_transport_ctx *nt)
+{
+	int i;
+
+	dev_dbg(&nt->ndev->pdev->dev, "Peer MSI descriptors changed");
+
+	for (i = 0; i < nt->qp_count; i++)
+		ntb_transport_setup_qp_peer_msi(nt, i);
+}
+
+static void ntb_transport_msi_desc_changed(void *data)
+{
+	struct ntb_transport_ctx *nt = data;
+	int i;
+
+	dev_dbg(&nt->ndev->pdev->dev, "MSI descriptors changed");
+
+	for (i = 0; i < nt->qp_count; i++)
+		ntb_transport_setup_qp_msi(nt, i);
+
+	ntb_peer_db_set(nt->ndev, nt->msi_db_mask);
+}
+
 static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
@@ -905,6 +1028,20 @@ static void ntb_transport_link_work(struct work_struct *work)
 	int rc = 0, i, spad;
 
 	/* send the local info, in the opposite order of the way we read it */
+
+	if (nt->use_msi) {
+		rc = ntb_msi_setup_mws(ndev);
+		if (rc) {
+			dev_warn(&pdev->dev,
+				 "Failed to register MSI memory window: %d\n",
+				 rc);
+			nt->use_msi = false;
+		}
+	}
+
+	for (i = 0; i < nt->qp_count; i++)
+		ntb_transport_setup_qp_msi(nt, i);
+
 	for (i = 0; i < nt->mw_count; i++) {
 		size = nt->mw_vec[i].phys_size;
 
@@ -962,6 +1099,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
 		ntb_transport_setup_qp_mw(nt, i);
+		ntb_transport_setup_qp_peer_msi(nt, i);
 
 		if (qp->client_ready)
 			schedule_delayed_work(&qp->link_work, 0);
@@ -1135,6 +1273,19 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		return -ENOMEM;
 
 	nt->ndev = ndev;
+
+	/*
+	 * If we are using MSI, and have at least one extra memory window,
+	 * we will reserve the last MW for the MSI window.
+	 */
+	if (use_msi && mw_count > 1) {
+		rc = ntb_msi_init(ndev, ntb_transport_msi_desc_changed);
+		if (!rc) {
+			mw_count -= 1;
+			nt->use_msi = true;
+		}
+	}
+
 	spad_count = ntb_spad_count(ndev);
 
 	/* Limit the MW's based on the availability of scratchpads */
@@ -1148,6 +1299,8 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	max_mw_count_for_spads = (spad_count - MW0_SZ_HIGH) / 2;
 	nt->mw_count = min(mw_count, max_mw_count_for_spads);
 
+	nt->msi_spad_offset = nt->mw_count * 2 + MW0_SZ_HIGH;
+
 	nt->mw_vec = kcalloc_node(mw_count, sizeof(*nt->mw_vec),
 				  GFP_KERNEL, node);
 	if (!nt->mw_vec) {
@@ -1178,6 +1331,12 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	qp_bitmap = ntb_db_valid_mask(ndev);
 
 	qp_count = ilog2(qp_bitmap);
+	if (nt->use_msi) {
+		qp_count -= 1;
+		nt->msi_db_mask = 1 << qp_count;
+		ntb_db_clear_mask(ndev, nt->msi_db_mask);
+	}
+
 	if (max_num_clients && max_num_clients < qp_count)
 		qp_count = max_num_clients;
 	else if (nt->mw_count < qp_count)
@@ -1601,7 +1760,10 @@ static void ntb_tx_copy_callback(void *data,
 
 	iowrite32(entry->flags | DESC_DONE_FLAG, &hdr->flags);
 
-	ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
+	if (qp->use_msi)
+		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
+	else
+		ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
 
 	/* The entry length can only be zero if the packet is intended to be a
 	 * "link down" or similar.  Since no payload is being sent in these
@@ -2268,6 +2430,11 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
 	u64 db_bits;
 	unsigned int qp_num;
 
+	if (ntb_db_read(nt->ndev) & nt->msi_db_mask) {
+		ntb_transport_msi_peer_desc_changed(nt);
+		ntb_db_clear(nt->ndev, nt->msi_db_mask);
+	}
+
 	db_bits = (nt->qp_bitmap & ~nt->qp_bitmap_free &
 		   ntb_db_vector_mask(nt->ndev, vector));
 
-- 
2.20.1

