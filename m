Return-Path: <linux-kselftest+bounces-23547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B279F71F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCA516A81C
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4913A41F;
	Thu, 19 Dec 2024 01:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BfJ0EP4i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CBE148FE8
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572533; cv=none; b=VbZEGLWZj0iCYUnJgXUK5jVuzft8zi6uFC522LKD2+oMuVHT9Uv8Tj7L5HRCIVmlRSWSXEazPgvDvb3rT7VVZC2sR2+IqCXI8ySQ+JDfmRomR3O78FBerRleDMpT3Z1oyCBu20KY3yH49rDhr21Ce+CxvdaYwDcDXDILKtNKVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572533; c=relaxed/simple;
	bh=Y5jIXBvCUA0KxFrBkgH7j33aKvmpeEPa2sYpQAOXOHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Spe4lDrgNYSnYNdq4+biuE1NeYZLOhEK2+OVqC3CMU4L79ELRz4WCgiX22OlNGGCTrJIkb8FWBMyPRHP1oQfo3N2MOFkkBVPGzIFQ7tSSOoz7zIOMdBlHJx5UunxsrICj5JAjnoCJ3z6/vuE4q3D9kT5rqik09AEEGeLF56vPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BfJ0EP4i; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38637614567so131310f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572529; x=1735177329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpCP+sQz3m+owH4OR4EB7vq8nn+9rMlJ0JOCW1P3Wbg=;
        b=BfJ0EP4i2jcjqJl7NHU0mQB5esRBB0SosPhJoVNNzczA5Nc659mO8fDl7Twt5QqfOq
         6FLhGV3RIiFol9uy1/WOzPf+vlK56ZnQAyXniTOQWLt2v9WkG791XrGGjerC40pING7R
         5wNye7Eo7DqeOfEVhjDi18E7TPj7/NSR7Z+4KsZ+ACFCXuVjj/2GEReafPhONZoH2a2d
         Qy91jpU4LkLCVPc4UaxqWpeMEZAWjYKMpEeNclyxA/p+dqtWCn9mTC/B9xuyUf4EKiWP
         QosaAygqY6wuhhVfR+hn2isFDmHCS3Vv83S74GIZ3nSYN8/KhP9OCnvbe/O2m1Oi6cVI
         a2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572529; x=1735177329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpCP+sQz3m+owH4OR4EB7vq8nn+9rMlJ0JOCW1P3Wbg=;
        b=gqvEX1FmAEyfFkbpysQ8LCKwa64VeHEHObWwtRN307FAQvB5yBpo7d/OKlD46dIpue
         ooU/CWvEVC1F1Fbs2tWJ56ueg3GmxL9yNv4sZoFAOl9MoyHel8dYGFkCBobBOyXMTVw7
         rN+xpAE1yeXJJx6Wn056gp74HVBrUthq2YSylRrQlSz4k0H9YISjaE48SdL3fpeEPLBk
         ixHIlKr8BOxWqgzPJCjybp0YUNltjwlDhhq78mYaNosWjOUcfsLC4BCX1Y8uJ6LagDRL
         Yq1sz+wi0e57/pOveK7VjWU1+y8UzV78mXzRrnVZ1ZQaW31sUT7DhQ2AAyaajs6DtL0A
         NGjw==
X-Forwarded-Encrypted: i=1; AJvYcCWS94xxK+ggckwPsAM/JXikfb8KGyEjSnj6CyNe8HruDHFcOwFoioml1Bs2IyElqpjvF+c2qwDgHON2kgrPSGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxQf2IialupPqHPB4iDyhzSh8Ot86XobVjpbJrkZo7Q6CRL7H
	8XVbnPXZ1JXfbobxZPzRHSHoYBG2w0HFDNmOQ9eWE8Q8X9o7tuTj2WTZawiEklM=
X-Gm-Gg: ASbGnctSY31GDI7yoQXgsYJWj/WD+TXkLCtc4WvAA/NzgQ6Dvvq1FARUtSNj+mxnjZD
	Q+2JALLuAcDevqKbC4j4z7H1JM1h1fsbQgQfmrlOD1onhsuU3xAy8f7S+V5N2x2D+wC35O+Tl+M
	FaVd5phLXFIZVs/tCn7O21IRWXlIP2KxHWSB42qLUozxXAABNqnYS1cia+KBpXs+VZrYQZm9HGT
	euDjOsavbxnd9einNYr5T8IXYgGDSpY0NrCEuyFaSuiXt54nngV7WkQ3zXlsruas47W
X-Google-Smtp-Source: AGHT+IHM28vMlcjkf0bjDb6yKxYp0rvfBgy+G7TOIpEzCf1xmixpCbu2wMpFfXPkrBjxT/G4TXzarg==
X-Received: by 2002:a05:6000:1fae:b0:385:f060:b7fc with SMTP id ffacd0b85a97d-388e4d56be2mr4021649f8f.25.1734572528956;
        Wed, 18 Dec 2024 17:42:08 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:08 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:01 +0100
