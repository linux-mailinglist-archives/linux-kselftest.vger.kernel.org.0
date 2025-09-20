Return-Path: <linux-kselftest+bounces-41996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA2B8C804
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 14:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567E55866EB
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A77C301497;
	Sat, 20 Sep 2025 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvgAfJgq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDDD29ACF7;
	Sat, 20 Sep 2025 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758370888; cv=none; b=QCUf1V/fXc1LSvxnSr2M3p4NTPqMqS2VDYsoCe3S1MXQAboZo4v3+YmaHFHRbVzGnnNzmLC04pKjaj5oNhsUQgpbxVZ7SAj4BGxokz5hd9BiSryG/+XhGljzu3STUS+KcA9jJrBMScFWUarn5n0GOun/waYjEPXSTW7rJHyHKbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758370888; c=relaxed/simple;
	bh=tMPCeHLV0AZkIwSaiKQEVLhP5PNGSU5qyZ7rqwvWdR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xw0/5Z2soGi6uAmVApCOlLg6AuYT9RiXMc7UfcQP9Tm62SIbeDHoMUTQJEnxKMHGFYrGrJbstFl1DstUelQC13KO8TE/4wDuYcAF07cWvA8bu56B8UCPDb7D9LqF83a+KdJZs3EQW/e3KVxD11jMVXIUfVsCEKboImklXw9E6h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvgAfJgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7543EC4CEEB;
	Sat, 20 Sep 2025 12:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758370887;
	bh=tMPCeHLV0AZkIwSaiKQEVLhP5PNGSU5qyZ7rqwvWdR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JvgAfJgqoXR4f+7AnhJ5rnDnDJpzkj99+jZeH18UWqETvCqPrt9fHtxPTVzKO9R3p
	 W1ooEhuYvt7HxvDY8qwD5DFcQzu8KfBqzGHMt4lkhVoR0sjmDIzEL1lwS1Cdy1wu2z
	 /zUOVUOBT99BliRoUFsCvACKbtMlh2Qkf6dWNcDNkZu+JHorOybxf7t/aHhtOcX5UA
	 PgbHdM7v9qP55NJzLT5zbfqiSYQCxo8+ld61nyUri66tQKsL1w/aWKvMbAVw6WQuSQ
	 txYn+lkKf9oai5wUm6bfyeIyaT8KoKs1yrIXuP55cdtDranr8w8v6hWKKDXoaXbdjB
	 Kii7yMmFeZvng==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 20 Sep 2025 14:20:30 +0200
Subject: [PATCH RFC bpf-next 4/6] net: ice: Add xmo_rx_checksum callback
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-xdp-meta-rxcksum-v1-4-35e76a8a84e7@kernel.org>
References: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
In-Reply-To: <20250920-xdp-meta-rxcksum-v1-0-35e76a8a84e7@kernel.org>
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
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Implement xmo_rx_checksum callback in ice driver to report RX checksum
result to the eBPF program bounded to the NIC.

Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_base.c     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 82 +++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index c5da8e9cc0a0e5551b340e70628813999059bcfe..e8ec419bdc98cb1f01e3c088698b0c4c0f97748f 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -591,6 +591,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		}
 	}
 
+	ring->pkt_ctx.rxq_flags = ring->flags;
 	xdp_init_buff(&ring->xdp, ice_get_frame_sz(ring), &ring->xdp_rxq);
 	ring->xdp.data = NULL;
 	ring->xdp_ext.pkt_ctx = &ring->pkt_ctx;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 2fd8e78178a271c15fc054ef553bd509b1c8f8f3..96a2bb79e5e95fa0b9c6287eb9769bdecf47dec1 100644
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
index 45cfaabc41cbeb9b119a0e95547e012e0df1e188..5327b0389ec1a3708a469fa9986a1e565b20ecf7 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -555,6 +555,87 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
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
+static int ice_xdp_rx_checksum(const struct xdp_md *ctx, u8 *ip_summed,
+			       u32 *cksum_meta)
+{
+	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+	const union ice_32b_rx_flex_desc *rx_desc = xdp_ext->eop_desc;
+	u16 rx_status0, rx_status1, ptype = ice_get_ptype(rx_desc);
+	struct libeth_rx_pt decoded = libie_rx_pt_parse(ptype);
+	bool ipv4, ipv6;
+
+	if (!libeth_rx_pt_has_checksum(xdp_ext->xdp_buff.rxq->dev, decoded))
+		goto checksum_none;
+
+	rx_status0 = le16_to_cpu(rx_desc->wb.status_error0);
+	rx_status1 = le16_to_cpu(rx_desc->wb.status_error1);
+	if ((xdp_ext->pkt_ctx->rxq_flags & ICE_RX_FLAGS_RING_GCS) &&
+	    rx_desc->wb.rxdid == ICE_RXDID_FLEX_NIC &&
+	    (decoded.inner_prot == LIBETH_RX_PT_INNER_TCP ||
+	     decoded.inner_prot == LIBETH_RX_PT_INNER_UDP ||
+	     decoded.inner_prot == LIBETH_RX_PT_INNER_ICMP)) {
+		const struct ice_32b_rx_flex_desc_nic *desc;
+		u16 csum;
+
+		desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
+		*ip_summed = CHECKSUM_COMPLETE;
+		csum = (__force u16)desc->raw_csum;
+		*cksum_meta = csum_unfold((__force __sum16)swab16(csum));
+		return 0;
+	}
+
+	/* check if HW has decoded the packet and checksum */
+	if (!(rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_L3L4P_S)))
+		goto checksum_none;
+
+	ipv4 = libeth_rx_pt_get_ip_ver(decoded) == LIBETH_RX_PT_OUTER_IPV4;
+	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EIPE_S))))
+		goto checksum_none;
+
+	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_IPE_S))))
+		goto checksum_none;
+
+	ipv6 = libeth_rx_pt_get_ip_ver(decoded) == LIBETH_RX_PT_OUTER_IPV6;
+	if (ipv6 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_IPV6EXADD_S))))
+		goto checksum_none;
+
+	/* check for L4 errors and handle packets that were not able to be
+	 * checksummed due to arrival speed
+	 */
+	if (rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_L4E_S))
+		goto checksum_none;
+
+	/* check for outer UDP checksum error in tunneled packets */
+	if ((rx_status1 & BIT(ICE_RX_FLEX_DESC_STATUS1_NAT_S)) &&
+	    (rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EUDPE_S)))
+		goto checksum_none;
+
+	/* If there is an outer header present that might contain a checksum
+	 * we need to bump the checksum level by 1 to reflect the fact that
+	 * we are indicating we validated the inner checksum.
+	 */
+	if (decoded.tunnel_type >= LIBETH_RX_PT_TUNNEL_IP_GRENAT)
+		*cksum_meta = 1;
+
+	*ip_summed = CHECKSUM_UNNECESSARY;
+	return 0;
+
+checksum_none:
+	*ip_summed = CHECKSUM_NONE;
+	*cksum_meta = 0;
+
+	return 0;
+}
+
 /**
  * ice_xdp_rx_vlan_tag - VLAN tag XDP hint handler
  * @ctx: XDP buff pointer
@@ -584,4 +665,5 @@ const struct xdp_metadata_ops ice_xdp_md_ops = {
 	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
 	.xmo_rx_hash			= ice_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= ice_xdp_rx_vlan_tag,
+	.xmo_rx_checksum		= ice_xdp_rx_checksum,
 };

-- 
2.51.0


