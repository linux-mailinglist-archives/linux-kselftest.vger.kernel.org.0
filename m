Return-Path: <linux-kselftest+bounces-28730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6B7A5C040
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8063A7D36
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 12:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2BA25DCFE;
	Tue, 11 Mar 2025 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SjHWyBZd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898525BAD4
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694618; cv=none; b=CjnWJoQ+LXa/1eImVomwy9F0mSZuRLEgT+1RVduChBO8Jgt4FQUjW1ZukeYTazWGFVmN+pqqyGTAV5jo9t9OZUgBfNgYT10bKdfKEDO4aPkV1N9PPUeDFKi3XkUai71VMISZex41SaTqF11LogsPjIBdpSrX+xum8mGvmmYb2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694618; c=relaxed/simple;
	bh=f1JuEfIfiwi+3nF9MJyCWwqAAofxh7Ooy18BIJhUuY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNaKrXlSHMmt8V22nA6/7ghN/p/pusifWBMZp1rTglCdsNtpvUQF+9aq0T+Igsyta+BORrtidw+Fz6v7rRb/4ql2X7b2SMsjfb4C9f9eM7YNuLaq9EDpaQ49xKxact7RIbeOpBqppGA2G9yVv9BDqHA4Rmq8IxhjRzHHl3c2SH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SjHWyBZd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so12059285e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694613; x=1742299413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaIP2GHHwj39q2umi2SJXSaFXfHsgcaJ+PlSi2XXsto=;
        b=SjHWyBZdbQzcj19ag8jDd0SWX9ryhzDmMFUJyyVHzOxCQgPkrMjGRYwHNLaOiApR9h
         BG6HRTXUn/Sxbd8Dug3iTSBikhY0gz7z0UPdj6iT2tan6VuMn3j59hiqC7J3VJt0dr7m
         Y+QNjdRwvQLteYR0ULSblbwlKCNTqJtzL1MJIU6soJf9iE6IVbAlDk0jXI3Ia2NiMOqL
         F5RFzBZWJ+X0sJuD+oC3nAX05ZI+Bko1qXTeYYHhlgdtIPucWEh7AFmJR+t0zoPTDsCn
         zi+semFc19nDuvNwCpGwgoVkQC+SfFikXio56Kxnz2uULN+IFH3yxqEZkYLkc6gT9AWJ
         +liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694613; x=1742299413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaIP2GHHwj39q2umi2SJXSaFXfHsgcaJ+PlSi2XXsto=;
        b=ayYcQTdVehNpsDjdUpkcakXKlGFu5RkYybeZ+YNLXKliU9cFlhR+9zzsgq8JJmk4M0
         SYk3J3Nsz97vGAg2uDJnNT4Q13huBB1GalXywfvq7e2LvuAhzrzyHe3J6cyt3NtwEPLi
         o+zuNXVHcYxYfHakXHrJcSLOqFUPcyghKC1nGCt5vK0L0FoANt31wJgwv6H22IssyCmR
         qdh8gF7jWCJK2RZA37PO46vPmXeJasJuKPgheIJqnFnc9V5Pm6ZrewyDAUk4yMPcCNAM
         7KJX1NVeV25kdwFBPCDEE+9yAe5RzsVFg7iFKQ9UwxQWQ5QWBR3qTSNitdYsanEB68xa
         zQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCWWfgLTtAbInqzqh1cgFiN11dG0ccXhmqwPHXA1fipYp74jWBz+JR4xOh0/xVeom+v9S0MfYHIx0xMJ0b1XI94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+HhJuXJ+J8GtVUmifZhd7AfrTjA90EtdVrTruSnDFYK5BFLjB
	Cr1ODFqXLzCmbJI77bdsOHjG2iSMftX23XwzuleexHcACH7pOn9NjW710tqieEw=
X-Gm-Gg: ASbGncsQ/8kF/ggRbwDLh+MfhFGFbQ8tvdRDknJCcDRJYdhrd4tV4V6/Wy1hBxoyvsW
	UO55eJIZ8eVurwjEDv2NW4+S7yScftuzMfXOB7gQ6RuA0dCA+kLVDDWTUDdnZSOlgl6elk2Ct4W
	uKHhf2ew+H/192IA6UaSAHo8lh9lvcxE5v1sZhKSQW3jIfbzEXkilFusFL9Gs7ZQfyKUGpeYC/0
	A8dmjVT2TRXi3OISg+FhaetdbhPs3u6TAir/vAmvNEp1NXH7sLUime9/wL3o9m53/4CxmR5SZkA
	8l6PWzwCtj7bGq/F7dLkhHSjwIe4mTUILiTwP3Zho2LGXYw+eNdH
X-Google-Smtp-Source: AGHT+IFNwRp0c0N16uhBvxn8mVZIeiZAZhNBgDiVafbwnU/w1dlp513+jyPzjiGAFBphZVK9fmT0Xg==
X-Received: by 2002:a05:600c:5248:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-43d01d11392mr41523865e9.3.1741694613295;
        Tue, 11 Mar 2025 05:03:33 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:32 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:22 +0100
Subject: [PATCH net-next v22 21/23] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-21-2b7b02155412@openvpn.net>
References: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
In-Reply-To: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
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
 h=from:subject:message-id; bh=f1JuEfIfiwi+3nF9MJyCWwqAAofxh7Ooy18BIJhUuY4=;
 b=owGbwMvMwMHIXfDUaoHF1XbG02pJDOkX1Art1igwNU91Pp4ttKDHWWTp9rjoT+2hfk3eFblal
 uyf/zd3MhqzMDByMMiKKbLMXH0n58cVoSf34g/8gRnEygQyhYGLUwAm8iOB/X/d6k/JLG/2JMx3
 CMrYuyeEvfnDBe2PXGdDOtQXd3oXzN96t4zr7OsVC7zsm/Yc4XDlZ88+7jjzSuOliIyMhRHXJI7
 WeD+pj3/hYbbAdtGpjvAQv9vtIZIZgsduHD9p1TRz+hHtHWwqZTtq784SehX2X3mXCPfM++HSFz
 fsKg22kdms8JHh4rwdEteLhMJT1n9vayxNZ/mzuMaoO+25qpfBmc5cnaj82wu9km65TEhxjI16e
 IYrkm1J9y73lJYqlfav+bE5PHe1WGLDGgzm+9UfNfx8NmWVgZ6J17vdqhNTDG/NY0q+yiI9o6kh
 NE2mtX5FiKbepzahTsE/DK13ZCze7LwUoLX0DuMCp82TAQ==
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
index 46500e4223d7619a342f803c67aa760166fa6f2b..be3484068cbcb1a8e00e5018c6852e645de37dc2 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1094,6 +1094,71 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
index d63e72f7d29808582af32e79be9fb1595acdd032..281ba0202744fd96adad1a6936555784b07ef9e6 100644
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


