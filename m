Return-Path: <linux-kselftest+bounces-20944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F609B4778
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 11:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8957A283FF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7409D20A5CD;
	Tue, 29 Oct 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="d/H0nNFe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD679208237
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198910; cv=none; b=msZg81UnUnNRjMjh/WxzmZA6oywUFhDeWQGsdl9eVg3/Qb0s6QaNtv7A5swd1KT2bCB5fXn/LSxmJJGg4EbOuecjQrohDqmC4GWZAQrK9iar+ny9LYOcG4a3RTD0um8J01fE7Q17x3VIs9Z4kmP7ZOz8H2Kms41ZqS4ACCx+LpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198910; c=relaxed/simple;
	bh=ZWKPpKvj4FpkGCZrYx1tEpbNQub72bY0wEweopGt9Pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUQCr1t9tOXeuHoYtp9vx0D69Fv7Gdq8zM4aftm1NLsemYT3lYjgCMzG9qIZtuaLS10Zrhtw58Rg+yQbGDce02EcCuGnzDaKaaQh//T7LnEUuPEyHGr2uHiKvUy5IAAuTNXGIyeolefvfOaAYKtmu6sWkPFlIuki9slzurzuaGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=d/H0nNFe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43161c0068bso50631405e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730198902; x=1730803702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBavTcVBYPRet7QKkFHfFIOWjK99aPBV/ncvg7CqaNY=;
        b=d/H0nNFeRhF1ouTtXv716awnR1k93PhIohdk0sbNexavoPBw21LGBC+Lm6xxRw/6t8
         nD0rV0qUy4nmJ8J7NdUvcX5FW5ExZbX2wM8EWCi1/X8lvp7DkHaIFCNK3QGCc0+SC4x7
         +OtAeM+no+hY6PKlgQBUJXgUDfokzjPr/9k+dOwgDi7qyAQeIVBqqokLuWEjbiUa6sUJ
         jsRGMYhX5j65c0nPGydjDfbJi+f5L4cCtTOhkupjqhDAOo+KtgxnqNPcO/GhTUWdYxE6
         y9d7jfDiZuO95trv7teJ9gzNk03dHflnq5mNQfKpKnSpZKthqAMwU/eM2Oy2+s+/WqS2
         hYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198902; x=1730803702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBavTcVBYPRet7QKkFHfFIOWjK99aPBV/ncvg7CqaNY=;
        b=Kk2qM66L6h/q5aMZAOIKQB/9fLy+wWapQgCoeIZ6vKqb8n3I10BhcWs3wCoWt3ekfm
         W7PAZh0YgmtiWkqCtNRQxMlcc7ljm4JXn3gFn2vOV6tlW+R+8FALVWLYNXvhq/K4cvjq
         PW8k8WjPa4Xmky0pnyqCrAymDvOai5Oq0ZChbv9me9wNg1f0UGPfuMz/bSzAja2n0Vqs
         4xPWoJXZE5MzYYRSc9/uArJTXACy+ffFLMqkExlwbxphA62iyoM0wDM2wNdxFC2twReS
         EYt0LfW+4E5cTt6Rk8zB00NnV4ZRtfSgOZecbuAzkvN0dTwjNlUa/cJQxQHaXht6DyQE
         y1JA==
X-Forwarded-Encrypted: i=1; AJvYcCUSxXW4wAiQ3ljEX5xN5mLbDFN4db4qaFblAkcudxKcmLVA2OTL/xcHlpKSF7nFOHJ+cL42dPCeAdCMHqItxeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgSAUz98ol2aLFB0P03W/vb8ZUR5zmU9BnC7qexPnqEWefXt6
	l5zqFyGgPnhZB9wCBQQHkoXdGpJYDSIDxxIh+NuMVVjY54xssJ8DfHZnWOA89bM=
X-Google-Smtp-Source: AGHT+IGn+04vUDSxtIgJrWoiG/OeCFrCSvCltOb02RNMPW7ARWZ7HGyWUYItumL/NT8gmIbL62MYtQ==
X-Received: by 2002:a05:600c:3c8c:b0:431:251a:9dc9 with SMTP id 5b1f17b1804b1-4319ad166femr96047515e9.25.1730198901799;
        Tue, 29 Oct 2024 03:48:21 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3dcf:a6cb:47af:d9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm141124785e9.0.2024.10.29.03.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:48:21 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 29 Oct 2024 11:47:31 +0100
