Return-Path: <linux-kselftest+bounces-18875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E87C598CF8D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD97B248FD
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7029219F12D;
	Wed,  2 Oct 2024 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PCjtlZjW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FF619CC0D
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859812; cv=none; b=UGY8YS6TsMh5bKo+ISUEXZ9IvX0owxQC9Sau2lQ6Hugo16Kx6XanderMKVG3Gw45s4uGytmuuHyvvIs7nPq0plG9huSkKbJUiCSL0Oj2VbC0gtpux7WIDwzCYGm2eZV9GFl37D/F16RVyS5eKQ6t3g8XdQONu60tFXpHlBxzRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859812; c=relaxed/simple;
	bh=ggF5K+58gLgiad5OUSjEn5k2AotXeWRMNMLXDkZhNv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZyR0IkWz6r1m6nfx3kNpmOfuOA8no7TEWHdVe+eY8cYhK9othQOvAoM1AhKVZKkHXxs60qEa66XQcwzJDYzcbMF8MZpT9VVGiaEuLOssOluFaVetG+r7ybGkX4ZbUwqDKvX1Sdhf4CDTffmybRmHOaVUbDDl8NpbsjkG7fUUruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PCjtlZjW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37ccfada422so3500574f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859807; x=1728464607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ud6K5GOoq3b4lX4KydaG6wKHFrptq5dDMvYiS7l/dAc=;
        b=PCjtlZjWIW7vfKXoOw0kGCumUr3gap+9t1bMFrMEkNwFKA1sSQnMWYJ+d0/Kcahy4r
         MR5VBSdmwAx85cAMOZsvQzu3aCKH3BSyyEspqDNWavBoW06MgSCjN2JUIMKKAr+KLiPI
         4IYJIyjL6tcXTInWriX5NF/LfH1xJWiElWStbhOwg/jR26AgD+Ui1WkyY1RWQPKoK1CW
         7ZAFRiN9T0pTL+g9Vyni38jCEaymQOtC4U/CVd6O9hahojUcA+8tQ787dhqmRSpJLwoE
         Fzb3zIv/8zgI35ujPyVcJ3NzH1foov3eBuYd/dwIysDdcKAWSOpkJKM4Ay2XmbezYbaG
         Ioow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859807; x=1728464607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ud6K5GOoq3b4lX4KydaG6wKHFrptq5dDMvYiS7l/dAc=;
        b=Zomr2llepXAoSdmwGs/NbWj1/SdvXzDuciaLmVarwVxwyFanhdcTBAG8LwUhMvR9Oy
         npA0pyrWNX2W4gN3dpj5tKdXFxxVVJ3AqR5clKAqGbnBcDFQ7A6ec6uD4+pR4hVwehUZ
         k/uVmJfNBccGjShrmBCaYsD05rR5+t4FVsC3UlUEQcaa6zQuvNFPlw4zv9YsYjIPlnqy
         0lzAfddEM6uas5uV4QaBVuOJy8zKa7vqpeF9qnsAqC8pP6TowirL0Xx0HyJf6IfrPlUt
         D3n7Zu5oFRiDEBeMcYiuulJegMoowHM2mULGiMNMYSJgSnz6CK1+7Ru6DlsGSJ6YMeST
         xEyw==
X-Forwarded-Encrypted: i=1; AJvYcCV67a4QX3lwYnntqqHj8mllFsp4qt1uIFH8nw/ttwGTI1SDh2Yud7jD+dWBa2vD/RQnGiHVntAurUKyyUJ7S5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4DnCbq3abanyJ67mNK9TpRVkbifLjPmuN3YdUFNdDQqjswAbe
	ROhFkEBSRt8G40HFXNwXuqu5WMtmiJ5ujf/VNpwm7DG0X76NOJOpnWp1JRebVa8=
X-Google-Smtp-Source: AGHT+IHpAM2XhxaIwZSVpURvWt5PavZQ+eEYh2yvQnfFjayvR6XGXujp+DV5DQzPPTLHo4Rl3Wb1Lw==
X-Received: by 2002:a5d:438a:0:b0:37c:ddab:a626 with SMTP id ffacd0b85a97d-37cfb8b5257mr1318662f8f.7.1727859806627;
        Wed, 02 Oct 2024 02:03:26 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:26 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:22 +0200
Subject: [PATCH net-next v8 08/24] ovpn: introduce the ovpn_socket object
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-8-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9019; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=ggF5K+58gLgiad5OUSjEn5k2AotXeWRMNMLXDkZhNv0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxRKVOwfmu031gZWitqkxwNVxZO62rgGRuqs
 WYsW48XkfWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUQAKCRALcOU6oDjV
 hxnNB/45k5Pb75lJYND2yI7s+Vi8LE7hpWru8jtx6b8f0jMcXToy6da2gzYCKY9zRHc8EPkTIUM
 2FcRdCjGeOTPspJBAYbI6sJRQApYZb27tNaSiPW0wkhJXtVdywpCQ6+b8l+CDpr4vEisGkZUImB
 W9y+DorjKH3RV9/3f4erSG0ROu+DeaYUYJLGN4axDiADU1hsxl4obWM7xUzt7169JhdpIzpdyVc
 kAMl0sVXRzedmHN9nLWB2tV5Q/ZhdGXEaj6bMBJr2I7JZ/cHPBY5Uwx+mRtwJ/nzf5YQJVoBjN3
 n1MUVXOXSvw3V0Krzt7gWOGQotP6Iws31D3MdSzJgYi3gQu8
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


