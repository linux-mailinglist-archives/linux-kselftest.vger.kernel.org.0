Return-Path: <linux-kselftest+bounces-25985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3F6A2C158
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 12:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 320937A0741
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 11:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980951D8DFE;
	Fri,  7 Feb 2025 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJ5xaxWt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056A1DC9B4
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926523; cv=none; b=s98AnnytYyFM7LF9D/pm8eKgkq9h5WeA7+4fhXFDZFEWvpw1hAk6yeLXMlE2mZKwS8llEmXlYfPi8ahNnjTCLF0hj95DELcnWPuNHhI4yKaG0jOV2A5ajAhdl1bamcl7JeaYo4jIWqKmxvd9sBuZjRyOLqRDmvfRS7yutWgPcG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926523; c=relaxed/simple;
	bh=Tz2v+58EgrfNfnp8Js0N+twJj7dNZpVrbCwABGygwnY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tzrCKEuu67/5eQCgaL2UpkgHeEdak8clAhne2tkRP0cSJ8ohAdK+dwLlykjWHZ5UtScqlUNKC2kizuSnJ2MGxJhzSg61+RdCblogcRiPthhyCjjjK5o7tJKK6q+wKKbnSwnj/19j6L3wPDk7BmlSY9Op2ZxvMrDm0bFWLpiAoSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zJ5xaxWt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f3aad4e0bso26306875ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738926521; x=1739531321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nox0s4Fh4xMKHiPrAZjhhl35UNnU1rsHPBzdNMgyl8w=;
        b=zJ5xaxWtNfE3Ii9Jgtdlqn3b2mBEZh39qIJKaIy0w7coJkYZyCovisfcplEXapapSe
         e+7LAck2Ti+ss4rTR2JZtQLD/G8oSqjCF+q/9U8okKceIve5S04TNSliuGlWWY0rr7pk
         Gnwl8AD/YtVGZ1zYgkq0Iw0pe/DoFce1eVLSYkpy+DeB53n4qFztoRzcfCyBxbn4cSVy
         tynCBODnYmHzmb2K6FWbzH8glqKjMnRiySt2OjTot5Oi+xPIYeYc48H/Sr3kcGTUtuSR
         JM1iogcxPrOhWIzmxsjCOfVkl+M4AbiVOTGas/PqyQxKnJP7P2nHeFWVh1KFYcZzL4d5
         bGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738926521; x=1739531321;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nox0s4Fh4xMKHiPrAZjhhl35UNnU1rsHPBzdNMgyl8w=;
        b=vpCmN9qOmsYefyeCDx/dZ2Ck566r+PMfO0JXQj2+L2afvQz3I3qhIJCHG0NX5KtXIM
         88miIhHUknKJC++Ya4A49YgF/dWyAwelJxe3aW+jyLvdsO+3GOUtcC2Fqd7u3i+7o4QC
         egJAp9dersZYPYOAUqwdvYsQu4a9FIpLXI0LwF6LdNDq1sGVa3EAoqTDhz3snDMFEaUP
         D2CJ40rbbpFxYpkqoJOtyNFHW69p9JJNdMabigpCGIvj2bUN+KzWDKCk2efMNfhhvNbL
         Ay9HG7sLwEvwWE3g+m/Rb1xJeW+WOkCCxclGlyyWOBDkmTsBvBfciy8h0o7UoJ7AqNre
         AStg==
X-Forwarded-Encrypted: i=1; AJvYcCUinRn8DX6OVQjo/G6awFbHBtAcQIgnIdmeYFOH9yhSG74cvW2+60jeAFm0wultQRlZYEtOQnWpaCuADI2T1j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtJ6iG37THQ0O5Z92P8PsmA1/kD1y2T+WIhRf/7/ddlDUkHyQ
	WgAXDHDVgjbmku7IV8nMdul5dUcgizSUXFIMHJ9QrYjDxxX9ljVj1JESFQ2FlsWmB4q1DfRumTk
	QJ/biRuIxrUyNiPzaKBgVtQ==
X-Google-Smtp-Source: AGHT+IHYIRSVcPnd/i11bspadzsee6R+uvAD1Phn24bE1EghLlOz5FhVWXiTeDgAUhbl7UMa598wfd3sOLO5Is+z+Q==
X-Received: from pgbcq2.prod.google.com ([2002:a05:6a02:4082:b0:801:d700:ff4])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:46cb:b0:216:4dfe:3ebd with SMTP id d9443c01a7336-21f4e785278mr51917645ad.50.1738926521259;
 Fri, 07 Feb 2025 03:08:41 -0800 (PST)
