Return-Path: <linux-kselftest+bounces-24696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8B3A14AF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 09:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8349B164E59
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 08:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D251F7088;
	Fri, 17 Jan 2025 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U7rzcVRA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549701F8668
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737101770; cv=none; b=WsEKITTYvFLFlcyoGkmL9XdUIYcUwiu71jt+zhpL7m+kXRauyQlrUnUC2XNGHFv8z25gFlFWROZpksS2OVjfaaFLaonl12SD1Lk94KxwrQBgxPcvQQvvRg6J8dFY4mcuEitnKKoiT1RaYQvR0Y3Whn0MMwPC4y8Wjgbvvy6TiO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737101770; c=relaxed/simple;
	bh=sRBUEVrMo/0V7SdkRE5CnE/w/K0IvzD/MMONWUZYsNA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MB82OZ9C7nlxF2kzVMBeo/nCkWpyFGjN007Qi8UBGq+pRo1WiK5Ishqi+CJlPjpo/6nM/UGxNjPOULU3vID+TLlif3FvqPATWJFs7l/GxffTm4SggU5ojh89iI08nqJppQNKhN+16/M2UCSlYMFNFE743316J8WG6b1uJI68dDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U7rzcVRA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216728b170cso36576375ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 00:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737101767; x=1737706567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWAd5UaNCLFpk3MqtCHOZDYrvEQhbDK50uttL23Pwro=;
        b=U7rzcVRA6eg0u5Zuqvms+/MQMbZkcGKOj+IQPnHZ+FicFxHPwiGM042VqjWFAiV3ps
         D1U8M1OBBgV/1Slg8Mbwb3XfQO7B3s7pU5xocM9RJwaYDYE9D4PG8y+ILHgSKiXW3M6R
         nf+qUS1WR8fwf6vRdlpIpAmxPYJCmc1ueBzZGMNZcWpu9H9hXTmluKfVh3kwPl5+eJrq
         dqZqlVnn6tQCVzUyN9EI9c2K/4VUd72fFvuPxU+ifFSUwiH3dlP07uHuLch20ggI6Y90
         SAGFHN4GOChuHHoJN5RY/rftGHATbOytisaWkxYHzkHu982wEdehEU7Cp9LoALfGZcft
         7VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737101767; x=1737706567;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWAd5UaNCLFpk3MqtCHOZDYrvEQhbDK50uttL23Pwro=;
        b=podYBhPPk7m7yIOHlDZ82OVE2Lyw2jswv2Gwd/M7uEzT7isOjmVE2kLeer4oN4jNVu
         +5Y1f9k86kl6FY6cDX7kOPq3RjuY91Ufp1ChmIW58r9Z4gcUGQLsZAY3hiaUFHqKgwjS
         xVMWMMTUxgQsbPw/qovQqrcFUfFjryj3TsXGgz4kAG7qo0yZ2G6CdoD+KwvfuIA037P0
         FmVDmpvKHD4uujX/YyOd3Ije00NfAPkJpFt/JosUuouPsWbceakRHOXrlxUDKyxm1zsp
         3fVbtidpbFcPhjZzQyoWR4+iLZblDfQTXUOC95RO+o40uJm6kV/XaXV9xPEASdZlVh2V
         LZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCVRRTVkMjx93+IqMWi2Pwcc0ve+cCuBClI89Oeetm/rEPb0PxQLH4AmleCt7S/B/+4xBCi1dWL1fOdT2owBjjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+k14eKb523Eb6e+iWFwbuSmhaDe9uiV/K9PuMzhPI3NCPecwT
	Lb69gGMollNb8Cp3Vitzn/lc5IlBIhXjI58mGQHs6ksZk54HOi2iZY6UhWc/i6rMlKYXJJKh9Ss
	YRMoFRlHFQL98IbI502Kp2g==
X-Google-Smtp-Source: AGHT+IHC8s+SghLCbRI+cpCbhYWFbOm3NCoR9cx6zlL6K/uqRp+hV1JiIhSswKub+VhEc/7DRDjY31fSPkAs1KcklQ==
X-Received: from pgbcs10.prod.google.com ([2002:a05:6a02:418a:b0:7fd:4919:f6cf])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7344:b0:1e1:ab8b:dda1 with SMTP id adf61e73a8af0-1eb215ecd12mr2987719637.35.1737101767560;
 Fri, 17 Jan 2025 00:16:07 -0800 (PST)
