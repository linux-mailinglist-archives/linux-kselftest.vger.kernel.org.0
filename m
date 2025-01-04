Return-Path: <linux-kselftest+bounces-23903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340B8A01482
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 13:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A9D163ACA
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6741B87F9;
	Sat,  4 Jan 2025 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcn7+frp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158FD8F7D;
	Sat,  4 Jan 2025 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995489; cv=none; b=jAlb74oGrSVV04w5Hw6EsGNJ3Kf62cCcoTHexMRjH6pg7pvpra0yV05ufc+R3QlQZ1DnhCYjPaoeFDSsJSDETU+6FB4bYZht+DVffveSNBVRmA0ZaZVPPiDbZoxV9CDtxI/f9ySbBaVd5+67zjypOX528kxITk4H8cpzJU2JqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995489; c=relaxed/simple;
	bh=Ucub9/T7gaSD/I8zsfycQdyN0nB9yvM9fvN/8FiIxmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYkJIW9yZKYs3mqha9ioUTYR8BpyuEHVz4AMYOBEZBC8JSh3EAQahboSBsl+mJXDZ8RbQlzVAtaxaYwokEIF2u3FiK3QZP2eic3UpsfVU2SGPnhYYLQZ6xQREm0SPvbwzrgTl2OGtCQBkxCoStFlaLzmgV9xNHzXybnb+zhHlTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcn7+frp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21649a7bcdcso178339255ad.1;
        Sat, 04 Jan 2025 04:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995483; x=1736600283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcjpTs6Q+mfwNXdv6hpX4yssGC761QDhUklXs0pAhTs=;
        b=jcn7+frpF/9UcokVCmGR9+AAUYq2y2bNj5oDymOZrb+ypcYDiC3tx1Ys3MVfyEsGY3
         7bYA6iEVXXj83+QA7PNg+/Lnpxdmbx/L/o1aIo5Nti0ZxHxfqjqRb5CJIk/4n3QKJId2
         FbH3o7clRiYnUYsiuu/uvvGjIJJhyn5KQp/i/ETsbVaV/OYPzPzTcQCBiUH0Uey7DXIL
         klep1GEMakMilkc+20IiOM2hUBeTkX4dDv/BayBA+VDZnuGWMTlN7PH3HTcXIgb3mspP
         YiCEKIWLjkvp7GyvLwOg1bPadTTqJkpkJqWWRJCHV8DOJFERuf0OqGbkFdV9PnyG+UkJ
         bGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995483; x=1736600283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcjpTs6Q+mfwNXdv6hpX4yssGC761QDhUklXs0pAhTs=;
        b=DKktYnmpR/etJvE1dgwakxNzRLOP/2r4uTTDcYJ6ozJeN86fiC0LrHOG204ogiNZGB
         ihF4gWinUcggHxDFccKycvNL+uCM0RRtOfLxBxbY8BtLNa6uYpqi5KjlsD6XFtRrYBH5
         XFHQg88gG5UlYFP9BclayQxqdZmND8YxJc+9nEG+P5Qjs+bO+YN0AdSXX+yKLYmQRuC8
         3ATNmtlp7YXZq8hHnRnJLgoL4qK31yGfw3gDTTpU8UCITE3s9QZgPcdGiFiyS6XN+q7P
         Qr3iYpnvZHsgvFcM6uXKh2ZDMirKyDM8RoLK+83XQJexBVV/s+EQUn8nKtLIJ/6ymRtH
         LrqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTuSYdUbRRHDWQY0ZXAmRxxIKh/Q9+0mLxD/QxuYX8rHZtWrTR51+hKGXwD3xUxlZTMv4nkt1OosFnWKRoaomS@vger.kernel.org, AJvYcCUU8MRx3s9ZCNpW/uirCdb9yG3ADRmK2CIOokgg1bqhsIljug/nVoVTjKrVolrN/mKD9E6n+qxTarxS@vger.kernel.org, AJvYcCUhoV+oz+GNBZeGmpQXh1aOFVXazR4v4XXlmDiIsHEPzphXgsasa6Qz9T5dXTeMYuNDr1UiaCztybK085/W@vger.kernel.org, AJvYcCUk/ZC+r41EiZ1terRrWMxuJr3a/mogK0h0aXhYEWgZ14PMP7AaM6vCl48qzLDGrHUnKk+hbOqLn99drxer+qE=@vger.kernel.org, AJvYcCUnlvy0vo2DskElABFstETUcdv9T0fTVbXv+LwH84Go1pwSmJCKCJCWw2cYGSjqGiLn0iRV0nB2FYsepw==@vger.kernel.org, AJvYcCVDMbSTpyiVYyIy2gxexL3fY0Xgy1FI3RakrTnMWe3Sz0iJBfgbE2h1a+V2XiJgrh6o4io=@vger.kernel.org, AJvYcCWm8+isAD1+SQYi8oI9/FyQ7g14QAb92Jsdw8LhzJymK5UipFCEdEgOPXm/JiXOHEMYy5Y2OdfdiAq+6w==@vger.kernel.org, AJvYcCXa5q3nbJJpUivYtZg3b7IpFg0sjxpzQ4dTZaaMG2FWSym5xIp9qOI9RyXUog9LfnGzUFqeynS/+S+G@vger.kernel.org
