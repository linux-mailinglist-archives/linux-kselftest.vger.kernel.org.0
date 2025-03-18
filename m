Return-Path: <linux-kselftest+bounces-29312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3800A6655C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 02:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414ED189EB21
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9111B4156;
	Tue, 18 Mar 2025 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="es900dw3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9662519CC0A
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262074; cv=none; b=ab5IHqBjN+/8L3hrYB2dUA7WWchGKh//ENjnM/p1EoW3oyBzVH0K7nmysXOZUMzpyL55E1k4zRfRqiTo67/bXCvX/e9WrABB6c9b9YTGt85VIDpqoaA7hn32eEpwx6UD/Vd3FH2ILWqwm96pJXMZyXx2HWNCvShU6GmQoW+Tjwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262074; c=relaxed/simple;
	bh=C9GZOISEYPh+tsuyG8LEU/VjtRzCHhiOhYmjrdknoC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bOGtekdZ5C6X/CD5Z98ErtQAu9NLGKo+PDSq58StOvGEW/YDg0joWZPHvEDmJIJxZoB1ok986z1rGioUSOyHMfLg4m5N2z/PlOsGRx2sKoEAb4fibiXWAV+xR0yKIdrJ3U1GPm+Xkt/H2j7xwHWeq1b5ctL/U5kiMsPYhYpuDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=es900dw3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso25876765e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262069; x=1742866869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rTXy70m+zO798yp8HULhJY3A5i+ksL0pqIJ1wfnz4s=;
        b=es900dw3oWqsYV6UQ5gmLTH2RufcSN+Ur5WtQBQCb1Mrlc5apRqbcfmbFCVaatFNjB
         rUZTKwb+I3LW5ePwhVftwzk7733yQ3kqAQV40HQqZveOP+9el/u1hPgJ3p9hChxIDwag
         /Af/MMjTiT0jJsZrXuTqDIOX8l5LRdRX0FgzR4A2a9KI4ytVyD3oFI8qcRPYPevOZouV
         pzAZdyOy3kpTA/agXyzCLDyd99Pb7W1MYhjeix1SYoT3zckine4+Rd5q5lU3LRCdLQKQ
         lJrmdto15OATletcEUVNobp0zBSuU5G5rZEerG2mSyOna4YIYnpqWgdEV18bvyGBEmHl
         Gclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262069; x=1742866869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rTXy70m+zO798yp8HULhJY3A5i+ksL0pqIJ1wfnz4s=;
        b=FsqXqvbT6g5+W1gzkGOzR9BGaOU8SurOczhn4khrr1BD3btzoHhZQdkfV2A2UfqcEw
         5QZxjkRgHAgGzJz9LGckpkv6OSkfAIVYqhIiLpITqbxj+dyxr+pWloTmLZM2UE46rr6Q
         EDuJ18fAzgAMgrJXDNRA0LmKnZIPyn4xWdK+1gqAdek4v4amWT2WuHOL05X/P5roqVRi
         Peum/mvIKkGHbwKvcFxHCI6azaMngeG8Gkeak4FierfbMkHE9Qmvb1JjF1VZ/WqbmSu1
         J8ml0BZkuYqiltz1q475Q1t/drwsnoDsZ4BDBwT+ut0RjmwHUPPbSCs7ejS3dU/LLwGk
         5ozA==
X-Forwarded-Encrypted: i=1; AJvYcCWYZu5SlNliL8ihMQqtJzsz1kpykczgDhwVAHRswkMyOih3SFRMvf8bdEtDaA/Hosz/knSdfj3W2cFhdtqEwtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFe5k4pwN7bYJQgzVVY4rMCgKvAJW0CySwhEzibSd1eawc/QRN
	ScLrzBMS5XjIzS0sDT52Pzig3rgG3dcA1ZL/POZWcSWmUUfjCjCshq7dFSeDwAbP+CxCfzpbEgR
	UukJBY196qw/Ulyj83T1f+nWZkI97hgmKbUN3DBaIJdFfE2JzEurjIUUgVG0=
X-Gm-Gg: ASbGncuse4q7gWYPlKWnGD5by/wac+AsCJgXjIjRp7FIKl68Co6gRScHkqK8qXdNyZ/
	UvcONsNfg3hh7hBjU61El7jU/6LgfXB30SGwCepQzJIRE+BOXwPJnzoyzCSv1dVtS8yaIKEWvvS
	KHjJXqfWgVH4vFPbeA3HHKqX/tAEnRZOznwfrrkmxIFTEgBbKTDTCXP97Hm4C6O0Uo3DHwDafsc
	220CqEw2urLWwmKRRbvMOkX1iZwXmiUU/Go9pmjvxbrEuCxp9o6iqlisr6w4Zp0n4uVDTdSX5+a
	jeKkLPTqSP7cESJGDwgEXHM9qrvI8bLrDEWDMKXjMg==
X-Google-Smtp-Source: AGHT+IGjt3nbyPcK96YI/GexcFhfkxDQu8PRUVxk05+xC3B62uMrcQ17El7TyjQCzJstQqWrCamIQg==
X-Received: by 2002:a05:600c:3d19:b0:43d:300f:fa4a with SMTP id 5b1f17b1804b1-43d3b9ac507mr3525925e9.12.1742262068910;
        Mon, 17 Mar 2025 18:41:08 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:08 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:41 +0100
Subject: [PATCH net-next v24 06/23] ovpn: introduce the ovpn_socket object
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-6-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
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
 h=from:subject:message-id; bh=C9GZOISEYPh+tsuyG8LEU/VjtRzCHhiOhYmjrdknoC8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn2M8p4yE1SRKZJHALd51aHnYlZ2FpgmiKfM4H8
 xY+p0S7tE2JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9jPKQAKCRALcOU6oDjV
 h1lBCAC04/RgX9Et5p6bmHn+nCPTzHu0sh5009Qs42mflWN59a/3YMLk7WJzu8kM6Pxsk0TbgfD
 tc9aucg8zeQ7wng9K9EisH7j15wLgQJDsHrTd5S+rJxIvRrhD1M97pDCWphfJczoOL47CHUnwAR
 xpvaiLWYDPe3uGlGwLZipjT9yJ4tbBYWakJlECH88dRE7/YZwkpSG254Z7qLsoIz20YEDQkeY7V
 BFRFCLiFCBrJ9QQZ2FDQMKK5hTtkWL/VMmI7UGeb24acM01mQ9OXjv9yQrtfVX/VNCtYLCBswn6
 E2UTgaPNVyyfBYCNCOBUpAhtWb/rFAQfLmVFd2ErlOsOOxm5
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
2.48.1


