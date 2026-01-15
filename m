Return-Path: <linux-kselftest+bounces-49055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCACFD27EFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 20:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCFC5303C294
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCC33D1CDB;
	Thu, 15 Jan 2026 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsNwo3AN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DF63D1CB3
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503581; cv=none; b=sozq+CK9cr8QuAp/pQcnT6TiSVZYPd1NAjY+O9JPOMPpM1iG2/ShaLlJU+kj0PeR3ne2/rQ7VAnxPdoSMtgp36pED1muHTifJ6Ozka/U+5fyTD4thgBLRIIqFdFIoJMJLlFsWZC13gPaYOuWUYjj8cb5qHz1go6RWIgZd/nmXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503581; c=relaxed/simple;
	bh=38iSyjYoEwMzr+nrU6pjXPKBtQ2TX3V1C7DF25i/yc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXVAT6+eZHh9+f+jBhZcNcdzT7Y6wjIbpqi9Bjr4ZH/ai21HEUDBqeiPB2vnzE7pSpRA5Vopap+BrLGOV1d6irUPW8U1bTVdUKDK53cO/jdEwl7ZkzGwFXW4jD1ODEJnBamSa1gJuMoGDUTxMl8Y/5FbgsE8/TOjGp1oR6edzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsNwo3AN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso2197798a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 10:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503576; x=1769108376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW47JMUnnrn3JGaUjgMVWNTwCOKFTT/lQ2uvrJQBiv0=;
        b=GsNwo3ANpuopCwQ6Mq6G2Xi4EIz4DMnGQFRjtUb/casX7POiiJhpbVlVHan7kAPnJ7
         cMxPberCOJqPeBwiaWMvflMUeYLoOSeraWDETQ39FZPHTuHjUDZ7yoAUwRcMFDB7Bj9g
         wxbwR9akbRTYKXWj9UmauL8dAkqVeC6zlH84cD1GKmcV1Tox90wW1CXJ6jOLqR/mV7VM
         VfuNAAzKC1SIskBmPopuWr7ynY/mSHQ/itgsMLNst9qPanDHsaC68GMMVoBpuZT35L5u
         OkAZo0yOSZhI5FNyGCbRzhV8xED0LwXHigQ7O8Ht9J5r2wEtVADA0wdv0NKhlHiBvpSj
         612A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503576; x=1769108376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bW47JMUnnrn3JGaUjgMVWNTwCOKFTT/lQ2uvrJQBiv0=;
        b=wLMYUOOC5ghwJESAfDUnjCXJQnyZIJh6rjfuI7KO1/KL9tbM2ZbdVxpDhZdiy7/agu
         6V222bXvY4tM3++/A5xMMGzdydspCfC1eEKGaISupFBn70M7OLMhNezcE57XDx8Ac2Vo
         p5y8axY6HjDD09IMwQkdA3G2t6+spe9mKFP9rKLV6ujxsE7SrSeSl+TG1r2tPT47VGmw
         C9/q5E2emc8S0MLdWpAKCWyGJsMPHeQ+PexIdGdY2cMsRdhX4K1MAXE5r/GT3pP5Vut9
         oRlERoz1ShfK/6WGK8VxXv87BbomX3aQ3OcrpyEIRqXiVt/yXd2W+X0AAqW0b5vKc1r4
         WMkA==
X-Forwarded-Encrypted: i=1; AJvYcCWUFDYkXM3eRnbpWvgo49DNSNT9UusNioqGQY54YQilKmRpk3Mij/xLXht1/KhogtsCMRhN2PrhGFewS8oMPRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOUpwl7JCrhmW2xaJWoqn4DAGYbbOBpaOgIHIEUqjh6CdANiiT
	z1PK5ujzzAHEK40QINCkeWUV9XoVtjCApqwDHt8gjVP0cC9TGRwBux+nhpLOcA==
