Return-Path: <linux-kselftest+bounces-22979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48219E8DFC
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246EE1886A55
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 08:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E3F217675;
	Mon,  9 Dec 2024 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ccym4vIC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D65216E13
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734393; cv=none; b=Twh9cMfHAsBrVmTKG6AwiVymXwwkslZUM0TkcIgV642MdaKC3243zVGP/tdOs319+VVS6gqy66KSUPIpNLRddTxJo7U9uC+YieLuzbdA2EBOvned/XujL+896FuqGJrsdhPnkon/0S2tXwa8vI2tE6pp1pVP8TWBpK/QWitJcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734393; c=relaxed/simple;
	bh=8xiGih1CQi/TNJQ5ByFDbsrz7I5PKWACy+oZz4SVIVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDIbmWHzcT+7RVjFKX+xuqq1rIoeofA4OPgfStuQUWgvihmMgzDUtsx4JM1lgfZPdnjPtNzlbGWoMDqB2rLFGPRpPshW785wQgc1vH2CQJ11xFTr9PDXL83vhUWjbbbUEjVBHLV2rUYPZ+eyVPNQB7j8Imp6921utJkMcw77ES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ccym4vIC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434fac2996fso4806005e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 00:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734388; x=1734339188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aw2Aul95ypW2sz09aIkVMXzFNhImeuRyk30EVCGbNa0=;
        b=Ccym4vIClvy4EqCxpnG3CJUnCvjox5U6ILI9NrUmXJfdkw7E2dUsfMnThx4VZ8oor8
         gJInFE9GBhA5XtdnmWlsTVaKuyDiqLFfF3zgM1+HwzlU8XKHwYXSTf0WR6vjw/yQxUiy
         h2cvlEHA1vO9QWCJGMWKNeT7cK8yi/f1xY1Fm7bfYsk98kjsOd2/6CUjSiOYUaOe9pP+
         NChzxwveq4IiBkgXBjkAfLSL+NK4MjtdvBznYWK/mMsVrKGxtsQpxv8QV10iU9mzt4ID
         6Yrl3Gj2vUn1Qwf4OF0CkDKl8xB7inWUcau9R08LGx5OFZ4gbCJKIWRPvmkWE518O3Kt
         LOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734388; x=1734339188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aw2Aul95ypW2sz09aIkVMXzFNhImeuRyk30EVCGbNa0=;
        b=rxzjTDF0+IaFaFeVmnfDgEyk/uWK2tQsamz70oVeEYOnLz+nhhJvIEDO2mQJw/oHyT
         sX7cFtz+b1bCGqL8q4yxtBYS78Y5hZXcjQmqVlGEwE61mNYzCdp0sLNUNnAAs/gSTgb0
         x3J8gVV7/01cO9NciDYDKdu743CUpUNfYvPgZ8VvYblbPlR2GamH/MnpEotiX+KQM8/6
         9GbHLRKLs7g3owAmevdjyxXMZgjMf0jb+AYepjo0+lqsPFYEfuEGPi6iLrnutkEknI0L
         i127dPzKe0MlijVH/pr1jruKVMTqUGMlhjRenx864AkBwHo/F7fHdMg/yIRlNeh2/qbX
         uRlA==
X-Forwarded-Encrypted: i=1; AJvYcCXMXlGhB9ez72Vh9ZOIWUk7ZrKzw5cKhQEFjIrbDwrFZLRo/fCplRsm9gP9ywvROa52uXUI2KuWM4NHClSn1zI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzvwmc7TOZyVPtXz1olGAO55g+BL5KzCUOmjBWFCczo8MRUcaV
	u1i1KTCCdCjcmWQcsR+YDcpM6jzdl7JnWdD8gnuUfOx47FwQRABElF9ZKPEB3tyP5sGRAwxZOP/
	B
X-Gm-Gg: ASbGncsNiilUG2la+RRWY75by0aZhWydr66KiBsdjTfiKGu0UnyRO9Fro2HoSiZq7DG
	1HipovyOJIV9q29j38szL1K2hOjwsuZwvSVGd0BWGEliR1l3tkm9Xm+Wnwn/m8U8rFMiteRe9db
	M37MgTbl3jjBF59NDJe/OdLEnyAHsPKSq9wb0QPn8lHE3R8fznaDm/qTg8vK15PNe3B3lwCNnBl
	YtOV7Ffo8x3MZkosDKiYWDtqVS2+crDkefYBi6X2Sdm/8wnTt1FSVXdNr+g
