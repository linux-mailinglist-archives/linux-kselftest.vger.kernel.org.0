Return-Path: <linux-kselftest+bounces-42282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE52B9E645
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 11:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DC1387417
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 09:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB202F60C4;
	Thu, 25 Sep 2025 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLh5acQl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557122F260D;
	Thu, 25 Sep 2025 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792657; cv=none; b=UlHYdAGuwCs0vOAdxhwtSx0nf2VzQ4GYfTHpHc4Dogl2BP328iZQuKosEOTQn24p9u0gX6YauxL+ZK3m2Ixp4QCGkrO2Cxv79uZVNRMPftGQ47wZVhuy3h774+5corhaZPM+VObj31q34mXBa2UL3/O0u8jFZ0BYP3uao4dn/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792657; c=relaxed/simple;
	bh=OBvxf+Pc9c1g3pCurCmZc1MUdjLVjxEGupO4B/c39pU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K2MTmA6by/yXZttcDhGy/pEm3LvCQXqN1JZDOKCjbN4CjR2bKpEOjIZ1K8TnvwbI25K4fVxzxp9RvDKEtOOUFa+J5mjw79WedICAM5SKeLkJjmIyxzWbOJ/HywRUgivkXazxwcJT3SkgPrRxmtzMoHQwQ4jF/0HoDZ7a8CoMx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLh5acQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4496C113CF;
	Thu, 25 Sep 2025 09:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758792657;
	bh=OBvxf+Pc9c1g3pCurCmZc1MUdjLVjxEGupO4B/c39pU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vLh5acQlcHK88CeaZ7yelQPiYEjblcADyMga9T7yKynTlLezaSt8RxQxA9FCuBWVd
	 CpbmTNrif9xlQfyuiw7Lzf1qXCcTb2VBZmDIyIFgvndY+jsJdOZbKtbt3m7vNHvx8F
	 6RyyGIDMsLMCY9MGix1cE+TMWgvgj6Xs9LZqQpGVrqt8pW779zkgJT4mPI96nnGyf+
	 vRX+C6574YkiKmU8n4B4Y+Vcx7BIVRiRKclqmwL6t3MsJKFiYr7pOFOKciGCDqC1Yr
	 j/UyPEkQmuRsmdmq1Pc/DSv9C1TWUy2eZvEl0eOXZ5M7o5JxM0uG2n9rZpAgF2KVYw
	 6VVVTAJRiwx5w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 25 Sep 2025 11:30:35 +0200
Subject: [PATCH RFC bpf-next v2 3/5] net: ice: Add xmo_rx_checksum callback
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-bpf-xdp-meta-rxcksum-v2-3-6b3fe987ce91@kernel.org>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
In-Reply-To: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Implement xmo_rx_checksum callback in ice driver to report RX checksum
result to the eBPF program bounded to the NIC.
Introduce ice_get_rx_csum utility routine in order to rx cksum codebase
available in ice_rx_csum().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_base.c     |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 125 +++++++++++++++++---------
 3 files changed, 83 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 2d35a278c555c526939e509c386959da6ce0cba9..7b1e932c8abc6292173caa36e4e26866d2e956bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -695,6 +695,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		}
 	}
 
