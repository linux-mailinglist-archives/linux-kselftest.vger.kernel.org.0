Return-Path: <linux-kselftest+bounces-23043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D579E983F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134B3188613F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B9135973;
	Mon,  9 Dec 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxKmoFmu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E473D1ACEC3;
	Mon,  9 Dec 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753162; cv=none; b=uSk/911u388q58gIQvuiZ2m6dFTnlfacZlHODBndbHHH12OhC3yDYARNxsUhbQ7iRfGI1acSfuZtMz9zg2SMOu2i3CJo39GH7mg/MUYloEZpWA9+nQrZBSqYkitwkzUzVz7yVnjOU2ZP2y7TF1xKe2q2shzjmGQjq4TOq8AtrJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753162; c=relaxed/simple;
	bh=LeyKS7zBH1F2Bs1Aa48d6dRkKN3uRmFYYfX+3kCbIwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKV2rLnqitKp9Ypr1fsRgTWsN1a94RhjXyeETjRPqvqs0ezoJedavgO+8R3u5bFrnCKRdvCnG2bJ/H3Am3Q+Fc+RIvT6i341P+MtNmu74kI6b/SsRQ6LjyGi1ATXkPryRWVFeKUW+zW/hclt9eLqyPE5o8dAzkMKUv3/+8YAn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxKmoFmu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2162c0f6a39so15519605ad.0;
        Mon, 09 Dec 2024 06:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733753158; x=1734357958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPy/Wa4sfWIv6r2JdpWfPhpUlAIM+rgHQUPWOAmdvfo=;
        b=KxKmoFmu8Rwtx+IIIe0DkaVU1H5hq1VFhPoQ0eqVMF9I0fqnKL7Xip351/e4ZtmxmK
         B2F+8GUNjNjriIybN/JDh9mPy/+xBDBBq4wnSGmTS++8PASHg9sdCpPxLgJUp/3TTrpk
         bnrUOrraO76b9ploTLngIqafVwARwOLKleVWZI5+MygTWF9sF6HMAoPZ0l1nMNngpN0Z
         k7K1pI/O+eLtDO7K/Uq9p7ZrSSVX+uwgwDgTjboZOmbw5n1Smq/URv48aKColdokrSs1
         BEj9mDYqkHhBXq8iKjdShyRAW9uzHENVAplstZ6X7622Zh4rj1kugyBB7lP2Sdle2M42
         dGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753158; x=1734357958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPy/Wa4sfWIv6r2JdpWfPhpUlAIM+rgHQUPWOAmdvfo=;
        b=wIiW/lZehs9MVkcp0ItrSN1r22RDEi51U9A10ok/4qvQ/+dlgOVtt6vgKg59Fra2Gx
         OtDi6z2iIG2Z2sY397vQ1QK1xdZQJysfQ+BplFiUclo+BbdE6GCYPuJBZgJIFjEBFbqR
         uG+ynQC3YmUIaeAsgiV/3oApa0A4dY46L0whMLiphp4yqW2VQCD8hPYzO7kKytlusLKN
         JEGaGQLaeXc/1xXZtszeMLnmXgr3oAYbS1YXGLSRi8gU/UCfB9YFS/UUS0juuIuQIEQX
         Hj9Wf7k1ky1eqr+sOBbqkXuOEzXp3AkKoF2hs+YnzOoZNNnr5wk0ipe/Xuq1bQ8wLUNW
         HJqg==
X-Forwarded-Encrypted: i=1; AJvYcCUxrDns0ySAWNNYI7e0oYDV1QXuhWW4JDHFAm4WeQwnLiLiEeCnsDtUn2Ij/JHNUlU37PYwaxX+g+y0Fk+p@vger.kernel.org, AJvYcCVlb7htj0+8eUGwfIs6UB50h7fQPwpiPLjIxW8+CtLKjAWByqLt+fVOJ+Mg69S8LkPXXREJmee1F2ct@vger.kernel.org, AJvYcCVnKxpVgORDVtCeRFMaF0boHpUTPsdWzXA44Lrkg0dcevMQPCDq6qCmgxL+cn91YhmTUeCpOfwGgmFNyw==@vger.kernel.org, AJvYcCWbTnajlkp7HUP1Su1+eN7gNfJlwmccF4zwYJ/c3KEG+0xLnLfUJeCkNogbx0oRVdHwkBcYFNymDrKTlg==@vger.kernel.org, AJvYcCXL7IhYMACpQhChumJdtosjAsZHh6adBbw5r1X6zasiIAbH5pqdvNP5V+Xd6bvFgxvY5acJiRuGn08r@vger.kernel.org, AJvYcCXMv6lzHhJNUMiOwIxUeweDFfBXpi+2TLH/Q7Tdzl3zT2medbaDVk4AO6iXjYI3Ey6Nq4zJq7jfv1+AeQM99Yg=@vger.kernel.org, AJvYcCXh6jnZqkR8bFW1v5nUrq+VIcQlCU+MAGLbs4T8eeepzW1pSg8MDZvackvYW9HWmpb7D3jN9geVsX0/V1zBOPj8@vger.kernel.org, AJvYcCXzyX6G8F8YoO8RqLJGcXYp+NGitGct6YcQj91jEUAwIv7zAbE/KIx6ZG2bW35p55oqNzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEvXql2nLyTl1qeUZjIXmPdt2TRsNytY2zFpJ4/l6eR1LxMt2
	nQicsLbIIyDhhfM9J3Z83LJPD7QRaMyLZJBdgi5/iew/j/r4iU/pOsfaTvp7GbQ=
X-Gm-Gg: ASbGncumNHZW9nBf2/snSCSykW6z3pd+Ul/iBne/jhj2Ph3jJUr3WJC4HYjY+D1htgC
	okNyJJd9Yp4O5G7XljnS1qcKji83ImQAp/mhWmn3Z5MzdTJ6Pj+UXZZQNt4MWsVjyBy+nFbN/H1
	sQ09qXBaAl0of3L60NOiJBGIdxtmVAlKPaenEHLyICbV3giaC03lNSPCyshbCcL8PpgVvKd/bjU
	RV7/VbooMQByjrixb7QvwK/opW84aXjgCwXKfMqLXggYOs=
