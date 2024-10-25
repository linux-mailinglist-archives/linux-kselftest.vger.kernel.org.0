Return-Path: <linux-kselftest+bounces-20643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6C89AFDF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE1F1C2268C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE09204017;
	Fri, 25 Oct 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="M2of6qoO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E720103F
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847720; cv=none; b=fH3YkM4bSdUje4ftQlOZ1jm7GNoG462HYlyc37USOsybgIfL2JAqg/0ckHBtjuW7jEqHD0xVFBE28ck5Az3VaKcWzB9u8zqUqmUL2eSa6A7Z/CQm9zTsGE/nr3qD3Rxr2qcK7z7yP31VLB5EEpJ7KYZune2MdPKojhdi3D393p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847720; c=relaxed/simple;
	bh=HPD74dFTUJVw1Mb6Tnva6vXx0/GeHnn2miLgqXGsZMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gvkE7T3nkw8MjxFNrf13zb+VujpfU9lRvtH8DDzGRfbF9jzclgnGJ9claYTL9nKubSQqSGFwhfvSFxb3vmvuoXa6+4mp4/MIAICWeODLvXwhvIjtUoqCwaDzrrm0OLNoPLRAjg2kjjU2FQKIiGZwut7ZfAPjDRZTOrJBP0tGRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=M2of6qoO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so17898445e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729847715; x=1730452515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lu9wUpES03z5zwq1pp4zWiW8qVio/9Hy3DajQ5KhjlI=;
        b=M2of6qoOLMK/E3yiHZJlHMjY1COeKjIS790pzCVJxsmSX1n5pxDimPi2a294FFDEpJ
         uNmqWnaXea1We4AB1slkB/FB3XD5joJBnbvl3d/9oCXTeXZF04mGrGXwxpn53qE5KIAa
         TLk5yUvz5qXJb/kGDEOe4YrgYfAPG1Te18l5GYrcLqdlenFKRYHTWLEvNYgKBLKKVRip
         ausohLLuRqt2NyJVV3yq5x0jQ16k3WTZDkyaEncBeA88utDCps3EoJLwNQnhx8MuqbBL
         RWKXem4VF3rRVvw6ZYl+7JEkpPNBOukh6rdwBJxoCHKPUJ+UNQkFrnHPLk5RG6GceJRo
         8ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847715; x=1730452515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lu9wUpES03z5zwq1pp4zWiW8qVio/9Hy3DajQ5KhjlI=;
        b=rvXUKlgp170n0lfL+hqgnL0Ng2Px26lqwSEoA6KRuy7QlWcltx4rpnfxKCgS55Jxu5
         k1vY50yVSr6I/3VY8QgjwmAn5BiiKC/ipNzT1o/Uq0wnNasoNQ0ozKL3WkLpNUS+233L
         LeyipFclKkCyL1docrPT6rfrSomMHHkpJmeOBkhn1NCcqxIAnmjwZI+/kEc4yc0S9n9Z
         QkrxV/qOpGJcROw5nedrStBPsdDKhfySdkDy3G3Lc6UWstOBGtq6KM8jMERMs74Mhsgk
         kbENUC749AqNzn0A1lKgB8fNG0QKqm38oDGsbkkx4m/oEzXj9vzOHrS7xVcH0BZKSklX
         ybqg==
X-Forwarded-Encrypted: i=1; AJvYcCXkTU+QqjKgBncDGZ6yQYQYeyHns2b4uT1XjRY4Mrkba+s48tCxsIL4A5tQVrmnqytGpM04L5FrxTO/wH90mHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymlM8pX154hK1NsMKp3qRwEgzm4/I60VkMOIttBxjmyZQ8CMMl
	41hUC9xngLGxZ0eJkC5UQeln3QZ4oSA//Iq6mgJP7dZag4le3dncjQSN2KhYDFI=
X-Google-Smtp-Source: AGHT+IGxFCfQ0DxXdn5vLfY025luLZomVZrHiWhmxpU25o3hiR8B+2XPgbRFl3LodCSQufWu3vIYJw==
X-Received: by 2002:a05:600c:45c3:b0:431:55c1:f440 with SMTP id 5b1f17b1804b1-431841a63ccmr74876555e9.30.1729847714998;
        Fri, 25 Oct 2024 02:15:14 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:676b:7d84:55a4:bea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm41981485e9.13.2024.10.25.02.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:15:13 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 25 Oct 2024 11:14:15 +0200
Subject: [PATCH net-next v10 16/23] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-ovpn-v10-16-b87530777be7@openvpn.net>
References: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
In-Reply-To: <20241025-b4-ovpn-v10-0-b87530777be7@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2783; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=HPD74dFTUJVw1Mb6Tnva6vXx0/GeHnn2miLgqXGsZMs=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnG2GaATdM0afVsDUYpAy+zNu0h/vLTp0Qg1Mxv
 mQWOPGhmmiJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZxthmgAKCRALcOU6oDjV
 hyrmB/9K0WpNSY3O4niaTgrt32ih33tq9c0Htr13HdkceSixKEPS4fxrwa4ESHl0UBui84X6bkZ
 6nvLvLMf7GVR749tO+BD/8Fuh4PpF+8DRIf6igXJ4Jbmvn/ipCNgHsMY2usc02UheCFQU6CuytE
 qx0eweHgYpFOwwhUSq52idC1zVGZ07g4dBv7/tl/hmOIywFGvVCope96MehFoSj0RM8HVttz/QP
 E4ljLXVbJoQcX7ie3uHrSmSsZX1D6daIXuA1EgL1pG5lSnEw3xGm7dEqkx3Rh3rwS+VJOijfaO/
 bnzNh55jyLFqlUX1lCb6SV0lJZ0wkiViRgDnxeD4OVVnHXAu
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
index e8a42212af391916b5321e729f7e8a864d0a541f..3f67d200e283213fcb732d10f9edeb53e0a0e9ee 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -416,6 +416,51 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
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
+	switch (skb_protocol_to_family(skb)) {
+	case AF_INET:
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			netdev_dbg(peer->ovpn->dev,
+				   "%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
+				   __func__, peer->id, &bind->local.ipv4.s_addr,
+				   &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+		}
+		break;
+	case AF_INET6:
+		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
+					      &ipv6_hdr(skb)->daddr))) {
+			netdev_dbg(peer->ovpn->dev,
+				   "%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+				   __func__, peer->id, &bind->local.ipv6,
+				   &ipv6_hdr(skb)->daddr);
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
index 952927ae78a3ab753aaf2c6cc6f77121bdac34be..1a8638d266b11a4a80ee2f088394d47a7798c3af 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -152,4 +152,7 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