X-Google-Smtp-Source: AGHT+IGGEhPpPCjEmCkg/k2lCDYLM/cC2yJEqtb91xfOp+frzKR2tOiKNJG/lrrJ04EyAWS/p+2aqQ==
X-Received: by 2002:a05:600c:1ca8:b0:434:f5d1:f10f with SMTP id 5b1f17b1804b1-434f5d1f2c1mr30464645e9.17.1733734388500;
        Mon, 09 Dec 2024 00:53:08 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:08 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:17 +0100
Subject: [PATCH net-next v14 08/22] ovpn: implement basic RX path (UDP)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-8-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13559; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=8xiGih1CQi/TNJQ5ByFDbsrz7I5PKWACy+oZz4SVIVw=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrAT4le+YWiwhSb4kHD2BV3qZ8NAbXojT8F0Q
 jz89zWrWN6JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awEwAKCRALcOU6oDjV
 h9PEB/0a3tcPeMfx4EMCUAE6GYtb+ReezV/IXlBSLcWQl5Dp6+Mo1ckZnxj+MJdCkeRVE2Z00j3
 yiwuvcwRBS+Q33+3sePX2mA1OOYv1uyJ4xrnExCx/hL2ANo0KIjEL7wGNek8iRTIgGTtGRjy2dC
 LYkSncnxFNGx6mQCWhAI9i7x+chBGIRH69BRjyOu99ehbRABvpSemCnF/QNST5GJFy03O8VzDoI
 JuO5ZQqTpJZoeB6uO3UGLPUcairSo1Vu4BBFgDh9qi0U2/PYbkGaursH5kaBfqoM4SMr4QaQWRV
 XPwJwzd0O7CRfxIoPZbbZ9irLBaZR76yCpQ9cGdpyCcAVlp1
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Packets received over the socket are forwarded to the user device.

Implementation is UDP only. TCP will be added by a later patch.

Note: no decryption/decapsulation exists yet, packets are forwarded as
they arrive without much processing.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c         | 64 +++++++++++++++++++++++++++++-
 drivers/net/ovpn/io.h         |  2 +
 drivers/net/ovpn/main.c       | 13 +++++-
 drivers/net/ovpn/ovpnstruct.h |  3 ++
 drivers/net/ovpn/proto.h      | 50 ++++++++++++++++++++++-
 drivers/net/ovpn/socket.c     | 24 +++++++++++
 drivers/net/ovpn/udp.c        | 92 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/udp.h        |  3 +-
 8 files changed, 246 insertions(+), 5 deletions(-)

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
index c37cb47495f04bb7a6facdf30e5877ddef0ddb29..c27e4c190f5bdf061a71c516344551ef7cd31496 100644
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
index 0abac02e13fb4ef1e212dacae075d5b58e872d34..e10590924e3f9fe605309989be84866e2e508944 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -23,6 +23,9 @@ static void ovpn_socket_detach(struct socket *sock)
 	if (!sock)
 		return;
 
+	if (sock->sk->sk_protocol == IPPROTO_UDP)
+		ovpn_udp_socket_detach(sock);
+
 	sockfd_put(sock);
 }
 
@@ -70,6 +73,27 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
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
index c0e7aa289ad3345fcd91e7c890f70961300c356f..975392fc39bc4c0107a07a53795afecd88d72c53 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -23,9 +23,83 @@
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
+		net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket\n",
+				    netdev_name(ovpn->dev));
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
@@ -262,8 +336,12 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb)
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
@@ -271,6 +349,7 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
 	if (!old_data) {
 		/* socket is currently unused - we can take it */
 		rcu_read_unlock();
+		setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
 		return 0;
 	}
 
@@ -297,3 +376,14 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
 
 	return ret;
 }
+
+/**
+ * ovpn_udp_socket_detach - clean udp-tunnel status for this socket
+ * @sock: the socket to clean
+ */
+void ovpn_udp_socket_detach(struct socket *sock)
+{
+	struct udp_tunnel_sock_cfg cfg = { };
+
+	setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
+}
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index 44ebeb82325dc4d172da7e29fb36f21a5609ea8d..90a46821d1e999fea0e1aa0f7de9db65decf71d5 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -16,7 +16,8 @@ struct ovpn_priv;
 struct socket;
 
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn);
-
+void ovpn_udp_socket_detach(struct socket *sock);
 void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb);
+struct ovpn_priv *ovpn_from_udp_sock(struct sock *sk);
 
 #endif /* _NET_OVPN_UDP_H_ */

-- 
2.45.2