Subject: [PATCH net-next v11 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=22439; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=ZWKPpKvj4FpkGCZrYx1tEpbNQub72bY0wEweopGt9Pg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnIL1sfXkR8HWTCeWVRngV2YZwvlr0GzPHCc8/T
 XH2j7C1iPeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZyC9bAAKCRALcOU6oDjV
 h6cLB/0R9GT9iNv+CgOuuEtIHKGmFJJ+BRWRIpT7vqNkIT1YtWwFKNRraNDY87CQ/in7vVdSxAB
 lypgPnMPdxodKY1u9AfhzJlSg9GJsS0vMF717LR7y+5kFZDo5uorgqXk4fOW2xdqNNJYftNFbpx
 04AZLFEhlCJUsJnJQfUzQRCeKvuI+AmFiTfxOfGiM2B5RcCItk+CKfnH7Yh/3ju3K67CkrK+4LJ
 XFJoTjmcfLvB9sHPr/W5X5A9EV6SJVTQ+106RAnkxD4DwyeFIXCA7Kg56F9Vzk4kbSo0JeHn/AQ
 JBp0wNTlrRmdAXAC8OAEMK2U4kLrIsXKi+4Zt2ede3hKxQFE
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This change introduces the netlink command needed to add, delete and
retrieve/dump known peers. Userspace is expected to use these commands
to handle known peer lifecycles.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 578 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.c    |  48 ++--
 drivers/net/ovpn/peer.h    |   5 +
 3 files changed, 609 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 2cc34eb1d1d870c6705714cb971c3c5dfb04afda..d504445325ef82db04f87367c858adaf025f6297 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/types.h>
 #include <net/genetlink.h>
 
 #include <uapi/linux/ovpn.h>
@@ -16,6 +17,10 @@
 #include "io.h"
 #include "netlink.h"
 #include "netlink-gen.h"
+#include "bind.h"
+#include "packet.h"
+#include "peer.h"
+#include "socket.h"
 
 MODULE_ALIAS_GENL_FAMILY(OVPN_FAMILY_NAME);
 
@@ -86,29 +91,592 @@ void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		netdev_put(ovpn->dev, &ovpn->dev_tracker);
 }
 
