Return-Path: <linux-kselftest+bounces-24337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EEDA0B2F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 10:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2207C7A4904
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3382A2500B9;
	Mon, 13 Jan 2025 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bNN6vpIY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4223A592
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760679; cv=none; b=EgvtqEatIkRbiDOF7yS4OSJTX5rd/0lc4FE/JDYaZHpkla4u3AfsNrRJA5p4ee/mhrTVcuNBvu/nQ+okuAZIzH3rLXCXYaCPUKHJktNsGR7YRT2ayVdIrM00VRRJV9mbkiIAjPzNa7fdsJwIvm8eyCn+sCjhtEiXpODjS7KQ6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760679; c=relaxed/simple;
	bh=f/ZFvXw8aBdPxN0APFZ1KQ3IzeEyB7t6eZ6UOQ0Hbjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HJDgWmv2jukTLyaWJ32WCOwyS1SXpJKmpgdtFSMZ7nZhKz4LqjOz+xjf5mcT26yMNPJv40StgoB5Smwg2dvH/XvFGRbuYJVpFboaJVxsivoedx0ZijS/1QQ290lUWiKbRQQ0OYO0NfimID8YWg5DF6M0f95IVz9OXh5wmAYwezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bNN6vpIY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43675b1155bso46365425e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 01:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760674; x=1737365474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EDQ+r6uFvwVDVY2ubXIKUI82sgLKZYHEnaMqJ1N/EU=;
        b=bNN6vpIYBPRljQkNmqAoeU+zyfRqNBf8lflhHMho6wT7y/+994oV3SekCktkLJv4Mu
         /6dhnNl7RfseVN8Dvi/cuROZB+f9GUNQkBb/a6k4Xo0fG/KcfyK4tefwMmh6HXDPDC/B
         OJij10eBPtEaDw90gLNfkAXKt1+oiesPdO0cJ844z+AbxI1DqT+0Ed7IH8pMiO3ECURp
         tHEK52Czjy9sVgKS228hPKqSGn7l2csnvxIDgwcvRD/4I7UoMK+xRnZMbeUShyFKoSB6
         wq/a+EM/QdvwZ2+0lsQUHTKMbjvHoqt5RVR7uGaNa5i/OPsW7IwVWDJy9fD5X9aHFv1C
         qXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760674; x=1737365474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EDQ+r6uFvwVDVY2ubXIKUI82sgLKZYHEnaMqJ1N/EU=;
        b=RSdvX0bcNNgs172fl7xfN259p+O7WA0qI8LxtnWzdWoFOxCJ6QU8qQpCmhgK8lGtqk
         evlSYD3E3uhyiQF9PraX52Rq5Asy6KLTOmvZ4yb6x4QbbvyVcoc+tsjVRywimGinpBgt
         rXFHF1u2XX5Vl/b4qtzllY/v0wMxme4PIwWUBjYPI3tZt5HVwzaJS0SaygnQx7Qis9NQ
         m94Ain2NYg1GmX0MFnS4F21vlVM6WWRwCfEcQ+Fv0PjaMeAWl56BKP19cnoRX2fqAR8O
         kYFI+QnwGIQYuCUYTrX+05drtUCV+T2QCUaO8zqiiXhGu0lhIOgXVCQL2DuhwDhfyxUu
         2kOg==
X-Forwarded-Encrypted: i=1; AJvYcCXC9+j3ImuZtCpB2TVwQr+kPYahZyjPBz2tdJoagIL9FSfqB8y/J6wIouWBgrABPKDtwv1DDBbUS7tiaUf6WbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsrzgMiN6eyHqAr+KJS+GFWz2898JDggBRXPJvwi5hXxoPcXLb
	E2hf6+CfqZsJ4KHtpSlZVltG6sM3rttqtolMb0h80WJnmVAI/K8JLIpN6ZHNPwQ=
X-Gm-Gg: ASbGncsIVJpn2p8a3wPfcJmouoMcRIogcvuhBZz5wvYsEPMEK4zX+HeT4gEWkiGQxPW
	9519iI0Cb2BfTcXiJEIi5ZKiYCNWuAwiXV3hNqhTtaaO8dDwI33PSwvfrU0rJGgwW+YC7SRsHcC
	bU9nTYWy8zT6iYv6PrBUCN0dhAXNG8l1O0k/VnocPWPOWTQiOo3Kael5hKvPGDzZMLlHVg6qF9g
	8/rsz05HY0TjjoGbuuOOXSk9JZovGsE8pwz43uzJ2N4xLQpPqWt2BwZioJPHyrNgOiP