+	ring->pkt_ctx.rxq_flags = ring->flags;
 	xdp_init_buff(&ring->xdp, ice_get_frame_sz(ring), &ring->xdp_rxq);
 	ring->xdp.data = NULL;
 	ring->xdp_ext.pkt_ctx = &ring->pkt_ctx;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 841a07bfba54ffb4907e765881bee993238cf7b8..cb6bd1e9cb97f0384b86e0f9e64339f68cae0e52 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -260,6 +260,7 @@ enum ice_rx_dtype {
 struct ice_pkt_ctx {
 	u64 cached_phctime;
 	__be16 vlan_proto;
+	u8 rxq_flags;
 };
 
 struct ice_xdp_buff {
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 45cfaabc41cbeb9b119a0e95547e012e0df1e188..56c3f09c81cefc137c6866cdc546a7c96b7890ac 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -80,69 +80,46 @@ ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,
 		libeth_rx_pt_set_hash(skb, hash, decoded);
 }
 
-/**
- * ice_rx_gcs - Set generic checksum in skb
- * @skb: skb currently being received and modified
- * @rx_desc: receive descriptor
- */
-static void ice_rx_gcs(struct sk_buff *skb,
-		       const union ice_32b_rx_flex_desc *rx_desc)
-{
-	const struct ice_32b_rx_flex_desc_nic *desc;
-	u16 csum;
-
-	desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
-	skb->ip_summed = CHECKSUM_COMPLETE;
-	csum = (__force u16)desc->raw_csum;
-	skb->csum = csum_unfold((__force __sum16)swab16(csum));
-}
-
-/**
- * ice_rx_csum - Indicate in skb if checksum is good
- * @ring: the ring we care about
- * @skb: skb currently being received and modified
- * @rx_desc: the receive descriptor
- * @ptype: the packet type decoded by hardware
- *
- * skb->protocol must be set before this function is called
- */
 static void
-ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
-	    union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
+ice_get_rx_csum(const union ice_32b_rx_flex_desc *rx_desc, u16 ptype,
+		struct net_device *dev, struct ice_pf *pf, u8 rxq_flag,
+		enum xdp_checksum *ip_summed, u32 *cksum_meta)
 {
-	struct libeth_rx_pt decoded;
+	struct libeth_rx_pt decoded = libie_rx_pt_parse(ptype);
 	u16 rx_status0, rx_status1;
 	bool ipv4, ipv6;
 
-	/* Start with CHECKSUM_NONE and by default csum_level = 0 */
-	skb->ip_summed = CHECKSUM_NONE;
-
-	decoded = libie_rx_pt_parse(ptype);
-	if (!libeth_rx_pt_has_checksum(ring->netdev, decoded))
-		return;
+	if (!libeth_rx_pt_has_checksum(dev, decoded))
+		goto checksum_none;
 
 	rx_status0 = le16_to_cpu(rx_desc->wb.status_error0);
 	rx_status1 = le16_to_cpu(rx_desc->wb.status_error1);
-
-	if ((ring->flags & ICE_RX_FLAGS_RING_GCS) &&
+	if ((rxq_flag & ICE_RX_FLAGS_RING_GCS) &&
 	    rx_desc->wb.rxdid == ICE_RXDID_FLEX_NIC &&
 	    (decoded.inner_prot == LIBETH_RX_PT_INNER_TCP ||
 	     decoded.inner_prot == LIBETH_RX_PT_INNER_UDP ||
 	     decoded.inner_prot == LIBETH_RX_PT_INNER_ICMP)) {
-		ice_rx_gcs(skb, rx_desc);
+		const struct ice_32b_rx_flex_desc_nic *desc;
+		u16 csum;
+
+		desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
+		*ip_summed = XDP_CHECKSUM_COMPLETE;
+		csum = (__force u16)desc->raw_csum;
+		*cksum_meta = csum_unfold((__force __sum16)swab16(csum));
 		return;
 	}
 
 	/* check if HW has decoded the packet and checksum */
 	if (!(rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_L3L4P_S)))
-		return;
+		goto checksum_none;
 
 	ipv4 = libeth_rx_pt_get_ip_ver(decoded) == LIBETH_RX_PT_OUTER_IPV4;
 	ipv6 = libeth_rx_pt_get_ip_ver(decoded) == LIBETH_RX_PT_OUTER_IPV6;
 
 	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EIPE_S)))) {
-		ring->vsi->back->hw_rx_eipe_error++;
-		return;
+		if (pf)
+			pf->hw_rx_eipe_error++;
+		goto checksum_none;
 	}
 
 	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_IPE_S))))
@@ -167,13 +144,48 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
 	 * we are indicating we validated the inner checksum.
 	 */
 	if (decoded.tunnel_type >= LIBETH_RX_PT_TUNNEL_IP_GRENAT)
-		skb->csum_level = 1;
+		*cksum_meta = 1;
 
-	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	*ip_summed = XDP_CHECKSUM_UNNECESSARY;
 	return;
 
 checksum_fail:
-	ring->vsi->back->hw_csum_rx_error++;
+	if (pf)
+		pf->hw_csum_rx_error++;
+checksum_none:
+	*ip_summed = XDP_CHECKSUM_NONE;
+	*cksum_meta = 0;
+}
+
+/**
+ * ice_rx_csum - Indicate in skb if checksum is good
+ * @ring: the ring we care about
+ * @skb: skb currently being received and modified
+ * @rx_desc: the receive descriptor
+ * @ptype: the packet type decoded by hardware
+ *
+ * skb->protocol must be set before this function is called
+ */
+static void
+ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
+	    union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
+{
+	enum xdp_checksum ip_summed;
+	u32 cksum_meta;
+
+	ice_get_rx_csum(rx_desc, ptype, ring->netdev, ring->vsi->back,
+			ring->flags, &ip_summed, &cksum_meta);
+	switch (ip_summed) {
+	case XDP_CHECKSUM_UNNECESSARY:
+		skb->csum_level = cksum_meta;
+		break;
+	case XDP_CHECKSUM_COMPLETE:
+		skb->csum = cksum_meta;
+		break;
+	default:
+		break;
+	}
+	skb->ip_summed = ip_summed;
 }
 
 /**
@@ -555,6 +567,30 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+/**
+ * ice_xdp_rx_checksum - RX checksum XDP hint handler
+ * @ctx: XDP buff pointer
+ * @ip_summed: RX checksum result destination address
+ * @cksum_meta: XDP RX checksum metadata destination address
+ *
+ * Copy RX checksum result (if available) and its metadata to the
+ * destination address.
+ */
+static int ice_xdp_rx_checksum(const struct xdp_md *ctx,
+			       enum xdp_checksum *ip_summed,
+			       u32 *cksum_meta)
+{
+	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+	const union ice_32b_rx_flex_desc *rx_desc = xdp_ext->eop_desc;
+
+	ice_get_rx_csum(rx_desc, ice_get_ptype(rx_desc),
+			xdp_ext->xdp_buff.rxq->dev, NULL,
+			xdp_ext->pkt_ctx->rxq_flags,
+			ip_summed, cksum_meta);
+
+	return 0;
+}
+
 /**
  * ice_xdp_rx_vlan_tag - VLAN tag XDP hint handler
  * @ctx: XDP buff pointer
@@ -584,4 +620,5 @@ const struct xdp_metadata_ops ice_xdp_md_ops = {
 	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
 	.xmo_rx_hash			= ice_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= ice_xdp_rx_vlan_tag,
+	.xmo_rx_checksum		= ice_xdp_rx_checksum,
 };

-- 
2.51.0


