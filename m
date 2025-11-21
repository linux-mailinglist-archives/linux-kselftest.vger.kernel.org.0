Return-Path: <linux-kselftest+bounces-46152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FA4C76BF9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4042835EA43
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 00:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C6239072;
	Fri, 21 Nov 2025 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Fae0AzLR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BB2253A1
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684463; cv=none; b=iyB5Orl3JdrvHDUQLMhsbkufOz8AYQLo186U62Kp0wCITbCWgNWn+GfjiOx4Xfqm0HPC+XzcwlskjkF6v1IMJ0/ZqbZ3WUbMTtIzoMvWted4Fo6yrF9aXMglL0ofvch4WxHWh6vHasbnvR4IyB4ZJD5oVvTCXibXQUh2HCan2Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684463; c=relaxed/simple;
	bh=ggyh434yfvgN1MddpgLjdLlJQg2cVR6qEDU1D/abUZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSKgTnhLdzkEfbKYAz38B+c13QM6y1oyDRMNucKCGLWDaG/Jx1ptVRJ5NRb1TSHfhXw7OnyDpy46wOYFzH3Q/G2Y1gytsShrLsNv48Ur1bl7K7Kc24YTLQrV3MmcWFTxN+H9auahoPlibr2Ep9wApYXcBqPnzK8Tkd2uxE9ZXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Fae0AzLR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso9875375e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 16:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684460; x=1764289260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfZ2HIL7kmSSJMl0qDJrOOZ7GWO1ROraHP5UYqRAkc4=;
        b=Fae0AzLRr75t363cbzqODeEQXowin41MZDqElozfKYlqAsTnZEIgbdv0Q5OhsEpNWo
         /N1jmQkIa6BxNb3JA5pRyOSyDibjMnK4sR7PEZcHeYB0GKDAbK+JzEitJ9aqSs/CyJ9J
         AwlcpkhsZg9FVPhgAnjn14Zd1X/qpnq6/lc2J0EIl00NZyUM6y4oaBWE2YfnUjDObb0d
         MBJZH7bEtlUm8U0SeWv9eqDlctZ1dGdgcWcADF4d5YqySlkD9TDhRqpxfbku9rKvaiUI
         h+dp4gpi0yvgSLcB/mrN+W5VwVZK9u68tSzpNc8ha8QyNKwddhPPa87jcfjMw15JIr/r
         8MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684460; x=1764289260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gfZ2HIL7kmSSJMl0qDJrOOZ7GWO1ROraHP5UYqRAkc4=;
        b=dAikExlSgDzwx3ztvwgaNPBz1AjMHGmuESI37YjueHKgfWV/ZNqWEXFO8YKMVVC+sH
         u9qAFl9yCFlxdUusEs+Lm1CeJo3zI7zPY7D55A2J65vYouw0JTubjiv9eryhelSz4FDO
         DB+9Ki8m4seqF50gIzp7gqRTv7TMzPf32gBi0ODs90rfF2GWvLbc978LcDcE/zSIUrrt
         ghzShIDfD1bfj7OKpS/LuLy3qonaB4jcs9gKcz7dVkTiLMH5G1dDxUR9/Wmqjiq9hVu1
         fqFG03ElIxmqt2icg4tEnR/RxcMsI89J/Z6DTc7hGfE0pw/wXCxwzZgSPa5T2fR8jgBY
         l1Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXf81VTQHkuFiVd8Xdfzuu8r9wu8ZWzA1ilQxuwUfTzOEHFgIto2S//TD0mf1VyeJI5fKb2ZoePpPFLQZyVvig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwApNxdbPcuR8lkOMFEa5KtjS/GCkqhcUC95XpSotUA0KA69app
	zsxHD8UEwL2NBUeJENLUT1S5oAHEfWluJQ0BqU1be0mJ5TsZzaSWWLWpH86Bbm9TgRiovO73ubP
	6dya4xWsJ2fd9HW/EaiMdEhwRYx/7BdqY/zml8eKOmUHlnIeEQEmEsVzw5ZgokyI=
X-Gm-Gg: ASbGncsoKZ5bqsdqHSO0SS4M82uB5v3CCBXL9fjM4Ri+VZLway8h/Qnl+cMyxTSSl3H
	g3jIwBsKp53gMAYXv1/xKKG99nf4FuXkcmV8YesDK6alLWngqmzYbSg53jQ5c0VZgxkIU5x33WY
	qzSRIVdQK9rEJSdtsYauM3vahuC2ajjc8D4anoPJlvhAFBEQthUtBD8HbCtQFwxIa7ZhVSHqJ7d
	UQ5amAvhGHTTkWiaVUm5uQFKbChp/YHtV4LIggMuQXaMSj6Q/xNZ6baLl1dHK8PytSTbAjB2KRg
	Td5L3Z7ACeJ4PNj+BkgEIOjjJi/Mnfc2z4o9YWXzYM1PT1/v2x2gao51QWKLUrPDN9Fiyt029HU
	kaQeCbvt7Jt+g3HcUVw/WKUkQ0a67qzWoOk6c9TKbPo5gLIaKo34I4UMzSjTImzBihiCtBUFdbg
	zGn5DOQGW6MA2+tsDVbq8DGy7l
