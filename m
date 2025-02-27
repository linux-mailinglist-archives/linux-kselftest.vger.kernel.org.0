Return-Path: <linux-kselftest+bounces-27684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653DFA47117
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 02:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 830AA7AD221
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624761AC435;
	Thu, 27 Feb 2025 01:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FeZktj/n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B851A5B99
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 01:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619375; cv=none; b=MRP/yb9LjzM6Rn1tw8fQDF+EHGkN9Y/ZnqM6I6DXalC6klSVii/gksBhX0iLcAM23E8H/D2iu3mc9yMC7a8CJSy3CR3w4dHi/iBHXjkjgajW4zDZTrTn2ZeqxA7dYrjF/i6OG3uDEkPm/bcaTUxz4X2TjdwBsSKBcPgZtKv3fOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619375; c=relaxed/simple;
	bh=nUR3j+PF3GeCo00yThyKvXh0xUWZHLPI5pMXEH4nWXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iN1v515cEAKT+GLla1NNYTxCMsMhAv+4XE61szodVkH+vRiIPVP9r3QOelsTwayH1TxmljLLscRZfk4nKRl4rewhxMVxD4LCEL8rEWroudwqKb5idt3hM149NFlRj1FGtDPmCe6KPcifHz24FSPZydExIT/vjUIHrHPt/YnG2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FeZktj/n; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso2519365e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 17:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619370; x=1741224170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmNZFpTImp7iu4EdSG4+h+qDwgM0SrM1vBjVW09w5vE=;
        b=FeZktj/nwWm6UWqrfiYSvix3i4fChtNFaSDlLioZScAmgtXDMRPkNJ5yQmmtIAiTaV
         iRmfA0yNSHfBFXwy28eBdYh/01yKT6exSWGjcbQA7vjYE5LVTLE8Xi7ceL2mAd5+JHvR
         VisC77BILQLTMzpSd37TLAeku6PRUK0AuonZ1kvtE7J4J5dG6yurEQSFe/iKfq/wruL3
         CJhR8xEH54U0r0APWHegOCMXyWt+6tBqzEjBVdiISK6U2Vg6vUOOfd+Oyb0fJbUcoNtY
         72CReN6o20p5tlHEKYAaItW/jIK372jecL2lxHebufvdujxzkPLYeUnd/uexkodeqzoj
         G1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619370; x=1741224170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmNZFpTImp7iu4EdSG4+h+qDwgM0SrM1vBjVW09w5vE=;
        b=OvGzIcT+qYrTIqM4OC0ktlQycSthzYGmX8gSdcqnzBQ1xs0c5Hy3Q4YLqMTRz/tDxq
         VTz/t1MIcIU16mlcCg5LPIR3DzIGCDAFaWy5jQtFaYbWpy2qlXG98s3T7oLIKPlLQQvz
         3g+2CCSfs+v0b4ztKZOafHtIabpGfBmpNQ9vhlly2gLv58ggFDA5fI5ja/mxtxFfuvvt
         8U71dM10Sr3PJteLykr0iuHCn3j4CpFhFOV6MwrwTYvGN9QnmjQ0x8djSammk5B/Gths
         L1hjWUu0Snd9cRpYg04eN1kgYbYVeAAysgK2F6uB08uqiLYhDjJvikeqWDnsj8xQ8jb3
         ybfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqeJT4Dt+2J0ezO8Gp3EFCB70hGkA/fVtAlQ5EwOzbNJsdQ6yNxRX31VCzYpuzhBkS/kq9EY2nQUMnhSnwKK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxFUVJZyUF/q7F5U0G618n/uuoj8wvknSuk5qysc3VFCNbtImA
	PNhuQJ8ZyuqXxOWk3OnUCJJnw7N/g+QcTFVkFtxLjOpMsgP6Y1buimgtq8axyS0=
