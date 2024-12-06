Return-Path: <linux-kselftest+bounces-22949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBE49E7AC5
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 22:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C001888EEA
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 21:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C987C224885;
	Fri,  6 Dec 2024 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UMAJ/9ul"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E5221DA5
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519944; cv=none; b=B8ScmT0EnY7VAAGlH1YPWuXcsBlwz4oOP5gctAAgTLaEe3KhQCjNFmp5nb0o0/fYwZvh/3/nB0Wsc9fW27kaxGsAFD9PKS/1b6jO6k9h9wqHd6zuq55hatmCTCasMPsxX+UVKqXqgcuzJrKgE7DKW+oLNDE7sInAL2GIqz93IKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519944; c=relaxed/simple;
	bh=erPTYrweFrnKu8N8OGwDdEIbYQXq1gCniqH6iX4uYZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QdYhLP+rEK32Q96EWLzyRNpgyTCm1IyOnzo+hLzr25BesZclKTARqVd3nvxx76V6efmr5dyQ1rpc4NmZMUD9xO7jkxCFiRKUTIHsLWo2aXeYuEsB3NxgNn72DoXv47Nu/79UlARK+1yDatN/R2B1OHZrx88jr53MPaRSKOuOMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UMAJ/9ul; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so24781275e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519940; x=1734124740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cyT+TFbRaSz+vYeKaMRbh97PUnS/cHongWol9wj6Bw=;
        b=UMAJ/9ulnl8QRuW7pZwQjJeSSiYEN0fVjOy3VH5OgYRfDDn3i3QtucPmfu1GE0CPJ8
         NxhdvKibQ8jM2UflSg+Tsemv8NdWw+uimCs6g5Zx76t6qWl59RFpcsFziqAYpHB+kMso
         5oaE7Q96CGgYboAnz9Q5C06YSI2E8r6Z1dvI93bPSv+ZP5fTIZBjxgMg4onO/r4L0iPl
         7w+PvZQGKIWhhX5NBA2q4UYVGe92/8NTZCGuQj5R6iuL4MCpf5JSyOlrFO3YeJMYz9m5
         huQBYrt+P4ZeeaXR/vawrZfsShADQSLm86sjyWqb2VSTiRdU999rA6zdq7lOzqfjjgcx
         Uu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519940; x=1734124740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cyT+TFbRaSz+vYeKaMRbh97PUnS/cHongWol9wj6Bw=;
        b=YP6sF1gcdooQvLZxoIVIitZi4FR4F4aDhJsWGX+xR43G0Cfw+yuxzyPL6FfuUHrQzV
         NQTtAAJrL1cQLUfJG6AVDxjKo2tb56EPX5L/Xc1/a2Jsjqgl8lGVt+Zj6HRPXASwKgwb
         Qv/u0g2cQYPYevxm8ePsrj/wBctEW4Sq/RUQ3bivlxJ43k0HZErd+HhJ+fisxPuAKftf
         6COtgsGAjr4VlqcOLPcbFd1ocQtKBJfIgzmRrJTbXWLoVltrb5fUXU3or0bC9qnsqgCq
         x9faiBFX2k6nYyH+rBns4o0FVoOopdApm5LFb71rqqXMbnaw2l1U6FoLmASqdBPf2Soe
         nzUg==
X-Forwarded-Encrypted: i=1; AJvYcCWZY4OSjriv15jiNzHT7yQSibDTpNwvS2tbdbvtSEHhzEhvOR90aczhb8XwUfOkSqpj4J+fkIQb8IDtGVkAVtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaErHxGOPmYXSKZw2tVXIhVdT3XM7fA1ux7FnUyRKeFZXPYOON
	KwEY32+ULkW0TXoWr3BOkFwcq62vvW0BIcsxD6FCTbPCmOX7Jy+Es2gwyyo9S20=
X-Gm-Gg: ASbGncvDk6wop6VI25D+0VlnUcMbWLN7q02IOJHHkwSWQoAT2qvpiTMLcgCaN73MctP
	LRnJovTLRvgwsQuRlyMrDOg+eKrfVm7bgsaPI6RWErto6t//Dr4xwcmMiPF/PDtO8SwLu7GLnOr
	VZVVDmLls6ibvhoYPrkUGuLDmOBqH+5lRm8w8iszNcYLRbpD5oIkOTPjb+sh9QFcanJErBy3uc0
	PU4Uky/HzMMGxqwwUbhMCyaEb+PlNb5ZvClD1iB4vUZBvC8MO4yV0ck7GbQNw==
X-Google-Smtp-Source: AGHT+IGu6qLY53C0yoO6aT+2nQymjktc9X77m8kuNJGtIHYDdrEE2bGIzUewngaCu8CdjcRxJXFXqg==
X-Received: by 2002:a5d:6da8:0:b0:386:1cd3:8a08 with SMTP id ffacd0b85a97d-3862b3325bemr3770534f8f.5.1733519940294;
        Fri, 06 Dec 2024 13:19:00 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:18:59 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 06 Dec 2024 22:18:40 +0100
Subject: [PATCH net-next v13 15/22] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-b4-ovpn-v13-15-67fb4be666e2@openvpn.net>
References: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
In-Reply-To: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
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
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnU2pYPaFUu0WM9rmjYa1hIakLvis3UG4dB+ZkA
 cWt6/NXu9OJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1NqWAAKCRALcOU6oDjV
 h2cuB/9bN3LXMG5OFVwkE3CFCaoewrE0mzZ4ZM2diIeWArrXH9Kxn9fBFG6OcFkk60k57ZPDsje
 vLo9i2p8G/jTWidWmKAAAjD93InJbIIfe5hFvu5Q5y5Bzr319nOpNpEOVdWSv0y+2AHQJKWwA1g
 a73wM/RCOJtW3vBDHN6MtIuxckta31w2uhfrZ/4ZXxU5hERGAZJhYO2kdLb4ownoJgIL8CVeKG7
 PCnOg20jiyBU65/dJ9BznTj2La3I6sJ7bIaypZONQKcaKysv5PH68mzZ9N+66MJDgEc3VdR29lY
 r6qBncZ/AST1K/7nHjRNhlLEFa8eS0kHNzefqW8yYXANfzes
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


