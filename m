Return-Path: <linux-kselftest+bounces-18880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9D198CF9B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAFE1F2307E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC31BBBCC;
	Wed,  2 Oct 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Vp7ZK0VV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5E019FA9D
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859818; cv=none; b=eUzywh1ipm7o6JjkTdxHKBb4YakCGqf3czkJD5P3zD+MEeDAgs1lvf2GREuhHZTlwMjYAr7rYc82qjLLLChq8Cs0Hs8P1DjeSw3ImeaeqsP+4Tib/x6YuUOHf8apbzSv3crS0h+oej72J3lMIb5ig69DxeGs6GxX/ug+ucMAUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859818; c=relaxed/simple;
	bh=LsN0kcYSqLCoUfF1EoZ4qP+bVQfuo1AhqIQmIQCdYLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QcPPtEchlnKi5vTkwQHB2y+espeKp7GbwKk3ZYr59GjtWw3rTqSwp2gHqO1+KTbTSbCw38XsoUiQ6vSGQ3KVV/JiOSe9hfRpKUovPRnIL64AOED0BUrco/exr3kbZhA9KYq3l78g5g0/HKBRj8/dfrQCio0saJNmydjGDHmNlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Vp7ZK0VV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cd5016d98so3315530f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859812; x=1728464612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLhkI0Q6L67BHoCzeNj9D9iPQT1B5QKWnqXp7U4Klcs=;
        b=Vp7ZK0VVkIuQD/FbaMxV1U4Wayold3+PWbqvREMch/SMroK59wNRo4wpKUWalXjnFv
         u9m7YsKsCOpFO0OAv/f6qdZpbpS5Exz60CtlCdvRVTw1+IQSwtl4+1Fydo4skNYjqjX/
         nxThGK73L9uu3Ye9Jpn4W0dE6k2gZU57ULpT5l8D1DnojLy00KhWKjQgei1WoQTRzpx1
         l3ycdD5FrqXxGx9Zf4K/xDXRiyHh0fjRu6UWCaGe457cs4gDPgFMI1O9xSzDJhxFGJDe
         N4oUMmk9T069S5L4cXAvrA7zUGicmxPGPN+1MSTB/z8mLDo8C96aeM+Xyk6zv8FEm87b
         17+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859812; x=1728464612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLhkI0Q6L67BHoCzeNj9D9iPQT1B5QKWnqXp7U4Klcs=;
        b=DOCr++vHNw/KGM/QT9l/lVBXT8tD+UXAe9U1shyKQMfvGpLUmFiKnQgt1+YNaDtkbH
         muHYKzjj+C7nxtIJETFkUU4mSMtPx07IYXte1aFXV+aSdQJdcgpCwAeGCTU/ySvG7EgU
         l+MoZ5/16SKZ4SFqPoapru/2wcfw98ZX83HK4HlGZx1q6tv9Gm6bKRqzv4nQqZHE4Q19
         1lIl6dgheCFW+uirjZrK0G/n3JLsWsyCxt6NH07tgHjVjY3c0gsZx0gysVHYWcngWVKM
         yULZGUZbI5cpOWmgE6GUArwN0nhBri0U3D6/BuQVihW7jTWsGnjhWlChL0e0PodWWQzB
         1TSg==
X-Forwarded-Encrypted: i=1; AJvYcCUBY3B2nvZXe75YUQ3OxbCmMViP9NGR+8R14EhnLJuNdt9G91dlMpSzboVgMcb5wLJJpARKKn02l9yFRD4kaDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2Uv8ELJu3jOuhPQoIzP8KJmOh9gSrzbP/i7M0jluDyTiKC09
	2fhU1BDhopuCLKtajIsVtX6ckflluJXsR5LGHGubLTwPmoeSLa6Gn01JyiwX7UA=
X-Google-Smtp-Source: AGHT+IE0cpuGolf8pT/ttAlbalzFE49a7uPBAN7yBGV+RhtMA3pT1VKsmow82iL4TnWXmUnOtxjHUw==
X-Received: by 2002:a05:6000:cd0:b0:374:c287:929b with SMTP id ffacd0b85a97d-37cfb8b1895mr1636980f8f.4.1727859812164;
        Wed, 02 Oct 2024 02:03:32 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:31 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:27 +0200
