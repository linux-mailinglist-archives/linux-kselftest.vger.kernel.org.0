Return-Path: <linux-kselftest+bounces-26286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5289BA2FF54
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D891164E7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB551D86ED;
	Tue, 11 Feb 2025 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NI0q/iMQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250C1D61A5
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234467; cv=none; b=DczKlbFV936fhBwpBie/F9rXTri+trMsVYv3TZqM+7jEpytgqkbfxxggqHKiT8hQljzrKz/7v+zM8wjlzfb2AX0tvIo7DIVdNFXhDapKcd2YwaZnWU7UPYU5p19stHTW4/LDCj3xB8Gt2N2vYAWjvnfreWDnsfJHf821Z+AD/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234467; c=relaxed/simple;
	bh=ruPoClfQN3L1nEP1jsrOuRwzk+6C/gbB+GLFas50jE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGsDrau2iXbPbS66/Px9QY9GvCDkLnJAXOLaJ8c8NTF6AhjCtFg5dgqFgzwQpVu2yDtMcB36rSSQEky+g8gEQmwZTvjVTa44c/nviWQ7cC1Hly/VaD5m6m50yXEQ3TAEkCkBROFtQ3LKmIaeZuu8FKgOyfOQGSicO8Fq0vo/Lqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NI0q/iMQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-438a39e659cso34197215e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234463; x=1739839263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9whC6lqwTtsCvFCTaEpmgA0AmOCEybPYWciU2ywGI8=;
        b=NI0q/iMQOIuVAXhewOMTb6BezMKEYk9YbXrTW0nDkCYGK5EFwo7kbMelhtem42mlZQ
         2XRrEE6H6cGhV2sZxLdDx7hSlkuqGMwXnQLwx0fb/S19gv2zUbhS1+9Dm5Tii8bHgg66
         OTHYgyIjJ4XrRE+LVjm2r2WOCsENYVPVisOsfplOnG6SW/ED3/wlSDD7wtLGmfU3EtX+
         ww6XPvapUkSFEdaWvmcQ9L6FMl+cZnUvhi/JXhwQhZ2Z+FzHDOufLTKOt0Ec70f98z0o
         cXD0lP+NqkR2rxLRWDQphKcnMEkd6RHuTsst0c+vhhFZRFV4D698T6DHp1S5axl/akzb
         7gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234463; x=1739839263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9whC6lqwTtsCvFCTaEpmgA0AmOCEybPYWciU2ywGI8=;
        b=KDGMQoZLOaALZej0E7kELJ+HEm9M82jKOBRi7OwN62Rd3NNwrvjgFPUco1kKQpPjkd
         ubO+ahFeqa6pW9XmIaPiIuxBOh3pPYcT/OSk7Wfr9MUB2sh4Dq1TsRt+6a2lOEs7TYLl
         3qRUDqQNPQKsqxkKkv2ByCZD4oxv3OeDlGjGxPckLm0cA4z/Ew4+ep/htT9SSfPrH/WS
         DgyKBpAsh+pmAJgNJj1b1pv1Dw9vmVEPjjoUnRdGvpzv9FAESjVkmZXObwkk8+Toycc7
         unbmbASiYmE76InKP73z6iaHxKoL8Wb0quP6zDUxSDNL4jfo8FJ7XA4IIL7xeBdm1oy2
         DYKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjtzgd0/kKXd7JAKIOXPKlqvazbRLGicQ9tqn2WWVBl1YJbwmGp5lp3i4T4ouO1pAI8yqI9vUcgyPjn3/gsOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjM5WxpMw6n8Y/7MecCwxlE8Qtde5y9ct+rpbLblCzwDKkJNDx
	0SmfHmj3fudKcVr8G2mTGMVBCQHxv7YTTI5mO33f57FV84KDp1cyOlyfgpCqs1c=
