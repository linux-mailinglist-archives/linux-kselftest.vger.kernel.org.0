Return-Path: <linux-kselftest+bounces-21605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209F89C077F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8F71F22CDE
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ED4212633;
	Thu,  7 Nov 2024 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf5FeYMY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D9B21263B;
	Thu,  7 Nov 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986238; cv=none; b=tvgtZfz16YP3FXsajrPQ8OhJCOot3rxtjJ0oNmRiXyZycsELTo+w35DvlcF0seAl2vFliVSK+/g5jyaVqWtblSUiyBOdzSjVv3CjPtjBswp/TwGcERhdu6jWuS0D1LvV9S6xdmyelW3nw8H0MdrMrskwlLhYwl3IoME0WWcGIn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986238; c=relaxed/simple;
	bh=R2okbkGGv03EaZoNX3EjievQR0H31mw0HCvCROIPr9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnEBbXW4qqzlbnJSEkoDbtUVbXBk8AHw69FjApuaYixn6cQkluxWr1JsbLVEs76oHkQp9yeMCTP4QzaFOvMfsCAzVZ0SHm5sB0GRbnugBdpnUbg1QU7zKcUxE0BbH58GLffoDie8YV2osfYjYgZUygCfsydwDCWYCsONvtL+KyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf5FeYMY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720be27db27so680799b3a.2;
        Thu, 07 Nov 2024 05:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986236; x=1731591036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=Yf5FeYMYQxI308x5eaSPyx09G+e6uuWYcMXQ/BvrKDeqIIkxVvh+lo/knkw51+nMyJ
         XKCZasF5924W1aOc/DoLYsN2P9mavy8Jytsm0FMpzXhvqP+FNWBl+yOwyFM9fmNU8f6s
         75kfcwztH+ZWFy71qlulwWbJd4hWUZXKZLPD8S5/xdewpJY7amKEwzbUPwDioR0RIYQZ
         3dS2T7bIui3YJxq7ZxFu+yh9qqeiImt3pX44NbYQJMhe6q//bnlW52ohH309i8IPaJfP
         JCUZEoqFXH4QmYiJy5wa3OoOdeG++EOqKCT2J1PVnHEWT7I2G/BlLzvDhTG424a2W4Jg
         yoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986236; x=1731591036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=C0ClhW5RISihVWzrIJuRoAIsWJQR2me+sJ15iz/t1vcASUyJCa3iOX0R4UmDY3zWl+
         nQzZHRmifiPvS5NLOxatwUGLhlzF3JW+jJj74PEmIXPhbeW2cu+QaIDY2UD3euhxxSrX
         Dw0IWrKt5MHy3RZG4BYlyw/uparcXjahcKn8esL5C1hfKmrfe/iUNw0jwnVOGwjxMPs9
         ouKgEDwwuU6wmE8DUVFg85fMudJjtkn9m15wOI4x/kGDh2tf3DmreRve6FP/1ez78dT5
         +/7rsa7M8ffqKJmLSzyKzs4D1f35OajGf6T7H/zIwuXXPLCjlyPGasBxjwtf/QqrK/jq
         8IVw==
X-Forwarded-Encrypted: i=1; AJvYcCUOtWwdP64jaOcv93/aRv5P8DTiFLctHY6oZLe3wHRzE/KWtdkFC6NYLf3sJW2iCY3NHYwDKn176FqUM9DHYzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh5efDmgEeVgqfDL7fiKOkh2LolGmvy3F56v5Zds4RM3arAvhS
	8FnzZDtYDOuxHbXz+K8OZ9ULCPggcCOryIFZTE04+5OkrPIMeLUkkIanV01MZ7k=
X-Google-Smtp-Source: AGHT+IFze7XtSUQRU9pWJyYFcIBTOxHAQhW46NXV/DKBG1Xjom3lV7mRNygSAOr8WJWkoEMTPfHvpw==
X-Received: by 2002:aa7:88d4:0:b0:71e:6bf1:158f with SMTP id d2e1a72fcca58-7240cfaa137mr972045b3a.21.1730986235784;
        Thu, 07 Nov 2024 05:30:35 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65b5afsm1359303a12.76.2024.11.07.05.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:30:35 -0800 (PST)
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
Subject: [PATCH net-next v2 3/8] net: ip_tunnel: Build flow in underlay net namespace
Date: Thu,  7 Nov 2024 21:29:58 +0800
Message-ID: <20241107133004.7469-4-shaw.leon@gmail.com>
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

Build IPv4 flow in underlay net namespace, where encapsulated packets
are routed.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv4/ip_tunnel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 25505f9b724c..09b73acf037a 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -294,7 +294,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 
 		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
 				    iph->saddr, tunnel->parms.o_key,
-				    iph->tos & INET_DSCP_MASK, dev_net(dev),
+				    iph->tos & INET_DSCP_MASK, tunnel->net,
 				    tunnel->parms.link, tunnel->fwmark, 0, 0);
 		rt = ip_route_output_key(tunnel->net, &fl4);
 
@@ -611,7 +611,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 	ip_tunnel_init_flow(&fl4, proto, key->u.ipv4.dst, key->u.ipv4.src,
 			    tunnel_id_to_key32(key->tun_id),
-			    tos & INET_DSCP_MASK, dev_net(dev), 0, skb->mark,
+			    tos & INET_DSCP_MASK, tunnel->net, 0, skb->mark,
 			    skb_get_hash(skb), key->flow_flags);
 
 	if (!tunnel_hlen)
@@ -774,7 +774,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
 			    tunnel->parms.o_key, tos & INET_DSCP_MASK,
-			    dev_net(dev), READ_ONCE(tunnel->parms.link),
+			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
 	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
-- 
2.47.0


