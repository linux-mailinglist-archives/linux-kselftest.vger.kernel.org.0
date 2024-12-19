Return-Path: <linux-kselftest+bounces-23559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ECD9F721C
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6393216C8A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99251AF0DE;
	Thu, 19 Dec 2024 01:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AiP3xnzZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A181AAA1C
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572559; cv=none; b=EXA39PVzTh5eSc3suRhZ5LN4bK2+ViT++JXesxLUfczmOFUR1ya4pki257wS9QSx2qlAqiHvxSfNrcXmORh1ALY3wMGeGfXXGk7ORQkALncr6V86EVK3C5AQeni0tP433uKoGOF3maQS0NBgAGrpW1E3DKcNOfupHzSLuIL95vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572559; c=relaxed/simple;
	bh=VAPwP0ND+/+1uiNTYTyRb5dZNF+tB/wOjSEeaQmrIbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAX1tdBp87mTnfLJA7vFQG+xjnlIX3Ma39vPv0NAsA5nrUxoZFzAIp7ZaFFMiAbuVwHTqjsE96NGT49OfeHaZah9KjM/j86SE8y0mB3QZPhTZpBX6OUtepn7mT1c7CKAx0lVj16HIGGH0xOp4LlAP+tWrkZF8LWSrHz5JPnScj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AiP3xnzZ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e06af753so141938f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572555; x=1735177355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71K3bveKDC1L2h+3pjr0ZAS8X5H0eQHVqfTEUOB0SmA=;
        b=AiP3xnzZ8jdAE88Ib/wxg3sfCKxJE5LfVatSYeucBhrVMYV/alQgwvkbKXBNny00TW
         6MQM5a87ApXw24lX9AdwvlwC8U3/V5uq8akLGROqbU/4ervFtJ6tjWIXhyKIsjw1UNZ2
         PD2R8dUcFXm1hrLkTDueTHh6OlmDd317UsWwUgnESt1Xc065gsxtr7nUXSg72UhG2/Pr
         azA/13zyFwp5ne6bILD/PeRswAewYFjZaOnmm5mqf8awqXxfPP1ZqnVnLXVCZ+eEQmGQ
         nPt+frVRZQg8fmRFcnKU/L/yV3j1v1ZbKNQYLALMH5V2QjB3/CS2/GWtzCQOXyB4E9Y8
         QJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572555; x=1735177355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71K3bveKDC1L2h+3pjr0ZAS8X5H0eQHVqfTEUOB0SmA=;
        b=ni109n/WAwQxoMxOK3/RHtOoDBMVd+jgLQddxTF7y+yN4ZPuCgJ9eDbO8DW+cQW6Qb
         wA1bcwtM102lIWlxt04suENxoiuxlcxDdxmjs+dl+hw0QcebEpnwxoEEquNcO3o7PC+e
         MZS0a2N7i+uZW9c9b4xWInJPBGIm0Ynd7m8GsnFA9WXV4IZSAaCQtGJUNwb2k88k26eo
         tGszuwxYr62elqRJzkyY1veuJMY06qo+sYzEVfzmorAkK3jt7Y/MAU2iICfAGo1br2qS
         iVmR3duxR1ZVfRuZeZ9xINI1uayyfnMvtJyOtuOqg7l04YdVtOkZz2raAAIyF9g6+JOe
         EXIw==
X-Forwarded-Encrypted: i=1; AJvYcCUF/fYR60B5hnE+cGPA+o38vWQ0TZXibdExkKQp+bfi/TB1gfiCEDUJHo+kUglO+tIG/3fGK+mdvWgachrrFdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuvnzvPNoiainInoklEKSRSGz5edXNw97wYjFSRkWY5+AveURJ
	sbge1QdeLEf08nLxIQjEvUvUtpwHDSTD88B0xsj+qSMTmkMsaDUptGriNEXgQjI=
X-Gm-Gg: ASbGncvrI/daA3kG87DLjKiCoxEFUZ9J4uPGEnT3R49lttMAUhkX5PYYwiXvLJOBCaP
	igIYmcWrFATb4UAC9ko8PZITBfzMk0yAvaIANrEf8W6OfwqvoNqF2dbHQcVgj+8Rn5C7zw/twAo
	J4pYLHogiNviVHONazlCUXuyYcuAJfpFGd2v83zOa8rLsX8kDGIUz+nSzXBf7Q0aR8E+DfFO++0
	LPlVphUoemU7g+urBfeusHHHjSfo8UhMKLBiGhYAHRs4nXsTzyXjrZM2j0tvdXSB47p
X-Google-Smtp-Source: AGHT+IER03Zv7N1bOc3gTOhR0K14RNj9Um5Y4vXyVtDzBAGKb4Rb5giusVaduRRJp2NApuxvEb7FlQ==
X-Received: by 2002:a05:6000:186d:b0:385:f677:8594 with SMTP id ffacd0b85a97d-388e4dae534mr4399498f8f.43.1734572555563;
        Wed, 18 Dec 2024 17:42:35 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:34 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:13 +0100
Subject: [PATCH net-next v16 19/26] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-19-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2804; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=VAPwP0ND+/+1uiNTYTyRb5dZNF+tB/wOjSEeaQmrIbg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oWgS+VHR/thjZl/ElWuyxRVt0FlEFIIPK62
 Thifh5lOW6JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FgAKCRALcOU6oDjV
 hzeFB/0W2Nl3moB4mh64eu3jJIg880o82q8367RO3w2F9ZnnS3Fz24VaZz53vSBWSOfsfO9LbPg
 S7isOnLBwMT79iOG6FqSlTshgZHkcilvJeC3BtoznRCh+Pts+HbdQs1tSM4KQsax0mjb8zKWG9W
 CrSjB0nZX9KT2Q46N3l7raSmwAAVcF+gVGujB2AV8KNzBeXzR9sfOHnYrH4s7ye8rEIJXCa0SsV
 RUXrQTSlfFmo2adSWRvLPSEjMci2GkWkZkZp/VPVghD0hP9pvHCJlVUjmbAfc0XRLHSVF+ibObp
 fribmHLJxKd7qkwJIQ+Mtwxd+TV3Xh3mB8X+MIAcHM4RGb0u
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
index 0f48e7dd8f9d3de1afdb1f3b7214556b428e9503..56c3788a2b4b8c2a85826b1b23fa84943e4cafbc 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -495,6 +495,51 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	ovpn_peer_put(peer);
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
index 9d85367912bef741f9692fa3ef16536ea314d16b..8e2dc1152d29d9a322361c7ad9b04cef07d18206 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -149,4 +149,7 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


