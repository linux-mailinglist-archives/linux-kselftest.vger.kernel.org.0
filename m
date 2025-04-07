Return-Path: <linux-kselftest+bounces-30286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6FDA7EDDD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F5C17D4FA
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45999224234;
	Mon,  7 Apr 2025 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WzWaSiEv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B72222D2
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055237; cv=none; b=Y12+y9nNJb7BoQAlNbpLbG7FQj7+h4VO8rFj20HxL8Z9kkFUWfXopxVq+g6BtpI9RMz2UkkAa69xcJ0nd/hTJd1gDTMUDw2wQzt1U6MyqULM7FQUYklb/E0V+Cc1BBwaFAoPrZV7VtT/rGeS1e7XCPj78osCmvyvgk+ngcBhitM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055237; c=relaxed/simple;
	bh=C7fStpHvAjZ/S2orbL77H9Jh5xa9IvaH2NqzgCAZERk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Te4pnZpgyv1nNs3jdqLJ01ORu/O24cMn3Q9QaylZqT/k5kHywK1QIjJ2MTjC87pDHMf92hrJwkDvlGwusO9SYGFF8f29hVLY8JciFFcWYTn9JqPKLlybTgwCn2v5UAWoIWHVaFUyNy2pC4zhJyE4jPc99FYUT2bvX9StIhZB3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WzWaSiEv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43690d4605dso32397995e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055232; x=1744660032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qR5yASGQ3hm0sHSQVRxmm5lN2EDGu3zFGh+nuUjOwlE=;
        b=WzWaSiEvf1aO++f7hxLnCGSsJ+Ij5FZabZo4WXritqKcrvx4XthqUnJthsvVV7aZJV
         y3AmaT7sHg/BietkCYMBQVmcvv2Ca2TxCLuYfwHjXsxxSku9FSG6EllbEy/ojmn77POY
         38DdJLge9lsb4xEKrXGP45edRsmUjwZ3relG3KkO1abtlcDnyfAz/wtNN4KFUD6Enp+n
         lgeaZV3FIwgXnPyczFzYu8utpuZWdhtriUKDfXuW9IqgSHUcf3S3xjwZyPEiYTtqeVnE
         JC2gW+GrNSp7ZZ/EzptDatrPphrsRmB1rUUn7J05tI0+h+ImKiaElJWvWyf747IJshXG
         k9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055232; x=1744660032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qR5yASGQ3hm0sHSQVRxmm5lN2EDGu3zFGh+nuUjOwlE=;
        b=mO/u0Rumum4T83CpIYswDlTUc096brsurWu5UeEvgt6qNSda/zAPph2NhmHOXCmoU1
         FW5OMh+C3Co30fD92beBB4mFJj0l6g0ehhxlEmZqML6FujgTwuS/BcCWgDJ661cCLGOI
         y2x9kOfb70a4+uE5b1VNUf3KnM5amrvBXO6f5IAJUH+diJqUVS94mi7Uzac8R5zIpOK1
         uEck6I/ycfr3lTKrg57TdJLwUuRVMEueTY77hE67ChFzuqqfR50/U8sKgx+yXkDMSoo9
         3lj0vzh7CiLiEbIiQCYSZb4S/dN8r+9kEy80sef1RZ8P2/qzgUZarVGsCrJqABif598d
         Tknw==
X-Forwarded-Encrypted: i=1; AJvYcCXsQcMUXSav2VdB7k7dhHUbpObEGSVVzUAG/6haAysici+mitgawBakaCBlsiEUf2c2plc2DhPwEUhgHcPIUxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1hyfOrUK81NpqvXtgkwnn3IVgmONYiPs9l0F0qZJZmplPTCV
	C5b26iP4Z3BTvAbF3YYVJEgh8JEtk0MPeYduxAe5LGN9YSl7RglCHLSoWrhDSWqsN9bKVCXRjE+
	hzmDswvAXn0pWYe1+wr5OAP4yv2rQWveBwhs5U2KrT9zY5m9DtO3RG8YjEHc=