X-Gm-Gg: ASbGncvrx87Ib4d2gnY0CyE0cvtQBihBqMK+Gku5Tw1aEAlTJ45moOdlTymNgHVBr86
	gyetdI16Q+eLZt8hr9ijZjLG6RqBTEwufBi5yhHLShEAPkQfxaLGUgSwEVFjoOhg/xSSRspRKRP
	ReYYi2iCbGcQRird8VHjlcRtPVrg1WwvV3Kg6zCKC7N1MAPnJibE0RcCxuy9K+e2gahfWWhqKOZ
	DgMgsRa4hHXKkfiwWSjwyWdt1+8BJXttjckT+nsPMpYdmHVOYbEe3VICioLBQbIVz/5cd8mUpmj
	UB8LKrE92Ox0YpurxBtbt/0G4kj27qtpPXtYQA==
X-Google-Smtp-Source: AGHT+IHzSPe+AA20x6X8PptRAj5ZA/yKNG7vKjAyl3Rd3TqJ4a9NmHdubKqCetTAIRTCk1xEoOd90Q==
X-Received: by 2002:a05:600c:4fc8:b0:439:955d:7ad9 with SMTP id 5b1f17b1804b1-43ab8fe9333mr55379565e9.14.1740619370394;
        Wed, 26 Feb 2025 17:22:50 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:22:49 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:34 +0100
Subject: [PATCH net-next v20 09/25] ovpn: implement basic RX path (UDP)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-9-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17078; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=nUR3j+PF3GeCo00yThyKvXh0xUWZHLPI5pMXEH4nWXQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75gRU62YczUISVBcW1Fiu5PExmTWGOdoMxA/
 mIF5em4UGyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++YAAKCRALcOU6oDjV
 h/szB/4jNXQIes8ojQ/gD0/JYDNRwIVs8Z7EuuBuLsIHgw3YZu0/GNgBw0x6bp86ZBMoqW+eAqs
 JhOkB8EpsK2D1n0Ecg1MktIKuufpK+rgnCZOijDuz7bpAMnrPLeFhlbVk7KNxjoK3xIGbwes3nI
 W8X443LRZBQUTNeiG2ZojLxx+xGDD0nxtG3ORTuuT32Kz8+L4S9bLsBRb2QBhvUzNGBEBBVW1Um
 HpwaQ3fRBWa7lMXq6I5fV3BURec7o2htQO0tjWKNeYV1zPw7QVCL5oeoB3WcJnaaOJexL2OJfpd
 cnujs12e0YJ5XmeRqgkt8YpaCpLOq/+IQayWs0xF0WxJv2uc
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Packets received over the socket are forwarded to the user device.

Implementation is UDP only. TCP will be added by a later patch.

Note: no decryption/decapsulation exists yet, packets are forwarded as
they arrive without much processing.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c       |  64 ++++++++++++++++-
 drivers/net/ovpn/io.h       |   2 +
 drivers/net/ovpn/main.c     |  16 ++++-
 drivers/net/ovpn/ovpnpriv.h |   3 +
 drivers/net/ovpn/proto.h    |  50 +++++++++++++-
 drivers/net/ovpn/socket.c   |  13 +++-
 drivers/net/ovpn/socket.h   |  11 ++-
 drivers/net/ovpn/udp.c      | 162 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/udp.h      |   2 +
 net/ipv6/udp.c              |   1 +
 10 files changed, 319 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 94b466bf2ef70d60d3e60d9820b64877c44f2e51..46ad27e8eb8425f810c7d2b6c63984ea008d90fa 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -9,15 +9,77 @@
 
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <net/gro_cells.h>
 #include <net/gso.h>
 
-#include "io.h"
 #include "ovpnpriv.h"
 #include "peer.h"
+#include "io.h"
+#include "netlink.h"
+#include "proto.h"
 #include "udp.h"
 #include "skb.h"
 #include "socket.h"
 
