Return-Path: <linux-kselftest+bounces-23947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA05A02752
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 14:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3F3188581D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459821DE88C;
	Mon,  6 Jan 2025 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUNl52Ev"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5D51DB951;
	Mon,  6 Jan 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736171861; cv=none; b=LAlFmQWodNhfq6MakUXbxh4Op39ddfH1Gt8TxeQn5+DXz2Iy3uSlxxvPGdqV6Vb9d041QSUWkeYB0w+gUeyicaz4rxOdvl4EIwQErT+SZ1yhOdH9DZ9kuO3vTz3evTpEip6HCCVu0x4Z0fxnf2zkPyffL0uuIWYM4XF0rkfulYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736171861; c=relaxed/simple;
	bh=qGCwaypJFSzHfD7SuLIe+AzV2lEwzPgKj63Q4p347so=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i2x0cgvZJMS5Qk1TZb+bvl2moXaw0++Q0EG90NxxTNtOmBk7nMKXPBPnQ7ziYQdo5N19AjBizo9HapDsnM7Iqv3WgSxJqSalycNJeSIhkp3uUTX2ckNIUT9Rc9rQJaSz8YhkrjQp2KUwjD0mhyhSEQewj54y9I4jsT76xXmObTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUNl52Ev; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736171860; x=1767707860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qGCwaypJFSzHfD7SuLIe+AzV2lEwzPgKj63Q4p347so=;
  b=bUNl52Evms9UTlJzGmkGzX65iJF65THJZQp/fYVjNSxmVQbUli4+od2t
   fA4xhQQ0xYWzZSO2NI2kVb8kmpR4wcSBjz9t1v+Gn3xWSvNfk12jsEx6R
   vx4mM8LEaG56qiodJsKgzMBmBzHHgFj5zHGf5sJ9VCWZyvAj80v8TZF/5
   /2QJa8tbK2OFQiP0soAj/QTKq7YlFZ98ZUrWdVrDbxoa6tvM1L7RkGUek
   /iIViblxphAbS2bLNWvwXSF9NUfofceED2C44MNahZlReOfQfEOH7L7Y8
   7nYmxABiF8xOZNE0a7QGYlWugbQvrSAbn6ObZmfEcI8ouMo19SVHGr3Bl
   g==;
X-CSE-ConnectionGUID: jNXu+3+2T9C6rcnxpMUb6A==
X-CSE-MsgGUID: LTCFkvdVR8C1q4vipOSH4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="36473831"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="36473831"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 05:57:39 -0800
X-CSE-ConnectionGUID: 5mNEh76+SQOPHNjCosOwZg==
X-CSE-MsgGUID: 7Q1uLqm2TRCloWfgYIj/Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="107408167"
Received: from unknown (HELO P12ILL20yoongsia.png.intel.com) ([10.88.227.38])
  by orviesa004.jf.intel.com with ESMTP; 06 Jan 2025 05:57:27 -0800
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
	Amritha Nambiar <amritha.nambiar@intel.com>,
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
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org,
	xdp-hints@xdp-project.net
Subject: [PATCH bpf-next v4 4/4] igc: Add launch time support to XDP ZC
Date: Mon,  6 Jan 2025 21:57:24 +0800
Message-Id: <20250106135724.9749-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Launch Time Control (LTC) support to XDP zero copy via XDP Tx
metadata framework.

This patch is tested with tools/testing/selftests/bpf/xdp_hw_metadata on
Intel Tiger Lake platform. Below are the test steps and result.

Test Steps:
1. Add mqprio qdisc:
   $ sudo tc qdisc add dev enp2s0 handle 8001: parent root mqprio num_tc 4
     map 3 2 1 0 0 0 0 0 0 0 0 0 0 0 0 0 queues 1@0 1@1 1@2 1@3 hw 0

2. Enable launch time hardware offload on hardware queue 1:
   $ sudo tc qdisc replace dev enp2s0 parent 8001:2 etf offload clockid
     CLOCK_TAI delta 500000

3. Change RSS to route all incoming IP packets into hardware queue 1:
   $ sudo ethtool -X enp2s0 start 1 equal 1

4. Start xdp_hw_metadata selftest application:
   $ sudo ./xdp_hw_metadata enp2s0 -l 1000000000

5. Send an UDP packet to port 9091 of DUT.
   $ echo -n xdp | nc -u -q0 169.254.1.1 9091

