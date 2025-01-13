Return-Path: <linux-kselftest+bounces-24369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B703DA0B9BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678B93A68D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6E284A6A;
	Mon, 13 Jan 2025 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXaf42pl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DE124633B;
	Mon, 13 Jan 2025 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779088; cv=none; b=YtyXWrCAyyW9UPsGhveXIXFT7g8ta7m/OIy4vx5jZ1DDxEWj+fl53ABGPnPtfz5Ers9/f4jvglqC6laaVg5S/IVdMAhJ0K7t2dDIN0vRxsrdnCN6GlxhKS3xtfZAWebP8XkcIJtriy9hz9jOIz39cjTYwH4wdEsHp8iGcFaa/K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779088; c=relaxed/simple;
	bh=yVXZazNTD2EBAWknl/LWkjWGKnNjfNLy9fPEJ6+d1rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Om4MinTlDxz3G0E7SzffK/e839bMHdsTzRzuO3vdhIssooQDfRs87NGGlMXjyP3C6Hk3TV5X4bxWeZWw2tj4lLUGLNRH0U+5eDDBHFiEUykV1IBRgv9GGPHX8GMhqJtzk5bbatPHrNt9umPnO/w5Gb55xRzKNFbQMWRwzs9UywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXaf42pl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163b0c09afso78914825ad.0;
        Mon, 13 Jan 2025 06:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779084; x=1737383884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZBCyw57IE7Zso6/WsMTOb7GBu1vP4ikeykgITmoGTY=;
        b=WXaf42pliAXm7S2hpDW6Y50VJZyXP3nvAsohzdfG/FQwrTQQNC6qhuBc2DK5nLJpBt
         aST/j5jIhKYoMnt2Br4UIFHJYdLE8Q9r8BYPAUovI4j4EN1K0EB3aep/tFajE5n1Nhjm
         HLuNicT/DFMcw5W22vgkSCp4YB0s9pfZLThlQdsOPUrA3UUFq7b7i/ILZPpmUxCBrXmY
         +hQF01Dd4CGE32IbGWWGFxgKNIFahlVsVAS36x1hNUbB6fvikc+PvhxtH2I+kxaV+Ndm
         OA3AWchpBvOb1u8GUM6NS/KhrLSlov3wrpLhc4rd5PJbpyRiacwt6U6pdpmheiW/1r/+
         OJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779084; x=1737383884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZBCyw57IE7Zso6/WsMTOb7GBu1vP4ikeykgITmoGTY=;
        b=ezZpZFe6rJ009dvDMl2+AINVfA/THqMF9yZSqw6tdtcm8l0+OZ1mQGLBI/R7CGJ1w3
         RhDBSv3kuodFNNkcpj/3tNcwu3UkfRLTx/T9HPn2aF/eAU5GJziyMFEJxJW2/6A1+K7A
         QPqdQchNQaYY7U2oEYQNAbsuGpOHxo30+kZwBPe63YhhmpYS1vhML/8yt6rrp3NKXX4f
         ++h9zgGPdWTfWSeSRP5wlTnYd9gwO0nmmTHLZqGHlmBEQMIFker4HYMxZOlDEz1oz519
         EwLLxkojsIfUymAPRgU7GRgtqoQjJNmlXx7JT/gezwMzUJem+MkoQp0GtfiLGBPC+Kyd
         3eXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDrD4Oix9RrrIxxidzHG0vYDg1S/iS/hdvBp0QhmVaoxUuM4oM1Xwq9ANtzO59L/5BJVqtI8qxGf6OYoM5r4RF@vger.kernel.org, AJvYcCUqd+cCn/MzZu4gciqOA9KaDg8kA6JOWMaVVAtJQwzTbPjMe/OqiWxnxG4WX8K4IwVYoERK0m+lUg6J@vger.kernel.org, AJvYcCVBU+D/J6dMuNMHX81KXaRiy68XcLCQWRoL1URptgfbP3+Nlxj8fJJ5Z6M9kdYgdG1MnzQ=@vger.kernel.org, AJvYcCVQAyqTntfopVU8owlO4Vpwl2MYUKbZcuoMmlTScygEAslQDrzUbomF0y9KhobljvUpBfQiDJ2HfWYK@vger.kernel.org, AJvYcCVmpp65t6x+HXGgeZzHTFFw4CD5n5JkiAjxharKd3GTsut/sdzvlDFaJLj4QMsSBgvAMcfQLsFOYeR8QVuA@vger.kernel.org, AJvYcCVoVA7mUaJ9eN7vthXp5aYC9Tg1J7keRNzcodoQ4SAB5fxD03iVpMHE1Hr0oDpyEyRPsClhsd44IPgInQ==@vger.kernel.org, AJvYcCWGT6SnKvdojOPbFrwcZ+3SCRQhfArNyGZFOOwmSnxPpUzxUxgeDxTqXWSJo39oS8Z1S2M8wdJRbNwKvg==@vger.kernel.org, AJvYcCWnOLOfHoClGKsRI9FaVj6EFEg+K0zyJO5V5KePVlgyofn2cPwJIfnWBkyRPk7L9Cvn6xHTd290fmPhKTUxvtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeU/4C+ATvrglbabxKJNL9fj5ONv9LPiEK+OqHttPLW7h9TMgU
	xxP6uZWBuOsEB8/394g6m69dJ+dx4+SIArAMrRhdOkkexKe0lo5ggh3GkoikL6k=
