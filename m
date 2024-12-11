Return-Path: <linux-kselftest+bounces-23215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29309ED8C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40038188BE0C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 21:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335B1FD79E;
	Wed, 11 Dec 2024 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LVt9WpHb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7A1FA8E4
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952790; cv=none; b=IoqeMmj8nJbA8MU+sGIUKqM3MSqRQuXVOYbQCz9LYld4Ee9W/7OGwoASAcKOxyevbE4TK6x1W+ea7KvCUoLM0bwJ99wj361rpfS4LmITP0tx0sP0Sht3bfKEK5no8gjoPJbjMlOaX75juT8LxsTvvo0X1TrmAmSftMVzcqDS5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952790; c=relaxed/simple;
	bh=cfVVFW1YSk9Sp4rozyN1I0rQt8bnuFN11hRcZBHCzX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bgOVL70ftNP+Upp+Okm+pskZtcpRrITuuyAvUc8nT/xWcK7wZdVHCbgalU6IQxc+hIDpsQz7qtntmWgK6D7yYsMkZ/FguWOWtgF9KYJ+v+DadhT8v2kTKEgSrJIDOXKDArZ1xpcT5mVEKo+DaO4UqLAgrRnFBFvWD/yviLmUZ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LVt9WpHb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e27c75f4so5245635f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 13:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952784; x=1734557584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Mca/LyJAWUP5fMD4RwhCraHPvEdCNF6yEEWN1Lkh4c=;
        b=LVt9WpHb2eJTPGaZhjHqR5QFoSN07z3wWnc0UP2tHMC9XrmBwM9HNGU1UcBo0/kJi5
         IyAgE6xO0FP/tMY+IRy77JPiLo1tR4qlYXbRdHa1PXAqaSzHx8WKg6KAEPASS9RWsgQW
         YMrKWStPjKXAhJTuGlx7jHM7VbxYqKDykNs2x2qdluOSLVgYYvEiXWrK1JELndtDwbbY
         7ITu82JiZLXt6/uEy4s+92GyOEW5xsLZVuuL0rmKawMThLOY7N6XAU70eYMchOUTExgD
         3+eJSpUrhdJkXfhvcgD9K/uDC2ufNAB1edJnzsKoEQ2qOfbMmQqZ0mRR4AV3Ol/RgAHS
         c5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952784; x=1734557584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Mca/LyJAWUP5fMD4RwhCraHPvEdCNF6yEEWN1Lkh4c=;
        b=QHC8Xnq9n3HmebTWPVwBoogN8ODGdwAd9yP2cw4ogY73Je0CsCVcMj6F0wY8r7vtMp
         2yl8gp1oZlam+UXnuig2+DLocqdZjxQcqiWRmZkhvp8+a24wb336TWOZgiyQTHrY8mlX
         xsnd8cwgq+cjmLFdsRKAnylEzMAizweCc3Vtq6zv3b81khg8f+hB3aMOlTu/2pEbGHp7
         LBTafu1o6JfJOPx5PQ1z2FNA9eJ/lxhfVE3iCXf80vngcC8I4CwSDC/WQ5/Wbg2qfGSe
         BrIO+1KaOIzCLQmDwLiFag2G5sTuYiqceDoTjmNASU0rdJdH9c+uwyxy8FX+FY5LUdhP
         Bvow==
X-Forwarded-Encrypted: i=1; AJvYcCVPZo2nEgtpoLqY1WSVGcVwTvgLYUSYBOLO59QXxOP10OJpcNCph+fYqYJx3tj0yO2h9BL0lJ051O6Z1sDtkx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzilH5LLkFqXmxEXnpvgTRvRp5teXJal3npC/xVWsO6gqzxAax
	9JKQ7ycbsyP3loxAUV1kGicCMxYqzdSz7LY9H9xYLkYw127TwfAD3Jib0XizhP4=
X-Gm-Gg: ASbGnctapqvnFPWgLPbpneEq2RyBvoY8nm2lyN2rIQGGW/vAR3b0+O3Ymoyb7RUg6pw
	e14XTnO30byW6B6taw9SftGqGySofO4oO4IX07EAEHZvN4bvRHpnBhih2Po4LP8LZ6bb3qjqMoV
	ffBvQA4BJsr3Sn+ROfGHiVVm5YAGxh3baZmnyUGefZaQMgt9PMiQoe7BrUXbEb8kOg919qkqRFM
	q8cYilYmogGMPfMtOYI68F9/vj98yZYhFEC2ejEhJFPe9SGMYVI9u4Qg5QI7/vtgA==
X-Google-Smtp-Source: AGHT+IGZighbjX7std4pzfSyBx0+MsFOhZyNAcJFzlKYO+bC8pDuB1636KCn0Y5SF5bgYneCudp7UQ==
X-Received: by 2002:a05:6000:1449:b0:386:4034:f9a4 with SMTP id ffacd0b85a97d-3864cec3aafmr4168759f8f.43.1733952784439;
        Wed, 11 Dec 2024 13:33:04 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:33:04 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:19 +0100
Subject: [PATCH net-next v15 15/22] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-15-314e2cad0618@openvpn.net>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
In-Reply-To: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
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
 h=from:subject:message-id; bh=cfVVFW1YSk9Sp4rozyN1I0rQt8bnuFN11hRcZBHCzX0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnWgUm0NLA+HdcRcj+rYusGtWB8pBOwuHsKLKgG
 DKo1jBAVEGJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1oFJgAKCRALcOU6oDjV
 h8MJCACtOWeN4YfTl/OlVyXYhMYutFiHG0LJEgsHOMFmfF0QOgXQSXoivUZ/dKp5jQSwP/yaQ8T
 PZ8+QdEClgpH4GiwPsr0pHCDbl/qNq/jE1gdARon1AZaUe+54bnPXxhKrMeNy+sTEczTsTx9AbM
 w4rOJA5tHRRMLPM61yPUtAw/3TS+q0zJ9uooUFzmMWqM1qeHXSBduz/LTQai/JyFErBcd0y6gE1
 F3WCwiJj0uXil6eeLy7ZPtltVSC1gYRNbhwb8qDre4rj81a1nTBbDYRvUFmziYTI2L2YF0tIUSg
 K0F/E6CsUhjEpEO/20lt7APJ1dinSqOqdx3IXvDWiU5TusjC
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
index 7908a4025352094b9c1ad5a75e1e9e2dfb86cb78..bcc7ffdd7a02774999f96b50232d18bf9db72280 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -466,6 +466,51 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
 	return peer;
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
index 4316051a12f0b8ada5110dd7aa71afedf29a0c2d..d12fbced1252f84665b084f7a24b6d515bed833d 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -153,4 +153,7 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


