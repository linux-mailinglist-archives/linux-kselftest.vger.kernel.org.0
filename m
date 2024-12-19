Return-Path: <linux-kselftest+bounces-23553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9C9F7211
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1542C189553D
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9077C1A2C25;
	Thu, 19 Dec 2024 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="U9pfzgJT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D611A08C1
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572546; cv=none; b=UM9wHxk+hHiKSLl5s6ub+Wt9Z789LgYz+zKVYMVmJhYOC9vmT/Nrr669LklkA7DZNcTw0DmhpMAZYUWUY0C6/MWpFSc9Jzn1AKr8pr5XFrnn0a+lsGA1WdSLip3ng/BltD8fJ299fVZAIx+hgzXqIUjA7OVbrOVHscqZBVx4Fzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572546; c=relaxed/simple;
	bh=kVyok1hMQosRRkvUz70O35G8zTnppxVL1RuS6YgJHvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQEEBIN5ErECPHR3Xszz6kW/XP9RTV45Mf4nWXd8KFeoUj9VpmLZBlouxNu8WC9VnHKDVei8D72Nyq9eEQmI+RKLiYL7pkC4Tlu0fQz3mZALJqXKa2MZ7jN9BC2OkBMecwtaMtL6FL2xbjRdvj4PRWuw0S1gH19hQV/8JvZO084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=U9pfzgJT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so2578635e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572542; x=1735177342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LvI/FoXO11dIl71baOcLbah5EATFl572sT9rKDIsgw=;
        b=U9pfzgJTOdSFg1qj4dG3x7FY3aizFfJLL0iK+UEvHBy1gUnSyGuxpG3cjBNBRKXrJ1
         XRmOXjuJXE9AX76eXvT9Kp9ZPhTamQ+RWMHDAcbv5FYot7HlD5+7C2XSKk+edntBJT1T
         5eR7p6BiX0ic42a6SqrsR9rry9G2BUFoagiRFmZfl47pnk+2k4iKNTydb8LeYTPSUmxl
         ueycDKFIqXvClYKnqGyZYFpjn+47KPmMFHu5rfNNx5qDjV+sXgAOMErsOkZ+X61MDpsS
         +1eX8tW9QyPnDwTt6ZN6GnhDWxKrpF1YvM9cqIfxnxf8oZ5nGUyCE+VnCGDWIfJer9Ag
         kT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572542; x=1735177342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LvI/FoXO11dIl71baOcLbah5EATFl572sT9rKDIsgw=;
        b=szexcGtQE74j9kLwP4vqhXGRDeFgNICn3KcWIG64jIZ8jD4NE6kxTGz1I9nheZCwf8
         q47HkfikI/xFqbAMXhicw519DlVH6GvdaJfwoO5koshLoJep8s7tAgZ5V94HTL/2sOV+
         dNOVK2DwPLtpu4eb5QAnHioDcAk1LnVOsf5ASKOe6/0mAVsCqqjIX/B0ptDwlNhQzW5A
         /uXM6I7H+gnD+bQKwMFcogzKgyndutdWGUDvnxpVvXvF/Q9X0E3071K1mMMPz5GAMxma
         or9N0P0yIoJdejaIiYPs3tKl+0UIRYVZrEL3Ueie6zViJJ1ux6DhC7JB+TaoUhzyZXKt
         TpWA==
X-Forwarded-Encrypted: i=1; AJvYcCVTEQugLCJpvoexmNd6/XJWR2yWQNSHulmrigIQbCEZ3AsqsiBPpmhG0U8t4P+JmUbrps2BTLxJdow9Pi6Mdds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz11OOGd5I8iCOsao74+w1aZAiJrVcQoMMg8budNjF8XWjgXJNK
	gaB27xgsAjILhdxSSfG/l7TvnCGDFavglYG0Phdd/L+V5d76vj6yWgL6s2Mh2gM=
