Return-Path: <linux-kselftest+bounces-23217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F85A9ED8B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480E22830F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690691FFC54;
	Wed, 11 Dec 2024 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fMsp0OUR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B51FCFFB
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952793; cv=none; b=KlFPZPBzDi3nrqCc96BrIDL3YxTcbuYqXmiDxryd/48oEMOdlWsgr55NrfRxMl6I81iPP9wTQNJ7qvFANkqOpefIwOKdEoS2aB3RgnisLGSo2aCRmJIcZQEICoTPFsIgTZUL/8GWYNWFPhADyikCWOAEh9CjLQvpFRvtWN1FFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952793; c=relaxed/simple;
	bh=kj8NuB1PSRjM5uTbMMWxSFKrGxBgUDNqBoFLbZGSOeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKvoGTaB1z5H3iEI6fzfeSeqq3MZj4ZuzO144mJDLQ2eB49hkbZ/f2pVaFegAi4A2GPEh4SQwtIXj3WCouhj/kDeffbIXXrPjk+dbSjZAlS2yeTixbHV/54oafYPl+2SWqjZwdY0zERuVf55l9CjGDAQtNDm18WPPl3us0yVBhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fMsp0OUR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434f30ba149so27823555e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 13:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952788; x=1734557588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53FH7WnWwm1WnfLduD5nvtNMsqlmC/u4PYxJ22eZEC0=;
        b=fMsp0OURXZXSngu+1TS6FhO9xnjpLgKSjalX7P+2jer3NqDaECobQDwBg6hCcSeIlN
         yoMruOv4zANF0BnR4JejN5rcPRB6oP81VvEwlw7jbYdas6ERx3bVibbKhKIhAMJ2KoTM
         CnCvAOc9jQMtx1UGeDTyghPIdwf/sC8htGFc/51+oFIDSV2LwnztyEbVPmJup+Q5jokD
         /CLAC+LhCnfge0H6k7vcueaCSFI1I6kNv1i6RGF4rufir5m3fP+qAyeiZmJsHJujRf98
         X2gMbbXyPgq9KPN6mqMpMh7kddBzGMKasdeppG06QAPsA0yEnfIPT9Dp25OYJw5BcFdY
         vaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952788; x=1734557588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53FH7WnWwm1WnfLduD5nvtNMsqlmC/u4PYxJ22eZEC0=;
        b=kKZ6XuaRS0I8z/Z4JINmxHPUWYFHsm32T6qBThUgYfoN9l+L5ego1c/dRPNI8oTunQ
         Vg7zQP1UyZTB2kI3c3OYA4O0uSVWp/HenKC1CvHTGLuKLctYJBV12RQQGBYA0HjpflhU
         Rv0X2XZJTO8xMHfPiYnf7ydwH4Jr9Yh4d0n3QhJVtBN33uuqwAMNvpoLyYflD5tJ6LcY
         HaZ8fAtQ2abRd5Xx2J2Bhxx234QEOI6w6AvcVSOKt75uvEHifCF8R0njqpfn8B0AJp1s
         LHJMzPiRS3ehpyFV4qqUqI8Xg3X3RxXzJntWXwDOmBdGvJMeRVb1e6AOcYfmGPCjwRe/
         58PA==
X-Forwarded-Encrypted: i=1; AJvYcCX6rAJK2s2QjPvS2uX5FJGf5JkCqNka4UuowF9hJocJDugXsD+p/+00HyDGX+EN0GhYrApaidHv909VH/fmeTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPiXfv3gkwrP6I5Ho6udZZLPToTmasqqo1n1apRwq0lmHMtG7t
	66NwwoflzYVpJNo3yv24TYV5nx5uiK/waECw3jm7bxsdx1rzJ0Zkld9oWB3rLXI=
X-Gm-Gg: ASbGnctG4NdMrIvA+3kZJnVXio77SdOTpgcy7KPVTi9JhZm9rHmk1GnRAKt56MqXPLB
	b038msJStTALlhPO/xUrLjEyK7npzu1bcFZYiDQP2B26DK4qRkbBkvDr3EYu7r+cRcyybYXf3Uh
	Aki+pkDTTnYsDXQn+ZOadxt/61WvE8Q9e6XGAPUiL9UK2GlMJaLr2wrba5YIfzZ/6hNIdwc/S6o
	BjWae4Icct39TVY/7w+IHSsevYJSIDGOZGtRjYOjKjQ/hDZhSk3syW5ZF2mTfWyUA==
