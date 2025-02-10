Return-Path: <linux-kselftest+bounces-26165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E13A2EDFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 14:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A68D160951
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15908231A29;
	Mon, 10 Feb 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfO92onU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3722FDE7;
	Mon, 10 Feb 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194266; cv=none; b=pZuozHLjUrr+sR+5aDdCZNINeY0m+1fttpGBLKUYsGwquRmeh7cWzBv5i852y631nZov3bWg3hXl1CGYauwrHzEwwEYV6NoWa7jIxh508HNKyrFAGQdUg4q58lRGNjr45kN41kOJ/SVW4eXyxHF94qMNkuSVNG0rDTQu2dyEcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194266; c=relaxed/simple;
	bh=afU0eP8leIGpj7KOdqVDO3ES9Mr3NHsvuQ09X1iwlHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0qPOGTArTz4hlbXpPjivmM4pOhu258OYef4JXbHA6/v6WDqv23yzgrnlO/kKb1DjYaxa1ybiISOlsYipubvIN6LXVIf6rCltDlQLbLFy2X1tTcuNmDEcli1+/rb+5WrqNzlH/7K6vI8Cmum8YjDcaDf/AVdf5hJSbyoYTtKZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfO92onU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f40deb941so88631955ad.2;
        Mon, 10 Feb 2025 05:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194263; x=1739799063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJKz1g6voDImT0UUTo/s+cF5fKbKW++euQC6BW/L/6A=;
        b=WfO92onUBROkws89XF0xJoYiXN4FY+kMJoYd37TDE6bRufKKr0r89DwlD1uSkinzmf
         fRNv9H5peOkZZOMZiWRihuQvO+0HCljpVxL64nuYALi9PbcWytZNjtRvLSzXuI0cYwbu
         kJprT0/Skum3pElV7RWeBnrhzMTKMUffM9m//R5bBbcQeqC0REmrSWfyRhPhXiJbDsA8
         iVfkvYG+UduGy3J6thkFLLfmrLuU9b9ZH2Vpgh3AwI2ofM+F0lRjS6YZ05g/MEO4Ow2/
         7PD5blYaWR1yTePxrVNjAceq2n0YhCBJ2iwtnPha8/0H3aT3pj++hUxOY/nNoFRpsYEg
         6bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194263; x=1739799063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJKz1g6voDImT0UUTo/s+cF5fKbKW++euQC6BW/L/6A=;
        b=gdiDZuCCTuQaYxmgaLJ9H2GbzKakMsoJLfO4tu0lYBuT+u6Tj2jmyNTD0djubbcxH4
         uZIvajYFSxi8vKmlZXRCZ+A7Y35CE3K4NMZoJIAsCFEcQ6kSHiTkr6pH4+ulF6Dkr1TZ
         SfYW87Iw1rpT97+KQPyQEzLomtW6Fhi0W/lotucqJnQl00H0snydbWwYRYWmDbCEKPDx
         aMDQMuaTdbyNF0z6xGbJds5QAl3AONHkTkaZqyAxUUQpIgefCeesjCNCknabnTaUGVHO
         TbVQdr4I+T5IUjNW4oZ4zjpMQljLnX7g3cjGeUbrF/W8zqq6kB2iwV0OwM3tXq8I+82v
         Vicw==
X-Forwarded-Encrypted: i=1; AJvYcCURR6ih8oatBAFoQlcDgFDYA0DYh1UNCrFwTpdo9b8st5PeRN6sXf8aGB9mO6it1k39AxvKhv0qF9Ryhe8Shp0=@vger.kernel.org, AJvYcCUbUBjtYVSjhl1OsVSrFVrtUo2PhYp7SZMyzVQ9NDoogVA1JszcJGmOo41sqz7/+t9KyFo=@vger.kernel.org, AJvYcCUdzs6uijMVHxCArqeZ4xhE+6e7qxoeS1k2xBPk1DHclqsl+kINweY3ocgocyq4ssuZV1dyY8lvNGieectI8a/s@vger.kernel.org, AJvYcCUy6EXV5QzD09tUzqNqrN4+R9PWvQ4qQ/uzJ+1/SWN+CDQLWFUq9OR4hBzGRu5G5u6kXwykjgiSzgyE@vger.kernel.org, AJvYcCVDruWV6E1CCpu9753+0DBWzU2gfPEdqYStAtG/nk9odDxgsoWRZNOIynbZQYtU8J6RCVbeBRPZ/SbF@vger.kernel.org, AJvYcCVkyLRvgU2mnxHKqhZ5lLAYi/5XIW08/i6y4VCuB2Lmb+8W9sFcX0Lt6L9G4X2qEdBpvjOK6Mm7DBH96w==@vger.kernel.org, AJvYcCWn22K3A+RE2CCSQMN5Eugba+cbQ3mISU1sL7jH5enCPmkQh55coa9NS3AfM7n6HFzTi4lTGrtRzQmUch0T@vger.kernel.org, AJvYcCWoNRQ77jt7YJ0bu4v7zvcLWJzVTuUBk43JDCgHnjPBIPHMnPRL/V7EypMlDNZpbhHI9bZbYTLyafjGjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEJFvbjDO0ULxAl0cStJ8qDP5giJ9CJ3Z8Q6Jwd94ovhoBdbq
	TG3NDXCmayBYMZc3Uv+GgccLAK2HvVr+NpjvrTLjdoWC8QOT9aR+FSCuZEcMqFg=
X-Gm-Gg: ASbGncvRGyzY3HR51LQ+JcHLRwsKdHK9vyvb74MB6EI1MDeH3mwxyL4Z7WOFNVMMiml
	h5qM+rXuRHBscDiko5SiY4gMd0tonTh4xOhKzQE1H4hFxThtkK731/g3Pn1KJFXUe4rfEBeSNs0
	IIWC3tW6pDRUjiJ6R4fdO9+IZUA19zJbOSljI9Enf6dWpBCoTEFh3qxt1qGSZlUefaI7sxDwBgJ
	l6ngEbA4HCSN/h93WGFnBJtepPTGXPJPyOSiS4CIHrk9Z6rXU57EjaOXJXriRMjd5rCwDtnRbrl
	HiZaNg==
X-Google-Smtp-Source: AGHT+IGNFjsW8yGSZG6C2tbCv5/JZ09OmB3LKkjVhY7agbUhlCe28tcl+Qcya8rlcfYhnDrE2/S9OQ==
X-Received: by 2002:a17:902:e946:b0:216:7cde:51a with SMTP id d9443c01a7336-21f4e72631dmr249984615ad.28.1739194263028;
        Mon, 10 Feb 2025 05:31:03 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:02 -0800 (PST)
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
Subject: [PATCH net-next v9 05/11] net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
Date: Mon, 10 Feb 2025 21:29:56 +0800
Message-ID: <20250210133002.883422-6-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133002.883422-1-shaw.leon@gmail.com>
References: <20250210133002.883422-1-shaw.leon@gmail.com>
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
2.48.1


