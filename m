Return-Path: <linux-kselftest+bounces-22945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043359E7ABF
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 22:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82E118889E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 21:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2F4221DB9;
	Fri,  6 Dec 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fef+tcNh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB18212F99
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519942; cv=none; b=YHvhc7Qc+4C2pb/KyEchlGCZ6VDbEwBTmFbm+zucUlAYgQPEK0KHC0sD8bA1fyKiFixQF8wjqLivM2Lpp8UMcHYgRUZPNhu9A4AFlVWXVS9Mk4bYN31kuiSErq9OiKQrsh5+uMwMFVWtL+n8AQCvfsEU2qM/0ePWqcTohgSbobc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519942; c=relaxed/simple;
	bh=D8UTr3ey9Zs7N36YFm8Gzp1lr5LDnmxjitxXmMf34Zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MAMhUEDx1YDNWFjI8k2TLNEBf3InjdNhV6Rsn/ZmNYWIuXE01aV53dQUKLtPWx855tIcvMiJtJ0XrqQknoVgYOQ/lstPi3Wi7iHSeqy4osgLGEClUpwjIlfWUl7aZQOqQmV/aWkHcirQCQyuxcgWXrqcXCyJpyf397SLwqPYa2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fef+tcNh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385dece873cso1254829f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 13:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519935; x=1734124735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRDiBYtfvP37gRC4eS2Ed3El2Q1m4uljBB6kHeFlQGU=;
        b=fef+tcNhVm8BC284oBKJmnWz0gcOD688AOjZhXpLuAgclYFFsLcekWmKgEp05FGZME
         dsDTF4XaxcvEL3eWLSKU+cGQpplP+YCf9u5Tm/sReQtapnr3+URyMzn55L87NY2/lLcW
         r26fq2WRafbNuMGe4XaPmhEbGXWS/Qqb0mk6ifGok6UiOZ20G+72yWc7Kzxy0VH/583E
         VYywiQUCyx294PNgwPiXzdVr9rxibpczxEGey9dL+8EMC8LqFgEnjgyCv7eEonSL/CcR
         ecU5COpVjUUtuaB2r+tPkTMVGqGIeJuHoLyYGNu7/U7s0ra90WaYOOLY5rJEQ2qWJY/F
         yEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519935; x=1734124735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRDiBYtfvP37gRC4eS2Ed3El2Q1m4uljBB6kHeFlQGU=;
        b=KiZ3K0aalXAQE7i/itd3dZfgHw8/2zNOeYDQYAtLEwmBcTv/lzKzsUlpvS372Q+a8y
         vcmwjBQs7ETIoTXYet0n7FjWz8qXfIx1kQTTLvPK60JciKneS5iRGRWrop+GzTvj9mdm
         MoXSA8d1THeCduzaTt8sUl5sVlCs9gGrDt6P8fnshwk6X8tDJNY+Jf2ev7lKEBbgWyvd
         wq0UO9v3a8pNl1PQTRWWkn9oRuS1dvXuBm9BMu+dyk4Szoes8MnD43Mbw74IdRlKJDdV
         mowgm09MTh+Ujb7JY2wVUOIDT2/FW+PBwYYorfCpgcwAVz0XI81C3DRTp54Tk4sQLG7K
         gM/g==
X-Forwarded-Encrypted: i=1; AJvYcCWBCNJBB6Wfd7rOjYG+qq5ErLPRfSyvCBDxGqdfzSfOxjbAulqTTSVtahYuD++F+Pf8jLjk2AHtrYh/Td1jAYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR66W9KDRPZ402bRICVNt2QJpJ8RrXs5TJpappVuhdXlUQKE8G
	XZSThQ+PH6eS+aYDMQP5pt0CWkfI1cbReiPgix/7HKOtRX4SMy5po70GYR4HmA4=
X-Gm-Gg: ASbGncv0b80qjCZtZT2/zcHrhY/XGlYn/fKY96sVPxqrjXsI0b+052tGdJn0LYJJtFw
	y+YPAo0uMpfMgjjIqCY0UmBA6QzCMdwsvGCS9tBDjs+Q5W5joxurJ/awp0SUqTDPWg7D8KHLDjZ
	hdRDskCIklVCVmOkHoI8mfSNGabGhSi9z2AvgCqsxEFQB0LG2UR2WhvJZtUE1gYuoz6LbWk5rDd
	cQrqTZHlLeHzwvXJ8NYdjsFn0Lq8OSwr0kMqLTaYdMGakCFlrpF/As59Pk0XQ==