X-Gm-Message-State: AOJu0YyInoKCE+yKSovlTEm4j4AJtYCicy7VIpS8PX76K0t1Tf1dj2mY
	VJZ5eqyfi3lZbqGPBzEgsiMN+qyJqk0zr1IQCd7KfsIk/rSNKijF0tkKeaUWE18=
X-Gm-Gg: ASbGncu6CRW5egbH3O166SplWMUeMeF23X4GImL+UUFVtNb4eUelHfWTb8Fhnrpv5TQ
	tsWuoXWe9o1gR41WNGT5q3OgUz2KA2MBchO9LNOo8aZkwoy9sd5+x9Kn0Kpw6E8MGeDzVXGLSOO
	iShABlpUsuj2FdSlNpITXotBeaVeGgTuOoQ/zrLlTgKMeaqf9kBXrEt5Xx+j0vEL6qMehzR7j8p
	2+sDpjFx4sTUa4wrKI+XpjSECFdlXw9GXxlTbpj5nKeVKI=
X-Google-Smtp-Source: AGHT+IEof4Ug9Jw0VMzYDDjW/tMo2iAMDI/x7nst5L28DNQsgH8g8chegJ2MfqyfFeNVpKOoy68daQ==
X-Received: by 2002:a05:6a00:3286:b0:725:b201:2353 with SMTP id d2e1a72fcca58-72abdec8856mr80567493b3a.13.1735995482888;
        Sat, 04 Jan 2025 04:58:02 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:02 -0800 (PST)
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
Subject: [PATCH net-next v7 02/11] rtnetlink: Pack newlink() params into struct
Date: Sat,  4 Jan 2025 20:57:23 +0800
Message-ID: <20250104125732.17335-3-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
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
follows, depending on netlink attributes in the request.

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
first and then moved to target netns. This has some side effects,
including extra ifindex allocation, ifname validation and link events.
These could be avoided if we create it in target netns from
the beginning.

On the other hand, the meaning of src_net parameter is ambiguous. It
varies depending on how parameters are passed. It is the effective
link (or peer netns) by design, but some drivers ignore it and use
dev_net instead.

This patch packs existing newlink() parameters, along with the source
netns, link netns and peer netns, into a struct. The old "src_net"
is renamed to "net" to avoid confusion with real source netns, and
will be deprecated later. The use of src_net are converted to
params->net trivially.

To make the semantics more clear, two helper functions -
rtnl_newlink_link_net() and rtnl_newlink_peer_net() - are provided
for netns fallback logic. Peer netns falls back to link netns, and
link netns falls back to source netns.

