Return-Path: <linux-kselftest+bounces-19811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5871F99FE02
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 03:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18643287B19
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 01:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E91D27BE;
	Wed, 16 Oct 2024 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="crGPpoG5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57E1D26E7
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040669; cv=none; b=mOw8M0qbAwtGrwhmQ5KHjQb1UR+urIXr4F+cjZKzeWzlyPVTDmEc+dxTMgqF9wFiZNmDnxAZa09uDkLRRo7J8nZV9iu9F8kT1TkD8KOw7zi4fMMOGe4R9qShbYAjOWjOFLzVYtGjCpOoh8ohO6JOKTEu/jyQUidgiPcA8OkmKDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040669; c=relaxed/simple;
	bh=nU8TleDp+Ut6e8BOqP5Lv2Lo+9j4c+aWZvfGoKQf/ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItxRR3buZg3rJeQQNWxcY5LrNngMnUeYfZZ2dYNUj75KOdqXvLatgAkyV8GJnlvy35D6kdWvLlDMLQpcwEhajf0mTbUoxxr1iljxu5iRsc7CzejvPwDl+23WK2Yu+IK48mBPBA2RFMXZY8uTdyDfggWb4VPn+2n/Hai2t8om6QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=crGPpoG5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d8901cb98so195981f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 18:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729040666; x=1729645466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqS1ZpjN7qw7rm8wczpqCw+7mxghDdiAYmdxPr/ayQM=;
        b=crGPpoG5NAaGA5nTBvpek0O9woMLjkRf2OtEmiQ8WSP4eTQ64cQVsoeQwnpnnYmbHm
         +9pXGyWPQrZ0Uw+7u8HsTz8L/KZOOG/W3WXAFocei+XK0ZNSTSy2s41MkfEqyj1ZsKym
         e5slvuSByqKPXoU+WueGWld0EmGtNFoszpbo3VTGVdcdaxnv78JfrZ0wJY50cfkn6Qv9
         U4HndNjUsClsjTHY/q4dg1j7iF129jfCumWbW5wLHJe+CxVCvDgYqMv3UphZ5qDmaOaU
         mcrwCnaOgtO94QQs3wPUX1oUKi5S3ayljHnIk0uF+XzYBo6anFkMHx4bohkedVGTMYAp
         5eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040666; x=1729645466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqS1ZpjN7qw7rm8wczpqCw+7mxghDdiAYmdxPr/ayQM=;
        b=ZhJA0OVrr6upJF0pwOm1m60E3BO6YiPgFDSsZ8hUa7hipHwd1pWxBgxIfoFKyRlABr
         dyyzh+EjISXTQ+g7ZKMksvQhLNvQgHHlIDdu59MnUhN9wpN8jvtvRmfLliDymnupwwRq
         rgHqMrtilkpv9WQUUorjDFnC9jKCPz0seoet68O4q/4OFAoy+XDU1MZ1JzrVsgEcXFpn
         QfixPTeHwrDbtyRZTadA59TdmrX2W/pexg6w+TAnJAGBcCIz/QXEmAkVNJdqKMiMgymK
         g01/QUzHTEZwRcmpCB/yvMCOt5TonrBk186lV8RuAQ7ohowwT7GNi/BkjvWYFyznjml3
         wvNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPFh0kpFjGSYFDhJf/7s5NvKktOvFlmmNSScsRhaV5iaEpSxnD4m+vgWIjoXJZATwcqJXkkC4yH1oq4zFYSsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydaKRXus0K3rjgcenrGx6mxsUAPElaRWbUZLyQD68GRn85HLK/
	ttqyH70utXRRgZwDlXOq9jfREmMnrWGqbIPJ+/oWklUh/b3mANplPoh+1APR8XM=
X-Google-Smtp-Source: AGHT+IEWqZORm45+krRlB8x4vdFvtbCcyxw2xawp6YS+IdLSRW/gVnMGHqyKRL9EZpdJhzk79c5MNg==
X-Received: by 2002:a5d:424c:0:b0:37d:3e42:be32 with SMTP id ffacd0b85a97d-37d54e0c9e9mr11734053f8f.0.1729040666005;
        Tue, 15 Oct 2024 18:04:26 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:4c1a:a7c8:72f5:4282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm2886765f8f.25.2024.10.15.18.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 18:04:25 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 16 Oct 2024 03:03:21 +0200
Subject: [PATCH net-next v9 21/23] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-b4-ovpn-v9-21-aabe9d225ad5@openvpn.net>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
In-Reply-To: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3254; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=nU8TleDp+Ut6e8BOqP5Lv2Lo+9j4c+aWZvfGoKQf/ac=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnDxDxJZTZd9C7SpMR2eH0McjXLmAr71bXtMFxf
 ycnsyJFIzCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZw8Q8QAKCRALcOU6oDjV
 hyHZB/9U16LBSG6sW4qDubGJY1UK4tSzYy4lZE+ZYOMMTYsi44kLIE87Gqi7bDpstD4f+9f32g9
 yX1+z85XxCLkz7FB9S/3g7zLpmgmY9WVsUhc7mH6uXOWt8c2vz3EwwQb3zkiQ7GFdp1MnhKJAbA
 d7K47D1qhl8Z3MM4/uE9uOE+VaeNi+vsKhpHlJ9Pu33xc6QxQSOlxwQaKKXnk/878Qx1RSjPzc8
 X9tbomhPVkdPrSAoLAjXYqy8H6RjTk9Vk+gzEMDtBhYj3eVsEd+LUKdr/cvSusqJhJWqpdlKWhU
 ZYzJwx787G2ceVKFd/Bn9gEBU6X1jXNgUF3j5bz1+vwW0DTi
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
index 09c7df2b1c76c812a3bece6e63c9fac13c96c327..975d324c0362e34fc209eaa4552051ff75c00036 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -903,6 +903,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
index 2e218e8cfacad753d1284808958234913f3ef59e..267ffa17db632d3b959c5b53f80075966f95a53c 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -239,6 +239,7 @@ void ovpn_peer_release_kref(struct kref *kref)
 {
 	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
 
+	ovpn_nl_peer_del_notify(peer);
 	ovpn_peer_release(peer);
 }
 

-- 
2.45.2


