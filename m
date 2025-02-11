Return-Path: <linux-kselftest+bounces-26292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7248BA2FF66
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99663167B7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7DF1E5B96;
	Tue, 11 Feb 2025 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ofv0PdZQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281031D5CCD
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234480; cv=none; b=s7IGtZmPQQ51S5uSniiZL/+tUxTG1rN52qvnWyWlZ7csqLMl/0ADVOcoT4cnTWsleh5XPnyG+kH9d/Epju0LQGZ5z3uoTomwTFL35bvAYTYr3n9QaS02dV6JySETUWfwnCLzUKF/n7KOHBSQgI2w01wdTjiZF0ERNxKuomNM0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234480; c=relaxed/simple;
	bh=hWNjF1KMDVLR8odIS0PZnyXcco7EGOlpor8Bu/gKBOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJUCNs681aG0TbVVTZwJMsY6Meu6nxwMAGj2dFYMJG3P1jjojWraUvexXmdRypS0UeoB3HXUlm8PNtjik6iJEpfoRMHC0LSGjzs9V8rtIgpaUPvhroZvuIGk0S+GqFDih/gI8xp/7fZ10e3FDEOLCFuvBEJ3HFlO2MCVW8Nqz8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ofv0PdZQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso26762805e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234475; x=1739839275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bAIzJNkaftZwywF6W1elua1sU8C07uYg77JqkVZ+Kc=;
        b=Ofv0PdZQKkKFLFveMjfzGdV5VYSoOQPuccuG4w1kjcFXlNq2Xo5Cl2Xp17MEnpNVsU
         nXSuhYIiXwHgCHKZqyqK4/M91zCo+tXvKRcw0ycd1yoaO42sFmVGN9+qYekQmqsfNhBm
         1m1FSljeiMvvFgxJUg3y4ysqWDggha0lSpAYfX6n7k0TpE6jtH8CaYUmCmfMeZ/fRn/T
         GXjDEvF8viSGVbW0FA5yFvhjOOd3OP7LaZXulbkEgxiq7wdQB1qDfDFwu9GyX1GlHXZ7
         AkQNFkGb/gHj+FERfBF4HDmXbSnr54fyUO/fU41P1hbhKrpzgC84y7yDwrDZ2zRGMxdb
         zvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234475; x=1739839275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bAIzJNkaftZwywF6W1elua1sU8C07uYg77JqkVZ+Kc=;
        b=NUj2pvAU0DLg1Z+nHVAiRIbq7TQiyCaI05jhb17ZDyEUkCgPDW3prZ7MkOrFgVUJG8
         OVVGZot6wTMLr8+RjHDgYfzUnSnbtXNeiIt+0CNuzw7rPVo9i7HUYqNLNj72Rgk/2Kfe
         aAk5GEGkzzGEUi2oF0IaIWrP6Oe3LQ1pqSru0Tr+ZqTHElVkiolxMjUjn9v7CCQbYWgW
         aN/4V0iyb1dlOjDb9srvQO7vYL5pcWWkOLC/jf29RV40RlV8d2WDjM46/0bu1iBSHZg8
         7osa+zu9CYG5OyAvQ1v+6z6kkYLJ6lbq4Swl/xaX9J+8wa21XhTiFs9TpqmKhl3fdQCi
         Ppfg==
X-Forwarded-Encrypted: i=1; AJvYcCXq5e+mEqo3YInJ9nQsWXOli6oDB91ODL3+oM9Sh7Fof9I6emHwY7kwuS0ug64TrQW58jZJa/Guc+3cssM0TjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkNkcWN0kg41aJYReV8jw4sI0RdSJgelIfpgW27Or3USb8wKd9
	sf67gpkuSEc+hbjpmhoTqgnsSLTzW7KON3kfm6UvPfpb9A8ODrq7VdaWA25zjzg=
X-Gm-Gg: ASbGnctkV3h0IT7cXm9Ohde59IXDiF/nugSLl2ASxGcdZyPLyKNpdPEmGuaSqgksYXa
	j0JCxRkJfAWkqfLeaYvi69e9uWjNDtelp6u1f0qO/7SX+pfxnz2MduDRmh/BIA0H2sK8fnQ3rYr
	dhHQDtvw6V8qUieVyidHE/LqkXcDyVXJhHYHaSbnzm+VRye2o5pRen/EErsf9w/rIHHjkt9gt9C
	u3+fSEkZY2aAZNW1ZWVCY2EZkZJx1uyrK8VBYemS3vL8GBOHzLEcebMGvUt/Ap2euuvA7xmpnPr
	aBx2EfNTxcL51gbjESLLlsoV9f0=
