Return-Path: <linux-kselftest+bounces-23503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F039F66C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 14:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78291894BCD
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD561F9408;
	Wed, 18 Dec 2024 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZG1Vlzc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2115A1F37A0;
	Wed, 18 Dec 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527410; cv=none; b=ENfY3S62VJ11PnWpmkNyNFpmIIGEOmNFtCM2jnmk/9S3we9h1O8UyPKey7N/jPQ5Opa+x6wisUFlD1peI/fa6lNh02xckFiXCc/vw+zTHRhk6kppXBd7guR++QmsAatBwgqGRqLIHhCCkE8upG47dCQbeU3pwvXIS93SFcWiZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527410; c=relaxed/simple;
	bh=Q/SDsLYvLvxL7f1ap2ESVK2p4seJuOkLNCClDpbcn1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0Svr0HtZWhcmo+Ol78dgXMlzuOQ05okniYwA5gV3jNkxbr2Kqs/ZbC5zqziRMuOcRbp2orQBWIRJStRdN3fdtmPKIrbUU1v0EVRhOVKLvpBszTmEdbOVx2xh51+ttIstKPz0U8ul4czkEUGmk8O0fsX/bymsqPtLbwXeNeQdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZG1Vlzc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728ec840a8aso6878525b3a.0;
        Wed, 18 Dec 2024 05:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527406; x=1735132206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duDRQNaydM9MnygAgym8Q8/9ko+la+IiXsEzlSyfpMg=;
        b=RZG1VlzcbzWj1TnXah8Pu9Wk6Cg12gTERlWp1pJw8xOfOJPwXgPUXbq2shluoEbyNM
         /6dCB4ujlcldB/swMJVrwZAHWAUWA8Y4yNCp12lqC5fcchRPbUdY3S0cOsV5RcOvr4bT
         Dv7dyQmNztBaWK/Mz0C2Og9NSWH39x4uyu+uVG+5EoGBFS4SqH9/p8fLyLJ47I8+ZUsR
         6SediXsDzEWhgFEqBjaWA2CEeaDmzxfu7Q/7Q1NlzR1NfuJMPxbimc+/9pKJGrioIAeP
         uaye4v5beZGtoKIdS6w2bD/+tfNVIdWzVwfC0ZjhwYX6VlN6x03b10hrrZuPAbOS/yFj
         UjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527406; x=1735132206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duDRQNaydM9MnygAgym8Q8/9ko+la+IiXsEzlSyfpMg=;
        b=IFJ3zMwPEdIacEE6UX5ersJEHV9whJj9MPGZufeBraurxqzeN0YAg1QmLbQKhE9H18
         jjwP5qTLtpDF+Ah1j/oXMEJreiqhNez6gSKjq4AnKmCuxGOjblVX/LGUqWm2sETRmj8q
         TgQLDnAtuCbwtA+YNJAbw2HiBC/B3w7xOAD7KsagNBmF/YKvP00bmHzEpn5BgxDvnTJ0
         eAWxqAlcBINi6Tdgbp89yLtzLWMU6VJ+ePPU3TjnvPDKnl2dZvWK2YxU8i7e90bytFRM
         mCWBGFEFbQct42e+kh8tExFSJII8JfRQtETRFDMiCYgquPEx0Ai0xTLV3r9Wmh6EPq/P
         bUZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUht++vYCJA33AUhuEJbagYLkzInsYsG97AuvXnJcO1fm1BMypLP2jAHckObHH2JsKOAik=@vger.kernel.org, AJvYcCUtIUF2jfXGmw7CwE4ZgePUTUoF9OAEhj0SIq6o8DmHu/r5JS+V2pUKQGee7zyHuBUtKxj9mmX9V9Pc7w==@vger.kernel.org, AJvYcCV/ParyEqKHXXzq29BB08O1XgEuvDIyN9MwmYlEWFyAhNw6/CQiQREUropNqcsxIq5P4+WvjnSkFfRg@vger.kernel.org, AJvYcCW0Fq00wP0XcfkoncyqIsRefvEKIOq2MTwvyZaM95Sc6UnEKtiI+VzWkD0EPosuNgWw9IV0QQygzI46@vger.kernel.org, AJvYcCW96md3YpDJGm4vJgWsnpfqL6+Ni4edHirkl9Sn87EfVC/f6bWlYR9hiMi0OkCX4S4AqsqFGj3yJ7bAOU+pwZE=@vger.kernel.org, AJvYcCWHrzslm8HpMve0LtUzQLrGrnBZy8SpUQUNFvnDxsK2Oro/GWDPZNuTbcwbIpmII3zvZ7RruUafjWcj8ufz@vger.kernel.org, AJvYcCWc9KSc3BfxDLYjk7UrkMKj+kKGL18N1DWRDsjpqWoPurLsiJL99YVnZH/KjMagdRbDbDdXPlEKpt96oA==@vger.kernel.org, AJvYcCXOANKnkL5lzoeGV2B4ejVBKbgH3hiHO2h7hnROiNgy1KuSzeGhp1THSy6N+27eVj2/uSnJA5LW6uZ0d/rCeTqA@vger.kernel.org
