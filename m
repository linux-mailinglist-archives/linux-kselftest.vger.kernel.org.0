Return-Path: <linux-kselftest+bounces-28854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4347FA5E5CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF38E3B9379
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 20:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15621F3D20;
	Wed, 12 Mar 2025 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cceOagZH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1351F2B90
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812885; cv=none; b=RvpPjwBk5+FBMXSTk5fW+gQrvMjuxb3nduIVrgrR/YlkuZPZU8/aMgNL8DOQxS0ICri59tsC8gjmmbcWP2ZbvLXZqj/fTsbYa09ZuPxg8bB1dSnALdVauoOn6WPUJDJ35nKDY3RPPL0hS4w/E5Zuj3P1YZVMRo7p0auQIgBoKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812885; c=relaxed/simple;
	bh=+0Lpy1HA2CXCFjidG7l956cT4RDP9YW3z8Brznsib4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYePCKc+ULWEdUxtVWxoT5sEPkwknzbU48XawBpA+I08bRgU1lk5jBY8PtYkPw8QpL9xOLw5zDz82C60XO1iGIVp4NidMOyLBpTe8/4IlBih3kcXPQ4/P3xN2TezvKETFV3QgXENSE6QER1Q7zLNOfgoFZFlp2fCYCP3+8iXQq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cceOagZH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-391342fc0b5so205396f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812879; x=1742417679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqH+PW2Am/OFHlScwl6b4nX6zbAU4r/87RUNyfO9FOM=;
        b=cceOagZH/yltDd1XOnLhT86KVThCVGDd/gX5ZXC78oDj+5ztSk9lialr5aF0MdzvKQ
         65vr6/4pOUEKbex5Em7Y0cwKVUTmlj6ac3ZKvAePnE95ETVoJt5PokGcvf7AXob3YEQm
         B6vUFBbFDlmGBy7WbQsiRUw1sIbE9nTKqLYU74wEE/+zuObPG784CiHY7nFkD69f2Dwh
         QdVlGRSh+kHsPl7Jb35jKsXEsTusHkQbuoqJtPdIX11A5h/jj83b4qZKvXtSBTOt/7C0
         wuRb4ugAhUnHbwNcZ7gOS+B/DcK7tgfvnji3riPLkbf5X3syGRFqicd8eWh5L2/fLEBU
         qYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812879; x=1742417679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqH+PW2Am/OFHlScwl6b4nX6zbAU4r/87RUNyfO9FOM=;
        b=v6G6s3iojIUYSmubHnqzIZZFM/QEYGDhpgybI6R2zfuaX4EQ4b2Id39l6JR6k6I6TR
         KfT6prgiJC1nEqKFxHYM26S44h45U642MIK4DiJM0OqPIluUNxS1ELN2URlMxDN1dllg
         DNyGNvpibuEWKRQlHSkeTgkHWhs230DBs1lsLBVcnwca/jY8w7mTii5oZrQ9+nAWlPFp
         qiTRzmyOrKMSHyD8zZAXC307ksx+lpf1ft4U/2z1VY2rpZZCZ4fIgxn580lYdStiaA12
         DrvbQJgXR1l23xyejRh+sfFkSQyy8es/LQnJaAXeJWKzlJJh9qe/itLv+oKmVnA9WsOK
         eGEw==
X-Forwarded-Encrypted: i=1; AJvYcCVCAIw7p3rT3T3U89Lt0VP86qLVJarni4/q/mwoOGKH+9Tawsr44fYoWp9a62gPEE6K0pMOn1bIZMlqqfLH/tM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+sL2FOXIwPPdej2M/lIgHn62H2NkfmV30lstIYTGDDeB9Hd0
	UPCIkuXgunHpdqJdNY9aXqX+DKVqToqHsXnCZSdD0YJXtiFYyNvsFv8FO9aWtAc=
X-Gm-Gg: ASbGnctky5Pu26AsFZwDpKwwhLKlEBIInehJZIur0WUOet0LO8pje4U/WisrAF3s0Xc
	HCFoAwkDXzUTZFyHCyPvPAAvpJPDbOfzWCEtA+sfMRxVAqLT1FhkwRerrysSl2xbUF1Eqpd3gSs
	1/5CUH154SC0Aq8YvGSY/hOcXNVt0PuNF0mCvjazlZ2r72ckdhvTba6L1XitwIk7i2Hy8qHugYi
	lfnS3YljlQHQnPGhWI6KuPyQns1tASfG8O4gmZ44KodpSkmjhEAXhozoSYcLQRfHmQSqWu/Bvpr
	ALC6Hjg0GZV2LjfmdAcApUJVfN9gmZNFRV5w2bpmxw==
