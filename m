Return-Path: <linux-kselftest+bounces-29327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E8BA6658F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 02:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD1E19C14A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDBB1F8724;
	Tue, 18 Mar 2025 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BtqHeRFa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE478185B4C
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262093; cv=none; b=tTuP9/vIWAFH6Xf+ZemznXolpufbIeWOG63hjGOTcdaGrCDoS2yndmwJsppPRXXzyNE6dw5eZ1GhhfpvJBKprX5BKXeWalUZs3Ox4gp80OYuqyEOppvA9/6DkA+tmoka8XILyHsZPuEtUGxaZ9PZvd4pzqoZHX5++AHwz4IyE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262093; c=relaxed/simple;
	bh=Wp5o+vkPxbqe4bUAkAYAYxmd9f29cPkdavwxtEN36zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yg9uzjWOyAt8UnCugOJH36/fQuo0waHGHt7oNCr1PLVpT2fNaJHlPTPSZwBV1Dp6gm2/FjhGm5bjoXlYGrKDgfrWWHU1kTosnBoPDKjJS8SpCw+g54Cw66MYPfQxX1Hj0CDIWOoj/mkA3ALYXbyM0ocr3dNPdaSPguvVFD9Vsbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BtqHeRFa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390fdaf2897so4721691f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 18:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262088; x=1742866888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kW1HvxU13zVoefK9Rc4SS+Z+mUMZC5jeVdu8mBJXAdk=;
        b=BtqHeRFaaIGg1KgLw3fJQIremwW6bBiWM9L+GwNwtauAivrFOnR5ZGj/H92OnGi0D6
         1ViYe14F5UfSr8Pxap19SMvLEGim9tw1W3tzay5bNPz4QEYdD+gn0wrk0kpjK6ELqpgA
         QHid3fjE4/I/bfM2TRWM2+4+h+3zub5yXbXgvn1RVQNwO+VWt6KchNl5++lHTusUrM+v
         niwoC8nCXtCXcWQFpNTXDvtxPOGa9KoEVWYQU4PZvqws9VYD4HJ2TbrM8l0Qo46fB0kR
         ydgBo/AIF+WVOjt8Kk1j7eX+yBlvV1eT1XTpFydxamrYSCMuAeQFqDOKmX3+6Pm0Se41
         wH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262088; x=1742866888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW1HvxU13zVoefK9Rc4SS+Z+mUMZC5jeVdu8mBJXAdk=;
        b=DpmNs+5MKF1Bv7jBBKNVPUhMeGGR2Y1AUq7lZ+ZDwdwODb00lklawSLg7GnjoxjNiP
         e+O2HNBW5AsOHlsECgntwjqxuQo1kd9dESy0mXTNFu8UB8/vbQRZLUV583Bz7hqJQ81r
         jUlvKDrQ7hfb1Mg64lX+Goci8YcPaJfFvCm85bwLYCSr83A7m6Be7Dx1nNZ5EQcDjaHe
         78Id+oH5pgDxGCeO+iVWlqhvirvCgtUOyFu54nFYWePaNwiqmzLcB1keOrujHBZ4VOMb
         4v/iGcuk7P2NHNRdsMT312C8BVaMNDc9+7+Xtlu1iNv76fWO1OG3gLMUKMV8L9Dfs1zf
         zd7g==
X-Forwarded-Encrypted: i=1; AJvYcCVeuby9qbYt6JvyIoKbr4FHFxDibKOoqbWKwDrLLyiepahG8rQWuG24+VvA9rBOAfyDO1VkrGminLoUgEee8eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgjDqrbxXOu8a0040A9DbBNc2dXyN0wyDiiwtlOVrHCZc3+5kb
	ls2XIk0xsonpj0Qt30EjT53Np+P9x49nyiyfdqBWjoilfKv4JgP5E7KoGYxa82P997/BkVvOxkd
	j86YbmPHrikH8no+19qZZ7Fh4k4ysrwWFVdrcQawB3dWERfU/wvTLYBz4/Xw=
X-Gm-Gg: ASbGncug1bjAaj7uRhLncKgS+kTPbY6Gi1Vb2yPI4rdCvGpVUu+51nkeIsUS/SNvD2D
	HSe4t3Osh+IeR1NpXzzubT8IRogdpTl13FT96dsruKLr5V5pqcLZRdyun2R49UbDFzsAKCidZfp
	4laalgvdy58lJpVlVG+PKEBtpd4+asBF+zEBWZskEVKHgVraMguqalbWiVHfjYpbOrC1zpZOj2S
	vqGjGVYWKX2N3eIKXKCIZ45hbxANfVW5c1OYsjNzFJhyD5g4MP3AdR7wxIHdRHEJ+pe3jEt5Sa4
	f5CBk5DA3BJc+1Z07KCnuIQyWzPJwaA/ShhCylheUQ==
X-Google-Smtp-Source: AGHT+IHaDLceHKOmjaD5f5AzpdADouKlNjyuWg8fEKZhWiQIWyn+2sF8zUUncumDSE9QTD1Rk5RXnA==
X-Received: by 2002:a5d:5f81:0:b0:390:de33:b0ef with SMTP id ffacd0b85a97d-3971ee443edmr12258911f8f.30.1742262087957;
        Mon, 17 Mar 2025 18:41:27 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:27 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:56 +0100
Subject: [PATCH net-next v24 21/23] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-21-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
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
 h=from:subject:message-id; bh=Wp5o+vkPxbqe4bUAkAYAYxmd9f29cPkdavwxtEN36zQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn2M8ryu2OgiCbGdZ6SWjknGoGxOnNj7bYHKPl9
 OJ+9PnHweOJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9jPKwAKCRALcOU6oDjV
 h3RrCACPXevMoksTwYexu/Oe1eKz8zdoXJhyjUwMvC7Q0KDrYwhsSXJnHku2qiqSwCkoSWdFTll
 MSO2r+mTY2lcgSoGuNeJcQhc/Jlh+6wqztoV7LHOr4ovdFAnbf9vW1DWG27S4G+xHTR5J/XfO7+
 KOeP97LFz7YnfLfy8UnVyhoUnycDpIgyu0Iaqzp+kHiervZrSodsiMlpDG+USnXrQwhYLCjRE/P
 i4hWY3BVmqFNpix5WKTJoLdcU10ag77dIpStC5ceeXn6RwPH3uj++boNGn0KkEDd/qFuZqP8Nm8
 kMGcXDpqzqQLRVaF+BvBoTlOM5ormwfT1/rOjFyDHBTvDTMp
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
index 93152734098948b58ec1ba8a2ed05f8bb40c91eb..30f2a7896edd3c12d3741278d350661b2bfa0f64 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1095,6 +1095,71 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
index 3af4531393f66a4c9e0fe64dc333f89b98efff6f..0b1d26388dba9b7129922287e43a226f9a2346c2 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -706,6 +706,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 
 	/* append to provided list for later socket release and ref drop */
 	llist_add(&peer->release_entry, release_list);

-- 
2.48.1


