Return-Path: <linux-kselftest+bounces-18889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D1798CFB4
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407711F21E4A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CCD1DFE14;
	Wed,  2 Oct 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GV/d1h4Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557131CC16F
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859826; cv=none; b=T3oMitt3ZGepWQ5M+3au1ZiCzrRCE6owdtusLVLJdb0L2Rk0JUBFOZXRm7NM8xvj0riKU3iCVWvJ7ebMVmyLp3VULS24Xd8gUUS1M6FOtatiWM0xMOoJWYhzBDZ75jl+CLemR7COJXeLxPYYt+HnqtmxfAezrrrubykNXqDI5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859826; c=relaxed/simple;
	bh=poxxnPMFHBlbgk9hT4KAoFDOsyv5Cr0vROL/GXgxBiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJjGMbtkRHVdQ+TWcKjtyrHQYsqAl6DMlotTmpYVmsuvT+8/TObVREOgk64MpR+JqB1qHAUO7kh7HP9TRtd4nDtFmVTV7Nzep6gDDmQuem0zyRIk+ZzrPzt05QFbViOB2xVFzjYX/3WihPRBDMs6s97QhPvmk/pN2zexb9v/DLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GV/d1h4Q; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37cdac05af9so4062111f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 02:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859823; x=1728464623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1g5ErvOWdSDbVBAMFtgccgGsR+CcI40dCMnEOfXG5Q=;
        b=GV/d1h4Qf1LZEGio6mtJXom7t8AFQtKLKO2ICdv2UFXWgRJoPKFsjhULgSWnbSvXzW
         uUCfGPlZGLny8OGyb2OGe9/yD6I9+/APep9vktwOTE5wLkTCBREzn8HTFMqef3xxgSTv
         vO4Sav7dCxIJZYyiCXy2Y3vuWw/QzAv3MhW+AFbxtM2DBUzbKbbtgpHgFkHtkwA6aIoJ
         fgcw3f3w6LFY8jZAxydgLAymUizxLDmkNsygyngKjhjzQMEyIaNYbfnsiHkOY0BNhvZV
         DQhdkL97y/HmdCjxHV6ikwRPaElign7+bKrxsp9ya2L0fJkb214SVxmeBjs8OP0HAs5B
         b2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859823; x=1728464623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1g5ErvOWdSDbVBAMFtgccgGsR+CcI40dCMnEOfXG5Q=;
        b=H4Zl6G0lmMuHxJcfjkEfq+244M4vmoWm9YlVHmwD+k1lFuCi7i0YdxEb4MJZ8n814C
         +833kLtU+sx5ujcGkcyhoHSyYT4Bzs+uH9xmIIwVmPfb1voyw97+dYt4LK4DovAVkGqh
         wud81FvcBTY2CYfiuc/jRM+7Tp3Vl6+i1anxQiCxUCm12CxkTTvnXzuNpRt+zsMMdwyy
         Wl48HqsdytBqYZSKKTWBWZhTdZyEBE0A4rFSZHReN3WO/BQak5ah8nwa0spurqANbdNh
         Gmyf+C7kraGzICcWT+M3+oYVnClVZH/AVJttI5y7twt12NApTkXtFFCLNK0rmWabgcE5
         yJcA==
X-Forwarded-Encrypted: i=1; AJvYcCVklql7xj01Z6XSW/ECHNxsNGxvrzPcl6C7/LrT1RxkmsaJU5IXAZH0WnqbqBglMJio4Pl/h/0MJifKDzhlFgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkWGl86ejgWkocOtmE9o8MCl5J0J2BOYuYBzxgWI/1EKGo+bR
	sbwMQZtlElSzPlp9CLqgZxyCpX1KfBb/wb+WtWLTw873eFYdrGpaqWNgz64Lh/I=
X-Google-Smtp-Source: AGHT+IH7fw/E/kQ3V24xzbtq3adS/XElxX31aae+kZFgbO0z9PggBosgYGxEoE3ngXbkU7APgvBgPA==
X-Received: by 2002:a5d:4108:0:b0:37c:cce6:997d with SMTP id ffacd0b85a97d-37cfb8cf38cmr2076166f8f.20.1727859822608;
        Wed, 02 Oct 2024 02:03:42 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:42 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:36 +0200
Subject: [PATCH net-next v8 22/24] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-22-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3246; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=poxxnPMFHBlbgk9hT4KAoFDOsyv5Cr0vROL/GXgxBiE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxTNGlDMBkkc6iZHWRsImvE3HBTYIXK4k31G
 ZWbXzIQ3rGJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUwAKCRALcOU6oDjV
 h1tdCAC0zOmuy1ivCPWZ7NSHAKEAslKsZkAfD2e29GZ9yIJ3/eUZzHReWipsVVB4a60CNoWBDS5
 lNS9lc2ugXq+YF7h3CSnFLYJ+PsnWFx9TwDvAROujAPWLSRT3+pqtges/3bnS00tjE03wAg8vGd
 dyk3/LMDb47yHd4BEvvDBZ5MJNLFFgVLUkfdO1MKkRmJzyXNayw6YkoYf0vkjjYKcHnAnzKYR78
 wLvN1FPK4t/x+R1aMAXzQLq5sZvet7b/C8viwCeXVgyHV1cMi3LAuZcemDcTausTB2zxU/7dbQ0
 AMlxMizMwzwNhbX7+/sUIEDvjHiUJhd8ZeJ4WGDsAOLUrtT4
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
index e9cf847e99026e78eee4d65b62911671e8c2e407..b96c84fcc24921b2cd173ec2b6358b59eec72b39 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -963,6 +963,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
index 1ce31f0317cb3593a8edf95c43d03a0bddb0a58f..f201bcddb2d792e4f6b759d5e1fed42234aa1410 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -249,6 +249,7 @@ void ovpn_peer_release_kref(struct kref *kref)
 
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
+	ovpn_nl_peer_del_notify(peer);
 	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
 }
 

-- 
2.45.2