X-Google-Smtp-Source: AGHT+IFcaxancHMJeMhw75zDYA/uxvKI/MAb0Q0GJLsS4U6dhAN2NkwijuLh9qMdHu6olIIDgrd7Tw==
X-Received: by 2002:a05:6000:1847:b0:386:3825:2c3b with SMTP id ffacd0b85a97d-38a87304672mr15970270f8f.18.1736760673781;
        Mon, 13 Jan 2025 01:31:13 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:13 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 13 Jan 2025 10:31:27 +0100
Subject: [PATCH net-next v18 08/25] ovpn: implement basic RX path (UDP)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-ovpn-v18-8-1f00db9c2bd6@openvpn.net>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
In-Reply-To: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14718; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=f/ZFvXw8aBdPxN0APFZ1KQ3IzeEyB7t6eZ6UOQ0Hbjc=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2G+t2mkRVoH0AUZurW47QFkaqVlGWwFVZ9f
 xDPSMQxYR+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdhgAKCRALcOU6oDjV
 h5FsB/4k17CFkvU8XiVzWqt6SWABcGe2euVBkmQ5AYB433yEDBpEdF0LNV1g43N7U4NglOwRR+k
 xksbQI4oOM+NeZFbgQ96krNpINR+pzg8Rvfn7Udyn84ji4LpzQWa0BnA/jPTFXY8wClvwbXV5px
 ReRw8QwRRqfrMTNWB8fRMsPvkv0iasKS2Yw3suEfdMC55s86Tqi+Ta/VtIzruT5tg754+kuecud
 evKIRFJaO/aLuIkXG6CvlD6yX73eDd9qSF5NJSqFFCRGbxVp8j5Xam1aBaq0lU/V3YfmW5vMmrn
 M5hU8pBpbAd+P8Hura3+sCwMBRpoGB0QdirKvrMc4BO1PdPy
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Packets received over the socket are forwarded to the user device.

Implementation is UDP only. TCP will be added by a later patch.

Note: no decryption/decapsulation exists yet, packets are forwarded as
they arrive without much processing.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c         |  64 ++++++++++++++++++++++-
 drivers/net/ovpn/io.h         |   2 +
 drivers/net/ovpn/main.c       |  13 ++++-
 drivers/net/ovpn/ovpnstruct.h |   3 ++
 drivers/net/ovpn/proto.h      |  50 +++++++++++++++++-
 drivers/net/ovpn/socket.c     |   9 ++++
 drivers/net/ovpn/socket.h     |   9 +++-
 drivers/net/ovpn/udp.c        | 116 +++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/udp.h        |   1 -
 9 files changed, 261 insertions(+), 6 deletions(-)

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
index bcfbc5f59f92f5d666e27b421382a714e45dd066..713702a475c56c4d4fcb15ad5b100405d78a5ff7 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
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
index a77d90870fb7522abf08049c72fc1c2bfc26b32a..f3bb709e96e46434729121239eec4163638b62e8 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -178,6 +178,15 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	ovpn_sock->sock = sock;
 	kref_init(&ovpn_sock->refcount);
 
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
index aab26b575df9c886a078c2884900c362a6bf0eb2..cb1c45d3a543ba575505fde7a63f76fd8aca3156 100644
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
index eb1bd38724ff9ea070e5f29a90b7964857398787..0807dd824d3627a126bab15ad351ddf6647d25b0 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -23,9 +23,111 @@
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
@@ -262,8 +364,12 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb)
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
@@ -271,6 +377,7 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
 	if (!old_data) {
 		/* socket is currently unused - we can take it */
 		rcu_read_unlock();
+		setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
 		return 0;
 	}
 
@@ -304,4 +411,11 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
  */
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
+	struct udp_tunnel_sock_cfg cfg = { };
+
+	if (ovpn_sock->ovpn)
+		/* drop reference to netdev held in sk_user_data */
+		netdev_put(ovpn_sock->ovpn->dev, &ovpn_sock->dev_tracker);
+	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
+			      &cfg);
 }
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index d0be0963b578bb46ddc9a3115bd474c1f43893c1..eb146f7284efc115e919a1b77dc1779b7faa1b19 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -17,7 +17,6 @@ struct socket;
 
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn);
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock);
-
 void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb);
 
 #endif /* _NET_OVPN_UDP_H_ */

-- 
2.45.2


