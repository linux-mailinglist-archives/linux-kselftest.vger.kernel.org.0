Return-Path: <linux-kselftest+bounces-19797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C899FDD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 03:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB441F26473
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 01:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3A018B49D;
	Wed, 16 Oct 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EjI4Ra7+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F2189F45
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040638; cv=none; b=pPmzsw76yLedKKcokPRxXmCZj9tI6vsfS6p1N7g1oLsdBnBnU5D/IY35RQ7SM9WGUJ78WKDVfV4NWQ6QVu0VEwaOGRdF5dsWYRHqt06B6ekSOjYP+qfaC/IuMTmDnvvFa18HMHFV5pijFLR/mfxD2YfbJNM24LHyo1NqGkk3e6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040638; c=relaxed/simple;
	bh=ggF5K+58gLgiad5OUSjEn5k2AotXeWRMNMLXDkZhNv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Armfrk1D6mwW7yGO36aJhmTpwow++l2iozDBLjWJK6yBH6E5kZcmFjmO3M54l9+oN6+3dmDjdDLQ+waLvnW8gP639a74W4406bb+/+UujSCp17GkuxEkmOlKPCvCmyi0pXq9/zo7NpYu4S3p26YiqhaGDHK5hKAstaGqLQFTTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EjI4Ra7+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43124843b04so34747335e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 18:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729040635; x=1729645435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ud6K5GOoq3b4lX4KydaG6wKHFrptq5dDMvYiS7l/dAc=;
        b=EjI4Ra7+mUtw6mx+ECVTzl22I6MuAJaq+ZpkMdqFRJ0ojMmlcwX1XcWgWsCaoSIb0w
         HQv3CXvVy8fx4vR1aKBEZgIWbHV/Z1XfcbcAUaEp8TX/5Z32SoIusND0lqsX9bv47+hS
         xwGsS7Yzp7aZjZwt8oOvNav72HsUofEKG8cnNccav/X2qXfnmVMDoRP7mylROUEaeX6e
         qERjMz7cmZfvhY7RdgPz3+uJd2aSK1FquDn3h1EOEpgApCYSwWZJk0GqcfMdd1lVEpb0
         idfybnmC1bHoZwhORzv2+K5mY22PtQLpl2Aok7TldZ9+Uh7kNWzz+yDV8KFn5gKKNujz
         iX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040635; x=1729645435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ud6K5GOoq3b4lX4KydaG6wKHFrptq5dDMvYiS7l/dAc=;
        b=ZPMkhyMbctP0/R4pQmJxH1jzK9CguHkDT0t38VB535w30IbvpO1pB+whfQWnzgoWwT
         sv5f5j7i4ufy2/kiJnlOtM5HUfzGxHnuOJMpF2X4Y250LEz6qUhD3oCRj31ihGiiXMrK
         5/ujwYVcC+z2rx6kDlbR9yz/ZXMD0CGHyVHrGl54knrxHLLVbhyLz4IorZU8mEcWCIBP
         ceRIKXjeioNWzggnCjz+72REawkn6mX4KbHzWgeyML5OE/uHtDZ7urlW/nKX3ZS2Q2Fs
         GJliIhRiA+iuwr6BJ2UuH5n1pEz8thurJpkLhTZlNGYFk4EYI3KaQ1iy8Lz5/SDsJtU9
         ry0A==
X-Forwarded-Encrypted: i=1; AJvYcCWioIk3858f4A9mP0rf0MJUhy+AVvjrMIHrj1kKlYoySNDjsJoOSRdojHVjGJCXJa4/aKDl6BgW9W//y5mYbjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUTNCqBCOpqZzmMnaexii3SplE2XrnYdvE8/olaCO1tE1BvE4Q
	eehhIybIM+vCGpWhY9xf6yMw0QbfnHnemIeEVrzWgr7sJ8yF0IGSiLQnw6SIhBc=
X-Google-Smtp-Source: AGHT+IElhVPemSMkaKzDVK6PyvleajJ2ybaHbRRGgXby+pI4RQz6g2YdJdfaif0XRYc8ChjoZir7gA==
X-Received: by 2002:a05:600c:2314:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-4315044e674mr5340115e9.22.1729040634638;
        Tue, 15 Oct 2024 18:03:54 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:4c1a:a7c8:72f5:4282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm2886765f8f.25.2024.10.15.18.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 18:03:53 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 16 Oct 2024 03:03:07 +0200
Subject: [PATCH net-next v9 07/23] ovpn: introduce the ovpn_socket object
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-b4-ovpn-v9-7-aabe9d225ad5@openvpn.net>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
In-Reply-To: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9019; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=ggF5K+58gLgiad5OUSjEn5k2AotXeWRMNMLXDkZhNv0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnDxDvkB0iccAPf51dXcjIuE5PlChNgocu3n670
 bhsJqkOBqmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZw8Q7wAKCRALcOU6oDjV
 h7IRCACuclE/Hw6nucIkFqbDD4j1FJyNvYHFTA8QEma+CjSf1LvLgRA0+wDQDcvD7CzGs0/kBVL
 +p7qFfU1Z3hRD5RaUIc58ByahD4fs14gKTzFb+geIoyr8QtLt61RYdG3/rP6FNDAiMD+t6L5XNC
 CWkqfD8uX6pzQiqnjSek7qBy5fauBVI8QCb0pExKkHnYgk2V41VOxHKeKSSftmOY80rJl0IlK1B
 2couLFlVAk+Ml9E0J4NYrmSTLeMy5rU3GNMy890nSkbaAXtTGYLeAqUAB1w3z5Lm4QZoUio2Fx7
 sjiyOZ5F94kK3r1HdQYjSLNMI904L1iuXfEf4eU+bmn0o6/l
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This specific structure is used in the ovpn kernel module
to wrap and carry around a standard kernel socket.

