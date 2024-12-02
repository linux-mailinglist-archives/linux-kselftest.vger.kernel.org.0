Return-Path: <linux-kselftest+bounces-22705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAC09E06C5
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 16:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7F0281D3B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A1D204093;
	Mon,  2 Dec 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ThEQYzKx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F22204F78
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152558; cv=none; b=INffRQuxEX/aiNZB5EN4duI6zCnOGYL8JstVyGIFL7ikxs/CxbeP0/65K9dRrrHGzoOwoIL+9lx/bhUmcstk2I6le7XpwgxmY+grDDqPx4hBcb6A/hC7SN/Zjlv5veOsQ6l7TNvLtHL0/9BX5jmN6pJ3CD01LmOZIQA792ykRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152558; c=relaxed/simple;
	bh=silTuCsQomSVhrC09ZgVVShik3tIYfu3bVc4ewGCVfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C8X1wAS5C8EgKpfM6eqfno+BBFxKGFnKCuBmWsIRyBomlzxoi0g/VijUcqvuROKPw+rLI6Orlwf/CsXejSOXB7dWC5BYpy8IWBiNaDktNl8DfEvVTWfo33GUgnx0TPAVpOtKA7zssoxEdFCG0ImYTlL4+9c4ZJZWUXvPojbsP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ThEQYzKx; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso806300f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2024 07:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152554; x=1733757354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4QULb/zX2A/JzZm2UGTqGndiLfwLMKYm7Yhm20GACk=;
        b=ThEQYzKxTOg0gmZ1Y1gPKer6jMceysqvIblc7B5TjzkIwSkLJ3XWzuUIh7PjlUDhLh
         +bb2RKrSBbzOqGHOrd5oHp5ZWoBEriI7SnjDuF4O6Caqc4rnObjDl0SutAWIxjTZmllD
         9MKN86C6jjNlSAnmkNvo/sZ6yKLx5JHwG5ag2CvYJD5Ao2rg88baY4kFHPAK0PoWAVNs
         VJ2kOgEYb4P99TvghIp5ZPhFRmApG2iwkqUJhwQZhhn4YLcdr+kxtB7iHKBuQY9kXNBP
         wljMhZX7ycwqlcmBOZ44MAOqrUgQadPtEQiaHsQSiFIw55n1aaHRKnxWn+1ExNJwTBHI
         DjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152554; x=1733757354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4QULb/zX2A/JzZm2UGTqGndiLfwLMKYm7Yhm20GACk=;
        b=NXPHwQRZ1ZFHbRB3iVYmVK4pmK/OnRtntG/QeDpJpNryoQA/+G5R/yrRQONImbKwe4
         d2HcgQE3pfhp82w4mTw9X1SI+IA54btwM49Xo4tT9cvo9ILu3mHOmNbag6OxNI17cFp0
         tilGEnu74udhJw6FlePJRKnQRLTCqGQGtUiiiIbB2fxaww7fPI5v1TBjHEFSDsxhAsBU
         RxtHvu8alvClQSei51WXW9AUZJGeGrTjfYp9UuPfQXEfHZY0e4hCiM9xK6CxHArTbK4K
         tPN81N25eLtU5sihVDZc4NAIFwgahP3TU5O0F/RRpaNVy84bfDJhSxLhQKUtPHOa1k1B
         Z4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhvU7hbOUIzRSgHsaQDRBZrD6XdOeS6UQWONvI4DfCZ0LkAEtjIuoDIzmHsNypmQyJqyg/1T8zKGgEQHl1cgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUBa6Ps0oi1ahvlgida/k3Vv0l1Z1uhO+c9M3u6A3lS7Epuvcw
	rR9XJhgZ+OQAQt9z1HvP8GdAyIfxKdKha774RUvMKiaZSurn0u6qZAknOqAuSk55EP5r7WEMdzn
	l
X-Gm-Gg: ASbGncuPX9t3VQcbIg/zF1EENxJHnWweb8/qfuxr9neZF4GCMQBUVUj13myYef/PbDa
	OFMwNpDXu9jmeINulWEkHujLB8fhxZ8zk+5RNjfU99JWF+WHPIjGP1AvobyUWIyDE8/UdrssdDO
	C7VmoAY0Q2YfQTM9nlcz8ItilmdHoN6Bu6yzUsDDfzHE8hAiT0Mm4vNa1y6c4m+a2lf4+bR2iE+
	g9x9ASdQs+1y6KGDaxzzybk6XEsSX62VvjnnZm3+lnNnL53K6EdRiCASP4a
X-Google-Smtp-Source: AGHT+IFxg4cHoPGVky36ZKZUxpd9wzXq36Jgdmrkwm2z2PHlDVLIn+dHxGtReNChwbA76uAlJYD0iQ==
X-Received: by 2002:a05:6000:1f85:b0:385:f114:15bd with SMTP id ffacd0b85a97d-385f1141819mr4679165f8f.37.1733152131775;
        Mon, 02 Dec 2024 07:08:51 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:08:51 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:38 +0100
Subject: [PATCH net-next v12 20/22] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-20-239ff733bf97@openvpn.net>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
In-Reply-To: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=silTuCsQomSVhrC09ZgVVShik3tIYfu3bVc4ewGCVfk=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1n7EZeBZct2cvZQHJDDg3pf8dCvuSbWp/Da
 N4oBi2Z74qJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NZwAKCRALcOU6oDjV
 hxanCACsyAzlub5uYkKgMpDIO0WKMwioHCPioVpoycFqd3w3VPcTBDx7gn+YwibOU5I+q1mSjKw
 aF79M27sYk58Gw9AOaPspT5nZ9l1ukOyfMlanQVSaKV64zeXWgmL0ygjZTPgOZFfot1ZwypOY54
 l9kfi67GNCa12a3fR7A59M2vHt/cbPgppnwV97e0stFUP9FZPbLlP0L64RskKtiGEnIYRViiFy+
 oiU4zbkH7Ck2Wf7j1gMpDWGluNmhrVwuFQilBiQf/wruUHcKEUDk5R06PNTtnzIAPXwoKnZgdB0
 2E/brPnOYT35SkJweAlFxnKBCW+zPadi8JG14H/2sy/HmFLo
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Whenever a peer is deleted, send a notification to userspace so that it
can react accordingly.

This is most important when a peer is deleted due to ping timeout,
because it all happens in kernelspace and thus userspace has no direct
way to learn about it.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  1 +
 drivers/net/ovpn/peer.c    |  1 +
 3 files changed, 57 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 6a06ed02875156e87637c59339b53f11b7835815..c25ef9fb7f46fad4288504d8f5b15adab84a24ef 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1042,6 +1042,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
+	if (nla_put_u8(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
+		goto err_cancel_msg;
+
+	nla_nest_end(msg, attr);
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(peer->sock->sock->sk),
+				msg, 0, OVPN_NLGRP_PEERS, GFP_KERNEL);
+
+	return 0;
+
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
index 33390b13c8904d40b629662005a9eb92ff617c3b..4ab3abcf23dba11f6b92e3d69e700693adbc671b 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,6 +12,7 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_peer_del_notify(struct ovpn_peer *peer);
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
 
 #endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index d33beb76ed8ed7b258d9250d29bc49be7fcc35fb..0e4ef1b6972f0c9cba19a01e40c6ab72a6d1f81e 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -989,6 +989,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
 

-- 
2.45.2


