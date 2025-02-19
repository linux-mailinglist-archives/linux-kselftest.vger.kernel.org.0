Return-Path: <linux-kselftest+bounces-26961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB0CA3BEC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3334B189279D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BDB1EB1B3;
	Wed, 19 Feb 2025 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwx2aFAp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B241E9B0C;
	Wed, 19 Feb 2025 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969484; cv=none; b=Kq9F1pbxqgucYi6OCXmhiPxEyUA6rVa8Jifp+dnvVv9tqv8sonIAqr2dx8qYxFoCDWDYOhXFtMwy/51tXavfoHVvXDE+d9vQvlgYX+wt9Bcd/KqvVzw6Bq4puCU2nDEOUjRC8B+bTuCYuEgWdPyY01R/CVtE260n4GIrpvn40qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969484; c=relaxed/simple;
	bh=8eR0wqjLqOmuxHlxb3OVVBO1kE9FkqjGLjioV06GSQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3U1nyr9iQm79pDdVNVyMm59YW+BC1g1UEDXLxyVcFpPubQG2quwyxxz6CHiM5AeZtF/ICGTXAey10OBLi+pFi2vqeh6YNZu723wKRMyeBCmaSabCzMq0eXfa/yoESoxXwD8Jui8Lij2Tl/Q3S2gZiCJ1g/2qi1OWeicrbKHN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwx2aFAp; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso8790013a91.1;
        Wed, 19 Feb 2025 04:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969481; x=1740574281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/A97M2zaAkPkySBdEofVw8pgt3e2mXhNRi7YscGFBDg=;
        b=dwx2aFApbKuzziHv8B+Qb2uqDyeLujKZOXLeKVmn1PCAgQSSKxN+7b1c2VGsdTi0jZ
         JQPKsdvZr9KnvbBRHn7kJXKhLg9sRd09yK/RS+jY/waG2IaGzqbayl0CW3bB6OwE59zi
         K8JCRwWwijmpy+7PzBNZEQJ6HK/NhKJKw3qkHHWhcwUY4C+hynTkBI1AkGgLMtncNWHh
         ayRoy5coixOezkCtZpKPU/ElCxPaFQfx+VLHEOZwG55LyvCDH/IJPgbVRHd85OyvrLNH
         yDow+eOPPJXltvxcVfbyFPijaYZasGkLELsQyUx0+TL3vcaqEe4pgXngtVuCL3ofeO6m
         /4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969481; x=1740574281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/A97M2zaAkPkySBdEofVw8pgt3e2mXhNRi7YscGFBDg=;
        b=XRAK6/G9pfQY61IYCZOw7qgtKCbbeE+KuR8rT0Hvo6bzQy4rLkRv15JlFZl2LDQvUS
         Gy80VWt2nkuEqjw4QHbcjHemkOYXop6q2/MtJLSY28RIR3WrgS7Ytznmq7lJJyI8bjdJ
         nn9tWOT3qtqbj72u3KVyBN2K2G2bzuABIF4EFhI+lPn5Aoeof0ZiPXNcwv/ISk4UXY0y
         y3aVXnRS48zwGcqs7EJ+eafArstf/zEXHeaKcwwZLDSX5YILwLXaqepDnhuL6P0F43Ah
         R29vTPQ3NDr2JS6XpZilLw2cgri/xxb3tbImUY25uAQtHzefMa5orJ4iZOu48hiW0VaF
         LW2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbtyJQFrI2nBKH+x3yLEK6uWhxt6hzHt3SRhYZlpd+4633acId0aZZuKcySWRBlf6LZtKiW8eFgOHkTruTWkg=@vger.kernel.org, AJvYcCVnoZKlOqgDku5NRWG6jC2VvGwWH3SJZbY/Vdh8jmI9ebXuyM2MeHUbkIdFiMEw1zBG0/g=@vger.kernel.org, AJvYcCVwR8ZKyKdcqobzhE359/7KretXmWjj+ydrAaeX51vUZyT9DQyrkHVEzkkDWSQTEvMb/eP05bSdys1i@vger.kernel.org, AJvYcCWJgjp56YmQMjZxVoyMR53HmUGMpzqGXJc0TrKMmQmzr+zA/3Z/Yt3TdNt9i9hsFC3JLsQzVSAnb/5a@vger.kernel.org, AJvYcCXMtDTbeA9bHfLgI91UDL1EM0q0xrY7XrpZidukAEUXbKzU0HbSC9/1H4U9BaCSbkUEY0TYTCQcuJZTLGZY@vger.kernel.org, AJvYcCXSmXT2mbeCDtZQIjKX1cA6yRvOcFZ3ytsDAMRodlUu/RM8624oTxyok9Rxl3prGPDGnRIZUS1l2wMFgw==@vger.kernel.org, AJvYcCXY7FhlUDT1NTjFp6mZKMaYxAPZMrv+erfkvOqcbCrSNS9gqCYdQjrrEvhbZTO6Ihy4HXgOAY1L10GkYA==@vger.kernel.org, AJvYcCXiHTaZP4iQJaHgYH8FUfWXOH1JLssMkMrG+WIGrMnc75u8LW5ntVFyjODtbnGdCUdKqz1JGH/BK/c7yMvnN+48@vger.kernel.org