X-Google-Smtp-Source: AGHT+IFDaf5OpGQxd+uygnu7Yvt0vbSpoh3JPgZgFhBe9XNSeI027mfpaDpD8xJSJmXuNZoHicVIdw==
X-Received: by 2002:a5d:6d0c:0:b0:38d:df29:e14f with SMTP id ffacd0b85a97d-38ddf29e276mr5802580f8f.43.1739234475226;
        Mon, 10 Feb 2025 16:41:15 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:14 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:40:05 +0100
Subject: [PATCH net-next v19 12/26] ovpn: implement TCP transport
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-12-86d5daf2a47a@openvpn.net>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24900; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=hWNjF1KMDVLR8odIS0PZnyXcco7EGOlpor8Bu/gKBOM=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyNAkOfqqXg1il2gEI5sxqZoestYPd0kuLFU
 NZJMtwtXtOJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjQAKCRALcOU6oDjV
 h+5MCACXfMi8B9rLYwcb5dMqFwDfzqwko+tbS3EeYC9DvAkfVZnEZZ46ut0hrzOWsC9q9Sk96IN
 /N5j+X1InvJX7SxPnNNnEaXs0niOQA7ZiUrk+i8lDgL0rOlBjAQWrTab+1t0WiC52ycfllswJ2g
 iQoBnwZIMaCRw9G2IVa8z7VPqhfiQCurUsMe+3bGtxqzwWjmOISvmx8Vgc1utRGouolctjFOtad
 O9/VPkY218mwCnuh+hiUA9oCwgBnrhNXVAVU1vu3hWvaLwZ3GTLwpTdsCub33SHan9541kzpSEF
 G9b2MpDSaHni5zcLrP6RbAPC2Y4m0lEh13WAMNMokSEZGfCL
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
 drivers/net/Kconfig         |   1 +
 drivers/net/ovpn/Makefile   |   1 +
 drivers/net/ovpn/io.c       |   4 +
 drivers/net/ovpn/main.c     |   3 +
 drivers/net/ovpn/ovpnpriv.h |   1 +
 drivers/net/ovpn/peer.h     |  33 +++
 drivers/net/ovpn/socket.c   |  16 +-
 drivers/net/ovpn/socket.h   |   6 +
 drivers/net/ovpn/tcp.c      | 553 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/tcp.h      |  34 +++
 10 files changed, 650 insertions(+), 2 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 51d77f3c0848c3c9425b586c6a90cff99a744390..754476cf6dc4774310205dd34f1124795fd2c4f7 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -125,6 +125,7 @@ config OVPN
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
index 34753eea78aa634f2e01370797e243b615d0c996..aa8996043225edad248858371a74e41a689f85c8 100644
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
@@ -223,6 +224,9 @@ void ovpn_encrypt_post(void *data, int ret)
 	case IPPROTO_UDP:
 		ovpn_udp_send_skb(peer, sock->sock, skb);
 		break;
+	case IPPROTO_TCP:
+		ovpn_tcp_send_skb(peer, sock->sock, skb);
+		break;
 	default:
 		/* no transport configured yet */
 		goto err_unlock;
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index d5d110b9d1b9dba7f0b4fda75d3cc9c050ba5524..2190926ce37dedb0877a4db1d482b7dafc405df2 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -22,6 +22,7 @@
 #include "io.h"
 #include "peer.h"
 #include "proto.h"
+#include "tcp.h"
 
 static int ovpn_net_init(struct net_device *dev)
 {
@@ -236,6 +237,8 @@ static int __init ovpn_init(void)
 		goto unreg_rtnl;
 	}
 
+	ovpn_tcp_init();
+
 	return 0;
 
 unreg_rtnl:
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 713702a475c56c4d4fcb15ad5b100405d78a5ff7..f6636cf4c287928ec005c94ad011f978b609069e 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNSTRUCT_H_
 #define _NET_OVPN_OVPNSTRUCT_H_
 
+#include <linux/workqueue.h>
 #include <net/gro_cells.h>
 #include <uapi/linux/if_link.h>
 #include <uapi/linux/ovpn.h>
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 9cc25ab350f4af98f8af3b75dfd57b8a493d433a..5b0fc94522ff1915ec3ed1f1f3564e58cdaac971 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -11,6 +11,7 @@
 #define _NET_OVPN_OVPNPEER_H_
 
 #include <net/dst_cache.h>
+#include <net/strparser.h>
 
 #include "crypto.h"
 #include "socket.h"
@@ -25,6 +26,18 @@
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
  * @sock: the socket being used to talk to this peer
+ * @tcp: keeps track of TCP specific state
+ * @tcp.strp: stream parser context (TCP only)
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
@@ -45,6 +58,26 @@ struct ovpn_peer {
 		struct in6_addr ipv6;
 	} vpn_addrs;
 	struct ovpn_socket __rcu *sock;
