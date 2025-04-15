Return-Path: <linux-kselftest+bounces-30857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA70A89C16
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214EA3BCC1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AED2BCF64;
	Tue, 15 Apr 2025 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="D9wGoCmc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4629A3EC
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715878; cv=none; b=DZOuykpbawlWEHXsF/J0WpO6tNnDTpD7/33jO2MD3WMqAxIxKsc/8Za6YghqnLdkb9QKiY2zgAecK61EAAgomv+lHlXuhUyqfTPHErmI1jOe9au2yOY/0KrBxwvQ1V4U782v5asKdTqg/0fg4oJXXdoRklxGVzx9sc3VWvUuIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715878; c=relaxed/simple;
	bh=FMh55rBun0mQDo3vsCYfcGp6JsEV2a+N+XLBGQAlCaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1RPPMf84CrUtnb1K6SZyIYB5NY8HmCB9+yy9hWoWUgcHSmb1uR8x3ZNOIv3BLTAhWrJgZkkKbeo+rZOyZNDDzedvBvWOgkDLf48rWsIFONtim4sLNSaI0J7BGNLiDZaGpqYeDBIOSosy3QDWkLH+KX5yF7b3a6b99ZJ31YnFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=D9wGoCmc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso27515115e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715871; x=1745320671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pj8nUplhYIj9I7Taqpyu2yhpVZ0f+jGbbXyib7HYCmQ=;
        b=D9wGoCmcjkzitVV2hlvjFLUXPP7kixKrMMSId3o0pPI+6ZxMLQj5B5rCg0ueEJ1zFR
         PxEvGskz7yVC0TsZ6BifohiSSkWVH7A8p7meQy2s+gK4Pko03jOaiKLFud1l8kL8WRVd
         XunMGL1JzNmMcaW64u5tKPbo5CfssbT1EM/p5c/14OUxzZrY3fTlgWWG6SjJXVMEHU8r
         ne56Dk2y0x65ejK0SxtEs+qNil2NnSld0LrUvXDA+6GvPLZLxh67IKujbr/y7UNW1Ga/
         nGB2k9Es9EpB6kkEOAs5NOik8Jet8HiOQIZYsK2p1Fiw4V1gLUGN3fYn2k3Hed2NjfEx
         DWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715871; x=1745320671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj8nUplhYIj9I7Taqpyu2yhpVZ0f+jGbbXyib7HYCmQ=;
        b=OdachcT/Okc0wqbbCttYXOeUKtWTwfP/Ydc2hQF+ifGZsAG6U9nIjH/vv9cKwxkYQK
         W0x7gZIvSuSwAMQKOQDlEjFEIeRFQ50Djodd57Z399Ti+zKWxlZ9OhtU6DWj1pyNnV/y
         rzJU0q2bID/k35nTC30Ta4OPgp1YmEmcNXK3X08pps2RKwweciL51J/vc3s+AZ7W5VD0
         nbJmKTpZqEq7KLZR/SIURWX96OwyZ0eHdkv9r4lfT3iqV0GfEN6VJUDUkurJ3ZQIM7QI
         vsQAEsARSHLYjBXnTlYZTgPSkss1nPhMB/a/OtYs0Pi6TyxTkLpT0IeuC8Tj2EWUDxvT
         YKQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfBmOhfr0PCFsUkGl9bcu+22gx//wMeEPsEuEtAg70bcubSdla1c3HYn6frbDcFBiQXRURWIqmnDK8J1D7pYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7nd50CO9eGUe+nLfszCgUcst3yt5H7EiRIJSEJ+7S9YMqpOhY
	QYoiGA34bidl2aOyW0LuCN7O0TcKWHgRf+iIC41yEB5MG+F/HutBEpF8ix38GJQiyHOjNU5DK3i
	bh3KLWjoiIUYQ+WiYmyyOL06DAigcgzGu7VreaJdKtgXqbQYborrdj199RYI=
X-Gm-Gg: ASbGncsXL/eMgXC6qyngznIl1CoG+oukNst2Sasfn6wvOH2wSpgZ7RSsJcYccw0maui
	E5YQi/h0bxBB6wh1I7NDqGc862zjhKk0N/AJ3l28cGiU/gOb4JsDs9Yg6n0mA3fGC9rkhcidkK2
	dDWk4Nt7P+iw6uVqFgnORQqoTWfpsYMEd2lWF6ublyDoM3rEzCdO2P5L54DNVtr91h5/UT795/a
	TikzuiojEPdqGROmc8/cv8SQKebzPWIFKwqGwF1zaLmrd/B0QC56Z/OKA3efRQu/5TW4oYjcpz9
	QNFDqLLwOjLpMa6K4YtumhCWdzXc/++TnUk/rw==
X-Google-Smtp-Source: AGHT+IE28SkgmY2tRziujtF++BH3UyqpBQrMnPvGUHPstnAGLNrwr/SES6EoSEFPbc5LfXXXClHgrw==
X-Received: by 2002:a05:600c:294:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-43f3d15d62fmr84121065e9.25.1744715870653;
        Tue, 15 Apr 2025 04:17:50 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:50 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:35 +0200
