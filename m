Return-Path: <linux-kselftest+bounces-18877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C4A98CF90
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36067B24A47
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51319F43B;
	Wed,  2 Oct 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="K0nDmTLW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8D19E97A
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859813; cv=none; b=bBWsaA6p6tNkEtv1KVtRNeilcJ6whRtcwalinCmD/XDWPSUqYQF8LaX6OvE8fns2WXUhNIbAAeMvSoK21uJ20EIWz21bQn+jS0ZUZNVRU58k4siuhxY+nzs64Q6qaWD79VZfRU88vH2yYTFp9SYb+KlAhM7MLJcnctB2ZG3X00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859813; c=relaxed/simple;
	bh=aOVQzbHAS0m3aoK7vNA3UF7L4WBMhvk/aS/IndQcn5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tvjKNWEKykfLicpNX1IZkOXKeh1eBH4TE+hiDVfURArSyUDOAl0+rfS26Vsc/t0+wYC8wkitQR6FRtWLEkw0OnzXNRgltXTgdy2UhKm0gw17bRzm9R6i5v4Sq4bkpDF/t3C4q+LCefi3qZzFcfRjWiRiD8dRoW+AsA1StWxCgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=K0nDmTLW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37cd5016d98so3315502f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859809; x=1728464609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzA/7r2cf9gFl3dmCrLr/KswflOHSEY+WrEWqYFo7PU=;
        b=K0nDmTLW9ZDSjCvp21PEvMspDHDE9kcrdWY+wi/xZNJLtlt1OOj5J9oBglLCanekjP
         s2PcMc4CFJI3r5cJLvVuxaZNbGz0Hhnmbx8CZZmxUvjn8vcFCprNvMOBa9Pb4gfESZc6
         QGlBqW8aKEAjDKK1IAiamze79ur0RZH5sY2SPmV0wqUQA1oCMxdN+nrekCQfoggHnO/e
         VbSFSbRozI7mpx5+WjKP8DWqojDNiacvjnC238u/sJwyyoLUndimmW7RYhjIcYB10a9B
         xcNQ+KePKSgggXcAjZ0JCcbCvoFJOhcmkYwfY1H8OEgSKQ1Rc0ISVWb440HtvB5Dmzxx
         OVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859809; x=1728464609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzA/7r2cf9gFl3dmCrLr/KswflOHSEY+WrEWqYFo7PU=;
        b=IrgbsWUyAYGJxWDEJOurBqddXPKFf8GYyi6EhTwncnCC3mbpmk7wAAk4CdnqPV8kMW
         T36GYDicFC2o8F1xC3rkXIu+8Q4IPq3jpcua8LrokZ7zwZ6afaRHmN/66A2fGqlqSulm
         1rC6tFOQiGmMeS4sK4NZMZvI4AorrPDZbgqCWnnVXPSK1nkl9IvsYdtEFbsrdd9GZkYG
         b1zD38G1huwIKfyuj+dYq8G9qQ/0f9t+g1dBkSOZ6BjU6+UJ4NmaRZxmWh8cVGyXmqWG
         eUAdPcBMK8I7digGSBSjan5R7RSwr6uUV5lYaMLvjPn6huiN6Ci4FZ5T9S4C4PMBa4kx
         SdFg==
X-Forwarded-Encrypted: i=1; AJvYcCXlBm2K0VJ3UNSFllo38YCFvJzTdBCq4qvmi7ZlUlD/y37QVeD7A+VTQ7kFQuLUbmMeAksZh9NbIDoCWNJhePY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyiQHqt/Z3K2wNJ1SjqOBGvCr0i3NyrR8IduDLexv2hthrjQ2K
	03mcJzU6BcvhjFavSrECyxt7D1coKfja5qAq/Qg9FvsHhrQdf1fdUikb12Y7LAo=
X-Google-Smtp-Source: AGHT+IHJc5XNcrwFWCbfCKAKOBYKcPGjZR2ZYh1igjMDN3U2v0IDkG8qa94eYabW1nHDeqjDoCR10A==
X-Received: by 2002:a05:6000:cd0:b0:374:c287:929b with SMTP id ffacd0b85a97d-37cfb8b1895mr1636870f8f.4.1727859808915;
        Wed, 02 Oct 2024 02:03:28 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:28 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:24 +0200
Subject: [PATCH net-next v8 10/24] ovpn: implement basic RX path (UDP)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-10-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14138; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=aOVQzbHAS0m3aoK7vNA3UF7L4WBMhvk/aS/IndQcn5I=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxSCf0Xbq1isSmzZjD8Lh7dS4HjHwPqAq5lI
 s62PfqbgECJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUgAKCRALcOU6oDjV
 h4cWB/sFqPcKE4+5AGbgPmyKt+8oeYTuzJmW2R6TArCmjoLgmAr+KK9QKHbjwJs+w2KVz/sTEbB
 9cXmhGS9CHPpmQ6XFknVPDWgprsu3Rm7iMRLQ6WmkrkhKlSXlVlBPyf0XYbpQEHHjogAoR+nHYY
 rl/dnKJ6MmZ7hxXKFGlIaygry5UUPMZcB5nSDQDQOtTxKItA4Efve7ydw3GGyd3UV4Lk3Z3vm6F
 vR4V4djiXtNLqtxQtnu943XM15jkQ1fQjLfL3UvgPFA9EQNv0+RWdkhOSuE9Ht1kleLXqTxeGaP
 5ORWaz6DDiMjlF7T5QhbvGcpDZ4yyEaSW9ZU0lvJaXvZaXiy
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Packets received over the socket are forwarded to the user device.