X-Gm-Message-State: AOJu0YyotuK6C1njft9sPsVU10PTx34HFbXmI5EhXPlh0LAnoPY85Drw
	wlw76IT7Y09We8v+uSMz3QiVilmlJkLr8zrJ+2zRjj5g7liWX+Z1advWCMt2NWY=
X-Gm-Gg: ASbGnctNHEul/gv+7fy4eZB24WHtc8wPU7zHMIn9p7k6qjVun5ZhvaKcqNGs6hSZSYs
	tappyVTBWoTGsm+ceLeQpjGC5RsWIgh1Xeo1f2j2Wr3WaLWLyvZuyHuPNsFFAmURaG5HbCVqpzy
	WkcdOQ8vBU0/XKoVXWgSJfi3F0nEpDr8uzKdURVD3+NrtkqPdRGLwlQSe1oa9WV5j0CT2BZXbY9
	OE/W3aUBncmluieymZIoLUkHBvlqdZlA/3lgtjJ/fAx3jRk2rgouTGV1xs0sTOhN0TnOp4hpn2f
	URJnqg==
X-Google-Smtp-Source: AGHT+IEUBhWwXPGbJB0c/P5YYbS1mahzsL5jnLOAoTy7sthWzlPO0yNFcwasqXoaMOXW8LwfTV2dYw==
X-Received: by 2002:a17:90b:3dce:b0:2fa:20f4:d27f with SMTP id 98e67ed59e1d1-2fc41154398mr23076583a91.32.1739969481387;
        Wed, 19 Feb 2025 04:51:21 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:20 -0800 (PST)
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
Subject: [PATCH net-next v10 03/13] net: Use link/peer netns in newlink() of rtnl_link_ops
Date: Wed, 19 Feb 2025 20:50:29 +0800
Message-ID: <20250219125039.18024-4-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two helper functions - rtnl_newlink_link_net() and
rtnl_newlink_peer_net() for netns fallback logic. Peer netns falls back
to link netns, and link netns falls back to source netns.

