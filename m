Return-Path: <linux-kselftest+bounces-22986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75819E8E15
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31EC81604ED
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 08:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987D3219E9F;
	Mon,  9 Dec 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CNR6pgYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FACB21882E
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734402; cv=none; b=G/HtamszmlrSIAgLjMULF/eCTFk7zPCGDh/XAtXKSrh2Hz4f5TTx/QnKX726lKT1Z7PucNwLr2/1wchlCdyDyncjzn4DD8Xf3q3fwa/lDTMJEY8IRIy9Nf3mvStGpwtO0dH63JpyhxorE4MOQ6fnh9GuS+NZHa0xYZnJlc+ymIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734402; c=relaxed/simple;
	bh=erPTYrweFrnKu8N8OGwDdEIbYQXq1gCniqH6iX4uYZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nrp5pNqCZ/BbHtuI7tOuxhrnxYBf6Trvsb9K/0LdMGxcbP5NhBEjoAICZ5CFnTs/pj4UxzAtb8fonUUE0hqbHGoQm7lZt6Ed3Si6U/0aArdF99X3zBnAgQ/ViiZ/y0ZHL5/Yqu5j2NsVYd7n/7LqhN8d2JIl1jodMqHBk0Po2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CNR6pgYB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e3621518so2969833f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 00:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734397; x=1734339197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cyT+TFbRaSz+vYeKaMRbh97PUnS/cHongWol9wj6Bw=;
        b=CNR6pgYBu/I44EVvsieJFeqIa0eJt+JVsITYZ0CCCFOEcW58NcNbNa0UzN4sziSSEv
         K8sG9KxfI8QHYoMLK37XdcTKIolY867hiRxeen7Q8ou6Yoiwcu1eVw3AUIPUkLwyoMWH
         xSiMuRbm546w6WYERQinj40Z2jkh4SbgxvXH24r9MSZXaZKHXwGcm5nN3sH+DgCGEu7h
         ok7TbXDJRY6yjnumWG7SM4i87nzhN1Qq4KvylcFfBD5r8CeewVpAFih5Cd0eqQBy73Mn
         wCoNSpOIL61buXMYx0FRWk3ukrw1dgfiMzM/Vh2uwfMWFu524Giw1Sd6g4i/Yv/ZSs5D
         KPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734397; x=1734339197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cyT+TFbRaSz+vYeKaMRbh97PUnS/cHongWol9wj6Bw=;
        b=wrWreAVqEadsxYIn7/kibCikNpWxmpe5XNVK1mxqstX0acA7rCiep9HFnNbiJQ2k2S
         2y//ONDlkGOFO0QiES86ZI9WS7hvVX6kiFajSS01EXGjal0oc5zbpXRsEmk10Ohn7uAj
         dMovaavgYtnxBE+90GvS1Va5c/43abIsTKlclCjcJ61oFOV2D/Supla2gFLhdH8TKPGH
         mSUzIQ8RP5jNjSUBoj/y8hbd/TrZnkbzi779hMqVPUTtw5+duU/SaEd2j6a9gqvV39Fx
         B6bbFSzg+sshGSjrpXaFDpIHmHPRfxaX+OibdvbclHO41YAGHGr6tkPHGXRkm0W3hix0
         Vifw==
X-Forwarded-Encrypted: i=1; AJvYcCWCudE6jgU4y9/pUDDDjdmQv8a+XmZcaud6tDH0OfQm7Y8Eeimby228Ducndufm/l9EDmM/9vqcqHY62JyQSH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM007OF27Kj1v29gI9ZgzMBaT1isVlpaw+71mfRxLl2qNwShuk
	m97zpWdqSU9atGUV/7XEgYGopUoqjaRcfWbqzrQvNyKdkuW+OHTgdSDSw3I2XgYkc+bkA7OswTe
	v
X-Gm-Gg: ASbGncv49x+330apkLltjulTCIdm5Y5Kp6CvY+r3FbCBPHKL34m+TKp8f0is8WY2W+3
	y3lJFCiMfJBJ4F9sltNMJ68oUznxoSDlabuwTtTLeJLV5UZs9bn4+gZYBiDruu4W9mw0Tn6XWxW
	qF3Ev1y2l5MhHhSXmii4yqVpHWjE91CyGFpG79DpPooSqw5ukUXnydPfGQfdju3necedvkWafI3
	4Zm+hlBJJc3pO3JTSFuNLX80hMWEAWhehqn6DMR+HHElLrJu8fjON8PWC3y
X-Google-Smtp-Source: AGHT+IF2L7jOxbcXc7HZVB9jez6DRnPBMEc3Djqdq+ywY0oQLtaHOecYVA5BJDgqA6V6omFKfoWtHg==
X-Received: by 2002:a5d:64af:0:b0:382:5aae:87c7 with SMTP id ffacd0b85a97d-3862b37bdffmr9587477f8f.31.1733734396928;
        Mon, 09 Dec 2024 00:53:16 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:16 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:24 +0100
Subject: [PATCH net-next v14 15/22] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-15-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=erPTYrweFrnKu8N8OGwDdEIbYQXq1gCniqH6iX4uYZ0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrAUIqsyxw+2rTKyOonqlGiBDvkBLsYim632e
 jGhWxypsHOJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awFAAKCRALcOU6oDjV
 hyAOCACSKx9KqPL8wCd9b5fYR0vtsed8xWroMySDvtYi5z8w5vq4b2CbLKrxqRL9fqpdg827aK3
 vQCy9mjmFJbHhXBpueOzcH5MR6WtLkC8OQHWKBH4XI7c0rGQKJ6afI2LzmxU8f59PtUdh76Zyxu
 8GHW30fPT6kOKBIBEzAiiVYTx3g9iNEs6L4Y5T4NUjZRL/i7QuVc4wBpBMKNlY2+zAXF6/ds5Hk
 MXaU6NhpMLnq37UCFp8SELZo0n/QIT8WzJP8sv5stphJQDDo1xU1EYD+TDddp2xGa/xM6i9AiFD
 xzXM6weikVu/F3MuBucuaQwz72nxqE4Y3aDIJu9WXNFaEhJH
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
index 168cec1cbcead962e921d29822fc0d9dec1f28a4..decc80c095d6a82787d42d0b4d50f85016e942ba 100644
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