Subject: [PATCH net-next v8 13/24] ovpn: implement TCP transport
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-13-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=22637; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=LsN0kcYSqLCoUfF1EoZ4qP+bVQfuo1AhqIQmIQCdYLU=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxSvG6PW+tvJO7aRvviiPn9G625ppsjro59D
 HFcZ/sBtACJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUgAKCRALcOU6oDjV
 h/pXB/9Jyiwsvqy9I6cuPOKk5LOi7DvfOsAvE7GqHismocbqZwxM2pQjgTiwR/vs46aIhXjzB8z
 XCIJjE2jJzmMUuQ2SJ2ZdJtmM3nLbSSFVx4i0Z4DvPw1FFDRQFNPMscUbxUQekymC4QfkMp3Pp2
 ZNPMXBsOR44/KIDeGUOsz2nvB9nPOo1ab5rVAk4+FhzGMT43mN0SAPLBfkDW6JS0Pyaxqk82RvJ
 hyGK/82hCFfSYMdyjI1RSnY/MCncE488zaZYzWSD9CzPVbiEk2Dv+wjAGSZopFoPycjpWYIAtAF
 K3AG60MDKNOk6L0ryIHaQLSdfUa3qh9juTsGa2veOBdON6Ia
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

With this change ovpn is allowed to communicate to peers also via TCP.
Parsing of incoming messages is implemented through the strparser API.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/Kconfig       |   1 +
 drivers/net/ovpn/Makefile |   1 +
 drivers/net/ovpn/io.c     |   4 +
 drivers/net/ovpn/main.c   |   3 +
 drivers/net/ovpn/peer.h   |  37 ++++
 drivers/net/ovpn/socket.c |  27 ++-
 drivers/net/ovpn/socket.h |   7 +-
 drivers/net/ovpn/tcp.c    | 506 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/tcp.h    |  43 ++++
 9 files changed, 625 insertions(+), 4 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 0055bcd2356c70bd9cfd8a944f549817dab8154f..cef1dd4dccad37c7b60a00aa41ab258c8df0807c 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -118,6 +118,7 @@ config WIREGUARD_DEBUG
 config OVPN
 	tristate "OpenVPN data channel offload"
 	depends on NET && INET
+	select STREAM_PARSER
 	select NET_UDP_TUNNEL
 	select DST_CACHE
 	select CRYPTO
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
index d54af1a0f03a33b03001a041e62554b35a7f5ebc..985f8bba6f1355b9f164e53f11575fa104133d43 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -22,6 +22,7 @@
 #include "netlink.h"
 #include "proto.h"
 #include "socket.h"
+#include "tcp.h"
 #include "udp.h"
 #include "skb.h"
 
@@ -209,6 +210,9 @@ void ovpn_encrypt_post(void *data, int ret)
 	case IPPROTO_UDP:
 		ovpn_udp_send_skb(peer->ovpn, peer, skb);
 		break;
+	case IPPROTO_TCP:
+		ovpn_tcp_send_skb(peer, skb);
+		break;
 	default:
 		/* no transport configured yet */
 		goto err;
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 670e66f8f750086de5d48e4708721d102c149a2e..cb5cc3d4b5620f5a1e401e06e52e67c32e57aa78 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -25,6 +25,7 @@
 #include "io.h"
 #include "packet.h"
 #include "peer.h"
+#include "tcp.h"
 
 /* Driver info */
 #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
@@ -270,6 +271,8 @@ static int __init ovpn_init(void)
 		goto unreg_rtnl;
 	}
 
+	ovpn_tcp_init();
+
 	return 0;
 
 unreg_rtnl:
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 89f6face71871e09f8efd533a949f0d9358a1342..86d4696b1529c45025b63d2973fc48ca81ca8f63 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -11,6 +11,7 @@
 #define _NET_OVPN_OVPNPEER_H_
 
 #include <net/dst_cache.h>
+#include <net/strparser.h>
 #include <uapi/linux/ovpn.h>
 
 #include "bind.h"
@@ -30,6 +31,18 @@
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
  * @sock: the socket being used to talk to this peer
+ * @tcp: keeps track of TCP specific state
+ * @tcp.strp: stream parser context (TCP only)
+ * @tcp.tx_work: work for deferring outgoing packet processing (TCP only)
+ * @tcp.user_queue: received packets that have to go to userspace (TCP only)
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
@@ -50,6 +63,30 @@ struct ovpn_peer {
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
index 964b566de69f4132806a969a455cec7f6059a0bd..8bb3b0cb18ec004fbae396cb2b152793653877d2 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -15,6 +15,7 @@
 #include "io.h"
 #include "peer.h"
 #include "socket.h"
+#include "tcp.h"
 #include "udp.h"
 
 static void ovpn_socket_detach(struct socket *sock)
@@ -24,6 +25,8 @@ static void ovpn_socket_detach(struct socket *sock)
 
 	if (sock->sk->sk_protocol == IPPROTO_UDP)
 		ovpn_udp_socket_detach(sock);
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
+		ovpn_tcp_socket_detach(sock);
 
 	sockfd_put(sock);
 }
