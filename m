Return-Path: <linux-kselftest+bounces-23906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62232A014A2
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 14:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D7EA7A156A
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B5E1C54B3;
	Sat,  4 Jan 2025 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRr2paM1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42361BCA0D;
	Sat,  4 Jan 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995512; cv=none; b=c6z8YrS3w/Mb86opA/8gwDvUfm408bqCiuirqxc0Q9b6xYXR/d3gAOgDMtW2bHtaDfvWX9vNuMTIV3YzVUdnk/LWI3ED9SB13LB57FztN23YW9JZQxyZUa25ZBjAsrsxsu2yiixFUlOI8jnjC178cele/xLCsY2fV6oKgKk3Vi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995512; c=relaxed/simple;
	bh=od0hp3ObXVcrAjwD63XqEg9Dqr5Go4qWpS5DUQq9mKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7mCw+tam5Uv81W+taXLGB06+bHWyyC+UCzekhGE/JlSfj9x7r21ppZEgAzRjZAcGJzHosnuHlEx/S3s5SMPTqovaTMArgCXQtN1gKFneD5hlkI6wTSyN2bOFoCrZNIhxi2Kw0D3Xj/ZNPt2Imudv90Iza983o0iXioxc1Ea7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRr2paM1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-219f8263ae0so138666965ad.0;
        Sat, 04 Jan 2025 04:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995507; x=1736600307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCmZExhyz7cb3bxHLdfAhcPoFeVCTtasFkXOWH4Z1YU=;
        b=DRr2paM1U4vZz1cO37449lyZ006oMgkgyCpzIdo+LIJ8Go2SQjzytb+aAV5R7caZOx
         J+ReIWF6IHKX4/O1y0JVgiNx6sFB4qdCPJpg4l608eRJhqox7i15w00hSiOaJ0a6nMxB
         oHLYyqQEcgxKgfmami69ppkwSGmJSXLoZ5cNvkNpZkJzseuWq2qtOBHM90fhtLqx85y/
         fw7mpKTVCJLmjkntUdLJu3YuJvsKW/ESooCs7ki6xF/Ad7iIRbnKNbc34NDnubGEiJO2
         ns1Du1fxrbLBFKDPtmVQpbZ0W5VIQlt6MCXb965UMuPqwblLy1E5XeMwEfr+Moi9qb05
         kZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995507; x=1736600307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCmZExhyz7cb3bxHLdfAhcPoFeVCTtasFkXOWH4Z1YU=;
        b=PvFSAkmY9Gs2MZaEWPDfVTnPL7T6WEGdA80wjnANsNN8NhhHEaHx6ZIUAZwuKdB+Ks
         oPXOeqEdXA6Iu6EoRbQv1cMEiyyQBjPmz5pt+oFistohVnzSom3JzEewT2IZcvHN+Gwn
         QJ58awuRv5TeGLicdJeO2WeQQB8WPJ57D5pUswM25KXjQ54MHjX0aw9aHQgqRtEIPZrK
         96Xpd4PnnxXQyH5WxGyy1gWW+4Md/WmyIQVbjxPFakJ1BpN13CldwfJV4cLSLLBMOI2C
         368zs68vDgZnd5R3xQ8jRx5yt1LOzPRFfOQIJpkcVSUTbGGrpe98O0F5oenb5JQSEEmN
         23Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUGqSdYz8WR08GVQcxpaO9KZHjUJMtGgJn3mjIsry0Zepwi9jNGDjh+ATeesD3DaRMEZSbV0suOU7sl12Re@vger.kernel.org, AJvYcCUuHY/9P9MRzM/ZLbqLeVi/KpWdH8tKAvn2LdKB4ppjsAfgal6y2/WmAz+DMpg46XGs4+0+iQPHtmzuKg==@vger.kernel.org, AJvYcCV9ezN+Yg4bs9OpCKF3ulqLatfS706Y9thm7gogNYbKB8GnUHO5SQ4JqoY9y4SG75Kcofi3ThvMoMb5@vger.kernel.org, AJvYcCVUAoPXY53vhrm2DaD6eLO9BrD0leW/ftlNMLtFk4SlOJYZyEHBO4ZDp3cVgJch0pXlRinR9TGwlKNU@vger.kernel.org, AJvYcCW3sQzc/5jTi0pX7E3WU3ZtusXor0yo5ygA7EuzeX8yc0l8rtb6X86GmamQWSfrwbNbUyiSpHarBfnvRA==@vger.kernel.org, AJvYcCWnKO1cTcoWqmxSBcsb4eAcay8fK8mxvxb9uW1xHMHyHlb/8+bDGWcglXB0y81aGs86Lu8WcgZH2vVUYpm1g/a9@vger.kernel.org, AJvYcCX68OH2JkkVl0xxfVnPw1NnuxnH1JLXqLKUdAOE0g47cmexs1Mz1sRcOM+zMQFwNvuNPVk=@vger.kernel.org, AJvYcCXhAe1aiAx3ElHOhI7D4u0uXSoczzK8Smru0bMsXGB8731yg2j/gLlGcjGxrVKvrPWqYvHNRyd6INzUp/dtOq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlW9IY1l7INOPuZY43ze78cAMtK1IzlN4unSe4I5yUxTkT1kgP
	pwgJElu5oB5WyUrzzfy/cVACpL5p1QhJwiBbnjPMIl3yT5N4coqzGPl8jKCyBks=
X-Gm-Gg: ASbGncsxK2USDII8sBKy/fJyg6bRzKtfdCxqt7aVRRd7GwDgyuaVGOGnUePAp2iLMX/
	Sjf3lneQoKyALAkwQgu9C03OLwL2+/eJyj8dGxewI+oQQB9Qm15l5ov1AsT2TGikLeDxTiqysJC
	gEiFR02lPUuBrvGARUeTPQgGG0jbw0XohX1EcyHtKf5BAhON4Gj/eVY4lOb244kJz0Ey/lzf7Bn
	G5Aka0/qjruDjg92umrThUMKhfYxHjcHnMASuYdlSmbVOQ=
X-Google-Smtp-Source: AGHT+IHhlUZ4hpFQ3a9b6BPvAGinyOtYhhp3nBXZboTqrJ2Is+5BNZ37AA3tsOk4lmwOGToWJ2idfA==
X-Received: by 2002:a05:6a21:3189:b0:1e0:d632:b9e0 with SMTP id adf61e73a8af0-1e5e046fab8mr87168448637.13.1735995506986;
        Sat, 04 Jan 2025 04:58:26 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:26 -0800 (PST)
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
Subject: [PATCH net-next v7 05/11] net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
Date: Sat,  4 Jan 2025 20:57:26 +0800
Message-ID: <20250104125732.17335-6-shaw.leon@gmail.com>
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
index 71eb651e2b44..d1b712b775b6 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1408,7 +1408,8 @@ static int ipgre_newlink(struct rtnl_newlink_params *params)
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int erspan_newlink(struct rtnl_newlink_params *params)
@@ -1427,7 +1428,8 @@ static int erspan_newlink(struct rtnl_newlink_params *params)
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1701,7 +1703,7 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
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