Subject: [PATCH net-next v16 07/26] ovpn: introduce the ovpn_socket object
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-7-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11027; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=Y5jIXBvCUA0KxFrBkgH7j33aKvmpeEPa2sYpQAOXOHg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oVraRdRqjKD8pVHlSgKunr8MDcKlnktlGfU
 9093Q7P19CJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FQAKCRALcOU6oDjV
 hx4HCACfyGlMpwCaQICIA7VJamuSw7armvA1uEQBAB8HJpNwqbijjFkL3r64Nn3M5XS7mjSJBUZ
 QL8+Ftcd+MMBYoVFV2JseHBFpIKoGiPiAyfxcaj4aZgs/AWWFq0s20PcJeQ1wztQl6/bmcZZmjP
 P5SjZPrgvMssZmedQM9RLxxdTnJ5m+sqhHcuYGD6wISb2VqSJ8DJLDDAkG6uhLvtRMsFvz2cGlm
 XA+4Gn4Un20jMyre5AhNBNEcOZ161OvtSPB0oAlrMaUWn6y2/evLerQ+aTGvo8ykEUCQlMQD8Q/
 FbypA5JpEgGTeIESYmGxAoaOM0PIWWCYJijYvguJHmC/yFcV
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
 drivers/net/ovpn/socket.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.h |  38 +++++++++++
 drivers/net/ovpn/udp.c    |  73 +++++++++++++++++++++
 drivers/net/ovpn/udp.h    |  18 +++++
 include/uapi/linux/udp.h  |   1 +
 6 files changed, 295 insertions(+)

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
index 0000000000000000000000000000000000000000..b41a95cc154ad50f86e67178a95f16e323880800
--- /dev/null
+++ b/drivers/net/ovpn/socket.c
@@ -0,0 +1,163 @@
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
+/**
+ * ovpn_socket_release_kref - kref_put callback
+ * @kref: the kref object
+ *
+ * This function releases the lock_sock which was previously
+ * acquired by kref_put_sock() in ovpn_socket_put()
+ */
+static void ovpn_socket_release_kref(struct kref *kref)
+	__releases(sock->sock->sk)
+{
+	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
+						refcount);
+
+	bh_unlock_sock(sock->sock->sk);
+	sockfd_put(sock->sock);
+	kfree_rcu(sock, rcu);
+}
+
+/**
+ * ovpn_socket_put - decrease reference counter
+ * @sock: the socket whose reference counter should be decreased
+ *
+ * Decreases the refcounter and, if it reached zero, acquires the
+ * socket lock and calls the release callback.
+ * This particular behaviour allows the callback to operate under
+ * lock while atomically getting the refconter to 0.
+ *
+ * This function is only used internally. Users willing to release
+ * references to the ovpn_socket should use ovpn_socket_release()
+ */
+static void ovpn_socket_put(struct ovpn_socket *sock)
+{
+	kref_put_sock(&sock->refcount, ovpn_socket_release_kref,
+		      sock->sock->sk);
+}
+
+/**
+ * ovpn_socket_release - release resources owned by socket user
+ * @sock: the socket to process
+ *
+ * This function should be invoked when the user is shutting
+ * down and wants to drop its link to the socket.
+ *
+ * In case of UDP, the socket is owned by multiple users concurrently,
+ * therefore the release consists only in decreasing the refcounter.
+ * Once the refcounter reaches 0, the socket can be fully detached and
+ * released. In turn, the detach routine will drop a reference to the
+ * ovpn netdev, pointed by the ovpn_socket.
+ */
+void ovpn_socket_release(struct ovpn_socket *sock)
+{
+	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
+		ovpn_socket_put(sock);
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
+	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
+	if (WARN_ON(!ovpn_socket_hold(ovpn_sock)))
+		ovpn_sock = NULL;
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
+	lock_sock(sock->sk);
+
+	ret = ovpn_socket_attach(sock, peer);
+	if (ret < 0 && ret != -EALREADY)
+		goto err_release;
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
+		release_sock(sock->sk);
+		sockfd_put(sock);
+		return ovpn_sock;
+	}
+
+	ovpn_sock = kzalloc(sizeof(*ovpn_sock), GFP_KERNEL);
+	if (!ovpn_sock) {
+		ret = -ENOMEM;
+		goto err_detach;
+	}
+
+	ovpn_sock->ovpn = peer->ovpn;
+	ovpn_sock->sock = sock;
+	kref_init(&ovpn_sock->refcount);
+
+	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
+	release_sock(sock->sk);
+
+	return ovpn_sock;
+err_detach:
+	if (sock->sk->sk_protocol == IPPROTO_UDP)
+		ovpn_udp_socket_detach(sock);
+err_release:
+	release_sock(sock->sk);
+	return ERR_PTR(ret);
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
index 0000000000000000000000000000000000000000..c8a065fbf27d4cb43a73fe8381a4d0d6d4c9de0f
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
+ * @sock: the socket to clean
+ */
+void ovpn_udp_socket_detach(struct socket *sock)
+{
+}
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
new file mode 100644
index 0000000000000000000000000000000000000000..42e6cccf0fe3958c7742af68b4edfbabc0132f12
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
+void ovpn_udp_socket_detach(struct socket *sock);
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