X-Google-Smtp-Source: AGHT+IEEGJ0Hsqud7hPajk/GIQtukILR00DM/BexIGUvvmgAK5ZlpRTNGMSKbznfKySB/uL23vkqIg==
X-Received: by 2002:a05:6000:1887:b0:391:2c67:7999 with SMTP id ffacd0b85a97d-39132db1bf2mr22842122f8f.48.1741812879208;
        Wed, 12 Mar 2025 13:54:39 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:38 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:20 +0100
Subject: [PATCH net-next v23 11/23] ovpn: implement TCP transport
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-11-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
In-Reply-To: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 David Ahern <dsahern@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=28787; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=+0Lpy1HA2CXCFjidG7l956cT4RDP9YW3z8Brznsib4o=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR7lgdDYGz4BBMvJRZPvJixTL6/sdZZwnYSz
 EKRjJzt0HiJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0ewAKCRALcOU6oDjV
 h012B/9TdhxpV+5tX1BHR1VSSoJo9n4Mg9N4LWZKJ6EjSOnvzMdhPSjWfVPnx/veOzafRQvO3rS
 X+tdHI0U7Lm4Ud+cVpmuW6qe7r1DzOBIIyfB6gVdzPyDpF6wzl2RDtQd7/WKmWXpP9FDENna9li
 k/AHTJ4eJXwX9bgl113IlulDcNpLL1xXw0zKjfziuJX+Oj7aId7YEQ5s2EUMd+WWWUzguZmgkvE
 Nu/o78spRyliyn2wJjel0byesPyG10F6dIKR4EzfSVlegOHQSc1S6crLfObfYQW48m6+EZEF+0D
 8C9+A/VYFOq+enQSX6y3efWkSp7ttjMcbENHTUIlNRyfc1Yk
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

Moreover export tcp_release_cb by means of EXPORT_SYMBOL instead of
EXPORT_IPV6_MOD, so that other modules can use it, even if IPV6 is
not compiled in.

Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/Kconfig         |   1 +
 drivers/net/ovpn/Makefile   |   1 +
 drivers/net/ovpn/io.c       |   4 +
 drivers/net/ovpn/main.c     |   3 +
 drivers/net/ovpn/ovpnpriv.h |   1 +
 drivers/net/ovpn/peer.h     |  35 +++
 drivers/net/ovpn/socket.c   |  44 +++-
 drivers/net/ovpn/socket.h   |   8 +-
 drivers/net/ovpn/tcp.c      | 588 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/tcp.h      |  36 +++
 net/ipv6/af_inet6.c         |   1 +
 11 files changed, 711 insertions(+), 11 deletions(-)

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
index 04c3345807c5d759daf65cc80a290f784dbf5588..229be66167e1fe8e5e4c8f475343b544d7ee694e 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -18,4 +18,5 @@ ovpn-y += peer.o
 ovpn-y += pktid.o
 ovpn-y += socket.o
 ovpn-y += stats.o
+ovpn-y += tcp.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 50dc2e4c03f01b02bdf616473b755b6e1e6b57f7..729f49ff6ce8001c2bbe804db0a617a2cc8965a8 100644
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
index 82f675f7a49ab9c35ff9686136b949a870b61c06..89b03f45dbc79c5de1f3c62ac9ef229acdc98d3e 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -22,6 +22,7 @@
 #include "io.h"
 #include "peer.h"
 #include "proto.h"
+#include "tcp.h"
 #include "udp.h"
 
 static int ovpn_net_init(struct net_device *dev)
@@ -238,6 +239,8 @@ static int __init ovpn_init(void)
 		goto unreg_rtnl;
 	}
 
+	ovpn_tcp_init();
+
 	return 0;
 
 unreg_rtnl:
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 9d0640e9c71e7fd494e3d9df155732bd5d82463e..2e3f4baf305f0b37b474d7b7d94751aa4af8a2ea 100644
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
index 2453d39ce327c6d174cfb35fe5430865b32c2efe..5ef00ba6523d7bf6608adb86fa7c7029f559ce2a 100644
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
@@ -45,6 +58,28 @@ struct ovpn_peer {
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
+
+		struct work_struct defer_del_work;
+	} tcp;
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 6de1e8c85a3d35a5d4f179d595d2409aa34cdc01..be20c500f373fb894d0df5e02ce1996cf386d195 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -16,6 +16,7 @@
 #include "io.h"
 #include "peer.h"
 #include "socket.h"
+#include "tcp.h"
 #include "udp.h"
 
 static void ovpn_socket_release_kref(struct kref *kref)