X-Gm-Gg: AY/fxX4PnfTus1PJhhIhfuUJ23RX5gdQvDmVmF3mi+k/0BttU0seAbaYn0t3iTMvmLl
	O6Vj48xcQuXOWJLVjwzctSqZlBRKxzLnt7wsC9UUfHNfoMUj2qiaV6nL3CMXZjA/CV6GSyo6aGX
	R0zPsbEYsLQNzDSANGp3OgdaMvzeTc5aNrh5x7asujokj3tFUG8H4y3w0cl8w1zxYZp25/vOA9C
	Tlj9tUiO+3n9rsEfL9uNOv8cxqod3qx2QvBlkMtWsszkDWfLcjeatnSZbztXmnXrIYM9j6sMr5V
	ToJFpr/f6J4aqkRaqFH69lKgo8OqN5svPoDebVGpAa8R4au68b3/rgPRpIGfIvENwfehVDFLzWr
	3ZX20Q5LZtOp4yqO7jQ1wNSHw4v4kZhJO2JYIED35rHjSDzvNCQCZnKoJOUh2u8uOIogjfFfQ8s
	550/dCcoibvoFc5+p6lADqomMnkj6Bex9ABYoBsH65aiLGUs5ldUuSIPW461ttGefXbAsnLy6bs
	Zcn1K2/x3vOELDD/g==
X-Received: by 2002:a05:600d:640f:20b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-4801e7d2a3cmr1465185e9.17.1768497153419;
        Thu, 15 Jan 2026 09:12:33 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm54741645e9.11.2026.01.15.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:12:32 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	kernel-team@meta.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v9 5/9] eth: bnxt: store rx buffer size per queue
Date: Thu, 15 Jan 2026 17:11:58 +0000
Message-ID: <f57efb32aae1da5c0a25acf473ef4ab559894adf.1768493907.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768493907.git.asml.silence@gmail.com>
References: <cover.1768493907.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using a constant buffer length, allow configuring the size
for each queue separately. There is no way to change the length yet, and
it'll be passed from memory providers in a later patch.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 56 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  2 +-
 4 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a0abe991f79a..196b972263bd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -905,7 +905,7 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 
 static bool bnxt_separate_head_pool(struct bnxt_rx_ring_info *rxr)
 {
-	return rxr->need_head_pool || PAGE_SIZE > BNXT_RX_PAGE_SIZE;
+	return rxr->need_head_pool || rxr->rx_page_size < PAGE_SIZE;
 }
 
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
@@ -915,9 +915,9 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 {
 	struct page *page;
 
-	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
+	if (rxr->rx_page_size < PAGE_SIZE) {
 		page = page_pool_dev_alloc_frag(rxr->page_pool, offset,
-						BNXT_RX_PAGE_SIZE);
+						rxr->rx_page_size);
 	} else {
 		page = page_pool_dev_alloc_pages(rxr->page_pool);
 		*offset = 0;
@@ -936,8 +936,9 @@ static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *mapping,
 {
 	netmem_ref netmem;
 
-	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
-		netmem = page_pool_alloc_frag_netmem(rxr->page_pool, offset, BNXT_RX_PAGE_SIZE, gfp);
+	if (rxr->rx_page_size < PAGE_SIZE) {
+		netmem = page_pool_alloc_frag_netmem(rxr->page_pool, offset,
+						     rxr->rx_page_size, gfp);
 	} else {
 		netmem = page_pool_alloc_netmems(rxr->page_pool, gfp);
 		*offset = 0;
@@ -1155,9 +1156,9 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
 				bp->rx_dir);
-	skb = napi_build_skb(data_ptr - bp->rx_offset, BNXT_RX_PAGE_SIZE);
+	skb = napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
@@ -1189,7 +1190,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
 				bp->rx_dir);
 
 	if (unlikely(!payload))
@@ -1203,7 +1204,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 
 	skb_mark_for_recycle(skb);
 	off = (void *)data_ptr - page_address(page);
-	skb_add_rx_frag(skb, 0, page, off, len, BNXT_RX_PAGE_SIZE);
+	skb_add_rx_frag(skb, 0, page, off, len, rxr->rx_page_size);
 	memcpy(skb->data - NET_IP_ALIGN, data_ptr - NET_IP_ALIGN,
 	       payload + NET_IP_ALIGN);
 
@@ -1288,7 +1289,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 		if (skb) {
 			skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
 					       cons_rx_buf->offset,
-					       frag_len, BNXT_RX_PAGE_SIZE);
+					       frag_len, rxr->rx_page_size);
 		} else {
 			skb_frag_t *frag = &shinfo->frags[i];
 
@@ -1313,7 +1314,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 			if (skb) {
 				skb->len -= frag_len;
 				skb->data_len -= frag_len;
-				skb->truesize -= BNXT_RX_PAGE_SIZE;
+				skb->truesize -= rxr->rx_page_size;
 			}
 
 			--shinfo->nr_frags;
@@ -1328,7 +1329,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 		}
 
 		page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem, 0,
