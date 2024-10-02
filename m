Return-Path: <linux-kselftest+bounces-18884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CB498CFA7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C7EB25659
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9591C8FD3;
	Wed,  2 Oct 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QWl555ky"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED91C0DE2
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859822; cv=none; b=nG5Ae34sxi1+cd8dez6efZWzr9qPvf/dUS5W5OW31NLeLG6AnVxo5IzmieBAalGBtTw95ymH5u4lzbZr1T8TfIoYe3WRxzN2QBjqiOBxGlBwxQHnNjuA1Yz9Fgew/008h1Mf4bpBdQ7MObn9eg9NCiCUnGI1nvcdMuLGuTa3Fk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859822; c=relaxed/simple;
	bh=em86kif804PfCNBmcFWnuObwa9l8Vt83cqY4INjENwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILdCOCGwBDQCnBaEatUp6kAwevJO5bGe61O5OSoivPM+2htjAUJuB0bcq2C0RZ1kEGClrS1bqKc8ZmHrPIOY/De5yYg33N5lEvAJ783GIfIT4GIqDUmfqfeU1DFWeoMv5o47sDVme/jTKFGJ11mfTXP1kZCq6zOVWJyXiCVHzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QWl555ky; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb806623eso50614125e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859817; x=1728464617; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4U2CGV7Muz0s4AKHAl9CLluIYCvToAM/yW8K6lT7kw=;
        b=QWl555ky6tsmFx1W+LFjVV195OajZjc0dIE3Ha5IaVhZW1rOffRHFofbDelY0mA/+f
         mF3MSR1ouq84eddhvKB1ARvduG0L1RZxN6pofsBcNFdbQBxKpkH6i20sGIOuRrdSOrZ9
         vVZ8p3AGNIIs7pR1Jaz+RxO7aVFwczMFxm/4DB+sKTDYWYWbGBJQdotHV9gsqNRFrcbP
         HYCIrCNd9SmXw58AaP58q8L5/w/bqnXa0mHH0haeFW/odDE9h6C0rWm/XLAiSULnlm0a
         TwFTnyN+qn7/baEtQ4nuA3grqsA39RHyDEJjUq3TvmYa7xnqxPT/geArsUCLz4Albim+
         hHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859817; x=1728464617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4U2CGV7Muz0s4AKHAl9CLluIYCvToAM/yW8K6lT7kw=;
        b=BQ2ie7/pqalqlW/J+SwvG13cYlQHpqnoV4+wbQXFDBG5M3nif8p4qaLOHoHj4CnUGI
         6hJXO7bWhZXqpnZb63YgT+G8fTcSjRavA6IZ6r4GAh7u6uOlon44XQjbnE7U3Sr44VMA
         3z51mJRcB2vrEdRjjDivlszrLB4WFSrUXcbs+YMfUaVMmZ0D936j7149ojlgstmf+uMP
         xn/2GrPnwU+EflAsGGSdDj1up7KoM2PDMF3L/LN0mlRCOfXOMa2QR1lU17D1TkcsO0Bu
         ouLi3Jyov2PlREk1J1KjBI+CGGV6v35jbjC/+mO8aZEe2IvxG7D3YbX4GxLEAUTKvNCV
         Z6VA==
X-Forwarded-Encrypted: i=1; AJvYcCXKCfS8VSE207fqTlqWsGEfQVUGY6fNC57u/ZsfHKvoCdcwM2pGGjFYyvWQGN2QHcm2wetxNb2fwbP4GHZyvZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqvGAa3I6nod64MD6YZt0ElcqU9PDLvRRuQey2EAM8TR4D9lEi
	3fK5u//27IkM0EpLUBhHXYDZ8/44QqEcB45VDnR9ZV1RfLm+8YiT6PvOd6Hzsn8=
X-Google-Smtp-Source: AGHT+IH9aZ1vVNBI6bT6zIA82+8YSkypRqTem5OODRt/ezqjNhFnFYCWf59vLNgAuurWVB/PeYOr5g==
X-Received: by 2002:a05:600c:1d26:b0:42c:bae0:f05b with SMTP id 5b1f17b1804b1-42f777b0b18mr16920025e9.1.1727859817534;
        Wed, 02 Oct 2024 02:03:37 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:37 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:31 +0200
Subject: [PATCH net-next v8 17/24] ovpn: add support for updating local UDP
 endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-17-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2783; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=em86kif804PfCNBmcFWnuObwa9l8Vt83cqY4INjENwo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxSiIvZ1T7l6cNYuhG2aSBM1H2D74AI73/f7
 FoyNbdLNvuJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUgAKCRALcOU6oDjV
 hxk9B/9/NHMXXWFPR1PVGYzYsGDBAAgpL83X4pLra9JkQ2gXTuMrvCzVc3aqkQx84VXDCHuorFH
 C+ZSB1qMARRATAba7CrYfEwHi7DRKze4yXYY72NyOMgWD+XhhwOSF/bUPSIPOFprhtyphENHLiR
 5evjJD3mRg6RNWJ12kwHYAIq+0xDvW/q9INN1aZcEWtUELz8h5xarg+AhugrtKm4tfxxG2I2O4Z
 sEYqzSPg8dWhXrbpoD+G837vVYavVgMW3dtxi5lYexcuyLc2cdeSJ5t6He9DeDtbHr3huaN97/Y
 Hin8iY/qh3/4FnjGBHKXoUmhSXif7v0ikdLFfkWFM8l8FayT
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
index dfaa4c7c012215b3dcd451b9bd1d7ffce9b1291c..f9d8f1d1827fe67dc4b4e0bba41a5b110bb90819 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -418,6 +418,51 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
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
index e0d8d1255b837b7ddfdcedc5a56e7e747f13e2c5..6b66e169b33510a794f8f43dff757f0357e3e5de 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -159,4 +159,7 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