@@ -23,12 +24,10 @@ static void ovpn_socket_release_kref(struct kref *kref)
 	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
 						refcount);
 
-	if (sock->sock->sk->sk_protocol == IPPROTO_UDP) {
+	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
 		ovpn_udp_socket_detach(sock);
-		netdev_put(sock->ovpn->dev, &sock->dev_tracker);
-	}
-
-	kfree_rcu(sock, rcu);
+	else if (sock->sock->sk->sk_protocol == IPPROTO_TCP)
+		ovpn_tcp_socket_detach(sock);
 }
 
 /**
@@ -38,10 +37,12 @@ static void ovpn_socket_release_kref(struct kref *kref)
  *
  * This function is only used internally. Users willing to release
  * references to the ovpn_socket should use ovpn_socket_release()
+ *
+ * Return: true if the socket was released, false otherwise
  */
-static void ovpn_socket_put(struct ovpn_peer *peer, struct ovpn_socket *sock)
+static bool ovpn_socket_put(struct ovpn_peer *peer, struct ovpn_socket *sock)
 {
-	kref_put(&sock->refcount, ovpn_socket_release_kref);
+	return kref_put(&sock->refcount, ovpn_socket_release_kref);
 }
 
 /**
@@ -65,6 +66,7 @@ static void ovpn_socket_put(struct ovpn_peer *peer, struct ovpn_socket *sock)
 void ovpn_socket_release(struct ovpn_peer *peer)
 {
 	struct ovpn_socket *sock;
+	bool released;
 
 	might_sleep();
 
@@ -94,11 +96,26 @@ void ovpn_socket_release(struct ovpn_peer *peer)
 	 * detached before it can be picked by a concurrent reader.
 	 */
 	lock_sock(sock->sock->sk);
-	ovpn_socket_put(peer, sock);
+	released = ovpn_socket_put(peer, sock);
 	release_sock(sock->sock->sk);
 
 	/* align all readers with sk_user_data being NULL */
 	synchronize_rcu();
+
+	/* following cleanup should happen with lock released */
+	if (released) {
+		if (sock->sock->sk->sk_protocol == IPPROTO_UDP) {
+			netdev_put(sock->ovpn->dev, &sock->dev_tracker);
+		} else if (sock->sock->sk->sk_protocol == IPPROTO_TCP) {
+			/* wait for TCP jobs to terminate */
+			ovpn_tcp_socket_wait_finish(sock);
+			ovpn_peer_put(sock->peer);
+		}
+		/* we can call plain kfree() because we already waited one RCU
+		 * period due to synchronize_rcu()
+		 */
+		kfree(sock);
+	}
 }
 
 static bool ovpn_socket_hold(struct ovpn_socket *sock)
@@ -110,6 +127,8 @@ static int ovpn_socket_attach(struct ovpn_socket *sock, struct ovpn_peer *peer)
 {
 	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
 		return ovpn_udp_socket_attach(sock, peer->ovpn);
+	else if (sock->sock->sk->sk_protocol == IPPROTO_TCP)
+		return ovpn_tcp_socket_attach(sock, peer);
 
 	return -EOPNOTSUPP;
 }
@@ -202,7 +221,14 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 		goto sock_release;
 	}
 
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
index c1697f4616d470f143cba77bb1db34de0398a37a..00d856b1a5d884ffeca7cde7f693cad599746c10 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -21,9 +21,11 @@ struct ovpn_peer;
  * struct ovpn_socket - a kernel socket referenced in the ovpn code
  * @ovpn: ovpn instance owning this socket (UDP only)
  * @dev_tracker: reference tracker for associated dev (UDP only)
+ * @peer: unique peer transmitting over this socket (TCP only)
  * @sock: the low level sock object
  * @refcount: amount of contexts currently referencing this object
