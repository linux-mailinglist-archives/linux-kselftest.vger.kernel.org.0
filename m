Return-Path: <linux-kselftest+bounces-27695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C60A47137
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 02:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE185172257
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 01:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50818202C4C;
	Thu, 27 Feb 2025 01:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="hWB0Ca4F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697341EB194
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619396; cv=none; b=HuZac3OFqhu8ufQv4P9jL4Wm5mljraGiYhiFkQJ4TR+KZUQBOi0XkIDz+pizC8CvijwdFAYJAKqr6AzAbkwiSZt37pSJ+J/fegvQyjbG9By4l/6jxGMMZ8yk9OigxX7UKy4V0euVCVaPqYnf+aF7htHzAKRyTwuGmW59t2uJyzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619396; c=relaxed/simple;
	bh=LH1vLLwrj4jJawePk5UOfUWyZxVvDZa88a9L/NM43VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NrEeak+62NjrnhhaTQbVDMHGqUp9V3EfiVt89/PtbWBR1+q0hmNhdpnRGd4kbTCzhhm0lAbtrmqYBRMfe8Npu7OtJyZ9fBGkjCy5nl56lfRRFu56cYg5yljcDv7A2CWS0Jx3jjol6+TZzXnoL61AlbkbScKw+4d4eKG/1OytFq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=hWB0Ca4F; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so3860255e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 17:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619390; x=1741224190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/POobfrYACbO+qsCjQLn5NEOyIIoU1m1J7XVE0Dxxr0=;
        b=hWB0Ca4FWuM5oAk/pv6vq8FBC6wkhVlW0riJpE5fySJfcElvKmoQ+Sfi4Fd+gAikVl
         SScDBWJ+WVPy5XEfbCnEU5YLRdAsBMtnui5gMkHB0u40GkpeXcvYCAP/J9Y4hwp/Itpj
         zN+kuF0qqwiKdgB3771kNW+JMplANO8cLrfhU2ymctoODDGMD3HoCVOzjrWIKto92j9h
         DWWduclc5NGJXv8KxNKEeVWMlvSPy+N9TqOkO/V91yP9BqNGbGCZY2mFZX0UPx+88Jvc
         WCEnHhbPqTpP1mCOrdDaFuB6mYlH09pYH7n+kXsG2Pe4dVM4WCynSD6pGIJEqulWxBaw
         DVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619390; x=1741224190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/POobfrYACbO+qsCjQLn5NEOyIIoU1m1J7XVE0Dxxr0=;
        b=CanR4+ynAERXzCuqXbOHXOyuN21JBCarkdJWu+r6hTC/XKnLdFztd2ySSf8ZESzPAa
         lUPGgotFd2Sd5tllinPwYf8UByatz5E8D4ULYXznPHuvCDS7qX6S49L/H0JWBqb2opZ0
         zaf7C/lfPueKR40MVl3ftVgJk3LJIKYtGbNwdCByiCFgLFJEgPrkNX5+aA41s143mKae
         NRGIFVagOvqtz1oBv8uSUyCucYEXtt/rOkfUNmQTH5VUas6zhdduPFo4ksn5sPk5e95k
         0dAV4qycg+A/ezUC92IOIlvuX/dBGDuhYPQxCFOVzRkdYatBu61Dg38i0T5uyaX3NtzA
         MqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVs+k/SoWdd7ca43KODWMP/hB+HKYqWjLKHrWOSj2tg9yy8IWcn9KT73hndPB5QZ2jNbqdUr+BMQzCBKqu5FM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Xqi5ldxpBZuyQDRnojr5wuyHG3gughAmxsB4ZgPpwHRDW0gI
	zw3cAXOnDkeTrYEZm1ex2uR2RZFg4jBamdpVL1rBXRrslIDEtpWFZjpWUL3oFi4=
X-Gm-Gg: ASbGncsXTShFC2kcMetMF55UFGtnG/DVBgWp1C1AhvdledJ3aHQPrwPP9OR20IG//8U
	W4vmAY4o5LhRzIkq23b7a2XW9jpmwMZL3x4zdxnfjFhaYr6n+UGx6ofrAtpyRwdcDDlrCRNOmxV
	Ru8DynNSDwLOCkn/pH653NNgiaXVAGCJZlhb3zzgO+dIVUpfqEWikCTeMhbb5mQoiN7nhE9IWIb
	WKBzKFfx6B5iMBQd9zyyGDhlJkBJwmbG0EaYdM6f+wNOPsC0XHTofzKuHtyIu3He2aNRkIo3yKr
	BSq7oLh8R0qcdqBMBcpSRCa9kOj7CqdvVTn81Q==