Date: Fri, 17 Jan 2025 17:15:58 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250117081600.150863-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v6 1/2] netlink: support dumping IPv4 multicast addresses
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-kselftest@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Extended RTM_GETMULTICAST to support dumping joined IPv4 multicast
addresses, in addition to the existing IPv6 functionality. This allows
userspace applications to retrieve both IPv4 and IPv6 multicast
addresses through similar netlink command and then monitor future
changes by registering to RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR.

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v5:
- Move the test case to a separate patch.
- Refactor the code to remove the dependency on `enum addr_type_t
  type`.
- Return error if `fillargs->event` is not set properly.
- Return -EINVAL in an unreachable code path.

Changelog since v4:
- Fixes a bug where fillargs->event was not initialized in the code
  path for dumping ifaddr.
- Fixes a bug where reply messages contain the wrong sequence number.
- Minor style fixes.
- Adds a ynl selftest.

Changelog since v3:
- Refactor in_dev_dump_addr() to break down the logic into two
  separate functions to simplify the logic.

Changelog since v2:
- Fix checkpatch.pl warnings.
- Remove one redundant EXPORT_SYMBOL().

Changelog since v1:
- Minor style fixes.
- Use for_each_pmc_rcu() instead of for_each_pmc_rtnl().

 include/linux/igmp.h | 12 +++++++
 net/ipv4/devinet.c   | 76 ++++++++++++++++++++++++++++++++++++--------
 net/ipv4/igmp.c      | 13 +++++---
 3 files changed, 83 insertions(+), 18 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 073b30a9b850..47c3ab54d79e 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -92,6 +92,15 @@ struct ip_mc_list {
 	struct rcu_head		rcu;
 };
=20
+struct inet_fill_args {
+	u32 portid;
+	u32 seq;
+	int event;
+	unsigned int flags;
+	int netnsid;
+	int ifindex;
+};
+
 /* V3 exponential field decoding */
 #define IGMPV3_MASK(value, nb) ((nb)>=3D32 ? (value) : ((1<<(nb))-1) & (va=
lue))
 #define IGMPV3_EXP(thresh, nbmant, nbexp, value) \
@@ -142,4 +151,7 @@ extern void __ip_mc_inc_group(struct in_device *in_dev,=
 __be32 addr,
 extern void ip_mc_inc_group(struct in_device *in_dev, __be32 addr);
 int ip_mc_check_igmp(struct sk_buff *skb);
=20
+int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
+		       const struct ip_mc_list *im,
+		       struct inet_fill_args *args);
 #endif
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c8b3cf5fba4c..5b561cdab31e 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -107,15 +107,6 @@ static const struct nla_policy ifa_ipv4_policy[IFA_MAX=
+1] =3D {
 	[IFA_PROTO]		=3D { .type =3D NLA_U8 },
 };
=20
-struct inet_fill_args {
-	u32 portid;
-	u32 seq;
-	int event;
-	unsigned int flags;
-	int netnsid;
-	int ifindex;
-};
-
 #define IN4_ADDR_HSIZE_SHIFT	8
 #define IN4_ADDR_HSIZE		(1U << IN4_ADDR_HSIZE_SHIFT)
=20
@@ -1846,9 +1837,38 @@ static int inet_valid_dump_ifaddr_req(const struct n=
lmsghdr *nlh,
 	return 0;
 }
=20
-static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
-			    struct netlink_callback *cb, int *s_ip_idx,
-			    struct inet_fill_args *fillargs)
+static int in_dev_dump_ifmcaddr(struct in_device *in_dev, struct sk_buff *=
skb,
+				struct netlink_callback *cb, int *s_ip_idx,
+				struct inet_fill_args *fillargs)
+{
+	struct ip_mc_list *im;
+	int ip_idx =3D 0;
+	int err;
+
+	for (im =3D rcu_dereference(in_dev->mc_list);
+	     im;
+	     im =3D rcu_dereference(im->next_rcu)) {
+		if (ip_idx < *s_ip_idx) {
+			ip_idx++;
+			continue;
+		}
+		err =3D inet_fill_ifmcaddr(skb, in_dev->dev, im, fillargs);
+		if (err < 0)
+			goto done;
+
+		nl_dump_check_consistent(cb, nlmsg_hdr(skb));
+		ip_idx++;
+	}
+	err =3D 0;
+	ip_idx =3D 0;
+done:
+	*s_ip_idx =3D ip_idx;
+	return err;
+}
+
+static int in_dev_dump_ifaddr(struct in_device *in_dev, struct sk_buff *sk=
b,
+			      struct netlink_callback *cb, int *s_ip_idx,
+			      struct inet_fill_args *fillargs)
 {
 	struct in_ifaddr *ifa;
 	int ip_idx =3D 0;
@@ -1874,6 +1894,21 @@ static int in_dev_dump_addr(struct in_device *in_dev=
, struct sk_buff *skb,
 	return err;
 }
=20
+static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
+			    struct netlink_callback *cb, int *s_ip_idx,
+			    struct inet_fill_args *fillargs)
+{
+	switch (fillargs->event) {
+	case RTM_NEWADDR:
+		return in_dev_dump_ifaddr(in_dev, skb, cb, s_ip_idx, fillargs);
+	case RTM_GETMULTICAST:
+		return in_dev_dump_ifmcaddr(in_dev, skb, cb, s_ip_idx,
+					    fillargs);
+	default:
+		return -EINVAL;
+	}
+}
+
 /* Combine dev_addr_genid and dev_base_seq to detect changes.
  */
 static u32 inet_base_seq(const struct net *net)