+static int ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
+					struct sockaddr_storage *ss)
+{
+	struct sockaddr_in6 *sin6;
+	struct sockaddr_in *sin;
+	struct in6_addr *in6;
+	__be16 port = 0;
+	__be32 *in;
+	int af;
+
+	ss->ss_family = AF_UNSPEC;
+
+	if (attrs[OVPN_A_PEER_REMOTE_PORT])
+		port = nla_get_be16(attrs[OVPN_A_PEER_REMOTE_PORT]);
+
+	if (attrs[OVPN_A_PEER_REMOTE_IPV4]) {
+		af = AF_INET;
+		ss->ss_family = AF_INET;
+		in = nla_data(attrs[OVPN_A_PEER_REMOTE_IPV4]);
+	} else if (attrs[OVPN_A_PEER_REMOTE_IPV6]) {
+		af = AF_INET6;
+		ss->ss_family = AF_INET6;
+		in6 = nla_data(attrs[OVPN_A_PEER_REMOTE_IPV6]);
+	} else {
+		return AF_UNSPEC;
+	}
+
+	switch (ss->ss_family) {
+	case AF_INET6:
+		/* If this is a regular IPv6 just break and move on,
+		 * otherwise switch to AF_INET and extract the IPv4 accordingly
+		 */
+		if (!ipv6_addr_v4mapped(in6)) {
+			sin6 = (struct sockaddr_in6 *)ss;
+			sin6->sin6_port = port;
+			memcpy(&sin6->sin6_addr, in6, sizeof(*in6));
+			break;
+		}
+
+		/* v4-mapped-v6 address */
+		ss->ss_family = AF_INET;
+		in = &in6->s6_addr32[3];
+		fallthrough;
+	case AF_INET:
+		sin = (struct sockaddr_in *)ss;
+		sin->sin_port = port;
+		sin->sin_addr.s_addr = *in;
+		break;
+	}
+
+	/* don't return ss->ss_family as it may have changed in case of
+	 * v4-mapped-v6 address
+	 */
+	return af;
+}
+
+static u8 *ovpn_nl_attr_local_ip(struct nlattr **attrs)
+{
+	u8 *addr6;
+
+	if (!attrs[OVPN_A_PEER_LOCAL_IPV4] && !attrs[OVPN_A_PEER_LOCAL_IPV6])
+		return NULL;
+
+	if (attrs[OVPN_A_PEER_LOCAL_IPV4])
+		return nla_data(attrs[OVPN_A_PEER_LOCAL_IPV4]);
+
+	addr6 = nla_data(attrs[OVPN_A_PEER_LOCAL_IPV6]);
+	/* this is an IPv4-mapped IPv6 address, therefore extract the actual
+	 * v4 address from the last 4 bytes
+	 */
+	if (ipv6_addr_v4mapped((struct in6_addr *)addr6))
+		return addr6 + 12;
+
+	return addr6;
+}
+
+static int ovpn_nl_peer_precheck(struct ovpn_struct *ovpn,
+				 struct genl_info *info,
+				 struct nlattr **attrs)
+{
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
+			      OVPN_A_PEER_ID))
+		return -EINVAL;
+
+	if (attrs[OVPN_A_PEER_REMOTE_IPV4] && attrs[OVPN_A_PEER_REMOTE_IPV6]) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "cannot specify both remote IPv4 or IPv6 address");
+		return -EINVAL;
+	}
+
+	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
+	    !attrs[OVPN_A_PEER_REMOTE_IPV6] && attrs[OVPN_A_PEER_REMOTE_PORT]) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "cannot specify remote port without IP address");
+		return -EINVAL;
+	}
+
+	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
+	    attrs[OVPN_A_PEER_LOCAL_IPV4]) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "cannot specify local IPv4 address without remote");
+		return -EINVAL;
+	}
+
+	if (!attrs[OVPN_A_PEER_REMOTE_IPV6] &&
+	    attrs[OVPN_A_PEER_LOCAL_IPV6]) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "cannot specify local IPV6 address without remote");
+		return -EINVAL;
+	}
+
+	if (!attrs[OVPN_A_PEER_REMOTE_IPV6] &&
+	    attrs[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID]) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "cannot specify scope id without remote IPv6 address");
+		return -EINVAL;
+	}
+
+	/* VPN IPs are needed only in MP mode for selecting the right peer */
+	if (ovpn->mode == OVPN_MODE_P2P && (attrs[OVPN_A_PEER_VPN_IPV4] ||
+					    attrs[OVPN_A_PEER_VPN_IPV6])) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "VPN IP unexpected in P2P mode");
+		return -EINVAL;
+	}
+
+	if ((attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
+	     !attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) ||
+	    (!attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
+	     attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT])) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "keepalive interval and timeout are required together");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * ovpn_nl_peer_modify - modify the peer attributes according to the incoming msg
+ * @peer: the peer to modify
+ * @info: generic netlink info from the user request
+ * @attrs: the attributes from the user request
+ *
+ * Return: a negative error code in case of failure, 0 on success or 1 on
+ *	   success and the VPN IPs have been modified (requires rehashing in MP
+ *	   mode)
+ */
+static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
+			       struct nlattr **attrs)
+{
+	struct sockaddr_storage ss = {};
+	u32 sockfd, interv, timeout;
+	struct socket *sock = NULL;
+	u8 *local_ip = NULL;
+	bool rehash = false;
+	int ret;
+
+	if (attrs[OVPN_A_PEER_SOCKET]) {
+		/* lookup the fd in the kernel table and extract the socket
+		 * object
+		 */
+		sockfd = nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
+		/* sockfd_lookup() increases sock's refcounter */
+		sock = sockfd_lookup(sockfd, &ret);
+		if (!sock) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "cannot lookup peer socket (fd=%u): %d",
+					       sockfd, ret);
+			return -ENOTSOCK;
+		}
+
+		/* Only when using UDP as transport protocol the remote endpoint
+		 * can be configured so that ovpn knows where to send packets
+		 * to.
+		 *
+		 * In case of TCP, the socket is connected to the peer and ovpn
+		 * will just send bytes over it, without the need to specify a
+		 * destination.
+		 */
+		if (sock->sk->sk_protocol != IPPROTO_UDP &&
+		    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
+		     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "unexpected remote IP address for non UDP socket");
+			sockfd_put(sock);
+			return -EINVAL;
+		}
+
+		if (peer->sock)
+			ovpn_socket_put(peer->sock);
+
+		peer->sock = ovpn_socket_new(sock, peer);
+		if (IS_ERR(peer->sock)) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "cannot encapsulate socket: %ld",
+					       PTR_ERR(peer->sock));
+			sockfd_put(sock);
+			peer->sock = NULL;
+			return -ENOTSOCK;
+		}
+	}
+
+	if (ovpn_nl_attr_sockaddr_remote(attrs, &ss) != AF_UNSPEC) {
+		/* we carry the local IP in a generic container.
+		 * ovpn_peer_reset_sockaddr() will properly interpret it
+		 * based on ss.ss_family
+		 */
+		local_ip = ovpn_nl_attr_local_ip(attrs);
+
+		spin_lock_bh(&peer->lock);
+		/* set peer sockaddr */
+		ret = ovpn_peer_reset_sockaddr(peer, &ss, local_ip);
+		if (ret < 0) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "cannot set peer sockaddr: %d",
+					       ret);
+			spin_unlock_bh(&peer->lock);
+			return ret;
+		}
+		spin_unlock_bh(&peer->lock);
+	}
+
+	if (attrs[OVPN_A_PEER_VPN_IPV4]) {
+		rehash = true;
+		peer->vpn_addrs.ipv4.s_addr =
+			nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
+	}
+
+	if (attrs[OVPN_A_PEER_VPN_IPV6]) {
+		rehash = true;
+		peer->vpn_addrs.ipv6 =
+			nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
+	}
+
+	/* when setting the keepalive, both parameters have to be configured */
+	if (attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
+	    attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) {
+		interv = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]);
+		timeout = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
+		ovpn_peer_keepalive_set(peer, interv, timeout);
+	}
+
+	netdev_dbg(peer->ovpn->dev,
+		   "%s: peer id=%u endpoint=%pIScp/%s VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
+		   __func__, peer->id, &ss,
+		   peer->sock->sock->sk->sk_prot_creator->name,
+		   &peer->vpn_addrs.ipv4.s_addr, &peer->vpn_addrs.ipv6);
+
+	return rehash ? 1 : 0;
+}
+
 int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