Convert the use of params->net in netdevice drivers to one of the helper
functions for clarity.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c    |  4 ++--
 drivers/net/amt.c                               |  6 +++---
 drivers/net/bareudp.c                           |  4 ++--
 drivers/net/can/vxcan.c                         |  2 +-
 .../net/ethernet/qualcomm/rmnet/rmnet_config.c  |  4 ++--
 drivers/net/geneve.c                            |  4 ++--
 drivers/net/gtp.c                               |  6 +++---
 drivers/net/ipvlan/ipvlan_main.c                |  4 ++--
 drivers/net/macsec.c                            |  4 ++--
 drivers/net/macvlan.c                           |  4 ++--
 drivers/net/netkit.c                            |  2 +-
 drivers/net/pfcp.c                              |  6 +++---
 drivers/net/ppp/ppp_generic.c                   |  4 ++--
 drivers/net/veth.c                              |  2 +-
 drivers/net/vxlan/vxlan_core.c                  |  4 ++--
 drivers/net/wireguard/device.c                  |  4 ++--
 drivers/net/wireless/virtual/virt_wifi.c        |  4 ++--
 drivers/net/wwan/wwan_core.c                    |  2 +-
 include/net/rtnetlink.h                         | 17 +++++++++++++++++
 net/8021q/vlan_netlink.c                        |  4 ++--
 net/hsr/hsr_netlink.c                           |  8 ++++----
 21 files changed, 58 insertions(+), 41 deletions(-)

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
index 8151e91395e2..ba8763cac9d9 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -121,9 +121,9 @@ static int rmnet_newlink(struct net_device *dev,
 			 struct rtnl_newlink_params *params,
 			 struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	u32 data_format = RMNET_FLAGS_INGRESS_DEAGGREGATION;
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
index d6d4326cb908..2cf43e7d0edc 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1466,8 +1466,8 @@ static int gtp_newlink(struct net_device *dev,
 		       struct rtnl_newlink_params *params,
 		       struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	unsigned int role = GTP_ROLE_GGSN;
 	struct gtp_dev *gtp;
 	struct gtp_net *gn;
@@ -1498,7 +1498,7 @@ static int gtp_newlink(struct net_device *dev,
 	gtp->restart_count = nla_get_u8_default(data[IFLA_GTP_RESTART_COUNT],
 						0);
 
-	gtp->net = src_net;
+	gtp->net = link_net;
 
 	err = gtp_hashtable_new(gtp, hashsize);
 	if (err < 0)
@@ -1528,7 +1528,7 @@ static int gtp_newlink(struct net_device *dev,
 		goto out_encap;
 	}
 
-	gn = net_generic(src_net, gtp_net_id);
+	gn = net_generic(link_net, gtp_net_id);
 	list_add(&gtp->list, &gn->gtp_dev_list);
 	dev->priv_destructor = gtp_destructor;
 
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
index f903b414eaeb..4e9d54be887c 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1444,9 +1444,9 @@ int macvlan_common_newlink(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct macvlan_dev *vlan = netdev_priv(dev);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct net_device *lowerdev;
 	struct macvlan_port *port;
@@ -1457,7 +1457,7 @@ int macvlan_common_newlink(struct net_device *dev,
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 
-	lowerdev = __dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
+	lowerdev = __dev_get_by_index(link_net, nla_get_u32(tb[IFLA_LINK]));
 	if (lowerdev == NULL)
 		return -ENODEV;
 
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 640a2dbbbd28..751347392570 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -331,13 +331,13 @@ static int netkit_new_link(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
 {
+	struct net *peer_net = rtnl_newlink_peer_net(params);
 	enum netkit_scrub scrub_prim = NETKIT_SCRUB_DEFAULT;
 	enum netkit_scrub scrub_peer = NETKIT_SCRUB_DEFAULT;
 	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp, *attr;
 	enum netkit_action policy_prim = NETKIT_PASS;
 	enum netkit_action policy_peer = NETKIT_PASS;
 	struct nlattr **data = params->data;
-	struct net *peer_net = params->net;
 	enum netkit_mode mode = NETKIT_L3;
 	unsigned char ifname_assign_type;
 	struct nlattr **tb = params->tb;
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 7b0575940e1d..f873a92d2445 100644
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
@@ -207,7 +207,7 @@ static int pfcp_newlink(struct net_device *dev,
 		goto exit_del_pfcp_sock;
 	}
 
-	pn = net_generic(net, pfcp_net_id);
+	pn = net_generic(link_net, pfcp_net_id);
 	list_add(&pfcp->list, &pn->pfcp_dev_list);
 
 	netdev_dbg(dev, "registered new PFCP interface\n");
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
index 09a4a5bf1038..f1212a9256f6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4404,8 +4404,8 @@ static int vxlan_newlink(struct net_device *dev,
 			 struct rtnl_newlink_params *params,
 			 struct netlink_ext_ack *extack)
 {
+	struct net *link_net = rtnl_newlink_link_net(params);
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
 	struct vxlan_config conf;
 	int err;
@@ -4414,7 +4414,7 @@ static int vxlan_newlink(struct net_device *dev,
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
index a05c49b4e7f8..63a47d420bc5 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -1065,7 +1065,7 @@ static void wwan_create_default_link(struct wwan_device *wwandev,
 	struct nlattr *tb[IFLA_MAX + 1], *linkinfo[IFLA_INFO_MAX + 1];
 	struct nlattr *data[IFLA_WWAN_MAX + 1];
 	struct rtnl_newlink_params params = {
-		.net = &init_net,
+		.src_net = &init_net,
 		.tb = tb,
 		.data = data,
 	};
diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 563a6a27436c..b22a106621fb 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -88,6 +88,23 @@ struct rtnl_newlink_params {
 	struct nlattr **data;
 };
 
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
2.48.1