+/* Called after decrypt to write the IP packet to the device.
+ * This method is expected to manage/free the skb.
+ */
+static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	unsigned int pkt_len;
+	int ret;
+
+	/* we can't guarantee the packet wasn't corrupted before entering the
+	 * VPN, therefore we give other layers a chance to check that
+	 */
+	skb->ip_summed = CHECKSUM_NONE;
+
+	/* skb hash for transport packet no longer valid after decapsulation */
+	skb_clear_hash(skb);
+
+	/* post-decrypt scrub -- prepare to inject encapsulated packet onto the
+	 * interface, based on __skb_tunnel_rx() in dst.h
+	 */
+	skb->dev = peer->ovpn->dev;
+	skb_set_queue_mapping(skb, 0);
+	skb_scrub_packet(skb, true);
+
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+	skb_reset_inner_headers(skb);
+
+	/* cause packet to be "received" by the interface */
+	pkt_len = skb->len;
+	ret = gro_cells_receive(&peer->ovpn->gro_cells, skb);
+	if (likely(ret == NET_RX_SUCCESS))
+		/* update RX stats with the size of decrypted packet */
+		dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
+}
+
+static void ovpn_decrypt_post(struct sk_buff *skb, int ret)
+{
+	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
+
+	if (unlikely(ret < 0))
+		goto drop;
+
+	ovpn_netdev_write(peer, skb);
+	/* skb is passed to upper layer - don't free it */
+	skb = NULL;
+drop:
+	if (unlikely(skb))
+		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
+	ovpn_peer_put(peer);
+	kfree_skb(skb);
+}
+
+/* RX path entry point: decrypt packet and forward it to the device */
+void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	ovpn_skb_cb(skb)->peer = peer;
+	ovpn_decrypt_post(skb, 0);
+}
+
 static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
 {
 	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index afea5f81f5628dcb9afda9a78974bbf6f2101c13..1cfa66873a2d4840ce57e337f8b4e8143e8b8e79 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -21,4 +21,6 @@
 
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
+void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index e58739d82da54001a346c38e5c5a882589eb3801..241f2345298ab149d79b2dc04a1e52cfcb52d12c 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
+#include <net/gro_cells.h>
 #include <net/ip.h>
 #include <net/rtnetlink.h>
 #include <uapi/linux/if_arp.h>
@@ -21,10 +22,20 @@
 #include "io.h"
 #include "peer.h"
 #include "proto.h"
+#include "udp.h"
 
 static int ovpn_net_init(struct net_device *dev)
 {
-	return 0;
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	return gro_cells_init(&ovpn->gro_cells, dev);
+}
+
+static void ovpn_net_uninit(struct net_device *dev)
+{
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	gro_cells_destroy(&ovpn->gro_cells);
 }
 
 static int ovpn_net_open(struct net_device *dev)
@@ -50,6 +61,7 @@ static int ovpn_net_stop(struct net_device *dev)
 
 static const struct net_device_ops ovpn_netdev_ops = {
 	.ndo_init		= ovpn_net_init,
+	.ndo_uninit		= ovpn_net_uninit,
 	.ndo_open		= ovpn_net_open,
 	.ndo_stop		= ovpn_net_stop,
 	.ndo_start_xmit		= ovpn_net_xmit,
@@ -226,6 +238,8 @@ static int __init ovpn_init(void)
 		goto unreg_rtnl;
 	}
 
+	ovpn_udp_init();
+
 	return 0;
 
 unreg_rtnl:
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index fae2682b424b03222a5ce881a4a1b4518a7ff311..9d0640e9c71e7fd494e3d9df155732bd5d82463e 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNSTRUCT_H_
 #define _NET_OVPN_OVPNSTRUCT_H_
 
+#include <net/gro_cells.h>
 #include <uapi/linux/if_link.h>
 #include <uapi/linux/ovpn.h>
 
@@ -20,6 +21,7 @@
  * @mode: device operation mode (i.e. p2p, mp, ..)
  * @lock: protect this object
  * @peer: in P2P mode, this is the only remote peer
+ * @gro_cells: pointer to the Generic Receive Offload cell
  */
 struct ovpn_priv {
 	struct net_device *dev;
@@ -27,6 +29,7 @@ struct ovpn_priv {
 	enum ovpn_mode mode;
 	spinlock_t lock; /* protect writing to the ovpn_priv object */
 	struct ovpn_peer __rcu *peer;
+	struct gro_cells gro_cells;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
index 5f95a78bebd3702868ffeeab3ea4938e957d568c..591b97a9925fd9b91f996d6d591fac41b1aa6148 100644
--- a/drivers/net/ovpn/proto.h
+++ b/drivers/net/ovpn/proto.h
@@ -10,6 +10,11 @@
 #ifndef _NET_OVPN_PROTO_H_
 #define _NET_OVPN_PROTO_H_
 
+#include "main.h"
+
+#include <linux/bitfield.h>
+#include <linux/skbuff.h>
+
 /* When the OpenVPN protocol is ran in AEAD mode, use
  * the OpenVPN packet ID as the AEAD nonce:
  *
@@ -34,5 +39,48 @@
 #define OVPN_NONCE_WIRE_SIZE (OVPN_NONCE_SIZE - OVPN_NONCE_TAIL_SIZE)
 
 #define OVPN_OPCODE_SIZE		4 /* DATA_V2 opcode size */
+#define OVPN_OPCODE_KEYID_MASK		0x07000000
+#define OVPN_OPCODE_PKTTYPE_MASK	0xF8000000
+#define OVPN_OPCODE_PEERID_MASK		0x00FFFFFF
+
+/* packet opcodes of interest to us */
+#define OVPN_DATA_V1			6 /* data channel v1 packet */
+#define OVPN_DATA_V2			9 /* data channel v2 packet */
+
+#define OVPN_PEER_ID_UNDEF		0x00FFFFFF
+
+/**
+ * ovpn_opcode_from_skb - extract OP code from skb at specified offset
+ * @skb: the packet to extract the OP code from
+ * @offset: the offset in the data buffer where the OP code is located
+ *
+ * Note: this function assumes that the skb head was pulled enough
+ * to access the first 4 bytes.
+ *
+ * Return: the OP code
+ */
+static inline u8 ovpn_opcode_from_skb(const struct sk_buff *skb, u16 offset)
+{
+	u32 opcode = be32_to_cpu(*(__be32 *)(skb->data + offset));
+
+	return FIELD_GET(OVPN_OPCODE_PKTTYPE_MASK, opcode);
+}
+
+/**
+ * ovpn_peer_id_from_skb - extract peer ID from skb at specified offset
+ * @skb: the packet to extract the OP code from
+ * @offset: the offset in the data buffer where the OP code is located
+ *
+ * Note: this function assumes that the skb head was pulled enough
+ * to access the first 4 bytes.
+ *
+ * Return: the peer ID
+ */
+static inline u32 ovpn_peer_id_from_skb(const struct sk_buff *skb, u16 offset)
+{
+	u32 opcode = be32_to_cpu(*(__be32 *)(skb->data + offset));
+
+	return FIELD_GET(OVPN_OPCODE_PEERID_MASK, opcode);
+}
 
-#endif /* _NET_OVPN_PROTO_H_ */
+#endif /* _NET_OVPN_OVPNPROTO_H_ */
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index a4a8686f2e2995dca163d5b96c6c897b86434967..6de1e8c85a3d35a5d4f179d595d2409aa34cdc01 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -23,8 +23,10 @@ static void ovpn_socket_release_kref(struct kref *kref)
 	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
 						refcount);
 
-	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
+	if (sock->sock->sk->sk_protocol == IPPROTO_UDP) {
 		ovpn_udp_socket_detach(sock);
+		netdev_put(sock->ovpn->dev, &sock->dev_tracker);
+	}
 
 	kfree_rcu(sock, rcu);
 }
@@ -200,6 +202,15 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 		goto sock_release;
 	}
 