X-Gm-Message-State: AOJu0YzGtPXWssUDDyc/byyZ5EV8BjqgwFCN5bF45GGeuqvdUtSvUQ4T
	rK8dOxG8xFaDHbWDb8CRyNIvlJKuxlfVfkuxQZs9s4Lralcd97KNDQ7Ita98ox8=
X-Gm-Gg: ASbGncu9OqUqwpY6qTIcAE7ExD0tQB8cLgKqiIwL22pE5k1i8Afcuc/VR/1YvZX1Fxt
	ig8FrPGWPQXERePC6EHiBOpbWS8o0Xn2btfjRaTr+bAg1saNYX97x0ruryFFNywANMEVatvQOf1
	PhN33zKNDeyd86zmNf4SXD2dFfOKotms4bQOfXdhtVCACct8R88IgCEValcBzPAXiekG1vPsAaA
	Z5x5JGmc0RwATpKfxeNRf3lAb7aypTVlOVE1k3WOM9WFko=
X-Google-Smtp-Source: AGHT+IHjAWByhkuRCvJpT02c4DgXI4s1gEBDobTpc14t8liBEMaFpl/IXfL3hYD82aWPv+sYgjfNgQ==
X-Received: by 2002:a05:6a21:c94:b0:1e1:a647:8a3f with SMTP id adf61e73a8af0-1e5b4824307mr5763308637.22.1734527405806;
        Wed, 18 Dec 2024 05:10:05 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:05 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v6 05/11] net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
Date: Wed, 18 Dec 2024 21:09:03 +0800
Message-ID: <20241218130909.2173-6-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218130909.2173-1-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When link_net is set, use it as link netns instead of dev_net(). This
prepares for rtnetlink core to create device in target netns directly,
in which case the two namespaces may be different.

Convert common ip_tunnel_newlink() to accept an extra link netns
argument. Don't overwrite ip_tunnel.net in ip_tunnel_init().

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/ip_tunnels.h |  5 +++--
 net/ipv4/ip_gre.c        |  8 +++++---
 net/ipv4/ip_tunnel.c     | 10 ++++++----
 net/ipv4/ip_vti.c        |  3 ++-
 net/ipv4/ipip.c          |  3 ++-
 5 files changed, 18 insertions(+), 11 deletions(-)

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
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index ecad1d88dd26..bae80bb7839a 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1405,7 +1405,8 @@ static int ipgre_newlink(struct rtnl_newlink_params *params)
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int erspan_newlink(struct rtnl_newlink_params *params)
@@ -1424,7 +1425,8 @@ static int erspan_newlink(struct rtnl_newlink_params *params)
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1698,7 +1700,7 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 	struct ip_tunnel *t;
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
+		.src_net = net,
 		.tb = tb,
 	};
 
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 25505f9b724c..952d2241c9b1 100644
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
index 12ccbf34fb6c..98752b4d28ad 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -584,7 +584,8 @@ static int vti_newlink(struct rtnl_newlink_params *params)
 	__u32 fwmark = 0;
 
 	vti_netlink_parms(data, &parms, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &parms, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb,
+				 &parms, fwmark);
 }
 
 static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 3a737ea3c2e5..c65c8b0e838f 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -456,7 +456,8 @@ static int ipip_newlink(struct rtnl_newlink_params *params)
 	}
 
 	ipip_netlink_parms(data, &p, &t->collect_md, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
-- 
2.47.1