@@ -70,6 +73,8 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
 
 	if (sock->sk->sk_protocol == IPPROTO_UDP)
 		ret = ovpn_udp_socket_attach(sock, peer->ovpn);
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
+		ret = ovpn_tcp_socket_attach(sock, peer);
 
 	return ret;
 }
@@ -131,14 +136,30 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
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
+	} else {
+		/* in UDP we only link the ovpn instance since the socket is
+		 * shared among multiple peers
+		 */
+		ovpn_sock->ovpn = peer->ovpn;
+	}
+
 	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
 
 	return ovpn_sock;
+err:
+	ovpn_socket_detach(sock);
+	return ERR_PTR(ret);
 }
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index 5ad9c5073b085482da95ee8ebf40acf20bf2e4b3..e9f0035d706eb081f60db0e0d7c62cc27185b8fb 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -20,12 +20,17 @@ struct ovpn_peer;
 /**
  * struct ovpn_socket - a kernel socket referenced in the ovpn code
  * @ovpn: ovpn instance owning this socket (UDP only)
+ * @peer: unique peer transmitting over this socket (TCP only)
  * @sock: the low level sock object
  * @refcount: amount of contexts currently referencing this object
  * @rcu: member used to schedule RCU destructor callback
  */
 struct ovpn_socket {
-	struct ovpn_struct *ovpn;
+	union {
+		struct ovpn_struct *ovpn;
+		struct ovpn_peer *peer;
+	};
+
 	struct socket *sock;
 	struct kref refcount;
 	struct rcu_head rcu;
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
new file mode 100644
index 0000000000000000000000000000000000000000..f2f8ad53451405694d9fc1acd7b87c3fa8213f6c
--- /dev/null
+++ b/drivers/net/ovpn/tcp.c
@@ -0,0 +1,506 @@
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
+#include <net/tcp.h>
+#include <net/route.h>
+#include <trace/events/sock.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "io.h"
+#include "packet.h"
+#include "peer.h"
+#include "proto.h"
+#include "skb.h"
+#include "socket.h"
+#include "tcp.h"
+
+static struct proto ovpn_tcp_prot __ro_after_init;
+static struct proto_ops ovpn_tcp_ops __ro_after_init;
+static struct proto ovpn_tcp6_prot;
+static struct proto_ops ovpn_tcp6_ops;
+static DEFINE_MUTEX(tcp6_prot_mutex);
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
+static void ovpn_tcp_to_userspace(struct ovpn_socket *sock, struct sk_buff *skb)
+{
+	struct sock *sk = sock->sock->sk;
+
+	skb_set_owner_r(skb, sk);
+	memset(skb->cb, 0, sizeof(skb->cb));
+	skb_queue_tail(&sock->peer->tcp.user_queue, skb);
+	sock->peer->tcp.sk_cb.sk_data_ready(sk);
+}
+
+static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
+{
+	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
+	struct strp_msg *msg = strp_msg(skb);
+	size_t pkt_len = msg->full_len - 2;
+	size_t off = msg->offset + 2;
+
+	/* ensure skb->data points to the beginning of the openvpn packet */
+	if (!pskb_pull(skb, off)) {
+		net_warn_ratelimited("%s: packet too small\n",
+				     peer->ovpn->dev->name);
+		goto err;
+	}
+
+	/* strparser does not trim the skb for us, therefore we do it now */
+	if (pskb_trim(skb, pkt_len) != 0) {
+		net_warn_ratelimited("%s: trimming skb failed\n",
+				     peer->ovpn->dev->name);
+		goto err;
+	}
+
+	/* we need the first byte of data to be accessible
+	 * to extract the opcode and the key ID later on
+	 */
+	if (!pskb_may_pull(skb, 1)) {
+		net_warn_ratelimited("%s: packet too small to fetch opcode\n",
+				     peer->ovpn->dev->name);
+		goto err;
+	}
+
+	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
+	if (likely(ovpn_opcode_from_skb(skb, 0) == OVPN_DATA_V2)) {
+		/* hold reference to peer as required by ovpn_recv().
+		 *
+		 * NOTE: in this context we should already be holding a
+		 * reference to this peer, therefore ovpn_peer_hold() is
+		 * not expected to fail
+		 */
+		if (WARN_ON(!ovpn_peer_hold(peer)))
+			goto err;
+
+		ovpn_recv(peer, skb);
+	} else {
+		/* The packet size header must be there when sending the packet
+		 * to userspace, therefore we put it back
+		 */
+		skb_push(skb, 2);
+		ovpn_tcp_to_userspace(peer->sock, skb);
+	}
+
+	return;
+err:
+	netdev_err(peer->ovpn->dev,
+		   "cannot process incoming TCP data for peer %u\n", peer->id);
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
+	rcu_assign_sk_user_data(sock->sk, NULL);
+
+	rcu_read_unlock();
+
+	/* cancel any ongoing work. Done after removing the CBs so that these
+	 * workers cannot be re-armed
+	 */
+	cancel_work_sync(&peer->tcp.tx_work);
+	strp_done(&peer->tcp.strp);
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
+					     peer->ovpn->dev->name, peer->id,
+					     ret);
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
+void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	if (peer->tcp.out_msg.skb)
+		return;
+
+	peer->tcp.out_msg.skb = skb;
+	peer->tcp.out_msg.len = skb->len;
+	peer->tcp.out_msg.offset = 0;
+
+	ovpn_tcp_send_sock(peer);
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
+	if (msg->msg_flags & ~MSG_DONTWAIT) {
+		ret = -EOPNOTSUPP;
+		goto peer_free;
+	}
+
+	lock_sock(sk);
+
+	if (peer->tcp.out_msg.skb) {
+		ret = -EAGAIN;
+		goto unlock;
+	}
+
+	if (size < linear)
+		linear = size;
+
+	skb = sock_alloc_send_pskb(sk, linear, size - linear,
+				   msg->msg_flags & MSG_DONTWAIT, &ret, 0);
+	if (!skb) {
+		net_err_ratelimited("%s: skb alloc failed: %d\n",
+				    sock->peer->ovpn->dev->name, ret);
+		goto unlock;
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
+				    sock->peer->ovpn->dev->name, ret);
+		goto unlock;
+	}
+
+	ovpn_tcp_send_sock_skb(sock->peer, skb);
+	ret = size;
+unlock:
+	release_sock(sk);
+peer_free:
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
+		netdev_err(peer->ovpn->dev,
+			   "provided socket is not TCP as expected\n");
+		return -EINVAL;
+	}
+
+	/* only a fully connected socket are expected. Connection should be
+	 * handled in userspace
+	 */
+	if (sock->sk->sk_state != TCP_ESTABLISHED) {
+		netdev_err(peer->ovpn->dev,
+			   "provided TCP socket is not in ESTABLISHED state: %d\n",
+			   sock->sk->sk_state);
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
+	strp_check_rcv(&peer->tcp.strp);
+	skb_queue_head_init(&peer->tcp.user_queue);
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
+		mutex_lock(&tcp6_prot_mutex);
+		if (!ovpn_tcp6_prot.recvmsg)
+			ovpn_tcp_build_protos(&ovpn_tcp6_prot, &ovpn_tcp6_ops,
+					      sock->sk->sk_prot,
+					      sock->sk->sk_socket->ops);
+		mutex_unlock(&tcp6_prot_mutex);
+
+		sock->sk->sk_prot = &ovpn_tcp6_prot;
+		sock->sk->sk_socket->ops = &ovpn_tcp6_ops;
+	}
+
+	/* avoid using task_frag */
+	sock->sk->sk_allocation = GFP_ATOMIC;
+	sock->sk->sk_use_task_frag = false;
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
+	barrier();
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
+	new_ops->poll = ovpn_tcp_poll;
+}
+
+/* Initialize TCP static objects */
+void __init ovpn_tcp_init(void)
+{
+	ovpn_tcp_build_protos(&ovpn_tcp_prot, &ovpn_tcp_ops, &tcp_prot,
+			      &inet_stream_ops);
+}
diff --git a/drivers/net/ovpn/tcp.h b/drivers/net/ovpn/tcp.h
new file mode 100644
index 0000000000000000000000000000000000000000..77773bb684f55404a4bd2a839d82f417a5401471
--- /dev/null
+++ b/drivers/net/ovpn/tcp.h
@@ -0,0 +1,43 @@
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
+
+void __init ovpn_tcp_init(void);
+
+int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer);
+void ovpn_tcp_socket_detach(struct socket *sock);
+void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sk_buff *skb);
+
+/* Prepare skb and enqueue it for sending to peer.
+ *
+ * Preparation consist in prepending the skb payload with its size.
+ * Required by the OpenVPN protocol in order to extract packets from
+ * the TCP stream on the receiver side.
+ */
+static inline void ovpn_tcp_send_skb(struct ovpn_peer *peer,
+				     struct sk_buff *skb)
+{
+	u16 len = skb->len;
+
+	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
+
+	bh_lock_sock(peer->sock->sock->sk);
+	ovpn_tcp_send_sock_skb(peer, skb);
+	bh_unlock_sock(peer->sock->sock->sk);
+}
+
+#endif /* _NET_OVPN_TCP_H_ */

-- 
2.45.2


