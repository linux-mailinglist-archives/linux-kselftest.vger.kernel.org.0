Return-Path: <linux-kselftest+bounces-26964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23892A3BEE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CAE16D23A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE891F3BBF;
	Wed, 19 Feb 2025 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUnL246V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45391E1A14;
	Wed, 19 Feb 2025 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969511; cv=none; b=GIhJLN+fZWZSXXRZhoJGPj9p9wrcSHlNbyTK/DqN70zp1vVufsL2+9ydvqEMFQW3IQ3cpcOcQCr+TTlEMvHT6//jcQw9dYi8dXoRJFG/YdeaBbXBSpkAkNj0Igu6E1aMmFfqiWKLsm/ny3joc0v0dB/ZNVYDOd54pVZ7tshtZ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969511; c=relaxed/simple;
	bh=TB+PZXAS/vx8BG7x1KeG79/o2AKkUgqXidM5xP69mA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvg1Q3OA2dLuBCDemBFpZgbNLMIGWdDFAXUCuMTmS/sSh9eW/B3MYest1Vg0qD8nVFx5YCxVa+w9SJ++Umbl70EhRa5DE9dyLOUv4kb67fJ4Z04ZXakodTQdujt/m3BI2km0wShG7h7rTGvNFtRrdSeMqGAcImLLTXQi0ZAc4WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUnL246V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220d39a5627so97980375ad.1;
        Wed, 19 Feb 2025 04:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969508; x=1740574308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8g2ZzjSkLAnV2rJAeqcq6uVgaF3+M6uyZFMb8BU5Wo=;
        b=lUnL246V0nSup/DnSHF1uwpze1YPSFu+IKjYijoxO9efDv+Xno8bqofJwSldOGKF14
         ANU5yMoA4hBt7yXFedNsnhxQE8/JgRyZL+0qF2Hs7ybxCZBXmZ0TJZ/oFNe6ndUUqwQm
         AqxT+Zyrj2zZVe1fNsf2eGPx2ldlJf+KV7W704SLBouDJCrF/l9gPKIolMUWWU7qA7a2
         zSmiOfQMLZV8BIqGYppIekaDyp7RxMLSm0ef3z1f4TqQygmRTRBFKGWvB6fAcf8SHIn5
         TYtSRd35WV265rAYk/wFuo0DRVoW+B9bZuCHw4SMVRJ7BQW+AbQdcHbaNwvLG/pK7hbu
         jKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969508; x=1740574308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8g2ZzjSkLAnV2rJAeqcq6uVgaF3+M6uyZFMb8BU5Wo=;
        b=lIYkPz5eBnOJmCtcuy0s1EQSjOgRosNfbOlbNTnXDDO29iypUUhgMJVX0Hy6/RULca
         Xklm4YrrGFhrmmpKPSLdgnggBeOMKofX0rWnAGhECl0Kquq8Quop8FkSdmhzAciMnyCP
         Y8iNJ8bhychzUTfopkrNORYMuPrOxazWS2D1N5e8jvecdSMOg5+9rlaRSwBsKYkzOqpl
         QT4ZZ1vWi81CJRLwj/oBKOWWKhJ28NdY52ZdZ196B43YswpMSMlOhWFNbKA2XtqrMQ4Z
         gm9aRFwu2Tvyz64fwlrmU8NXnfoY+PfmAKwWvA5eQLBEOXjeesSMhWGrp6cvFy7IS3jJ
         4AVA==
