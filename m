Return-Path: <linux-kselftest+bounces-21606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A29C0780
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3981C222C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 13:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC02E21265E;
	Thu,  7 Nov 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnFvcIp+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FD621263B;
	Thu,  7 Nov 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986243; cv=none; b=cnEXVQIE8rVVArPkgN/6brTwj5b/fpBaRKRtpMUPHAQt47irR4yIWOOtpRzPJ7E1UaBPMuBIBFckGTtq6J6LhZAiPdOuq45P5G5FfaJnFsM94Frb+rNhdTJBim+nmq0HySj4/0MULX6iqZGhhr4YD1UVOfMuwRNIdQGWrAUPoPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986243; c=relaxed/simple;
	bh=RIeIldQmMdDgDbqz3W4hOhKKpSmk1DSKS+AB23VYQvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chN69wB67o88F6LXUZ2tVY17FYmiehea+D8FS/O35JgV5V5AUdF9sRuoYAPPHZB8j5ApYHGZSRLRM7x7q3afNXLm5gX0b7bEZPp4rWS8TgWTaTPLsGBxVR4TSEGOW5bl5AGDfx2EwrEDXqGatz7LsZiKVFGoJ+8S5tJ91laY8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnFvcIp+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso722843a12.1;
        Thu, 07 Nov 2024 05:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986241; x=1731591041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edUof7QbXp59vbL8hGVThiWd9steq8vHUUDXnAQJbcI=;
        b=QnFvcIp+edCnx9X2zTrQFBevIcbtSKmsuiv4g4qp5JRZwk/m8aqlLzyIINoFbab4aB
         o+a6Rdj/0XGrEKKsI+OkIJpHHrMHk6BbaQuMHEE0zeLhgr+aT+uP0maaSQw+jkuVes2l
         UY8SDND2x5aRe01dTsBfvjAP5t1SCYcZv+0QxB0VKnO+HQbtEjq5Dk7u67ktl1akMjuu
         pJZN5aKlHqOUt7YRm6fLS1o24Px6wdGH3i61PqUSkmW484gaCg8orNJhGrmq7iamtom8
         hNKzZG2tTAOiJSfxW4xkyoMxwoSTab0ZdlKap6kJSUu9v87wsm9gVE+HeurzWHbFmgZC
         M2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986241; x=1731591041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edUof7QbXp59vbL8hGVThiWd9steq8vHUUDXnAQJbcI=;
        b=biCtsh/121yQ6B7vbRSptGMzS5RHEazYst2yXZG9vggUK9G34ZdbyGH3R3bQwUBCvO
         AY0WnL8Kfhqkiq3OoeESDmGdUd9m3jIrfLUgvvT0YlunztOiP4ZLUh6xIruwOd9M3Gcz
         AsX4WsI3FkEMzKC+3H7yZhPpLFtswF5pjq0eMoadvqNpp4FfMHLyUbY8+3ep+xZXra1L
         QgrWq9WVbzqzEY/QgRpKuynD4hkkplLQ0dRfR0KcMV4kUWZkL3UuU5pM/tXL7qjhQNQR
         Exi0/HrvBWWIUcY8x6bvdxddrgkKyxzQlffXqwGK18vbf9GmW2Kj8TtK+w8fUm4A1Vmq
         LT5g==
X-Forwarded-Encrypted: i=1; AJvYcCVzA9BSUZxFo6WZRchEFTPXxEdeHUDm/Vhf1Nrkn7uymcvk5i6TW2UAmdmyAU5alY0pMGkbe18CvtRBemLFd3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIsso0TXyO1xW6OklcNI+GYhuOTM03UbyYllNHy2zUAaJtWYbQ
	0NnVY4gPpyr0UmifLE98pgZcO1nUasgJbaRiZpjRQb5a/myjPHPtB8C/VI1yJBw=
X-Google-Smtp-Source: AGHT+IFKqI6A60S+72Sq4xBo0OBSVo/LClDbkWd02Q8TYGnP5n41wmBzinwzBIQPB+v2rfG7zIGCYQ==
X-Received: by 2002:a05:6a20:918c:b0:1d7:1288:8338 with SMTP id adf61e73a8af0-1dc18849479mr1779747637.8.1730986241107;
        Thu, 07 Nov 2024 05:30:41 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65b5afsm1359303a12.76.2024.11.07.05.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:30:40 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v2 4/8] net: ip_tunnel: Add source netns support for newlink
Date: Thu,  7 Nov 2024 21:29:59 +0800
Message-ID: <20241107133004.7469-5-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107133004.7469-1-shaw.leon@gmail.com>
References: <20241107133004.7469-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ip_tunnel_newlink_net() that accepts src_net parameter, which is
passed from newlink() of RTNL ops, and use it as tunnel source netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/ip_tunnels.h |  3 +++
 net/ipv4/ip_tunnel.c     | 21 +++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1aa31bdb2b31..e7cabc93902b 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -408,6 +408,9 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 			 struct ip_tunnel_parm_kern *p, __u32 fwmark);
 int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 		      struct ip_tunnel_parm_kern *p, __u32 fwmark);
+int ip_tunnel_newlink_net(struct net *src_net, struct net_device *dev,
+			  struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
+			  __u32 fwmark);
 void ip_tunnel_setup(struct net_device *dev, unsigned int net_id);
 
 bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 09b73acf037a..bbb2fbb90bd2 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1213,17 +1213,17 @@ void ip_tunnel_delete_nets(struct list_head *net_list, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
 
-int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
-		      struct ip_tunnel_parm_kern *p, __u32 fwmark)
+int ip_tunnel_newlink_net(struct net *src_net, struct net_device *dev,
+			  struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
+			  __u32 fwmark)
 {
 	struct ip_tunnel *nt;
-	struct net *net = dev_net(dev);
 	struct ip_tunnel_net *itn;
 	int mtu;
 	int err;
 
 	nt = netdev_priv(dev);
-	itn = net_generic(net, nt->ip_tnl_net_id);
+	itn = net_generic(src_net, nt->ip_tnl_net_id);
 
 	if (nt->collect_md) {
 		if (rtnl_dereference(itn->collect_md_tun))
@@ -1233,7 +1233,7 @@ int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 			return -EEXIST;
 	}
 
-	nt->net = net;
+	nt->net = src_net;
 	nt->parms = *p;
 	nt->fwmark = fwmark;
 	err = register_netdevice(dev);
@@ -1265,6 +1265,13 @@ int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 err_register_netdevice:
 	return err;
 }
+EXPORT_SYMBOL_GPL(ip_tunnel_newlink_net);
+
+int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
+		      struct ip_tunnel_parm_kern *p, __u32 fwmark)
+{
+	return ip_tunnel_newlink_net(dev_net(dev), dev, tb, p, fwmark);
+}
 EXPORT_SYMBOL_GPL(ip_tunnel_newlink);
 
 int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1326,7 +1333,9 @@ int ip_tunnel_init(struct net_device *dev)
 	}
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
+
 	strscpy(tunnel->parms.name, dev->name);
 	iph->version		= 4;
 	iph->ihl		= 5;
-- 
2.47.0