When launch time is set to 1s in the future, the delta between launch time
and transmit hardware timestamp is equal to 0.016us, as shown in result
below:
  0x562ff5dc8880: rx_desc[4]->addr=84110 addr=84110 comp_addr=84110 EoP
  rx_hash: 0xE343384 with RSS type:0x1
  HW RX-time:   1734578015467548904 (sec:1734578015.4675) delta to User RX-time sec:0.0002 (183.103 usec)
  XDP RX-time:   1734578015467651698 (sec:1734578015.4677) delta to User RX-time sec:0.0001 (80.309 usec)
  No rx_vlan_tci or rx_vlan_proto, err=-95
  0x562ff5dc8880: ping-pong with csum=561c (want c7dd) csum_start=34 csum_offset=6
  HW RX-time:   1734578015467548904 (sec:1734578015.4675) delta to HW Launch-time sec:1.0000 (1000000.000 usec)
  0x562ff5dc8880: complete tx idx=4 addr=4018
  HW Launch-time:   1734578016467548904 (sec:1734578016.4675) delta to HW TX-complete-time sec:0.0000 (0.016 usec)
  HW TX-complete-time:   1734578016467548920 (sec:1734578016.4675) delta to User TX-complete-time sec:0.0000 (32.546 usec)
  XDP RX-time:   1734578015467651698 (sec:1734578015.4677) delta to User TX-complete-time sec:0.9999 (999929.768 usec)
  HW RX-time:   1734578015467548904 (sec:1734578015.4675) delta to HW TX-complete-time sec:1.0000 (1000000.016 usec)
  0x562ff5dc8880: complete rx idx=132 addr=84110

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 78 ++++++++++++++++-------
 1 file changed, 56 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27872bdea9bd..6857f5f5b4b2 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1566,6 +1566,26 @@ static bool igc_request_tx_tstamp(struct igc_adapter *adapter, struct sk_buff *s
 	return false;
 }
 
+static void igc_insert_empty_packet(struct igc_ring *tx_ring)
+{
+	struct igc_tx_buffer *empty_info;
+	struct sk_buff *empty;
+	void *data;
+
+	empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
+	empty = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
+	if (!empty)
+		return;
+
+	data = skb_put(empty, IGC_EMPTY_FRAME_SIZE);
+	memset(data, 0, IGC_EMPTY_FRAME_SIZE);
+
+	igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
+
+	if (igc_init_tx_empty_descriptor(tx_ring, empty, empty_info) < 0)
+		dev_kfree_skb_any(empty);
+}
+
 static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 				       struct igc_ring *tx_ring)
 {
@@ -1603,26 +1623,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	skb->tstamp = ktime_set(0, 0);
 	launch_time = igc_tx_launchtime(tx_ring, txtime, &first_flag, &insert_empty);
 
-	if (insert_empty) {
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
-	}
+	if (insert_empty)
+		igc_insert_empty_packet(tx_ring);
 
 done:
 	/* record the location of the first descriptor for this packet */
@@ -2955,9 +2957,33 @@ static u64 igc_xsk_fill_timestamp(void *_priv)
 	return *(u64 *)_priv;
 }
 
+static void igc_xsk_request_launch_time(u64 launch_time, void *_priv)
+{
+	struct igc_metadata_request *meta_req = _priv;
+	struct igc_ring *tx_ring = meta_req->tx_ring;
+	__le32 launch_time_offset;
+	bool insert_empty = false;
+	bool first_flag = false;
+
+	if (!tx_ring->launchtime_enable)
+		return;
+
+	launch_time_offset = igc_tx_launchtime(tx_ring,
+					       ns_to_ktime(launch_time),
+					       &first_flag, &insert_empty);
+	if (insert_empty) {
+		igc_insert_empty_packet(tx_ring);
+		meta_req->tx_buffer =
+			&tx_ring->tx_buffer_info[tx_ring->next_to_use];
+	}
+
+	igc_tx_ctxtdesc(tx_ring, launch_time_offset, first_flag, 0, 0, 0);
+}
+
 const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops = {
 	.tmo_request_timestamp		= igc_xsk_request_timestamp,
 	.tmo_fill_timestamp		= igc_xsk_fill_timestamp,
+	.tmo_request_launch_time	= igc_xsk_request_launch_time,
 };
 
 static void igc_xdp_xmit_zc(struct igc_ring *ring)
@@ -2980,7 +3006,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	ntu = ring->next_to_use;
 	budget = igc_desc_unused(ring);
 
-	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
+	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >= 4) {
 		struct igc_metadata_request meta_req;
 		struct xsk_tx_metadata *meta = NULL;
 		struct igc_tx_buffer *bi;
@@ -3004,6 +3030,12 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
 					&meta_req);
 
+		/* xsk_tx_metadata_request() may have updated next_to_use */
+		ntu = ring->next_to_use;
+
+		/* xsk_tx_metadata_request() may have updated Tx buffer info */
+		bi = meta_req.tx_buffer;
+
 		tx_desc = IGC_TX_DESC(ring, ntu);
 		tx_desc->read.cmd_type_len = cpu_to_le32(meta_req.cmd_type);
 		tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
@@ -3021,9 +3053,11 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 		ntu++;
 		if (ntu == ring->count)
 			ntu = 0;
+
+		ring->next_to_use = ntu;
+		budget = igc_desc_unused(ring);
 	}
 
-	ring->next_to_use = ntu;
 	if (tx_desc) {
 		igc_flush_tx_descriptors(ring);
 		xsk_tx_release(pool);
-- 
2.34.1