X-Forwarded-Encrypted: i=1; AJvYcCVFkjzYCO1pt7UkgQRSGbrza3PkcuKpD/dY6rP9xbEoqDXM4WVTdVcHrpigOpaBiOEoUT8mGm3Y+Odz@vger.kernel.org, AJvYcCVaxv9FvMwb1+XyLty7HgVdoaLLOywyttShK+OeShIN0vfiyd0ru4ILpxLYuiL4SqKTBdzAU2O4cED4PvGPsA68@vger.kernel.org, AJvYcCW1NQ01DJcPlDM+PjFtnvjAMNdj3yLP/bMxFknDStqvPLIiyfLBbrV7zbQksgzJAaT3gbnIYQt6gmtf@vger.kernel.org, AJvYcCWCukGYV9pnFhP5DQh2wotPZEtisPOuoKXst/FSJ/i2VULpRimpu4ml7SKMJQpSunCHnOSgF0SSGuyi1I65@vger.kernel.org, AJvYcCWF6Xro3QoOM7aIch9XnwZs22nuGDsRhinX01zSq5RyZlOBXPhpvjX9z7sexSmrU47iUGGJJhw6Jb4mzg==@vger.kernel.org, AJvYcCXCgtlPdJOeuBguoWzrIIh+P93v2CyCsGB/hZegA+6MEG8bXAjZ+5ff87BRVbz+ih2PegM=@vger.kernel.org, AJvYcCXTJEV7MtHhCzEDVxhR4u3Iy19yL5LkkeKDDS/FFv5Tm78eipxhQNy7bJR0FIZXDiGJf3A/hk8CaGbeVwVRm9E=@vger.kernel.org, AJvYcCXUQVXRS8Z8OSfq32JdrSRVPVAUNf1wip4VMRzYQrhlaXahllQP/r3BKElWWINW9XhG8M5GNOHnJWoDlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrK7NnNI0HljjGkZS1ZlI8YSXLbMTRTdw4t/h+K6Rkh44TiHh0
	Vk/WzVdRkgAm1Lpg9w/cTQosS4MrdNkFTw43ZgrcEImHRz0mXt4NN4Wvo6K/yWs=
X-Gm-Gg: ASbGncthCU7toCPgGui/PfEFHMHpTVn+R13GRk5QfrQd2wf7AD/r5PpeWxeUlF+5wn2
	CNrgsWu5zafKld+qqzvlhtpwdAApSrhEJtFLE6bx48y72/KT/doFER9Eo0zp+qYtkJVJGS7fXpl
	VDMvRn2fClFGpZUJyo3C3LXj2ONi1Rim9Ldyf+D0pSTCsSGb7OX9pIBpwYbJRdip2dNapBad9L5
	b8uCnBD1eXauCWaMGp1nSrN+V4ggopAitSpu8cpOi9d4h0ZkcaBNTQjUnSpX3LB7QpyTzqFDW8q
	SSQ9LQ==
X-Google-Smtp-Source: AGHT+IFYP0H8aiDg7L5uhsGsJLhgqrRsnWJTkGp9h+ijz9vj+qGa0NYcij3UcKBMYCMaV2Zll9Ie8g==
X-Received: by 2002:a17:902:ec84:b0:220:d532:834e with SMTP id d9443c01a7336-221040255d9mr276303305ad.19.1739969508267;
        Wed, 19 Feb 2025 04:51:48 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:47 -0800 (PST)
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
Subject: [PATCH net-next v10 06/13] net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
Date: Wed, 19 Feb 2025 20:50:32 +0800
Message-ID: <20250219125039.18024-7-shaw.leon@gmail.com>
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

When link_net is set, use it as link netns instead of dev_net(). This
prepares for rtnetlink core to create device in target netns directly,
in which case the two namespaces may be different.

Convert common ip_tunnel_newlink() to accept an extra link netns
argument.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/ip_tunnels.h | 5 +++--
 net/ipv4/ip_gre.c        | 8 +++++---
 net/ipv4/ip_tunnel.c     | 6 +++---
 net/ipv4/ip_vti.c        | 3 ++-
 net/ipv4/ipip.c          | 3 ++-
 5 files changed, 15 insertions(+), 10 deletions(-)

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
index 1fe9b13d351c..26d15f907551 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1413,7 +1413,8 @@ static int ipgre_newlink(struct net_device *dev,
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int erspan_newlink(struct net_device *dev,
@@ -1433,7 +1434,8 @@ static int erspan_newlink(struct net_device *dev,
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1701,7 +1703,7 @@ static struct rtnl_link_ops erspan_link_ops __read_mostly = {
 struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 					u8 name_assign_type)
 {
-	struct rtnl_newlink_params params = { .net = net };
+	struct rtnl_newlink_params params = { .src_net = net };
 	struct nlattr *tb[IFLA_MAX + 1];
 	struct net_device *dev;
 	LIST_HEAD(list_kill);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index dd4b4e5be998..011f2a5aab3b 100644
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
2.48.1


