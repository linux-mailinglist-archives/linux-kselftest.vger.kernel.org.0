Return-Path: <linux-kselftest+bounces-21927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8839C6FF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 14:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5FA28B535
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E7202F8B;
	Wed, 13 Nov 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhphHj61"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48396202F68;
	Wed, 13 Nov 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502675; cv=none; b=ATOwUPmo+yLm2xdjlU1I8/aVaJ11RW0OeW1Hc/LX35KkVIO0Ky+Kr2mqGTZeSy7qFFFZvE5MtIzMauVoOAFIo3ETkFKenWocp3e0XSSLQP0hxE1sLhcuKl31WPUD6+5xMbwOF1uhSdO1Ftn8EAgwmFSyyHOCy/Ozumb2QqLtfY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502675; c=relaxed/simple;
	bh=R2okbkGGv03EaZoNX3EjievQR0H31mw0HCvCROIPr9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNtjLcfjmWDL46ysosqXQ2t52swqiVdyT5op5UtbmhiMpWXwmhQl6MmeGcierpyZ74rDsWUf1dPlkEK9iGkKVS/P2ug779URGlRgKwEW2vHXnyScloVQbElUgk6HpQPTpyMfhXHyZnuuFfEZPe381tQ9iqCgHvoVP+P0RUa0WiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhphHj61; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720c286bcd6so6160193b3a.3;
        Wed, 13 Nov 2024 04:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502673; x=1732107473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=QhphHj61uOxcq0ke4tJA5WdlUq1P4Utgz24eJOzOGhnTFF1bxZxSkDIzcDxNJ7Vcah
         i9Kn+yb7PcLfS+05jAPBMWEtmaawDGWNUPsnPv620FCRh5oD7F5S00IY4l00BZ0gS3Xh
         4Kjms9NrUrrfHgjGxMbvSdsy75/dHo578xOZ6I0JGSRi/Ir+ir+zmiYi37hRp9ry4+yX
         PV8nUbGxIqqRqiixal/hIuVet1iuBWk4oNZnbZ4pekcDi4CD5hFYeXvYwWvzSqvrGqId
         XoPhyhXKQnEXWPpvgmmaJKnoUK30ARD9cU31dDMWWrWRoO6VOjd2Mg8aqWKtY4hPqvY3
         TUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502673; x=1732107473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=ik+vRlWy4uOb71LBWVAXFtKW5bH/DmVegdtWS6Up0LR4CmBFOQ4cN834VPgbVXx39w
         kuKhMmbiYAla+5LHQO4phBKahnWeO96UfMa7GmTnlqGzi//oQgMY3719h3viTG9/X3cz
         scjACm+UAJJBcL1nU2jxCyXsx9+KtQBFDRpnujYrqJbo+uQ37AFfRLJhc23nKW54nrAb
         89ldH2MGTxs7bP/KfhYumHpekq198w8vRC0fSVB6mWOSFkSO+HT8rs66gxJCnI5XeanJ
         dYl5sRcN7JKLQShlxn54zB+P4BwLborz1Rwb0ngU0fmTS7Rgh9zWyzc0Lfi5Vemumc5A
         TQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCVCoMwdxXhn3TEGBD5onr0PXlrWnEFiGPOdK+Y2DtlzV23cqO75RP6x3Eq+FzuPC4xtWviaYuzwnG8Kxf5P@vger.kernel.org, AJvYcCVSuXeNU/89k1qs8dGZtpG2N+bQ4G5aO4ZqsFzSyDKCpdUy6mIOE12ma0M0YMyV9U2QFJkVfR5JiPvG@vger.kernel.org, AJvYcCVZshXJB2gHrEjIBUVzC0cZghC7zZHjLwq/BC1o6X8v4C8hkyFvxcztVOws0/oJ0M4KWqW8odWuPi6xE8XZ3rxS@vger.kernel.org, AJvYcCW+qMX1BM5VSBqb54lg68k08tlm/oN/VjIqQsG08fgOkA5p+bqYCSTE5KVmd6Pqr9osTgv3bYbTtp8c@vger.kernel.org, AJvYcCW9o2hLk/Lnj5ZywnqJnSE1KyZ1H683I7aTp+OaQPHXflytW7xbEGLO+QZr4EfoX41TOG4XxQsy37h7Vg==@vger.kernel.org, AJvYcCWUomG9ZblEgIZSvo0pA5vnQoj5Y9EYVP3gZtrwVoVaQphHb4iazZ+bI9EeWzmskJonWdc=@vger.kernel.org, AJvYcCXAuwx/163RJR6qO+wbYCKACD1AHwsl3haGrAvUyJQq+21RjgWqFu/FFwmHXaXHfTJvK7sIMjR10+yhWDPN+x4=@vger.kernel.org, AJvYcCXpvD1kI8k82RyC152jhXzXuAw9r4F4D8KN5ReCiPOKztfQi32nEkQWgB3odfIdVNasQ4QgY3B5Tb+pDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/FQM5wlAN3bpfP4N5sLV9W5BeH9c2+osRn8UoqRE8WLqZScVl
	Y6VlL7VoKfxFQt9BA+nAooJowgRyOJE3s5IOaQb9RkchIQradmI30VfIFpLxZiw=
X-Google-Smtp-Source: AGHT+IGJi6Tp37K+i8d+pRtqcGbSCXzQQJQiHEkYvBXRMyT+Ytmcy1PnetStqWOPaDWwW+msVvcvjQ==
X-Received: by 2002:a17:90b:38c4:b0:2e2:c6a6:84da with SMTP id 98e67ed59e1d1-2e9b1799123mr24937176a91.34.1731502673070;
        Wed, 13 Nov 2024 04:57:53 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:57:52 -0800 (PST)
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
Subject: [PATCH net-next v3 2/6] net: ip_tunnel: Build flow in underlay net namespace
Date: Wed, 13 Nov 2024 20:57:11 +0800
Message-ID: <20241113125715.150201-3-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113125715.150201-1-shaw.leon@gmail.com>
References: <20241113125715.150201-1-shaw.leon@gmail.com>
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


