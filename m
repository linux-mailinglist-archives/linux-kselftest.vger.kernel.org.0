Return-Path: <linux-kselftest+bounces-24422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599E2A0FED5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 03:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5D3164E85
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 02:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EB9230988;
	Tue, 14 Jan 2025 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFLga5t3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40FB1C28E
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 02:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736822268; cv=none; b=jmhs7gbEVLTHO2P71xFLproUnJzqcCL0SSrVBZGJbRCgoeh8k2GghoPY4YClT8rQffvCFULpDWLZts1V+szvyxXzjJ+rbZgAV3lJ7v9AJcwrgeHK6ZXOrefqsB9d5UBOQJrFWUzLX+urxNcve+ufE7pWveeIHlPM0hZFR1JCukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736822268; c=relaxed/simple;
	bh=yNk7VMyMfPqqYLZcu3qccUrUaYOYBY8mJnlFy6n8dfs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eZmTr7JAZ24Kmo3ojnbeBgvqGOOoUY40CSHU3aN0nuRPhYJEFw9VHUEJy4vMUc+nbitZZjTTM4bnbnVrL2c0o0thrKuXsUaFxSOQFtmFoV2alOhwfvJRciU3b1do6EofXopKTuKDKU7w2tf8ooihlLxHJUt2lid+F+hDi8HUoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFLga5t3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efa0eb9dacso9083937a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 18:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736822266; x=1737427066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B5dgNaAp0sQQS5iHM2VZ2tj2onKjWNY3G/2soEYB4j8=;
        b=GFLga5t3f7RTyBE/avyeKgg0a+xNuGD55hl0yWdq3+CjkmXHevayaPBcI5xwPvZnj5
         wo7Tc7jCydPi3ZYQB/UC6mJUbVx/6iCfg6bejBlJD6/kvoUB+s8gOOGOA3YJFCTnRrtR
         PUHbc5tBlqRue0y7IS2h/+XGa94U/EBTKjdoAII02N8g8IEN+3xC1evnqhdJ+0CHBFOj
         7XtIyFYDr6MANd+Q7H1hr5A+AAfSmGzc+x7Z5YqUbYLPuOVd086VLKozCjmh3dvEtipU
         BRAdYo6fIa/36/jMUEYC6YPWePXaXFFmI+q30O3vUuBdAHJ6yu4R+j70AO6kVkloMUiQ
         aKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736822266; x=1737427066;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5dgNaAp0sQQS5iHM2VZ2tj2onKjWNY3G/2soEYB4j8=;
        b=uFoIm5pHwnU4cpMG2Gl2ciGYE0Mrjivywb0NaTMlWeyOkWDNcItF9toUuxm6LyN1ft
         PVhwa9VmRZ7JR9MaDhPakw11+DyHjsuFkrtavaIYUt77ysdDECyAUTIB79vQK/lr6hbh
         KSdSA9axB97jtkb6OLQsx29/bkiSFu2xmJdVNRv8ydbj4MuIM8XU0EKTJhTRRUYJh4Fv
         mWJg5sg2JvhEZ6UZFgzqT5OaZDKMi2ttjqfm49NAYzJlssq5aYlF+5EY9S7YNfmwAa/J
         7eSsqvNbi0F+voFfycEwymPhqwpDT1CmKpIbN8cEOUAlicpzgsfB0au+OFG3Y+7ljytx
         Wgyg==
X-Forwarded-Encrypted: i=1; AJvYcCVBO1KS0jJh1QakQMQVCNxBem0sJAnhigcTbTmsDHRCS+7aaNDVNmB9K+IuOYwTNxaVotQaNDo/LiKCJgWhf3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6HjXNaaSJMBdjDTGXuxmtPuATlnZ/aPitqPwWD42o2IdqqFr
	xnvXKqmrSxPl/AuZUqeHAmCaXz2Uq5Na90lpFNSvYa6FizWpusZR5q4CIjGeGoAmmCATp6xm3in
	zjw0nai8k3RZjYidPxuRXhA==
X-Google-Smtp-Source: AGHT+IGeMMn3k7BfERczvJyKys0ont/IFyQwmAym5frdzNFk++XhQ1xYq6zTVVaQVQLpX3Aw8Vf2KpWtJT+wryDvCA==
X-Received: from pjwx4.prod.google.com ([2002:a17:90a:c2c4:b0:2e9:ee22:8881])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:dfcc:b0:2ee:ad18:b30d with SMTP id 98e67ed59e1d1-2f548e98f31mr30603134a91.6.1736822265970;
 Mon, 13 Jan 2025 18:37:45 -0800 (PST)
Date: Tue, 14 Jan 2025 11:37:40 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250114023740.3753350-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v5] netlink: support dumping IPv4 multicast addresses
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

