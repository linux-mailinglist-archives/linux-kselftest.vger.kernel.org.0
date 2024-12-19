Return-Path: <linux-kselftest+bounces-23564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE589F722C
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8202B168449
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C7D1BFE0D;
	Thu, 19 Dec 2024 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HPE5Bqcx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29321BD9E3
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572567; cv=none; b=bbaZh7C/unI5Ci44AU/PQsjbPR71s1MXl+oW8KGv0yH7+ttCf5FrrAgLGqWaC/qTuICHgPIrikaz4Z+V0HlCDFZfxPDnzzJbMo8X4LRBzX59gmqkj0VE09N4xYLmmZMBiiQuUz6yj2lcq2/wnITbGoQX5KUc674kkDmlOFwaAfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572567; c=relaxed/simple;
	bh=ibciGk34mgb14Q/O0IUMwiijWmteUMWnDN1MJ3oF+6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZG4xTAqKnwimXgxPKbwrt+wkqjj5i8As1K9DYP/uzE6ARUxAzVuHjdzgvjqG2DHOIInL8JjRJ6ifA5Xg6qV+DZ2fmUIarFvJNerFCiZ5Y+L5vmt125rNht8gR8rMkIZMd/64NdYmWA4QPad5aNoTmkxRvUIUjvXPu1mWihVbisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HPE5Bqcx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso1820065e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572564; x=1735177364; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIFUafy1KpMwpkTMRou+S9rJLFNIuyqzOJ5DJ0mO+AE=;
        b=HPE5BqcxL2y63xAUufm8ts5/NH0CYvCA/8TXLUhdFpTzdmcaTfStV7jCbg12udUK5U
         LE4Xx/oaaCj4F3BlLdhhU78W5Tv+bbJ91Hwxk+/cLgxilNv/jkBLeIKv15Q+t5nLR4O1
         CUGEA4j6vcym6uDNKWlmYmnk+sBdiQm+OwYINUkr5cSU1lWnNr63siPz+VqPZY+KJtp2
         VveMtJVk3JqeRqyp2rOx15aupqKHuc8aSj4ohmYfjCJDEHpE6OjOSwerfyTt5G2FuPMc
         kcKE6pAmF+kuUEO0+uffsYIUNXHKsgIdy4plYUsrlGpPZk/39b1WJG5bl7eaRFsQOR7h
         oviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572564; x=1735177364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIFUafy1KpMwpkTMRou+S9rJLFNIuyqzOJ5DJ0mO+AE=;
        b=I9BAEuEy3Jba0I3/a6LQSzaC8EjrqIRBg9+4fKf1XMT7cNNdf6uQ7PWNkPxB/hQBst
         IW0hTipLNmbHI3poP1lhqhibKX5+16TPNbK2mkUrz3acLjTDS3AqyOse8sJahP1BUQzv
         IzCPqeeczr8Q+eP/pqUE+p8ixNxIEdTv1F8pXYymCM77hQH2cWeV4yR7ILOJH5dOSc4P
         HOwOwd95vHcGxLuiEKtlG0xGQd9rVTD6fzcJuGC8avPS879WvUyyz7K52b3NuYTEn6Fh
         GHYoaBNNgPdKz5tCCPZycE0qHlGso45Ep+M0CdmDBtukEBxghmZe+70vlqAAW3gOvq6v
         xDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeBqc6cJDHfL1jDbNiP5jNbK5UzUGeAOebQ1jg/vGtukyVXcfMhdHwQiIcg6vWpSCw9YyctCzQ4EhYtxygphc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpe7lhx4ksPZWKSWakKy/d4ir0LvsiAHyNM8NVylMvMeUgIK6C
	pk2WBnGCssPdQXzAdye98i1mhtlKjT2mRjSWblPJxgT4x6nlzevzX3fHpdqCkJM=
X-Gm-Gg: ASbGncuch6h2PQe4aV23lwa579AAEI8A5pRvgafjZ3rE09Gul8reTNw1fubKv8oj8bj
	o6OIcmbyYugWorRv7z57e5tdO1KujES+DCwwkBODgh5U40sT9y7ruSZ+XHuqIz5NUDptOp8iGzi
	yD077jNzLJZ8n+89g//FkyeA5BY4+xO0nPO0tdVbhYd7A4VQMKw/RQhOaNIAHnInz30fO5Lb3zF
	0Q6nC1yeCcZ3BuzZJ29i6N5AwTYzbvt+hbkZr3nVBo3w+RcBLXqa1UE/m4XWze4DyfR
X-Google-Smtp-Source: AGHT+IFirbNADb4kGGweSN9O3GdWt5YhcxS/6Lpy4xvPDUx61u5cJBup6viUrOyERXmkQWV38cuyCw==
X-Received: by 2002:a05:600c:4511:b0:434:9d62:aa23 with SMTP id 5b1f17b1804b1-43655426b06mr37963425e9.20.1734572564242;
        Wed, 18 Dec 2024 17:42:44 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:43 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:18 +0100
Subject: [PATCH net-next v16 24/26] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-24-3e3001153683@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3265; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=ibciGk34mgb14Q/O0IUMwiijWmteUMWnDN1MJ3oF+6E=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oXd0tc2Syt6Pe4X5WBUViknadUbKTXhVQ/L
 WdbsZo15F2JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FwAKCRALcOU6oDjV
 h/riB/9nfWpj5ytrPpRKf9woeZNfXEjHimNe2BhTkn9MBoIsxh4OT/Cgu+Gt1xl1jTY5UcxaBnF
 NSx6j0wekQly4Tu+KqFC6U1POWJTFpKQ9L0HKm6zpkOn1rekZyaWSqMLiM5ol6GEMZAjtPt5GT1
 6WmQTKA6QXs5wspnZXCC789W0ROL78uguqv4y8LdqCffX9/wcW82ijrcUKZHYoBmFhWiAfU8hTS
 E0tygW2L6cNojZxJa/mfdHO8sBdHtejUur6s4OX1ZN7+eUGWIJjf9Trm4ObOo3mPC4qgIiLrAwZ
 zlJwC1CVVcFJKZZSav4yz/kZ3YxcgWU3dtmdUaSX9qUTJ2dp
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
index 266a54485ea00bc7aa333694c3886a2c3a1a8a19..cab1471455f0314f61d2c8320cce14182afce3ac 100644
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
index f391a7fec98e342786a9ab2ef5ac445adbc1417d..36282b85937261a03aef347a44e17ec614f87673 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -660,6 +660,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 	if (peer->sock)
 		ovpn_socket_release(peer->sock);
 

-- 
2.45.2


