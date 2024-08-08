Return-Path: <linux-kselftest+bounces-15032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED99294BDD1
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 14:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF231F21A95
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 12:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192418DF7F;
	Thu,  8 Aug 2024 12:43:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDA18C92E;
	Thu,  8 Aug 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120989; cv=none; b=jnpCG/B0iceBQMR2fK9FQZNfLCd8MoX9z0UdxNVyC2dTlnDJNXOeoLKKDnmgNouShm5OiHTaMXqCZIaNkx4LYHipLUwH8YLtj5DLAzwf1sDdytKXdjeWkBkcDAydh45bv673di14EZUP68yTiGTkkPRxM3Xcm1ijMv+dv+vePME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120989; c=relaxed/simple;
	bh=USC0Noa3yXLEkQj+LYxHJq++lZLR65WRuj6ejkWV9Yk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpGlRvyokKYTno4UCGN9icQWS9XMyjHHbnNPOm9Fhevog+hj0f/2HxqJZa4b8Jh0n3VfMPdURk8HbWNc284rIiqX5xKJ/y35CyOMePwwoAzlWTSdOoH9sf4EWUhFk62dkcgtVGMmR6ptIlBIjixZoqeIVf2dehXo/Ojalpt02DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wfmqw020fz1xtyH;
	Thu,  8 Aug 2024 20:41:16 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B9FCA1A0188;
	Thu,  8 Aug 2024 20:43:04 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 20:43:04 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>, Chuck Lever
	<chuck.lever@oracle.com>, Sagi Grimberg <sagi@grimberg.me>, Jeroen de Borst
	<jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>, Eric Dumazet <edumazet@google.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Felix Fietkau
	<nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
	<Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Chaitanya
 Kulkarni <kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, David Howells <dhowells@redhat.com>, Marc Dionne
	<marc.dionne@auristor.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown
	<neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
	<trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Shuah Khan
	<shuah@kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-nvme@lists.infradead.org>, <kvm@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-mm@kvack.org>,
	<bpf@vger.kernel.org>, <linux-afs@lists.infradead.org>,
	<linux-nfs@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v13 04/14] mm: page_frag: add '_va' suffix to page_frag API
Date: Thu, 8 Aug 2024 20:37:04 +0800
Message-ID: <20240808123714.462740-5-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240808123714.462740-1-linyunsheng@huawei.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Currently the page_frag API is returning 'virtual address'
or 'va' when allocing and expecting 'virtual address' or
'va' as input when freeing.