X-Google-Smtp-Source: AGHT+IEF2IdsO0dlfw1xVW3wXZn/fnp8ZsNmuFHOPBj3vovVjuAj52DM3bbVJRqhdNDjiNW+DV/spQ==
X-Received: by 2002:a05:6000:4013:b0:386:3e3c:ef1 with SMTP id ffacd0b85a97d-3864cea4553mr3680787f8f.35.1733952787746;
        Wed, 11 Dec 2024 13:33:07 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:33:06 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:21 +0100
Subject: [PATCH net-next v15 17/22] ovpn: implement peer
 add/get/dump/delete via netlink
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-17-314e2cad0618@openvpn.net>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
In-Reply-To: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24629; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=kj8NuB1PSRjM5uTbMMWxSFKrGxBgUDNqBoFLbZGSOeI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnWgUm9eEuKBEBIR3t4GjsQeRszGTTDu+d9M/7X
 L0/JGl2OoSJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1oFJgAKCRALcOU6oDjV
 h3ZFB/9NXCOaFe7HH5cFu5ejSyCSiCTID7Z5zMvTRWaF5KpK7gA8eebPlrvG8erbBNmzf/+Bywy
 LwMnKHz8nBPF5vUGHIpkfm2wDscVVhprsBb/LEdvB1mfBQfRqremhZVEMfOePPCVjtVvmmWSuyb
 Z4m7LuUuDfo+LDh7DSWI5sfds5yY46pi18m+cDSGJK8u3AWGGDkM3BpYGhBjrksY2/b+gmWcFuR
 iPuyf8xZ8HtUWXTy1KSEZln0cmB0mOcWD1wC5Vr6PRB/RY1Cgx/gOAxMNI0TtcvG2x1pwGdkt5S
 cICLbhVLAQPb3VGBcrpTPHNuNX7/ZfqkLXE3Ek/Seam3sAFl
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This change introduces the netlink command needed to add, delete and
retrieve/dump known peers. Userspace is expected to use these commands
to handle known peer lifecycles.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 640 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.c    |  53 ++--
 drivers/net/ovpn/peer.h    |   5 +
 3 files changed, 676 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index c91368408b805d2bf4f12d64d5c55f4ed6d81343..9cc072a9e818dce97cc7dc1b48fb256a6039298f 100644
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
 
@@ -85,29 +89,655 @@ void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
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
+	struct ovpn_socket *ovpn_sock;
+	u32 sockfd, interv, timeout;
+	struct socket *sock = NULL;
+	u8 *local_ip = NULL;
+	bool rehash = false;
+	int ret;
+
+	if (attrs[OVPN_A_PEER_SOCKET]) {
+		if (peer->sock) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "peer socket can't be modified");
+			return -EINVAL;
+		}
+
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
+		ovpn_sock = ovpn_socket_new(sock, peer);
+		if (IS_ERR(ovpn_sock)) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "cannot encapsulate socket: %ld",
+					       PTR_ERR(ovpn_sock));
+			sockfd_put(sock);
+			return -ENOTSOCK;
+		}
+
+		peer->sock = ovpn_sock;
+	}
+
+	/* ovpn_socket_new() may sleep and cannot be invoked under lock.
+	 * For this reason we acquire the lock only from this point on.
+	 * However, this is not an issue because the socket cannot be
+	 * updated on an existing peer, therefore there is no concurrency
+	 * to protect from
+	 */
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
+	struct ovpn_peer *peer;
+	u32 peer_id;
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
+	struct ovpn_priv *ovpn;
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
index 3a794750a226b4e1bd0b683d5910b03d250cfb47..ed450be2d2379664a7fe0f17a9af527829474174 100644
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
@@ -816,6 +816,37 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
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
@@ -877,19 +908,7 @@ static int ovpn_peer_add_mp(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
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
index 361068a0a40fd11cd4d3d347f83352ed3d46048e..b3354d6ee8f5d9527b01565d98fe824d5b28d22d 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -124,6 +124,7 @@ static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
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

-- 
2.45.2