X-Google-Smtp-Source: AGHT+IFhtw6aOaRBRqvTJbYhi/Fe6yXPqzisSZXdysCa+uK3mB+MiqtBQc7Dx64qWN61pTDIg+VOTg==
X-Received: by 2002:a17:902:ce03:b0:212:1abb:cba1 with SMTP id d9443c01a7336-21611b1362emr181353375ad.24.1733753156954;
        Mon, 09 Dec 2024 06:05:56 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:05:55 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 3/5] rtnetlink: Decouple net namespaces in rtnl_newlink_create()
Date: Mon,  9 Dec 2024 22:01:49 +0800
Message-ID: <20241209140151.231257-4-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209140151.231257-1-shaw.leon@gmail.com>
References: <20241209140151.231257-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 4 net namespaces involved when creating links:

 - source netns - where the netlink socket resides,
 - target netns - where to put the device being created,
 - link netns - netns associated with the device (backend),
 - peer netns - netns of peer device.

Currently, two nets are passed to newlink() callback - "src_net"
parameter and "dev_net" (implicitly in net_device). They are set as
follows, depending on netlink attributes.

 +------------+-------------------+---------+---------+
 | peer netns | IFLA_LINK_NETNSID | src_net | dev_net |
 +------------+-------------------+---------+---------+
 |            | absent            | source  | target  |
 | absent     +-------------------+---------+---------+
 |            | present           | link    | link    |
 +------------+-------------------+---------+---------+
 |            | absent            | peer    | target  |
 | present    +-------------------+---------+---------+
 |            | present           | peer    | link    |
 +------------+-------------------+---------+---------+

When IFLA_LINK_NETNSID is present, the device is created in link netns
first. This has some side effects, including extra ifindex allocation,
ifname validation and link notifications. There's also an extra step to
move the device to target netns. These could be avoided if we create it
in target netns at the beginning.

On the other hand, the meaning of src_net is ambiguous. It varies
depending on how parameters are passed. It is the effective link or peer
netns by design, but some drivers ignore it and use dev_net instead.

This patch refactors netns handling by packing newlink() parameters into
a struct, and passing source, link and peer netns as is through this
struct. Fallback logic is implemented in helper functions -
rtnl_newlink_link_net() and rtnl_newlink_peer_net(). If is not set, peer
netns falls back to link netns, and link netns falls back to source netns.
rtnl_newlink_create() now creates devices in target netns directly,
so dev_net is always target netns.

For drivers that use dev_net as fallback of link_netns, current behavior
is kept for compatibility.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---

There're some issues found when coverting drivers. Please check if they
work as intended:

- In amt_newlink() drivers/net/amt.c:

    amt->net = net;
    ...
    amt->stream_dev = dev_get_by_index(net, ...

  Uses net (src_net actually), but amt_lookup_upper_dev() only searches
  in dev_net.

- In gtp_newlink() in drivers/net/gtp.c:

    gtp->net = src_net;
    ...
    gn = net_generic(dev_net(dev), gtp_net_id);
    list_add_rcu(&gtp->list, &gn->gtp_dev_list);

  Uses src_net, but is linked to list in dev_net.

- In pfcp_newlink() in drivers/net/pfcp.c:

    pfcp->net = net;
    ...
    pn = net_generic(dev_net(dev), pfcp_net_id);
    list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);

  Same.

- In lowpan_newlink() in net/ieee802154/6lowpan/core.c:

    wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));

  Looks for IFLA_LINK in dev_net, but in theory the ifindex is defined
  in link netns.

---

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  | 11 +++--
 drivers/net/amt.c                             | 13 +++---
 drivers/net/bareudp.c                         | 11 +++--
 drivers/net/bonding/bond_netlink.c            |  8 ++--
 drivers/net/can/dev/netlink.c                 |  4 +-
 drivers/net/can/vxcan.c                       |  9 ++--
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 11 +++--
 drivers/net/geneve.c                          | 11 +++--
 drivers/net/gtp.c                             |  9 ++--
 drivers/net/ipvlan/ipvlan.h                   |  4 +-
 drivers/net/ipvlan/ipvlan_main.c              | 11 +++--
 drivers/net/ipvlan/ipvtap.c                   |  7 ++-
 drivers/net/macsec.c                          | 11 +++--
 drivers/net/macvlan.c                         |  8 ++--
 drivers/net/macvtap.c                         |  8 ++--
 drivers/net/netkit.c                          |  9 ++--
 drivers/net/pfcp.c                            |  8 ++--
 drivers/net/ppp/ppp_generic.c                 | 10 +++--
 drivers/net/team/team_core.c                  |  7 +--
 drivers/net/veth.c                            |  9 ++--
 drivers/net/vrf.c                             |  7 +--
 drivers/net/vxlan/vxlan_core.c                | 11 +++--
 drivers/net/wireguard/device.c                |  8 ++--
 drivers/net/wireless/virtual/virt_wifi.c      | 10 +++--
 drivers/net/wwan/wwan_core.c                  | 15 +++++--
 include/net/ip_tunnels.h                      |  5 ++-
 include/net/rtnetlink.h                       | 44 ++++++++++++++++---
 net/8021q/vlan_netlink.c                      | 11 +++--
 net/batman-adv/soft-interface.c               | 12 ++---
 net/bridge/br_netlink.c                       |  8 ++--
 net/caif/chnl_net.c                           |  6 +--
 net/core/rtnetlink.c                          | 25 +++++------
 net/hsr/hsr_netlink.c                         | 14 +++---
 net/ieee802154/6lowpan/core.c                 |  9 ++--
 net/ipv4/ip_gre.c                             | 27 ++++++++----
 net/ipv4/ip_tunnel.c                          | 10 +++--
 net/ipv4/ip_vti.c                             | 10 +++--
 net/ipv4/ipip.c                               | 10 +++--
 net/ipv6/ip6_gre.c                            | 28 +++++++-----
 net/ipv6/ip6_tunnel.c                         | 16 +++----
 net/ipv6/ip6_vti.c                            | 15 +++----
 net/ipv6/sit.c                                | 16 +++----
 net/xfrm/xfrm_interface_core.c                | 14 +++---
 43 files changed, 305 insertions(+), 205 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
index 9ad8d9856275..da587af85d4f 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
@@ -97,10 +97,13 @@ static int ipoib_changelink(struct net_device *dev, struct nlattr *tb[],
 	return ret;
 }
 
