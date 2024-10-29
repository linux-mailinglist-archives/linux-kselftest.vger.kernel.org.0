Return-Path: <linux-kselftest+bounces-20946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA7F9B4781
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 11:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC151C2111E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63645209F40;
	Tue, 29 Oct 2024 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TXgIiXdN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DC209F38
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198913; cv=none; b=fWXPeQK7/UE5Or/8DuysNcSF86itwCw+HYNUhnt+jKAew0TDdelPJCFE4NkZPP/Pcjhl0BM1DHLZMiHNmtkpwDQRFlodquhIBtGACuvIKsqrg956amG+LBRsgT3skpNYFMdJsEgQlNcFu7JkEC1amYqPVV2Trbt82hRa+cg73pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198913; c=relaxed/simple;
	bh=AzIDOSUkaDPNX63bsZvcEQktPafnVpTeTaD2rfmd2so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UmTsvtcpGbxdrHUwmCuMVhBLwDNo/KFEEMhPXDrM5z9nlcySaI55AWQASPYkz5xMlunwdM2bCjfqASLsbJdqf9GLHxZ6ybtD/f52WtJmIVW8mBudl9NWWKhOIjf4BcnelRYUmSJV/QfCdZ3lcHgOLkQN4vXuKJ5gqLH5qHGYWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TXgIiXdN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so52432635e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730198905; x=1730803705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HE7a3/0ck94n809ggeYYpm0YGkDJyT0BmHOqLaQj8no=;
        b=TXgIiXdNOp1mBn3I3A08p4JpK9rosWBmJBjk0sASt1upDajDFCTMvK/8blidu19KVZ
         zn73vHk5Mg4fqV9i5Pjj/lMUpk2omr3ZDxg4hl3fp+vGiAhcXgubskBBN94Rhm7rZ0HF
         +zttIOoDjuXCPS90q+g2fSlhxoTkwH0MeuY6D3C/2cPI0DK1+gIkRk+mcyqL/4jZjOkH
         8d851OWFiKMyl4eWi3kwwGkoZc8r6K0Ek2GTAaJe/j2LtMYxjQQy6hcnQks5Xnc7v/wa
         tV0KwCH0ZPPLxWLnSe76tkBpVIIJ+9jDM/5BKOoy6Si1Y8do5TtUV0QBP+oWrlMzhfGo
         lTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198905; x=1730803705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE7a3/0ck94n809ggeYYpm0YGkDJyT0BmHOqLaQj8no=;
        b=AHuqO1AwXiAMwg1f98GupD3pVaFjn93r+ZK26j7wM8vZlETXiZ+62z75Po9DAm1odV
         5IoL2o4OkO32K0Yu3ANGoicItsSATmR6X8k+GnZ3x/6RCawKStFX1Oqb9+Lm94MKJMbi
         eqKZkcOiO6cBZzOhlyrdIwWhfLX9jkBL+y1DxyAPJUMD3epvDNGCDSAGGKawpyO0kz4y
         y2AOXIYjY5DNVcUA5W1t5k+P/cc8Sn4jFUiMNo3K4cJJF+zQk61irsedTEyBDgQRP2bV
         7fJcMCgCZasiiYXSkvloWAOI+Mb2BxqEjTVxM1TVspyyowJsGb0BL9qga/Fyt3UlekTD
         supg==
X-Forwarded-Encrypted: i=1; AJvYcCX5N9MJsREFBU09DsijQt//7f2KuEf+9J1VXfQp7opVV/tIrDhkxoONaeVQF/KWUxcUJMQtyBfOkobilwT90/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3V1oeYyvEevnTm2UlO5ipobi/neUIplvcRq9zbm6HSa6K+g8L
	unwmJizq+f41sXnDK2JgLKa0It7Uvu8hiaonEZc8eQ6cXL857NChE13uJrmJByk=
X-Google-Smtp-Source: AGHT+IHH7RujvMYpnMvj19eJ/a7Q4ZIlCQPo9vzyeercFGF6f5ckbar13WClzPWz8sjm1V71usApHg==
X-Received: by 2002:a05:600c:4f51:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-4319ad2d6aamr103053895e9.29.1730198905554;
        Tue, 29 Oct 2024 03:48:25 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3dcf:a6cb:47af:d9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm141124785e9.0.2024.10.29.03.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:48:25 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 29 Oct 2024 11:47:34 +0100
Subject: [PATCH net-next v11 21/23] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-b4-ovpn-v11-21-de4698c73a25@openvpn.net>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3254; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=AzIDOSUkaDPNX63bsZvcEQktPafnVpTeTaD2rfmd2so=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnIL1s1cOE/xYZ02iUkO4hDSrbP5T5z3vH/78dC
 NV6L+OgoiaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZyC9bAAKCRALcOU6oDjV
 h8iUB/9ZnqHJvfWC00xhSZN3M5zWNrsc8nptTcikS4rhb94TCQR4bCesvyLTlFDDBEQzD9Li4nj
 RaOYWgDTTdyjVsig/gVwG1XRJXgfraghh839SAlLHFPXzxMx9ADcMHOmrJucwxnm0t4/x2koAle
 2j4Rtlzhv1dD+VIyabU6/sB/qH+qT1mPgbV6qlrODoCOiFB03/3qo/LtiYPu8VCKktq4/l0ti+L
 C6TBIk3/2BDga/2qxfQIXQUZQhUvxQtLkRiAZIrA1QDF/AFQOXmYy5HtScA/Pj5Kvm7XnQYZSRc
 ffTxLgLlZnWajkJ6jYkjjgGdkRNA4CJzyo1NtD0hSLOe4rY4
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
index 2b2ba1a810a0e87fb9ffb43b988fa52725a9589b..4d7d835cb47fd1f03d7cdafa2eda9f03065b8024 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -999,6 +999,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
+	msg = nlmsg_new(100, GFP_ATOMIC);
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
+	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev), msg,
+				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
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
index 8cfe1997ec116ae4fe74cd7105d228569e2a66a9..91c608f1ffa1d9dd1535ba308b6adc933dbbf1f1 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -242,6 +242,7 @@ void ovpn_peer_release_kref(struct kref *kref)
 {
 	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
 
+	ovpn_nl_peer_del_notify(peer);
 	ovpn_peer_release(peer);
 }
 

-- 
2.45.2


