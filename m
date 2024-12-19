Return-Path: <linux-kselftest+bounces-23549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF2C9F7201
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C9A1894F41
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80F219DF48;
	Thu, 19 Dec 2024 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="M9tRxB/O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ADF199E84
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572537; cv=none; b=J1Arv874h6ZVCdRyyOYs3H+V3mi6zO0zJau3UcApsga0tLglKf09RSQkJymk9k2+CdbLrLREMscGuyDi85jlIG5s+BNoE2vtMsL8eYuR9wv9drnuBQAkm5JepUYHJyW8ixCoLb2rKGOepk0WduCs9uOQdf6s/QCidYLMDepDCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572537; c=relaxed/simple;
	bh=G3o75mECEiv5NDbplEHNwy4rk6vMAWM5t0ag7a21wA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNCFjum0a3qu0r7NRLNcBS99t/RZPg9ZZ81uMvfXQl52grSHKSEta15B/r3Eq0995vitfV6KoyKQSo3t0qaSTp0eUt0IoFRcKxhi1P31fLlxRndOmYAzz/x6z6oBbKrQl4WvdMf6zPcg4EEW6XkLMnfhOtvgyTL1q74lS+PsERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=M9tRxB/O; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862b364538so143025f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572533; x=1735177333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yupCsG0X6uLl1aaEsHYCPnk6gI9tcBz+v8TkhgCurW8=;
        b=M9tRxB/OQUXIrW8DRPpZe3mzpblxQWzjjnX84Aep+Rx+p/UvA+9KPah9lhacjXDvQw
         nOIC+t7GtPuEEZZNdeJb9hvs1K7XbS8g/PwezJpPh+CIy4N2/ZJZ1iMNeJIS/CLszBPo
         2V+4yFmF75hE5wJ52qBlUmXypgXVvwmEZu2rpQWuTve5O8LOPZrNYqQD6TT9KISgm9dn
         1O6zX6Y+kpDdqaE1R7fwF9q4iDyUpGkPTnEwmRjKM7ob6acgzvdjP+KiPuW/ZHcEz39E
         A4PpzyEwTJ376JAUMdWWBNoDhy/qDwJL6VKCS4F62e0r97Vq0/yDDTDZ0kRylaPTAVS7
         McRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572533; x=1735177333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yupCsG0X6uLl1aaEsHYCPnk6gI9tcBz+v8TkhgCurW8=;
        b=QhG0XewyDKBrGbhPnmUln4eY6t72nbq1NAUNQCIgSC2iMU9Hn5Uu4NlE3DEJclgviz
         a9ff7tRNec7wgvRlxKnzskM4z6+RCPy2kZ3pw72CQHYhEx+poIjvPBxYIjq7pDP9nQ2T
         PdyjDyXQg9d6vAkYuWH/JTkFeyaKozafcDcCUNvRqpQGKUCRbc92UA9rcpujXKyFnmbs
         IriwGFXzHiF9UODGcKdb2IKMVZfuXR/njiv/JsV3Dc0PeYlblO408HodN8MyoepWHSrs
         offdaPDcqrcIlfwHjjDeDlSY+F6F4nHMevv7hqxH7jwAJsoGnXgR13qRJ+7BktGbzvU8
         kCrg==
X-Forwarded-Encrypted: i=1; AJvYcCWSSvaYG78Pn9oXoKVanqaNSiGHMd82YNn2hB7XKbf6w1kxRB/GT6nmA9Lkazke4GzQYeNuhvidyLiQz8m9IX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/mdrL4AQbwnpVvzanhzebDdTpazOqJCrRzo1c+0WgmVF94dxl
	M8xhwPG2B5xLefjL8cb4yw+BCTpGWkCYdVz8ZUSaOxUgD0VviIxpwnqk6IM4/iU=
X-Gm-Gg: ASbGncu2LZyP4V9iBkkTxCnCbK3Zwq8N8riV9zlrHZbiz6kpVu+mNbullmv0sl56L0y
	2TVYBfVJ/fON4ef70IUUGzHCCU6izVj4FFwyQ6NPcaS1m2szQJs0jnbr+IFi9fF92s+ecOuw5SA
	VvpFvDOHdJIReLG0o0sFuqrM1bAP+kVtsiuoWCAF/ZZDJEurfbHURa0UtvuXz74W5TK0UN2yqp4
	EFHsrjyv+YLJpHhhXCsIdkHh1C9VQpM3nzDtrhTe7vIssvDyJEWcxPCKclRpFEsdXyd