X-Gm-Gg: ASbGnctrSXgrCdTol0LdzqenJV6VOrlTuRGpTJJJffZOjc9hZ5ck2CiyuP40EvQh7Q3
	yzCVzeNDUvhpJ2Gl35zbEZWTT2PhUFfYF0lgdwjIBXpXsR4sOxahHjko+LYAp21nK+61mOmBdtG
	c+sK46/c1y5DKebPvJfsdPFQEc9ODoLGS1L2Oem+QQhTjxFJC5WMZ2EpiWufiXZgbPCr6rDhk6y
	Gq2SFQL0d5itY/bWrcz6iWxzbLPXQ2OBzRXfhTqWINSV5eoEauCnChpQZYnD9sPyPyJf0HAMfzu
	OsG4KWW58MQsPIuoR6YYkuV6xpg=
X-Google-Smtp-Source: AGHT+IHaTSq99n4Rn04YvQfT8tnWm+rELQekm00K6p2bkGhoGXlXG6kkbKg19MKYsxD7Q1zgBTBwHQ==
X-Received: by 2002:a05:600c:1c03:b0:439:4dfa:4e1 with SMTP id 5b1f17b1804b1-4394dfa07b0mr2338085e9.15.1739234463007;
        Mon, 10 Feb 2025 16:41:03 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:02 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:39:59 +0100
Subject: [PATCH net-next v19 06/26] ovpn: introduce the ovpn_socket object
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-6-86d5daf2a47a@openvpn.net>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 willemdebruijn.kernel@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13511; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=ruPoClfQN3L1nEP1jsrOuRwzk+6C/gbB+GLFas50jE0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyMkX1XWG2sGnJhqQg8KiDhW4O8Hf0sfEHmB
 JvUU8NtQ/WJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjAAKCRALcOU6oDjV
 h3HcCACSSHI8DvzcjWC7I/uZ7XdhRdiCakOh3MvrP2MLUpuH66itUDmYD6DADzZKecSld9kzBMf
 UJAPnEm7mw6jgRBfUqs8Qxzfu7SLUkCptrU0TnqaTLBNbssnSg+Ye5JENSqQ+5EHssPq/X2UIEh
 y/X7BTbJHzv1JP98fGZU0ljLnoFNJwQd3zopv1rNMA6FW+CT/A5+tFUR0Qjh7uEOMND4O3dTRKv
 4Y7dEXXeAm8zFa579xrDZv99JEibNNC57qwftFfIqHsd7PgQMSJMLcreanFi5PJDFKoFyNhV72u
 W6tFBaWmATpD5GyqE0im5rwf21OUCXyhn/Bq2npLIiSQTP7y
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This specific structure is used in the ovpn kernel module
to wrap and carry around a standard kernel socket.

ovpn takes ownership of passed sockets and therefore an ovpn
specific objects is attached to them for status tracking
purposes.

Initially only UDP support is introduced. TCP will come in a later
patch.

Cc: willemdebruijn.kernel@gmail.com
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile |   2 +
 drivers/net/ovpn/peer.c   |   5 ++
 drivers/net/ovpn/peer.h   |   4 +
 drivers/net/ovpn/socket.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.h |  38 ++++++++++
 drivers/net/ovpn/udp.c    |  73 ++++++++++++++++++
 drivers/net/ovpn/udp.h    |  18 +++++
 include/uapi/linux/udp.h  |   1 +
 8 files changed, 331 insertions(+)

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index ce13499b3e1775a7f2a9ce16c6cb0aa088f93685..56bddc9bef83e0befde6af3c3565bb91731d7b22 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -13,3 +13,5 @@ ovpn-y += io.o
 ovpn-y += netlink.o
 ovpn-y += netlink-gen.o
 ovpn-y += peer.o
+ovpn-y += socket.o
+ovpn-y += udp.o
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 9b3832819d7f60224ca78683c78ab1aaca43db49..f7324727ea40a5724c5b66eb873882a168de9c0a 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -258,6 +258,11 @@ static void ovpn_peer_remove_work(struct work_struct *work)
 	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
 					      remove_work);
 