+	if (sock->sk->sk_protocol == IPPROTO_UDP) {
+		/* in UDP we only link the ovpn instance since the socket is
+		 * shared among multiple peers
+		 */
+		ovpn_sock->ovpn = peer->ovpn;
+		netdev_hold(peer->ovpn->dev, &ovpn_sock->dev_tracker,
+			    GFP_KERNEL);
+	}
+
 	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
 sock_release:
 	release_sock(sock->sk);
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index ade8c94619d7b2f905b5284373dc73f590188399..e5b94afe0cfa59ecd41007779456d083d8c1555f 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -20,12 +20,21 @@ struct ovpn_peer;
 /**
  * struct ovpn_socket - a kernel socket referenced in the ovpn code
  * @ovpn: ovpn instance owning this socket (UDP only)
+ * @dev_tracker: reference tracker for associated dev (UDP only)
+ * @udp_prot: pointer to the original socket sk_proto (UDP only)
  * @sock: the low level sock object
  * @refcount: amount of contexts currently referencing this object
  * @rcu: member used to schedule RCU destructor callback
  */
 struct ovpn_socket {
-	struct ovpn_priv *ovpn;
+	union {
+		struct {
+			struct ovpn_priv *ovpn;
+			netdevice_tracker dev_tracker;
+			struct proto *udp_prot;
+		};
+	};
+
 	struct socket *sock;
 	struct kref refcount;
 	struct rcu_head rcu;
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index ae76ae6d372f565715a39ee24e3fba14f1c1370e..81f0ec332fc885d53e5a357512628f245ef3774f 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -15,6 +15,7 @@
 #include <net/dst_cache.h>
 #include <net/route.h>
 #include <net/ipv6_stubs.h>
+#include <net/transp_v6.h>
 #include <net/udp.h>
 #include <net/udp_tunnel.h>
 
@@ -23,9 +24,117 @@
 #include "bind.h"
 #include "io.h"
 #include "peer.h"
+#include "proto.h"
 #include "socket.h"
 #include "udp.h"
 
+static struct proto ovpn_udp_prot __ro_after_init;
+static struct proto ovpn_udp6_prot __ro_after_init;
+
+/* Retrieve the corresponding ovpn object from a UDP socket
+ * rcu_read_lock must be held on entry
+ */
+static struct ovpn_socket *ovpn_socket_from_udp_sock(struct sock *sk)
+{
+	struct ovpn_socket *ovpn_sock;
+
+	if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
+		return NULL;
+
+	ovpn_sock = rcu_dereference_sk_user_data(sk);
+	if (unlikely(!ovpn_sock))
+		return NULL;
+
+	/* make sure that sk matches our stored transport socket */
+	if (unlikely(!ovpn_sock->sock || sk != ovpn_sock->sock->sk))
+		return NULL;
+
+	return ovpn_sock;
+}
+
+/**
+ * ovpn_udp_encap_recv - Start processing a received UDP packet.
+ * @sk: socket over which the packet was received
+ * @skb: the received packet
+ *
+ * If the first byte of the payload is:
+ * - DATA_V2 the packet is accepted for further processing,
+ * - DATA_V1 the packet is dropped as not supported,
+ * - anything else the packet is forwarded to the UDP stack for
+ *   delivery to user space.
+ *
+ * Return:
+ *  0 if skb was consumed or dropped
+ * >0 if skb should be passed up to userspace as UDP (packet not consumed)
+ * <0 if skb should be resubmitted as proto -N (packet not consumed)
+ */
+static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
+{
+	struct ovpn_socket *ovpn_sock;
+	struct ovpn_priv *ovpn;
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	u8 opcode;
+
+	ovpn_sock = ovpn_socket_from_udp_sock(sk);
+	if (unlikely(!ovpn_sock)) {
+		net_err_ratelimited("ovpn: %s invoked on non ovpn socket\n",
+				    __func__);
+		goto drop_noovpn;
+	}
+
+	ovpn = ovpn_sock->ovpn;
+	if (unlikely(!ovpn)) {
+		net_err_ratelimited("ovpn: cannot obtain ovpn object from UDP socket\n");
+		goto drop_noovpn;
+	}
+
+	/* Make sure the first 4 bytes of the skb data buffer after the UDP
+	 * header are accessible.
+	 * They are required to fetch the OP code, the key ID and the peer ID.
+	 */
+	if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) +
+				    OVPN_OPCODE_SIZE))) {
+		net_dbg_ratelimited("%s: packet too small from UDP socket\n",
+				    netdev_name(ovpn->dev));
+		goto drop;
+	}
+
+	opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
+	if (unlikely(opcode != OVPN_DATA_V2)) {
+		/* DATA_V1 is not supported */
+		if (opcode == OVPN_DATA_V1)
+			goto drop;
+
+		/* unknown or control packet: let it bubble up to userspace */
+		return 1;
+	}
+
+	peer_id = ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
+	/* some OpenVPN server implementations send data packets with the
+	 * peer-id set to UNDEF. In this case we skip the peer lookup by peer-id
+	 * and we try with the transport address
+	 */
+	if (peer_id == OVPN_PEER_ID_UNDEF)
+		peer = ovpn_peer_get_by_transp_addr(ovpn, skb);
+	else
+		peer = ovpn_peer_get_by_id(ovpn, peer_id);
+
+	if (unlikely(!peer))
+		goto drop;
+
+	/* pop off outer UDP header */
+	__skb_pull(skb, sizeof(struct udphdr));
+	ovpn_recv(peer, skb);
+	return 0;
+
+drop:
+	dev_core_stats_rx_dropped_inc(ovpn->dev);
+drop_noovpn:
+	kfree_skb(skb);
+	return 0;
+}
+
 /**
  * ovpn_udp4_output - send IPv4 packet over udp socket
  * @peer: the destination peer
@@ -263,6 +372,10 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct socket *sock,
 int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
 			   struct ovpn_priv *ovpn)
 {
+	struct udp_tunnel_sock_cfg cfg = {
+		.encap_type = UDP_ENCAP_OVPNINUDP,
+		.encap_rcv = ovpn_udp_encap_recv,
+	};
 	struct socket *sock = ovpn_sock->sock;
 	struct ovpn_socket *old_data;
 	int ret;
@@ -273,6 +386,14 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
 	if (!old_data) {
 		/* socket is currently unused - we can take it */
 		rcu_read_unlock();
