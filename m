Return-Path: <linux-kselftest+bounces-24371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1FEA0B9D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3E518882CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AF62500A6;
	Mon, 13 Jan 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfnzCE6R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24C3246355;
	Mon, 13 Jan 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779104; cv=none; b=OGAJUkd6YCuoVYtsvE+wNoDs+p0CPYAT7Hxek9520tqirhy6/dZpqxXg+Eugjj6WmmiUq2zxXz1Yjv1aRna7yS+H2PMaOIw1qe30rMcqvLp/3Nq6Jno8YGmgbwwBHJSbiP/S/AMln+EyO9iFIARJ9y07KKHS6A87g8KFMtBCbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779104; c=relaxed/simple;
	bh=4+uj3n3qzLmPEBfggnLAVLnO/V0f9mUleOD9sy+kwQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpaBH6K1KHBBhrr6mYhcGI6pc6e9wsN1dhOqQWyBmts0m3p6pdpqXn7ZwlacAqKDcOCv3b8OKeGptQQxo6qD7WoR79s6UbQZY324h2pMzdZ8c4tX/Juzs0UAi6V3c5MybSbHf2XzpDGM26mVX40q3BV+knqi/SIATV+RXJGhaM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfnzCE6R; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215770613dbso52931945ad.2;
        Mon, 13 Jan 2025 06:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779102; x=1737383902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2hr3iCsVwpwP1Nzlez7XTECQN7gMZZquvojvDybmoY=;
        b=bfnzCE6RhkR3mH6HdaywSfC0r2ONa7vLfi4KQ1j0U7zFOFANx1MxyxXEY8+b2v365A
         N0Jflc1WZJ5hmV7pxrVA+h0Wc3B4SvJg+eRTLCydrRuH166XGrbqi/pIdCLtOu6S6KBZ
         ukFrNEKme98YWNM0ZwwDxD5uYt7GANZN9cP+XYsbH/yq+pumW00j97fQuU21W6ApcDVx
         pDviWZ7nTyPyJqiDLf3D4T66TsI+ilZ18QXzZEQwwM4RFcEDf4zQ4LIukp81s7bJBvrv
         hjoLBcrpiKKgYSjHFa9+VEwcSCj49kOIFpYtjAQDuoA7PXYZRJJ4AKNqB7kGngmJN5Yh
         ZrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779102; x=1737383902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2hr3iCsVwpwP1Nzlez7XTECQN7gMZZquvojvDybmoY=;
        b=ZGb7oeutrBpcI3FsMnm/H0p9pilZfifLWSJzgwr/OuNQzcyGNJMdCLMAxB710a1pnC
         9L356jOPMPxkLZwADFG1psCXKb3IbqCJq9HHjdqxn/Qe1KyGgEifFcF5AXel8wUXG4SU
         OhymppWKWLDTdS90vUPkSxLk+5zAPqgbs/48mW+/1l93C7vc8eFAA9bNp5GjKXXCDmgO
         kxJi+9+1L4wEpaqGo20b3+3vf+3sL+M2Fi3EKIRBKrpb8bOpr/ojFWKfGblv5Gis217P
         6fBy0poCaUmQgPFcwGLzmS0AC83LRn8SL2NCInhWJQiL4J541Ac/h3tIifY9oybqZgD2
         cJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCUUkcKgY0Jt9rEXZvt//Aw/Ch8Fw+B7Vy8gTHkhUZ3OzRGkCi4oAMEarH49gJ8YKrdAKauCUmsCioViHySJgElm@vger.kernel.org, AJvYcCUZfygCc3aQo5/TJ3hzGaR7PLbe443xngGTMBz19+Rg8o9zANOHwl6450BZxbKSAx3OIKc=@vger.kernel.org, AJvYcCVAheS3YNo1fhOK1dYOX8rjrPuEvjV7RRkctcgEMFR+t1wAie96d1iZJJey0A0pWxjsP4LPKMX7nvBcHg==@vger.kernel.org, AJvYcCVQ04dilNbo0YfI/FoBBiDoqowcx80Wanqj5MomQP7o6ZS560NmVqvp0d7SBIFFOZGUUolPQwFjHZqz@vger.kernel.org, AJvYcCVikUMBBw8TEmlKxsfNJz7spR89TBbG/y8SFRvv9hwhJAp5utqE12Q/NjVWLmYXzbDnZ+SM/t6MT6G8besHKQU=@vger.kernel.org, AJvYcCWYqpM1we9bZr7ImhMd3jGNr/i6HmKDqc19gtsY8mOhUT6WzMqAEInsyZqvQgi/kd8t4BrB6R8NEkRR@vger.kernel.org, AJvYcCWn40lY4Mp0J1FkGEQTuczwuTQ03xTw5dw3Q94tvYeGjkcUa9lc22XVY8gSJoobh9FG/R5OYbIdgUBDnQ==@vger.kernel.org, AJvYcCXwKgKUFtbKx9gIwMYW8VUdzVEN0Qx/uHLQKD7G2lSZN0VV7ke4WU0i2jhqb6WhR3h8s2nJIa/V5fsa2mJZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvfjf6k+w4tDwlDXknTMQGdIT9ZknNLLIcxUzb2ICeWgdvMxm
	FU+57/D5559/niDPMOQvKyYEcoT9VJyLJejg6kUlEm5XAM12PrIIUy+hLNF5VUQ=
X-Gm-Gg: ASbGnctQvqa46xG5wbMDI2KXyG2NPSF3+8As7mSu9u3XhI6X4atEBA6NHV2owX1JusW
	h+Fe5t2rV2H37qTG1Ult7+/2boJanPYv7zPsMtwg4WWRa24gWw6JJua/3se39Qf1yOCkmCU1xqy
	sVASfHPm1DkNKez12Q1VCCjKK6kwS3JFHFvyjFVynoIyIARb/LsQ3RAsUKdnYav3swBxCnqJS3R
	lLNKb1Ek/BACPXsJ+MXP0u4VEGmpE7B30g9INyfiVt9i54=
X-Google-Smtp-Source: AGHT+IGv14RrhPbpKFC9/J2BufZTu7MOaWM0c1rsX2Y4WR5iS1cGRY2j7eRCHAjKSVADaNJCQQybTw==
X-Received: by 2002:a17:902:f685:b0:215:b473:1dc9 with SMTP id d9443c01a7336-21a83fdf10fmr312977815ad.46.1736779101666;
        Mon, 13 Jan 2025 06:38:21 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:21 -0800 (PST)
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
Subject: [PATCH net-next v8 05/11] net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
Date: Mon, 13 Jan 2025 22:37:13 +0800
Message-ID: <20250113143719.7948-6-shaw.leon@gmail.com>
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
index 4e8c310769ad..51113e981229 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1409,7 +1409,8 @@ static int ipgre_newlink(struct net_device *dev,
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int erspan_newlink(struct net_device *dev,
@@ -1429,7 +1430,8 @@ static int erspan_newlink(struct net_device *dev,
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1703,7 +1705,7 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 	struct ip_tunnel *t;
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
+		.src_net = net,
 		.tb = tb,
 	};
 
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
index b901bee03e6d..159b4473290e 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -585,7 +585,8 @@ static int vti_newlink(struct net_device *dev,
 	__u32 fwmark = 0;
 
 	vti_netlink_parms(data, &parms, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &parms, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb,
+				 &parms, fwmark);
 }
 
 static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index a8b844bcfc64..bab0bf90c908 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -455,7 +455,8 @@ static int ipip_newlink(struct net_device *dev,
 	}
 
 	ipip_netlink_parms(data, &p, &t->collect_md, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
-- 
2.47.1