ovpn takes ownership of passed sockets and therefore an ovpn
specific objects is attached to them for status tracking
purposes.

Initially only UDP support is introduced. TCP will come in a later
patch.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile |   2 +
 drivers/net/ovpn/socket.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.h |  48 +++++++++++++++++++
 drivers/net/ovpn/udp.c    |  72 ++++++++++++++++++++++++++++
 drivers/net/ovpn/udp.h    |  17 +++++++
 5 files changed, 259 insertions(+)

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
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
new file mode 100644
index 0000000000000000000000000000000000000000..090a3232ab0ec19702110f1a90f45c7f10889f6f
--- /dev/null
+++ b/drivers/net/ovpn/socket.c
@@ -0,0 +1,120 @@
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
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "io.h"
+#include "peer.h"
+#include "socket.h"
+#include "udp.h"
+
+static void ovpn_socket_detach(struct socket *sock)
+{
+	if (!sock)
+		return;
+
+	sockfd_put(sock);
+}
+
+/**
+ * ovpn_socket_release_kref - kref_put callback
+ * @kref: the kref object
+ */
+void ovpn_socket_release_kref(struct kref *kref)
+{
+	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
+						refcount);
+
+	ovpn_socket_detach(sock->sock);
+	kfree_rcu(sock, rcu);
+}
+
+static bool ovpn_socket_hold(struct ovpn_socket *sock)
+{
+	return kref_get_unless_zero(&sock->refcount);
+}
+
+static struct ovpn_socket *ovpn_socket_get(struct socket *sock)
+{
+	struct ovpn_socket *ovpn_sock;
+
+	rcu_read_lock();
+	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
+	if (!ovpn_socket_hold(ovpn_sock)) {
+		pr_warn("%s: found ovpn_socket with ref = 0\n", __func__);
+		ovpn_sock = NULL;
+	}
+	rcu_read_unlock();
+
+	return ovpn_sock;
+}
+
+static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (!sock || !peer)
+		return -EINVAL;
+
+	if (sock->sk->sk_protocol == IPPROTO_UDP)
+		ret = ovpn_udp_socket_attach(sock, peer->ovpn);
+
+	return ret;
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
+	ret = ovpn_socket_attach(sock, peer);
+	if (ret < 0 && ret != -EALREADY)
+		return ERR_PTR(ret);
+
+	/* if this socket is already owned by this interface, just increase the
+	 * refcounter and use it as expected.
+	 *
+	 * Since UDP sockets can be used to talk to multiple remote endpoints,
+	 * openvpn normally instantiates only one socket and shares it among all
+	 * its peers. For this reason, when we find out that a socket is already
+	 * used for some other peer in *this* instance, we can happily increase
+	 * its refcounter and use it normally.
+	 */
+	if (ret == -EALREADY) {
+		/* caller is expected to increase the sock refcounter before
+		 * passing it to this function. For this reason we drop it if
+		 * not needed, like when this socket is already owned.
+		 */
+		ovpn_sock = ovpn_socket_get(sock);
+		sockfd_put(sock);
+		return ovpn_sock;
+	}
+
+	ovpn_sock = kzalloc(sizeof(*ovpn_sock), GFP_KERNEL);
+	if (!ovpn_sock)
+		return ERR_PTR(-ENOMEM);
+
+	ovpn_sock->ovpn = peer->ovpn;
+	ovpn_sock->sock = sock;
+	kref_init(&ovpn_sock->refcount);
+
+	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
+
+	return ovpn_sock;
+}
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
new file mode 100644
index 0000000000000000000000000000000000000000..5ad9c5073b085482da95ee8ebf40acf20bf2e4b3
--- /dev/null
+++ b/drivers/net/ovpn/socket.h
@@ -0,0 +1,48 @@
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
+struct ovpn_struct;
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
+	struct ovpn_struct *ovpn;
+	struct socket *sock;
+	struct kref refcount;
+	struct rcu_head rcu;
+};
+
+void ovpn_socket_release_kref(struct kref *kref);
+
+/**
+ * ovpn_socket_put - decrease reference counter
+ * @sock: the socket whose reference counter should be decreased
+ */
+static inline void ovpn_socket_put(struct ovpn_socket *sock)
+{
+	kref_put(&sock->refcount, ovpn_socket_release_kref);
+}
+
+struct ovpn_socket *ovpn_socket_new(struct socket *sock,
+				    struct ovpn_peer *peer);
+
+#endif /* _NET_OVPN_SOCK_H_ */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
new file mode 100644
index 0000000000000000000000000000000000000000..c10474d252e19a0626d17a6f5dd328a5e5811551
--- /dev/null
+++ b/drivers/net/ovpn/udp.c
@@ -0,0 +1,72 @@
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
+int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
+{
+	struct ovpn_socket *old_data;
+	int ret = 0;
+
+	/* sanity check */
+	if (sock->sk->sk_protocol != IPPROTO_UDP) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
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
+			   "%s: provided socket already owned by this interface\n",
+			   __func__);
+		ret = -EALREADY;
+	} else {
+		netdev_err(ovpn->dev,
+			   "%s: provided socket already taken by other user\n",
+			   __func__);
+		ret = -EBUSY;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
new file mode 100644
index 0000000000000000000000000000000000000000..f2507f8f2c71ea9d5e5ac5446801e2d56f86700f
--- /dev/null
+++ b/drivers/net/ovpn/udp.h
@@ -0,0 +1,17 @@
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
+struct ovpn_struct;
+struct socket;
+
+int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn);
+
+#endif /* _NET_OVPN_UDP_H_ */

-- 
2.45.2