X-Gm-Gg: ASbGncuySx4YxXb+oK4ZwyqrVyU6TBGF/IRQ7dM5fnjSojECEXiGwfspJGLVorQNJbn
	CKk2ySFjogpFsSF3fTUj+kBiFRRqOqrnIgOsRCSji+yN4FLu7v/K4f0VkxSxCjSNEbb7mZTdRpt
	zqVtfa8fP9O/LyEczOXvo0RLvmX/dsXb7ec9gla27dnFlaHdCC/RSCABh7Z5jAp16WG9CEkwCM6
	RZtpC54u2WLecpAkD0HrLK7boNKSvVgPP321gzIUkp8ejvzjM6c2tPTMbQv2chpiFq7
X-Google-Smtp-Source: AGHT+IGisikY5ScuTkQw8bZiBRKKrgzpLeE4lpChgkb1fZUGhPTyw2r7i9n3esJ4VgYoL0apF4DKzg==
X-Received: by 2002:a05:600c:3b88:b0:434:f739:7ce2 with SMTP id 5b1f17b1804b1-4365535d7afmr43096435e9.8.1734572541465;
        Wed, 18 Dec 2024 17:42:21 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:20 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:07 +0100
Subject: [PATCH net-next v16 13/26] ovpn: implement TCP transport
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-13-3e3001153683@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=27368; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=kVyok1hMQosRRkvUz70O35G8zTnppxVL1RuS6YgJHvE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oWDmZIWaoEKQYvBkPMcyk16Lg9Hs7d1VD7b
 NrJGJMf+RCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FgAKCRALcOU6oDjV
 h+nTCACymBJitaaiuqyvCVKIb/815wvYh8Ihj7lf7fcU6Fo0TxSSiPYVuroVdbSIc9TUIrCd1VO
 ibmhTdOLv7pezP14+e4N8gYQqbH96+mONaiarVPtkQkuzkmUXuxfnBLn9DIoAQ9k3eQfvoGybYu
 8YM0tp6cwYdK9v0gO1Xu/qEsJnUYiN2/6+UOlVtOPWNY7h+SrSDQHsDDGsMjbQWp6+FF3ben+pX
 wa1sLb2i0HingnA3Ix0FTdqlXm9ujLxuzwRupm/iijcpz/T98MZXrRpGHT57BnaGsXi3EaYu6tC
 2yEBws5oALoI6r8x/xH5Ov1CCfyclqucyJQuzEXYrjWeOMBb
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
 drivers/net/ovpn/peer.h       |  35 +++
 drivers/net/ovpn/socket.c     |  48 +++-
 drivers/net/ovpn/socket.h     |   9 +-
 drivers/net/ovpn/tcp.c        | 563 ++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/tcp.h        |  33 +++
 drivers/net/ovpn/udp.c        |   4 +
 11 files changed, 698 insertions(+), 4 deletions(-)

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
index 286611bd5c63b704a8cc4eb32c0418c524c04304..24a6f04b9f1cecf43e845bc948f6b9c09d0a9502 100644
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
@@ -211,6 +212,9 @@ void ovpn_encrypt_post(void *data, int ret)
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
index 0dbbcf2faf129651390f47ce6098d5b6e28aa74e..0f291c540f8e05dbfbc15d835d6c71e796114b03 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -22,6 +22,7 @@
 #include "io.h"
 #include "peer.h"
 #include "proto.h"