-						  BNXT_RX_PAGE_SIZE);
+						  rxr->rx_page_size);
 
 		total_frag_len += frag_len;
 		prod = NEXT_RX_AGG(prod);
@@ -2290,8 +2291,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			if (!skb)
 				goto oom_next_rx;
 		} else {
-			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs,
-						 rxr->page_pool, &xdp);
+			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr, &xdp);
 			if (!skb) {
 				/* we should be able to free the old skb here */
 				bnxt_xdp_buff_frags_free(rxr, &xdp);
@@ -3837,11 +3837,13 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.pool_size = bp->rx_agg_ring_size / agg_size_fac;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size / rx_size_fac;
+
+	pp.order = get_order(rxr->rx_page_size);
 	pp.nid = numa_node;
 	pp.netdev = bp->dev;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
-	pp.max_len = PAGE_SIZE;
+	pp.max_len = PAGE_SIZE << pp.order;
 	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
 		   PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 	pp.queue_idx = rxr->bnapi->index;
@@ -3852,7 +3854,10 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	rxr->page_pool = pool;
 
 	rxr->need_head_pool = page_pool_is_unreadable(pool);
+	rxr->need_head_pool |= !!pp.order;
 	if (bnxt_separate_head_pool(rxr)) {
+		pp.order = 0;
+		pp.max_len = PAGE_SIZE;
 		pp.pool_size = min(bp->rx_ring_size / rx_size_fac, 1024);
 		pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 		pool = page_pool_create(&pp);
@@ -4328,6 +4333,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		if (!rxr)
 			goto skip_rx;
 
+		rxr->rx_page_size = BNXT_RX_PAGE_SIZE;
+
 		ring = &rxr->rx_ring_struct;
 		rmem = &ring->ring_mem;
 		rmem->nr_pages = bp->rx_nr_pages;
@@ -4487,7 +4494,7 @@ static void bnxt_init_one_rx_agg_ring_rxbd(struct bnxt *bp,
 	ring = &rxr->rx_agg_ring_struct;
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
-		type = ((u32)BNXT_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
+		type = ((u32)rxr->rx_page_size << RX_BD_LEN_SHIFT) |
 			RX_BD_TYPE_RX_AGG_BD;
 
 		/* On P7, setting EOP will cause the chip to disable
@@ -7065,6 +7072,7 @@ static void bnxt_hwrm_ring_grp_free(struct bnxt *bp)
 
 static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 				       struct hwrm_ring_alloc_input *req,
+				       struct bnxt_rx_ring_info *rxr,
 				       struct bnxt_ring_struct *ring)
 {
 	struct bnxt_ring_grp_info *grp_info = &bp->grp_info[ring->grp_idx];
@@ -7074,7 +7082,7 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 	if (ring_type == HWRM_RING_ALLOC_AGG) {
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
 		req->rx_ring_id = cpu_to_le16(grp_info->rx_fw_ring_id);
-		req->rx_buf_size = cpu_to_le16(BNXT_RX_PAGE_SIZE);
+		req->rx_buf_size = cpu_to_le16(rxr->rx_page_size);
 		enables |= RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID;
 	} else {
 		req->rx_buf_size = cpu_to_le16(bp->rx_buf_use_size);
@@ -7088,6 +7096,7 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 }
 
 static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
+				    struct bnxt_rx_ring_info *rxr,
 				    struct bnxt_ring_struct *ring,
 				    u32 ring_type, u32 map_index)
 {
@@ -7144,7 +7153,8 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 			      cpu_to_le32(bp->rx_ring_mask + 1) :
 			      cpu_to_le32(bp->rx_agg_ring_mask + 1);
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-			bnxt_set_rx_ring_params_p5(bp, ring_type, req, ring);
+			bnxt_set_rx_ring_params_p5(bp, ring_type, req,
+						   rxr, ring);
 		break;
 	case HWRM_RING_ALLOC_CMPL:
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_L2_CMPL;
@@ -7292,7 +7302,7 @@ static int bnxt_hwrm_rx_ring_alloc(struct bnxt *bp,
 	u32 map_idx = bnapi->index;
 	int rc;
 
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, rxr, ring, type, map_idx);
 	if (rc)
 		return rc;
 
@@ -7312,7 +7322,7 @@ static int bnxt_hwrm_rx_agg_ring_alloc(struct bnxt *bp,
 	int rc;
 
 	map_idx = grp_idx + bp->rx_nr_rings;
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, rxr, ring, type, map_idx);
 	if (rc)
 		return rc;
 
@@ -7336,7 +7346,7 @@ static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
 
 	ring = &cpr->cp_ring_struct;
 	ring->handle = BNXT_SET_NQ_HDL(cpr);
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, NULL, ring, type, map_idx);
 	if (rc)
 		return rc;
 	bnxt_set_db(bp, &cpr->cp_db, type, map_idx, ring->fw_ring_id);
@@ -7351,7 +7361,7 @@ static int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp,
 	const u32 type = HWRM_RING_ALLOC_TX;
 	int rc;
 
-	rc = hwrm_ring_alloc_send_msg(bp, ring, type, tx_idx);
+	rc = hwrm_ring_alloc_send_msg(bp, NULL, ring, type, tx_idx);
 	if (rc)
 		return rc;
 	bnxt_set_db(bp, &txr->tx_db, type, tx_idx, ring->fw_ring_id);
@@ -7377,7 +7387,7 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 
 		vector = bp->irq_tbl[map_idx].vector;
 		disable_irq_nosync(vector);
-		rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+		rc = hwrm_ring_alloc_send_msg(bp, NULL, ring, type, map_idx);
 		if (rc) {
 			enable_irq(vector);
 			goto err_out;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f88e7769a838..9eaef6d7c150 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1105,6 +1105,7 @@ struct bnxt_rx_ring_info {
 
 	unsigned long		*rx_agg_bmap;
 	u16			rx_agg_bmap_size;
+	u32			rx_page_size;
 	bool                    need_head_pool;
 
 	dma_addr_t		rx_desc_mapping[MAX_RX_PAGES];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index c94a391b1ba5..85cbeb35681c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -183,7 +183,7 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 			u16 cons, u8 *data_ptr, unsigned int len,
 			struct xdp_buff *xdp)
 {
-	u32 buflen = BNXT_RX_PAGE_SIZE;
+	u32 buflen = rxr->rx_page_size;
 	struct bnxt_sw_rx_bd *rx_buf;
 	struct pci_dev *pdev;
 	dma_addr_t mapping;
@@ -460,7 +460,7 @@ int bnxt_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 
 struct sk_buff *
 bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
-		   struct page_pool *pool, struct xdp_buff *xdp)
+		   struct bnxt_rx_ring_info *rxr, struct xdp_buff *xdp)
 {
 	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
 
@@ -468,7 +468,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 		return NULL;
 
 	xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
-				  BNXT_RX_PAGE_SIZE * num_frags,
+				  rxr->rx_page_size * num_frags,
 				  xdp_buff_get_skb_flags(xdp));
 	return skb;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 220285e190fc..8933a0dec09a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -32,6 +32,6 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 			      struct xdp_buff *xdp);
 struct sk_buff *bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
-				   u8 num_frags, struct page_pool *pool,
+				   u8 num_frags, struct bnxt_rx_ring_info *rxr,
 				   struct xdp_buff *xdp);
 #endif
-- 
2.52.0