This change includes a new ynl based selftest case. To run the test,
execute the following command:

$ vng -v --user root --cpus 16 -- \
    make -C tools/testing/selftests TARGETS=3Dnet \
    TEST_PROGS=3Drtnetlink.py TEST_GEN_PROGS=3D"" run_tests

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v4:
- Fixes a bug where fillargs->event was not initialized in the code path fo=
r
  dumping ifaddr.
- Fixes a bug where reply messages contain the wrong sequence number.
- Minor style fixes.
- Adds a ynl selftest.

Changelog since v3:
- Refactor in_dev_dump_addr() to break down the logic into two separate
  functions to simplify the logic.

Changelog since v2:
- Fix checkpatch.pl warnings.
- Remove one redundant EXPORT_SYMBOL().

Changelog since v1:
- Minor style fixes.
- Use for_each_pmc_rcu() instead of for_each_pmc_rtnl().

 Documentation/netlink/specs/rt_link.yaml | 70 ++++++++++++++++++++
 include/linux/igmp.h                     | 14 ++++
 net/ipv4/devinet.c                       | 82 ++++++++++++++++++++----
 net/ipv4/igmp.c                          | 13 ++--
 tools/testing/selftests/net/Makefile     |  1 +
 tools/testing/selftests/net/rtnetlink.py | 30 +++++++++
 6 files changed, 192 insertions(+), 18 deletions(-)
 create mode 100755 tools/testing/selftests/net/rtnetlink.py

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netli=
nk/specs/rt_link.yaml
index 0d492500c7e5..7dcd5fddac9d 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -92,6 +92,41 @@ definitions:
       -
         name: ifi-change
         type: u32
+  -
+    name: ifaddrmsg
+    type: struct
+    members:
+      -
+        name: ifa-family
+        type: u8
+      -
+        name: ifa-prefixlen
+        type: u8
+      -
+        name: ifa-flags
+        type: u8
+      -
+        name: ifa-scope
+        type: u8
+      -
+        name: ifa-index
+        type: u32
+  -
+    name: ifacacheinfo
+    type: struct
+    members:
+      -
+        name: ifa-prefered
+        type: u32
+      -
+        name: ifa-valid
+        type: u32
+      -
+        name: cstamp
+        type: u32
+      -
+        name: tstamp
+        type: u32
   -
     name: ifla-bridge-id
     type: struct
@@ -2253,6 +2288,18 @@ attribute-sets:
       -
         name: tailroom
         type: u16
+  -
+    name: ifmcaddr-attrs
+    attributes:
+      -
+        name: addr
+        type: binary
+        value: 7
+      -
+        name: cacheinfo
+        type: binary
+        struct: ifacacheinfo
+        value: 6
=20
 sub-messages:
   -
@@ -2493,6 +2540,29 @@ operations:
         reply:
           value: 92
           attributes: *link-stats-attrs
+    -
+      name: getmaddrs
+      doc: Get / dump IPv4/IPv6 multicast addresses.
+      attribute-set: ifmcaddr-attrs
+      fixed-header: ifaddrmsg
+      do:
+        request:
+          value: 58
+          attributes:
+            - ifa-family
+            - ifa-index
+        reply:
+          value: 58
+          attributes: &mcaddr-attrs
+            - addr
+            - cacheinfo
+      dump:
+        request:
+          value: 58
+            - ifa-family
+        reply:
+          value: 58
+          attributes: *mcaddr-attrs
=20
 mcast-groups:
   list:
diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 073b30a9b850..a460e1ef0524 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -16,6 +16,7 @@
 #include <linux/ip.h>
 #include <linux/refcount.h>
 #include <linux/sockptr.h>
+#include <net/addrconf.h>
 #include <uapi/linux/igmp.h>
=20
 static inline struct igmphdr *igmp_hdr(const struct sk_buff *skb)
@@ -92,6 +93,16 @@ struct ip_mc_list {
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
+	enum addr_type_t type;
+};
+
 /* V3 exponential field decoding */
 #define IGMPV3_MASK(value, nb) ((nb)>=3D32 ? (value) : ((1<<(nb))-1) & (va=
lue))
 #define IGMPV3_EXP(thresh, nbmant, nbexp, value) \
@@ -142,4 +153,7 @@ extern void __ip_mc_inc_group(struct in_device *in_dev,=
 __be32 addr,
 extern void ip_mc_inc_group(struct in_device *in_dev, __be32 addr);
 int ip_mc_check_igmp(struct sk_buff *skb);
=20
+int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
+		       const struct ip_mc_list *im,
+		       struct inet_fill_args *args);
 #endif
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c8b3cf5fba4c..d90b2442e17b 100644
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
@@ -1874,6 +1894,23 @@ static int in_dev_dump_addr(struct in_device *in_dev=
, struct sk_buff *skb,
 	return err;
 }