X-Gm-Gg: ASbGncviWypHVfx51Ts138AHQFDkyQX0o21diRdjXm4xA+AvwTxoM6HryJfY2RDg3YX
	1p9rPQ2rqkKqBW/GDpN4sX3ccskqubbDJFFyjj47uB7GpdsBZ3nDvMmWqj5AOHhrLh9lXXM743c
	V8mKPg3wPkbysaJlY//447Hmd37zmBObTuKI1VoJxjNa/7XSgUBmJTShcQJOGE+sNCoO69Ltz7d
	5cMovbHNlsQRSDrEuaLX/WK00sch9kDgHxtRoGxnp8EAvU=
X-Google-Smtp-Source: AGHT+IE+8qVbma2Qb/CZO5qK/8pf/aA+GET4Kf+ksPfd0XQFxcjbmABnzOsLzbZBSWi1j8h4JBn4Hg==
X-Received: by 2002:a17:903:32ce:b0:215:b8c6:338a with SMTP id d9443c01a7336-21a83f338a5mr322037415ad.4.1736779084410;
        Mon, 13 Jan 2025 06:38:04 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:03 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
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
Subject: [PATCH net-next v8 03/11] net: Use link netns in newlink() of rtnl_link_ops
Date: Mon, 13 Jan 2025 22:37:11 +0800
Message-ID: <20250113143719.7948-4-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113143719.7948-1-shaw.leon@gmail.com>
References: <20250113143719.7948-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These netdevice drivers already uses netns parameter in newlink()
callback. Convert them to use rtnl_newlink_link_net() or
rtnl_newlink_peer_net() for clarity and deprecate params->net.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c       | 4 ++--
 drivers/net/amt.c                                  | 6 +++---
 drivers/net/bareudp.c                              | 4 ++--
 drivers/net/can/vxcan.c                            | 2 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 4 ++--
 drivers/net/geneve.c                               | 4 ++--
 drivers/net/gtp.c                                  | 4 ++--
 drivers/net/ipvlan/ipvlan_main.c                   | 4 ++--
 drivers/net/macsec.c                               | 4 ++--
 drivers/net/macvlan.c                              | 4 ++--
 drivers/net/macvtap.c                              | 4 ++--
 drivers/net/netkit.c                               | 2 +-
 drivers/net/pfcp.c                                 | 4 ++--
 drivers/net/ppp/ppp_generic.c                      | 4 ++--
 drivers/net/veth.c                                 | 2 +-
 drivers/net/vxlan/vxlan_core.c                     | 4 ++--
 drivers/net/wireguard/device.c                     | 4 ++--
 drivers/net/wireless/virtual/virt_wifi.c           | 4 ++--
 drivers/net/wwan/wwan_core.c                       | 2 +-
 net/8021q/vlan_netlink.c                           | 4 ++--
 net/hsr/hsr_netlink.c                              | 8 ++++----
 21 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
