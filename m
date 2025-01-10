Return-Path: <linux-kselftest+bounces-24262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E275EA09DEE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E3F16A47C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73787225A46;
	Fri, 10 Jan 2025 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MRhjt/8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92E226168
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547998; cv=none; b=AWWAEjP+o5up/LHBHbLrFdnk6Nnc7SG2akBFDCDugoJVsysbwYOE/hogLuvOHvx3kxofXr0nC7ilnE3qowu/6ZHNStNt4QHSL7SX3ZxJtKzLM5J7uS1vsF5BBk9wcmzfd4Yibm/3W0UtfPAzcGt8YdE98iwKxuuXFX8PYsdZEFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547998; c=relaxed/simple;
	bh=sfnnny82c3hrw7F908dFCzjAwkrJZwFLmunTOd1rYr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWYDrVJWf/AV1I4gDLOINDVVCnGUIw78KtH95p9Zypu0wXB00OSm3yW0C77j6zpknCOiPUBFqmjMOtLtCLYBg4hsx5p4rEGQs7Hervyeput+pkQMpMHQCOIY+sImHSz22LwL2NPlcX24t8J0gkVwjG6mXTFyTOhnBlWSwg51iBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MRhjt/8y; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862d6d5765so1475554f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 14:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736547994; x=1737152794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9tsPDxSi4SlwJAXcn+BgBsXrwiXO+HoGaW69KY5c0M=;
        b=MRhjt/8ySakZey6XOCKoblQsduAKJSN6bxjUJ/4dtIeN4BDFWVQy+Ey1/4jqWrooMC
         IBLXbycElNd+AMcJd3XuTOQkQDH26SASePP3MOYPATa7mWq/aKgC/X4UHvihcjTFLDY+
         dK3nslF4j21JAvIUhp+2hIjIjlIYcpdswOwI+B0ULSGJI/8IMeWF+wFHJIkQ05F7vRDe
         bEcIiMbgrSeJuuI3fKmAG6gPQ0upxmQ8MpBDWH6fC17jW9fg0YAhjHd23sRncuohRedS
         bwmdHmF2msqlbw4iuYqkkNjKgdI663nX5PXDZ64AJjhyqa6uCTEPPpfWJn6QGitoTqi9
         3F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547994; x=1737152794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9tsPDxSi4SlwJAXcn+BgBsXrwiXO+HoGaW69KY5c0M=;
        b=pOGG5b6x4L7oOgs7xMltpedqxqju6PHzoCkeDI4UsGVEVhRYTCckh7EI2LSBbKy+ck
         M9Tw8ySa7y+3lV/1XWivOE7ULI3/j41NM9/RbMd+e5uLavAiNnjF2Y3d8ZTTdiO6/0jN
         aXT3fK24G6mu+TmlcojBAU9nLqvGQC9MJK5FdG/E6bMBF4Dcvq+ZuaAq4MSkRiLX+bV7
         s6t70N1fBT40noozgK6JknBZL1bqO8gvSinMajBwA4LHSAwOkQXLO1i4xB1I5AlK6Liv
         h03B4ZkAwc+yl0wG1ucMtNRy0i6xzgINn300cbx9c8LNCgVFdKnx5MZRx6dQS0xXT0tX
         ZIlw==
X-Forwarded-Encrypted: i=1; AJvYcCW/4leQH74HAPKwKYdmZSGx6MJbctqsd7TgD8/X0POhIcOkI+JlVacDsakNHNXwNMOL3cE2IChK+QTD1CHvkHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJvX3n28mgLJw+Rqs7UPtTuNeEPrIVtOhG6mEIV/Up1jImVAaw
	eBLPKzu6/ijoyjy+qCi+wNteqrhmii69ZBZDoD9Xm2wyBKRtSR1QH5AVv45s8SU=
X-Gm-Gg: ASbGncuwh7pihmiIyhOg6ZKjCiX4MaSEQRgDgSlBRLz4+tOzdT0cwLG5PPU0rK6pmv8
	AtT5FwtZVRn/sjtzf5a4/MX8I8RvDbBXcZ5jmIoRG6Z5WjjArKeWp8fhrENsEFFzcpr9poL+n+L
	odjExmo1XxYcJhV9l2RmrqsHdwQ3xi6ahDd/NgEt7oaG6NZs4DZPv3QpeJQ1EhWw7EeulZzbVqf
	OfPxOx81ZuJEpJKztmPU/dDsBd+jpgFSWmxZfG/8Kt/k27UJ9+NKevIUTcA+KMaAsCi
X-Google-Smtp-Source: AGHT+IFB8Nbp16yiNArRtim/1kKMUFl9n4Zth5DCTRTFFGTNTuHTf4FaHe/WqtYsW+eUNmmGgGYUlA==
X-Received: by 2002:a5d:64ed:0:b0:38a:9f27:82f2 with SMTP id ffacd0b85a97d-38a9f278491mr161034f8f.49.1736547993901;
        Fri, 10 Jan 2025 14:26:33 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:33 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:34 +0100
Subject: [PATCH net-next v17 18/25] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-18-47b2377e5613@openvpn.net>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
In-Reply-To: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
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
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6xLzuH/xgoOAJNKKf0ApiTlbxy6rpMfuMHB
 VQBGCZCvQaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GesQAKCRALcOU6oDjV
 h+40CACgAh1+YbuD05ba9IMudNNMDGLZDn9uPS4AP4B/gKUWan0x4IfZF1tML03GG1Pzk+8zYFj
 /tneK3X4T5yVThaPLj766rvyMq6L9WpidsEDdhNR1xSn6xIbjYgXqw8qvrZhBRiF4zSaVf5EYse
 Tn3FWq4uu+KokaF7icD4zNunvyAqLreq0FN4l7Z01/sOecZx5Z1pGxByat2V8dCUvuXqgFHn1rb
 pboiwsD4Ykd2cryk01bjZqfATBLhpctuxSmucDW3M7dVzzc8U7eYNeoeSoglaoA239lCjeDEJrM
 thEvC+Sfl9LFw0IF7zT25bxay1s99skdg5byosQ1TvzNHwHM
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