-static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
-				struct nlattr *tb[], struct nlattr *data[],
-				struct netlink_ext_ack *extack)
+static int ipoib_new_child_link(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct net_device *pdev;
 	struct ipoib_dev_priv *ppriv;
 	u16 child_pkey;
@@ -109,7 +112,7 @@ static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 
-	pdev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	pdev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!pdev || pdev->type != ARPHRD_INFINIBAND)
 		return -ENODEV;
 
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 98c6205ed19f..2f7bf50e05d2 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3161,14 +3161,17 @@ static int amt_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int amt_newlink(struct net *net, struct net_device *dev,
-		       struct nlattr *tb[], struct nlattr *data[],
-		       struct netlink_ext_ack *extack)
+static int amt_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct amt_dev *amt = netdev_priv(dev);
 	int err = -EINVAL;
 
-	amt->net = net;
+	amt->net = link_net;
 	amt->mode = nla_get_u32(data[IFLA_AMT_MODE]);
 
 	if (data[IFLA_AMT_MAX_TUNNELS] &&
@@ -3183,7 +3186,7 @@ static int amt_newlink(struct net *net, struct net_device *dev,
 	amt->hash_buckets = AMT_HSIZE;
 	amt->nr_tunnels = 0;
 	get_random_bytes(&amt->hash_seed, sizeof(amt->hash_seed));
-	amt->stream_dev = dev_get_by_index(net,
+	amt->stream_dev = dev_get_by_index(link_net,
 					   nla_get_u32(data[IFLA_AMT_LINK]));
 	if (!amt->stream_dev) {
 		NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_AMT_LINK],
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 70814303aab8..91e1c02ada72 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -698,10 +698,13 @@ static void bareudp_dellink(struct net_device *dev, struct list_head *head)
 	unregister_netdevice_queue(dev, head);
 }
 
-static int bareudp_newlink(struct net *net, struct net_device *dev,
-			   struct nlattr *tb[], struct nlattr *data[],
-			   struct netlink_ext_ack *extack)
+static int bareudp_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct bareudp_conf conf;
 	int err;
 
@@ -709,7 +712,7 @@ static int bareudp_newlink(struct net *net, struct net_device *dev,
 	if (err)
 		return err;
 
-	err = bareudp_configure(net, dev, &conf, extack);
+	err = bareudp_configure(link_net, dev, &conf, extack);
 	if (err)
 		return err;
 
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 2a6a424806aa..db3062c6dbe0 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -564,10 +564,12 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
 	return 0;
 }
 
-static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int bond_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *bond_dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
 	int err;
 
 	err = bond_changelink(bond_dev, tb, data, extack);
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 01aacdcda260..52dae0e94858 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -624,9 +624,7 @@ static int can_fill_xstats(struct sk_buff *skb, const struct net_device *dev)
 	return -EMSGSIZE;
 }
 
-static int can_newlink(struct net *src_net, struct net_device *dev,
-		       struct nlattr *tb[], struct nlattr *data[],
-		       struct netlink_ext_ack *extack)
+static int can_newlink(struct rtnl_newlink_params *params)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index ca8811941085..65ae07116c91 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -172,10 +172,13 @@ static void vxcan_setup(struct net_device *dev)
 /* forward declaration for rtnl_create_link() */
 static struct rtnl_link_ops vxcan_link_ops;
 
-static int vxcan_newlink(struct net *peer_net, struct net_device *dev,
-			 struct nlattr *tb[], struct nlattr *data[],
-			 struct netlink_ext_ack *extack)
+static int vxcan_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *peer_net = rtnl_newlink_peer_net(params);
 	struct vxcan_priv *priv;
 	struct net_device *peer;
 
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index f3bea196a8f9..d45555d784e6 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -117,10 +117,13 @@ static void rmnet_unregister_bridge(struct rmnet_port *port)
 	rmnet_unregister_real_device(bridge_dev);
 }
 
-static int rmnet_newlink(struct net *src_net, struct net_device *dev,
-			 struct nlattr *tb[], struct nlattr *data[],
-			 struct netlink_ext_ack *extack)
+static int rmnet_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	u32 data_format = RMNET_FLAGS_INGRESS_DEAGGREGATION;
 	struct net_device *real_dev;
 	int mode = RMNET_EPMODE_VND;
@@ -134,7 +137,7 @@ static int rmnet_newlink(struct net *src_net, struct net_device *dev,
 		return -EINVAL;
 	}
 
