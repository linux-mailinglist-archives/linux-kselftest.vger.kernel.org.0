Return-Path: <linux-kselftest+bounces-22991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC619E8E2C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38990161DE1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 08:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A963421B918;
	Mon,  9 Dec 2024 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OPc+P5gq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41392215F72
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734408; cv=none; b=A6sQmr5JZvFWlMTnSWnVH4LrcDHDvJkLnQQ5zxh3fcqN0crn2ANkmYN+jhUDbx/3enDvRv0nXO2xdVfXm9hRYH4mA+CZhBE7Z2vXrIZL79F9Ei2NbB6G7PCKg22l4mTIlz55prFlC4JWOEN3vgciHPt90zEvCvrbDYRU+mQrNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734408; c=relaxed/simple;
	bh=2w03x074C1Ch4YmIvqL1EZXwi46cvkQyIQqVLlfb0iE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bT2ZDUIe9eYn1dTO8zOPKHKUds0hKQUxXSKtG+x01yQVR8ANuyN05IEOuGlikd6Oez8w92Iy46g626I7cxZXyas3k7IIqPi85dGsv8+p3lbfCGizqm12Ae8RKAGSUTgtvzsqYz/NCcktLiV876+NUYhZWa/bRHz6Yp9rPpLEFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OPc+P5gq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385de9f789cso3117259f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 00:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734403; x=1734339203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4bvAlWIlAJT3sFXjrq4CK+OVCRXz5cWRmVw86mNfzs=;
        b=OPc+P5gq6irDuW6pxQVTkkFFaXIcIIfmzJ1s/3J3xNIWnxU/XfN6kz3PTd4YS42RRT
         2Cfg9tBtNgogVG4Q5W4OxWhnPlLgLd08etcRgFfCASr9ApvRr0U0WiPgOPVzm4+Txm3o
         Zow20MwgY9kV6zXEkOruMQyv3JU3IbE977/MZNW7GXnK8Z6+X0t0K7HDuP3D5DzEK3HB
         df99a1/brU5vtgRxEF5j6jh4uhduk4i3DZQxcCWWhwDuXdW66Mdp4s9HtmEgoOvQRozg
         xcIn1N1cC63pzYQ6C+21nCcAv7BtVFwgvaQ8kns+etIBqcIOD4fvD4OBL31FBPRq/n/x
         j4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734403; x=1734339203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4bvAlWIlAJT3sFXjrq4CK+OVCRXz5cWRmVw86mNfzs=;
        b=i/CNQDltTFkLTJWXH5zwJaWjGTcRAkGeSPXf1oDeHUwadv06xdmGOh5gzPUIO5353r
         +RrxQxmObAJk+zdMFyJke/OmsQfgZeP9aKVeRB2RCrjntScPN8aVppDkupPI3sgaWGTf
         dYhT5mmh7KkJpR76W6zmI5jCEpzCjLBH5qlpr00X709c56HW3c94CXwThtiqu6MJJYBJ
         TQ/EYH9BiXZhufpa/nBpFeQxGojVtLd2DV2Ymj6DiL2jwexOA7w0JOAB/RxzD6O1Onco
         oQcAO+D5IeCZ1s7ne+8jNh2eQp+GUhDL33Bzo4U9aOZldQPOxa2gaNqw+iPG4NR3yyUv
         IJ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCBHKkgFe3eDSU407cAxm0ENlhSGjtSSZGWg3sD6qLlgybyNGeRBsh8h0aefABJ15iE/CoeyNdYj64dXsh5QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1Rjhty4hbVYhf4AKT1a0dis1pKm2i6OOCFwHA/xJhZcWzw6G
	rABJJuav2ja/q6mBSdKqkNBXEt4JMgC4aWpNAM/3LOQ7tpybrRQWd0VMe2mYebjHBsh3axIb/yv
	L
X-Gm-Gg: ASbGncvrpsfgVJO5V85+TZA16QF8eryBGACT84Ln1DKekpvkcvRyiE0nR/C8+aRiP41
	40wGurn3LdPr5xh7lqstx5yyw2wMgjNVoVLtg6PciG5cpd6cq7jP249YcqYj43Fy+AHS6izk/M+
	zxmJXS700Y/BJTv+mk0zuzA9/ex+gQwf+2aGCZM1xYutslAQTlhTyj5j7CReBUvc/9ahi/AJIx6
	cROowC48YERhOQ2iraLgufuUGtbQUg1XG1bZnFFHke0FkwhFQKuCFwL1Sj6
X-Google-Smtp-Source: AGHT+IHOm6HGAx1cavZYLbkpD4UuFEb00623Xp1GfEaNpgWOFYLyQZW96BwNSzkcpJU8IyUjfm/Urw==
X-Received: by 2002:a5d:47a5:0:b0:385:e5d8:2bea with SMTP id ffacd0b85a97d-3862b34f6e8mr9004307f8f.20.1733734402733;
        Mon, 09 Dec 2024 00:53:22 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:22 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:29 +0100
Subject: [PATCH net-next v14 20/22] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-20-ea243cf16417@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=2w03x074C1Ch4YmIvqL1EZXwi46cvkQyIQqVLlfb0iE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrAU6qIeZlQcbVLy3erqqdL/pTt9cOrOUfotk
 8IUNmCyGROJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awFAAKCRALcOU6oDjV
 hwnRB/44xV3lo+1ixlon03vhr7ZFG5ctnJIJ4F5HGzw9o5gVE3vGbr8gHCHjOap6R89jc05CvrG
 McEgQQz5lcER8qyvYIQvC1i4c/lc3VoTPiBty2k20F0PIM0fcyTi2+WiMptlJw1l/6pesZktMlD
 m4f2+2uU7oGA0c6XG7Ba9TUUmanQNnTqXsF+lmFdxSsGVxVY/YnJ5T0miGheTn21rKQGpPp7f6x
 NOiTJrH6t+PyhVswlaes0CeAJg7+rTYZDgCz04adh7zQT+dnisU9b6bGCM3TxhPMhOze0/7LCEI
 OIu5QldZPG471uGlsbfEQel+/oRwWsuDC+boSyA8ylErnZPT
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
index 355cd3aa4849b518bc794152e6d9d0bce7ed0f6b..20e9d6b5e92c2647b00f8d50f508b5b1bd8d83d2 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1044,6 +1044,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
index 86caac747c6173672e4d3294639f60cd4138ac43..513b738364b9281861ea6b83a6330e78cbea5f4f 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -995,6 +995,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
 

-- 
2.45.2