X-Google-Smtp-Source: AGHT+IGiQ2Cecjy7TFcV1wvFXY6ymGXnXqm87hQmW5hArlVv3z2xPRu1OvFo2JcXASjlN+4wtsg5Tw==
X-Received: by 2002:adf:e19b:0:b0:385:f15f:c96f with SMTP id ffacd0b85a97d-3862b3d08edmr3636592f8f.42.1733519934675;
        Fri, 06 Dec 2024 13:18:54 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:18:54 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 06 Dec 2024 22:18:36 +0100
Subject: [PATCH net-next v13 11/22] ovpn: implement TCP transport
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-b4-ovpn-v13-11-67fb4be666e2@openvpn.net>
References: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
In-Reply-To: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=27901; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=D8UTr3ey9Zs7N36YFm8Gzp1lr5LDnmxjitxXmMf34Zc=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnU2pXSCWQhp1HLi2dyzwKSxyEgiOO4gwE39GHy
 Wa+ZrHAY1WJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1NqVwAKCRALcOU6oDjV
 hzEICACsZZmaKGOLMAbv1MOySrMvXmAyJ+OiU65nOSAiz+2KHsNa2CS5Up+zxoLipjTHwiySIJq
 Y8NkyP6Zg7V7Cz8pOFg58gV8VsD8elIqFj+OFE1QP0EBvNzl5TBYAOGZpsagSt0wSwKOydN58Ez
 c4WW3SXlkZ6sataOltBla4j0BcLqRj4TASadk6ryMBAcTVm4cmPyUZMUMJNAlAcZV31FVbCkKnq
 RWTwb3mrDdZkrniGT+Ib2XXrwD76oDolPfG+b3ChRPtbuKmejpVxoPKi7dNfTLvrqSgFpiz8FH7
 V2K+UDUvjPUza8c63HJkjC22fJ+AMQWaMpYdeybLesVFCnJ8
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

With this change ovpn is allowed to communicate to peers also via TCP.
Parsing of incoming messages is implemented through the strparser API.

Note that ovpn redefines sk_prot and sk_socket->ops for the TCP socket
used to communicate with the peer.
For this reason it needs to access inet6_stream_ops, which is declared
as extern in the IPv6 module, but it is not fully exported.
Therefore this patch is also adding EXPORT_SYMBOL_GPL(inet6_stream_ops)
to net/ipv6/af_inet6.c.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/Kconfig           |   1 +
 drivers/net/ovpn/Makefile     |   1 +
 drivers/net/ovpn/io.c         |   4 +
 drivers/net/ovpn/main.c       |   3 +
 drivers/net/ovpn/ovpnstruct.h |   1 +
 drivers/net/ovpn/peer.h       |  39 +++
 drivers/net/ovpn/socket.c     |  49 +++-
 drivers/net/ovpn/socket.h     |   9 +-
 drivers/net/ovpn/tcp.c        | 578 ++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/tcp.h        |  33 +++
 drivers/net/ovpn/udp.c        |   9 +
 net/ipv6/af_inet6.c           |   1 +
 12 files changed, 721 insertions(+), 7 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 7d274ec48983f0ec460094ec81dc177c56f37ffe..755e79d424a5ef015054a09abce4c2817c948e1e 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -124,6 +124,7 @@ config OVPN
 	select CRYPTO_AES
 	select CRYPTO_GCM
 	select CRYPTO_CHACHA20POLY1305
+	select STREAM_PARSER
 	help
 	  This module enhances the performance of the OpenVPN userspace software
 	  by offloading the data channel processing to kernelspace.
diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index d43fda72646bdc7644d9a878b56da0a0e5680c98..f4d4bd87c851c8dd5b81e357315c4b22de4bd092 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -18,4 +18,5 @@ ovpn-y += peer.o
 ovpn-y += pktid.o
 ovpn-y += socket.o
 ovpn-y += stats.o
+ovpn-y += tcp.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 8414dbd24467d77a5122daa9c3c745aa5e258c98..ecc1d35b04248f7d5da99501777bee971c98b91f 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -22,6 +22,7 @@
 #include "crypto_aead.h"
 #include "netlink.h"
 #include "proto.h"
+#include "tcp.h"
 #include "udp.h"
 #include "skb.h"
 #include "socket.h"
@@ -210,6 +211,9 @@ void ovpn_encrypt_post(void *data, int ret)
 	case IPPROTO_UDP:
 		ovpn_udp_send_skb(peer, skb);
 		break;
+	case IPPROTO_TCP:
+		ovpn_tcp_send_skb(peer, skb);
+		break;
 	default:
 		/* no transport configured yet */
 		goto err;
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index c27e4c190f5bdf061a71c516344551ef7cd31496..b09e98080737cbb6c446d00cfaad6d2e0c716327 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -22,6 +22,7 @@
 #include "io.h"
 #include "peer.h"
 #include "proto.h"
