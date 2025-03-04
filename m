Return-Path: <linux-kselftest+bounces-28117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B2A4D007
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 01:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFA5174AE2
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C3715383A;
	Tue,  4 Mar 2025 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LvQjUjGn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60E137923
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048478; cv=none; b=KjdkP8gNae9ISLmTnBFSPxUJDSoRenw8CeGYvuzr6CsspY5rM2rKjiJgxb8eWB3/GTg18dVJwEaDX0Ig0O8rWGKUqGUCw+6tykaWPRtCG6QWiuU7bXD8VYFTSkoIvmER2Di3v37/ogsWyK3hnqZST563Fp22h27mo9cBfna2J/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048478; c=relaxed/simple;
	bh=Q6t7iC7Y/gKU/SNt4l5/ZdTJJZD8kiL2iHxQ3LpAAlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l+gve4O18UxH1AjsPg7Fzapf2Q+KbMnodCN+Upc8ywtkzAnKKipuKG3x/2zE8k1G53K7eCFDKf+3aAzUV54R0tqpUypbrw2JntqfH7IbMlJ0SIKrKgr467JmcHVmd+H1ytOfk+JdTE7cKUubl7gBx2OWSFoosazTBl213QEjFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LvQjUjGn; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390f5556579so1838506f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 16:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048474; x=1741653274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/PA3s7eLlE6tKl6PZi8ASYiHuz5Zk6OyWMM3V1pipY=;
        b=LvQjUjGnBRE8/aLD0cUGJWCURyffQzoBpvhA9ivyMgN2/zymkswn3u/pyeBfAOqJW3
         9nomkFjrbaxIP7coacY0K4ElczfBfVHnE7tcqAge3IK1f+du3m+oXSBl4m2WsWDMaWR/
         7RHce5GEQNo84HqWrFGUVIgnsqv6gBKcQNDpShw3zuIK2X0hZFUU3z5SS1nqOsG7ogV8
         /mluCo4D9f12H6mfX4Z2dtNWrxI7XtqPHnSKIfNggk1eGu4BREn5Pmz5tzT58KSBQpIX
         dmSI7eInhMUxI0yPI4pXpOEWWCpx74+jWACR7yVw8DtMDpuVYF8bajSp3GARBmP3eR06
         X2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048474; x=1741653274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/PA3s7eLlE6tKl6PZi8ASYiHuz5Zk6OyWMM3V1pipY=;
        b=HWFP7ZwVEfdln074xQvW9siQRBwJPYRa8/FIZYiLxOteUac7WHOdq6YHEHorqXDGW4
         SUHv1NVJ6Z0PvylScpea6BBBXfV63ZxlMevhAD89q2MdESVVz+WBT8oAfaW1AHRib9+9
         ZzefVCv5gys839L92/RhS9Rwc5Qu8l8nIH5l+dzJ05d3qVAXF8LNzR9ka1hF21W/1w7K
         tbCuE8FeuJkz97d3rOtlCYlil1eWvf+slNSsF7rC/xBkNspRSlNdytd5H0/sczSCQYbB
         aZXHIKirPb70xAKWKzjBeOBvaPjcNxRsUoHYUbVbhQSrtso/GRVIAI36CAeSxt6hYcyp
         +4PQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/t866dGSDxG0oM32ugwo0Bq7Pr/SbvKxYds21l5zIw5pMELYs9tjj7HfMllgCiIKP6HUPNnw8dBhKTouih2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf2w4n8JA2d7ZaXYp0aIbWKWFhz/i+6D+cTd60KMC4il3wTE5i
	lc5xcDARrdbLWRpLgMQFqhLvRNS+WiLS8/Axu+vpsbfDS9MY40/iJ8yP+8LpFGk=
X-Gm-Gg: ASbGnctiPy9BL97cW5qvzsgysIcrqHuSUfTVI06HGRD9DO/pOA6G+sabs/TG+oekw7l
	gqG8pb8M48x+cTFWaBdxV1/yr1YNTWL7ou7QQB+r2uo0ED8nhUQQvIVKdDDsqqlR/ZpFhcqMLi1
	XcbO41UgP9q1Dy6FbRw1x6FP7HF2EuiU5DpbYJlU6PSt1TeXD4FjCfFuAA+vzSy1mhnN2eFuZZ4
	qFhhs4ENr14ehV2/aEycFdmvHDEpHxQ8w+jELqdscEMGVbb/i+2g/pnTz/g8e2aEbeLb8gxqf32
	0U6VJ0Zo/PlgoKw9f+Toys4gt2Zv5gjUHG+aRC33dQ==
X-Google-Smtp-Source: AGHT+IGrbZzSlJzwBcVSJ4upY9d5+Y7fp6d9+9Din6Q7l/eQSiPNmm9CbwBswDwc+819e5av+fjCGA==
X-Received: by 2002:a5d:588c:0:b0:38d:cf33:31d6 with SMTP id ffacd0b85a97d-390ec7c8054mr9355146f8f.3.1741048473992;
        Mon, 03 Mar 2025 16:34:33 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:33 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:36 +0100
Subject: [PATCH v21 06/24] ovpn: introduce the ovpn_socket object
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-6-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16344; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=Q6t7iC7Y/gKU/SNt4l5/ZdTJJZD8kiL2iHxQ3LpAAlI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqPnXruo1VOSC7L2CpW/1Au0J2Sd1mZai7eE
 MaljKORiQaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKjwAKCRALcOU6oDjV
 h+hYB/9CPPBpg7VyiDWDvfBJggl8yC5V7BNAc3Xpdub6/RjMq1RVcvG9D8bW7h2ItLwx8d3oZwS
 LOGHSjKKsfp4vVqHESAv5hFIa3wlMG7X1T6ZbScqQzx4FGg7LjjC0hQxU3Fctti8prdUM/zXxnM
 SnnNPRO/hDTU0tUj0OKt8xPnCLJx/BrCkVy8TzsSDgmmYBefL1UiyGyGWwqHwDnARZHn26Sw27Z
 laup12aQSIkM+J2Aw6xXjk7dkDGcMhAfw07t5fJ/QY/Y87vl50Xa+V8faNPb/RdV6+QMZQtUIpZ
 VWP8zloGOp5Hx1s7GW6+qLyejqYgBpgtAskwoGpv5luSdrw1
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
 drivers/net/ovpn/socket.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.h |  38 +++++++++
 drivers/net/ovpn/udp.c    |  75 +++++++++++++++++
 drivers/net/ovpn/udp.h    |  19 +++++
 include/uapi/linux/udp.h  |   1 +
 9 files changed, 372 insertions(+), 7 deletions(-)

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
index 3c72b80095a0ed8f2f2064fdfa556f750f1c7061..e58739d82da54001a346c38e5c5a882589eb3801 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -185,7 +185,7 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
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
index 0000000000000000000000000000000000000000..0a1ba3f75aa7438502dec4c86dcef8637d5ebffa
--- /dev/null
+++ b/drivers/net/ovpn/socket.c
@@ -0,0 +1,208 @@
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
+	/* release may be invoked after socket was detached */
+	rcu_read_lock();
+	sock = rcu_dereference_protected(peer->sock, true);
+	if (!sock) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_assign_pointer(peer->sock, NULL);
+	rcu_read_unlock();
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
2.45.3