Subject: [PATCH net-next v26 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-18-577f6097b964@openvpn.net>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=27886; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=FMh55rBun0mQDo3vsCYfcGp6JsEV2a+N+XLBGQAlCaQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBCEySK2Ru+c01KlVsZSH0B+A3yDHab+q/8G
 /gGAbRHV4SJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQgAKCRALcOU6oDjV
 h0zGB/sFG4vtM/1eHDs5gQplh7yoGZn4dMQb7g6mXq/hCHb+bETNwzrbx7RATKqGBEdFAbmnrRO
 hh9KaCnYpqV2U+HSoigN2I5aovTtgmQr29IyZOgu5o2/HmAWvNJ6N4L8u2U3bLaPGKaewOYrvYc
 +gMPEV+auuy/wjctNOSVp8In1ugBIToPUxu8Vq2oiYN4qyP8rPJC3qqYu6KvKT+U0A6LRgpppok
 PB9Ln/sBWO3xA1d1UxZ3Mv6cA48kFi0HDlNRAOYuv8MNyz3iqCD+ngkmP/W0fltStKNRTNQM5wo
 XFaWqsrBmSCRHZxcAPcm5dXoyp37A9cDxzWuZH37JDcCqYQO
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This change introduces the netlink command needed to add, delete and
retrieve/dump known peers. Userspace is expected to use these commands
to handle known peer lifecycles.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 686 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.c    |  79 ++++--
 drivers/net/ovpn/peer.h    |   5 +
 drivers/net/ovpn/socket.c  |   4 +-
 4 files changed, 738 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 8d267d4c82283d9b5f989478102086ce385195d5..5653a588a47c6c94ff10e042f4f6d32bd8205e58 100644
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
 
@@ -89,29 +93,701 @@ void ovpn_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
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
+	if ((attrs[OVPN_A_PEER_REMOTE_IPV4] ||
+	     attrs[OVPN_A_PEER_REMOTE_IPV6]) &&
+	    !attrs[OVPN_A_PEER_REMOTE_PORT]) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "cannot specify remote IP address without port");
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
+	void *local_ip = NULL;
+	u32 interv, timeout;
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
+		dst_cache_reset(&peer->dst_cache);
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
index 10a6fd3e6ecd0306072053d51a5a195543069223..0469afd6da238d795b63b9e68c8c728fa324de98 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -135,9 +135,9 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
  *
  * Return: 0 on success or a negative error code otherwise
  */
-static int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
-				    const struct sockaddr_storage *ss,
-				    const void *local_ip)
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+			     const struct sockaddr_storage *ss,
+			     const void *local_ip)
 {
 	struct ovpn_bind *bind;
 	size_t ip_len;
@@ -149,19 +149,21 @@ static int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
 	if (IS_ERR(bind))
 		return PTR_ERR(bind);
 
-	if (ss->ss_family == AF_INET) {
-		ip_len = sizeof(struct in_addr);
-	} else if (ss->ss_family == AF_INET6) {
-		ip_len = sizeof(struct in6_addr);
-	} else {
-		net_dbg_ratelimited("%s: invalid family %u for remote endpoint for peer %u\n",
-				    netdev_name(peer->ovpn->dev),
-				    ss->ss_family, peer->id);
-		kfree(bind);
-		return -EINVAL;
-	}
+	if (local_ip) {
+		if (ss->ss_family == AF_INET) {
+			ip_len = sizeof(struct in_addr);
+		} else if (ss->ss_family == AF_INET6) {
+			ip_len = sizeof(struct in6_addr);
+		} else {
+			net_dbg_ratelimited("%s: invalid family %u for remote endpoint for peer %u\n",
+					    netdev_name(peer->ovpn->dev),
+					    ss->ss_family, peer->id);
+			kfree(bind);
+			return -EINVAL;
+		}
 
-	memcpy(&bind->local, local_ip, ip_len);
+		memcpy(&bind->local, local_ip, ip_len);
+	}
 
 	/* set binding */
 	ovpn_bind_reset(peer, bind);
@@ -346,7 +348,7 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
  * ovpn_peer_release - release peer private members
  * @peer: the peer to release
  */
-static void ovpn_peer_release(struct ovpn_peer *peer)
+void ovpn_peer_release(struct ovpn_peer *peer)
 {
 	ovpn_crypto_state_release(&peer->crypto);
 	spin_lock_bh(&peer->lock);
@@ -887,6 +889,37 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
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
@@ -948,19 +981,7 @@ static int ovpn_peer_add_mp(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
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
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index f1288734ff100ee76b0c41ebb6dc71725ea33261..a1423f2b09e066d9c2392685d3765a2ec29a82ba 100644
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
+			     const void *local_ip);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 3a18fbdd3721628c0b4b0d23c9aef77332addfe6..a83cbab7259109f6cb476d6cc670d16180c12761 100644
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
2.49.0


