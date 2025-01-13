Return-Path: <linux-kselftest+bounces-24336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EF3A0B2E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 10:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18C71886AE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8B12451EA;
	Mon, 13 Jan 2025 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NpGsnHqU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A223ED67
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760676; cv=none; b=UkO/azOTRCIRms3UZsR7CVawwXqjCnqc3uCLtoNbzOXO3mevXaKm1kvRod6CAbg0Ygfrcm0Mazr4fs9y8tQtsVvXcQVV5Snn/zfVP1Wiw1fCnLSitwzGd0R25OSvPfO0FxVDLpvskz8fQk5rSZDZtk+jFIxF8+mg3DrruEx7MUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760676; c=relaxed/simple;
	bh=vvPWtzkoAAgVxyXCmCpGpsFlYt3qVWfy4JKJ4h7LaU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VVvUd7VbznUv3ExcmaC7rR62F0UYwo2WoxXMrENwYiyr+AwuV9ZwN0BiE+kcvLQTto6Jjgf6hlBQs8N7Fl/C7JoN+6s1gKlYRHNeIbRwjBlQjuDSqvGjr7YdSr3jFDHBJWvjI8751acBnwJVTihPqEVwtW2lIBLULOnjwJpmd6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NpGsnHqU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385df53e559so3238007f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 01:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760671; x=1737365471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrRSM51Rle4kdO4FzKl+ps/20UQ8rEmMX+kqKzbwc2Q=;
        b=NpGsnHqU6zLLMomzqhZQ24C5GIkKD+RzEBAiB6P47p2MLBG4UGpnUw6yq8HP6DX3Bj
         aszYMtWJsd+YC0ia3zX3fK1mQ7LLxZ5tnXmxWmFrZv4S7+XjAaDaV/olVTuFXWY9U399
         oV4ODghWpQ0TsU8orjySkDxxHlPTJSSmlgRzKcDOo6c1XTZ3/vrt1q1pnPiFGd5kc3A2
         /NEhRCYdTEeLzLH4X577xXI1ORR/CRpJARQK1jBq2GpV0JBJHRLwWuXOHtW9nVgZ29tj
         P7WPlfgaevK9WWCmwgqX4H76hyV9MB0FoL7YqooTtdPQloLbotYcPUOqeVLPC1sfvmyJ
         gk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760671; x=1737365471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrRSM51Rle4kdO4FzKl+ps/20UQ8rEmMX+kqKzbwc2Q=;
        b=Ln2tZo/XazpHaIvbJ6Lgosns94BM3x+uQSz0XgehZkod/A47XMrt2jqJ7IMu8Qsg8H
         fS2abTU7OqnaK194gQtCwQxA0S2KttNUaD4VyhzgWDb4N3zl7NmhwzFOZJsu7Geupjc8
         HcGXwwRxi6kTtx8Y8nGdMfGdOLtntR+UGXRmqLsDyAGQBvLnW3MoFYWy1yoSYZZZCqxl
         lAwJQxbAU7xKFC2i/lmYXFeQeeOnaN7w55e2IgoePC1v9lfhdI8leZBeLCJ4TlNQjk74
         zoH6WhrPKTX+73PpCrmEA1R2uPS/n9/fhHBDclWd/ExzJr5+hHdA41TiOPeiK7+Lmg9j
         8tnA==
X-Forwarded-Encrypted: i=1; AJvYcCV8g6MKm2xf04zcrhr6ajC9HKKDwL5QnGoKQ8UcYm7e87TZ4rkaxiKlMhdumbCnJwAKk2pbYdwAKhHx3rDIJHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8VS9KgOBrlnklvCc4tmxUsJnCqNEt4IYYlxLWbj7jyNmSz97r
	TsZhgJoQJo7y/U7kjazICzBgC4HoY9pDqcFkfR2Mt0tDL5Xx64C+SlSLHu9kIYo=
X-Gm-Gg: ASbGncsmSjGkXnLS8qJJ2Ex6TCzwIkIopYFDSdLD1eHMEOW1PvDtCM4Oc8fWeuhzDzM
	Fh1Cin0COWtQwlmISu4KYP/Mb1Qh8aCXezZrdFkE+z3e0WAyr4X6evSDyLl195eQsunDm2O40Ku
	CDsCMn5XBQoO0NyqdPApHTlrXT81QH5DVBu53dZLDusl61lP3bo9NamGTLdFncdPfIOrhaeNZH7
	gppSRk1ESA631bNOxCg/e7sJuAYiJlU6siYEKUetyCZ0ppGul7zuCc67UVGVz6kNWSY