X-Google-Smtp-Source: AGHT+IGsGXqzLqVVJJYHt4xippAVVBv0/jjktPW3RfJHF4DlrDW5QOd9Km/RjmhR9kafcRgyxJbWNQ==
X-Received: by 2002:a05:600c:3593:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-477c0162f1fmr5374945e9.7.1763684459801;
        Thu, 20 Nov 2025 16:20:59 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:20:58 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 05/13] ovpn: notify userspace on client float event
Date: Fri, 21 Nov 2025 01:20:36 +0100
Message-ID: <20251121002044.16071-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Send a netlink notification when a client updates its remote UDP
endpoint. The notification includes the new IP address, port, and scope
ID (for IPv6).

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 Documentation/netlink/specs/ovpn.yaml       |  6 ++
 drivers/net/ovpn/netlink.c                  | 82 +++++++++++++++++++++
 drivers/net/ovpn/netlink.h                  |  2 +
 drivers/net/ovpn/peer.c                     |  2 +
 include/uapi/linux/ovpn.h                   |  1 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c |  3 +
 6 files changed, 96 insertions(+)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index 1b91045cee2e..0d0c028bf96f 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -502,6 +502,12 @@ operations:
             - ifindex
             - keyconf
 
+    -
+      name: peer-float-ntf
+      doc: Notification about a peer floating (changing its remote UDP endpoint)
+      notify: peer-get
+      mcgrp: peers
+
 mcast-groups:
   list:
     -
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index fed0e46b32a3..3db056f4cd0a 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1203,6 +1203,88 @@ int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
 	return ret;
 }
 
+/**
+ * ovpn_nl_float_peer_notify - notify userspace about peer floating
+ * @peer: the floated peer
+ * @ss: sockaddr representing the new remote endpoint
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
+			      const struct sockaddr_storage *ss)
+{
+	struct ovpn_socket *sock;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa;
+	struct sk_buff *msg;
+	struct nlattr *attr;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0,
+			  OVPN_CMD_PEER_FLOAT_NTF);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_IFINDEX, peer->ovpn->dev->ifindex))
+		goto err_cancel_msg;
+
+	attr = nla_nest_start(msg, OVPN_A_PEER);
+	if (!attr)
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
+		goto err_cancel_msg;
+
+	if (ss->ss_family == AF_INET) {
+		sa = (struct sockaddr_in *)ss;
+		if (nla_put_in_addr(msg, OVPN_A_PEER_REMOTE_IPV4,
+				    sa->sin_addr.s_addr) ||
+		    nla_put_net16(msg, OVPN_A_PEER_REMOTE_PORT, sa->sin_port))
+			goto err_cancel_msg;
+	} else if (ss->ss_family == AF_INET6) {
+		sa6 = (struct sockaddr_in6 *)ss;
+		if (nla_put_in6_addr(msg, OVPN_A_PEER_REMOTE_IPV6,
+				     &sa6->sin6_addr) ||
+		    nla_put_u32(msg, OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
+				sa6->sin6_scope_id) ||
+		    nla_put_net16(msg, OVPN_A_PEER_REMOTE_PORT, sa6->sin6_port))
+			goto err_cancel_msg;
+	} else {
+		ret = -EAFNOSUPPORT;
+		goto err_cancel_msg;
+	}
+
+	nla_nest_end(msg, attr);
+	genlmsg_end(msg, hdr);
+
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (!sock) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sk), msg,
+				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	return 0;
+
+err_unlock:
+	rcu_read_unlock();
+err_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+err_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 /**
  * ovpn_nl_key_swap_notify - notify userspace peer's key must be renewed
  * @peer: the peer whose key needs to be renewed
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index 8615dfc3c472..11ee7c681885 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -13,6 +13,8 @@ int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
 int ovpn_nl_peer_del_notify(struct ovpn_peer *peer);
+int ovpn_nl_peer_float_notify(struct ovpn_peer *peer,
+			      const struct sockaddr_storage *ss);
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
 
 #endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 4bfcab0c8652..9ad50f1ac2c3 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -287,6 +287,8 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 
 	spin_unlock_bh(&peer->lock);
 
+	ovpn_nl_peer_float_notify(peer, &ss);
+
 	/* rehashing is required only in MP mode as P2P has one peer
 	 * only and thus there is no hashtable
 	 */
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
index 680d1522dc87..b3c9ff0a6849 100644
--- a/include/uapi/linux/ovpn.h
+++ b/include/uapi/linux/ovpn.h
@@ -99,6 +99,7 @@ enum {
 	OVPN_CMD_KEY_SWAP,
 	OVPN_CMD_KEY_SWAP_NTF,
 	OVPN_CMD_KEY_DEL,
+	OVPN_CMD_PEER_FLOAT_NTF,
 
 	__OVPN_CMD_MAX,
 	OVPN_CMD_MAX = (__OVPN_CMD_MAX - 1)
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 0a5226196a2e..064453d16fdd 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1516,6 +1516,9 @@ static int ovpn_handle_msg(struct nl_msg *msg, void *arg)
 	case OVPN_CMD_PEER_DEL_NTF:
 		fprintf(stdout, "received CMD_PEER_DEL_NTF\n");
 		break;
+	case OVPN_CMD_PEER_FLOAT_NTF:
+		fprintf(stdout, "received CMD_PEER_FLOAT_NTF\n");
+		break;
 	case OVPN_CMD_KEY_SWAP_NTF:
 		fprintf(stdout, "received CMD_KEY_SWAP_NTF\n");
 		break;
-- 
2.51.2