+			       ovpn_peer_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	ret = ovpn_nl_peer_precheck(ovpn, info, attrs);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
+			      OVPN_A_PEER_SOCKET))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+	peer = ovpn_peer_new(ovpn, peer_id);
+	if (IS_ERR(peer)) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot create new peer object for peer %u: %ld",
+				       peer_id, PTR_ERR(peer));
+		return PTR_ERR(peer);
+	}
+
+	ret = ovpn_nl_peer_modify(peer, info, attrs);
+	if (ret < 0)
+		goto peer_release;
+
+	ret = ovpn_peer_add(ovpn, peer);
+	if (ret < 0) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot add new peer (id=%u) to hashtable: %d\n",
+				       peer->id, ret);
+		goto peer_release;
+	}
+
+	return 0;
+
+peer_release:
+	/* release right away because peer is not used in any context */
+	ovpn_peer_release(peer);
+
+	return ret;
 }
 
 int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
+			       ovpn_peer_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	ret = ovpn_nl_peer_precheck(ovpn, info, attrs);
+	if (ret < 0)
+		return ret;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer)
+		return -ENOENT;
+
+	ret = ovpn_nl_peer_modify(peer, info, attrs);
+	if (ret < 0) {
+		ovpn_peer_put(peer);
+		return ret;
+	}
+
+	/* ret == 1 means that VPN IPv4/6 has been modified and rehashing
+	 * is required
+	 */
+	if (ret > 0) {
+		spin_lock_bh(&ovpn->peers->lock);
+		ovpn_peer_hash_vpn_ip(peer);
+		spin_unlock_bh(&ovpn->peers->lock);
+	}
+
+	ovpn_peer_put(peer);
+
+	return 0;
+}
+
+static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
+			     const struct ovpn_peer *peer, u32 portid, u32 seq,
+			     int flags)
+{
+	const struct ovpn_bind *bind;
+	struct nlattr *attr;
+	void *hdr;
+
+	hdr = genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags,
+			  OVPN_CMD_PEER_GET);
+	if (!hdr)
+		return -ENOBUFS;
+
+	attr = nla_nest_start(skb, OVPN_A_PEER);
+	if (!attr)
+		goto err;
+
+	if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
+		goto err;
+
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY))
+		if (nla_put_in_addr(skb, OVPN_A_PEER_VPN_IPV4,
+				    peer->vpn_addrs.ipv4.s_addr))
+			goto err;
+
+	if (!ipv6_addr_equal(&peer->vpn_addrs.ipv6, &in6addr_any))
+		if (nla_put_in6_addr(skb, OVPN_A_PEER_VPN_IPV6,
+				     &peer->vpn_addrs.ipv6))
+			goto err;
+
+	if (nla_put_u32(skb, OVPN_A_PEER_KEEPALIVE_INTERVAL,
+			peer->keepalive_interval) ||
+	    nla_put_u32(skb, OVPN_A_PEER_KEEPALIVE_TIMEOUT,
+			peer->keepalive_timeout))
+		goto err;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (bind) {
+		if (bind->remote.in4.sin_family == AF_INET) {
+			if (nla_put_in_addr(skb, OVPN_A_PEER_REMOTE_IPV4,
+					    bind->remote.in4.sin_addr.s_addr) ||
+			    nla_put_net16(skb, OVPN_A_PEER_REMOTE_PORT,
+					  bind->remote.in4.sin_port) ||
+			    nla_put_in_addr(skb, OVPN_A_PEER_LOCAL_IPV4,
+					    bind->local.ipv4.s_addr))
+				goto err_unlock;
+		} else if (bind->remote.in4.sin_family == AF_INET6) {
+			if (nla_put_in6_addr(skb, OVPN_A_PEER_REMOTE_IPV6,
+					     &bind->remote.in6.sin6_addr) ||
+			    nla_put_u32(skb, OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
+					bind->remote.in6.sin6_scope_id) ||
+			    nla_put_net16(skb, OVPN_A_PEER_REMOTE_PORT,
+					  bind->remote.in6.sin6_port) ||
+			    nla_put_in6_addr(skb, OVPN_A_PEER_LOCAL_IPV6,
+					     &bind->local.ipv6))
+				goto err_unlock;
+		}
+	}
+	rcu_read_unlock();
+
+	if (nla_put_net16(skb, OVPN_A_PEER_LOCAL_PORT,
+			  inet_sk(peer->sock->sock->sk)->inet_sport) ||
+	    /* VPN RX stats */
+	    nla_put_uint(skb, OVPN_A_PEER_VPN_RX_BYTES,
+			 atomic64_read(&peer->vpn_stats.rx.bytes)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_VPN_RX_PACKETS,
+			 atomic64_read(&peer->vpn_stats.rx.packets)) ||
+	    /* VPN TX stats */
+	    nla_put_uint(skb, OVPN_A_PEER_VPN_TX_BYTES,
+			 atomic64_read(&peer->vpn_stats.tx.bytes)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_VPN_TX_PACKETS,
+			 atomic64_read(&peer->vpn_stats.tx.packets)) ||
+	    /* link RX stats */
+	    nla_put_uint(skb, OVPN_A_PEER_LINK_RX_BYTES,
+			 atomic64_read(&peer->link_stats.rx.bytes)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_LINK_RX_PACKETS,
+			 atomic64_read(&peer->link_stats.rx.packets)) ||
+	    /* link TX stats */
+	    nla_put_uint(skb, OVPN_A_PEER_LINK_TX_BYTES,
+			 atomic64_read(&peer->link_stats.tx.bytes)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_LINK_TX_PACKETS,
+			 atomic64_read(&peer->link_stats.tx.packets)))
+		goto err;
+
+	nla_nest_end(skb, attr);
+	genlmsg_end(skb, hdr);
+
+	return 0;
+err_unlock:
+	rcu_read_unlock();
+err:
+	genlmsg_cancel(skb, hdr);
+	return -EMSGSIZE;
 }
 
 int ovpn_nl_peer_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct ovpn_peer *peer;