+#include "tcp.h"
 
 static int ovpn_net_init(struct net_device *dev)
 {
@@ -229,6 +230,8 @@ static int __init ovpn_init(void)
 		goto unreg_rtnl;
 	}
 
+	ovpn_tcp_init();
+
 	return 0;
 
 unreg_rtnl:
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index 1cca91d869d9e3c722a0933a426255f05daf8097..7af1f21bb5a76acb34269693bcba5ce8f832137f 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNSTRUCT_H_
 #define _NET_OVPN_OVPNSTRUCT_H_
 
+#include <linux/workqueue.h>
 #include <net/gro_cells.h>
 #include <net/net_trackers.h>
 #include <uapi/linux/if_link.h>
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 61c54fb864d990ff3d746f18c9a06d4c950bd1ac..02e7e53792dcd69fb3d8371e9a447c6dc7aef016 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -11,6 +11,7 @@
 #define _NET_OVPN_OVPNPEER_H_
 
 #include <net/dst_cache.h>
+#include <net/strparser.h>
 
 #include "crypto.h"
 #include "stats.h"
@@ -23,6 +24,19 @@
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
  * @sock: the socket being used to talk to this peer
+ * @tcp: keeps track of TCP specific state
+ * @tcp.strp: stream parser context (TCP only)
+ * @tcp.tx_work: work for deferring outgoing packet processing (TCP only)
+ * @tcp.user_queue: received packets that have to go to userspace (TCP only)
+ * @tcp.out_queue: packets on hold while socket is taken by user (TCP only)
+ * @tcp.tx_in_progress: true if TX is already ongoing (TCP only)
+ * @tcp.out_msg.skb: packet scheduled for sending (TCP only)
+ * @tcp.out_msg.offset: offset where next send should start (TCP only)
+ * @tcp.out_msg.len: remaining data to send within packet (TCP only)
+ * @tcp.sk_cb.sk_data_ready: pointer to original cb (TCP only)
+ * @tcp.sk_cb.sk_write_space: pointer to original cb (TCP only)
+ * @tcp.sk_cb.prot: pointer to original prot object (TCP only)
+ * @tcp.sk_cb.ops: pointer to the original prot_ops object (TCP only)
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
@@ -42,6 +56,31 @@ struct ovpn_peer {
 		struct in6_addr ipv6;
 	} vpn_addrs;
 	struct ovpn_socket *sock;
+
+	/* state of the TCP reading. Needed to keep track of how much of a
+	 * single packet has already been read from the stream and how much is
+	 * missing
+	 */
+	struct {
+		struct strparser strp;
+		struct work_struct tx_work;
+		struct sk_buff_head user_queue;
+		struct sk_buff_head out_queue;
+		bool tx_in_progress;
+
+		struct {
+			struct sk_buff *skb;
+			int offset;
+			int len;
+		} out_msg;
+
+		struct {
+			void (*sk_data_ready)(struct sock *sk);
+			void (*sk_write_space)(struct sock *sk);
+			struct proto *prot;
+			const struct proto_ops *ops;
+		} sk_cb;
+	} tcp;
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index e10590924e3f9fe605309989be84866e2e508944..312f0c19acf1548b4d44bed35e221ce94c91a8fa 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -16,6 +16,7 @@
 #include "io.h"
 #include "peer.h"
 #include "socket.h"
+#include "tcp.h"
 #include "udp.h"
 
 static void ovpn_socket_detach(struct socket *sock)
@@ -25,10 +26,26 @@ static void ovpn_socket_detach(struct socket *sock)
 
 	if (sock->sk->sk_protocol == IPPROTO_UDP)
 		ovpn_udp_socket_detach(sock);
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
+		ovpn_tcp_socket_detach(sock);
 
 	sockfd_put(sock);
 }
 