index 16cb8ced9f35..53db7c8191e3 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
@@ -101,8 +101,8 @@ static int ipoib_new_child_link(struct net_device *dev,
 				struct rtnl_newlink_params *params,
 				struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct net_device *pdev;
 	struct ipoib_dev_priv *ppriv;
@@ -112,7 +112,7 @@ static int ipoib_new_child_link(struct net_device *dev,
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 
-	pdev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	pdev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!pdev || pdev->type != ARPHRD_INFINIBAND)
 		return -ENODEV;
 
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 96b7ec9a2c13..53899b70fae1 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3165,13 +3165,13 @@ static int amt_newlink(struct net_device *dev,
 		       struct rtnl_newlink_params *params,
 		       struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct amt_dev *amt = netdev_priv(dev);
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = params->net;
 	int err = -EINVAL;
 
-	amt->net = net;
+	amt->net = link_net;
 	amt->mode = nla_get_u32(data[IFLA_AMT_MODE]);
 
 	if (data[IFLA_AMT_MAX_TUNNELS] &&
@@ -3186,7 +3186,7 @@ static int amt_newlink(struct net_device *dev,
 	amt->hash_buckets = AMT_HSIZE;
 	amt->nr_tunnels = 0;
 	get_random_bytes(&amt->hash_seed, sizeof(amt->hash_seed));
-	amt->stream_dev = dev_get_by_index(net,
+	amt->stream_dev = dev_get_by_index(link_net,
 					   nla_get_u32(data[IFLA_AMT_LINK]));
 	if (!amt->stream_dev) {
 		NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_AMT_LINK],
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index fc21dcfb4848..d1473c5f8eef 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -702,9 +702,9 @@ static int bareudp_newlink(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = params->net;
 	struct bareudp_conf conf;
 	int err;
 
@@ -712,7 +712,7 @@ static int bareudp_newlink(struct net_device *dev,
 	if (err)
 		return err;
 
-	err = bareudp_configure(net, dev, &conf, extack);
+	err = bareudp_configure(link_net, dev, &conf, extack);
 	if (err)
 		return err;
 
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 6f8ebb1cfd7b..99a78a757167 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -176,8 +176,8 @@ static int vxcan_newlink(struct net_device *dev,
 			 struct rtnl_newlink_params *params,
 			 struct netlink_ext_ack *extack)
 {
+	struct net *peer_net = rtnl_newlink_peer_net(params);
 	struct nlattr **data = params->data;
-	struct net *peer_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct vxcan_priv *priv;
 	struct net_device *peer;
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 8151e91395e2..ab7e5b6649b2 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -122,8 +122,8 @@ static int rmnet_newlink(struct net_device *dev,
 			 struct netlink_ext_ack *extack)
 {
 	u32 data_format = RMNET_FLAGS_INGRESS_DEAGGREGATION;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct net_device *real_dev;
 	int mode = RMNET_EPMODE_VND;
@@ -137,7 +137,7 @@ static int rmnet_newlink(struct net_device *dev,
 		return -EINVAL;
 	}
 
-	real_dev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	real_dev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev) {
 		NL_SET_ERR_MSG_MOD(extack, "link does not exist");
 		return -ENODEV;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index d373a851930c..c7700deefb00 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1618,9 +1618,9 @@ static int geneve_newlink(struct net_device *dev,
 			  struct rtnl_newlink_params *params,
 			  struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = params->net;
 	struct geneve_config cfg = {
 		.df = GENEVE_DF_UNSET,
 		.use_udp6_rx_checksums = false,
@@ -1634,7 +1634,7 @@ static int geneve_newlink(struct net_device *dev,
 	if (err)
 		return err;
 
-	err = geneve_configure(net, dev, extack, &cfg);
+	err = geneve_configure(link_net, dev, extack, &cfg);
 	if (err)
 		return err;
 
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 80ad618ba423..646d0fdd42f4 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1464,8 +1464,8 @@ static int gtp_newlink(struct net_device *dev,
 		       struct rtnl_newlink_params *params,
 		       struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	unsigned int role = GTP_ROLE_GGSN;
 	struct gtp_dev *gtp;
 	struct gtp_net *gn;
@@ -1496,7 +1496,7 @@ static int gtp_newlink(struct net_device *dev,
 	gtp->restart_count = nla_get_u8_default(data[IFLA_GTP_RESTART_COUNT],
 						0);
 
-	gtp->net = src_net;
+	gtp->net = link_net;
 
 	err = gtp_hashtable_new(gtp, hashsize);
 	if (err < 0)
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 19ce19ca7e32..b56144ca2fde 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -535,9 +535,9 @@ static int ipvlan_nl_fillinfo(struct sk_buff *skb,
 int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 		    struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct ipvl_port *port;
 	struct net_device *phy_dev;
@@ -547,7 +547,7 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 
-	phy_dev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	phy_dev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!phy_dev)
 		return -ENODEV;
 
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 1869b0513f57..4de5d63fd577 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4145,10 +4145,10 @@ static int macsec_newlink(struct net_device *dev,
 			  struct rtnl_newlink_params *params,
 			  struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct macsec_dev *macsec = macsec_priv(dev);
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = params->net;
 	rx_handler_func_t *rx_handler;
 	u8 icv_len = MACSEC_DEFAULT_ICV_LEN;
 	struct net_device *real_dev;
@@ -4157,7 +4157,7 @@ static int macsec_newlink(struct net_device *dev,
 
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
-	real_dev = __dev_get_by_index(net, nla_get_u32(tb[IFLA_LINK]));
+	real_dev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev)
 		return -ENODEV;
 	if (real_dev->type != ARPHRD_ETHER)
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 0c496aa1f706..689759bbd159 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1569,8 +1569,8 @@ static int macvlan_newlink(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
 {
-	return macvlan_common_newlink(params->net, dev, params->tb,
-				      params->data, extack);
+	return macvlan_common_newlink(rtnl_newlink_link_net(params), dev,
+				      params->tb, params->data, extack);
 }
 
 void macvlan_dellink(struct net_device *dev, struct list_head *head)
diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index 6dbfeeac5c99..ee1bfd4298c2 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -105,8 +105,8 @@ static int macvtap_newlink(struct net_device *dev,
 	/* Don't put anything that may fail after macvlan_common_newlink
 	 * because we can't undo what it does.
 	 */
-	err = macvlan_common_newlink(params->net, dev, params->tb, params->data,
-				     extack);
+	err = macvlan_common_newlink(rtnl_newlink_link_net(params), dev,
+				     params->tb, params->data, extack);
 	if (err) {
 		netdev_rx_handler_unregister(dev);
 		return err;
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 1e9eadc77da2..d278d7697cee 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -331,8 +331,8 @@ static int netkit_new_link(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
 {
+	struct net *peer_net = rtnl_newlink_peer_net(params);
 	struct nlattr **data = params->data;
-	struct net *peer_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb, *attr;
 	enum netkit_action policy_prim = NETKIT_PASS;
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index d9e4b5185c51..33eaded152ce 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -188,12 +188,12 @@ static int pfcp_newlink(struct net_device *dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct pfcp_dev *pfcp = netdev_priv(dev);
-	struct net *net = params->net;
 	struct pfcp_net *pn;
 	int err;
 
-	pfcp->net = net;
+	pfcp->net = link_net;
 
 	err = pfcp_add_sock(pfcp);
 	if (err) {
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index b3340f8a6149..6220866258fc 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1307,8 +1307,8 @@ static int ppp_nl_newlink(struct net_device *dev,
 			  struct rtnl_newlink_params *params,
 			  struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct ppp_config conf = {
 		.unit = -1,
@@ -1346,7 +1346,7 @@ static int ppp_nl_newlink(struct net_device *dev,
 	if (!tb[IFLA_IFNAME] || !nla_len(tb[IFLA_IFNAME]) || !*(char *)nla_data(tb[IFLA_IFNAME]))
 		conf.ifname_is_set = false;
 
-	err = ppp_dev_configure(src_net, dev, &conf);
+	err = ppp_dev_configure(link_net, dev, &conf);
 
 out_unlock:
 	mutex_unlock(&ppp_mutex);
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 7dfda89f072f..ba3ae2d8092f 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1769,8 +1769,8 @@ static int veth_newlink(struct net_device *dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
 {
+	struct net *peer_net = rtnl_newlink_peer_net(params);
 	struct nlattr **data = params->data;
-	struct net *peer_net = params->net;
 	struct nlattr **tb = params->tb;
 	int err;
 	struct net_device *peer;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 86c620b4c26f..cd0964823864 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4397,8 +4397,8 @@ static int vxlan_newlink(struct net_device *dev,
 			 struct rtnl_newlink_params *params,
 			 struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct vxlan_config conf;
 	int err;
@@ -4407,7 +4407,7 @@ static int vxlan_newlink(struct net_device *dev,
 	if (err)
 		return err;
 
-	return __vxlan_dev_create(src_net, dev, &conf, extack);
+	return __vxlan_dev_create(link_net, dev, &conf, extack);
 }
 
 static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 404cf05bd72b..c496d35b266d 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -311,11 +311,11 @@ static int wg_newlink(struct net_device *dev,
 		      struct rtnl_newlink_params *params,
 		      struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct wg_device *wg = netdev_priv(dev);
-	struct net *src_net = params->net;
 	int ret = -ENOMEM;
 
-	rcu_assign_pointer(wg->creating_net, src_net);
+	rcu_assign_pointer(wg->creating_net, link_net);
 	init_rwsem(&wg->static_identity.lock);
 	mutex_init(&wg->socket_update_lock);
 	mutex_init(&wg->device_update_lock);
diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 26905b2b3ba3..f9d11a023313 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -524,7 +524,7 @@ static int virt_wifi_newlink(struct net_device *dev,
 			     struct netlink_ext_ack *extack)
 {
 	struct virt_wifi_netdev_priv *priv = netdev_priv(dev);
-	struct net *src_net = params->net;
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **tb = params->tb;
 	int err;
 
@@ -534,7 +534,7 @@ static int virt_wifi_newlink(struct net_device *dev,
 	netif_carrier_off(dev);
 
 	priv->upperdev = dev;
-	priv->lowerdev = __dev_get_by_index(src_net,
+	priv->lowerdev = __dev_get_by_index(link_net,
 					    nla_get_u32(tb[IFLA_LINK]));
 
 	if (!priv->lowerdev)
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 53a6c437ff79..34e34bc3ae94 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -1068,7 +1068,7 @@ static void wwan_create_default_link(struct wwan_device *wwandev,
 	struct nlmsghdr *nlh;
 	struct sk_buff *msg;
 	struct rtnl_newlink_params params = {
-		.net = &init_net,
+		.src_net = &init_net,
 		.tb = tb,
 		.data = data,
 	};
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index 91df0f96e32a..a000b1ef0520 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -139,9 +139,9 @@ static int vlan_newlink(struct net_device *dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct net_device *real_dev;
 	unsigned int max_mtu;
@@ -158,7 +158,7 @@ static int vlan_newlink(struct net_device *dev,
 		return -EINVAL;
 	}
 
-	real_dev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	real_dev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (!real_dev) {
 		NL_SET_ERR_MSG_MOD(extack, "link does not exist");
 		return -ENODEV;
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 39add538ba99..b120470246cc 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -33,8 +33,8 @@ static int hsr_newlink(struct net_device *dev,
 		       struct rtnl_newlink_params *params,
 		       struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	enum hsr_version proto_version;
 	unsigned char multicast_spec;
 	u8 proto = HSR_PROTOCOL_HSR;
@@ -48,7 +48,7 @@ static int hsr_newlink(struct net_device *dev,
 		NL_SET_ERR_MSG_MOD(extack, "Slave1 device not specified");
 		return -EINVAL;
 	}
-	link[0] = __dev_get_by_index(src_net,
+	link[0] = __dev_get_by_index(link_net,
 				     nla_get_u32(data[IFLA_HSR_SLAVE1]));
 	if (!link[0]) {
 		NL_SET_ERR_MSG_MOD(extack, "Slave1 does not exist");
@@ -58,7 +58,7 @@ static int hsr_newlink(struct net_device *dev,
 		NL_SET_ERR_MSG_MOD(extack, "Slave2 device not specified");
 		return -EINVAL;
 	}
-	link[1] = __dev_get_by_index(src_net,
+	link[1] = __dev_get_by_index(link_net,
 				     nla_get_u32(data[IFLA_HSR_SLAVE2]));
 	if (!link[1]) {
 		NL_SET_ERR_MSG_MOD(extack, "Slave2 does not exist");
@@ -71,7 +71,7 @@ static int hsr_newlink(struct net_device *dev,
 	}
 
 	if (data[IFLA_HSR_INTERLINK])
-		interlink = __dev_get_by_index(src_net,
+		interlink = __dev_get_by_index(link_net,
 					       nla_get_u32(data[IFLA_HSR_INTERLINK]));
 
 	if (interlink && interlink == link[0]) {
-- 
2.47.1