=20
+static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
+			    struct netlink_callback *cb, int *s_ip_idx,
+			    struct inet_fill_args *fillargs)
+{
+	switch (fillargs->type) {
+	case UNICAST_ADDR:
+		fillargs->event =3D RTM_NEWADDR;
+		return in_dev_dump_ifaddr(in_dev, skb, cb, s_ip_idx, fillargs);
+	case MULTICAST_ADDR:
+		fillargs->event =3D RTM_GETMULTICAST;
+		return in_dev_dump_ifmcaddr(in_dev, skb, cb, s_ip_idx,
+					    fillargs);
+	default:
+		return 0;
+	}
+}
+
 /* Combine dev_addr_genid and dev_base_seq to detect changes.
  */
 static u32 inet_base_seq(const struct net *net)
@@ -1889,15 +1926,16 @@ static u32 inet_base_seq(const struct net *net)
 	return res;
 }
=20
-static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *=
cb)
+static int inet_dump_addr(struct sk_buff *skb, struct netlink_callback *cb=
,
+			  enum addr_type_t type)
 {
 	const struct nlmsghdr *nlh =3D cb->nlh;
 	struct inet_fill_args fillargs =3D {
 		.portid =3D NETLINK_CB(cb->skb).portid,
 		.seq =3D nlh->nlmsg_seq,
-		.event =3D RTM_NEWADDR,
 		.flags =3D NLM_F_MULTI,
 		.netnsid =3D -1,
+		.type =3D type,
 	};
 	struct net *net =3D sock_net(skb->sk);
 	struct net *tgt_net =3D net;
@@ -1949,6 +1987,20 @@ static int inet_dump_ifaddr(struct sk_buff *skb, str=
uct netlink_callback *cb)
 	return err;
 }
=20
+static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *=
cb)
+{
+	enum addr_type_t type =3D UNICAST_ADDR;
+
+	return inet_dump_addr(skb, cb, type);
+}
+
+static int inet_dump_ifmcaddr(struct sk_buff *skb, struct netlink_callback=
 *cb)
+{
+	enum addr_type_t type =3D MULTICAST_ADDR;
+
+	return inet_dump_addr(skb, cb, type);
+}
+
 static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *n=
lh,
 		      u32 portid)
 {
@@ -2845,6 +2897,8 @@ static const struct rtnl_msg_handler devinet_rtnl_msg=
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
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests=
/net/Makefile
index 73ee88d6b043..e2f03211f9b3 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -36,6 +36,7 @@ TEST_PROGS +=3D cmsg_so_priority.sh
 TEST_PROGS +=3D cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS +=3D netns-name.sh
 TEST_PROGS +=3D nl_netdev.py
+TEST_PROGS +=3D rtnetlink.py
 TEST_PROGS +=3D srv6_end_dt46_l3vpn_test.sh
 TEST_PROGS +=3D srv6_end_dt4_l3vpn_test.sh
 TEST_PROGS +=3D srv6_end_dt6_l3vpn_test.sh
diff --git a/tools/testing/selftests/net/rtnetlink.py b/tools/testing/selft=
ests/net/rtnetlink.py
new file mode 100755
index 000000000000..9b9dfbe4dd7b
--- /dev/null
+++ b/tools/testing/selftests/net/rtnetlink.py
@@ -0,0 +1,30 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_exit, ksft_run, ksft_ge, RtnlFamily
+import socket
+
+IPV4_ALL_HOSTS_MULTICAST =3D b'\xe0\x00\x00\x01'
+
+def dump_mcaddr_check(rtnl: RtnlFamily) -> None:
+    """
+    Verify that at least one interface has the IPv4 all-hosts multicast ad=
dress.
+    At least the loopback interface should have this address.
+    """
+
+    addresses =3D rtnl.getmaddrs({"ifa-family": socket.AF_INET}, dump=3DTr=
ue)
+
+    all_host_multicasts =3D [
+        addr for addr in addresses if addr['addr'] =3D=3D IPV4_ALL_HOSTS_M=
ULTICAST
+    ]
+
+    ksft_ge(len(all_host_multicasts), 1,
+            "No interface found with the IPv4 all-hosts multicast address"=
)
+
+def main() -> None:
+    rtnl =3D RtnlFamily()
+    ksft_run([dump_mcaddr_check], args=3D(rtnl, ))
+    ksft_exit()
+
+if __name__ =3D=3D "__main__":
+    main()
--=20
2.48.0.rc2.279.g1de40edade-goog


