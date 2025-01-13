Return-Path: <linux-kselftest+bounces-24351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D72A0B326
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 10:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B077A7A4B1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8024D233147;
	Mon, 13 Jan 2025 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Z1ZbChd0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6821ADC9
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760697; cv=none; b=GRHr04cwchqED70T+/5984GiLw+aujWEsw7qTKywKF77Yhg1VQyV+PXwvtVgqOO6Nz8rk2ADwA2Zfqk2Uf7M5UHnFzeXkmYpQNI+H1wAXgkG+PhSr1MLo+BOnvKmISg5ujiWgFURpvOX6CK2QE83IfFXpDAID0gTy1sJF5OIsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760697; c=relaxed/simple;
	bh=FZL0RiwFzBI2RRQL9F0n5usDl8jGaA9au8vGVArqmOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnAuExWCpGZUzO7CI+AqF3StkTgMjGnj/0AM5ljluC15djJbBQl8iQxVU3HuvUQIKHT0zS7EW0/oN4p32txkCu6PrGITebw2berzticvFUPXvzFBP7xSKmo6gMAlsgFSNjrpmaFf7HSF9bzyYpp5iWEY7iWcC+uT4ilM49ls1d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Z1ZbChd0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385df53e559so3238276f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 01:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760690; x=1737365490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ux7Kt001T7u/9/AdwO5txn9YzANpbMhGHEfn1wbBv5U=;
        b=Z1ZbChd0TjcOV8XtUUpjq2Vl7EUPeqaHPC+qR9H7IJ3wfATl0h5w9ctMvmQQ6AY6AR
         Fhe++fSvI2S/fGhscNhEVKkH99WW8nLoU3mOAUmf804aw/TnwpCQWsh8z5uiB4znPfn5
         1KofL+64S6ArtqbGyh6qQpBom3xGD/fNdmQ/T3jHM5x/hH+/XtbsN4Z6dUmO+Y0jW9jl
         mi0KfDZBKI7nAytPL+wjq28wwYS4k0aOJOw40CzaiQ+9fTZy3qCxJKSZ8ZY1d2GVre/+
         i0gPrOBgHrrpTrzGSA/7E2QJ4nA0wxQZqx2EbVAyiH3gyaUmE0F++Ya3xkOdBvma2rVm
         dDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760690; x=1737365490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux7Kt001T7u/9/AdwO5txn9YzANpbMhGHEfn1wbBv5U=;
        b=S8ATC2Ojs50sPKwcbgLn2BTvmEtH7frZ9z5196Op28aIQGIuUDkkVsKL7BAG/qKRWx
         LEVekNNzm8eV5UpSPXtrHlENZwKWZSj+Q+zw4q+uBhtJmhRMJN2l9EIRy7APsBYvmY7V
         4ePOwUWRWsetPImXwFRMGQB3Rw0Ku50342bCMgjEsXJcfluAxN2IGuUkBfNs6XjEXAVZ
         YBdHOPvp0anUPfP+QGmk99DGu34NakKr5D4xyymNeTcR3jvX4P1+fnQunKzdLdJcZsi2
         yE1pH+ZRSQ8YspYVPVvxWMsUqEUAGRFsK7EJtd6j9+kJwvcKRP+RaSOf5cVF/5ycIQNI
         HrLw==
X-Forwarded-Encrypted: i=1; AJvYcCXj1x25wKAbNZLKRNF4GH6GarNv+LnfjPoWjXMOoCE8XML3r90LXnNwbXWKyz4ETNUS6C0P1aweidU2pGXrrmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyET1tsvasPugwvjo14YWlaXpWYrziGYJjNdX+SEdtSHpxEdBjC
	ayOOlsNAtklWKfTNi9gjcrcN/1p7rc4BCZ2cEWDdffi/aFXtrRsVAZfPDIyDT80=
X-Gm-Gg: ASbGncuv2Z9m8veYvogEv6z4QxJ2ELbLK3bFExOwJQRPqIirKUqND4+xvsjfi9po78n
	aZK0tCzDOjyJCUH/nwTcWEfoui5n4dkMo8q5rBOH3efMrlfqAPUd07TpoGiYIM+LgXI7YC0hfUx
	Dq+xWVyOni7/fGmspLEJcYiEXGsZmW0zx9pFWwaobch1bn0aQ6C6Udc8iamabFI1qQKOb+KdQzM
	KS0pHttFSr5i7/A75a5eY6KzWpxktaztG5m8ggWNOyMip2/ax8uNkXrJRVe8yJ/pkoF
X-Google-Smtp-Source: AGHT+IH5syisqNp+7tovXLe+0wV5iGKi41aYZwrDjhpEzTzUVKzDnvb5YyrzLSYr4FZIIDKvw9F2Ug==
X-Received: by 2002:a5d:64ed:0:b0:38a:5122:5a10 with SMTP id ffacd0b85a97d-38a872de114mr18636133f8f.15.1736760690233;
        Mon, 13 Jan 2025 01:31:30 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:29 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 13 Jan 2025 10:31:39 +0100