+static void ovpn_socket_release_work(struct work_struct *work)
+{
+	struct ovpn_socket *sock = container_of(work, struct ovpn_socket, work);
+
+	ovpn_socket_detach(sock->sock);
+	kfree_rcu(sock, rcu);
+}
+
+static void ovpn_socket_schedule_release(struct ovpn_socket *sock)
+{
+	INIT_WORK(&sock->work, ovpn_socket_release_work);
+	schedule_work(&sock->work);
+}
+
 /**
  * ovpn_socket_release_kref - kref_put callback
  * @kref: the kref object
@@ -38,8 +55,7 @@ void ovpn_socket_release_kref(struct kref *kref)
 	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
 						refcount);
 
-	ovpn_socket_detach(sock->sock);
-	kfree_rcu(sock, rcu);
+	ovpn_socket_schedule_release(sock);
 }
 
 static bool ovpn_socket_hold(struct ovpn_socket *sock)
@@ -53,7 +69,7 @@ static struct ovpn_socket *ovpn_socket_get(struct socket *sock)
 
 	rcu_read_lock();
 	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
-	if (WARN_ON(!ovpn_socket_hold(ovpn_sock)))
+	if (!ovpn_sock || WARN_ON(!ovpn_socket_hold(ovpn_sock)))
 		ovpn_sock = NULL;
 	rcu_read_unlock();
 
@@ -69,6 +85,8 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
 
 	if (sock->sk->sk_protocol == IPPROTO_UDP)
 		ret = ovpn_udp_socket_attach(sock, peer->ovpn);
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
+		ret = ovpn_tcp_socket_attach(sock, peer);
 
 	return ret;
 }
@@ -130,14 +148,33 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 	}
 
 	ovpn_sock = kzalloc(sizeof(*ovpn_sock), GFP_KERNEL);
-	if (!ovpn_sock)
-		return ERR_PTR(-ENOMEM);
+	if (!ovpn_sock) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
-	ovpn_sock->ovpn = peer->ovpn;
 	ovpn_sock->sock = sock;
 	kref_init(&ovpn_sock->refcount);
 
+	/* TCP sockets are per-peer, therefore they are linked to their unique
+	 * peer
+	 */
+	if (sock->sk->sk_protocol == IPPROTO_TCP) {
+		ovpn_sock->peer = peer;
+		ovpn_peer_hold(peer);
+	} else {
+		/* in UDP we only link the ovpn instance since the socket is
+		 * shared among multiple peers
+		 */
+		ovpn_sock->ovpn = peer->ovpn;
+		netdev_hold(peer->ovpn->dev, &peer->ovpn->dev_tracker,
+			    GFP_KERNEL);
+	}
+
 	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
 
 	return ovpn_sock;