Implementation is UDP only. TCP will be added by a later patch.

Note: no decryption/decapsulation exists yet, packets are forwarded as
they arrive without much processing.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c         |  66 ++++++++++++++++++++++++++-
 drivers/net/ovpn/io.h         |   2 +
 drivers/net/ovpn/main.c       |   8 +++-
 drivers/net/ovpn/ovpnstruct.h |   3 ++
 drivers/net/ovpn/proto.h      |  75 ++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.c     |  24 ++++++++++
 drivers/net/ovpn/udp.c        | 104 +++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/udp.h        |   3 +-
 8 files changed, 281 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index dfd2c90c56842374b7fb1c8bead061a76272441e..78449b52a2f8f710107d2493299c6aca9a2cb2ce 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -9,14 +9,78 @@
 
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
 
+/* Called after decrypt to write the IP packet to the device.
+ * This method is expected to manage/free the skb.
+ */
+static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	unsigned int pkt_len;
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
+	skb_probe_transport_header(skb);
+	skb_reset_inner_headers(skb);
+
+	memset(skb->cb, 0, sizeof(skb->cb));
+
+	/* cause packet to be "received" by the interface */
+	pkt_len = skb->len;
+	if (likely(gro_cells_receive(&peer->ovpn->gro_cells,
+				     skb) == NET_RX_SUCCESS))
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
+/* pick next packet from RX queue, decrypt and forward it to the device */
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
index aa259be66441f7b0262f39da12d6c3dce0a9b24c..9667a0a470e0b4b427524fffb5b9b395007e5a2f 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -12,4 +12,6 @@
 
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
+void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 4522f2f8978614c96d529f807bd2cf32a44f8216..670e66f8f750086de5d48e4708721d102c149a2e 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -13,6 +13,7 @@
 #include <linux/inetdevice.h>
 //#include <linux/rcupdate.h>
 #include <linux/version.h>
+#include <net/gro_cells.h>
 #include <net/ip.h>
 #include <net/rtnetlink.h>
 #include <uapi/linux/if_arp.h>
@@ -45,11 +46,16 @@ static void ovpn_struct_init(struct net_device *dev, enum ovpn_mode mode)
 
 static void ovpn_struct_free(struct net_device *net)
 {
+	struct ovpn_struct *ovpn = netdev_priv(net);
+
+	gro_cells_destroy(&ovpn->gro_cells);
 }
 
 static int ovpn_net_init(struct net_device *dev)
 {
-	return 0;
+	struct ovpn_struct *ovpn = netdev_priv(dev);
+
+	return gro_cells_init(&ovpn->gro_cells, dev);
 }
 
 static int ovpn_net_open(struct net_device *dev)
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index 25f4837b798b1a2c9b11763dfb5b44e8ec337e6f..65497ce115aa4be719ed03f89135a80b73f9ef9b 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNSTRUCT_H_
 #define _NET_OVPN_OVPNSTRUCT_H_
 
+#include <net/gro_cells.h>
 #include <net/net_trackers.h>
 #include <uapi/linux/ovpn.h>
 
@@ -22,6 +23,7 @@
  * @lock: protect this object
  * @peer: in P2P mode, this is the only remote peer
  * @dev_list: entry for the module wide device list
