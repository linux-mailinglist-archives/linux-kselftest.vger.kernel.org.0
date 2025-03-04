Return-Path: <linux-kselftest+bounces-28130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 785C9A4D02E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 01:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8823188BAF7
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14DE1F791C;
	Tue,  4 Mar 2025 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZkrIewQ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B261F5438
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048497; cv=none; b=lGlL9vXaLFgSu1N1C00h12t2ThA35nZbuiBG4UZHT4ge8+XZkdbgd2OnR8RQ1PGq7zKrySKflOmebFb/oDJmAEeJeBpCu+uuUjs9x50U75uPpTEbumX3e74mimFRKRPNBUG7rBhqQnUMUWaEzzC9zOfv2iNNvmi1M4LBQIBqcQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048497; c=relaxed/simple;
	bh=K5L15PBxYyBMtNsaZI5XAeZmGuUFKc2QfPIAxM3li7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y5epDKYTKJmo8+ynP7gedoE8OGwpiEfi5EtnLNp9IqgYTq5Ah5uRYy6rYT6r7noDt1PoAJIOzJZu5QTNCgu9OyIAvBMELHUCjNmwkTR9GZJj7YL6MSj9JjKqd+FjLXrvu2AAeuoQ/Q2F6gnOCAr6Nn7WTvXWazaG+rnJAHCWb+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZkrIewQ1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390d98ae34dso4118561f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 16:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048492; x=1741653292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mk4iUNO6T5IE1XUw14Enok+xkB/OnSQhnHglEcoiQcY=;
        b=ZkrIewQ1Pck+DbtFr/n3laHPvNbxZkcHJ4P4FDwLhXRbJUR7pi+f0EY3S3DYPOJWUY
         BXaWW0FWwQZtijIMak+il5rocDHU/Btjj3X8dsDaMVWaK1qxRdtkeTLPNF9FPXBrWHd5
         tmk4mUh2axfehAcmPioP0c7ER3qBqeXIqSpI1gmEys0F/hWX1F1LToYNK06kuv/IcmoM
         5NMHATZKOkENJSnRNQ6sJWVKJxSj38eZjfvXgkCsZV8qQ1PIoc8xkX2weUmsfVjgHVgs
         pnQVWhIDJ4OOBuwoiye1+5+IcdRmvbDt/rQ46WkXzKKqSWka4CVinMLtccVupAtbnQ96
         GffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048492; x=1741653292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk4iUNO6T5IE1XUw14Enok+xkB/OnSQhnHglEcoiQcY=;
        b=nmYDmQtz7n+OaNZ8T4IceQJX5ewdRit3lCvWzNfGMq3NS4rGWvbbMiQLBNEqtMz8kO
         ZYPq2proNyyUtqOfx8d4FE84ToybfCUP34nVYnJktpORLVn2a4R1+wRPwCXAfFXJyLux
         9cd6c5w57M4PyvR3++OfhnMG2JndYMozY/1lLDVIAMtU51vI9QziB9NdH0fceyhkNxav
         lqieDRagQ8h+P8jSusU3stOQrZkqG/sAmRymWtZ330vlSjuu11gB0KFKo5sBGxJWH0Ry
         1jUNKQsZwN5GZjE/d8+n2D0UKLZ8kwfg0SaRAsPivHSb7ojc5tB3wgqk2Wk+XXjahf1Q
         ZjIw==
X-Forwarded-Encrypted: i=1; AJvYcCXHkB1W4fAEcXfaTOr+XBZzWK6BGeWHgJ/Bv8JDe/UDLlLVUUbFCouNGw72XytYaNsNgixEmMkVoB05GKYnimk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyANTOpYdsCQCmoE/jR27U32Jhy6BJ21oXlEwMg70/tG653C2LV
	/+OnZ7us8I2KkwVKhDQh5ZXcas71JhR1pwMH3f7nmaf6kwH7vMxjONoUACA78g0=
