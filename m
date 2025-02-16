Return-Path: <linux-kselftest+bounces-26729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C84A3727B
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 08:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8BC16EA5B
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 07:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAA1156F57;
	Sun, 16 Feb 2025 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KuV6hyEm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3931547F3;
	Sun, 16 Feb 2025 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739691840; cv=none; b=XmUfb3MiPE5fGNTr472FyH1t+5CYomRbJ1dyHwzCywrPy0EYHd6XRYo1ncPHml4Teg5ze8P3LBqpQpxY2+ke9vBhIYUXoCQTkX+y1j8zIVl30vazpCIZlESphsIC8iXQ/bKDhTcLuwRTFCFbmnKyjYwke4m4qrwI77KzFXoC6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739691840; c=relaxed/simple;
	bh=1ZNUHtJ1pgOfw/IuS15coOc2ol1V/tTszPLKQRh9oB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ia+j1SaOWWB/6turx/rgClkXLbFjDhqYMdSw3w18Dcd17VQkRI5n8BDdrj8B6ntnGHACHWJZZNHAJZXu2siqqZY2kSeAHV1jK0gPBAvJyS8ubIaj/7J61YbAyOFrMsmRwpdTcm7OUaxnic0Mj1zfLmnEJZ11Jn4Toaxdi3Ws4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KuV6hyEm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739691838; x=1771227838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ZNUHtJ1pgOfw/IuS15coOc2ol1V/tTszPLKQRh9oB4=;
  b=KuV6hyEmPgpLCZXnofKF36aZ4zENt/PfvxCB4TLaJgtbw1CaXcMdTzSt
   tzDvFvABT2kmpTr77w6P0iPuiHWHtmJfGkTGiDKbbRL2dBDHg3OGgtFLq
   e4ygYEUPNC2/wI8hknMcSV/6o3qfKnioqWhkR2GlxjGjetNI2XITk8Okd
   0dCwdk4HNjeDRlx5rrgqCgaHyevDsV1gCps3h0vthslfWj81DZlHA1XtP
   PmRhWfTUjMT25ApZTNfuLQpSSkejpABpPb5a4oaUuzqptanzzh6seHiHX
   ewUSZU4tIfaIZuw22p1C2LAfcQ/YUBLv8P5vp08RON3VAym14mfSLiVWC
   w==;
X-CSE-ConnectionGUID: ezeFu1oBRXOeslu0nHuQ3Q==
X-CSE-MsgGUID: 2tFX1I2QTPS/emIiVEbNSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40515426"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40515426"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 23:43:57 -0800
X-CSE-ConnectionGUID: mD/8w8I2SYqVYQLjPdAOrQ==
X-CSE-MsgGUID: gi6+hWA5S0OMzxvyai3oIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="114028049"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by fmviesa008.fm.intel.com with ESMTP; 15 Feb 2025 23:43:46 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Bouska Zdenek <zdenek.bouska@siemens.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org,
	xdp-hints@xdp-project.net
Subject: [PATCH bpf-next v11 4/5] igc: Refactor empty frame insertion for launch time support
Date: Sun, 16 Feb 2025 15:43:01 +0800
Message-Id: <20250216074302.956937-5-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216074302.956937-1-yoong.siang.song@intel.com>
References: <20250216074302.956937-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the code for inserting an empty frame into a new function
igc_insert_empty_frame(). This change extracts the logic for inserting
an empty packet from igc_xmit_frame_ring() into a separate function,
allowing it to be reused in future implementations, such as the XDP
zero copy transmit function.

Remove the igc_desc_unused() checking in igc_init_tx_empty_descriptor()
because the number of descriptors needed is guaranteed.

Ensure that skb allocation and DMA mapping work for the empty frame,
before proceeding to fill in igc_tx_buffer info, context descriptor,
and data descriptor.

Rate limit the error messages for skb allocation and DMA mapping failures.

Update the comment to indicate that the 2 descriptors needed by the empty
frame are already taken into consideration in igc_xmit_frame_ring().

Handle the case where the insertion of an empty frame fails and explain
the reason behind this handling.

