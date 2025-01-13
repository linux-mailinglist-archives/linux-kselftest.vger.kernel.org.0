Return-Path: <linux-kselftest+bounces-24353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99452A0B329
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 10:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285393A2C66
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B1E2045B8;
	Mon, 13 Jan 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OoHb3jfx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3171422C33F
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760699; cv=none; b=YbaDJPbrC0L3IP+4enFlrol616mEVEhkGdEGx82HsZ7cq4rTDzdBDOSICjg06BXmMfwsf0y6DDayHgqq2OzqQ43ezc0cvae7Yrzokt41sgnNPHaxJg3kpgOJ/Le1OM2UocbyZ+ZQvKfGAuoh2BPiqXGJKEhTnOPKRYJCkt95Vgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760699; c=relaxed/simple;
	bh=u+DaT4ZH2Bj560YpaChFDw53S8Y6M11VXIEMEdSoZVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RgBEWPGk/TIoexTaY1N4ZXCgQ4ruBOC5sdDmQqIlTeUxeufKGbKTN9EbOuL5Fl+8o97+UJev+s3ma2rcmk/qzVckUYf1T4EBX+Vty7bgQamTqWOZIxcr0AeSO93GuEpqID4/rZ7do27HWbl9PISRod169nEl4FDU/Imy0PTR9fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OoHb3jfx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso30704785e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 01:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760694; x=1737365494; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JU5a+IDMOM0B1/o/nxIo/5rxP4IFLIFLg5D7RvWguEo=;
        b=OoHb3jfxEteVtakrpEvtoVqrTwPZDDWjgL7+gKX2xWDjq6cCYrFZ/rzzRMHBCtpSKk
         UiKYj6kCprziFkQCIAp78alkKNWj0mv5UYdn7og1FHI3f4FWwRsccf1rRoPOtYBTMJEV
         akZA1KXxK7bqiODCeZINAQR1I1UVbwWY/3qg4Yh6prB90FV/HS/B1VBbrKiTjE+x9BtH
         Nrla/g5YVVeGiVjL7bdnn0WFClC4HFN7K7G8CWJtVjdCsvff+XKoSa7+8gsTGtot5Vvh
         Rz30s2ICtVdkf1sTzmFZB+jQvQK/iOiY0HNr58oN3j+8+6xFg6epUXT30axO1xDpIunZ
         L8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760694; x=1737365494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU5a+IDMOM0B1/o/nxIo/5rxP4IFLIFLg5D7RvWguEo=;
        b=AOEkbqfZzgf4xsw1C8S43q8Xg7RjyOUJYFYVCN9IkTPI+xqRY04u6ymMZ5I++FwFsR
         kSnE17pOO/pp3KIv2y8RiA7RpqPSY2Qz8J3jA8t6hRv72vxJ/3R4jJh0YhpoQZ41Nw2r
         w7daDn5rOytxGtUs0yEl76FcM0tZaBwML8Z0udvUgxG1UQTTCQ12/QamF4RRufneMHmJ
         RLlcZc1Zcn3ew7pP3nYeZlVwEFrZLytrhrP9kXHH3KXvH7DxwSFgVJ2gZ4DQaeBd5luc
         G4PD09f2Ua7pW6EFGlWFv8Y8nEjv+aL883ex4tJmg57+ZlBrBHSJbhPh+HCoIySB2tU7
         aqmA==
X-Forwarded-Encrypted: i=1; AJvYcCUBB+i/q3nk8gu3HNnSvArW6YSNU4t4tB/DNZ0hNR5LaGF0/B7QWwNXgno/JnqJj0RxL70VUCftp9NStaEwr9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHH0xuP79sSGXz/42N1McZiZC+eLxDcuyFhJjKTBKu3cqjZe1w
	4Q/eT3DEA9TpKeqiGU6Bj8MA2XbAXBG9jhe3Bxk/KIMv9uQ6UCc4Syfufdhuxh8=
X-Gm-Gg: ASbGncv3EBv23htvQPifcfq+n7/1Wrrd6Y1Oys/PHswON/cBrUlRrAzx1kf57qtvjox
	+GROklU0klvyFUq5Num+30yf2x3xQKTNoReoIGpVmw3eYZX4qu3F3nGn1/iJuvC8u/BTHTKGy9W
	J/ZM+k4YkT8ZiyJFiFoTAVuvNoCftwTyPvNiHeAXM/siSQzpDwtONi+N/ILer+JiOo5mJ1MPCPe
	BxNoakuaw5wYdqMhlA151+eAXV7lSHF7OZHusRivQdvQLSQNYRpydY3fvJkkZZ8OFNc
X-Google-Smtp-Source: AGHT+IG0LtCt46Hh3KFZKWDcbB8Q1BpAKrtbvdET7eMRcGQT8nMzoQC3vVYcsL9tDkkZNBJxA4oNxA==
X-Received: by 2002:a05:600c:58cf:b0:434:e892:1033 with SMTP id 5b1f17b1804b1-436e880fc6amr132805995e9.2.1736760694288;
        Mon, 13 Jan 2025 01:31:34 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:33 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 13 Jan 2025 10:31:42 +0100
Subject: [PATCH net-next v18 23/25] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-ovpn-v18-23-1f00db9c2bd6@openvpn.net>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
In-Reply-To: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3304; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=u+DaT4ZH2Bj560YpaChFDw53S8Y6M11VXIEMEdSoZVI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2I/O9y2CqYe2gKKpkh+59SAgOm+yXRaINKH
 95X6J7x5geJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdiAAKCRALcOU6oDjV
 h8qLB/95Gi32YO2wKD/IvGPDn9u0CZvcXd7XwlJ3F7UE7Zyz7pjqkUR8n5h5ono7torQLEXQ7BN
 Ia8Cu5/ui4xxglrPengfFpW6cYmP9qR+Aib/vkSx26YoUM/eHOVyi7LTmvtjEuzIxex7tni6X1W
 AnP2mRE8OJVU0KDk0joCkllk2SIhK55N70ZyEvU39QjvyuPoUNvLfRDyMKr6HkceyB4wAFgqp0h
 D31GJHNbtpjPVRqZakMje2/teyZCpUkRG9IFGI6isCWIfRV9enhzitAWF29UIwhKj+eLCdMjPv1
 WeTHRtS/ju1Nl73hb+Ek1Q0xZkQhv25cATavGUWh+c8jeQmZ
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
index 6f82fa0b42077ae87b72b3ffe2ed99a1e72dbb3c..6240df740d1af5fc9853224b63dc011d19f644da 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1047,6 +1047,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
index f680b778c61cd40ce53cf1e834886d0346520a36..b032390047fec2fd9c70957b911c30ae8a8f12ec 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -675,6 +675,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 
 	INIT_WORK(&peer->remove_work, ovpn_peer_remove_work);
 	schedule_work(&peer->remove_work);

-- 
2.45.2