+
+	struct {
+		struct strparser strp;
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
index 58f18f369736f1bbd1207336ffcb11cc4cb7bf0f..1ce949b5c83056c25c38f4afd1ef7150b0d16d83 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -16,6 +16,7 @@
 #include "io.h"
 #include "peer.h"
 #include "socket.h"
+#include "tcp.h"
 #include "udp.h"
 
 static void ovpn_socket_release_kref(struct kref *kref)
@@ -26,6 +27,9 @@ static void ovpn_socket_release_kref(struct kref *kref)
 	if (sock->sock->sk->sk_protocol == IPPROTO_UDP) {
 		ovpn_udp_socket_detach(sock);
 		netdev_put(sock->ovpn->dev, &sock->dev_tracker);
+	} else if (sock->sock->sk->sk_protocol == IPPROTO_TCP) {
+		ovpn_tcp_socket_detach(sock);
+		ovpn_peer_put(sock->peer);
 	}
 
 	sockfd_put(sock->sock);
@@ -91,6 +95,8 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
 
 	if (sock->sk->sk_protocol == IPPROTO_UDP)
 		return ovpn_udp_socket_attach(sock, peer->ovpn);
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
+		return ovpn_tcp_socket_attach(sock, peer);
 
 	return -EOPNOTSUPP;
 }
@@ -181,11 +187,17 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 		goto sock_release;
 	}
 
-	ovpn_sock->ovpn = peer->ovpn;
 	ovpn_sock->sock = sock;
 	kref_init(&ovpn_sock->refcount);
 