- * @rcu: member used to schedule RCU destructor callback
+ * @work: member used to schedule release routine (it may block)
+ * @tcp_tx_work: work for deferring outgoing packet processing (TCP only)
  */
 struct ovpn_socket {
 	union {
@@ -31,11 +33,13 @@ struct ovpn_socket {
 			struct ovpn_priv *ovpn;
 			netdevice_tracker dev_tracker;
 		};
+		struct ovpn_peer *peer;
 	};
 
 	struct socket *sock;
 	struct kref refcount;
-	struct rcu_head rcu;
+	struct work_struct work;
+	struct work_struct tcp_tx_work;
 };
 
 struct ovpn_socket *ovpn_socket_new(struct socket *sock,
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
new file mode 100644
index 0000000000000000000000000000000000000000..a5bfd06bc9499b6886b42e039095bb8ce93994fb
--- /dev/null
+++ b/drivers/net/ovpn/tcp.c
@@ -0,0 +1,588 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2025 OpenVPN, Inc.
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
+#define OVPN_TCP_DEPTH_NESTING	2
+#if OVPN_TCP_DEPTH_NESTING == SINGLE_DEPTH_NESTING
+#error "OVPN TCP requires its own lockdep subclass"
+#endif
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
+	 * Parse accordingly and return the actual size (including the size
+	 * header)
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
+	skb_queue_purge(&peer->tcp.user_queue);
+
+	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
+	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
+	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
+	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
+	sock->sk->sk_socket->ops = peer->tcp.sk_cb.ops;
+
+	rcu_assign_sk_user_data(sock->sk, NULL);
+}
+
+void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock)
+{
+	struct ovpn_peer *peer = sock->peer;
+
+	/* NOTE: we don't wait for peer->tcp.defer_del_work to finish:
+	 * either the worker is not running or this function
+	 * was invoked by that worker.
+	 */
+
+	cancel_work_sync(&sock->tcp_tx_work);
+	strp_done(&peer->tcp.strp);
+
+	skb_queue_purge(&peer->tcp.out_queue);
+	kfree_skb(peer->tcp.out_msg.skb);
+	peer->tcp.out_msg.skb = NULL;
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
+			ovpn_peer_hold(peer);
+			schedule_work(&peer->tcp.defer_del_work);
+
+			/* we bail out immediately and keep tx_in_progress set
+			 * to true. This way we prevent more TX attempts
+			 * which would lead to more invocations of
+			 * schedule_work()
+			 */
+			return;
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
+static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
+				   struct sk_buff *skb)
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
+void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct socket *sock,
+		       struct sk_buff *skb)
+{
+	u16 len = skb->len;
+
+	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
+
+	spin_lock_nested(&sock->sk->sk_lock.slock, OVPN_TCP_DEPTH_NESTING);
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
+	spin_unlock(&sock->sk->sk_lock.slock);
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
+		return;
+	}
+
+	peer = sock->peer;
+
+	/* during initialization this function is called before
+	 * assigning sock->peer
+	 */
+	if (unlikely(!peer || !ovpn_peer_hold(peer))) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
+	__skb_queue_head_init(&queue);
+	skb_queue_splice_init(&peer->tcp.out_queue, &queue);
+
+	while ((skb = __skb_dequeue(&queue)))
+		ovpn_tcp_send_sock_skb(peer, sk, skb);
+
+	peer->tcp.sk_cb.prot->release_cb(sk);
+	ovpn_peer_put(peer);
+}
+
+static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
+{
+	struct ovpn_socket *sock;
+	int ret, linear = PAGE_SIZE;
+	struct ovpn_peer *peer;
+	struct sk_buff *skb;
+
+	lock_sock(sk);
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	if (unlikely(!sock || !sock->peer || !ovpn_peer_hold(sock->peer))) {
+		rcu_read_unlock();
+		release_sock(sk);
+		return -EIO;
+	}
+	rcu_read_unlock();
+	peer = sock->peer;
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
+static void ovpn_tcp_peer_del_work(struct work_struct *work)
+{
+	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
+					      tcp.defer_del_work);
+
+	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+	ovpn_peer_put(peer);
+}
+
+/* Set TCP encapsulation callbacks */
+int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
+			   struct ovpn_peer *peer)
+{
+	struct socket *sock = ovpn_sock->sock;
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
+	INIT_WORK(&peer->tcp.defer_del_work, ovpn_tcp_peer_del_work);
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
+	struct ovpn_peer *peer;
+
+	rcu_read_lock();
+	sock = rcu_dereference_sk_user_data(sk);
+	if (!sock || !sock->peer || !ovpn_peer_hold(sock->peer)) {
+		rcu_read_unlock();
+		return;
+	}
+	peer = sock->peer;
+	rcu_read_unlock();
+
+	ovpn_peer_del(sock->peer, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
+	peer->tcp.sk_cb.prot->close(sk, timeout);
+	ovpn_peer_put(peer);
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
index 0000000000000000000000000000000000000000..10aefa834cf358f39f4fc250063d6ef13e0353b0
--- /dev/null
+++ b/drivers/net/ovpn/tcp.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2025 OpenVPN, Inc.
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
+int ovpn_tcp_socket_attach(struct ovpn_socket *ovpn_sock,
+			   struct ovpn_peer *peer);
+void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock);
+void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock);
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
2.48.1