X-Google-Smtp-Source: AGHT+IFaCjNf7K/gYrB5Mt+s7vjTSV/6I8ufYNlOQ1vJG4qujUIcS7FDMHPG+sgWLvA9KSqehgf7fw==
X-Received: by 2002:a05:600c:3589:b0:439:6925:4d42 with SMTP id 5b1f17b1804b1-43ab8fd20bfmr48395185e9.5.1740619389654;
        Wed, 26 Feb 2025 17:23:09 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:23:09 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:45 +0100
Subject: [PATCH net-next v20 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-20-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=27159; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=LH1vLLwrj4jJawePk5UOfUWyZxVvDZa88a9L/NM43VI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75hZFJHEmtugzE97gkFoThFw+c5GVz6QWN2G
 jgWRA8OHDyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++YQAKCRALcOU6oDjV
 h5FiB/9hsYQqfBLuA2cWCTEakLEf0REUZqyHaLUkriHAyURX39+iH5E8CFJFloWd+8yWJe2tMW6
 7phUhDYtRBHomk7ue2b7sQBkoxND8YIeFykiLNmWjwGnw1ejJB9sTxUfZSwU8x6kXu7AL+2yf1p
 QFydEIPiPGZFayqaI768uTsG5+UT7ohEJMIi4YgF6LcYgsYj/wA+w5p9pXvnR23sdTTQrV1WMW2
 OjsA67t7VgG+bxwi+jpyBcfDyq18GQhj1T1CFgNkxpZvraaVICWqhinYsjhDA4CHWHxGoYJK/+C
 4aGRo/rKheeeNFZk2vYLALxcfXz8T3C2dMjPIdYgGj688e2i
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This change introduces the netlink command needed to add, delete and
retrieve/dump known peers. Userspace is expected to use these commands
to handle known peer lifecycles.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 677 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.c    |  60 ++--
 drivers/net/ovpn/peer.h    |   5 +
 drivers/net/ovpn/socket.c  |   4 +-
 4 files changed, 720 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 8d267d4c82283d9b5f989478102086ce385195d5..f7558aa52a53e81b4a8245b214d70864ff608399 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/types.h>
 #include <net/genetlink.h>
 
 #include <uapi/linux/ovpn.h>
@@ -15,6 +16,9 @@
 #include "main.h"
 #include "netlink.h"
 #include "netlink-gen.h"
+#include "bind.h"
+#include "peer.h"
+#include "socket.h"
 
 MODULE_ALIAS_GENL_FAMILY(OVPN_FAMILY_NAME);
 
@@ -89,29 +93,692 @@ void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		netdev_put(ovpn->dev, tracker);
 }
 
