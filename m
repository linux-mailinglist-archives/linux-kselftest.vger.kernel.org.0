Return-Path: <linux-kselftest+bounces-21607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6FF9C0782
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B5F1C229CD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77940212631;
	Thu,  7 Nov 2024 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+Gaf29e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E305F21263B;
	Thu,  7 Nov 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986249; cv=none; b=W6I9VRg53a8yRwWaAZLTnVITE4YlBKkFoAKPIFJRXlJfU44IKAN853Rm031TWBqfDtWxgEk26scbBN020obu7IEDPEaA6aQ+rRO7d42IzzH14u3HGcRQkCXOqpL4jA5lQKYaNRDc6lPKQO2tawvEuM36EM89ZGAnHeuW/rqH/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986249; c=relaxed/simple;
	bh=DP+FtCvuMIZd6/BnGy3YHcmGQRT1aA22G7G7QoSQE1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9ZXhBVyh2NyEKl7m2dUaB4gqc5oTKkBUkN3/9CZOoaNCxp4udgXajsxmZerLYG7T1XzcRjjOwOT8Bhhni0bMqikRW/Y/jd0UnZ4ImJv2pkYWHgjZOztEl1dMqd0ePgq1EhF2EMCjK3m8B5eZVwd/XpxP1ppRhzcYN/rC3YqR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+Gaf29e; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-288661760d3so482439fac.3;
        Thu, 07 Nov 2024 05:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986247; x=1731591047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gClAoFe1h5U+0NiA7Nj6o2YtRc1W3/sr4TmNeojvSXo=;
        b=c+Gaf29ex4ZwF77HWo4rIq9/wJY+94BgG9HyPQTAvRp0vKqYOaIz+0WUnZCircZ8Pm
         LqFh5D4TCY6Vx3EDbRK5qiwXa2lKYpxBWc55/VBFe8kKJKcTWzMg+0g5RHkvD8GPPuEn
         qpjtjc3uzS1Y3ScSt6WPqt6aNw2SPkhdrSO5Aweb+GoGY9iGA+uWD1CWtANgkizZsP91
         BDzJ9++1ye/m2oMMCo1cbynCR59KpPDlJDsCl/a70pxE9GbFd2mPYriwIrLq1kcW7bLu
         d0iQx6Sgis05OurP3FZMazu3xz5BmV1XM4YnACK2nPww3fX4p8IZiVHm1DGkYauH6MKw
         LLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986247; x=1731591047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gClAoFe1h5U+0NiA7Nj6o2YtRc1W3/sr4TmNeojvSXo=;
        b=MRIhk27TR0V7goyivZjVAV+SFpE/RtPy7vRvgByAKIhKkEjxYhxrW0xsqXDD6f5/TR
         AU5t7qOMKvYFKf0xdknnxfYztm9NxnPTjDQkCdOIbHIKdG4JrjzPhtOCEg4w9EzfOPsQ
         vtQXeTBlnW/XsGuw2xMCdPxA/WeuoDLBUo3DGkfaQ+4nMXK0CAroZqe8H30TWftbXQvc
         legD2O+J+TtLizfynTlwuRZnTr9l6tqeauLY/9w9/7uEa+UE2G9cwlfDeQu+XEKmWzx5
         hzeA+58ht756DUgIBQ1QYUCCvYenB/n91xehcf9k3XFPqkiiY2oRnN5T5rq8nUliLCjt
         Bg2A==
X-Forwarded-Encrypted: i=1; AJvYcCW66S4ctjpIO8RDWo1WeE6nHaqr+tTeh+9G1veIOV5nvanbOyJTavWT5f6G3TcM8CNdydYe6wx4i/QyUogA0E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkYkQVRM0QOd9uBzG/DULJh5ZSHVBEA9JH/StofkbieGI/EmE+
	Yl+P3+NHX2DLL64oP6mTGMQ4QXz9H0wsxQnp7JSiunnMtVurgib+0KdBwnJXYRE=
X-Google-Smtp-Source: AGHT+IG3t8hX31pJw8ubYbA4z3BcyxT+HBjVplQdqc1Kz+fLlnndA1qcsnroO+cgg7mJOqee6zSr5A==
X-Received: by 2002:a05:6870:3310:b0:255:2e14:3d9d with SMTP id 586e51a60fabf-29051adb328mr38968240fac.5.1730986246492;
        Thu, 07 Nov 2024 05:30:46 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65b5afsm1359303a12.76.2024.11.07.05.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:30:46 -0800 (PST)
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
Subject: [PATCH net-next v2 5/8] net: ip_gre: Add netns_atomic module parameter
Date: Thu,  7 Nov 2024 21:30:00 +0800
Message-ID: <20241107133004.7469-6-shaw.leon@gmail.com>
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

If set to true, create device in target netns (when different from
link-netns) without netns change, and use current netns as link-netns
if not specified explicitly.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv4/ip_gre.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index f1f31ebfc793..6ef7e98e4620 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -107,6 +107,11 @@ static bool log_ecn_error = true;
 module_param(log_ecn_error, bool, 0644);
 MODULE_PARM_DESC(log_ecn_error, "Log packets received with corrupted ECN");
 
+static bool netns_atomic;
+module_param(netns_atomic, bool, 0444);
+MODULE_PARM_DESC(netns_atomic,
+		 "Create tunnel in target net namespace directly and use current net namespace as link-netns by default");
+
 static struct rtnl_link_ops ipgre_link_ops __read_mostly;
 static const struct header_ops ipgre_header_ops;
 
@@ -1393,6 +1398,7 @@ static int ipgre_newlink(struct net *src_net, struct net_device *dev,
 			 struct nlattr *tb[], struct nlattr *data[],
 			 struct netlink_ext_ack *extack)
 {
+	struct net *link_net = netns_atomic ? src_net : dev_net(dev);
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = 0;
 	int err;
@@ -1404,13 +1410,14 @@ static int ipgre_newlink(struct net *src_net, struct net_device *dev,
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink_net(link_net, dev, tb, &p, fwmark);
 }
 
 static int erspan_newlink(struct net *src_net, struct net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
+	struct net *link_net = netns_atomic ? src_net : dev_net(dev);
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = 0;
 	int err;
@@ -1422,7 +1429,7 @@ static int erspan_newlink(struct net *src_net, struct net_device *dev,
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink_net(link_net, dev, tb, &p, fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1777,6 +1784,10 @@ static int __init ipgre_init(void)
 
 	pr_info("GRE over IPv4 tunneling driver\n");
 
+	ipgre_link_ops.netns_atomic = netns_atomic;
+	ipgre_tap_ops.netns_atomic = netns_atomic;
+	erspan_link_ops.netns_atomic = netns_atomic;
+
 	err = register_pernet_device(&ipgre_net_ops);
 	if (err < 0)
 		return err;
-- 
2.47.0