X-Google-Smtp-Source: AGHT+IF6gZK/WEF63mtNbkvyZN5u9BPXbvHE86jguuCJJWFg4mmcbKfP573zmyNW/TUwSrNn0/L8wQ==
X-Received: by 2002:a5d:64a4:0:b0:386:374b:e8bc with SMTP id ffacd0b85a97d-38a1a221d7amr1258843f8f.15.1734572533399;
        Wed, 18 Dec 2024 17:42:13 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:11 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:03 +0100
Subject: [PATCH net-next v16 09/26] ovpn: implement basic RX path (UDP)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-9-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13893; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=G3o75mECEiv5NDbplEHNwy4rk6vMAWM5t0ag7a21wA8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oVQMLaKEKfjL0PKroAMrLkJ6/aa/Cijgic1
 jgAkbaFZBSJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FQAKCRALcOU6oDjV
 h4aCB/94XV6HCsdHz70ymcwEidG4mSWmGR1Wkmv9vLg+aXEz1KJsTIVav44iMKkZTBzt1LwSxzw
 bOrz6BGwgMQDcsZig2y0Fbuk/i0uq9GTW7GMvjUiArIxvw1JGGBLMn7tGQLb7AZvwDx4tAD28cy
 R29U+Esvo8BGnR4fRImXKD1nHxjejTeKS3/mG4lWag2ZtTnJOOqo1m1e7IneApl+6NmBqYpcBxM
 dLBoZTWirDoe7AhwusDhxm5eWlMa1mNY7N6wy8GVkbempGpl8OVFk0lR9sq/NTS5PAhhdF/hiG5
 aY1IF8mQYQDAT8XNuWPKxaof1IRyXy2Pxuobf7aTeAwHdX2k
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Packets received over the socket are forwarded to the user device.

Implementation is UDP only. TCP will be added by a later patch.

Note: no decryption/decapsulation exists yet, packets are forwarded as
they arrive without much processing.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c         | 64 ++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/io.h         |  2 ++
 drivers/net/ovpn/main.c       | 13 ++++++-
 drivers/net/ovpn/ovpnstruct.h |  3 ++
 drivers/net/ovpn/proto.h      | 50 +++++++++++++++++++++++++-
 drivers/net/ovpn/socket.c     | 32 +++++++++++++++++
 drivers/net/ovpn/udp.c        | 83 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/udp.h        |  2 +-
 8 files changed, 244 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 2a3dbc723813a14070159318097755cc7ea3f216..9f5c6b06c79681048f750fce89e9683da41ea642 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -9,15 +9,77 @@
 
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <net/gro_cells.h>
 #include <net/gso.h>
 
