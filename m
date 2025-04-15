Return-Path: <linux-kselftest+bounces-30861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C576A89C2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F25441F8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05DF2BEC2D;
	Tue, 15 Apr 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WZq1u/x+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276729E07B
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715881; cv=none; b=bqBdnwto6M5H8G8cRUsnOwX3Kg7LrfSOEcnooBcSU3226JhUHeoRrFOtP5+2uvQE6DE/s4IuoE62da/lL3cIdEN5P7bF37GVNt3cRiFi9e1k6rZ+9Q/okKZVS3vl8phVikgeXgf/ULmpqhRWT2b//xliZqCL6QUoPxq4KoFt09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715881; c=relaxed/simple;
	bh=msH2j+Q6ALu9sPaWC8c9A15IHOtUvKpWFZuqoXCVm1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNMpsDpn3jW5YokCkn4NKzAzkmpLmEzYPD4AQArIdIAY+P3lo06ht60o97euoxVCHPRlzCLyBgis9gHMY2ZL9f6/ItZFAqw+TZStapc6DO+z8zNBaDNySvEAQaPVoZY+f7IvW3D2zPF6JflsChnBRaQ/m/55WpVFAw4zF4v0QNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WZq1u/x+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso36382345e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715874; x=1745320674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DObrEelohmbhDtacq4AF90RWgYCcWXl9R0gtuBJxDJI=;
        b=WZq1u/x+s4paJ9CTh4SIeJFodMQcJd5tIKU+cLCiYqw5ds/yX/1bxgtbNxW7dq4XTu
         C8tLIYiRcdr1XbC9G4NQI04U4DJ9RUd3Io3KWU1EqaqasJ7L0OmF9wdDOHuYV+D6R/p7
         UfIBEFXZpk2AWh8RVstqTOVIpAZvMXUJ8priwqeiZUSxqoz/LAEQD0lyrr8CAjDOTfwe
         on1/Z659wshxslWY0XEo+rB1xmThnq0qr0Ym2vrrNxSnrv4U2KmDowDVs2TS26y7iCdB
         15mjYLKROSa5LRnNOQVtFcuFP9yb/NLaGqkE92a5zwxX2BXYyMXWDdyky0hmqKeHvRwD
         qfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715874; x=1745320674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DObrEelohmbhDtacq4AF90RWgYCcWXl9R0gtuBJxDJI=;
        b=rbS2y25oqLuqjdXQx+aOeH6ZL/p/XtdP3olPcxBh2YsoSFG8yIxn20msb/SD3KeB3F
         /ao9akGQdc7QHHdEpg+X+IapSHimYN+uqykr28XywGFN1IgJRZQCzAIJujKyBV11+MAc
         /XO3s++0KEsljoNvzMs0pQ5z2JGH9K0YdZTGvepo6Ep2MS3+CRF/cXWk1MVLF0eNgClO
         iqVzXbnfcmvTBv0CrHbJwc3a0CRX2C/rsmOLf17MbjHg8j7xR58h+hK9aUh5jG1FScfV
         qDHvOiNTvxLkjA5OqF9Bil8D8NKE6EvPOrt5gc4ElVwzCtfQnqAr8mDVRMbKzP7R2y36
         yCDw==
X-Forwarded-Encrypted: i=1; AJvYcCUlKmA0METVK88fkqWXf0raka85tqcUI2nvCaUFRnTcVza2plhFPYKoXt4LKLFy0pQEBaP9AYTLzarjqHY5oW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqTOSJVPK9EMLAQ9VhZPmpknff6e3xVLMoLwnoPrlpwf9XGJHe
	8rZ1Yy+nMw30zObFu9ZD0kHELnKyTlDsq/w1eOR1n3PaVj1s1AjeSLmj1YRECz2TTjnuDId/C0g
	4nGfng5xBLDUdGIYWb0fBIIwd5q7bmIhvoWSAl7WNsM/Kh2hJgbEBiCuGdAE=