+	/* the peer has been unhashed and is being deactivated - we can
+	 * now switch off the socket and drop its reference
+	 */
+	ovpn_socket_release(peer);
+
 	/* reference from ovpn->peer or hashtable dropped */
 	ovpn_peer_put(peer);
 }
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 048f7c6fe5822e0d8a1e44102eb7f4bbd5f718ca..0f33bbe148cba13f9dc186e4470a15657c83c0d2 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -12,6 +12,8 @@
 
 #include <net/dst_cache.h>
 
+#include "socket.h"
+
 /**
  * struct ovpn_peer - the main remote peer object
  * @ovpn: main openvpn instance this peer belongs to
@@ -20,6 +22,7 @@
  * @vpn_addrs: IP addresses assigned over the tunnel
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
+ * @sock: the socket being used to talk to this peer
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
@@ -36,6 +39,7 @@ struct ovpn_peer {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
 	} vpn_addrs;
+	struct ovpn_socket __rcu *sock;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
 	enum ovpn_del_peer_reason delete_reason;
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
new file mode 100644
index 0000000000000000000000000000000000000000..644649676f3a339b9d81f86f518a2d082f43cee0
--- /dev/null
+++ b/drivers/net/ovpn/socket.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/net.h>
+#include <linux/netdevice.h>
+#include <linux/udp.h>
+
+#include "ovpnpriv.h"
+#include "main.h"
+#include "io.h"
+#include "peer.h"
+#include "socket.h"
+#include "udp.h"
+
+static void ovpn_socket_release_kref(struct kref *kref)
+{
+	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
+						refcount);
+
+	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
+		ovpn_udp_socket_detach(sock);
+
+	sockfd_put(sock->sock);
+	kfree_rcu(sock, rcu);
+}
+
+/**
+ * ovpn_socket_put - decrease reference counter
+ * @peer: peer whose socket reference counter should be decreased
+ * @sock: the RCU protected peer socket
+ *
+ * This function is only used internally. Users willing to release
+ * references to the ovpn_socket should use ovpn_socket_release()
+ */
+static void ovpn_socket_put(struct ovpn_peer *peer, struct ovpn_socket *sock)
+{
+	RCU_INIT_POINTER(peer->sock, NULL);
+	kref_put(&sock->refcount, ovpn_socket_release_kref);
+}
+
+/**
+ * ovpn_socket_release - release resources owned by socket user
+ * @peer: peer whose socket should be released
+ *
+ * This function should be invoked when the user is shutting
+ * down and wants to drop its link to the socket.
+ *
+ * In case of UDP, the detach routine will drop a reference to the
+ * ovpn netdev, pointed by the ovpn_socket.
+ *
+ * In case of TCP, releasing the socket will cause dropping
+ * the refcounter for the peer it is linked to, thus allowing the peer
+ * disappear as well.
+ *
+ * NOTE: this function may sleep
+ */
+void ovpn_socket_release(struct ovpn_peer *peer)
+{
+	/* only one ovpn_peer_remove() can ever happen for each peer */
+	struct ovpn_socket *sock = rcu_dereference_protected(peer->sock, true);
+
+	/* Drop the reference while holding the sock lock to avoid
+	 * concurrent ovpn_socket_new call to mess up with a partially
+	 * detached socket.
+	 *
+	 * Holding the lock ensures that a socket with refcnt 0 is fully
+	 * detached before it can be picked by a concurrent reader.
+	 */
+	lock_sock(sock->sock->sk);
+	ovpn_socket_put(peer, sock);
+	release_sock(sock->sock->sk);
+}
+
+static bool ovpn_socket_hold(struct ovpn_socket *sock)
+{
+	return kref_get_unless_zero(&sock->refcount);
+}
+
+static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
+{
+	if (!sock || !peer)
+		return -EINVAL;
+
+	if (sock->sk->sk_protocol == IPPROTO_UDP)
+		return ovpn_udp_socket_attach(sock, peer->ovpn);
+
+	return -EOPNOTSUPP;
+}
+
+/**
+ * ovpn_socket_new - create a new socket and initialize it
+ * @sock: the kernel socket to embed
+ * @peer: the peer reachable via this socket
+ *
+ * Return: an openvpn socket on success or a negative error code otherwise
+ */
+struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
+{
+	struct ovpn_socket *ovpn_sock;
+	int ret;
+
+	lock_sock(sock->sk);
+
+	/* a TCP socket can only be owned by a single peer, therefore there
+	 * can't be any other user
+	 */
+	if (sock->sk->sk_protocol == IPPROTO_TCP && sock->sk->sk_user_data) {
+		ovpn_sock = ERR_PTR(-EBUSY);
+		goto sock_release;
+	}
+
+	/* a UDP socket can be shared across multiple peers, but we must make
+	 * sure it is not owned by something else
+	 */
+	if (sock->sk->sk_protocol == IPPROTO_UDP) {
+		u8 type = READ_ONCE(udp_sk(sock->sk)->encap_type);
+
+		/* socket owned by other encapsulation module */
+		if (type && type != UDP_ENCAP_OVPNINUDP) {
+			ovpn_sock = ERR_PTR(-EBUSY);
+			goto sock_release;
+		}
+
+		rcu_read_lock();
+		ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
+		if (ovpn_sock) {
+			/* socket owned by another ovpn instance, we can't use it */
+			if (ovpn_sock->ovpn != peer->ovpn) {
+				ovpn_sock = ERR_PTR(-EBUSY);
+				rcu_read_unlock();
+				goto sock_release;
+			}
+
+			/* this socket is already owned by this instance,
+			 * therefore we can increase the refcounter and
+			 * use it as expected
+			 */
+			if (WARN_ON(!ovpn_socket_hold(ovpn_sock))) {
+				/* this should never happen because setting
+				 * the refcnt to 0 and detaching the socket
+				 * is expected to be atomic
+				 */
+				ovpn_sock = ERR_PTR(-EAGAIN);
+				rcu_read_unlock();
+				goto sock_release;
+			}
+
+			/* caller is expected to increase the sock
+			 * refcounter before passing it to this
+			 * function. For this reason we drop it if
+			 * not needed, like when this socket is already
+			 * owned.
+			 */
+			sockfd_put(sock);
+			rcu_read_unlock();
+			goto sock_release;
+		}
+		rcu_read_unlock();
+	}
+
+	/* socket is not owned: attach to this ovpn instance */
+
+	ovpn_sock = kzalloc(sizeof(*ovpn_sock), GFP_KERNEL);
+	if (!ovpn_sock) {
+		ovpn_sock = ERR_PTR(-ENOMEM);
+		goto sock_release;
+	}
+
+	ret = ovpn_socket_attach(sock, peer);
+	if (ret < 0) {
+		kfree(ovpn_sock);
+		ovpn_sock = ERR_PTR(ret);
+		goto sock_release;
+	}
+
+	ovpn_sock->ovpn = peer->ovpn;
+	ovpn_sock->sock = sock;
+	kref_init(&ovpn_sock->refcount);
+
+	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
+sock_release:
+	release_sock(sock->sk);
+	return ovpn_sock;
+}
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
new file mode 100644
index 0000000000000000000000000000000000000000..9cd991123bcb8be28635cd7fc4994358898ffc9b
--- /dev/null
+++ b/drivers/net/ovpn/socket.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_SOCK_H_
+#define _NET_OVPN_SOCK_H_
+
+#include <linux/net.h>
+#include <linux/kref.h>
+#include <net/sock.h>
+
+struct ovpn_priv;
+struct ovpn_peer;
+
+/**
+ * struct ovpn_socket - a kernel socket referenced in the ovpn code
+ * @ovpn: ovpn instance owning this socket (UDP only)
+ * @sock: the low level sock object
+ * @refcount: amount of contexts currently referencing this object
+ * @rcu: member used to schedule RCU destructor callback
+ */
+struct ovpn_socket {
+	struct ovpn_priv *ovpn;
+	struct socket *sock;
+	struct kref refcount;
+	struct rcu_head rcu;
+};
+
+struct ovpn_socket *ovpn_socket_new(struct socket *sock,
+				    struct ovpn_peer *peer);
+void ovpn_socket_release(struct ovpn_peer *peer);
+
+#endif /* _NET_OVPN_SOCK_H_ */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
new file mode 100644
index 0000000000000000000000000000000000000000..e92e42f6c0ee12226a553cafc1529da9187a4903
--- /dev/null
+++ b/drivers/net/ovpn/udp.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/netdevice.h>
+#include <linux/socket.h>
+#include <linux/udp.h>
+#include <net/udp.h>
+
+#include "ovpnpriv.h"
+#include "main.h"
+#include "socket.h"
+#include "udp.h"
+
+/**
+ * ovpn_udp_socket_attach - set udp-tunnel CBs on socket and link it to ovpn
+ * @sock: socket to configure
+ * @ovpn: the openvp instance to link
+ *
+ * After invoking this function, the sock will be controlled by ovpn so that
+ * any incoming packet may be processed by ovpn first.
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
+{
+	struct ovpn_socket *old_data;
+	int ret = 0;
+
+	/* make sure no pre-existing encapsulation handler exists */
+	rcu_read_lock();
+	old_data = rcu_dereference_sk_user_data(sock->sk);
+	if (!old_data) {
+		/* socket is currently unused - we can take it */
+		rcu_read_unlock();
+		return 0;
+	}
+
+	/* socket is in use. We need to understand if it's owned by this ovpn
+	 * instance or by something else.
+	 * In the former case, we can increase the refcounter and happily
+	 * use it, because the same UDP socket is expected to be shared among
+	 * different peers.
+	 *
+	 * Unlikely TCP, a single UDP socket can be used to talk to many remote
+	 * hosts and therefore openvpn instantiates one only for all its peers
+	 */
+	if ((READ_ONCE(udp_sk(sock->sk)->encap_type) == UDP_ENCAP_OVPNINUDP) &&
+	    old_data->ovpn == ovpn) {
+		netdev_dbg(ovpn->dev,
+			   "provided socket already owned by this interface\n");
+		ret = -EALREADY;
+	} else {
+		netdev_dbg(ovpn->dev,
+			   "provided socket already taken by other user\n");
+		ret = -EBUSY;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+/**
+ * ovpn_udp_socket_detach - clean udp-tunnel status for this socket
+ * @ovpn_sock: the socket to clean
+ */
+void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
+{
+}
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
new file mode 100644
index 0000000000000000000000000000000000000000..1864f123f99d29b5e814679404276f8f8c3876c2
--- /dev/null
+++ b/drivers/net/ovpn/udp.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_UDP_H_
+#define _NET_OVPN_UDP_H_
+
+struct ovpn_priv;
+struct socket;
+
+int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn);
+void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock);
+
+#endif /* _NET_OVPN_UDP_H_ */
diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index d85d671deed3c78f6969189281b9083dcac000c6..edca3e430305a6bffc34e617421f1f3071582e69 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -43,5 +43,6 @@ struct udphdr {
 #define UDP_ENCAP_GTP1U		5 /* 3GPP TS 29.060 */
 #define UDP_ENCAP_RXRPC		6
 #define TCP_ENCAP_ESPINTCP	7 /* Yikes, this is really xfrm encap types. */
+#define UDP_ENCAP_OVPNINUDP	8 /* OpenVPN traffic */
 
 #endif /* _UAPI_LINUX_UDP_H */

-- 
2.45.3