+err:
+	ovpn_socket_detach(sock);
+	return ERR_PTR(ret);
 }
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index 904814d2b9e9f2b0773bf942372bcbe904ef5474..6805277853814c85c0292d3c1d2bf10e5b2e60bb 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -20,14 +20,21 @@ struct ovpn_peer;
 /**
  * struct ovpn_socket - a kernel socket referenced in the ovpn code
  * @ovpn: ovpn instance owning this socket (UDP only)
+ * @peer: unique peer transmitting over this socket (TCP only)
  * @sock: the low level sock object
  * @refcount: amount of contexts currently referencing this object
+ * @work: member used to schedule release routine (it may block)
  * @rcu: member used to schedule RCU destructor callback
  */
 struct ovpn_socket {
-	struct ovpn_priv *ovpn;
+	union {
+		struct ovpn_priv *ovpn;
+		struct ovpn_peer *peer;
+	};
+
 	struct socket *sock;
 	struct kref refcount;
+	struct work_struct work;
 	struct rcu_head rcu;
 };
 
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
new file mode 100644
index 0000000000000000000000000000000000000000..c9b9df206e53d17692dc717aad301ab1c0294ab7
--- /dev/null
+++ b/drivers/net/ovpn/tcp.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/skbuff.h>
+#include <net/hotdata.h>
+#include <net/inet_common.h>
+#include <net/ipv6.h>
+#include <net/tcp.h>
+#include <net/transp_v6.h>
+#include <net/route.h>
+#include <trace/events/sock.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "io.h"
+#include "peer.h"
+#include "proto.h"
+#include "skb.h"
+#include "tcp.h"
+
+static struct proto ovpn_tcp_prot __ro_after_init;
+static struct proto_ops ovpn_tcp_ops __ro_after_init;
+static struct proto ovpn_tcp6_prot __ro_after_init;
+static struct proto_ops ovpn_tcp6_ops __ro_after_init;
+
+static int ovpn_tcp_parse(struct strparser *strp, struct sk_buff *skb)
+{
+	struct strp_msg *rxm = strp_msg(skb);
+	__be16 blen;
+	u16 len;
+	int err;
+
+	/* when packets are written to the TCP stream, they are prepended with
+	 * two bytes indicating the actual packet size.
+	 * Here we read those two bytes and move the skb data pointer to the
+	 * beginning of the packet
+	 */
+
+	if (skb->len < rxm->offset + 2)
+		return 0;
+
+	err = skb_copy_bits(skb, rxm->offset, &blen, sizeof(blen));
+	if (err < 0)
+		return err;
+
+	len = be16_to_cpu(blen);
+	if (len < 2)
+		return -EINVAL;
+
+	return len + 2;
+}
+
+/* queue skb for sending to userspace via recvmsg on the socket */
+static void ovpn_tcp_to_userspace(struct ovpn_peer *peer, struct sock *sk,
+				  struct sk_buff *skb)
+{
+	skb_set_owner_r(skb, sk);
+	memset(skb->cb, 0, sizeof(skb->cb));
+	skb_queue_tail(&peer->tcp.user_queue, skb);
+	peer->tcp.sk_cb.sk_data_ready(sk);
+}
+
+static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
+{
+	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
+	struct strp_msg *msg = strp_msg(skb);
+	size_t pkt_len = msg->full_len - 2;
+	size_t off = msg->offset + 2;
+	u8 opcode;
+
+	/* ensure skb->data points to the beginning of the openvpn packet */
+	if (!pskb_pull(skb, off)) {
+		net_warn_ratelimited("%s: packet too small for peer %u\n",
+				     netdev_name(peer->ovpn->dev), peer->id);
+		goto err;
+	}
+
+	/* strparser does not trim the skb for us, therefore we do it now */
+	if (pskb_trim(skb, pkt_len) != 0) {
+		net_warn_ratelimited("%s: trimming skb failed for peer %u\n",
+				     netdev_name(peer->ovpn->dev), peer->id);
+		goto err;
+	}
+
+	/* we need the first byte of data to be accessible
+	 * to extract the opcode and the key ID later on
+	 */
+	if (!pskb_may_pull(skb, 1)) {
+		net_warn_ratelimited("%s: packet too small to fetch opcode for peer %u\n",
+				     netdev_name(peer->ovpn->dev), peer->id);
+		goto err;
+	}
+
+	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
+	opcode = ovpn_opcode_from_skb(skb, 0);
+	if (unlikely(opcode != OVPN_DATA_V2)) {
+		if (opcode == OVPN_DATA_V1) {
+			net_warn_ratelimited("%s: DATA_V1 detected on the TCP stream\n",
+					     netdev_name(peer->ovpn->dev));
+			goto err;
+		}
+
+		/* The packet size header must be there when sending the packet
+		 * to userspace, therefore we put it back
+		 */
+		skb_push(skb, 2);
+		ovpn_tcp_to_userspace(peer, strp->sk, skb);
+		return;
+	}
+
+	/* hold reference to peer as required by ovpn_recv().
+	 *
+	 * NOTE: in this context we should already be holding a reference to
+	 * this peer, therefore ovpn_peer_hold() is not expected to fail
+	 */
+	if (WARN_ON(!ovpn_peer_hold(peer)))
+		goto err;
+
+	ovpn_recv(peer, skb);
+	return;
+err:
+	dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
+	kfree_skb(skb);
+	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+}
+
+static int ovpn_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+			    int flags, int *addr_len)
+{
+	int err = 0, off, copied = 0, ret;
+	struct ovpn_socket *sock;
+	struct ovpn_peer *peer;
+	struct sk_buff *skb;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	if (!sock || !sock->peer) {
+		rcu_read_unlock();
+		return -EBADF;
+	}
+	/* we take a reference to the peer linked to this TCP socket, because
+	 * in turn the peer holds a reference to the socket itself.
+	 * By doing so we also ensure that the peer stays alive along with
+	 * the socket while executing this function
+	 */
+	ovpn_peer_hold(sock->peer);
+	peer = sock->peer;
+	rcu_read_unlock();
+
+	skb = __skb_recv_datagram(sk, &peer->tcp.user_queue, flags, &off, &err);
+	if (!skb) {
+		if (err == -EAGAIN && sk->sk_shutdown & RCV_SHUTDOWN) {
+			ret = 0;
+			goto out;
+		}
+		ret = err;
+		goto out;
+	}
+
+	copied = len;
+	if (copied > skb->len)
+		copied = skb->len;
+	else if (copied < skb->len)
+		msg->msg_flags |= MSG_TRUNC;
+
+	err = skb_copy_datagram_msg(skb, 0, msg, copied);
+	if (unlikely(err)) {
+		kfree_skb(skb);
+		ret = err;
+		goto out;
+	}
+
+	if (flags & MSG_TRUNC)
+		copied = skb->len;
+	kfree_skb(skb);
+	ret = copied;
+out:
+	ovpn_peer_put(peer);
+	return ret;
+}
+
+void ovpn_tcp_socket_detach(struct socket *sock)
+{
+	struct ovpn_socket *ovpn_sock;
+	struct ovpn_peer *peer;
+
+	if (!sock)
+		return;
+
+	rcu_read_lock();
+	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
+
+	if (!ovpn_sock->peer) {
+		rcu_read_unlock();
+		return;
+	}
+
+	peer = ovpn_sock->peer;
+	strp_stop(&peer->tcp.strp);
+
+	skb_queue_purge(&peer->tcp.user_queue);
+
+	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
+	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
+	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
+	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
+	sock->sk->sk_socket->ops = peer->tcp.sk_cb.ops;
+	/* drop reference to peer */
+	rcu_assign_sk_user_data(sock->sk, NULL);
+
+	rcu_read_unlock();
+
+	/* before canceling any ongoing work we must ensure that CBs
+	 * have been reset to prevent workers from being re-armed
+	 */
+	barrier();
+
+	cancel_work_sync(&peer->tcp.tx_work);
+	strp_done(&peer->tcp.strp);
+	skb_queue_purge(&peer->tcp.out_queue);
+
+	ovpn_peer_put(peer);
+}
+
+static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
+{
+	struct sk_buff *skb = peer->tcp.out_msg.skb;
+
+	if (!skb)
+		return;
+
+	if (peer->tcp.tx_in_progress)
+		return;
+
+	peer->tcp.tx_in_progress = true;
+
+	do {
+		int ret = skb_send_sock_locked(peer->sock->sock->sk, skb,
+					       peer->tcp.out_msg.offset,
+					       peer->tcp.out_msg.len);
+		if (unlikely(ret < 0)) {
+			if (ret == -EAGAIN)
+				goto out;
+
+			net_warn_ratelimited("%s: TCP error to peer %u: %d\n",
+					     netdev_name(peer->ovpn->dev),
+					     peer->id, ret);
+
+			/* in case of TCP error we can't recover the VPN
+			 * stream therefore we abort the connection
+			 */
+			ovpn_peer_del(peer,
+				      OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+			break;
+		}
+
+		peer->tcp.out_msg.len -= ret;
+		peer->tcp.out_msg.offset += ret;
+	} while (peer->tcp.out_msg.len > 0);
+
+	if (!peer->tcp.out_msg.len)
+		dev_sw_netstats_tx_add(peer->ovpn->dev, 1, skb->len);
+
+	kfree_skb(peer->tcp.out_msg.skb);
+	peer->tcp.out_msg.skb = NULL;
+	peer->tcp.out_msg.len = 0;
+	peer->tcp.out_msg.offset = 0;
+
+out:
+	peer->tcp.tx_in_progress = false;
+}
+
+static void ovpn_tcp_tx_work(struct work_struct *work)
+{
+	struct ovpn_peer *peer;
+
+	peer = container_of(work, struct ovpn_peer, tcp.tx_work);
+
+	lock_sock(peer->sock->sock->sk);
+	ovpn_tcp_send_sock(peer);
+	release_sock(peer->sock->sock->sk);
+}
+
+static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	if (peer->tcp.out_msg.skb)
+		ovpn_tcp_send_sock(peer);
+
+	if (peer->tcp.out_msg.skb) {
+		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
+		kfree_skb(skb);
+		return;
+	}
+
+	peer->tcp.out_msg.skb = skb;
+	peer->tcp.out_msg.len = skb->len;
+	peer->tcp.out_msg.offset = 0;
+	ovpn_tcp_send_sock(peer);
+}
+
+void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	u16 len = skb->len;
+
+	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
+
+	bh_lock_sock(peer->sock->sock->sk);
+	if (sock_owned_by_user(peer->sock->sock->sk)) {
+		if (skb_queue_len(&peer->tcp.out_queue) >=
+		    READ_ONCE(net_hotdata.max_backlog)) {
+			dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
+			kfree_skb(skb);
+			goto unlock;
+		}
+		__skb_queue_tail(&peer->tcp.out_queue, skb);
+	} else {
+		ovpn_tcp_send_sock_skb(peer, skb);
+	}
+unlock:
+	bh_unlock_sock(peer->sock->sock->sk);
+}
+
+static void ovpn_tcp_release(struct sock *sk)
+{
+	struct sk_buff_head queue;
+	struct ovpn_socket *sock;
+	struct ovpn_peer *peer;
+	struct sk_buff *skb;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	if (!sock) {
+		rcu_read_unlock();
+		goto release;
+	}
+
+	peer = sock->peer;
+
+	/* during initialization this function is called before
+	 * assigning sock->peer
+	 */
+	if (unlikely(!peer || !ovpn_peer_hold(peer))) {
+		rcu_read_unlock();
+		goto release;
+	}
+	rcu_read_unlock();
+
+	__skb_queue_head_init(&queue);
+	skb_queue_splice_init(&peer->tcp.out_queue, &queue);
+
+	while ((skb = __skb_dequeue(&queue)))
+		ovpn_tcp_send_sock_skb(peer, skb);
+
+	ovpn_peer_put(peer);
+release:
+	tcp_release_cb(sk);
+}
+
+static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
+{
+	struct ovpn_socket *sock;
+	int ret, linear = PAGE_SIZE;
+	struct ovpn_peer *peer;
+	struct sk_buff *skb;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	peer = sock->peer;
+	if (unlikely(!ovpn_peer_hold(peer))) {
+		rcu_read_unlock();
+		return -EIO;
+	}
+	rcu_read_unlock();
+
+	lock_sock(peer->sock->sock->sk);
+
+	if (msg->msg_flags & ~MSG_DONTWAIT) {
+		ret = -EOPNOTSUPP;
+		goto peer_free;
+	}
+
+	if (peer->tcp.out_msg.skb) {
+		ret = -EAGAIN;
+		goto peer_free;
+	}
+
+	if (size < linear)
+		linear = size;
+
+	skb = sock_alloc_send_pskb(sk, linear, size - linear,
+				   msg->msg_flags & MSG_DONTWAIT, &ret, 0);
+	if (!skb) {
+		net_err_ratelimited("%s: skb alloc failed: %d\n",
+				    netdev_name(sock->peer->ovpn->dev), ret);
+		goto peer_free;
+	}
+
+	skb_put(skb, linear);
+	skb->len = size;
+	skb->data_len = size - linear;
+
+	ret = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
+	if (ret) {
+		kfree_skb(skb);
+		net_err_ratelimited("%s: skb copy from iter failed: %d\n",
+				    netdev_name(sock->peer->ovpn->dev), ret);
+		goto peer_free;
+	}
+
+	ovpn_tcp_send_sock_skb(sock->peer, skb);
+	ret = size;
+peer_free:
+	release_sock(peer->sock->sock->sk);
+	ovpn_peer_put(peer);
+	return ret;
+}
+
+static void ovpn_tcp_data_ready(struct sock *sk)
+{
+	struct ovpn_socket *sock;
+
+	trace_sk_data_ready(sk);
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	strp_data_ready(&sock->peer->tcp.strp);
+	rcu_read_unlock();
+}
+
+static void ovpn_tcp_write_space(struct sock *sk)
+{
+	struct ovpn_socket *sock;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	schedule_work(&sock->peer->tcp.tx_work);
+	sock->peer->tcp.sk_cb.sk_write_space(sk);
+	rcu_read_unlock();
+}
+
+static void ovpn_tcp_build_protos(struct proto *new_prot,
+				  struct proto_ops *new_ops,
+				  const struct proto *orig_prot,
+				  const struct proto_ops *orig_ops);
+
+/* Set TCP encapsulation callbacks */
+int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer)
+{
+	struct strp_callbacks cb = {
+		.rcv_msg = ovpn_tcp_rcv,
+		.parse_msg = ovpn_tcp_parse,
+	};
+	int ret;
+
+	/* make sure no pre-existing encapsulation handler exists */
+	if (sock->sk->sk_user_data)
+		return -EBUSY;
+
+	/* sanity check */
+	if (sock->sk->sk_protocol != IPPROTO_TCP) {
+		net_err_ratelimited("%s: provided socket is not TCP as expected\n",
+				    netdev_name(peer->ovpn->dev));
+		return -EINVAL;
+	}
+
+	/* only a fully connected socket are expected. Connection should be
+	 * handled in userspace
+	 */
+	if (sock->sk->sk_state != TCP_ESTABLISHED) {
+		net_err_ratelimited("%s: provided TCP socket is not in ESTABLISHED state: %d\n",
+				    netdev_name(peer->ovpn->dev),
+				    sock->sk->sk_state);
+		return -EINVAL;
+	}
+
+	lock_sock(sock->sk);
+
+	ret = strp_init(&peer->tcp.strp, sock->sk, &cb);
+	if (ret < 0) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		release_sock(sock->sk);
+		return ret;
+	}
+
+	INIT_WORK(&peer->tcp.tx_work, ovpn_tcp_tx_work);
+	__sk_dst_reset(sock->sk);
+	skb_queue_head_init(&peer->tcp.user_queue);
+	skb_queue_head_init(&peer->tcp.out_queue);
+
+	/* save current CBs so that they can be restored upon socket release */
+	peer->tcp.sk_cb.sk_data_ready = sock->sk->sk_data_ready;
+	peer->tcp.sk_cb.sk_write_space = sock->sk->sk_write_space;
+	peer->tcp.sk_cb.prot = sock->sk->sk_prot;
+	peer->tcp.sk_cb.ops = sock->sk->sk_socket->ops;
+
+	/* assign our static CBs and prot/ops */
+	sock->sk->sk_data_ready = ovpn_tcp_data_ready;
+	sock->sk->sk_write_space = ovpn_tcp_write_space;
+
+	if (sock->sk->sk_family == AF_INET) {
+		sock->sk->sk_prot = &ovpn_tcp_prot;
+		sock->sk->sk_socket->ops = &ovpn_tcp_ops;
+	} else {
+		sock->sk->sk_prot = &ovpn_tcp6_prot;
+		sock->sk->sk_socket->ops = &ovpn_tcp6_ops;
+	}
+
+	/* avoid using task_frag */
+	sock->sk->sk_allocation = GFP_ATOMIC;
+	sock->sk->sk_use_task_frag = false;
+
+	/* enqueue the RX worker */
+	strp_check_rcv(&peer->tcp.strp);
+
+	release_sock(sock->sk);
+	return 0;
+}
+
+static void ovpn_tcp_close(struct sock *sk, long timeout)
+{
+	struct ovpn_socket *sock;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+
+	strp_stop(&sock->peer->tcp.strp);
+
+	tcp_close(sk, timeout);
+
+	ovpn_peer_del(sock->peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+	rcu_read_unlock();
+}
+
+static __poll_t ovpn_tcp_poll(struct file *file, struct socket *sock,
+			      poll_table *wait)
+{
+	__poll_t mask = datagram_poll(file, sock, wait);
+	struct ovpn_socket *ovpn_sock;
+
+	rcu_read_lock();
+	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
+	if (!skb_queue_empty(&ovpn_sock->peer->tcp.user_queue))
+		mask |= EPOLLIN | EPOLLRDNORM;
+	rcu_read_unlock();
+
+	return mask;
+}
+
+static void ovpn_tcp_build_protos(struct proto *new_prot,
+				  struct proto_ops *new_ops,
+				  const struct proto *orig_prot,
+				  const struct proto_ops *orig_ops)
+{
+	memcpy(new_prot, orig_prot, sizeof(*new_prot));
+	memcpy(new_ops, orig_ops, sizeof(*new_ops));
+	new_prot->recvmsg = ovpn_tcp_recvmsg;
+	new_prot->sendmsg = ovpn_tcp_sendmsg;
+	new_prot->close = ovpn_tcp_close;
+	new_prot->release_cb = ovpn_tcp_release;
+	new_ops->poll = ovpn_tcp_poll;
+}
+
+/* Initialize TCP static objects */
+void __init ovpn_tcp_init(void)
+{
+	ovpn_tcp_build_protos(&ovpn_tcp_prot, &ovpn_tcp_ops, &tcp_prot,
+			      &inet_stream_ops);
+
+#if IS_ENABLED(CONFIG_IPV6)
+	ovpn_tcp_build_protos(&ovpn_tcp6_prot, &ovpn_tcp6_ops, &tcpv6_prot,
+			      &inet6_stream_ops);
+#endif
+}
diff --git a/drivers/net/ovpn/tcp.h b/drivers/net/ovpn/tcp.h
new file mode 100644
index 0000000000000000000000000000000000000000..994c18fd95468141dc4adfe5ff3e7eeade0bdbd4
--- /dev/null
+++ b/drivers/net/ovpn/tcp.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_TCP_H_
+#define _NET_OVPN_TCP_H_
+
+#include <linux/net.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include "peer.h"
+#include "skb.h"
+#include "socket.h"
+
+void __init ovpn_tcp_init(void);
+
+int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer);
+void ovpn_tcp_socket_detach(struct socket *sock);
+
+/* Prepare skb and enqueue it for sending to peer.
+ *
+ * Preparation consist in prepending the skb payload with its size.
+ * Required by the OpenVPN protocol in order to extract packets from
+ * the TCP stream on the receiver side.
+ */
+void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb);
+
+#endif /* _NET_OVPN_TCP_H_ */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 975392fc39bc4c0107a07a53795afecd88d72c53..da90a9a0903771d54869d844fbeddedda78985d3 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -384,6 +384,15 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
 void ovpn_udp_socket_detach(struct socket *sock)
 {
 	struct udp_tunnel_sock_cfg cfg = { };
+	struct ovpn_priv *ovpn;
+
+	rcu_read_lock();
+	ovpn = ovpn_from_udp_sock(sock->sk);
+	if (ovpn)
+		/* drop reference to netdev held in sk_user_data */
+		netdev_put(ovpn->dev, &ovpn->dev_tracker);
+	rcu_read_unlock();
 
 	setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
+	rcu_assign_sk_user_data(sock->sk, NULL);
 }
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index f60ec8b0f8ea40b2d635d802a3bc4f9b9d844417..3e812187e125cec7deac88413b85a35dd5b22a2d 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -715,6 +715,7 @@ const struct proto_ops inet6_stream_ops = {
 #endif
 	.set_rcvlowat	   = tcp_set_rcvlowat,
 };
+EXPORT_SYMBOL_GPL(inet6_stream_ops);
 
 const struct proto_ops inet6_dgram_ops = {
 	.family		   = PF_INET6,

-- 
2.45.2


