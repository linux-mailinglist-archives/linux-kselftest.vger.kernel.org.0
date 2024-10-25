Return-Path: <linux-kselftest+bounces-20649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8FD9AFE03
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66EA1F23BE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0720696C;
	Fri, 25 Oct 2024 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SXF1oW7H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA875206064
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847730; cv=none; b=cEkTtJE84gnDPRCy83vh/kmi3QudbW0ZQbYDnpZkY7wTWUZkMOvrRVORn44EqWD88K0ZaSWrLXa7w80fZAtA/oJlg9S3Gb8qISQSsoP3ZFg+A6RRj44sbbwt7sihSheSDELtb1mJB6zi5j5me1U5QDTfAS6aGf+vdwLG/JrD5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847730; c=relaxed/simple;
	bh=AzIDOSUkaDPNX63bsZvcEQktPafnVpTeTaD2rfmd2so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZXBObf7AeyrWvzv38C7u1vdrVxjt3w3pWOrxysvcm+6SyzXLo2hsmL9jxRZjebaYxwXuLuSmbrl0xMHoMskxe+3cAt9wBuUMUgE3gql7EZaQQvZI0oimgkrrUeVcyPVCD4qwFDdrw5+DShowln3VhAIKh4OaLZJJEi+bvzNqdag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SXF1oW7H; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so18795545e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729847725; x=1730452525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HE7a3/0ck94n809ggeYYpm0YGkDJyT0BmHOqLaQj8no=;
        b=SXF1oW7H2OkH9DbAtki7vxptp9gLQngEEeg4Vub/2bRtyGs0V4mSXyzqtTkG3Obxmb
         U2zhRj7o787DgDACzEPX20KXpCQxZ3NkrbmhvulGweq8hkbbR2itg5v7Lw+AO2zoEnMA
         W+Fy/dx7g3c9030WK/eRWamUUONvHBCUsXoLTS+ZCyR8BvVU1fugCRapFpL/1pYAgd6M
         X0WLU9f+u+83NAVGN6Ocz1bB5CgKdIaLVYauivyyEq2gpXiuD999y84EBck+j7tWLAfR
         wbMSGym56021wWEYEPsHobbhc9GLdPxA+jRkMXlO6Ht+BVcIhZF1L62CAhrB+qWkLb2s
         kwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847725; x=1730452525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE7a3/0ck94n809ggeYYpm0YGkDJyT0BmHOqLaQj8no=;
        b=rqLgbYAteLomagueQ4ZCYmahGJGrsec0rGHZS0oTo2FaPjK8neW7fUKBt5+ZlzUuSW
         R9wo9I95EUgKjjoAqCkexVaFqTQkANCfrVX3sjNeQxwdppLv20TRHCW/PpgdaKhCwbgx
         R3PuVkFIaVu8/sluUzyhg7p9kt71GaMOtj4+igm+SJNcgXn3lTZIByc64TQ7dttPEuGD
         R90CLsMMBxTllj3D68c2hsNif6uvyHh/FUUO1ubxp/DcOOG4hkZ8/zAR9ZDGbkp/Uv9k
         2j36lbEtpvyviB+Lgsh7YLxAziPLvRKZi6sSBf19qlrWsYyDPQeN1gVtknX3CxxvmQrq
         Coug==
X-Forwarded-Encrypted: i=1; AJvYcCV2gpkmNGWbkNhPEW5hIXfu+hJFC4oqPZDN939B9VvgjOOx0aNbTBqVACEjqErESHWkqW9EQMq4D0A8glTnzXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3UDdGYYY0VciJpUj+tmSOWGTmX5qP4RwFw0bdR29VuRG8dEEk
	LcKXBHQ8WsRzzXbIv+2ImvQcGcIUrbUHQfWDj1mrj5/a5TeJh6wUvntT8Xl/FGQ=
X-Google-Smtp-Source: AGHT+IGS6M4QtU/1eozXYwUGRg6O3N98SCRuKllxDYeV4sbQJYRPJpqnjdjdAj9p9Wu3SwXZzeKe4Q==
X-Received: by 2002:a05:600c:1d11:b0:431:46fe:4cc1 with SMTP id 5b1f17b1804b1-4318c6f14ecmr44875065e9.10.1729847724920;
        Fri, 25 Oct 2024 02:15:24 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:676b:7d84:55a4:bea5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm41981485e9.13.2024.10.25.02.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:15:23 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 25 Oct 2024 11:14:20 +0200
Subject: [PATCH net-next v10 21/23] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-ovpn-v10-21-b87530777be7@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3254; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=AzIDOSUkaDPNX63bsZvcEQktPafnVpTeTaD2rfmd2so=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnG2GbQfIzywdx73kts68lqL5vFZscLj7whP+7R
 alMtMUDxjCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZxthmwAKCRALcOU6oDjV
 h5DEB/4qyhwjliiZFNve3TSusPqHaS17r7Fi7JfsHQzdy9zIhzKsV4DOu+tNEr5Q21tRNahvIaj
 UEnE8m0hxHLAykTNqlJ9Xrrio6wjH3q0eMwM8mLeTbuMDItXGsZ/hexVrIfeZm25RF6lD9bmn4d
 EWBVKW4Hn/4sSh1HJSilW593mx0WYXGjUAhwhMSwUDpBUIRm+EVx6GXuT5hrZYlyOAe0ZFmbbID
 ta4V0kzQ/bIUGGD6jJexxp3oAXQY0+koQjuT++MrWBbK9TTXI2KilXHMc7idNqgf+BdBxLAgOKs
 KlcOFZZuZft0NWCQJbo7c2xtrAQtk0ERdgkcYRZC40LFqF30
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


