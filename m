Return-Path: <linux-kselftest+bounces-22976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04A29E8DEF
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B42281896
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D5C216E1C;
	Mon,  9 Dec 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="N2B47Rfk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58837215714
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734391; cv=none; b=KipQuD0KoJukFM6h0hg/HjARg7Fn0ckTHq7WCO5DeafAlMW7rg9JBMNYe/D0dV32+yhVtEve23eWUAznwwYqVU4eyFvE6w3GM7W7e8/vTWn5J+M3dJtGPrcIwUJgoZ5KecGnJJkzWfBdgzJTdD+Xn9F/+lqxBUoplgw5fhzxmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734391; c=relaxed/simple;
	bh=M8gNqQbi0rQ9/EHbOPxLbfPu705KbN+HrD3T/RxuNJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K5FyWXzG3FKeUyAaO7czk6QfMaE5LNlk52EdoPMwB598S3K0n7tC+NbRGMqmvhazFpBlK6yDK/Kl8jyc/SJ+YidH0b9fhd1suSnLuju3dTK8B7G1nWN4yn3cay4c4Ktc0iYAo3bAW6SN44BY1tkiW5dfb9Op/ZySAkkjgMZAiTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=N2B47Rfk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862a4b8ec2so1441145f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 00:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734386; x=1734339186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/iB0pPD3YtcNPkyKNqoQoWPIVEtSQcv/dxMDug0/uA=;
        b=N2B47RfkkkNG7ooFAUDtbjkVJsJUA75pgkcmiVqBz8GQ15A+m3Bsu8xbsMBgRePRPc
         KwNV2FzX7JhHxZK6HEQcQlOEdh7u8ElomcGaSDONMch8sjZ3p3dX8n/Un2VaDyUA9Pcf
         SIWPhvplyjt8Yv1D6MzF0HCHtESN/4oyKHw4zw42SVMCUD+xI4Ed63P4rGRYiX24up/B
         cUcGefOm01TRJQHgaI6FyJn/mGHNpHpIE42C4pEs2+TZsVcOBfultLklJDEElkhaAC4V
         szATl0+yINQ/V5L+1sUND/6g5LiAn5FmcqNFzimk5DTaAj4hWioA7BI5fqWhSh2li8mz
         20HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734386; x=1734339186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/iB0pPD3YtcNPkyKNqoQoWPIVEtSQcv/dxMDug0/uA=;
        b=RThAqMpn233ZHCejVrPkXmkaPqNPx1ca192hi5+uPDq4llTmxx+yTj5RORqtZ5hb8z
         Km8Z5N//JbKqhI7WVB2gjmKDqwYgRZrrROJh/71B+HAkYW/khkMAZ3U19urlCeDM42g1
         xBp9kk6DOImkDpjaalk8sxOe203C48czdVotQcjj7phxzPq/yP/9OwcLgg14UMEaR1BH
         +DynBpz7lE7V7lCIBHvRTOeUOPoVGfWXGPNI5Rlxnerda8HTgxtMe8pRM4aX1U0Kdn+D
         SzPLh47L0K1HjQ5RTq8D7jSgp/GHNqtf5lBDE0IFPXz0bQknINGNb0H1/OhD/bO2OP0b
         rbnA==
X-Forwarded-Encrypted: i=1; AJvYcCUau8MkBMopsZcY7JGWgvusOfVTDOyv0dhgSSxcjq4j303G+XcxZUfg3TUxJOkE68XCvxRxOWsJl+PGTJylFJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUCnK8/ckyQ/tS0l6njuaEWlFnD0KYxZDrtw/X5u1JKyQFTZW
	9fQAxQQKgJGIunSJL178FacgXv60ijb+XdLsJnsEGRO5+4iVnGlpGbEqyRpJOkrazA/UAszOPvF
	+
X-Gm-Gg: ASbGncuA22qgoXhAO3duHyyAmWtaZ93W+eEjsvekiwev5MRMvTHNTsU6CVsSNlZymK1
	fdQDHyemLnL4oGSuQCXn2J6VYebfJ+qPw/rYj/bkrtrSZSURpTQ3lbQ+CY3VSJThqaMzcc8piWr
	rbBT5LFSm7UFrpWE3r8oAaLQ6ITuV4adY7Vl8afMyeNSdr2y6Uz6pLVY8KH3GUMjPGZNLcuvmt7
	u3pEk+xXB8W1eV4PdEaRYhu1VfmtYi5NrCJmk9lGe7loZLLAv7JlQLKSGwR
X-Google-Smtp-Source: AGHT+IF9ezypYFrB9qJ5ihkcUmMKiShoTwOz9Y+OA4ZKyHiAeA8xlUjhsShCbzOR9hz0pVckiGozTA==
X-Received: by 2002:a5d:6d89:0:b0:385:d7f9:f169 with SMTP id ffacd0b85a97d-3862b33ab64mr6566552f8f.12.1733734386156;
        Mon, 09 Dec 2024 00:53:06 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:05 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:15 +0100
Subject: [PATCH net-next v14 06/22] ovpn: introduce the ovpn_socket object
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-6-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9404; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=M8gNqQbi0rQ9/EHbOPxLbfPu705KbN+HrD3T/RxuNJQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrASppgiLIXh56HvLrw0NiLEekU3Ky0wiSbSm
 yDJdlm/Wm2JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awEgAKCRALcOU6oDjV
 hwxPB/96QuQ85IemgNUR8dlIw8KbMyD/pS86muGuPKOZI8SbGrDqIf73vDjbK5rnA8eVSrnd3DG
 DvlEUHNjQnAzhgm0U5EZAoz1nVCGPePR/hOugmT7R8AYxPzwWGk91sd1mTyko2B6nZvRDvxM4dL
 N37EIIn9b00WlIr7vLRSG1DuVtiwLsycaY3UbrMthNYLP4hW0w3DDPaFpNgafeHh8q/Oyts8qvh
 mZgtb1cLehG6ETN7ZjvPribNIL/2EuKsa/sXpZZYwWQ6VAx+f4FNP6N+jsQcb7Ej3HckjDdSRWO
 8zkDoEQSkIStY1jwuZhjOtwiwKx5eeFpnF9VyH5kQeGUBAH0
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
 drivers/net/ovpn/socket.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.h |  48 +++++++++++++++++++
 drivers/net/ovpn/udp.c    |  65 +++++++++++++++++++++++++
 drivers/net/ovpn/udp.h    |  17 +++++++
 include/uapi/linux/udp.h  |   1 +
 6 files changed, 252 insertions(+)

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
index 0000000000000000000000000000000000000000..0abac02e13fb4ef1e212dacae075d5b58e872d34
--- /dev/null
+++ b/drivers/net/ovpn/socket.c
@@ -0,0 +1,119 @@
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
+	if (WARN_ON(!ovpn_socket_hold(ovpn_sock)))
+		ovpn_sock = NULL;
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
index 0000000000000000000000000000000000000000..904814d2b9e9f2b0773bf942372bcbe904ef5474
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
index 0000000000000000000000000000000000000000..c00e07f148d72ff737e732028fd73f82a507fb57
--- /dev/null
+++ b/drivers/net/ovpn/udp.c
@@ -0,0 +1,65 @@
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
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
new file mode 100644
index 0000000000000000000000000000000000000000..3c48a06f15eed624aec0a2a7b871f0e7f3004137
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
+struct ovpn_priv;
+struct socket;
+
+int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn);
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