+ * @gro_cells: pointer to the Generic Receive Offload cell
  */
 struct ovpn_struct {
 	struct net_device *dev;
@@ -31,6 +33,7 @@ struct ovpn_struct {
 	spinlock_t lock; /* protect writing to the ovpn_struct object */
 	struct ovpn_peer __rcu *peer;
 	struct list_head dev_list;
+	struct gro_cells gro_cells;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
new file mode 100644
index 0000000000000000000000000000000000000000..69604cf26bbf82539ee5cd5a7ac9c23920f555de
--- /dev/null
+++ b/drivers/net/ovpn/proto.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNPROTO_H_
+#define _NET_OVPN_OVPNPROTO_H_
+
+#include "main.h"
+
+#include <linux/skbuff.h>
+
+/* Methods for operating on the initial command
+ * byte of the OpenVPN protocol.
+ */
+
+/* packet opcode (high 5 bits) and key-id (low 3 bits) are combined in
+ * one byte
+ */
+#define OVPN_KEY_ID_MASK 0x07
+#define OVPN_OPCODE_SHIFT 3
+#define OVPN_OPCODE_MASK 0x1F
+/* upper bounds on opcode and key ID */
+#define OVPN_KEY_ID_MAX (OVPN_KEY_ID_MASK + 1)
+#define OVPN_OPCODE_MAX (OVPN_OPCODE_MASK + 1)
+/* packet opcodes of interest to us */
+#define OVPN_DATA_V1 6 /* data channel V1 packet */
+#define OVPN_DATA_V2 9 /* data channel V2 packet */
+/* size of initial packet opcode */
+#define OVPN_OP_SIZE_V1 1
+#define OVPN_OP_SIZE_V2	4
+#define OVPN_PEER_ID_MASK 0x00FFFFFF
+#define OVPN_PEER_ID_UNDEF 0x00FFFFFF
+/* first byte of keepalive message */
+#define OVPN_KEEPALIVE_FIRST_BYTE 0x2a
+/* first byte of exit message */
+#define OVPN_EXPLICIT_EXIT_NOTIFY_FIRST_BYTE 0x28
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
+	u8 byte = *(skb->data + offset);
+
+	return byte >> OVPN_OPCODE_SHIFT;
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
+ * Return: the peer ID.
+ */
+static inline u32 ovpn_peer_id_from_skb(const struct sk_buff *skb, u16 offset)
+{
+	return ntohl(*(__be32 *)(skb->data + offset)) & OVPN_PEER_ID_MASK;
+}
+
+#endif /* _NET_OVPN_OVPNPROTO_H_ */
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 090a3232ab0ec19702110f1a90f45c7f10889f6f..964b566de69f4132806a969a455cec7f6059a0bd 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -22,6 +22,9 @@ static void ovpn_socket_detach(struct socket *sock)
 	if (!sock)
 		return;
 
+	if (sock->sk->sk_protocol == IPPROTO_UDP)
+		ovpn_udp_socket_detach(sock);
+
 	sockfd_put(sock);
 }
 
@@ -71,6 +74,27 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
 	return ret;
 }
 
+/* Retrieve the corresponding ovpn object from a UDP socket
+ * rcu_read_lock must be held on entry
+ */
+struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk)
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
index d26d7566e9c8dfe91fa77f49c34fb179a9fb2239..d1e88ae83843f02d591e67a7995f2d6868720695 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -21,9 +21,95 @@
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
+	struct ovpn_peer *peer = NULL;
+	struct ovpn_struct *ovpn;
+	u32 peer_id;
+	u8 opcode;
+
+	ovpn = ovpn_from_udp_sock(sk);
+	if (unlikely(!ovpn)) {
+		net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket\n",
+				    __func__);
+		goto drop_noovpn;
+	}
+
+	/* Make sure the first 4 bytes of the skb data buffer after the UDP
+	 * header are accessible.
+	 * They are required to fetch the OP code, the key ID and the peer ID.
+	 */
+	if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) +
+				    OVPN_OP_SIZE_V2))) {
+		net_dbg_ratelimited("%s: packet too small\n", __func__);
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
+	 * peer-id set to undef. In this case we skip the peer lookup by peer-id
+	 * and we try with the transport address
+	 */
+	if (peer_id != OVPN_PEER_ID_UNDEF) {
+		peer = ovpn_peer_get_by_id(ovpn, peer_id);
+		if (!peer) {
+			net_err_ratelimited("%s: received data from unknown peer (id: %d)\n",
+					    __func__, peer_id);
+			goto drop;
+		}
+	}
+
+	if (!peer) {
+		/* data packet with undef peer-id */
+		peer = ovpn_peer_get_by_transp_addr(ovpn, skb);
+		if (unlikely(!peer)) {
+			net_dbg_ratelimited("%s: received data with undef peer-id from unknown source\n",
+					    __func__);
+			goto drop;
+		}
+	}
+
+	/* pop off outer UDP header */
+	__skb_pull(skb, sizeof(struct udphdr));
+	ovpn_recv(peer, skb);
+	return 0;
+
+drop:
+	if (peer)
+		ovpn_peer_put(peer);
+	dev_core_stats_rx_dropped_inc(ovpn->dev);
+drop_noovpn:
+	kfree_skb(skb);
+	return 0;
+}
+
 /**
  * ovpn_udp4_output - send IPv4 packet over udp socket
  * @ovpn: the openvpn instance
@@ -259,8 +345,12 @@ void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
  */
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
 {
+	struct udp_tunnel_sock_cfg cfg = {
+		.encap_type = UDP_ENCAP_OVPNINUDP,
+		.encap_rcv = ovpn_udp_encap_recv,
+	};
 	struct ovpn_socket *old_data;
-	int ret = 0;
+	int ret;
 
 	/* sanity check */
 	if (sock->sk->sk_protocol != IPPROTO_UDP) {
@@ -274,6 +364,7 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
 	if (!old_data) {
 		/* socket is currently unused - we can take it */
 		rcu_read_unlock();
+		setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
 		return 0;
 	}
 
@@ -302,3 +393,14 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
 
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
index e60f8cd2b4ac8f910aabcf8ed546af59d6ca4be4..fecb68464896bc1228315faf268453f9005e693d 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -18,8 +18,9 @@ struct sk_buff;
 struct socket;
 
 int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn);
-
+void ovpn_udp_socket_detach(struct socket *sock);
 void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
 		       struct sk_buff *skb);
+struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk);
 
 #endif /* _NET_OVPN_UDP_H_ */

-- 
2.45.2