+	struct sk_buff *msg;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
+			       ovpn_peer_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
+			      OVPN_A_PEER_ID))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot find peer with id %u", peer_id);
+		return -ENOENT;
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = ovpn_nl_send_peer(msg, info, peer, info->snd_portid,
+				info->snd_seq, 0);
+	if (ret < 0) {
+		nlmsg_free(msg);
+		goto err;
+	}
+
+	ret = genlmsg_reply(msg, info);
+err:
+	ovpn_peer_put(peer);
+	return ret;
 }
 
 int ovpn_nl_peer_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	const struct genl_info *info = genl_info_dump(cb);
+	int bkt, last_idx = cb->args[1], dumped = 0;
+	struct ovpn_struct *ovpn;
+	struct ovpn_peer *peer;
+
+	ovpn = ovpn_get_dev_from_attrs(sock_net(cb->skb->sk), info);
+	if (IS_ERR(ovpn))
+		return PTR_ERR(ovpn);
+
+	if (ovpn->mode == OVPN_MODE_P2P) {
+		/* if we already dumped a peer it means we are done */
+		if (last_idx)
+			goto out;
+
+		rcu_read_lock();
+		peer = rcu_dereference(ovpn->peer);
+		if (peer) {
+			if (ovpn_nl_send_peer(skb, info, peer,
+					      NETLINK_CB(cb->skb).portid,
+					      cb->nlh->nlmsg_seq,
+					      NLM_F_MULTI) == 0)
+				dumped++;
+		}
+		rcu_read_unlock();
+	} else {
+		rcu_read_lock();
+		hash_for_each_rcu(ovpn->peers->by_id, bkt, peer,
+				  hash_entry_id) {
+			/* skip already dumped peers that were dumped by
+			 * previous invocations
+			 */
+			if (last_idx > 0) {
+				last_idx--;
+				continue;
+			}
+
+			if (ovpn_nl_send_peer(skb, info, peer,
+					      NETLINK_CB(cb->skb).portid,
+					      cb->nlh->nlmsg_seq,
+					      NLM_F_MULTI) < 0)
+				break;
+
+			/* count peers being dumped during this invocation */
+			dumped++;
+		}
+		rcu_read_unlock();
+	}
+
+out:
+	netdev_put(ovpn->dev, &ovpn->dev_tracker);
+
+	/* sum up peers dumped in this message, so that at the next invocation
+	 * we can continue from where we left
+	 */
+	cb->args[1] += dumped;
+	return skb->len;
 }
 
 int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