As we are about to support new use cases that the caller
need to deal with 'struct page' or need to deal with both
'va' and 'struct page'. In order to differentiate the API
handling between 'va' and 'struct page', add '_va' suffix
to the corresponding API mirroring the page_pool_alloc_va()
API of the page_pool. So that callers expecting to deal with
va, page or both va and page may call page_frag_alloc_va*,
page_frag_alloc_pg*, or page_frag_alloc* API accordingly.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/net/ethernet/google/gve/gve_rx.c      |  4 ++--
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  2 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  4 ++--
 .../marvell/octeontx2/nic/otx2_common.c       |  2 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c    |  4 ++--
 drivers/nvme/host/tcp.c                       |  8 +++----
 drivers/nvme/target/tcp.c                     | 22 +++++++++----------
 drivers/vhost/net.c                           |  6 ++---
 include/linux/page_frag_cache.h               | 21 +++++++++---------
 include/linux/skbuff.h                        |  2 +-
 kernel/bpf/cpumap.c                           |  2 +-
 mm/page_frag_cache.c                          | 12 +++++-----
 net/core/skbuff.c                             | 16 +++++++-------
 net/core/xdp.c                                |  2 +-
 net/rxrpc/txbuf.c                             | 15 +++++++------
 net/sunrpc/svcsock.c                          |  6 ++---
 .../selftests/mm/page_frag/page_frag_test.c   | 13 ++++++-----
 19 files changed, 75 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index acb73d4d0de6..b6c10100e462 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -729,7 +729,7 @@ static int gve_xdp_redirect(struct net_device *dev, struct gve_rx_ring *rx,
 
 	total_len = headroom + SKB_DATA_ALIGN(len) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	frame = page_frag_alloc(&rx->page_cache, total_len, GFP_ATOMIC);
+	frame = page_frag_alloc_va(&rx->page_cache, total_len, GFP_ATOMIC);
 	if (!frame) {
 		u64_stats_update_begin(&rx->statss);
 		rx->xdp_alloc_fails++;
@@ -742,7 +742,7 @@ static int gve_xdp_redirect(struct net_device *dev, struct gve_rx_ring *rx,
 
 	err = xdp_do_redirect(dev, &new, xdp_prog);
 	if (err)
-		page_frag_free(frame);
+		page_frag_free_va(frame);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8d25b6981269..00c706de2b82 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -126,7 +126,7 @@ ice_unmap_and_free_tx_buf(struct ice_tx_ring *ring, struct ice_tx_buf *tx_buf)
 		dev_kfree_skb_any(tx_buf->skb);
 		break;
 	case ICE_TX_BUF_XDP_TX:
-		page_frag_free(tx_buf->raw_buf);
+		page_frag_free_va(tx_buf->raw_buf);
 		break;
 	case ICE_TX_BUF_XDP_XMIT:
 		xdp_return_frame(tx_buf->xdpf);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index feba314a3fe4..6379f57d8228 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -148,7 +148,7 @@ static inline int ice_skb_pad(void)
  * @ICE_TX_BUF_DUMMY: dummy Flow Director packet, unmap and kfree()
  * @ICE_TX_BUF_FRAG: mapped skb OR &xdp_buff frag, only unmap DMA
  * @ICE_TX_BUF_SKB: &sk_buff, unmap and consume_skb(), update stats
- * @ICE_TX_BUF_XDP_TX: &xdp_buff, unmap and page_frag_free(), stats
+ * @ICE_TX_BUF_XDP_TX: &xdp_buff, unmap and page_frag_free_va(), stats
  * @ICE_TX_BUF_XDP_XMIT: &xdp_frame, unmap and xdp_return_frame(), stats
  * @ICE_TX_BUF_XSK_TX: &xdp_buff on XSk queue, xsk_buff_free(), stats
  */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 2719f0e20933..a1a41a14df0d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -250,7 +250,7 @@ ice_clean_xdp_tx_buf(struct device *dev, struct ice_tx_buf *tx_buf,
 
 	switch (tx_buf->type) {
 	case ICE_TX_BUF_XDP_TX:
-		page_frag_free(tx_buf->raw_buf);
+		page_frag_free_va(tx_buf->raw_buf);
 		break;
 	case ICE_TX_BUF_XDP_XMIT:
 		xdp_return_frame_bulk(tx_buf->xdpf, bq);
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 149911e3002a..eef16a909f85 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -302,7 +302,7 @@ static bool ixgbevf_clean_tx_irq(struct ixgbevf_q_vector *q_vector,
 
 		/* free the skb */
 		if (ring_is_xdp(tx_ring))
-			page_frag_free(tx_buffer->data);
+			page_frag_free_va(tx_buffer->data);
 		else
 			napi_consume_skb(tx_buffer->skb, napi_budget);
 
@@ -2412,7 +2412,7 @@ static void ixgbevf_clean_tx_ring(struct ixgbevf_ring *tx_ring)
 
 		/* Free all the Tx ring sk_buffs */
 		if (ring_is_xdp(tx_ring))
-			page_frag_free(tx_buffer->data);
+			page_frag_free_va(tx_buffer->data);
 		else
 			dev_kfree_skb_any(tx_buffer->skb);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 87d5776e3b88..a485e988fa1d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -553,7 +553,7 @@ static int __otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 	*dma = dma_map_single_attrs(pfvf->dev, buf, pool->rbsize,
 				    DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
 	if (unlikely(dma_mapping_error(pfvf->dev, *dma))) {
-		page_frag_free(buf);
+		page_frag_free_va(buf);
 		return -ENOMEM;
 	}
 
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.c b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
index 7063c78bd35f..c4228719f8a4 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
@@ -142,8 +142,8 @@ mtk_wed_wo_queue_refill(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q,
 		dma_addr_t addr;
 		void *buf;
 
-		buf = page_frag_alloc(&q->cache, q->buf_size,
-				      GFP_ATOMIC | GFP_DMA32);
+		buf = page_frag_alloc_va(&q->cache, q->buf_size,
+					 GFP_ATOMIC | GFP_DMA32);
 		if (!buf)
 			break;
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a2a47d3ab99f..86906bc505de 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -506,7 +506,7 @@ static void nvme_tcp_exit_request(struct blk_mq_tag_set *set,
 {
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
-	page_frag_free(req->pdu);
+	page_frag_free_va(req->pdu);
 }
 
 static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
@@ -520,7 +520,7 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
-	req->pdu = page_frag_alloc(&queue->pf_cache,
+	req->pdu = page_frag_alloc_va(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
 	if (!req->pdu)
@@ -1337,7 +1337,7 @@ static void nvme_tcp_free_async_req(struct nvme_tcp_ctrl *ctrl)
 {
 	struct nvme_tcp_request *async = &ctrl->async_req;
 
-	page_frag_free(async->pdu);
+	page_frag_free_va(async->pdu);
 }
 
 static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
@@ -1346,7 +1346,7 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
-	async->pdu = page_frag_alloc(&queue->pf_cache,
+	async->pdu = page_frag_alloc_va(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
 	if (!async->pdu)
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5bff0d5464d1..560df3db2f82 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1463,24 +1463,24 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	c->queue = queue;
 	c->req.port = queue->port->nport;
 
-	c->cmd_pdu = page_frag_alloc(&queue->pf_cache,
+	c->cmd_pdu = page_frag_alloc_va(&queue->pf_cache,
 			sizeof(*c->cmd_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
 	if (!c->cmd_pdu)
 		return -ENOMEM;
 	c->req.cmd = &c->cmd_pdu->cmd;
 
-	c->rsp_pdu = page_frag_alloc(&queue->pf_cache,
+	c->rsp_pdu = page_frag_alloc_va(&queue->pf_cache,
 			sizeof(*c->rsp_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
 	if (!c->rsp_pdu)
 		goto out_free_cmd;
 	c->req.cqe = &c->rsp_pdu->cqe;
 
-	c->data_pdu = page_frag_alloc(&queue->pf_cache,
+	c->data_pdu = page_frag_alloc_va(&queue->pf_cache,
 			sizeof(*c->data_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
 	if (!c->data_pdu)
 		goto out_free_rsp;
 
-	c->r2t_pdu = page_frag_alloc(&queue->pf_cache,
+	c->r2t_pdu = page_frag_alloc_va(&queue->pf_cache,
 			sizeof(*c->r2t_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
 	if (!c->r2t_pdu)
 		goto out_free_data;
@@ -1495,20 +1495,20 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 
 	return 0;
 out_free_data:
-	page_frag_free(c->data_pdu);
+	page_frag_free_va(c->data_pdu);
 out_free_rsp:
-	page_frag_free(c->rsp_pdu);
+	page_frag_free_va(c->rsp_pdu);
 out_free_cmd:
-	page_frag_free(c->cmd_pdu);
+	page_frag_free_va(c->cmd_pdu);
 	return -ENOMEM;
 }
 
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c)
 {
-	page_frag_free(c->r2t_pdu);
-	page_frag_free(c->data_pdu);
-	page_frag_free(c->rsp_pdu);
-	page_frag_free(c->cmd_pdu);
+	page_frag_free_va(c->r2t_pdu);
+	page_frag_free_va(c->data_pdu);
+	page_frag_free_va(c->rsp_pdu);
+	page_frag_free_va(c->cmd_pdu);
 }
 
 static int nvmet_tcp_alloc_cmds(struct nvmet_tcp_queue *queue)
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f16279351db5..6691fac01e0d 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -686,8 +686,8 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 		return -ENOSPC;
 
 	buflen += SKB_DATA_ALIGN(len + pad);
-	buf = page_frag_alloc_align(&net->pf_cache, buflen, GFP_KERNEL,
-				    SMP_CACHE_BYTES);
+	buf = page_frag_alloc_va_align(&net->pf_cache, buflen, GFP_KERNEL,
+				       SMP_CACHE_BYTES);
 	if (unlikely(!buf))
 		return -ENOMEM;
 
@@ -734,7 +734,7 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 	return 0;
 
 err:
-	page_frag_free(buf);
+	page_frag_free_va(buf);
 	return ret;
 }
 
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index a758cb65a9b3..ef038a07925c 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -9,23 +9,24 @@
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
-void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
-			      gfp_t gfp_mask, unsigned int align_mask);
+void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
+				 unsigned int fragsz, gfp_t gfp_mask,
+				 unsigned int align_mask);
 
-static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
-					  unsigned int fragsz, gfp_t gfp_mask,
-					  unsigned int align)
+static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
+					     unsigned int fragsz,
+					     gfp_t gfp_mask, unsigned int align)
 {
 	WARN_ON_ONCE(!is_power_of_2(align));
-	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
+	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, -align);
 }
 
-static inline void *page_frag_alloc(struct page_frag_cache *nc,
-				    unsigned int fragsz, gfp_t gfp_mask)
+static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
+				       unsigned int fragsz, gfp_t gfp_mask)
 {
-	return __page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
+	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, ~0u);
 }
 
-void page_frag_free(void *addr);
+void page_frag_free_va(void *addr);
 
 #endif
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 7482997c719f..f9f0393e6b12 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3381,7 +3381,7 @@ static inline struct sk_buff *netdev_alloc_skb_ip_align(struct net_device *dev,
 
 static inline void skb_free_frag(void *addr)
 {
-	page_frag_free(addr);
+	page_frag_free_va(addr);
 }
 
 void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask);
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index fbdf5a1aabfe..3b70b6b071b9 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -323,7 +323,7 @@ static int cpu_map_kthread_run(void *data)
 
 			/* Bring struct page memory area to curr CPU. Read by
 			 * build_skb_around via page_is_pfmemalloc(), and when
-			 * freed written by page_frag_free call.
+			 * freed written by page_frag_free_va call.
 			 */
 			prefetchw(page);
 		}
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index c5bc72cf018a..70fb6dead624 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -59,9 +59,9 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
-void *__page_frag_alloc_align(struct page_frag_cache *nc,
-			      unsigned int fragsz, gfp_t gfp_mask,
-			      unsigned int align_mask)
+void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
+				 unsigned int fragsz, gfp_t gfp_mask,
+				 unsigned int align_mask)
 {
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 	unsigned int size = nc->size;
@@ -130,16 +130,16 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 
 	return nc->va + (size - remaining);
 }
-EXPORT_SYMBOL(__page_frag_alloc_align);
+EXPORT_SYMBOL(__page_frag_alloc_va_align);
 
 /*
  * Frees a page fragment allocated out of either a compound or order 0 page.
  */
-void page_frag_free(void *addr)
+void page_frag_free_va(void *addr)
 {
 	struct page *page = virt_to_head_page(addr);
 
 	if (unlikely(put_page_testzero(page)))
 		free_unref_page(page, compound_order(page));
 }
-EXPORT_SYMBOL(page_frag_free);
+EXPORT_SYMBOL(page_frag_free_va);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index de2a044cc665..6cf2c51a34e1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -314,8 +314,8 @@ void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 	fragsz = SKB_DATA_ALIGN(fragsz);
 
 	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
-	data = __page_frag_alloc_align(&nc->page, fragsz,
-				       GFP_ATOMIC | __GFP_NOWARN, align_mask);
+	data = __page_frag_alloc_va_align(&nc->page, fragsz,
+					  GFP_ATOMIC | __GFP_NOWARN, align_mask);
 	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 	return data;
 
@@ -330,9 +330,9 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 		struct page_frag_cache *nc = this_cpu_ptr(&netdev_alloc_cache);
 
 		fragsz = SKB_DATA_ALIGN(fragsz);
-		data = __page_frag_alloc_align(nc, fragsz,
-					       GFP_ATOMIC | __GFP_NOWARN,
-					       align_mask);
+		data = __page_frag_alloc_va_align(nc, fragsz,
+						  GFP_ATOMIC | __GFP_NOWARN,
+						  align_mask);
 	} else {
 		local_bh_disable();
 		data = __napi_alloc_frag_align(fragsz, align_mask);
@@ -751,14 +751,14 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 
 	if (in_hardirq() || irqs_disabled()) {
 		nc = this_cpu_ptr(&netdev_alloc_cache);
-		data = page_frag_alloc(nc, len, gfp_mask);
+		data = page_frag_alloc_va(nc, len, gfp_mask);
 		pfmemalloc = nc->pfmemalloc;
 	} else {
 		local_bh_disable();
 		local_lock_nested_bh(&napi_alloc_cache.bh_lock);
 
 		nc = this_cpu_ptr(&napi_alloc_cache.page);
-		data = page_frag_alloc(nc, len, gfp_mask);
+		data = page_frag_alloc_va(nc, len, gfp_mask);
 		pfmemalloc = nc->pfmemalloc;
 
 		local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
@@ -848,7 +848,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 	} else {
 		len = SKB_HEAD_ALIGN(len);
 
-		data = page_frag_alloc(&nc->page, len, gfp_mask);
+		data = page_frag_alloc_va(&nc->page, len, gfp_mask);
 		pfmemalloc = nc->page.pfmemalloc;
 	}
 	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index bcc5551c6424..7d4e09fb478f 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -387,7 +387,7 @@ void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
 		page_pool_put_full_page(page->pp, page, napi_direct);
 		break;
 	case MEM_TYPE_PAGE_SHARED:
-		page_frag_free(data);
+		page_frag_free_va(data);
 		break;
 	case MEM_TYPE_PAGE_ORDER0:
 		page = virt_to_page(data); /* Assumes order0 page*/
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index c3913d8a50d3..dccb0353ee84 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -33,8 +33,8 @@ struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_t data_
 
 	data_align = umax(data_align, L1_CACHE_BYTES);
 	mutex_lock(&call->conn->tx_data_alloc_lock);
-	buf = page_frag_alloc_align(&call->conn->tx_data_alloc, total, gfp,
-				    data_align);
+	buf = page_frag_alloc_va_align(&call->conn->tx_data_alloc, total, gfp,
+				       data_align);
 	mutex_unlock(&call->conn->tx_data_alloc_lock);
 	if (!buf) {
 		kfree(txb);
@@ -96,17 +96,18 @@ struct rxrpc_txbuf *rxrpc_alloc_ack_txbuf(struct rxrpc_call *call, size_t sack_s
 	if (!txb)
 		return NULL;
 
-	buf = page_frag_alloc(&call->local->tx_alloc,
-			      sizeof(*whdr) + sizeof(*ack) + 1 + 3 + sizeof(*trailer), gfp);
+	buf = page_frag_alloc_va(&call->local->tx_alloc,
+				 sizeof(*whdr) + sizeof(*ack) + 1 + 3 + sizeof(*trailer), gfp);
 	if (!buf) {
 		kfree(txb);
 		return NULL;
 	}
 
 	if (sack_size) {
-		buf2 = page_frag_alloc(&call->local->tx_alloc, sack_size, gfp);
+		buf2 = page_frag_alloc_va(&call->local->tx_alloc, sack_size,
+					  gfp);
 		if (!buf2) {
-			page_frag_free(buf);
+			page_frag_free_va(buf);
 			kfree(txb);
 			return NULL;
 		}
@@ -180,7 +181,7 @@ static void rxrpc_free_txbuf(struct rxrpc_txbuf *txb)
 			  rxrpc_txbuf_free);
 	for (i = 0; i < txb->nr_kvec; i++)
 		if (txb->kvec[i].iov_base)
-			page_frag_free(txb->kvec[i].iov_base);
+			page_frag_free_va(txb->kvec[i].iov_base);
 	kfree(txb);
 	atomic_dec(&rxrpc_nr_txbuf);
 }
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 6b3f01beb294..42d20412c1c3 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1222,8 +1222,8 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	/* The stream record marker is copied into a temporary page
 	 * fragment buffer so that it can be included in rq_bvec.
 	 */
-	buf = page_frag_alloc(&svsk->sk_frag_cache, sizeof(marker),
-			      GFP_KERNEL);
+	buf = page_frag_alloc_va(&svsk->sk_frag_cache, sizeof(marker),
+				 GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 	memcpy(buf, &marker, sizeof(marker));
@@ -1235,7 +1235,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
 		      1 + count, sizeof(marker) + rqstp->rq_res.len);
 	ret = sock_sendmsg(svsk->sk_sock, &msg);
-	page_frag_free(buf);
+	page_frag_free_va(buf);
 	if (ret < 0)
 		return ret;
 	*sentp += ret;
diff --git a/tools/testing/selftests/mm/page_frag/page_frag_test.c b/tools/testing/selftests/mm/page_frag/page_frag_test.c
index 4a009122991e..e522611452c9 100644
--- a/tools/testing/selftests/mm/page_frag/page_frag_test.c
+++ b/tools/testing/selftests/mm/page_frag/page_frag_test.c
@@ -52,7 +52,7 @@ static int page_frag_pop_thread(void *arg)
 
 		if (obj) {
 			nr--;
-			page_frag_free(obj);
+			page_frag_free_va(obj);
 		} else {
 			cond_resched();
 		}
@@ -80,13 +80,16 @@ static int page_frag_push_thread(void *arg)
 		int ret;
 
 		if (test_align) {
-			va = page_frag_alloc_align(&test_frag, test_alloc_len,
-						   GFP_KERNEL, SMP_CACHE_BYTES);
+			va = page_frag_alloc_va_align(&test_frag,
+						      test_alloc_len,
+						      GFP_KERNEL,
+						      SMP_CACHE_BYTES);
 
 			WARN_ONCE((unsigned long)va & (SMP_CACHE_BYTES - 1),
 				  "unaligned va returned\n");
 		} else {
-			va = page_frag_alloc(&test_frag, test_alloc_len, GFP_KERNEL);
+			va = page_frag_alloc_va(&test_frag, test_alloc_len,
+						GFP_KERNEL);
 		}
 
 		if (!va)
@@ -94,7 +97,7 @@ static int page_frag_push_thread(void *arg)
 
 		ret = __ptr_ring_produce(ring, va);
 		if (ret) {
-			page_frag_free(va);
+			page_frag_free_va(va);
 			cond_resched();
 		} else {
 			nr--;
-- 
2.33.0