-	real_dev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	real_dev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev) {
 		NL_SET_ERR_MSG_MOD(extack, "link does not exist");
 		return -ENODEV;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 642155cb8315..77978617f509 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1614,10 +1614,13 @@ static void geneve_link_config(struct net_device *dev,
 	geneve_change_mtu(dev, ldev_mtu - info->options_len);
 }
 
-static int geneve_newlink(struct net *net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int geneve_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct geneve_config cfg = {
 		.df = GENEVE_DF_UNSET,
 		.use_udp6_rx_checksums = false,
@@ -1631,7 +1634,7 @@ static int geneve_newlink(struct net *net, struct net_device *dev,
 	if (err)
 		return err;
 
-	err = geneve_configure(net, dev, extack, &cfg);
+	err = geneve_configure(link_net, dev, extack, &cfg);
 	if (err)
 		return err;
 
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 89a996ad8cd0..3eb1bc3ac124 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1460,10 +1460,11 @@ static int gtp_create_sockets(struct gtp_dev *gtp, const struct nlattr *nla,
 #define GTP_TH_MAXLEN	(sizeof(struct udphdr) + sizeof(struct gtp0_header))
 #define GTP_IPV6_MAXLEN	(sizeof(struct ipv6hdr) + GTP_TH_MAXLEN)
 
-static int gtp_newlink(struct net *src_net, struct net_device *dev,
-		       struct nlattr *tb[], struct nlattr *data[],
-		       struct netlink_ext_ack *extack)
+static int gtp_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	unsigned int role = GTP_ROLE_GGSN;
 	struct gtp_dev *gtp;
 	struct gtp_net *gn;
@@ -1494,7 +1495,7 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 	gtp->restart_count = nla_get_u8_default(data[IFLA_GTP_RESTART_COUNT],
 						0);
 
-	gtp->net = src_net;
+	gtp->net = link_net;
 
 	err = gtp_hashtable_new(gtp, hashsize);
 	if (err < 0)
diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 025e0c19ec25..beff25a1d6f0 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -166,9 +166,7 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 void *ipvlan_get_L3_hdr(struct ipvl_port *port, struct sk_buff *skb, int *type);
 void ipvlan_count_rx(const struct ipvl_dev *ipvlan,
 		     unsigned int len, bool success, bool mcast);
-int ipvlan_link_new(struct net *src_net, struct net_device *dev,
-		    struct nlattr *tb[], struct nlattr *data[],
-		    struct netlink_ext_ack *extack);
+int ipvlan_link_new(struct rtnl_newlink_params *params);
 void ipvlan_link_delete(struct net_device *dev, struct list_head *head);
 void ipvlan_link_setup(struct net_device *dev);
 int ipvlan_link_register(struct rtnl_link_ops *ops);
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ee2c3cf4df36..53860e9d08b1 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -532,10 +532,13 @@ static int ipvlan_nl_fillinfo(struct sk_buff *skb,
 	return ret;
 }
 
-int ipvlan_link_new(struct net *src_net, struct net_device *dev,
-		    struct nlattr *tb[], struct nlattr *data[],
-		    struct netlink_ext_ack *extack)
+int ipvlan_link_new(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ipvl_port *port;
 	struct net_device *phy_dev;
@@ -545,7 +548,7 @@ int ipvlan_link_new(struct net *src_net, struct net_device *dev,
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 
-	phy_dev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	phy_dev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!phy_dev)
 		return -ENODEV;
 
diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 1afc4c47be73..69e7456a48ca 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -73,10 +73,9 @@ static void ipvtap_update_features(struct tap_dev *tap,
 	netdev_update_features(vlan->dev);
 }
 
-static int ipvtap_newlink(struct net *src_net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int ipvtap_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
 	struct ipvtap_dev *vlantap = netdev_priv(dev);
 	int err;
 
@@ -97,7 +96,7 @@ static int ipvtap_newlink(struct net *src_net, struct net_device *dev,
 	/* Don't put anything that may fail after macvlan_common_newlink
 	 * because we can't undo what it does.
 	 */
-	err =  ipvlan_link_new(src_net, dev, tb, data, extack);
+	err =  ipvlan_link_new(params);
 	if (err) {
 		netdev_rx_handler_unregister(dev);
 		return err;
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 1bc1e5993f56..e8b147fe4fce 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4141,10 +4141,13 @@ static int macsec_add_dev(struct net_device *dev, sci_t sci, u8 icv_len)
 
 static struct lock_class_key macsec_netdev_addr_lock_key;
 
-static int macsec_newlink(struct net *net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int macsec_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct macsec_dev *macsec = macsec_priv(dev);
 	rx_handler_func_t *rx_handler;
 	u8 icv_len = MACSEC_DEFAULT_ICV_LEN;
@@ -4154,7 +4157,7 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
-	real_dev = __dev_get_by_index(net, nla_get_u32(tb[IFLA_LINK]));
+	real_dev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev)
 		return -ENODEV;
 	if (real_dev->type != ARPHRD_ETHER)
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index fed4fe2a4748..7050a061b2b9 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1565,11 +1565,11 @@ int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(macvlan_common_newlink);
 
-static int macvlan_newlink(struct net *src_net, struct net_device *dev,
-			   struct nlattr *tb[], struct nlattr *data[],
-			   struct netlink_ext_ack *extack)
+static int macvlan_newlink(struct rtnl_newlink_params *params)
 {
-	return macvlan_common_newlink(src_net, dev, tb, data, extack);
+	return macvlan_common_newlink(rtnl_newlink_link_net(params),
+				      params->dev, params->tb, params->data,
+				      params->extack);
 }
 
 void macvlan_dellink(struct net_device *dev, struct list_head *head)
diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index 29a5929d48e5..213a16719c5a 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -77,10 +77,9 @@ static void macvtap_update_features(struct tap_dev *tap,
 	netdev_update_features(vlan->dev);
 }
 
-static int macvtap_newlink(struct net *src_net, struct net_device *dev,
-			   struct nlattr *tb[], struct nlattr *data[],
-			   struct netlink_ext_ack *extack)
+static int macvtap_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
 	struct macvtap_dev *vlantap = netdev_priv(dev);
 	int err;
 
@@ -105,7 +104,8 @@ static int macvtap_newlink(struct net *src_net, struct net_device *dev,
 	/* Don't put anything that may fail after macvlan_common_newlink
 	 * because we can't undo what it does.
 	 */
-	err = macvlan_common_newlink(src_net, dev, tb, data, extack);
+	err = macvlan_common_newlink(rtnl_newlink_link_net(params), dev,
+				     params->tb, params->data, params->extack);
 	if (err) {
 		netdev_rx_handler_unregister(dev);
 		return err;
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index c1d881dc6409..607d3b141f8c 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -327,10 +327,13 @@ static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
 
 static struct rtnl_link_ops netkit_link_ops;
 
-static int netkit_new_link(struct net *peer_net, struct net_device *dev,
-			   struct nlattr *tb[], struct nlattr *data[],
-			   struct netlink_ext_ack *extack)
+static int netkit_new_link(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *peer_net = rtnl_newlink_peer_net(params);
 	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb, *attr;
 	enum netkit_action policy_prim = NETKIT_PASS;
 	enum netkit_action policy_peer = NETKIT_PASS;
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 69434fd13f96..8576d5117233 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -184,15 +184,15 @@ static int pfcp_add_sock(struct pfcp_dev *pfcp)
 	return PTR_ERR_OR_ZERO(pfcp->sock);
 }
 
-static int pfcp_newlink(struct net *net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int pfcp_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct pfcp_dev *pfcp = netdev_priv(dev);
 	struct pfcp_net *pn;
 	int err;
 
-	pfcp->net = net;
+	pfcp->net = link_net;
 
 	err = pfcp_add_sock(pfcp);
 	if (err) {
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4583e15ad03a..a0ace8aa5b5d 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1303,10 +1303,12 @@ static int ppp_nl_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int ppp_nl_newlink(struct net *src_net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int ppp_nl_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct ppp_config conf = {
 		.unit = -1,
 		.ifname_is_set = true,
@@ -1343,7 +1345,7 @@ static int ppp_nl_newlink(struct net *src_net, struct net_device *dev,
 	if (!tb[IFLA_IFNAME] || !nla_len(tb[IFLA_IFNAME]) || !*(char *)nla_data(tb[IFLA_IFNAME]))
 		conf.ifname_is_set = false;
 
-	err = ppp_dev_configure(src_net, dev, &conf);
+	err = ppp_dev_configure(link_net, dev, &conf);
 
 out_unlock:
 	mutex_unlock(&ppp_mutex);
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index a1b27b69f010..c9ee70030517 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2206,10 +2206,11 @@ static void team_setup(struct net_device *dev)
 	dev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
 }
 
-static int team_newlink(struct net *src_net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int team_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+
 	if (tb[IFLA_ADDRESS] == NULL)
 		eth_hw_addr_random(dev);
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 07ebb800edf1..e9818f6b666b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1765,10 +1765,13 @@ static int veth_init_queues(struct net_device *dev, struct nlattr *tb[])
 	return 0;
 }
 
-static int veth_newlink(struct net *peer_net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int veth_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *peer_net = rtnl_newlink_peer_net(params);
 	int err;
 	struct net_device *peer;
 	struct veth_priv *priv;
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index ca81b212a246..ed1d47a473e2 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1677,10 +1677,11 @@ static void vrf_dellink(struct net_device *dev, struct list_head *head)
 	unregister_netdevice_queue(dev, head);
 }
 
-static int vrf_newlink(struct net *src_net, struct net_device *dev,
-		       struct nlattr *tb[], struct nlattr *data[],
-		       struct netlink_ext_ack *extack)
+static int vrf_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
 	struct net_vrf *vrf = netdev_priv(dev);
 	struct netns_vrf *nn_vrf;
 	bool *add_fib_rules;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b46a799bd390..2e27b19a557e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4351,10 +4351,13 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int vxlan_newlink(struct net *src_net, struct net_device *dev,
-			 struct nlattr *tb[], struct nlattr *data[],
-			 struct netlink_ext_ack *extack)
+static int vxlan_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct vxlan_config conf;
 	int err;
 
@@ -4362,7 +4365,7 @@ static int vxlan_newlink(struct net *src_net, struct net_device *dev,
 	if (err)
 		return err;
 
-	return __vxlan_dev_create(src_net, dev, &conf, extack);
+	return __vxlan_dev_create(link_net, dev, &conf, extack);
 }
 
 static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 6cf173a008e7..a27f844cfb7f 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -307,14 +307,14 @@ static void wg_setup(struct net_device *dev)
 	wg->dev = dev;
 }
 
-static int wg_newlink(struct net *src_net, struct net_device *dev,
-		      struct nlattr *tb[], struct nlattr *data[],
-		      struct netlink_ext_ack *extack)
+static int wg_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct wg_device *wg = netdev_priv(dev);
 	int ret = -ENOMEM;
 
-	rcu_assign_pointer(wg->creating_net, src_net);
+	rcu_assign_pointer(wg->creating_net, link_net);
 	init_rwsem(&wg->static_identity.lock);
 	mutex_init(&wg->socket_update_lock);
 	mutex_init(&wg->device_update_lock);
diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 4ee374080466..107dc503b4f2 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -519,10 +519,12 @@ static rx_handler_result_t virt_wifi_rx_handler(struct sk_buff **pskb)
 }
 
 /* Called with rtnl lock held. */
-static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
-			     struct nlattr *tb[], struct nlattr *data[],
-			     struct netlink_ext_ack *extack)
+static int virt_wifi_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct virt_wifi_netdev_priv *priv = netdev_priv(dev);
 	int err;
 
@@ -532,7 +534,7 @@ static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
 	netif_carrier_off(dev);
 
 	priv->upperdev = dev;
-	priv->lowerdev = __dev_get_by_index(src_net,
+	priv->lowerdev = __dev_get_by_index(link_net,
 					    nla_get_u32(tb[IFLA_LINK]));
 
 	if (!priv->lowerdev)
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index a51e2755991a..450cf2e253e4 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -967,10 +967,11 @@ static struct net_device *wwan_rtnl_alloc(struct nlattr *tb[],
 	return dev;
 }
 
-static int wwan_rtnl_newlink(struct net *src_net, struct net_device *dev,
-			     struct nlattr *tb[], struct nlattr *data[],
-			     struct netlink_ext_ack *extack)
+static int wwan_rtnl_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
 	struct wwan_device *wwandev = wwan_dev_get_by_parent(dev->dev.parent);
 	u32 link_id = nla_get_u32(data[IFLA_WWAN_LINK_ID]);
 	struct wwan_netdev_priv *priv = netdev_priv(dev);
@@ -1064,6 +1065,11 @@ static void wwan_create_default_link(struct wwan_device *wwandev,
 	struct net_device *dev;
 	struct nlmsghdr *nlh;
 	struct sk_buff *msg;
+	struct rtnl_newlink_params params = {
+		.src_net = &init_net,
+		.tb = tb,
+		.data = data,
+	};
 
 	/* Forge attributes required to create a WWAN netdev. We first
 	 * build a netlink message and then parse it. This looks
@@ -1105,7 +1111,8 @@ static void wwan_create_default_link(struct wwan_device *wwandev,
 	if (WARN_ON(IS_ERR(dev)))
 		goto unlock;
 
-	if (WARN_ON(wwan_rtnl_newlink(&init_net, dev, tb, data, NULL))) {
+	params.dev = dev;
+	if (WARN_ON(wwan_rtnl_newlink(&params))) {
 		free_netdev(dev);
 		goto unlock;
 	}
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1aa31bdb2b31..ae1f2dda4533 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -406,8 +406,9 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		  bool log_ecn_error);
 int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 			 struct ip_tunnel_parm_kern *p, __u32 fwmark);
-int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
-		      struct ip_tunnel_parm_kern *p, __u32 fwmark);
+int ip_tunnel_newlink(struct net *net, struct net_device *dev,
+		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
+		      __u32 fwmark);
 void ip_tunnel_setup(struct net_device *dev, unsigned int net_id);
 
 bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index bc0069a8b6ea..04fc0e91af42 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -69,6 +69,44 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 		return AF_UNSPEC;
 }
 
+/**
+ *	struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
+ *
+ *	@src_net: Source netns of rtnetlink socket
+ *	@link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
+ *	@peer_net: Peer netns
+ *	@dev: The net_device being created
+ *	@tb: IFLA_* attributes
+ *	@data: IFLA_INFO_DATA attributes
+ *	@extack: Netlink extended ACK
+ */
+struct rtnl_newlink_params {
+	struct net *src_net;
+	struct net *link_net;
+	struct net *peer_net;
+	struct net_device *dev;
+	struct nlattr **tb;
+	struct nlattr **data;
+	struct netlink_ext_ack *extack;
+};
+
+/* Get effective link netns from newlink params. Generally, this is link_net
+ * and falls back to src_net. But for compatibility, a driver may * choose to
+ * use dev_net(dev) instead.
+ */
+static inline struct net *rtnl_newlink_link_net(struct rtnl_newlink_params *p)
+{
+	return p->link_net ? : p->src_net;
+}
+
+/* Get peer netns from newlink params. Fallback to link netns if peer netns is
+ * not specified explicitly.
+ */
+static inline struct net *rtnl_newlink_peer_net(struct rtnl_newlink_params *p)
+{
+	return p->peer_net ? : rtnl_newlink_link_net(p);
+}
+
 /**
  *	struct rtnl_link_ops - rtnetlink link operations
  *
@@ -125,11 +163,7 @@ struct rtnl_link_ops {
 					    struct nlattr *data[],
 					    struct netlink_ext_ack *extack);
 
-	int			(*newlink)(struct net *src_net,
-					   struct net_device *dev,
-					   struct nlattr *tb[],
-					   struct nlattr *data[],
-					   struct netlink_ext_ack *extack);
+	int			(*newlink)(struct rtnl_newlink_params *params);
 	int			(*changelink)(struct net_device *dev,
 					      struct nlattr *tb[],
 					      struct nlattr *data[],
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index 134419667d59..603b2ea1e2b4 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -135,10 +135,13 @@ static int vlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	return 0;
 }
 
-static int vlan_newlink(struct net *src_net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int vlan_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 	struct net_device *real_dev;
 	unsigned int max_mtu;
@@ -155,7 +158,7 @@ static int vlan_newlink(struct net *src_net, struct net_device *dev,
 		return -EINVAL;
 	}
 
-	real_dev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	real_dev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev) {
 		NL_SET_ERR_MSG_MOD(extack, "link does not exist");
 		return -ENODEV;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 2758aba47a2f..c411b8857095 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1063,18 +1063,14 @@ static int batadv_softif_validate(struct nlattr *tb[], struct nlattr *data[],
 
 /**
  * batadv_softif_newlink() - pre-initialize and register new batadv link
- * @src_net: the applicable net namespace
- * @dev: network device to register
- * @tb: IFLA_INFO_DATA netlink attributes
- * @data: enum batadv_ifla_attrs attributes
- * @extack: extended ACK report struct
+ * @params: rtnl newlink parameters
  *
  * Return: 0 if successful or error otherwise.
  */
-static int batadv_softif_newlink(struct net *src_net, struct net_device *dev,
-				 struct nlattr *tb[], struct nlattr *data[],
-				 struct netlink_ext_ack *extack)
+static int batadv_softif_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
 	struct batadv_priv *bat_priv = netdev_priv(dev);
 	const char *algo_name;
 	int err;
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 3e0f47203f2a..ccce5119b28d 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1553,10 +1553,12 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 	return 0;
 }
 
-static int br_dev_newlink(struct net *src_net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int br_dev_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
 	struct net_bridge *br = netdev_priv(dev);
 	int err;
 
diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
index 94ad09e36df2..748e38908709 100644
--- a/net/caif/chnl_net.c
+++ b/net/caif/chnl_net.c
@@ -438,10 +438,10 @@ static void caif_netlink_parms(struct nlattr *data[],
 	}
 }
 
-static int ipcaif_newlink(struct net *src_net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int ipcaif_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
 	int ret;
 	struct chnl_net *caifdev;
 	ASSERT_RTNL();
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7855f81c917b..3ea63722d0fd 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3757,6 +3757,14 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	struct net_device *dev;
 	char ifname[IFNAMSIZ];
 	int err;
+	struct rtnl_newlink_params params = {
+		.src_net = net,
+		.link_net = link_net,
+		.peer_net = peer_net,
+		.tb = tb,
+		.data = data,
+		.extack = extack,
+	};
 
 	if (!ops->alloc && !ops->setup)
 		return -EOPNOTSUPP;
@@ -3768,22 +3776,18 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
 	}
 
 	dev->ifindex = ifm->ifi_index;
-
-	if (link_net)
-		net = link_net;
-	if (peer_net)
-		net = peer_net;
+	params.dev = dev;
 
 	if (ops->newlink)
-		err = ops->newlink(net, dev, tb, data, extack);
+		err = ops->newlink(&params);
 	else
 		err = register_netdevice(dev);
 	if (err < 0) {
@@ -3794,11 +3798,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
-	if (link_net) {
-		err = dev_change_net_namespace(dev, tgt_net, ifname);
-		if (err < 0)
-			goto out_unregister;
-	}
 	if (tb[IFLA_MASTER]) {
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
 		if (err)
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index b68f2f71d0e1..694392222637 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -29,10 +29,12 @@ static const struct nla_policy hsr_policy[IFLA_HSR_MAX + 1] = {
 /* Here, it seems a netdevice has already been allocated for us, and the
  * hsr_dev_setup routine has been executed. Nice!
  */
-static int hsr_newlink(struct net *src_net, struct net_device *dev,
-		       struct nlattr *tb[], struct nlattr *data[],
-		       struct netlink_ext_ack *extack)
+static int hsr_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	enum hsr_version proto_version;
 	unsigned char multicast_spec;
 	u8 proto = HSR_PROTOCOL_HSR;
@@ -46,7 +48,7 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 		NL_SET_ERR_MSG_MOD(extack, "Slave1 device not specified");
 		return -EINVAL;
 	}
-	link[0] = __dev_get_by_index(src_net,
+	link[0] = __dev_get_by_index(link_net,
 				     nla_get_u32(data[IFLA_HSR_SLAVE1]));
 	if (!link[0]) {
 		NL_SET_ERR_MSG_MOD(extack, "Slave1 does not exist");
@@ -56,7 +58,7 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 		NL_SET_ERR_MSG_MOD(extack, "Slave2 device not specified");
 		return -EINVAL;
 	}
-	link[1] = __dev_get_by_index(src_net,
+	link[1] = __dev_get_by_index(link_net,
 				     nla_get_u32(data[IFLA_HSR_SLAVE2]));
 	if (!link[1]) {
 		NL_SET_ERR_MSG_MOD(extack, "Slave2 does not exist");
@@ -69,7 +71,7 @@ static int hsr_newlink(struct net *src_net, struct net_device *dev,
 	}
 
 	if (data[IFLA_HSR_INTERLINK])
-		interlink = __dev_get_by_index(src_net,
+		interlink = __dev_get_by_index(link_net,
 					       nla_get_u32(data[IFLA_HSR_INTERLINK]));
 
 	if (interlink && interlink == link[0]) {
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 175efd860f7b..65a5c61cf38c 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -129,10 +129,10 @@ static int lowpan_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int lowpan_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *ldev = params->dev;
+	struct nlattr **tb = params->tb;
 	struct net_device *wdev;
 	int ret;
 
@@ -143,7 +143,8 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 	/* find and hold wpan device */
-	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
+	wdev = dev_get_by_index(params->link_net ? : dev_net(ldev),
+				nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
 		return -ENODEV;
 	if (wdev->type != ARPHRD_IEEE802154) {
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index f1f31ebfc793..4a3f8e450ef5 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1389,10 +1389,12 @@ ipgre_newlink_encap_setup(struct net_device *dev, struct nlattr *data[])
 	return 0;
 }
 
-static int ipgre_newlink(struct net *src_net, struct net_device *dev,
-			 struct nlattr *tb[], struct nlattr *data[],
-			 struct netlink_ext_ack *extack)
+static int ipgre_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct net *net = params->link_net ? : dev_net(dev);
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = 0;
 	int err;
@@ -1404,13 +1406,15 @@ static int ipgre_newlink(struct net *src_net, struct net_device *dev,
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(net, dev, tb, &p, fwmark);
 }
 
-static int erspan_newlink(struct net *src_net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int erspan_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct net *net = params->link_net ? : dev_net(dev);
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = 0;
 	int err;
@@ -1422,7 +1426,7 @@ static int erspan_newlink(struct net *src_net, struct net_device *dev,
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(net, dev, tb, &p, fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1695,6 +1699,10 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 	LIST_HEAD(list_kill);
 	struct ip_tunnel *t;
 	int err;
+	struct rtnl_newlink_params params = {
+		.src_net = net,
+		.tb = tb,
+	};
 
 	memset(&tb, 0, sizeof(tb));
 
@@ -1707,7 +1715,8 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 	t = netdev_priv(dev);
 	t->collect_md = true;
 
-	err = ipgre_newlink(net, dev, tb, NULL, NULL);
+	params.dev = dev;
+	err = ipgre_newlink(&params);
 	if (err < 0) {
 		free_netdev(dev);
 		return ERR_PTR(err);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 09b73acf037a..618a50d5c0c2 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1213,11 +1213,11 @@ void ip_tunnel_delete_nets(struct list_head *net_list, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
 
-int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
-		      struct ip_tunnel_parm_kern *p, __u32 fwmark)
+int ip_tunnel_newlink(struct net *net, struct net_device *dev,
+		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
+		      __u32 fwmark)
 {
 	struct ip_tunnel *nt;
-	struct net *net = dev_net(dev);
 	struct ip_tunnel_net *itn;
 	int mtu;
 	int err;
@@ -1326,7 +1326,9 @@ int ip_tunnel_init(struct net_device *dev)
 	}
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
+
 	strscpy(tunnel->parms.name, dev->name);
 	iph->version		= 4;
 	iph->ihl		= 5;
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index f0b4419cef34..b567e2375302 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -575,15 +575,17 @@ static void vti_netlink_parms(struct nlattr *data[],
 		*fwmark = nla_get_u32(data[IFLA_VTI_FWMARK]);
 }
 
-static int vti_newlink(struct net *src_net, struct net_device *dev,
-		       struct nlattr *tb[], struct nlattr *data[],
-		       struct netlink_ext_ack *extack)
+static int vti_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
 	struct ip_tunnel_parm_kern parms;
 	__u32 fwmark = 0;
 
 	vti_netlink_parms(data, &parms, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &parms, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb,
+				 &parms, fwmark);
 }
 
 static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index dc0db5895e0e..9dccaa0d6ba7 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -436,10 +436,11 @@ static void ipip_netlink_parms(struct nlattr *data[],
 		*fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-static int ipip_newlink(struct net *src_net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int ipip_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_encap ipencap;
 	struct ip_tunnel_parm_kern p;
@@ -453,7 +454,8 @@ static int ipip_newlink(struct net *src_net, struct net_device *dev,
 	}
 
 	ipip_netlink_parms(data, &p, &t->collect_md, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 235808cfec70..7d6d3db200a1 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1971,7 +1971,7 @@ static bool ip6gre_netlink_encap_parms(struct nlattr *data[],
 	return ret;
 }
 
-static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
+static int ip6gre_newlink_common(struct net *link_net, struct net_device *dev,
 				 struct nlattr *tb[], struct nlattr *data[],
 				 struct netlink_ext_ack *extack)
 {
@@ -1992,7 +1992,7 @@ static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
 		eth_hw_addr_random(dev);
 
 	nt->dev = dev;
-	nt->net = dev_net(dev);
+	nt->net = link_net;
 
 	err = register_netdevice(dev);
 	if (err)
@@ -2005,12 +2005,14 @@ static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
 	return err;
 }
 
-static int ip6gre_newlink(struct net *src_net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int ip6gre_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
 	struct ip6_tnl *nt = netdev_priv(dev);
-	struct net *net = dev_net(dev);
+	struct net *net = params->link_net ? : dev_net(dev);
 	struct ip6gre_net *ign;
 	int err;
 
@@ -2025,7 +2027,7 @@ static int ip6gre_newlink(struct net *src_net, struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6gre_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6gre_tunnel_link_md(ign, nt);
@@ -2241,12 +2243,14 @@ static void ip6erspan_tap_setup(struct net_device *dev)
 	netif_keep_dst(dev);
 }
 
-static int ip6erspan_newlink(struct net *src_net, struct net_device *dev,
-			     struct nlattr *tb[], struct nlattr *data[],
-			     struct netlink_ext_ack *extack)
+static int ip6erspan_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
 	struct ip6_tnl *nt = netdev_priv(dev);
-	struct net *net = dev_net(dev);
+	struct net *net = params->link_net ? : dev_net(dev);
 	struct ip6gre_net *ign;
 	int err;
 
@@ -2262,7 +2266,7 @@ static int ip6erspan_newlink(struct net *src_net, struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6erspan_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6erspan_tunnel_link_md(ign, nt);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 48fd53b98972..33a58c3c9ebe 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -250,10 +250,9 @@ static void ip6_dev_free(struct net_device *dev)
 	dst_cache_destroy(&t->dst_cache);
 }
 
-static int ip6_tnl_create2(struct net_device *dev)
+static int ip6_tnl_create2(struct net *net, struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	int err;
 
@@ -308,7 +307,7 @@ static struct ip6_tnl *ip6_tnl_create(struct net *net, struct __ip6_tnl_parm *p)
 	t = netdev_priv(dev);
 	t->parms = *p;
 	t->net = dev_net(dev);
-	err = ip6_tnl_create2(dev);
+	err = ip6_tnl_create2(net, dev);
 	if (err < 0)
 		goto failed_free;
 
@@ -2002,11 +2001,12 @@ static void ip6_tnl_netlink_parms(struct nlattr *data[],
 		parms->fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
-			   struct nlattr *tb[], struct nlattr *data[],
-			   struct netlink_ext_ack *extack)
+static int ip6_tnl_newlink(struct rtnl_newlink_params *params)
 {
-	struct net *net = dev_net(dev);
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct net *net = params->link_net ? : dev_net(dev);
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 	struct ip6_tnl *nt, *t;
@@ -2031,7 +2031,7 @@ static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
 			return -EEXIST;
 	}
 
-	err = ip6_tnl_create2(dev);
+	err = ip6_tnl_create2(net, dev);
 	if (!err && tb[IFLA_MTU])
 		ip6_tnl_change_mtu(dev, nla_get_u32(tb[IFLA_MTU]));
 
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 590737c27537..ff9dc74819c5 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -174,10 +174,9 @@ vti6_tnl_unlink(struct vti6_net *ip6n, struct ip6_tnl *t)
 	}
 }
 
-static int vti6_tnl_create2(struct net_device *dev)
+static int vti6_tnl_create2(struct net *net, struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
 	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
 	int err;
 
@@ -221,7 +220,7 @@ static struct ip6_tnl *vti6_tnl_create(struct net *net, struct __ip6_tnl_parm *p
 	t->parms = *p;
 	t->net = dev_net(dev);
 
-	err = vti6_tnl_create2(dev);
+	err = vti6_tnl_create2(net, dev);
 	if (err < 0)
 		goto failed_free;
 
@@ -997,11 +996,11 @@ static void vti6_netlink_parms(struct nlattr *data[],
 		parms->fwmark = nla_get_u32(data[IFLA_VTI_FWMARK]);
 }
 
-static int vti6_newlink(struct net *src_net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int vti6_newlink(struct rtnl_newlink_params *params)
 {
-	struct net *net = dev_net(dev);
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct net *net = params->link_net ? : dev_net(dev);
 	struct ip6_tnl *nt;
 
 	nt = netdev_priv(dev);
@@ -1012,7 +1011,7 @@ static int vti6_newlink(struct net *src_net, struct net_device *dev,
 	if (vti6_locate(net, &nt->parms, 0))
 		return -EEXIST;
 
-	return vti6_tnl_create2(dev);
+	return vti6_tnl_create2(net, dev);
 }
 
 static void vti6_dellink(struct net_device *dev, struct list_head *head)
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 39bd8951bfca..cbcaccbfc3c9 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -198,10 +198,9 @@ static void ipip6_tunnel_clone_6rd(struct net_device *dev, struct sit_net *sitn)
 #endif
 }
 
-static int ipip6_tunnel_create(struct net_device *dev)
+static int ipip6_tunnel_create(struct net *net, struct net_device *dev)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
 	struct sit_net *sitn = net_generic(net, sit_net_id);
 	int err;
 
@@ -270,7 +269,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	nt = netdev_priv(dev);
 
 	nt->parms = *parms;
-	if (ipip6_tunnel_create(dev) < 0)
+	if (ipip6_tunnel_create(net, dev) < 0)
 		goto failed_free;
 
 	if (!parms->name[0])
@@ -1550,11 +1549,12 @@ static bool ipip6_netlink_6rd_parms(struct nlattr *data[],
 }
 #endif
 
-static int ipip6_newlink(struct net *src_net, struct net_device *dev,
-			 struct nlattr *tb[], struct nlattr *data[],
-			 struct netlink_ext_ack *extack)
+static int ipip6_newlink(struct rtnl_newlink_params *params)
 {
-	struct net *net = dev_net(dev);
+	struct net_device *dev = params->dev;
+	struct nlattr **tb = params->tb;
+	struct nlattr **data = params->data;
+	struct net *net = params->link_net ? : dev_net(dev);
 	struct ip_tunnel *nt;
 	struct ip_tunnel_encap ipencap;
 #ifdef CONFIG_IPV6_SIT_6RD
@@ -1575,7 +1575,7 @@ static int ipip6_newlink(struct net *src_net, struct net_device *dev,
 	if (ipip6_tunnel_locate(net, &nt->parms, 0))
 		return -EEXIST;
 
-	err = ipip6_tunnel_create(dev);
+	err = ipip6_tunnel_create(net, dev);
 	if (err < 0)
 		return err;
 
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 98f1e2b67c76..d1f2674a98c8 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -242,10 +242,9 @@ static void xfrmi_dev_free(struct net_device *dev)
 	gro_cells_destroy(&xi->gro_cells);
 }
 
-static int xfrmi_create(struct net_device *dev)
+static int xfrmi_create(struct net *net, struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net *net = dev_net(dev);
 	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
 	int err;
 
@@ -814,11 +813,12 @@ static void xfrmi_netlink_parms(struct nlattr *data[],
 		parms->collect_md = true;
 }
 
-static int xfrmi_newlink(struct net *src_net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int xfrmi_newlink(struct rtnl_newlink_params *params)
 {
-	struct net *net = dev_net(dev);
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net *net = params->link_net ? : dev_net(dev);
 	struct xfrm_if_parms p = {};
 	struct xfrm_if *xi;
 	int err;
@@ -851,7 +851,7 @@ static int xfrmi_newlink(struct net *src_net, struct net_device *dev,
 	xi->net = net;
 	xi->dev = dev;
 
-	err = xfrmi_create(dev);
+	err = xfrmi_create(net, dev);
 	return err;
 }
 
-- 
2.47.1