Subject: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
In-Reply-To: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24262; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=FZL0RiwFzBI2RRQL9F0n5usDl8jGaA9au8vGVArqmOA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2ISNVrsMfKpf2JNqJIEuWb5/98U0oyRD+bH
 x85t3tuQF+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdiAAKCRALcOU6oDjV
 h0VoB/9mK7Q+UbZvsbRedp27/21SBGWEujYPmKGQPd6POxDVPqXDWDBxuWsh4jRGUESbPrOGsdq
 O2lnrwLigziaVinJtS+5uwMPH9mrw6X6EljZYDpXjngrNK55lXegDJ/vA06gqh3AopAFcrYx9Jr
 hitbRr6NEalTc2YA+W7KVshmu517sCXWIe2JW+9i3cOrhMM7SHbWBOzcmDWpwkEA0v+6a8xJ6th
 lUbEiFnGFKDeau+chUTSZSE7dMkiAk9vVcZ0MB4xRorq921y7reGdXaV8kP/bA5F+lST68Xs1u7
 XeWhmkhRP4nNPAEQKRHP9qs6Y7MSPxd3KiMYm3zlpfuh4n4f
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This change introduces the netlink command needed to add, delete and
retrieve/dump known peers. Userspace is expected to use these commands
to handle known peer lifecycles.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 630 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.c    |  53 ++--
 drivers/net/ovpn/peer.h    |   5 +
 3 files changed, 666 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index d5d0f9112ec554e9959b17d2c7bf6b054ea9ff1b..9daa48c294b435f26aa099b28ec458a21de3a87a 100644
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
 
@@ -89,29 +93,645 @@ void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		netdev_put(ovpn->dev, tracker);
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
+	u32 interv, timeout;
+	u8 *local_ip = NULL;
+	bool rehash = false;
+	int ret;
+
+	spin_lock_bh(&peer->lock);
+
+	if (ovpn_nl_attr_sockaddr_remote(attrs, &ss) != AF_UNSPEC) {
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
+		   "modify peer id=%u endpoint=%pIScp/%s VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
+		   peer->id, &ss, peer->sock->sock->sk->sk_prot_creator->name,
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
+	/* peers can only be added when the interface is up and running */
+	if (!netif_running(ovpn->dev))
+		return -ENETDOWN;
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
+	/* lookup the fd in the kernel table and extract the socket object */
+	sockfd = nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
+	/* sockfd_lookup() increases sock's refcounter */
+	sock = sockfd_lookup(sockfd, &ret);
+	if (!sock) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot lookup peer socket (fd=%u): %d",
+				       sockfd, ret);
+		return -ENOTSOCK;
+	}
+
+	/* Only when using UDP as transport protocol the remote endpoint
+	 * can be configured so that ovpn knows where to send packets to.
+	 *
+	 * In case of TCP, the socket is connected to the peer and ovpn
+	 * will just send bytes over it, without the need to specify a
+	 * destination.
+	 */
+	if (sock->sk->sk_protocol != IPPROTO_UDP &&
+	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
+	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "unexpected remote IP address for non UDP socket");
+		sockfd_put(sock);
+		return -EINVAL;
+	}
+
+	ovpn_sock = ovpn_socket_new(sock, peer);
+	if (IS_ERR(ovpn_sock)) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot encapsulate socket: %ld",
+				       PTR_ERR(ovpn_sock));
+		sockfd_put(sock);
+		return -ENOTSOCK;
+	}
+
+	peer->sock = ovpn_sock;
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
+	struct nlattr *attr;
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
+	if (!net_eq(genl_info_net(info), sock_net(peer->sock->sock->sk))) {
+		id = peernet2id_alloc(genl_info_net(info),
+				      sock_net(peer->sock->sock->sk),
+				      GFP_ATOMIC);
+		if (nla_put_s32(skb, OVPN_A_PEER_SOCKET_NETNSID, id))
+			goto err;
+	}
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
index e86b16ecf8dc2d152004ba752df5474b673bce17..f680b778c61cd40ce53cf1e834886d0346520a36 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -115,9 +115,9 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
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
@@ -311,7 +311,7 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
  * ovpn_peer_release - release peer private members
  * @peer: the peer to release
  */
-static void ovpn_peer_release(struct ovpn_peer *peer)
+void ovpn_peer_release(struct ovpn_peer *peer)
 {
 	ovpn_crypto_state_release(&peer->crypto);
 	spin_lock_bh(&peer->lock);
@@ -858,6 +858,37 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
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
+		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr,
+					   &peer->vpn_addrs.ipv4,
+					   sizeof(peer->vpn_addrs.ipv4));
+		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
+	}
+
+	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
+		/* remove potential old hashing */
+		hlist_nulls_del_init_rcu(&peer->hash_entry_addr6);
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
@@ -919,19 +950,7 @@ static int ovpn_peer_add_mp(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
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
 	spin_unlock_bh(&ovpn->lock);
 	return ret;
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 33e5fc49fa1219a403f6857ed1a5c6106d5e94de..7a062cc5a5a4c082f908ec444a41fe70702e3882 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -125,6 +125,7 @@ static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
 	return kref_get_unless_zero(&peer->refcount);
 }
 
+void ovpn_peer_release(struct ovpn_peer *peer);
 void ovpn_peer_release_kref(struct kref *kref);
 
 /**
@@ -148,6 +149,7 @@ struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
 struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 				       struct sk_buff *skb);
+void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer);
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
 
@@ -155,5 +157,8 @@ void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
 void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb);
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+			     const struct sockaddr_storage *ss,
+			     const u8 *local_ip);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