+		setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
+
+		ovpn_sock->udp_prot = sock->sk->sk_prot;
+
+		if (sock->sk->sk_family == AF_INET)
+			sock->sk->sk_prot = &ovpn_udp_prot;
+		else
+			sock->sk->sk_prot = &ovpn_udp6_prot;
 		return 0;
 	}
 
@@ -306,4 +427,45 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
  */
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
+	struct udp_tunnel_sock_cfg cfg = { };
+
+	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
+			      &cfg);
+	ovpn_sock->sock->sk->sk_prot = ovpn_sock->udp_prot;
+}
+
+static void ovpn_udp_close(struct sock *sk, long timeout)
+{
+	struct ovpn_socket *sock;
+	struct ovpn_priv *ovpn;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	if (!sock || !sock->ovpn) {
+		rcu_read_unlock();
+		return;
+	}
+	ovpn = sock->ovpn;
+	rcu_read_unlock();
+
+	if (ovpn->mode == OVPN_MODE_P2P)
+		ovpn_peer_release_p2p(ovpn, sk,
+				      OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
+	sock->udp_prot->close(sk, timeout);
+}
+
+static void ovpn_udp_build_protos(struct proto *new_prot,
+				  const struct proto *orig_prot)
+{
+	memcpy(new_prot, orig_prot, sizeof(*new_prot));
+	new_prot->close = ovpn_udp_close;
+}
+
+void __init ovpn_udp_init(void)
+{
+	ovpn_udp_build_protos(&ovpn_udp_prot, &udp_prot);
+
+#if IS_ENABLED(CONFIG_IPV6)
+	ovpn_udp_build_protos(&ovpn_udp6_prot, &udpv6_prot);
+#endif
 }
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index 9994eb6e04283247d8ffc729966345810f84b22b..ac71f2bcb2a774eedf31fa1e17a5e0d7f67c479f 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -15,6 +15,8 @@ struct ovpn_peer;
 struct ovpn_priv;
 struct socket;
 
+void __init ovpn_udp_init(void);
+
 int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
 			   struct ovpn_priv *ovpn);
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3a0d6c5a8286b1685e8a1dec50365fe392ab9a87..8793b27273d6004dc3e9fbd459a076be822bdfea 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1933,6 +1933,7 @@ struct proto udpv6_prot = {
 	.h.udp_table		= NULL,
 	.diag_destroy		= udp_abort,
 };
+EXPORT_SYMBOL_GPL(udpv6_prot);
 
 static struct inet_protosw udpv6_protosw = {
 	.type =      SOCK_DGRAM,

-- 
2.45.3