In following patches, to prepare for creating link in target netns
directly:

  - For device drivers that are aware of the old "src_net", the use of
    it are replace with one of the two helper functions.
  - And for those that takes dev_net() as link netns, we try
    params->link_net and then dev_net(), in order to maintain
    compatibility with the old behavior.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  |  9 ++--
 drivers/net/amt.c                             | 12 +++--
 drivers/net/bareudp.c                         |  9 ++--
 drivers/net/bonding/bond_netlink.c            |  8 ++--
 drivers/net/can/dev/netlink.c                 |  4 +-
 drivers/net/can/vxcan.c                       |  9 ++--
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |  9 ++--
 drivers/net/geneve.c                          |  9 ++--
 drivers/net/gtp.c                             |  7 +--
 drivers/net/ipvlan/ipvlan.h                   |  4 +-
 drivers/net/ipvlan/ipvlan_main.c              | 13 ++++--
 drivers/net/ipvlan/ipvtap.c                   | 10 ++--
 drivers/net/macsec.c                          | 13 ++++--
 drivers/net/macvlan.c                         |  7 ++-
 drivers/net/macvtap.c                         | 11 +++--
 drivers/net/netkit.c                          |  9 ++--
 drivers/net/pfcp.c                            |  9 ++--
 drivers/net/ppp/ppp_generic.c                 |  8 ++--
 drivers/net/team/team_core.c                  |  7 +--
 drivers/net/veth.c                            |  9 ++--
 drivers/net/vrf.c                             | 11 +++--
 drivers/net/vxlan/vxlan_core.c                |  9 ++--
 drivers/net/wireguard/device.c                |  9 ++--
 drivers/net/wireless/virtual/virt_wifi.c      | 12 +++--
 drivers/net/wwan/wwan_core.c                  | 25 +++++++---
 include/net/rtnetlink.h                       | 46 +++++++++++++++++--
 net/8021q/vlan_netlink.c                      | 13 ++++--
 net/batman-adv/soft-interface.c               | 16 +++----
 net/bridge/br_netlink.c                       | 12 +++--
 net/caif/chnl_net.c                           |  6 +--
 net/core/rtnetlink.c                          | 16 +++++--
 net/hsr/hsr_netlink.c                         |  8 ++--
 net/ieee802154/6lowpan/core.c                 |  6 +--
 net/ipv4/ip_gre.c                             | 21 ++++++---
 net/ipv4/ip_vti.c                             |  7 +--
 net/ipv4/ipip.c                               | 11 +++--
 net/ipv6/ip6_gre.c                            | 24 ++++++----
 net/ipv6/ip6_tunnel.c                         |  7 +--
 net/ipv6/ip6_vti.c                            |  6 +--
 net/ipv6/sit.c                                |  7 +--
 net/xfrm/xfrm_interface_core.c                |  7 +--
 41 files changed, 296 insertions(+), 159 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
index 9ad8d9856275..61f2457aab77 100644
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
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct net *src_net = params->net;
+	struct nlattr **tb = params->tb;
 	struct net_device *pdev;
 	struct ipoib_dev_priv *ppriv;
 	u16 child_pkey;
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 98c6205ed19f..85878abb51d2 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3161,13 +3161,17 @@ static int amt_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int amt_newlink(struct net *net, struct net_device *dev,
-		       struct nlattr *tb[], struct nlattr *data[],
-		       struct netlink_ext_ack *extack)
+static int amt_newlink(struct rtnl_newlink_params *params)
 {
-	struct amt_dev *amt = netdev_priv(dev);
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct nlattr **tb = params->tb;
+	struct net *net = params->net;
+	struct amt_dev *amt;
 	int err = -EINVAL;
 
+	amt = netdev_priv(dev);
 	amt->net = net;
 	amt->mode = nla_get_u32(data[IFLA_AMT_MODE]);
 
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 70814303aab8..4c2a50bbf7c0 100644
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
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct nlattr **tb = params->tb;
+	struct net *net = params->net;
 	struct bareudp_conf conf;
 	int err;
 
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 2a6a424806aa..39708a778285 100644
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
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *bond_dev = params->dev;
+	struct nlattr **data = params->data;
+	struct nlattr **tb = params->tb;
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
index ca8811941085..5d7717c22fab 100644
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
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct net *peer_net = params->net;
+	struct nlattr **tb = params->tb;
 	struct vxcan_priv *priv;
 	struct net_device *peer;
 
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index f3bea196a8f9..b4834651c693 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -117,11 +117,14 @@ static void rmnet_unregister_bridge(struct rmnet_port *port)
 	rmnet_unregister_real_device(bridge_dev);
 }
 