X-Gm-Gg: ASbGncvM3Uwjtdo1L6P6+SirLGEUbCm30v5eaof2y7TdFAg0PTI8V0h3soOym/DC9Io
	JUBgJNU1u53iUZjqZvPtLq5rRxnbQmxUAwDuORYq3AIxjuc5UohVTfqoiJCRSQ4Yrj8utUEN3h6
	qDlJKhpUyM/+jONDTRaI/j3rRI+Wn6rkU5TKui2Dy/hPScNP9Lzj+TLVdq9fDVpcwBW5iw26bgD
	Ue44w3AKTWPbVOB+NyzQg1N+TCnoC9AOYnZ5YxrcJs1ohedscd+GMWhPkmDUdm+1scqyedUw845
	Q1hMM2n9XxjTifacLUR/J7Yoh4O+PFD8Xgh0H3Nx/w==
X-Google-Smtp-Source: AGHT+IHBocl7uEBjnCXmBLcA7jmdmYN4t0NU9+so5irl4HPky5jdrZEC9IuDmNxoS1OkOQETLAXqvg==
X-Received: by 2002:a05:600c:3109:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-43ecf85fb61mr124159805e9.14.1744055232356;
        Mon, 07 Apr 2025 12:47:12 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:11 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:14 +0200
Subject: [PATCH net-next v25 06/23] ovpn: introduce the ovpn_socket object
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-6-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16231; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=C7fStpHvAjZ/S2orbL77H9Jh5xa9IvaH2NqzgCAZERk=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn9Cu0zfGMrIgimA6fFgcP+wkDeyrfzcY3cxr5Q
 3WfL3q3Ix+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/QrtAAKCRALcOU6oDjV
 hwTAB/9bN4sHyzZU40lbwrSrFusbYTWz76Z5X3iKun6+ipkuBSA6U4gXLnKgwbZow9BAFbBtB95
 AViIcARKbVqZ3Sfx0l8ul6/m9DEGqVEJ+iEuJmKhE3DQYIDQ3cU5K0ayBi0bBzVKfW+foAruvc7
 m+95bN46BrDKYA/D8tuWJ0zVwDL6FCJvZN+RACqsr0p+jg2ohLjHvw5bnhoYtmA+M7Svb87H8oc
 Gx0ifjQMWLsEgdtwzS9/oarRgE0S/1SONNjn5zY2RJJP60KmOXzYlmAqRM79U8MwqryXSpRkNSw
 Nc/au+y2AmwUZ9vy+tLYMkAPv/GJRhGJYoul2Zzlo+Dg4Ert
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
 drivers/net/ovpn/main.c   |   2 +-
 drivers/net/ovpn/peer.c   |  28 +++++--
 drivers/net/ovpn/peer.h   |   6 +-
 drivers/net/ovpn/socket.c | 203 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.h |  38 +++++++++
 drivers/net/ovpn/udp.c    |  75 +++++++++++++++++
 drivers/net/ovpn/udp.h    |  19 +++++
 include/uapi/linux/udp.h  |   1 +
 9 files changed, 367 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 618328ae338861b9764b42485df71ebd0fc1fe90..164f2058ea8e6dc5b9287afb59758a268b2f8b56 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -13,3 +13,5 @@ ovpn-y += io.o
 ovpn-y += netlink.o
 ovpn-y += netlink-gen.o
 ovpn-y += peer.o
+ovpn-y += socket.o
+ovpn-y += udp.o
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 49e39ca11310e6f583ce44371202f14859a2a1b9..6f3f649bdf2d8da352bdea94a368ea95f153af68 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -176,7 +176,7 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 		ovpn->registered = false;
 
 		if (ovpn->mode == OVPN_MODE_P2P)
-			ovpn_peer_release_p2p(ovpn,
+			ovpn_peer_release_p2p(ovpn, NULL,
 					      OVPN_DEL_PEER_REASON_TEARDOWN);
 		break;
 	case NETDEV_POST_INIT:
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 338069c99248f42b0c4aeb44b2b9d3a35f8bebeb..0bb6c15171848acbc055829a3d2aefd26c5b810a 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -16,17 +16,20 @@
 #include "main.h"
 #include "netlink.h"
 #include "peer.h"
+#include "socket.h"
 
 static void unlock_ovpn(struct ovpn_priv *ovpn,
-			struct llist_head *release_list)
+			 struct llist_head *release_list)
 	__releases(&ovpn->lock)
 {
 	struct ovpn_peer *peer;
 
 	spin_unlock_bh(&ovpn->lock);
 
-	llist_for_each_entry(peer, release_list->first, release_entry)
+	llist_for_each_entry(peer, release_list->first, release_entry) {
+		ovpn_socket_release(peer);
 		ovpn_peer_put(peer);
+	}
 }
 
 /**
@@ -394,18 +397,33 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 /**
  * ovpn_peer_release_p2p - release peer upon P2P device teardown
  * @ovpn: the instance being torn down
+ * @sk: if not NULL, release peer only if it's using this specific socket
  * @reason: the reason for releasing the peer
  */
