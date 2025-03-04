Return-Path: <linux-kselftest+bounces-28119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544B9A4D00F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 01:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F401897EAE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACD918A6C1;
	Tue,  4 Mar 2025 00:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cnZ0/Ngg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA241547CC
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048481; cv=none; b=DdO8PbubuWYk0aKKYfgPld4er3rdPlm8ClhqL7hHoa/L+AH7fhPKSiLJD/kbeS/1DLvKRXrobprj/Ejy0opvCpr+kAUVxrb7MHuMWU3j/V8/K1U8gZme8XIGhpc4SAl77+zRgTq28UXJjAZo/zbOp3y0vB+HwzZGc+xhypSbRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048481; c=relaxed/simple;
	bh=VhoBfJWs3ZDhvroX7DxVRatnOwepp8RCSs9tDMVlbBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGMT5QWbddbmg2AfrgbJepmgvOq6nPIb+pE+Uh/PT880mQttdLdAczfOAYftURx9I8hyAuvraYD35SKWZWp8zWR92d8srJ2hn55WnMWNcuLP5thK//DJNYi/1Uv+ZOY1mg3WAwKSzjH0qo5saoKr5TasYlS5+E5IM6ShKSTNcz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cnZ0/Ngg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390ddf037ffso2682435f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 16:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048477; x=1741653277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITEw0lVkg5Hi1ADnmSshbpsNGDpjx3yqM6aprDrjQDE=;
        b=cnZ0/Nggc8kRVA28Lk54MqBNxubB78Kfr3zumrGjfn4zU8fEmYB/9/BpnwNgcjcXnF
         /mIZhWnegSzx64poHxgN3ZG0oBZS7mandE/vSOtqaRf907g3HPkMvr+U5AQjrO9j4OFf
         Ajbvl8vjwjV44fLQwUmw1s6Ni9Gba7wrQGbfenXbVVRDOpS7w1ZI8lFuax4DujORjHT1
         jk13TuJIKtBSt9pWIKWWnmgm6uAwx8EAyGr+GKFBOQAmC7IdmcKdGm6b9KYtDy//Y3bv
         i47NDhGuAeii8YbZ7mwSrdCcJWzZ7xUJyK7R9DkHAoLKkOcDasSydY8M9H4ZuKFjsh3Q
         i3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048477; x=1741653277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITEw0lVkg5Hi1ADnmSshbpsNGDpjx3yqM6aprDrjQDE=;
        b=Y7o+sv+fUh5O1xygSuo9gzA1p6LVdQswnnHvqSWB2/1b2gqGnDTtMTd4jEHU69MhBt
         gKmS7qMEDAOijVF8+97K9d/lmIuBctgbG084EimNX99rYGDBwvTtdB+HxydMi0S67437
         oyHz9RkKoKeP3kv5tdC/kHFqZYpIBT01BPq4Lq3EY0+E/q1LsmCmaLw5NDUWpExEmuxi
         u+AGQFAlV0ojU0H6PbVQI7PrmEo/5q02n4WzgiP7SmtZYfOVduoRczZvyLKk3wmKNNVU
         8gRtcH/2eB2haePExU6Myr9B+ENoFskKslMj0pyEhX2u+0qiWPEgu1/SaILxNDeUSXeX
         a+OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT4Mn+a7r+8Rb+Zca28rl3NkTXyVS2H3ZnK3cTMgPQSTI1fVkAOWMJdAzut63UHWIfoDH2i1/O6uTGOXPijeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5W4traziHHvxJEJ7vEofrCkqlUTeWMXDYnh/3DuGZJOcOTUli
	9UJoVRS3Lg2heMWPhXsTHB7qXj0zNJvMfqirmIZAyWB4otg8BZSetFqzXUZ2WLOeLhYUgM/Yorw
	T
X-Gm-Gg: ASbGnctEKax5gYICHwvxnpeiS4NCK2GiYOzfhFaclqgHRnQb9uLsbSTNSf7nesL7iH3
	CXojDJZLmBvzVVcNd4lm3Gh7dNmvGI+nd7XD+dJ98lvinSUUoCwUj64SmArM1NwzJsjHYzPhc31
	sfSahTJp88DpusZEbHSEpFOn3w+HNJyUWHSu9jRRQg1jyQ3rBkH6QBe5z58+x5oykLT3gwjmvVw
	m5LtqFKGOHfs8RvpWRgDb1RwxC4JLFjJC8DHZzfeOZg3Mh3IzEtUtDO6mCq+AyZf2k1c073rb6m
	LtnN7dGK7QriPS75t8YZnuYypY6IegzUvrfaiFJnnw==