Reviewed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 82 ++++++++++++++---------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 84307bb7313e..1bfa71545e37 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1092,7 +1092,8 @@ static int igc_init_empty_frame(struct igc_ring *ring,
 
 	dma = dma_map_single(ring->dev, skb->data, size, DMA_TO_DEVICE);
 	if (dma_mapping_error(ring->dev, dma)) {
-		netdev_err_once(ring->netdev, "Failed to map DMA for TX\n");
+		net_err_ratelimited("%s: DMA mapping error for empty frame\n",
+				    netdev_name(ring->netdev));
 		return -ENOMEM;
 	}
 
@@ -1108,20 +1109,12 @@ static int igc_init_empty_frame(struct igc_ring *ring,
 	return 0;
 }
 
-static int igc_init_tx_empty_descriptor(struct igc_ring *ring,
-					struct sk_buff *skb,
-					struct igc_tx_buffer *first)
+static void igc_init_tx_empty_descriptor(struct igc_ring *ring,
+					 struct sk_buff *skb,
+					 struct igc_tx_buffer *first)
 {
 	union igc_adv_tx_desc *desc;
 	u32 cmd_type, olinfo_status;
-	int err;
-
-	if (!igc_desc_unused(ring))
-		return -EBUSY;
-
-	err = igc_init_empty_frame(ring, first, skb);
-	if (err)
-		return err;
 
 	cmd_type = IGC_ADVTXD_DTYP_DATA | IGC_ADVTXD_DCMD_DEXT |
 		   IGC_ADVTXD_DCMD_IFCS | IGC_TXD_DCMD |
@@ -1140,8 +1133,6 @@ static int igc_init_tx_empty_descriptor(struct igc_ring *ring,
 	ring->next_to_use++;
 	if (ring->next_to_use == ring->count)
 		ring->next_to_use = 0;
-
-	return 0;
 }
 
 #define IGC_EMPTY_FRAME_SIZE 60
@@ -1567,6 +1558,40 @@ static bool igc_request_tx_tstamp(struct igc_adapter *adapter, struct sk_buff *s
 	return false;
 }
 
+static int igc_insert_empty_frame(struct igc_ring *tx_ring)
+{
+	struct igc_tx_buffer *empty_info;
+	struct sk_buff *empty_skb;
+	void *data;
+	int ret;
+
+	empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
+	empty_skb = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
+	if (unlikely(!empty_skb)) {
+		net_err_ratelimited("%s: skb alloc error for empty frame\n",
+				    netdev_name(tx_ring->netdev));
+		return -ENOMEM;
+	}
+
+	data = skb_put(empty_skb, IGC_EMPTY_FRAME_SIZE);
+	memset(data, 0, IGC_EMPTY_FRAME_SIZE);
+
+	/* Prepare DMA mapping and Tx buffer information */
+	ret = igc_init_empty_frame(tx_ring, empty_info, empty_skb);
+	if (unlikely(ret)) {
+		dev_kfree_skb_any(empty_skb);
+		return ret;
+	}
+
+	/* Prepare advanced context descriptor for empty packet */
+	igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
+
+	/* Prepare advanced data descriptor for empty packet */
+	igc_init_tx_empty_descriptor(tx_ring, empty_skb, empty_info);
+
+	return 0;
+}
+
 static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 				       struct igc_ring *tx_ring)
 {
@@ -1586,6 +1611,7 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	 *	+ 1 desc for skb_headlen/IGC_MAX_DATA_PER_TXD,
 	 *	+ 2 desc gap to keep tail from touching head,
 	 *	+ 1 desc for context descriptor,
+	 *	+ 2 desc for inserting an empty packet for launch time,
 	 * otherwise try next time
 	 */
 	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++)
@@ -1605,24 +1631,16 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	launch_time = igc_tx_launchtime(tx_ring, txtime, &first_flag, &insert_empty);
 
 	if (insert_empty) {
-		struct igc_tx_buffer *empty_info;
-		struct sk_buff *empty;
-		void *data;
-
-		empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
-		empty = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
-		if (!empty)
-			goto done;
-
-		data = skb_put(empty, IGC_EMPTY_FRAME_SIZE);
-		memset(data, 0, IGC_EMPTY_FRAME_SIZE);
-
-		igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
-
-		if (igc_init_tx_empty_descriptor(tx_ring,
-						 empty,
-						 empty_info) < 0)
-			dev_kfree_skb_any(empty);
+		/* Reset the launch time if the required empty frame fails to
+		 * be inserted. However, this packet is not dropped, so it
+		 * "dirties" the current Qbv cycle. This ensures that the
+		 * upcoming packet, which is scheduled in the next Qbv cycle,
+		 * does not require an empty frame. This way, the launch time
+		 * continues to function correctly despite the current failure
+		 * to insert the empty frame.
+		 */
+		if (igc_insert_empty_frame(tx_ring))
+			launch_time = 0;
 	}
 
 done:
-- 
2.34.1