X-Gm-Gg: ASbGncsGPI+P5mdMiJ6BvdOte7fC4mOkmODYKMvtnsW2vvOgjvmwV9d1ebWYT+ru1O5
	Fn7ByYUwPucVUy9dxCLhKFLxYrPYxJNOZUqtQlLBdpbMSXTts2J8C+G29YolrNxd4d1dQYkeTWD
	wI0gTOPB9qna/38ZcHtTOCjq5oOkr7GzFOfKqshO0OJTRm8fYpkXwIa/rnvYFRej8eAiPEu5+y1
	jlDoPNaydx7RU7Qzan+UTKjiRpOeUW3Ka5B52w4zFXUMjdo4cldy1+vyp8ZJ9wpf3QZYon4pcsy
	2jMvS0sWnA1t4aV4oNiAPUz/oPUgAIx2Lo/hbw==
X-Google-Smtp-Source: AGHT+IEVtyPWfeEm0iAB1SWN457EOBw6FOEMlM/OCAQt4uzO7AOZNHLuBgdFeFZZEcrRfbgsh3KthQ==
X-Received: by 2002:a05:600c:35c5:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-43f99889ad0mr22670395e9.3.1744715874331;
        Tue, 15 Apr 2025 04:17:54 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:53 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:38 +0200
Subject: [PATCH net-next v26 21/23] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-21-577f6097b964@openvpn.net>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3532; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=msH2j+Q6ALu9sPaWC8c9A15IHOtUvKpWFZuqoXCVm1E=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBC251cpPT2Ir32maxXT+1GseMs0GX5F3HpU
 izTyIMkSiyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQgAKCRALcOU6oDjV
 h43yB/oCyuzwiHH/C2i4SGt96BFO8DmgMOKrjPMmw6zYgOTTb6RFgTOLtYKTY3L9orFc3eiWphX
 Z4bBwgHqlyDU7b0ApH1oeCg3Xzr1Ef2x7d9m6k7NK9V2mLsDxk+PIDwAG5m//IkP8TxbGb/Twfo
 e+7HtRxIPW/8vyx6OTazLFNWHMhS5HMjPcKwltX/YTBdTQT+Q2uawJ8wQmsBoF61+keCPaWclQk
 rizH+J9ZnTg/KydSKaqWEuf4BpEfPjLTTHKl5MExeOJQprLU/+iob4aL1lVUegrlmn9en+VJtoF
 aOyJK8WOkQzAwRV3k7G8qRjen5MUNsxDjzYyRRicigiz0qpb
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Whenever a peer is deleted, send a notification to userspace so that it
can react accordingly.

This is most important when a peer is deleted due to ping timeout,
because it all happens in kernelspace and thus userspace has no direct
way to learn about it.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  1 +
 drivers/net/ovpn/peer.c    |  1 +
 3 files changed, 67 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index f0b5716059364a1deee1c7d4da1d5341b53dffca..bea03913bfb1e1948d57bd613d2bc6241c76fc06 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1103,6 +1103,71 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+/**
+ * ovpn_nl_peer_del_notify - notify userspace about peer being deleted
+ * @peer: the peer being deleted
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
+{
+	struct ovpn_socket *sock;
+	struct sk_buff *msg;
+	struct nlattr *attr;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	netdev_info(peer->ovpn->dev, "deleting peer with id %u, reason %d\n",
+		    peer->id, peer->delete_reason);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0, OVPN_CMD_PEER_DEL_NTF);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_IFINDEX, peer->ovpn->dev->ifindex))
+		goto err_cancel_msg;
+
+	attr = nla_nest_start(msg, OVPN_A_PEER);
+	if (!attr)
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
+		goto err_cancel_msg;
+
+	nla_nest_end(msg, attr);
+
+	genlmsg_end(msg, hdr);
+
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (!sock) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sock->sk),
+				msg, 0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	return 0;
+
+err_unlock:
+	rcu_read_unlock();
+err_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+err_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 /**
  * ovpn_nl_key_swap_notify - notify userspace peer's key must be renewed
  * @peer: the peer whose key needs to be renewed
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index 5dc84c8e5e803014053faa0d892fc3a7259d40e5..8615dfc3c4720a2a550b5cd1a8454ccc58a3c6ba 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,6 +12,7 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_peer_del_notify(struct ovpn_peer *peer);
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
 
 #endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 0469afd6da238d795b63b9e68c8c728fa324de98..a37f89fffb02efbb6468d54c93247b170b5d11f6 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -706,6 +706,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 
 	/* append to provided list for later socket release and ref drop */
 	llist_add(&peer->release_entry, release_list);

-- 
2.49.0


