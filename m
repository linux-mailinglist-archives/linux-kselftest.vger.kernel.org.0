Return-Path: <linux-kselftest+bounces-24268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6D5A09E02
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67AA07A4839
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A823D2288D0;
	Fri, 10 Jan 2025 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ui4eLviN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B935F22758C
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736548004; cv=none; b=QAphYoh4qwztHUTtYomWFqTDVKjPBFBkiuQj0/XyedH8OG0a9inkE8ZPXAHIPpB4bJc+KBHDxgrzBM6NJp6j+6Uomy/tHM9tVFPhJR4UMocu7POH9GMuZ6pYUVTmftT41z/eE/06tXb+Cf1K5g0g++KHdahm7YC8iFIrB25vJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736548004; c=relaxed/simple;
	bh=RTxhy6pn0gZiFOvpOuRGXZQEY04Ig49yF2u3K4JO+Ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/6fvXMW/7PVZ/iiwQgDEBCeyVi/l9ELxiS+vqME2zMm5qzXVkZSDeC9Byw/dG4KQYpEF8DtkLfpWbbEP3mb+KWH5swwaQDiR3BSqrYY8qoW5kvmMufVr24sCIaluB1fAmUpd2TENwAu5EfdLXoXlD/r/UUYbe9AbhEoQYnNmy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ui4eLviN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38a34e8410bso1384062f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 14:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736548000; x=1737152800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8g2T9H3zYj+igPES3pI0uiRTkM/qH8v2b9qfmsQE7eI=;
        b=Ui4eLviN2jyvK8VSM+f2OpbkueSKN/6wrW2amrsGb4M5NvaNM5UhjHuTlen9L8cj/U
         PkgR42pNKNZ0YYZe6E7ruENIejFQ1t2arSrzSq0MydFGFUBb7oTfwjVF9CughcK1pKqR
         GvVSSQtPfebDhmrs0fSg25+X9Jp9Zr6pEtNE0Wbe12SqB8RWfteh4v37+ps62XXp+IUZ
         OpbT6N+RhhzGNQqxnUCOKcuI39+nWV1J3RMKCs1tGfh8S84YX0IlaWwMFrFce+AaZbNw
         O10TWicR7zGIGmr7VQV7LqhdwUo0Hmoyn1cGLWFNEcoO6YKPChgnHamqaFqUYzAeH7RO
         Y60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736548000; x=1737152800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g2T9H3zYj+igPES3pI0uiRTkM/qH8v2b9qfmsQE7eI=;
        b=OfUntl3AgDKFE/TSFl4iKzrteBzcNBi66eR3ji6zRW5w4jglJccM1qu4wRQ58fngxE
         SKnQQA6Gnhp7d2cGP+1Iyb7QMfS5GF39E7rd+A9rrXQOlEHu77NJOwXI0surSCnQB8Np
         Cyi7VoiqdU+RYWAmPK1UhbCNxa1Pk+pK8o/X/OJHaBaBFuFtYq7MO8xQzYcF43Se4lzj
         chks8yacT5q9D/raade7C/bWff565c10G7p4ybxLIaNpNyU9CIaBGnJbFesgJWFaSotr
         JKuCE/sQd5sua9S7SJgejhjtUwR1E6RFSvq22uusmue5mxNlTIQ/vc06mVshr3QSRehc
         zj6g==
X-Forwarded-Encrypted: i=1; AJvYcCXLJgNVPaYJH1J9Rd80KgbfIy3ug2Va3Uzk1hg231WpPIyA/8snMhUBSOIQy8e/bPV/ORmlclopYjFzNA49F0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb5tEIz5aNpqfl2cr9/pOFZbK8XN0riYl8h9sCXZUS153aEHxR
	wcYzqkOY1y+KrSf6AIMPDL7ygVvmcAh0zeCnf14gy5jt5Ay8wSmfer9exF+weJI=
X-Gm-Gg: ASbGncuqIEBNEprZ8tInu9sio9NlNQy2d/UDkWFEbNlsZkeNwpoZ05gcAUtw2gpccp3
	GAmD9efVm4Q+SNP9BSm6xlCHKPa1y3KmWTw2VtshKBCLvG2x5m0/K+pKxbDDRptH8W/H3kMFDz+
	t5zKP+8+Hzux/LEj5yZtmE6HBH0YQK+EU0L0685xayqDtIy5r0bLYpPe4c3nARuyy4TGZjt2f+O
	MvCouhgHxHtweRaAw1ocIOnCYrJDlq8HfY8zXh5J1xnX8qVrOmJYELNiO+cL+YccKW9
X-Google-Smtp-Source: AGHT+IGoxUfKSONsje7ScRNr9CPvoVq3A4SLuj2eAAj9dmyZwzqU1PbPqLS+6yOBp4gwa6gEh7aaXw==
X-Received: by 2002:a5d:5f52:0:b0:385:fcfb:8d4f with SMTP id ffacd0b85a97d-38a872deb1amr13165947f8f.21.1736547999924;
        Fri, 10 Jan 2025 14:26:39 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:39 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:39 +0100
Subject: [PATCH net-next v17 23/25] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-23-47b2377e5613@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3304; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=RTxhy6pn0gZiFOvpOuRGXZQEY04Ig49yF2u3K4JO+Ro=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6y7DtgvY0GJtHiByPb2iY99Ti0+EsUI676V
 xIk2v1GHKOJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GesgAKCRALcOU6oDjV
 h/2QCAC07gTXELlxA9C1LGlOxrjqYq0vX8jX32yCHnN0E/594giJ+xyvyk2kddWTUmmoptTJ8mt
 U9Yw1LWjHIG1K0Zpyh2HjdzJgdPRBApt9KTcOhE+0xMZcVGygzvkjWIpX6ulXEgSET5ON/+R8c9
 2jHtEE08xp2jAIUr3R+tXCiBPqxh7l9c3KkmrMMypAijPQfb7KhpsNm7fzTqj0tG8xSbx/+yuLi
 aXUkFtAJfcEXiEYLrCHClRmCxkIYiUJkA8jNxhTDViqZ70suWfBhX8W5V23GISXVnuoN1JmVyC8
 e0Luunwih+jV/tFhUC9inaf/5elBls0r49mbjl6lvmkWLHCD
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
index 6f637ce68b4524c248d4015eec2136d5e4495d8d..11bb17d94fd54c797edf7650cb709f5fecde4e98 100644
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