@@ -1889,13 +1924,14 @@ static u32 inet_base_seq(const struct net *net)
 	return res;
 }
=20
-static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *=
cb)
+static int inet_dump_addr(struct sk_buff *skb, struct netlink_callback *cb=
,
+			  int event)
 {
 	const struct nlmsghdr *nlh =3D cb->nlh;
 	struct inet_fill_args fillargs =3D {
 		.portid =3D NETLINK_CB(cb->skb).portid,
 		.seq =3D nlh->nlmsg_seq,
-		.event =3D RTM_NEWADDR,
+		.event =3D event,
 		.flags =3D NLM_F_MULTI,
 		.netnsid =3D -1,
 	};
@@ -1949,6 +1985,16 @@ static int inet_dump_ifaddr(struct sk_buff *skb, str=
uct netlink_callback *cb)
 	return err;
 }
=20
+static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *=
cb)
+{
+	return inet_dump_addr(skb, cb, RTM_NEWADDR);
+}
+
+static int inet_dump_ifmcaddr(struct sk_buff *skb, struct netlink_callback=
 *cb)
+{
+	return inet_dump_addr(skb, cb, RTM_GETMULTICAST);
+}
+
 static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *n=
lh,
 		      u32 portid)
 {
@@ -2845,6 +2891,8 @@ static const struct rtnl_msg_handler devinet_rtnl_msg=
_handlers[] __initconst =3D {
 	{.protocol =3D PF_INET, .msgtype =3D RTM_GETNETCONF,
 	 .doit =3D inet_netconf_get_devconf, .dumpit =3D inet_netconf_dump_devcon=
f,
 	 .flags =3D RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
+	{.owner =3D THIS_MODULE, .protocol =3D PF_INET, .msgtype =3D RTM_GETMULTI=
CAST,
+	 .dumpit =3D inet_dump_ifmcaddr, .flags =3D RTNL_FLAG_DUMP_UNLOCKED},
 };
=20
 void __init devinet_init(void)
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 3da126cea884..756db3ca3e34 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1432,14 +1432,16 @@ static void ip_mc_hash_remove(struct in_device *in_=
dev,
 	*mc_hash =3D im->next_hash;
 }
=20
-static int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
-			      const struct ip_mc_list *im, int event)
+int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
+		       const struct ip_mc_list *im,
+		       struct inet_fill_args *args)
 {
 	struct ifa_cacheinfo ci;
 	struct ifaddrmsg *ifm;
 	struct nlmsghdr *nlh;
=20
-	nlh =3D nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
+	nlh =3D nlmsg_put(skb, args->portid, args->seq, args->event,
+			sizeof(struct ifaddrmsg), args->flags);
 	if (!nlh)
 		return -EMSGSIZE;
=20
@@ -1468,6 +1470,9 @@ static int inet_fill_ifmcaddr(struct sk_buff *skb, st=
ruct net_device *dev,
 static void inet_ifmcaddr_notify(struct net_device *dev,
 				 const struct ip_mc_list *im, int event)
 {
+	struct inet_fill_args fillargs =3D {
+		.event =3D event,
+	};
 	struct net *net =3D dev_net(dev);
 	struct sk_buff *skb;
 	int err =3D -ENOMEM;
@@ -1479,7 +1484,7 @@ static void inet_ifmcaddr_notify(struct net_device *d=
ev,
 	if (!skb)
 		goto error;
=20
-	err =3D inet_fill_ifmcaddr(skb, dev, im, event);
+	err =3D inet_fill_ifmcaddr(skb, dev, im, &fillargs);
 	if (err < 0) {
 		WARN_ON_ONCE(err =3D=3D -EMSGSIZE);
 		nlmsg_free(skb);
--=20
2.48.0.rc2.279.g1de40edade-goog