X-Gm-Gg: ASbGncuSzyckwFAKravoCwVRYYyTP3QdH9nKFGkdljlWsOCkmxASBA1DpdwNrWX696l
	+jqpMFaIzggmx0GaaqqmSxnKM9dYydZgZCg2Yswj8X8U5JfL82kly5+XNJD+rkFMqqMjLkTd0hz
	7rw5Klp/+LhEhS+bV32lHsCeBZJyuEqIqhPJY1Mk6sRdcIFg6IodL2VAp5jNwTOAs6BFnScSB1S
	LaZ6CKiWHcRORmlMG7C43NBfdjYQVRASEdv5at1Cu04XQrPxpqcs2R5B7HYP3cPXrnzZ3s/NGvC
	2fqRES2s1qxe8Jeq9GAkTdRO73Sjh29shHvpl3vbvA==
X-Google-Smtp-Source: AGHT+IHwtZsj6CQqjW7zNeem412xNggo89jBLzizOmziMfvp4DhunYZautwgkBpiurQaKhgJqhKZeg==
X-Received: by 2002:a5d:5f49:0:b0:390:f987:26a1 with SMTP id ffacd0b85a97d-390f987270bmr5645940f8f.29.1741048491796;
        Mon, 03 Mar 2025 16:34:51 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:51 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:49 +0100
Subject: [PATCH v21 19/24] ovpn: implement peer add/get/dump/delete via
 netlink
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-19-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=27271; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=K5L15PBxYyBMtNsaZI5XAeZmGuUFKc2QfPIAxM3li7Y=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqQbqLQg1C75IlkxvYpW+6UpM80GalKkXlxY
 s7Dr0Ld8EOJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKkAAKCRALcOU6oDjV
 h78iCACn7YRVT5FZuW9KdPuhMaol2e7mBkp6eDMNBlan2CbrF333ha5hXmIa4pvN6JNUeGgqXmh
 o3SytjuxyuQbWzcjL+G1Z1NL5JXpXID+Nm7M2nWcK31j3SLEtsSwdTQSVHY8s7T/P67x1QhDtQD
 IHri9IKUaMeQwbA70hEawa/VfPPG4keoKXCyRfBHE9mpRDfoFMlrM9Lyy8Em0njNX3QeT1EvZh1
 bePTeM2b5dIyQEDJU0P+YwI8xxf3avEJznBI6QJ87kVGD8fsoqPgAk0fpIDbEhtRXCUWDIlsV7u
 ZiLkK+qXkQvTpjE+Kg/Co5HzVxwJBUl2TIGbKdH6KbA+JzRS
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This change introduces the netlink command needed to add, delete and
retrieve/dump known peers. Userspace is expected to use these commands
to handle known peer lifecycles.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 677 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.c    |  62 +++--
 drivers/net/ovpn/peer.h    |   5 +
 drivers/net/ovpn/socket.c  |   4 +-
 4 files changed, 722 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 8d267d4c82283d9b5f989478102086ce385195d5..9824ce4437e63e602d37d31105fb9ac06f99d421 100644
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
+				       "cannot add new peer (id=%u) to hashtable: %d",
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
index 156e45407e0a6e69f177a064053f81fe778a9dd8..2a9f373b7a2f684203677bdc7b5a147c41ea2daf 100644
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
@@ -1317,11 +1336,16 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
 
 	/* prevent rearming if the interface is being destroyed */
 	if (next_run > 0 && ovpn->registered) {
+		time64_t delta = next_run - now;
+
 		netdev_dbg(ovpn->dev,
 			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
-			   next_run, now, next_run - now);
+			   next_run, now, delta > 0 ? delta : 0);
+		/* due to the waiting above, the next_run deadline may have
+		 * passed: in this case we reschedule the worker immediately
+		 */
 		schedule_delayed_work(&ovpn->keepalive_work,
-				      (next_run - now) * HZ);
+				      delta * HZ > 0 ? delta * HZ : 0);
 	}
 	unlock_ovpn(ovpn, &release_list);
 }
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index f1288734ff100ee76b0c41ebb6dc71725ea33261..4cddf3c795a5a472279d586027c1cf564f55c50a 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -125,6 +125,7 @@ static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
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
index be20c500f373fb894d0df5e02ce1996cf386d195..6ecf40857651afbd0986793afeb2a2f66f336aaf 100644
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