+static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
+					 struct sockaddr_storage *ss)
+{
+	struct sockaddr_in6 *sin6;
+	struct sockaddr_in *sin;
+	struct in6_addr *in6;
+	__be16 port = 0;
+	__be32 *in;
+
+	ss->ss_family = AF_UNSPEC;
+
+	if (attrs[OVPN_A_PEER_REMOTE_PORT])
+		port = nla_get_be16(attrs[OVPN_A_PEER_REMOTE_PORT]);
+
+	if (attrs[OVPN_A_PEER_REMOTE_IPV4]) {
+		ss->ss_family = AF_INET;
+		in = nla_data(attrs[OVPN_A_PEER_REMOTE_IPV4]);
+	} else if (attrs[OVPN_A_PEER_REMOTE_IPV6]) {
+		ss->ss_family = AF_INET6;
+		in6 = nla_data(attrs[OVPN_A_PEER_REMOTE_IPV6]);
+	} else {
+		return false;
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
+	return true;
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
+static sa_family_t ovpn_nl_family_get(struct nlattr *addr4,
+				      struct nlattr *addr6)
+{
+	if (addr4)
+		return AF_INET;
+
+	if (addr6) {
+		if (ipv6_addr_v4mapped((struct in6_addr *)nla_data(addr6)))
+			return AF_INET;
+		return AF_INET6;
+	}
+
+	return AF_UNSPEC;
+}
+
+static int ovpn_nl_peer_precheck(struct ovpn_priv *ovpn,
+				 struct genl_info *info,
+				 struct nlattr **attrs)
+{
+	sa_family_t local_fam, remote_fam;
+
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
+	/* check that local and remote address families are the same even
+	 * after parsing v4mapped IPv6 addresses.
+	 * (if addresses are not provided, family will be AF_UNSPEC and
+	 * the check is skipped)
+	 */
+	local_fam = ovpn_nl_family_get(attrs[OVPN_A_PEER_LOCAL_IPV4],
+				       attrs[OVPN_A_PEER_LOCAL_IPV6]);
+	remote_fam = ovpn_nl_family_get(attrs[OVPN_A_PEER_REMOTE_IPV4],
+					attrs[OVPN_A_PEER_REMOTE_IPV6]);
+	if (local_fam != AF_UNSPEC && remote_fam != AF_UNSPEC &&
+	    local_fam != remote_fam) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "mismatching local and remote address families");
+		return -EINVAL;
+	}
+
+	if (remote_fam != AF_INET6 && attrs[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID]) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "cannot specify scope id without remote IPv6 address");
+		return -EINVAL;
+	}
+
+	/* VPN IPs are needed only in MP mode for selecting the right peer */
+	if (ovpn->mode == OVPN_MODE_P2P && (attrs[OVPN_A_PEER_VPN_IPV4] ||
+					    attrs[OVPN_A_PEER_VPN_IPV6])) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "unexpected VPN IP in P2P mode");
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
+	u32 interv, timeout;
+	u8 *local_ip = NULL;
+	bool rehash = false;
+	int ret;
+
+	spin_lock_bh(&peer->lock);
+
+	if (ovpn_nl_attr_sockaddr_remote(attrs, &ss)) {
+		/* we carry the local IP in a generic container.
+		 * ovpn_peer_reset_sockaddr() will properly interpret it
+		 * based on ss.ss_family
+		 */
+		local_ip = ovpn_nl_attr_local_ip(attrs);
+
+		/* set peer sockaddr */
+		ret = ovpn_peer_reset_sockaddr(peer, &ss, local_ip);
+		if (ret < 0) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "cannot set peer sockaddr: %d",
+					       ret);
+			goto err_unlock;
+		}
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
+		   "modify peer id=%u endpoint=%pIScp VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
+		   peer->id, &ss,
+		   &peer->vpn_addrs.ipv4.s_addr, &peer->vpn_addrs.ipv6);
+
+	spin_unlock_bh(&peer->lock);
+
+	return rehash ? 1 : 0;
+err_unlock:
+	spin_unlock_bh(&peer->lock);
+	return ret;
+}
+
 int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct ovpn_socket *ovpn_sock;