X-Google-Smtp-Source: AGHT+IEIkvFa7/NvPO5TfDeEyfAo6R++gDuDluKs07i6DLUJHUO/h2EZSR7okjBJ8DOt90fIjZhr6A==
X-Received: by 2002:a5d:588b:0:b0:38a:3732:444d with SMTP id ffacd0b85a97d-38a872e567fmr19669240f8f.23.1736760671154;
        Mon, 13 Jan 2025 01:31:11 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:10 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 13 Jan 2025 10:31:25 +0100
Subject: [PATCH net-next v18 06/25] ovpn: introduce the ovpn_socket object
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-ovpn-v18-6-1f00db9c2bd6@openvpn.net>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
In-Reply-To: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13267; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=vvPWtzkoAAgVxyXCmCpGpsFlYt3qVWfy4JKJ4h7LaU8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2GpbV5BxHqlha8DmYCh56cywK1ZI8R+tOPA
 NcAeW52yGmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdhgAKCRALcOU6oDjV
 hz5tB/446RsHoU6wpLS4S5cHM7m3/ab/roZ33u3Ip114R+ychdqd7MEG1gBbdyFItfdp8/i4dR5
 vPnCDXK5+9DhsO4Unc4gAw+jv0puGET25FOMEhsUjb7QTsBgAqgxY8koXDsI+aaltxS1/hsnZ6h
 FGAft3ha7v61MZLQHv/ZMnvkNSSLzpreoCislKMpj7tfVSbPFGoEL+cEtjLQQb8HFAg5ujRZJl3
 i3gG0J3ORMY3Ql9UD5qxohTKGBoVyxeZjuVEGWS5Zmv+4WeX2mOY8tzmTgKbDFFXUVPRR7JLFiu
 8jHO7c1eL3D3E87pz3kJCMB78Uhp90285qt9klDxARv8g13Y
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
 drivers/net/ovpn/peer.c   |   6 ++
 drivers/net/ovpn/peer.h   |   4 +
 drivers/net/ovpn/socket.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.h |  38 ++++++++++
 drivers/net/ovpn/udp.c    |  73 ++++++++++++++++++
 drivers/net/ovpn/udp.h    |  18 +++++
 include/uapi/linux/udp.h  |   1 +
 8 files changed, 327 insertions(+)

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
index cf55c3b4f4cfd9add0c8df543f917cfa0563ebd2..735d23d98739c507cc3d42031976b17a5f87c0ed 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -258,6 +258,12 @@ static void ovpn_peer_remove_work(struct work_struct *work)
 	struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
 					      remove_work);
 
+	/* the peer has been unhashed and is being deactivated - we can
+	 * now switch off the socket and drop its reference
+	 */
+	if (peer->sock)
+		ovpn_socket_release(peer->sock);
+
 	/* reference from ovpn->peer or hashtable dropped */
 	ovpn_peer_put(peer);
 }
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 048f7c6fe5822e0d8a1e44102eb7f4bbd5f718ca..745b8cf46dd2df399aa027c52a13cec6e98d6ca8 100644
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
+	struct ovpn_socket *sock;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
 	enum ovpn_del_peer_reason delete_reason;
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
new file mode 100644
index 0000000000000000000000000000000000000000..a77d90870fb7522abf08049c72fc1c2bfc26b32a
--- /dev/null
+++ b/drivers/net/ovpn/socket.c
@@ -0,0 +1,185 @@
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
+#include "ovpnstruct.h"
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
+ * @sock: the socket whose reference counter should be decreased
+ *
+ * This function is only used internally. Users willing to release
+ * references to the ovpn_socket should use ovpn_socket_release()
+ */
+static void ovpn_socket_put(struct ovpn_socket *sock)
+{
+	kref_put(&sock->refcount, ovpn_socket_release_kref);
+}
+
+/**
+ * ovpn_socket_release - release resources owned by socket user
+ * @sock: the socket to process
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
+void ovpn_socket_release(struct ovpn_socket *sock)
+{
+	/* Drop the reference while holding the sock lock to avoid
+	 * concurrent ovpn_socket_new call to mess up with a partially
+	 * detached socket.
+	 *
+	 * Holding the lock ensures that a socket with refcnt 0 is fully
+	 * detached before it can be picked by a concurrent reader.
+	 */
+	lock_sock(sock->sock->sk);
+	ovpn_socket_put(sock);
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
index 0000000000000000000000000000000000000000..aab26b575df9c886a078c2884900c362a6bf0eb2
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
+void ovpn_socket_release(struct ovpn_socket *sock);
+
+#endif /* _NET_OVPN_SOCK_H_ */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
new file mode 100644
index 0000000000000000000000000000000000000000..4567c7ea19c4adc5b85bfda2d408f3bc3340a48b
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
+#include "ovpnstruct.h"
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
2.45.2