X-Google-Smtp-Source: AGHT+IEUF0craKLR2wtoAUK3D15VYbt5sUaGVOjF3tVbHjDI/qe+Pe4ezfrU0IRcud/KDzc0ePXHww==
X-Received: by 2002:a05:6000:1846:b0:390:f2f1:2a21 with SMTP id ffacd0b85a97d-390f2f12b6cmr10656827f8f.37.1741048477219;
        Mon, 03 Mar 2025 16:34:37 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:36 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:38 +0100
Subject: [PATCH v21 08/24] ovpn: implement basic RX path (UDP)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-8-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15804; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=VhoBfJWs3ZDhvroX7DxVRatnOwepp8RCSs9tDMVlbBQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqPaqWV8SF+zzycO4B7/Lr9GBGHCISvRZLzp
 VIGLxiAkPyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKjwAKCRALcOU6oDjV
 hxz5B/9tZIItYWu8551gPq0hBPElfPiT59DV8K+lMyFwaHrNAVXGv3fXlcPRBCGmiO9t5R9Rtef
 szCcXmY0gGXnfALTbtaDJ9+4CNGB4VDCOMgBSrGQLXico4LI544bsIkZuFTcjyVPyEQLPM3zvgL
 Fx2yxc9hbwriUlApURhT/PqBobHOxoI2qTNgbEoUr029pmvScDYinzT/4fXrGgxd2UkIXCiibeV
 6lzyXEa0aawPa2tMoWNPOhvaUxMIVvsv/oV+KJRPuDl87dHCr5ouT3vqcOoYuAEI/n9ZeJb8fRe
 Br5qtGUUEslzPLJPaWtWu2TU/1MGFpawPhvUawZf7gNprbOo
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Packets received over the socket are forwarded to the user device.

Implementation is UDP only. TCP will be added by a later patch.

Note: no decryption/decapsulation exists yet, packets are forwarded as
they arrive without much processing.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c       |  64 ++++++++++++++++++++-
 drivers/net/ovpn/io.h       |   2 +
 drivers/net/ovpn/main.c     |  14 ++++-
 drivers/net/ovpn/ovpnpriv.h |   3 +
 drivers/net/ovpn/proto.h    |  50 +++++++++++++++-
 drivers/net/ovpn/socket.c   |  13 ++++-
 drivers/net/ovpn/socket.h   |   9 ++-
 drivers/net/ovpn/udp.c      | 135 ++++++++++++++++++++++++++++++++++++++++++++
 net/ipv6/udp.c              |   1 +
 9 files changed, 286 insertions(+), 5 deletions(-)

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
index e58739d82da54001a346c38e5c5a882589eb3801..82f675f7a49ab9c35ff9686136b949a870b61c06 100644
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
index ade8c94619d7b2f905b5284373dc73f590188399..c1697f4616d470f143cba77bb1db34de0398a37a 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -20,12 +20,19 @@ struct ovpn_peer;
 /**
  * struct ovpn_socket - a kernel socket referenced in the ovpn code
  * @ovpn: ovpn instance owning this socket (UDP only)
+ * @dev_tracker: reference tracker for associated dev (UDP only)
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
+		};
+	};
+
 	struct socket *sock;
 	struct kref refcount;
 	struct rcu_head rcu;
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index ae76ae6d372f565715a39ee24e3fba14f1c1370e..6f4b51089033a8d806eede0a63f62b239197af0b 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -15,6 +15,7 @@
 #include <net/dst_cache.h>
 #include <net/route.h>
 #include <net/ipv6_stubs.h>
+#include <net/transp_v6.h>
 #include <net/udp.h>
 #include <net/udp_tunnel.h>
 
@@ -23,9 +24,114 @@
 #include "bind.h"
 #include "io.h"
 #include "peer.h"
+#include "proto.h"
 #include "socket.h"
 #include "udp.h"
 
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
@@ -250,6 +356,25 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct socket *sock,
 	}
 }
 
+static void ovpn_udp_encap_destroy(struct sock *sk)
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
+}
+
 /**
  * ovpn_udp_socket_attach - set udp-tunnel CBs on socket and link it to ovpn
  * @ovpn_sock: socket to configure
@@ -263,6 +388,11 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct socket *sock,
 int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
 			   struct ovpn_priv *ovpn)
 {
+	struct udp_tunnel_sock_cfg cfg = {
+		.encap_type = UDP_ENCAP_OVPNINUDP,
+		.encap_rcv = ovpn_udp_encap_recv,
+		.encap_destroy = ovpn_udp_encap_destroy,
+	};
 	struct socket *sock = ovpn_sock->sock;
 	struct ovpn_socket *old_data;
 	int ret;
@@ -273,6 +403,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
 	if (!old_data) {
 		/* socket is currently unused - we can take it */
 		rcu_read_unlock();
+		setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
 		return 0;
 	}
 
@@ -306,4 +437,8 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
  */
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
+	struct udp_tunnel_sock_cfg cfg = { };
+
+	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
+			      &cfg);
 }
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