Date: Fri,  7 Feb 2025 20:08:35 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207110836.2407224-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v8 1/2] netlink: support dumping IPv4 multicast addresses
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, petrm@nvidia.com, linux-kselftest@vger.kernel.org, 
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

Changelog since v7:
- Move igmp_internal.h to net/ipv4.

Changelog since v6:
- Move `inet_fill_args` and `inet_fill_ifmcaddr` from igmp.h to igmp_intern=
al.h to avoid exposing these two definitions kernel wide.

Changelog since v5:
- Move the test case to a separate patch.
- Refactor the code to remove the dependency on `enum addr_type_t type`.
- Return error if `fillargs->event` is not set properly.=20
- Return -EINVAL in an unreachable code path.

Changelog since v4:
- Fixes a bug where fillargs->event was not initialized in the code path fo=
r dumping ifaddr.
- Fixes a bug where reply messages contain the wrong sequence number.
- Minor style fixes.
- Adds a ynl selftest.

Changelog since v3:
- Refactor in_dev_dump_addr() to break down the logic into two separate fun=
ctions to simplify the logic.

Changelog since v2:
- Fix checkpatch.pl warnings.
- Remove one redundant EXPORT_SYMBOL().

Changelog since v1:
- Minor style fixes.
- Use for_each_pmc_rcu() instead of for_each_pmc_rtnl().

 net/ipv4/devinet.c       | 77 ++++++++++++++++++++++++++++++++--------
 net/ipv4/igmp.c          | 14 +++++---
 net/ipv4/igmp_internal.h | 17 +++++++++
 3 files changed, 90 insertions(+), 18 deletions(-)
 create mode 100644 net/ipv4/igmp_internal.h

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c8b3cf5fba4c..f51e026d7a84 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -46,6 +46,7 @@
 #include <linux/notifier.h>
 #include <linux/inetdevice.h>
 #include <linux/igmp.h>
+#include "igmp_internal.h"
 #include <linux/slab.h>
 #include <linux/hash.h>
 #ifdef CONFIG_SYSCTL
@@ -107,15 +108,6 @@ static const struct nla_policy ifa_ipv4_policy[IFA_MAX=
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
@@ -1846,9 +1838,38 @@ static int inet_valid_dump_ifaddr_req(const struct n=
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
@@ -1874,6 +1895,21 @@ static int in_dev_dump_addr(struct in_device *in_dev=
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
@@ -1889,13 +1925,14 @@ static u32 inet_base_seq(const struct net *net)
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
@@ -1949,6 +1986,16 @@ static int inet_dump_ifaddr(struct sk_buff *skb, str=
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
@@ -2845,6 +2892,8 @@ static const struct rtnl_msg_handler devinet_rtnl_msg=
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
index 3da126cea884..2c394c364cb9 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -81,6 +81,7 @@
 #include <linux/skbuff.h>
 #include <linux/inetdevice.h>
 #include <linux/igmp.h>
+#include "igmp_internal.h"
 #include <linux/if_arp.h>
 #include <linux/rtnetlink.h>
 #include <linux/times.h>
@@ -1432,14 +1433,16 @@ static void ip_mc_hash_remove(struct in_device *in_=
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
@@ -1468,6 +1471,9 @@ static int inet_fill_ifmcaddr(struct sk_buff *skb, st=
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
@@ -1479,7 +1485,7 @@ static void inet_ifmcaddr_notify(struct net_device *d=
ev,
 	if (!skb)
 		goto error;
=20
-	err =3D inet_fill_ifmcaddr(skb, dev, im, event);
+	err =3D inet_fill_ifmcaddr(skb, dev, im, &fillargs);
 	if (err < 0) {
 		WARN_ON_ONCE(err =3D=3D -EMSGSIZE);
 		nlmsg_free(skb);
diff --git a/net/ipv4/igmp_internal.h b/net/ipv4/igmp_internal.h
new file mode 100644
index 000000000000..0a1bcc8ec8e1
--- /dev/null
+++ b/net/ipv4/igmp_internal.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_IGMP_INTERNAL_H
+#define _LINUX_IGMP_INTERNAL_H
+
+struct inet_fill_args {
+	u32 portid;
+	u32 seq;
+	int event;
+	unsigned int flags;
+	int netnsid;
+	int ifindex;
+};
+
+int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
+		       const struct ip_mc_list *im,
+		       struct inet_fill_args *args);
+#endif
--=20
2.48.1.502.g6dc24dfdaf-goog


