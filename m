Return-Path: <linux-kselftest+bounces-24348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EEEA0B305
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 10:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FFA18854B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4861C21ADD9;
	Mon, 13 Jan 2025 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ffhfd48i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F341FDA92
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760692; cv=none; b=pSJ8VYePJ+vSJ74TRLSqQWJCUCbMek1wPp/9Q3JXwEvsdEHJt6AFvpc7MmRaVs9+KjYJe1/WJq4nbSs2JPnt+JKNoQZtR7begGBEtVtAk96jhshe3gaNFM9TwZHo0TYLklF7fb6y5ETnGmf8lHfhkYTqTqBjvuAQOSnz7hRvmaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760692; c=relaxed/simple;
	bh=sfnnny82c3hrw7F908dFCzjAwkrJZwFLmunTOd1rYr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=he2GpTUNuhZXRJNDdMqU24ipLnyKgXUKKnlcWVoA+wPIvDMWbMIOVwyItcbSDW+oCV17R3dZDotg4uAq+dQg+Xf805Vai5Mxxl79MOBXUMI8IR41X0sjm4xnaRuF6G22s/MfQSFgUvXDIE4eIqTXXSHDq4WvMYeI3Lzir1ZYC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ffhfd48i; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso28656665e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 01:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760687; x=1737365487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9tsPDxSi4SlwJAXcn+BgBsXrwiXO+HoGaW69KY5c0M=;
        b=Ffhfd48i1N14UgZl4JkWbf49oZBfO6u+gWnwxbs5nZCmDT57S+BF6Lh9yUQH2iOfph
         IBltXC3VlBkDVZohi5XBkYDrNPzSGWrqUa2RFn+vKatJlxoA9tygpko3hd9Int51KVdj
         ezOcS8q/HPk//Si+CKBS33ub0adSFSH85gI7TL1Nh0ObgsKrob2UvE2htc5QCHBIE1jc
         P6cBWbxufKrJGYhlNvDNXDRe0ySyPvYN5gdQkYN95D9plWS0nMpbKRRNcILF57a5usxR
         rGfQ9xkXB9TKreSyFfQtlFQtBWOVOREmr+tCrzSp33yVuvHnuiUp4mnGvbmkFIFg3wEz
         YdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760687; x=1737365487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9tsPDxSi4SlwJAXcn+BgBsXrwiXO+HoGaW69KY5c0M=;
        b=CJXh11gD9JCl/80IhpUvxFbYLVkPTaXp6zyqWf7yCiph0V7mFuUkEHHESSBRLlskT6
         S09Wzfqgfs+KINkKdxtQ6hwDU0Din8RzRl4x65FDof/kTXZjX9zdigeRR94gr4E9Oh20
         adS5WXzN4eMyZiZedQd/5pO4RAtv5L2D/Ipy5UxJS+XT9Xb8Dv4S91+lhLXn9Zlh4pZw
         a3HomV2Ug08fuNQKx9utl2wbGMOrAltqq8+6l3t4iV04XtmB4NdIYPgieOKaf7EDJgJS
         x2DU1DUf4SEpxguwceqFoSfwbkM1df2QyI5u2TDuWXWSuYrtp1AxSctMiHe5XOff5jDD
         L49A==
X-Forwarded-Encrypted: i=1; AJvYcCWzjQWZMKqalseqJqGhyp10ig9wDcx3Wx6arUXNP986F+oGm2F2SMTKwbnAmtCbkuwFupSuCKU5MgrmzbE0L2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrRIsbtc0GcTZcwNdQ1IvXhSkKIGTf7tAoOvIOP2jJYZtkJyyA
	j/3U+w3WL79lhmGWGe5aGsaCzEouubT1edcOMznlvXEX6EYFieycYWGOf0Eu86Y=
X-Gm-Gg: ASbGncsi9r+eqXLVXg0yVbRUU4CK8/rhb5usHWwXUSmHXgeTnwFqcA163zsZqCDhxNj
	bCZIMMk6pmrZUyUIdQRuog2T2qhN9EvF2P/FBanhXmGowyAvUFip3R87XhLwHNtwlGZpCiqHEmA
	JLY3Pn+VPUa4iptlVY880/g8avulEeGazZ8/FULHlfcu27sKkw9UchDUYcCe3uXrYqB29/hHTca
	qDWjHLuhHpOU5rP5iOTv8wA9ZlQebfXak/mrZnE1VMAR+xIx4rUoeTUTpUvxUSL7myZ
X-Google-Smtp-Source: AGHT+IG0QgCvtdVDRKJGtGYxDQfnk09z6hr4rVUERs0VV59iZXi/wcsQUljgCdp9aAxGb1EKzgk4LA==
X-Received: by 2002:a05:6000:2a3:b0:386:3684:c97e with SMTP id ffacd0b85a97d-38a87309ca0mr19091096f8f.23.1736760687461;
        Mon, 13 Jan 2025 01:31:27 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:26 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 13 Jan 2025 10:31:37 +0100
Subject: [PATCH net-next v18 18/25] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-ovpn-v18-18-1f00db9c2bd6@openvpn.net>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
In-Reply-To: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=sfnnny82c3hrw7F908dFCzjAwkrJZwFLmunTOd1rYr8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2HxJVMnigkf6vk6CtZjPrdDaNSdWvVWRcUn
 4lbNrehisSJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdhwAKCRALcOU6oDjV
 h9IVB/9IK5NDX3bCWUjbFO5fG/aEomYiJZMP9Va5/tApVRNFIG/Ar7HF0iSvf02OSMMXdty1ow5
 JBsFKSmhEjpnzzznn+UEak0Yt/PnkS1V0hQpHubelxROGl+jT+S37Ua8qLhL/0E3H22BfrcQBKe
 +zkEHlaUlVMOoQIAkDJaOtN3aQJWolvoAXT4RWcw0AlYjjN1UoB0D428xX8iS5Z1IKEgDgUtXkU
 S1z1T/5zes8IcFn3Z5kxy0puIEof2zhvC4hyt8PZ1ik62nAhFjzxwxQdRuHunqiEoKjJdOT0DoQ
 7dzQEtVkgIMe1YVkFcbZYk6HsK86AzBXQTIjs30WSLOAaRhd
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

In case of UDP links, the local endpoint used to communicate with a
given peer may change without a connection restart.

Add support for learning the new address in case of change.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index d78726718ec40126c93624310ce627ddbd210816..3055804894a1331243833379631c1d2e6a138238 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -508,6 +508,51 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	schedule_work(&peer->remove_work);
 }
 
+/**
+ * ovpn_peer_update_local_endpoint - update local endpoint for peer
+ * @peer: peer to update the endpoint for
+ * @skb: incoming packet to retrieve the destination address (local) from
+ */
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb)
+{
+	struct ovpn_bind *bind;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind))
+		goto unlock;
+
+	spin_lock_bh(&peer->lock);
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv4.s_addr,
+					    &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+		}
+		break;
+	case htons(ETH_P_IPV6):
+		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
+					      &ipv6_hdr(skb)->daddr))) {
+			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv6,
+					    &ipv6_hdr(skb)->daddr);
+			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
+		}
+		break;
+	default:
+		break;
+	}
+	spin_unlock_bh(&peer->lock);
+
+unlock:
+	rcu_read_unlock();
+}
+
 /**
  * ovpn_peer_get_by_dst - Lookup peer to send skb to
  * @ovpn: the private data representing the current VPN session
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index c69774877c84f0f335fc7ab8fc5da0c555c0794c..ebe7ef12ff9b63d4eabefcfed1e89454aa2f96a4 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -154,4 +154,7 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