+	struct socket *sock = NULL;
+	struct ovpn_peer *peer;
+	u32 sockfd, peer_id;
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
+	/* in MP mode VPN IPs are required for selecting the right peer */
+	if (ovpn->mode == OVPN_MODE_MP && !attrs[OVPN_A_PEER_VPN_IPV4] &&
+	    !attrs[OVPN_A_PEER_VPN_IPV6]) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "VPN IP must be provided in MP mode");
+		return -EINVAL;
+	}
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
+	/* lookup the fd in the kernel table and extract the socket object */
+	sockfd = nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
+	/* sockfd_lookup() increases sock's refcounter */
+	sock = sockfd_lookup(sockfd, &ret);
+	if (!sock) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot lookup peer socket (fd=%u): %d",
+				       sockfd, ret);
+		ret = -ENOTSOCK;
+		goto peer_release;
+	}
+
+	/* Only when using UDP as transport protocol the remote endpoint
+	 * can be configured so that ovpn knows where to send packets to.
+	 */
+	if (sock->sk->sk_protocol == IPPROTO_UDP &&
+	    !attrs[OVPN_A_PEER_REMOTE_IPV4] &&
+	    !attrs[OVPN_A_PEER_REMOTE_IPV6]) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "missing remote IP address for UDP socket");
+		sockfd_put(sock);
+		ret = -EINVAL;
+		goto peer_release;
+	}
+
+	/* In case of TCP, the socket is connected to the peer and ovpn
+	 * will just send bytes over it, without the need to specify a
+	 * destination.
+	 */
+	if (sock->sk->sk_protocol == IPPROTO_TCP &&
+	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
+	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "unexpected remote IP address with TCP socket");
+		sockfd_put(sock);
+		ret = -EINVAL;
+		goto peer_release;
+	}
+
+	ovpn_sock = ovpn_socket_new(sock, peer);
+	/* at this point we unconditionally drop the reference to the socket:
+	 * - in case of error, the socket has to be dropped
+	 * - if case of success, the socket is configured and let
+	 *   userspace own the reference, so that the latter can
+	 *   trigger the final close()
+	 */
+	sockfd_put(sock);
+	if (IS_ERR(ovpn_sock)) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot encapsulate socket: %ld",
+				       PTR_ERR(ovpn_sock));
+		ret = -ENOTSOCK;
+		goto peer_release;
+	}
+
+	rcu_assign_pointer(peer->sock, ovpn_sock);
+
+	ret = ovpn_nl_peer_modify(peer, info, attrs);
+	if (ret < 0)
+		goto sock_release;
+
+	ret = ovpn_peer_add(ovpn, peer);
+	if (ret < 0) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot add new peer (id=%u) to hashtable: %d\n",
+				       peer->id, ret);
+		goto sock_release;
+	}
+
+	return 0;
+
+sock_release:
+	ovpn_socket_release(peer);
+peer_release:
+	/* release right away because peer was not yet hashed, thus it is not
+	 * used in any context
+	 */
+	ovpn_peer_release(peer);
+
+	return ret;
 }
 
 int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct ovpn_socket *sock;
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
+	if (attrs[OVPN_A_PEER_SOCKET]) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "socket cannot be modified");
+		return -EINVAL;
+	}
+
+	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot find peer with id %u", peer_id);
+		return -ENOENT;
+	}
+
+	/* when using a TCP socket the remote IP is not expected */
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (sock && sock->sock->sk->sk_protocol == IPPROTO_TCP &&
+	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
+	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
+		rcu_read_unlock();
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "unexpected remote IP address with TCP socket");
+		ovpn_peer_put(peer);
+		return -EINVAL;
+	}
+	rcu_read_unlock();
+
+	spin_lock_bh(&ovpn->lock);
+	ret = ovpn_nl_peer_modify(peer, info, attrs);
+	if (ret < 0) {
+		spin_unlock_bh(&ovpn->lock);
+		ovpn_peer_put(peer);
+		return ret;
+	}
+
+	/* ret == 1 means that VPN IPv4/6 has been modified and rehashing
+	 * is required
+	 */
+	if (ret > 0)
+		ovpn_peer_hash_vpn_ip(peer);
+	spin_unlock_bh(&ovpn->lock);
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
+	struct ovpn_socket *sock;
+	int ret = -EMSGSIZE;
+	struct nlattr *attr;
+	__be16 local_port;
+	void *hdr;
+	int id;
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
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (!sock) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
+	if (!net_eq(genl_info_net(info), sock_net(sock->sock->sk))) {
+		id = peernet2id_alloc(genl_info_net(info),
+				      sock_net(sock->sock->sk),
+				      GFP_ATOMIC);
+		if (nla_put_s32(skb, OVPN_A_PEER_SOCKET_NETNSID, id))
+			goto err_unlock;
+	}
+	local_port = inet_sk(sock->sock->sk)->inet_sport;
+	rcu_read_unlock();
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
+	if (nla_put_net16(skb, OVPN_A_PEER_LOCAL_PORT, local_port) ||
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
+	return ret;
 }
 
 int ovpn_nl_peer_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_priv *ovpn = info->user_ptr[0];
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
+	netdevice_tracker tracker;
+	struct ovpn_priv *ovpn;
+	struct ovpn_peer *peer;
+
+	ovpn = ovpn_get_dev_from_attrs(sock_net(cb->skb->sk), info, &tracker);
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
+	netdev_put(ovpn->dev, &tracker);
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
+	struct ovpn_priv *ovpn = info->user_ptr[0];
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
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot find peer with id %u", peer_id);
+		return -ENOENT;
+	}
+
+	netdev_dbg(ovpn->dev, "del peer %u\n", peer->id);
+	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
+	ovpn_peer_put(peer);
+
+	return ret;
 }
 
 int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index b9bbc562bf7f8e7fbd0a928250e54f595e0a2cae..cfe5396da584fb2b6ecbd84cd9b65446e123b6f3 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -135,9 +135,9 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
  *
  * Return: 0 on success or a negative error code otherwise
  */
