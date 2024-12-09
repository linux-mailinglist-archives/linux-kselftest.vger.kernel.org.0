Return-Path: <linux-kselftest+bounces-23040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6987E9E9822
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 15:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67318166A7A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E8C1B4220;
	Mon,  9 Dec 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIasV0bg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975631B0432;
	Mon,  9 Dec 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752960; cv=none; b=cmyO/wJaaQlct07WDKPQFkTigqlls9po/RxSaUaWDmMPGSkWBVBX336XXB74tPwuUDdZdZ0tbbYApdgVX+3V1ywtea6rgZsZ0htiViHNU2NTWJ240ou6qNvrkzMDnjEe82Bu7ZvZkaQfAdn0vpkI69sLO6PJka5GmkTleJVMB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752960; c=relaxed/simple;
	bh=lgJmK7QhO45xqDrvl66irdPCWIX4b3Dm6YQ5hpUAe5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyz4/1G0qS4K7bKa/2vpRTILf3XPJ4NicYR6iJppaBUEtqK9TM0RH4ZKUFT/JJEFmVxzeE92K+aj4wF1OGbrr/usd7akb8rtemliNWPK8Op92EhoDbSKciCl7IsqliceJ21yd+quvBnWoWHlG3bpUpCvGpiRP5PE3CZfr0WDnFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIasV0bg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-215810fff52so47769755ad.1;
        Mon, 09 Dec 2024 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733752957; x=1734357757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93uG6ogDA0suRI92nCq7Qt11rTzcUQ+bpSh6BVGj6ZI=;
        b=OIasV0bgWQHhHdjJYtHd5Rg1GAipPOrh6anOEpIn07NLiZNxcuRQXaAtDHyN7+Wame
         yjXyEn7dIFNnAY+KTZ8h19F6KFIY+PqZhUmQMtwt77he8c/SFD0Ic5JtY8whDEkXKUY4
         K8xSjgEqmzPxoTAoXsdilQtaQmJIREuVcCJLpKvNIqUZfRUXsHblExxsoS0vNFFrSfc6
         H6VDhCn5142vIYBBQ/iyPy2BXNdT2R6n4cn4BxwxjNg+JayKfS5WYoKcQXMZelHf41cC
         LXhJkgeMYdP9wGCVO2TaLkOMPv5eF6xk5LRko6BAJaoBamhfECA7NKNKuEM9Kz+TQNol
         G+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752957; x=1734357757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93uG6ogDA0suRI92nCq7Qt11rTzcUQ+bpSh6BVGj6ZI=;
        b=FnF9qBz6VYByHsQLVEoiz6etCl/JUQySr9+Tgcv+o4KEEnmDi/JfIAyXRhCPx5ig9t
         wuKOZQ7Cmy3CbvFQGbmmhrx0zS0v3ydGYy+TholIJeOkr7E3IhCGToaYs9nWf6Wpv6p7
         7WPeRxtdsGPmSRaYWIhVU+rwTGGf+cIL957HeLVyllIPjFd+vS/aLjVQBtauik2NjOv5
         SjI4Xy3ztlonvHwsusoNjE9GlAm9EbAb8KUfP5lAf4Ytk6ijlgbGeYpC+n+ki0DtRg5V
         WUHI+CZYyYQw3jxy6jUMf5tYi3dmmAIU6F+bcP2Q2fxQTBMECvrYeuHGNzxJ8SGc1LVP
         KeBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGVBVDaXahL9iXvbusjJ7Xgv8UTioXMyahPPQiKdhTHGKd0Gomq7W3sS96Uy+o1AwLjeU=@vger.kernel.org, AJvYcCUwdsZ8vYdzITbCyCYVXLtyk6PqIyuNAOVb4e97xe/wrQsxIcHBpLCYdWHcoNI3SE+ZeYh7rjr5RnwQ@vger.kernel.org, AJvYcCVBamm95IP1ufMwRPd2btvhY79ERVkWgWcg4wBg/1XLZA7xeT1f1RcjVxGj9fy+D93BNF77hodf2zsInWE0@vger.kernel.org, AJvYcCVNi1kOfiB9XWcpx/ym10I1FF1PBa2SoH8oq3DJlSUu2UUFhxB6bOerUghuKDYfwVDhj7+sNyYi281LqVNuM4s=@vger.kernel.org, AJvYcCVfZZ41NiOk8co5g4X+l6Deng7USDQ074z88DpkqQdjGivERHpVJE3jDCISdsvHChOVk+2wRpRexuF6gg==@vger.kernel.org, AJvYcCVuSgP6QkFDUl2OftjfPkF5YQXmEbtc8Ve98AG09hUqlfTkXM23fscqaFBiIPBINrU4RXzh79VQy57r1fIndFzP@vger.kernel.org, AJvYcCW6tWQs3xzSY9nYpdYF6ZqlsUe+M6GenQhDVQpfdKB3lNnmfiNy5lmWE6FNpZtnLqHVjw8wlYjxknjabA==@vger.kernel.org, AJvYcCWcXPzI3NBDYp6BBvsweiN4JXtD2dgeGuv+xQvYdNkWCatNAtyF75absMFKUUmKVhT5hacytvvrd+1+@vger.kernel.org
X-Gm-Message-State: AOJu0YwedFSA++VoNWuOHKaqan6DOk/fKpBSJoY5T/9EgkhgW2oMxrl2
	vUVFphGI05GqqOIE1O25VPLJNV+OQf0y3i2EhjlVmSl2GOoP5RPFYqYvI0V41Kk=
X-Gm-Gg: ASbGncv31XD8uKIHdNUjBCiAOEofpGe9TGYhl7+O/VG+qSQiwOl3kLSP/n/jCeroRXo
	qF9XtsHcH9pb+KGQT7SaoNJNLOWRz9YF3B2t0H8InAXqfFCce7rYCejjCszIA36x/V8K6uGF+u+
	2Vq7SYfw7u4A7CvRNPzztZfZ9mDaWhSpFH4FqsGDwLhcRjslk6c0aCRm0zqeuzozNhpAFDbU4Fu
	GP91HbaHQd0Gtid5mNFEbphAKNQh+Kpi1F+fQTboDU3V+s=
X-Google-Smtp-Source: AGHT+IEJ2QVBGY2MGcE4mBFIU/c+dzWKa28cbDvoqfUFybFT/JmX0nfLyJJqRhwpUbbXsTp1UoSovg==
X-Received: by 2002:a17:902:cf08:b0:205:6a9b:7e3e with SMTP id d9443c01a7336-2166a0b59acmr8694095ad.56.1733752957447;
        Mon, 09 Dec 2024 06:02:37 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:02:36 -0800 (PST)
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
Subject: [PATCH net-next v5 1/5] net: ip_tunnel: Build flow in underlay net namespace
Date: Mon,  9 Dec 2024 22:01:47 +0800
Message-ID: <20241209140151.231257-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209140151.231257-1-shaw.leon@gmail.com>
References: <20241209140151.231257-1-shaw.leon@gmail.com>
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
2.47.1