-	if (sock->sk->sk_protocol == IPPROTO_UDP) {
+	/* TCP sockets are per-peer, therefore they are linked to their unique
+	 * peer
+	 */
+	if (sock->sk->sk_protocol == IPPROTO_TCP) {
+		INIT_WORK(&ovpn_sock->tcp_tx_work, ovpn_tcp_tx_work);
+		ovpn_sock->peer = peer;
+		ovpn_peer_hold(peer);
+	} else if (sock->sk->sk_protocol == IPPROTO_UDP) {
 		/* in UDP we only link the ovpn instance since the socket is
 		 * shared among multiple peers
 		 */
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index 974aab3e435db519ee336c951f25588143ec7524..872852c19cf71491547d15bdb5157ebdab6e2db9 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -21,8 +21,11 @@ struct ovpn_peer;
  * struct ovpn_socket - a kernel socket referenced in the ovpn code
  * @ovpn: ovpn instance owning this socket (UDP only)
  * @dev_tracker: reference tracker for associated dev (UDP only)
+ * @peer: unique peer transmitting over this socket (TCP only)
  * @sock: the low level sock object
  * @refcount: amount of contexts currently referencing this object
+ * @work: member used to schedule release routine (it may block)
+ * @tcp_tx_work: work for deferring outgoing packet processing (TCP only)
  * @rcu: member used to schedule RCU destructor callback
  */
 struct ovpn_socket {
@@ -31,10 +34,13 @@ struct ovpn_socket {
 			struct ovpn_priv *ovpn;
 			netdevice_tracker dev_tracker;
 		};
+		struct ovpn_peer *peer;
 	};
 
 	struct socket *sock;
 	struct kref refcount;
+	struct work_struct work;
+	struct work_struct tcp_tx_work;
 	struct rcu_head rcu;
 };
 
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
new file mode 100644
index 0000000000000000000000000000000000000000..c7eb96d79e0229d178e1cf090cea45361730685e
--- /dev/null
+++ b/drivers/net/ovpn/tcp.c
@@ -0,0 +1,553 @@
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
+#include "ovpnpriv.h"
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
+	if (!pskb_may_pull(skb, OVPN_OPCODE_SIZE)) {
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
+	if (unlikely(!sock || !sock->peer || !ovpn_peer_hold(sock->peer))) {
+		rcu_read_unlock();
+		return -EBADF;
+	}
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
+void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock)
+{
+	struct ovpn_peer *peer = ovpn_sock->peer;
+	struct socket *sock = ovpn_sock->sock;
+
+	strp_stop(&peer->tcp.strp);
+
+	skb_queue_purge(&peer->tcp.user_queue);
+
+	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
+	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
+	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
+	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
+	sock->sk->sk_socket->ops = peer->tcp.sk_cb.ops;
+
+	/* drop reference to peer */
+	rcu_assign_sk_user_data(sock->sk, NULL);
+
+	/* before canceling any ongoing work we must ensure that CBs
+	 * have been reset to prevent workers from being re-armed
+	 */
+	barrier();
+
+	cancel_work_sync(&ovpn_sock->tcp_tx_work);
+	strp_done(&peer->tcp.strp);
+	skb_queue_purge(&peer->tcp.out_queue);
+	kfree_skb(peer->tcp.out_msg.skb);
+}
+
+static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
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
+		int ret = skb_send_sock_locked(sk, skb,
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
+	if (!peer->tcp.out_msg.len) {
+		preempt_disable();
+		dev_sw_netstats_tx_add(peer->ovpn->dev, 1, skb->len);
+		preempt_enable();
+	}
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
+void ovpn_tcp_tx_work(struct work_struct *work)
+{
+	struct ovpn_socket *sock;
+
+	sock = container_of(work, struct ovpn_socket, tcp_tx_work);
+
+	lock_sock(sock->sock->sk);
+	if (sock->peer)
+		ovpn_tcp_send_sock(sock->peer, sock->sock->sk);
+	release_sock(sock->sock->sk);
+}
+
+static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk, struct sk_buff *skb)
+{
+	if (peer->tcp.out_msg.skb)
+		ovpn_tcp_send_sock(peer, sk);
+
+	if (peer->tcp.out_msg.skb) {
+		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
+		kfree_skb(skb);
+		return;
+	}
+
+	peer->tcp.out_msg.skb = skb;
+	peer->tcp.out_msg.len = skb->len;
+	peer->tcp.out_msg.offset = 0;
+	ovpn_tcp_send_sock(peer, sk);
+}
+
+void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct socket *sock, struct sk_buff *skb)
+{
+	u16 len = skb->len;
+
+	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
+
+	bh_lock_sock(sock->sk);
+	if (sock_owned_by_user(sock->sk)) {
+		if (skb_queue_len(&peer->tcp.out_queue) >=
+		    READ_ONCE(net_hotdata.max_backlog)) {
+			dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
+			kfree_skb(skb);
+			goto unlock;
+		}
+		__skb_queue_tail(&peer->tcp.out_queue, skb);
+	} else {
+		ovpn_tcp_send_sock_skb(peer, sock->sk, skb);
+	}
+unlock:
+	bh_unlock_sock(sock->sk);
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
+		ovpn_tcp_send_sock_skb(peer, sk, skb);
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
+	if (unlikely(!sock || !sock->peer || !ovpn_peer_hold(sock->peer))) {
+		rcu_read_unlock();
+		return -EIO;
+	}
+	peer = sock->peer;
+	rcu_read_unlock();
+
+	lock_sock(sk);
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
+				    netdev_name(peer->ovpn->dev), ret);
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
+				    netdev_name(peer->ovpn->dev), ret);
+		goto peer_free;
+	}
+
+	ovpn_tcp_send_sock_skb(peer, sk, skb);
+	ret = size;
+peer_free:
+	release_sock(sk);
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
+	if (likely(sock && sock->peer))
+		strp_data_ready(&sock->peer->tcp.strp);
+	rcu_read_unlock();
+}
+
+static void ovpn_tcp_write_space(struct sock *sk)
+{
+	struct ovpn_socket *sock;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	if (likely(sock && sock->peer)) {
+		schedule_work(&sock->tcp_tx_work);
+		sock->peer->tcp.sk_cb.sk_write_space(sk);
+	}
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
+	/* only a fully connected socket is expected. Connection should be
+	 * handled in userspace
+	 */
+	if (sock->sk->sk_state != TCP_ESTABLISHED) {
+		net_err_ratelimited("%s: provided TCP socket is not in ESTABLISHED state: %d\n",
+				    netdev_name(peer->ovpn->dev),
+				    sock->sk->sk_state);
+		return -EINVAL;
+	}
+
+	ret = strp_init(&peer->tcp.strp, sock->sk, &cb);
+	if (ret < 0) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return ret;
+	}
+
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
+	return 0;
+}
+
+static void ovpn_tcp_close(struct sock *sk, long timeout)
+{
+	struct ovpn_socket *sock;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	if (sock && sock->peer) {
+		strp_stop(&sock->peer->tcp.strp);
+		ovpn_peer_del(sock->peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+	}
+	rcu_read_unlock();
+	tcp_close(sk, timeout);
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
+	if (ovpn_sock && ovpn_sock->peer &&
+	    !skb_queue_empty(&ovpn_sock->peer->tcp.user_queue))
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
index 0000000000000000000000000000000000000000..0be0c5ba4e02566b907ac82a3d89041e52dd7f16
--- /dev/null
+++ b/drivers/net/ovpn/tcp.h
@@ -0,0 +1,34 @@
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
+void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock);
+
+/* Prepare skb and enqueue it for sending to peer.
+ *
+ * Preparation consist in prepending the skb payload with its size.
+ * Required by the OpenVPN protocol in order to extract packets from
+ * the TCP stream on the receiver side.
+ */
+void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct socket *sock, struct sk_buff *skb);
+void ovpn_tcp_tx_work(struct work_struct *work);
+
+#endif /* _NET_OVPN_TCP_H_ */

-- 
2.45.3