-static int rmnet_newlink(struct net *src_net, struct net_device *dev,
-			 struct nlattr *tb[], struct nlattr *data[],
-			 struct netlink_ext_ack *extack)
+static int rmnet_newlink(struct rtnl_newlink_params *params)
 {
 	u32 data_format = RMNET_FLAGS_INGRESS_DEAGGREGATION;
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct net *src_net = params->net;
+	struct nlattr **tb = params->tb;
 	struct net_device *real_dev;
 	int mode = RMNET_EPMODE_VND;
 	struct rmnet_endpoint *ep;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 642155cb8315..ea0a98a513ed 100644
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
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct nlattr **tb = params->tb;
+	struct net *net = params->net;
 	struct geneve_config cfg = {
 		.df = GENEVE_DF_UNSET,
 		.use_udp6_rx_checksums = false,
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 89a996ad8cd0..46d5734da7f3 100644
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
+	struct net *src_net = params->net;
 	unsigned int role = GTP_ROLE_GGSN;
 	struct gtp_dev *gtp;
 	struct gtp_net *gn;
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
index ee2c3cf4df36..a994fd54ada4 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -532,16 +532,21 @@ static int ipvlan_nl_fillinfo(struct sk_buff *skb,
 	return ret;
 }
 
-int ipvlan_link_new(struct net *src_net, struct net_device *dev,
-		    struct nlattr *tb[], struct nlattr *data[],
-		    struct netlink_ext_ack *extack)
+int ipvlan_link_new(struct rtnl_newlink_params *params)
 {
-	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct net *src_net = params->net;
+	struct nlattr **tb = params->tb;
+	struct ipvl_dev *ipvlan;
 	struct ipvl_port *port;
 	struct net_device *phy_dev;
 	int err;
 	u16 mode = IPVLAN_MODE_L3;
 
+	ipvlan = netdev_priv(dev);
+
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 
diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 1afc4c47be73..0b0c65390066 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -73,13 +73,13 @@ static void ipvtap_update_features(struct tap_dev *tap,
 	netdev_update_features(vlan->dev);
 }
 
-static int ipvtap_newlink(struct net *src_net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int ipvtap_newlink(struct rtnl_newlink_params *params)
 {
-	struct ipvtap_dev *vlantap = netdev_priv(dev);
+	struct net_device *dev = params->dev;
+	struct ipvtap_dev *vlantap;
 	int err;
 
+	vlantap = netdev_priv(dev);
 	INIT_LIST_HEAD(&vlantap->tap.queue_list);
 
 	/* Since macvlan supports all offloads by default, make
@@ -97,7 +97,7 @@ static int ipvtap_newlink(struct net *src_net, struct net_device *dev,
 	/* Don't put anything that may fail after macvlan_common_newlink
 	 * because we can't undo what it does.
 	 */
-	err =  ipvlan_link_new(src_net, dev, tb, data, extack);
+	err = ipvlan_link_new(params);
 	if (err) {
 		netdev_rx_handler_unregister(dev);
 		return err;
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 1bc1e5993f56..9da111a6629c 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4141,17 +4141,22 @@ static int macsec_add_dev(struct net_device *dev, sci_t sci, u8 icv_len)
 
 static struct lock_class_key macsec_netdev_addr_lock_key;
 
-static int macsec_newlink(struct net *net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int macsec_newlink(struct rtnl_newlink_params *params)
 {
-	struct macsec_dev *macsec = macsec_priv(dev);
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct nlattr **tb = params->tb;
+	struct net *net = params->net;
 	rx_handler_func_t *rx_handler;
 	u8 icv_len = MACSEC_DEFAULT_ICV_LEN;
 	struct net_device *real_dev;
+	struct macsec_dev *macsec;
 	int err, mtu;
 	sci_t sci;
 
+	macsec = macsec_priv(dev);
+
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 	real_dev = __dev_get_by_index(net, nla_get_u32(tb[IFLA_LINK]));
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index fed4fe2a4748..1915f54bd35a 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1565,11 +1565,10 @@ int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(macvlan_common_newlink);
 
-static int macvlan_newlink(struct net *src_net, struct net_device *dev,
-			   struct nlattr *tb[], struct nlattr *data[],
-			   struct netlink_ext_ack *extack)
+static int macvlan_newlink(struct rtnl_newlink_params *params)
 {
-	return macvlan_common_newlink(src_net, dev, tb, data, extack);
+	return macvlan_common_newlink(params->net, params->dev, params->tb,
+				      params->data, params->extack);
 }
 
 void macvlan_dellink(struct net_device *dev, struct list_head *head)
diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index 29a5929d48e5..e5fd8a147310 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -77,13 +77,13 @@ static void macvtap_update_features(struct tap_dev *tap,
 	netdev_update_features(vlan->dev);
 }
 
-static int macvtap_newlink(struct net *src_net, struct net_device *dev,
-			   struct nlattr *tb[], struct nlattr *data[],
-			   struct netlink_ext_ack *extack)
+static int macvtap_newlink(struct rtnl_newlink_params *params)
 {
-	struct macvtap_dev *vlantap = netdev_priv(dev);
+	struct net_device *dev = params->dev;
+	struct macvtap_dev *vlantap;
 	int err;
 
+	vlantap = netdev_priv(dev);
 	INIT_LIST_HEAD(&vlantap->tap.queue_list);
 
 	/* Since macvlan supports all offloads by default, make
@@ -105,7 +105,8 @@ static int macvtap_newlink(struct net *src_net, struct net_device *dev,
 	/* Don't put anything that may fail after macvlan_common_newlink
 	 * because we can't undo what it does.
 	 */
-	err = macvlan_common_newlink(src_net, dev, tb, data, extack);
+	err = macvlan_common_newlink(params->net, dev, params->tb, params->data,
+				     params->extack);
 	if (err) {
 		netdev_rx_handler_unregister(dev);
 		return err;
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index c1d881dc6409..f5527bb533ab 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -327,10 +327,13 @@ static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
 
 static struct rtnl_link_ops netkit_link_ops;
 
-static int netkit_new_link(struct net *peer_net, struct net_device *dev,
-			   struct nlattr *tb[], struct nlattr *data[],
-			   struct netlink_ext_ack *extack)
+static int netkit_new_link(struct rtnl_newlink_params *params)
 {
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct net *peer_net = params->net;
+	struct nlattr **tb = params->tb;
 	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb, *attr;
 	enum netkit_action policy_prim = NETKIT_PASS;
 	enum netkit_action policy_peer = NETKIT_PASS;
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 69434fd13f96..cb936da99674 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -184,14 +184,15 @@ static int pfcp_add_sock(struct pfcp_dev *pfcp)
 	return PTR_ERR_OR_ZERO(pfcp->sock);
 }
 
-static int pfcp_newlink(struct net *net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int pfcp_newlink(struct rtnl_newlink_params *params)
 {
-	struct pfcp_dev *pfcp = netdev_priv(dev);
+	struct net_device *dev = params->dev;
+	struct net *net = params->net;
+	struct pfcp_dev *pfcp;
 	struct pfcp_net *pn;
 	int err;
 
+	pfcp = netdev_priv(dev);
 	pfcp->net = net;
 
 	err = pfcp_add_sock(pfcp);
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4583e15ad03a..5b58e7bb4e7b 100644
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
+	struct nlattr **data = params->data;
+	struct net *src_net = params->net;
+	struct nlattr **tb = params->tb;
 	struct ppp_config conf = {
 		.unit = -1,
 		.ifname_is_set = true,
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index c7690adec8db..1e2a40196377 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2211,10 +2211,11 @@ static void team_setup(struct net_device *dev)
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
index 01251868a9c2..04229c07023d 100644
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
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct net *peer_net = params->net;
+	struct nlattr **tb = params->tb;
 	int err;
 	struct net_device *peer;
 	struct veth_priv *priv;
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index ca81b212a246..9a21bfc5bcc7 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1677,16 +1677,19 @@ static void vrf_dellink(struct net_device *dev, struct list_head *head)
 	unregister_netdevice_queue(dev, head);
 }
 
-static int vrf_newlink(struct net *src_net, struct net_device *dev,
-		       struct nlattr *tb[], struct nlattr *data[],
-		       struct netlink_ext_ack *extack)
+static int vrf_newlink(struct rtnl_newlink_params *params)
 {
-	struct net_vrf *vrf = netdev_priv(dev);
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
 	struct netns_vrf *nn_vrf;
+	struct net_vrf *vrf;
 	bool *add_fib_rules;
 	struct net *net;
 	int err;
 
+	vrf = netdev_priv(dev);
+
 	if (!data || !data[IFLA_VRF_TABLE]) {
 		NL_SET_ERR_MSG(extack, "VRF table id is missing");
 		return -EINVAL;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 05c10acb2a57..3d1088bf9acd 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4393,10 +4393,13 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int vxlan_newlink(struct net *src_net, struct net_device *dev,
-			 struct nlattr *tb[], struct nlattr *data[],
-			 struct netlink_ext_ack *extack)
+static int vxlan_newlink(struct rtnl_newlink_params *params)
 {
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct net *src_net = params->net;
+	struct nlattr **tb = params->tb;
 	struct vxlan_config conf;
 	int err;
 
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 6cf173a008e7..92aac080d2b5 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -307,13 +307,14 @@ static void wg_setup(struct net_device *dev)
 	wg->dev = dev;
 }
 
-static int wg_newlink(struct net *src_net, struct net_device *dev,
-		      struct nlattr *tb[], struct nlattr *data[],
-		      struct netlink_ext_ack *extack)
+static int wg_newlink(struct rtnl_newlink_params *params)
 {
-	struct wg_device *wg = netdev_priv(dev);
+	struct net_device *dev = params->dev;
+	struct net *src_net = params->net;
+	struct wg_device *wg;
 	int ret = -ENOMEM;
 
+	wg = netdev_priv(dev);
 	rcu_assign_pointer(wg->creating_net, src_net);
 	init_rwsem(&wg->static_identity.lock);
 	mutex_init(&wg->socket_update_lock);
diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 4ee374080466..d64eb03e0ac8 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -519,13 +519,17 @@ static rx_handler_result_t virt_wifi_rx_handler(struct sk_buff **pskb)
 }
 
 /* Called with rtnl lock held. */
-static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
-			     struct nlattr *tb[], struct nlattr *data[],
-			     struct netlink_ext_ack *extack)
+static int virt_wifi_newlink(struct rtnl_newlink_params *params)
 {
-	struct virt_wifi_netdev_priv *priv = netdev_priv(dev);
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct virt_wifi_netdev_priv *priv;
+	struct net *src_net = params->net;
+	struct nlattr **tb = params->tb;
 	int err;
 
+	priv = netdev_priv(dev);
+
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index a51e2755991a..908a3db61477 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -967,15 +967,20 @@ static struct net_device *wwan_rtnl_alloc(struct nlattr *tb[],
 	return dev;
 }
 
-static int wwan_rtnl_newlink(struct net *src_net, struct net_device *dev,
-			     struct nlattr *tb[], struct nlattr *data[],
-			     struct netlink_ext_ack *extack)
+static int wwan_rtnl_newlink(struct rtnl_newlink_params *params)
 {
-	struct wwan_device *wwandev = wwan_dev_get_by_parent(dev->dev.parent);
-	u32 link_id = nla_get_u32(data[IFLA_WWAN_LINK_ID]);
-	struct wwan_netdev_priv *priv = netdev_priv(dev);
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct wwan_netdev_priv *priv;
+	struct wwan_device *wwandev;
+	u32 link_id;
 	int ret;
 
+	wwandev = wwan_dev_get_by_parent(dev->dev.parent);
+	link_id = nla_get_u32(data[IFLA_WWAN_LINK_ID]);
+	priv = netdev_priv(dev);
+
 	if (IS_ERR(wwandev))
 		return PTR_ERR(wwandev);
 
@@ -1064,6 +1069,11 @@ static void wwan_create_default_link(struct wwan_device *wwandev,
 	struct net_device *dev;
 	struct nlmsghdr *nlh;
 	struct sk_buff *msg;
+	struct rtnl_newlink_params params = {
+		.net = &init_net,
+		.tb = tb,
+		.data = data,
+	};
 
 	/* Forge attributes required to create a WWAN netdev. We first
 	 * build a netlink message and then parse it. This looks
@@ -1105,7 +1115,8 @@ static void wwan_create_default_link(struct wwan_device *wwandev,
 	if (WARN_ON(IS_ERR(dev)))
 		goto unlock;
 
-	if (WARN_ON(wwan_rtnl_newlink(&init_net, dev, tb, data, NULL))) {
+	params.dev = dev;
+	if (WARN_ON(wwan_rtnl_newlink(&params))) {
 		free_netdev(dev);
 		goto unlock;
 	}
diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index bc0069a8b6ea..ed970b4568d1 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -69,6 +69,46 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 		return AF_UNSPEC;
 }
 
+/**
+ *	struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
+ *
+ *	@net: Netns of interest
+ *	@src_net: Source netns of rtnetlink socket
+ *	@link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
+ *	@peer_net: Peer netns
+ *	@dev: The net_device being created
+ *	@tb: IFLA_* attributes
+ *	@data: IFLA_INFO_DATA attributes
+ *	@extack: Netlink extended ACK
+ */
+struct rtnl_newlink_params {
+	struct net *net;
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
@@ -125,11 +165,7 @@ struct rtnl_link_ops {
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
index 134419667d59..26a0f0a2ce27 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -135,16 +135,21 @@ static int vlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	return 0;
 }
 
-static int vlan_newlink(struct net *src_net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int vlan_newlink(struct rtnl_newlink_params *params)
 {
-	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct net *src_net = params->net;
+	struct nlattr **tb = params->tb;
 	struct net_device *real_dev;
+	struct vlan_dev_priv *vlan;
 	unsigned int max_mtu;
 	__be16 proto;
 	int err;
 
+	vlan = vlan_dev_priv(dev);
+
 	if (!data[IFLA_VLAN_ID]) {
 		NL_SET_ERR_MSG_MOD(extack, "VLAN id not specified");
 		return -EINVAL;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 2758aba47a2f..5f92a25d6b26 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1063,22 +1063,20 @@ static int batadv_softif_validate(struct nlattr *tb[], struct nlattr *data[],
 
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
-	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct batadv_priv *bat_priv;
 	const char *algo_name;
 	int err;
 
+	bat_priv = netdev_priv(dev);
+
 	if (data && data[IFLA_BATADV_ALGO_NAME]) {
 		algo_name = nla_data(data[IFLA_BATADV_ALGO_NAME]);
 		err = batadv_algo_select(bat_priv, algo_name);
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 3e0f47203f2a..362ca10607ba 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1553,13 +1553,17 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 	return 0;
 }
 
-static int br_dev_newlink(struct net *src_net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int br_dev_newlink(struct rtnl_newlink_params *params)
 {
-	struct net_bridge *br = netdev_priv(dev);
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct nlattr **tb = params->tb;
+	struct net_bridge *br;
 	int err;
 
+	br = netdev_priv(dev);
+
 	err = register_netdevice(dev);
 	if (err)
 		return err;
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
index f65bd49da541..f902b8a5189f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3757,6 +3757,15 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	struct net_device *dev;
 	char ifname[IFNAMSIZ];
 	int err;
+	struct rtnl_newlink_params params = {
+		.net = net,
+		.src_net = net,
+		.link_net = link_net,
+		.peer_net = peer_net,
+		.tb = tb,
+		.data = data,
+		.extack = extack,
+	};
 
 	if (!ops->alloc && !ops->setup)
 		return -EOPNOTSUPP;
@@ -3776,14 +3785,15 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	}
 
 	dev->ifindex = ifm->ifi_index;
+	params.dev = dev;
 
 	if (link_net)
-		net = link_net;
+		params.net = link_net;
 	if (peer_net)
-		net = peer_net;
+		params.net = peer_net;
 
 	if (ops->newlink)
-		err = ops->newlink(net, dev, tb, data, extack);
+		err = ops->newlink(&params);
 	else
 		err = register_netdevice(dev);
 	if (err < 0) {
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index b68f2f71d0e1..08d38e2e2962 100644
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
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct net *src_net = params->net;
 	enum hsr_version proto_version;
 	unsigned char multicast_spec;
 	u8 proto = HSR_PROTOCOL_HSR;
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 175efd860f7b..c16c14807d87 100644
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
 
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index a020342f618d..71eb651e2b44 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1392,10 +1392,11 @@ ipgre_newlink_encap_setup(struct net_device *dev, struct nlattr *data[])
 	return 0;
 }
 
-static int ipgre_newlink(struct net *src_net, struct net_device *dev,
-			 struct nlattr *tb[], struct nlattr *data[],
-			 struct netlink_ext_ack *extack)
+static int ipgre_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct nlattr **tb = params->tb;
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = 0;
 	int err;
@@ -1410,10 +1411,11 @@ static int ipgre_newlink(struct net *src_net, struct net_device *dev,
 	return ip_tunnel_newlink(dev, tb, &p, fwmark);
 }
 
-static int erspan_newlink(struct net *src_net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int erspan_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct nlattr **tb = params->tb;
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = 0;
 	int err;
@@ -1698,6 +1700,10 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 	LIST_HEAD(list_kill);
 	struct ip_tunnel *t;
 	int err;
+	struct rtnl_newlink_params params = {
+		.net = net,
+		.tb = tb,
+	};
 
 	memset(&tb, 0, sizeof(tb));
 
@@ -1710,7 +1716,8 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 	t = netdev_priv(dev);
 	t->collect_md = true;
 
-	err = ipgre_newlink(net, dev, tb, NULL, NULL);
+	params.dev = dev;
+	err = ipgre_newlink(&params);
 	if (err < 0) {
 		free_netdev(dev);
 		return ERR_PTR(err);
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index f0b4419cef34..12ccbf34fb6c 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -575,11 +575,12 @@ static void vti_netlink_parms(struct nlattr *data[],
 		*fwmark = nla_get_u32(data[IFLA_VTI_FWMARK]);
 }
 
-static int vti_newlink(struct net *src_net, struct net_device *dev,
-		       struct nlattr *tb[], struct nlattr *data[],
-		       struct netlink_ext_ack *extack)
+static int vti_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
 	struct ip_tunnel_parm_kern parms;
+	struct nlattr **tb = params->tb;
 	__u32 fwmark = 0;
 
 	vti_netlink_parms(data, &parms, &fwmark);
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index dc0db5895e0e..3a737ea3c2e5 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -436,15 +436,18 @@ static void ipip_netlink_parms(struct nlattr *data[],
 		*fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-static int ipip_newlink(struct net *src_net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int ipip_newlink(struct rtnl_newlink_params *params)
 {
-	struct ip_tunnel *t = netdev_priv(dev);
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct nlattr **tb = params->tb;
 	struct ip_tunnel_encap ipencap;
 	struct ip_tunnel_parm_kern p;
+	struct ip_tunnel *t;
 	__u32 fwmark = 0;
 
+	t = netdev_priv(dev);
+
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 235808cfec70..3efd51f0d7d2 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2005,15 +2005,19 @@ static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
 	return err;
 }
 
-static int ip6gre_newlink(struct net *src_net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
+static int ip6gre_newlink(struct rtnl_newlink_params *params)
 {
-	struct ip6_tnl *nt = netdev_priv(dev);
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct net *src_net = params->net;
+	struct nlattr **tb = params->tb;
 	struct net *net = dev_net(dev);
 	struct ip6gre_net *ign;
+	struct ip6_tnl *nt;
 	int err;
 
+	nt = netdev_priv(dev);
 	ip6gre_netlink_parms(data, &nt->parms);
 	ign = net_generic(net, ip6gre_net_id);
 
@@ -2241,15 +2245,19 @@ static void ip6erspan_tap_setup(struct net_device *dev)
 	netif_keep_dst(dev);
 }
 
-static int ip6erspan_newlink(struct net *src_net, struct net_device *dev,
-			     struct nlattr *tb[], struct nlattr *data[],
-			     struct netlink_ext_ack *extack)
+static int ip6erspan_newlink(struct rtnl_newlink_params *params)
 {
-	struct ip6_tnl *nt = netdev_priv(dev);
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct net *src_net = params->net;
+	struct nlattr **tb = params->tb;
 	struct net *net = dev_net(dev);
 	struct ip6gre_net *ign;
+	struct ip6_tnl *nt;
 	int err;
 
+	nt = netdev_priv(dev);
 	ip6gre_netlink_parms(data, &nt->parms);
 	ip6erspan_set_version(data, &nt->parms);
 	ign = net_generic(net, ip6gre_net_id);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 48fd53b98972..f4bdbabc3246 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2002,10 +2002,11 @@ static void ip6_tnl_netlink_parms(struct nlattr *data[],
 		parms->fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
-			   struct nlattr *tb[], struct nlattr *data[],
-			   struct netlink_ext_ack *extack)
+static int ip6_tnl_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct nlattr **tb = params->tb;
 	struct net *net = dev_net(dev);
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 590737c27537..79e601e629d2 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -997,10 +997,10 @@ static void vti6_netlink_parms(struct nlattr *data[],
 		parms->fwmark = nla_get_u32(data[IFLA_VTI_FWMARK]);
 }
 
-static int vti6_newlink(struct net *src_net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int vti6_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
 	struct net *net = dev_net(dev);
 	struct ip6_tnl *nt;
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 39bd8951bfca..4dd1309d1eb3 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1550,10 +1550,11 @@ static bool ipip6_netlink_6rd_parms(struct nlattr *data[],
 }
 #endif
 
-static int ipip6_newlink(struct net *src_net, struct net_device *dev,
-			 struct nlattr *tb[], struct nlattr *data[],
-			 struct netlink_ext_ack *extack)
+static int ipip6_newlink(struct rtnl_newlink_params *params)
 {
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
+	struct nlattr **tb = params->tb;
 	struct net *net = dev_net(dev);
 	struct ip_tunnel *nt;
 	struct ip_tunnel_encap ipencap;
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 98f1e2b67c76..77d50d4af4a1 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -814,10 +814,11 @@ static void xfrmi_netlink_parms(struct nlattr *data[],
 		parms->collect_md = true;
 }
 
-static int xfrmi_newlink(struct net *src_net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int xfrmi_newlink(struct rtnl_newlink_params *params)
 {
+	struct netlink_ext_ack *extack = params->extack;
+	struct net_device *dev = params->dev;
+	struct nlattr **data = params->data;
 	struct net *net = dev_net(dev);
 	struct xfrm_if_parms p = {};
 	struct xfrm_if *xi;
-- 
2.47.1