-static int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
-				    const struct sockaddr_storage *ss,
-				    const u8 *local_ip)
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+			     const struct sockaddr_storage *ss,
+			     const u8 *local_ip)
 {
 	struct ovpn_bind *bind;
 	size_t ip_len;
@@ -331,7 +331,7 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
  * ovpn_peer_release - release peer private members
  * @peer: the peer to release
  */
-static void ovpn_peer_release(struct ovpn_peer *peer)
+void ovpn_peer_release(struct ovpn_peer *peer)
 {
 	ovpn_crypto_state_release(&peer->crypto);
 	spin_lock_bh(&peer->lock);
@@ -872,6 +872,37 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	return match;
 }
 
+void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
+{
+	struct hlist_nulls_head *nhead;
+
+	lockdep_assert_held(&peer->ovpn->lock);
+
+	/* rehashing makes sense only in multipeer mode */
+	if (peer->ovpn->mode != OVPN_MODE_MP)
+		return;
+
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
+		/* remove potential old hashing */
+		hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
+
+		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr4,
+					   &peer->vpn_addrs.ipv4,
+					   sizeof(peer->vpn_addrs.ipv4));
+		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
+	}
+
+	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
+		/* remove potential old hashing */
+		hlist_nulls_del_init_rcu(&peer->hash_entry_addr6);
+
+		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr6,
+					   &peer->vpn_addrs.ipv6,
+					   sizeof(peer->vpn_addrs.ipv6));
+		hlist_nulls_add_head_rcu(&peer->hash_entry_addr6, nhead);
+	}
+}
+
 /**
  * ovpn_peer_add_mp - add peer to related tables in a MP instance
  * @ovpn: the instance to add the peer to
@@ -933,19 +964,7 @@ static int ovpn_peer_add_mp(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 			   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
 					      sizeof(peer->id)));
 
-	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
-		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr4,
-					   &peer->vpn_addrs.ipv4,
-					   sizeof(peer->vpn_addrs.ipv4));
-		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
-	}
-
-	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
-		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr6,
-					   &peer->vpn_addrs.ipv6,
-					   sizeof(peer->vpn_addrs.ipv6));
-		hlist_nulls_add_head_rcu(&peer->hash_entry_addr6, nhead);
-	}
+	ovpn_peer_hash_vpn_ip(peer);
 out:
 	spin_unlock_bh(&ovpn->lock);
 	return ret;
@@ -1310,9 +1329,12 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
 	if (next_run > 0 && ovpn->registered) {
 		netdev_dbg(ovpn->dev,
 			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
-			   next_run, now, next_run - now);
+			   next_run, now, next_run - now ?: 0);
+		/* due to the waiting above, the next_run deadline may have
+		 * passed: in this case we reschedule the worker immediately
+		 */
 		schedule_delayed_work(&ovpn->keepalive_work,
-				      (next_run - now) * HZ);
+				      (next_run - now) * HZ ?: 0);
 	}
 	unlock_ovpn(ovpn, &release_list);
 }
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index a8bd9497d3a1606a0519e7a38e8ee5834a36c571..b3f0826ee93b914071b5034894eb27893e57a1f2 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -123,6 +123,7 @@ static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
 	return kref_get_unless_zero(&peer->refcount);
 }
 
+void ovpn_peer_release(struct ovpn_peer *peer);
 void ovpn_peer_release_kref(struct kref *kref);
 
 /**
@@ -147,6 +148,7 @@ struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
 struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 				       struct sk_buff *skb);
+void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer);
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
 
@@ -154,5 +156,8 @@ void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
 void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb);
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+			     const struct sockaddr_storage *ss,
+			     const u8 *local_ip);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index daf69154ee13c6755d4734f3ddd9a3004cf4288c..0936d57fec1f0b7e4491828c34e2c90fbbaa88b9 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -49,8 +49,8 @@ static bool ovpn_socket_put(struct ovpn_peer *peer, struct ovpn_socket *sock)
  * ovpn_socket_release - release resources owned by socket user
  * @peer: peer whose socket should be released
  *
- * This function should be invoked when the user is shutting
- * down and wants to drop its link to the socket.
+ * This function should be invoked when the peer is being removed
+ * and wants to drop its link to the socket.
  *
  * In case of UDP, the detach routine will drop a reference to the
  * ovpn netdev, pointed by the ovpn_socket.

-- 
2.45.3


