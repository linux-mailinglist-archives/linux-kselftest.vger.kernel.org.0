Return-Path: <linux-kselftest+bounces-26298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721B8A2FF7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644FD3A7896
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F3C1EDA08;
	Tue, 11 Feb 2025 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="THSngIUV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E51EA7D0
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234487; cv=none; b=izHovArNQe2tXIGoB/2JNNBXAqzgaqrVbkNTVsI87zQPCWIYdhBqYU73B9Ngsqd/G/Dj9ezRAxiLUW5oMOBFm4iWJRWmrfSZJGjb3hfLwLP8eHTyA3AK+VIlD8b3MSgZ3ZPJDa1MzzRHuVX2yTUBX3cVZBiZJq0umekuwDKGzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234487; c=relaxed/simple;
	bh=kRLxFU3RIlci5q1fJZL+vCcCgb57tun1V4Hh8BduQcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MT6l6bItKgmVoYWd0VBVYkikCPVrbk197bVrOk9+yIFJAxIfWkYIK2J+htJMtBJ7faHMM/xAU81BO1pHeg49NR4zRrHb453nSe6j0EVIQtmrgVUCahYioYpettZyf03Mke9ON+AFF2e2XF7lGl3fXgC0yXei/s4RQuAWJ6+BrIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=THSngIUV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43948021a45so12133055e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234483; x=1739839283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=namXF0RBmKLnN0h99gOEqMwzL/zH7E46wh9CkY0RGP8=;
        b=THSngIUVMn6bb/kW4uCCa4iqHeLza7RsEh1q/yXFxRN/vnjwJpfPLtRhTH/NGPWfT6
         KBG8PHHicAAH+HX6dI3XvvZu9/uUuUi5qJUyACObFsQSxben1684T6/mRL6AlDtwqDxT
         BupJGIQDjYq4LFaYOgB/Mr3iY4mB2hAgVAidJ1uP0dFQsR/WCdrEzG6IO9ARMVWozft1
         G5uQ7oh72NecKnH/cXgiC/tQEuaQiTzIg2LQwjGikWtbBZCtURPsWmg0NnPA5hWPcDiS
         +AxzEsDrHRDcPCWQ1ZAKMGkEbsp2q27BprWMGtBG5TaraO6NZ+zWn0puDA7yeYbO+og+
         X9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234483; x=1739839283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=namXF0RBmKLnN0h99gOEqMwzL/zH7E46wh9CkY0RGP8=;
        b=cD3txcvbmBLqWs9hGUL4hwDBefPH5SFbkHaFRut878gj12bvy3+DqdWG6TWPy4AuJG
         zeX1Ir7PKPpoBxCouwfARhUUqhMHa7RZxQ0e3U3HTEQ/QW1M0SK6fgpltRSKxZNt9fwV
         bDlI6HJr4OmekGRXBlNUG48hw+z1ITJneSpxMUuC1QwGwCxX8yPxPuXKwBi8P+sN0Gej
         bSJE9WX3RgaSuaSDekPChtaB9PQWmb9t48ke3ukAxC/yL2FccyhtQGNAsLGyZfIF6pj/
         KJ46W/RG1533+X52m/RNKy6Lc8M69EapO2knI5FJ+8JOZlnv+fzKEMxcPXrPzfIizOUl
         Wy7g==
X-Forwarded-Encrypted: i=1; AJvYcCWNEEDyowcfaU26uxgz9Um2fZ9A4MsDHFhxQtLjciwc1d+//VwXMPOKfr4MAQCDTcZmzAiJGpEtLXgbHbZBkFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZtgg9Mj8jKq0pb6qcKAUh90rv/IqmQ44qqAfts4aAEpIJRfm3
	hr+CDA88Qm8WZC4BOjtRiEoUYnL9/06PXO1swqQhl5V1jiS/WwrsO5mRvzB3byI=
X-Gm-Gg: ASbGnctWVJyFZrG7P3WDkcexNNbpQvQZSj+n5Dj4EyGFKwfKs7zqy5dvHCk6J66gF5Z
	h33j27N/fopEnvUqTleCRyxfpVWl6lL4YkEctEsUYnHcdT2VrsdZhXPgaUQc9skFcGqjvg9KimL
	j8EY9xibKa2A/2yAQE+/adSthAtN8ng0zWp8MiOPrQGURd/ySuNfLF/1KyN6KT19/PirrEfTg0E
	cWe8jnadOW/uKxP2Cslvfsq5wZkvHVkeoe/NxP+ZAkzAD3uXnVFjDJE93j0UiWJJGeqpcFtKr7p
	DpZ+zFoz+dEMZFdrmO70CFiddDI=
X-Google-Smtp-Source: AGHT+IFM4TvrZ0AQn2sqrlBeBKrS62f7m6vNPrwbr+HRevP3undtugBQhouVV5NamQiETw1pI9KH0Q==
X-Received: by 2002:a05:600c:3b8e:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-4392497c946mr120973235e9.4.1739234483492;
        Mon, 10 Feb 2025 16:41:23 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:22 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:40:11 +0100
Subject: [PATCH net-next v19 18/26] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-18-86d5daf2a47a@openvpn.net>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
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
 h=from:subject:message-id; bh=kRLxFU3RIlci5q1fJZL+vCcCgb57tun1V4Hh8BduQcI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyORYiGL+cLU7KHfiPZWT6QIQluSWnOnBsf2
 ya3X+1qzbeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjgAKCRALcOU6oDjV
 h6wDB/oCBdUEUiwyfpKf0bZFhoh6ICVUfioO1Mqvs9lXAWXe7QVQo+5YxOKqQUeIyornKSf5YRT
 6Sb3hFVRvp49qyULn5TrkZT1EMz20W9xPvIKUVOiPbRXa3hz2oACZyvEFMB/bxSTHlzG+hRu1ub
 8Bx3HWgj1cZxFj+karMvUQtK5IkniZIo9x/T3URan5+tVjaE9d4E0RWVIjpl0tIhbJ2DYZTDWLE
 4OT3tbOjCfnkxRz3zmmag1LLQabIZD3h4BjECfX4bprU/kvFTzn9viuzuiKf3xgX8bumE4SpRCV
 pAMoKhB/qQCvd42taUFJbQLWFHWnhi8l112Rvw8syIF9X+Cx
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
index 483d5a5d069f213930d6e7ea9130216988672d21..6cd83bbd85a8ffbe8ccb32598db2a5406583f886 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -513,6 +513,51 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
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
index 68f8ed281b175311363787f71d582446e55efc79..18dd9c8acc06c8a9c9e1393d76506da80fe1b25b 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -152,4 +152,7 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.3