+			       ovpn_peer_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
+			      OVPN_A_PEER_ID))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer)
+		return -ENOENT;
+
+	netdev_dbg(ovpn->dev, "%s: peer id=%u\n", __func__, peer->id);
+	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
+	ovpn_peer_put(peer);
+
+	return ret;
 }
 
 int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index da6215bbb643592e4567e61e4b4976d367ed109c..8cfe1997ec116ae4fe74cd7105d228569e2a66a9 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -102,9 +102,9 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
  *
  * Return: 0 on success or a negative error code otherwise
  */
-static int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
-				    const struct sockaddr_storage *ss,
-				    const u8 *local_ip)
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+			     const struct sockaddr_storage *ss,
+			     const u8 *local_ip)
 	__must_hold(&peer->lock)
 {
 	struct ovpn_bind *bind;
@@ -219,7 +219,7 @@ void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
 	rcu_read_unlock();
 }
 
-static void ovpn_peer_release(struct ovpn_peer *peer)
+void ovpn_peer_release(struct ovpn_peer *peer)
 {
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
@@ -763,6 +763,32 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 	return match;
 }
 
+void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
+	__must_hold(&peer->ovpn->peers->lock)
+{
+	struct hlist_nulls_head *nhead;
+
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
+		/* remove potential old hashing */
+		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+
+		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr,
+					   &peer->vpn_addrs.ipv4,
+					   sizeof(peer->vpn_addrs.ipv4));
+		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
+	}
+
+	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
+		/* remove potential old hashing */
+		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+
+		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr,
+					   &peer->vpn_addrs.ipv6,
+					   sizeof(peer->vpn_addrs.ipv6));
+		hlist_nulls_add_head_rcu(&peer->hash_entry_addr6, nhead);
+	}
+}
+
 /**
  * ovpn_peer_add_mp - add peer to related tables in a MP instance
  * @ovpn: the instance to add the peer to
@@ -824,19 +850,7 @@ static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 			   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
 					      sizeof(peer->id)));
 
-	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
-		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr,
-					   &peer->vpn_addrs.ipv4,
-					   sizeof(peer->vpn_addrs.ipv4));
-		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
-	}
-
-	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
-		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr,
-					   &peer->vpn_addrs.ipv6,
-					   sizeof(peer->vpn_addrs.ipv6));
-		hlist_nulls_add_head_rcu(&peer->hash_entry_addr6, nhead);
-	}
+	ovpn_peer_hash_vpn_ip(peer);
 out:
 	spin_unlock_bh(&ovpn->peers->lock);
 	return ret;
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 940cea5372ec0375cfe3e673154a1e0248978409..1adecd0f79f8f4a202110543223fc448c09e5175 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -124,6 +124,7 @@ static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
 	return kref_get_unless_zero(&peer->refcount);
 }
 
+void ovpn_peer_release(struct ovpn_peer *peer);
 void ovpn_peer_release_kref(struct kref *kref);
 
 /**
@@ -146,6 +147,7 @@ struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id);
 struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
 				       struct sk_buff *skb);
+void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer);
 bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
 
@@ -156,5 +158,8 @@ void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
 				     struct sk_buff *skb);
 
 void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb);
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+			     const struct sockaddr_storage *ss,
+			     const u8 *local_ip);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