-#include "io.h"
 #include "ovpnstruct.h"
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
index a90537e9af6c0d2f38da229bdc2d8c639f2d11d1..b3830b787e16f3bdcaaff94e5bbe89be3e1006fe 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -21,4 +21,6 @@
 
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
+void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index a2d953dccd2cd9372f486b6f35479fb0180760b8..0dbbcf2faf129651390f47ce6098d5b6e28aa74e 100644
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
@@ -24,7 +25,16 @@
 
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
@@ -50,6 +60,7 @@ static int ovpn_net_stop(struct net_device *dev)
 
 static const struct net_device_ops ovpn_netdev_ops = {
 	.ndo_init		= ovpn_net_init,
+	.ndo_uninit		= ovpn_net_uninit,
 	.ndo_open		= ovpn_net_open,
 	.ndo_stop		= ovpn_net_stop,
 	.ndo_start_xmit		= ovpn_net_xmit,
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index a6cfb436f3d0d79a0c438e647f8652021119b0ed..1cca91d869d9e3c722a0933a426255f05daf8097 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNSTRUCT_H_
 #define _NET_OVPN_OVPNSTRUCT_H_
 
+#include <net/gro_cells.h>
 #include <net/net_trackers.h>
 #include <uapi/linux/if_link.h>
 #include <uapi/linux/ovpn.h>
@@ -22,6 +23,7 @@
  * @mode: device operation mode (i.e. p2p, mp, ..)
  * @lock: protect this object
  * @peer: in P2P mode, this is the only remote peer
+ * @gro_cells: pointer to the Generic Receive Offload cell
  */
 struct ovpn_priv {
 	struct net_device *dev;
@@ -30,6 +32,7 @@ struct ovpn_priv {
 	enum ovpn_mode mode;
 	spinlock_t lock; /* protect writing to the ovpn_priv object */
 	struct ovpn_peer __rcu *peer;
+	struct gro_cells gro_cells;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
index 00bb3725ac7ab7040c97eb012c2639b2d6967de1..34a812869b2e92e8bab0ebb87d46b67c3bbccf9f 100644
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
+ * to access the first byte.
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
index b41a95cc154ad50f86e67178a95f16e323880800..ff4b64f743641e04489c88f76293d378e54c8853 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -31,6 +31,17 @@ static void ovpn_socket_release_kref(struct kref *kref)
 	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
 						refcount);
 
+	/* UDP sockets are detached in this kref callback because
+	 * we now know for sure that all concurrent users have
+	 * finally gone (refcounter dropped to 0).
+	 *
+	 * Moreover, detachment is performed under lock to prevent
+	 * a concurrent ovpn_socket_new() call with the same socket
+	 * to find the socket still attached but with refcounter 0.
+	 */
+	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
+		ovpn_udp_socket_detach(sock->sock);
+
 	bh_unlock_sock(sock->sock->sk);
 	sockfd_put(sock->sock);
 	kfree_rcu(sock, rcu);
@@ -102,6 +113,27 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
 	return ret;
 }
 
+/* Retrieve the corresponding ovpn object from a UDP socket
+ * rcu_read_lock must be held on entry
+ */
+struct ovpn_priv *ovpn_from_udp_sock(struct sock *sk)
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
+	return ovpn_sock->ovpn;
+}
+
 /**
  * ovpn_socket_new - create a new socket and initialize it
  * @sock: the kernel socket to embed
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 5f2a3790613e7b688001ee65993031436a308b95..5932f8b5dfad1004e9e76e5fabfbb71bd9a94d4d 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -23,9 +23,82 @@
 #include "bind.h"
 #include "io.h"
 #include "peer.h"
+#include "proto.h"
 #include "socket.h"
 #include "udp.h"
 
+/**
+ * ovpn_udp_encap_recv - Start processing a received UDP packet.
+ * @sk: socket over which the packet was received
+ * @skb: the received packet
+ *
+ * If the first byte of the payload is DATA_V2, the packet is further processed,
+ * otherwise it is forwarded to the UDP stack for delivery to user space.
+ *
+ * Return:
+ *  0 if skb was consumed or dropped
+ * >0 if skb should be passed up to userspace as UDP (packet not consumed)
+ * <0 if skb should be resubmitted as proto -N (packet not consumed)
+ */
+static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
+{
+	struct ovpn_priv *ovpn;
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	u8 opcode;
+
+	ovpn = ovpn_from_udp_sock(sk);
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
@@ -262,8 +335,12 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb)
  */
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
 {
+	struct udp_tunnel_sock_cfg cfg = {
+		.encap_type = UDP_ENCAP_OVPNINUDP,
+		.encap_rcv = ovpn_udp_encap_recv,
+	};
 	struct ovpn_socket *old_data;
-	int ret = 0;
+	int ret;
 
 	/* make sure no pre-existing encapsulation handler exists */
 	rcu_read_lock();
@@ -271,6 +348,7 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
 	if (!old_data) {
 		/* socket is currently unused - we can take it */
 		rcu_read_unlock();
+		setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
 		return 0;
 	}
 
@@ -304,4 +382,7 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
  */
 void ovpn_udp_socket_detach(struct socket *sock)
 {
+	struct udp_tunnel_sock_cfg cfg = { };
+
+	setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
 }
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index b4ac15a535c24ec4979db7cb44f682af1b096ccf..90a46821d1e999fea0e1aa0f7de9db65decf71d5 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -17,7 +17,7 @@ struct socket;
 
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn);
 void ovpn_udp_socket_detach(struct socket *sock);
-
 void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb);
+struct ovpn_priv *ovpn_from_udp_sock(struct sock *sk);
 
 #endif /* _NET_OVPN_UDP_H_ */

-- 
2.45.2