-void ovpn_peer_release_p2p(struct ovpn_priv *ovpn,
+void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 			   enum ovpn_del_peer_reason reason)
 {
+	struct ovpn_socket *ovpn_sock;
 	LLIST_HEAD(release_list);
 	struct ovpn_peer *peer;
 
 	spin_lock_bh(&ovpn->lock);
 	peer = rcu_dereference_protected(ovpn->peer,
 					 lockdep_is_held(&ovpn->lock));
-	if (peer)
-		ovpn_peer_remove(peer, reason, &release_list);
+	if (!peer) {
+		spin_unlock_bh(&ovpn->lock);
+		return;
+	}
+
+	if (sk) {
+		ovpn_sock = rcu_access_pointer(peer->sock);
+		if (!ovpn_sock || ovpn_sock->sock->sk != sk) {
+			spin_unlock_bh(&ovpn->lock);
+			ovpn_peer_put(peer);
+			return;
+		}
+	}
+
+	ovpn_peer_remove(peer, reason, &release_list);
 	unlock_ovpn(ovpn, &release_list);
 }
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index fd2e7625990a73f61bf5bb4c051929828d9996bd..29c9065cedccb156ec6ca6d9b692372e8fc89a2d 100644
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
@@ -70,7 +74,7 @@ static inline void ovpn_peer_put(struct ovpn_peer *peer)
 struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id);
 int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
-void ovpn_peer_release_p2p(struct ovpn_priv *ovpn,
+void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 			   enum ovpn_del_peer_reason reason);
 
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
new file mode 100644
index 0000000000000000000000000000000000000000..97f6a249b09fe26cc6d078d80abc955f8d35e821
--- /dev/null
+++ b/drivers/net/ovpn/socket.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
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
+ * This function is expected to be invoked exactly once per peer
+ *
+ * NOTE: this function may sleep
+ */
+void ovpn_socket_release(struct ovpn_peer *peer)
+{
+	struct ovpn_socket *sock;
+
+	might_sleep();
+
+	sock = rcu_replace_pointer(peer->sock, NULL, true);
+	/* release may be invoked after socket was detached */
+	if (!sock)
+		return;
+
+	/* sanity check: we should not end up here if the socket
+	 * was already closed
+	 */
+	if (!sock->sock->sk) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return;
+	}
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
+
+	/* align all readers with sk_user_data being NULL */
+	synchronize_rcu();
+}
+
+static bool ovpn_socket_hold(struct ovpn_socket *sock)
+{
+	return kref_get_unless_zero(&sock->refcount);
+}
+
+static int ovpn_socket_attach(struct ovpn_socket *sock, struct ovpn_peer *peer)
+{
+	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
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
+	ovpn_sock->ovpn = peer->ovpn;
+	ovpn_sock->sock = sock;
+	kref_init(&ovpn_sock->refcount);
+
+	ret = ovpn_socket_attach(ovpn_sock, peer);
+	if (ret < 0) {
+		kfree(ovpn_sock);
+		ovpn_sock = ERR_PTR(ret);
+		goto sock_release;
+	}
+
+	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
+sock_release:
+	release_sock(sock->sk);
+	return ovpn_sock;
+}
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
new file mode 100644
index 0000000000000000000000000000000000000000..ade8c94619d7b2f905b5284373dc73f590188399
--- /dev/null
+++ b/drivers/net/ovpn/socket.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
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
index 0000000000000000000000000000000000000000..91970e66a4340370a96c1fc42321f94574302143
--- /dev/null
+++ b/drivers/net/ovpn/udp.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2025 OpenVPN, Inc.
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
+ * @ovpn_sock: socket to configure
+ * @ovpn: the openvp instance to link
+ *
+ * After invoking this function, the sock will be controlled by ovpn so that
+ * any incoming packet may be processed by ovpn first.
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
+			   struct ovpn_priv *ovpn)
+{
+	struct socket *sock = ovpn_sock->sock;
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
index 0000000000000000000000000000000000000000..1c8fb6fe402dc1cfdc10fddc9cf5b74d7d6887ce
--- /dev/null
+++ b/drivers/net/ovpn/udp.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2025 OpenVPN, Inc.
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
+int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
+			   struct ovpn_priv *ovpn);
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
2.49.0


