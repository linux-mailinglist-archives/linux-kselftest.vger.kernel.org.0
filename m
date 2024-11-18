Return-Path: <linux-kselftest+bounces-22180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D89B39D1313
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 15:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F011F221D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2DB1ADFF5;
	Mon, 18 Nov 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEQ803qS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD6E199FBF;
	Mon, 18 Nov 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940404; cv=none; b=jDOn3Qrg3atza7Vgv3uEZPgjkuUzMpXAJKSY4iDxJSOZVH307h+VGUf75+BIW+mV/7NFzz60SoWewrMX618/CmcdAcmDmzFuKuzQIVB+05vkzm5MEb4jyzwyqJK0Vw/+hnyodCdwekUai1JwhxvcFs24L38mY6n8HGyuZ2665QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940404; c=relaxed/simple;
	bh=R2okbkGGv03EaZoNX3EjievQR0H31mw0HCvCROIPr9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihd0Rfmhv50v+v1zLyUTgrhpHeRXoH9CdH7grAaXV2FtOlCPj8/84Oz+WMCQuF3HxGAhIkFVY8sZ1eK5hedNg9DupovfTfwR38/ENvMFSdKsL9lmXC7IOAcYg0jNfnyTDUyL1mqFPkyy23K0Ts/UfVxWBoC+uv1E/6DYCAC9viY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEQ803qS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-72467c35ddeso3021435b3a.0;
        Mon, 18 Nov 2024 06:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940402; x=1732545202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=kEQ803qSaF9AyvxFkO85IHYjtyif4cYEmsi0g76YwB71l36Z6ZvwLBw0BjiQKfKZvB
         ++CdzhyYlNDa79gg4MfGYNBlAAp3aH4w004nJcQS8WEIqdvfIS2MLCXiS6IwNyOkGQFk
         9w89zg+WcAQLHlmjEaP9xKwoJjKXdpi+6NScPJNU734t0jQrjzJa/2HQwRwNCbefWuyV
         OcTKz8J1oi1+YjLV2nfcI+lwvRJA9a9RycBVtw58yn4QVfdvnvvQOm/CVtSAEdGNU0Gp
         ipMPN4OfG7GkUTBaVUgqZNrgQhAACCayrOkhc1UM5W3aEXnm8I8ak63NSeFdQ+D4VfSU
         4K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940402; x=1732545202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=Ug5F+mBRWKXPCrRCiUTbzr5NUQZYHvVgxDEeFSe3LXSxWtHUxCjpYHp4CPBsPc5NZ9
         DwID4SyUsXT4E+pSO/CvLIswRyG+FvyVawLRIlLK3WQLh584xUFDONkCPVMQJq1phieE
         DHnLt6Hcq2uWlCo4/rIokgl2TXJX2B/Gw+sMmfKv3aF+veZkN+1hIh4VH67mcfQrrXAK
         NcbGwuzg7RB9PlBo4tbGD26dZXW6XamK/wY1JTJ92ao/1DaCdeNPvp7LQpQvczeXNhdB
         ZyFCALjGZYSinsieXzHhZ/Gwt+wZruVqUJrb2ulxx8Bzx1SFwZFPiYrehHNCIuOFY66T
         je0A==
X-Forwarded-Encrypted: i=1; AJvYcCU+2vvjmrQgMOSYZI3/YmDS5ue4dQyRtMXBAR51ZSFICCFVPlo0RilxHpTZq05g48vIN3sMfc3ZVEvdy5uGwSs=@vger.kernel.org, AJvYcCUaM7F2iVncaQsm8cmQ6Z1YVeGviwCHrWwauDvSSBkstKhmtTQeugNn4xpvxTWNa3u0vjc=@vger.kernel.org, AJvYcCW+rdlLPKLqNhPhTLJOAHFxn+f0SmxwnCNi8J7+MbS0CNTV/lPDmaI68vWb2SYTaaGlCnNcLRNyQCF6/8sqELc3@vger.kernel.org, AJvYcCWGuYNjc0B2plg2QzHI6x8JhnGhHYICI3NULAs5m7fihKRgeaCA3nXu0cy5flKTkUTzPu4CnmIBsqWUHw==@vger.kernel.org, AJvYcCWOeDoL3pwKBRS9nZoPNXPAXTABHgVs9BgjaEAhAQ3dHe4xMROwOyzwHD2Ng0l/fZbFIU5hUs6Nry35@vger.kernel.org, AJvYcCWPArFYINRZaZ176tcgVKIvIUzni4wuI9LBboVNY7AwP308UtEYgMQY/kv24njT+cqYhrr/Glgiy7UA@vger.kernel.org, AJvYcCXLSoXsZCOadgkHNMohBH6+Y/JPLlLU+NF2H2Kt3yeI8ndo8iZn5pY/S74rTE3n+MCI/NDPByG9mLST2Q==@vger.kernel.org, AJvYcCXifWTKEDXr38y9Yu+ilV/bU8mdXctPl4xpewlNK2Jnqcuho/wFEguKR8xtrHMfPFiSb3QFHLzunBINfop6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9R84hz6N4gVsOnlqXi4Yd8b59/KTvPZoFQKXdTDnhTVFYVljP
	JxbG6c2pvZS1/bqegzwGbimMSQaArlfRdhtxTseely0K4WDt5JaJB1mWuCUFlG4=
X-Google-Smtp-Source: AGHT+IGzbRz7s9CT801paPWPDasO606/jlaO2UpnfJMF7tMlUetZpF6RTCqXaMFrG8I7wghYj9+EFA==
X-Received: by 2002:a17:90b:3c4e:b0:2ea:9ccb:d206 with SMTP id 98e67ed59e1d1-2ea9ccbd33amr1559048a91.8.1731940401993;
        Mon, 18 Nov 2024 06:33:21 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:21 -0800 (PST)
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
Subject: [PATCH net-next v4 1/5] net: ip_tunnel: Build flow in underlay net namespace
Date: Mon, 18 Nov 2024 22:32:40 +0800
Message-ID: <20241118143244.1773-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118143244.1773-1-shaw.leon@gmail.com>
References: <20241118143244.1773-1-shaw.leon@gmail.com>
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