+#include "tcp.h"
 
 static int ovpn_net_init(struct net_device *dev)
 {
@@ -240,6 +241,8 @@ static int __init ovpn_init(void)
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
index 1165a2b705b5d9a9570f77ae06367d23cfda2d36..370657baf775e1cf6a88e5a117e4d599196f944d 100644
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
@@ -42,6 +56,27 @@ struct ovpn_peer {
 		struct in6_addr ipv6;
 	} vpn_addrs;
 	struct ovpn_socket *sock;
+
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
index ff4b64f743641e04489c88f76293d378e54c8853..7b404e102794f0c456e048a22f877c3d0c410172 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -16,6 +16,7 @@
 #include "io.h"
 #include "peer.h"
 #include "socket.h"
+#include "tcp.h"
 #include "udp.h"
 
 /**
@@ -65,6 +66,20 @@ static void ovpn_socket_put(struct ovpn_socket *sock)
 		      sock->sock->sk);
 }
 
+static void ovpn_socket_release_work(struct work_struct *work)
+{
+	struct ovpn_socket *sock = container_of(work, struct ovpn_socket, work);
+
+	lock_sock(sock->sock->sk);
+	/* TCP sockets are owned by one user only, therefore we can
+	 * detach here in the release routine, without waiting for the
+	 * refcounter to drop to 0.
+	 */
+	ovpn_tcp_socket_detach(sock->sock);
+	release_sock(sock->sock->sk);
+	ovpn_socket_put(sock);
+}
+
 /**
  * ovpn_socket_release - release resources owned by socket user
  * @sock: the socket to process
@@ -77,11 +92,22 @@ static void ovpn_socket_put(struct ovpn_socket *sock)
  * Once the refcounter reaches 0, the socket can be fully detached and
  * released. In turn, the detach routine will drop a reference to the
  * ovpn netdev, pointed by the ovpn_socket.
+ *
+ * In case of TCP, the socket is owned by one user only, therefore it
+ * can be immediately detached. Releasing the socket will cause dropping
+ * the refcounter for the peer it is linked to, thus allowing the peer
+ * disappear as well.
+ * NOTE: TCP socket detach is performed in a scheduled work because this
+ * code may sleep.
  */
 void ovpn_socket_release(struct ovpn_socket *sock)
 {
-	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
+	if (sock->sock->sk->sk_protocol == IPPROTO_UDP) {
 		ovpn_socket_put(sock);
+	} else if (sock->sock->sk->sk_protocol == IPPROTO_TCP) {
+		INIT_WORK(&sock->work, ovpn_socket_release_work);
+		schedule_work(&sock->work);
+	}
 }
 
 static bool ovpn_socket_hold(struct ovpn_socket *sock)
@@ -94,7 +120,7 @@ static struct ovpn_socket *ovpn_socket_get(struct socket *sock)
 	struct ovpn_socket *ovpn_sock;
 
 	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
-	if (WARN_ON(!ovpn_socket_hold(ovpn_sock)))
+	if (!ovpn_sock || WARN_ON(!ovpn_socket_hold(ovpn_sock)))
 		ovpn_sock = NULL;
 
 	return ovpn_sock;
@@ -109,6 +135,8 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
 
 	if (sock->sk->sk_protocol == IPPROTO_UDP)
 		ret = ovpn_udp_socket_attach(sock, peer->ovpn);
+	else if (sock->sk->sk_protocol == IPPROTO_TCP)
+		ret = ovpn_tcp_socket_attach(sock, peer);
 
 	return ret;
 }
@@ -178,10 +206,24 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 		goto err_detach;
 	}
 
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
 	release_sock(sock->sk);
 
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index aab26b575df9c886a078c2884900c362a6bf0eb2..f2f4ab991f298ff9c5c05f00d188ff5239701fa9 100644
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
index 0000000000000000000000000000000000000000..9658513cf021681d20de2f4a581ca032d9d3dfdc
--- /dev/null
+++ b/drivers/net/ovpn/tcp.c
@@ -0,0 +1,563 @@
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
+	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
+	if (WARN_ON(!ovpn_sock))
+		return;
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
+
+	/* drop reference to peer */
+	rcu_assign_sk_user_data(sock->sk, NULL);
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
+		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
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
+			dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
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
+	if (unlikely(!sock || !sock->peer || !ovpn_peer_hold(sock->peer))) {
+		rcu_read_unlock();
+		return -EIO;
+	}
+	peer = sock->peer;
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
+		schedule_work(&sock->peer->tcp.tx_work);
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
index 5932f8b5dfad1004e9e76e5fabfbb71bd9a94d4d..30d15c9423b59305d0947885a4801c78d0406b02 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -382,7 +382,11 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
  */
 void ovpn_udp_socket_detach(struct socket *sock)
 {
+	struct ovpn_priv *ovpn = ovpn_from_udp_sock(sock->sk);
 	struct udp_tunnel_sock_cfg cfg = { };
 
+	if (ovpn)
+		/* drop reference to netdev held in sk_user_data */
+		netdev_put(ovpn->dev, &ovpn->dev_tracker);
 	setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
 }

-- 
2.45.2


