Return-Path: <linux-kselftest+bounces-19433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71817998384
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 12:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC0E28385B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 10:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1BA1C1AA9;
	Thu, 10 Oct 2024 10:26:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92A1A00ED;
	Thu, 10 Oct 2024 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556007; cv=none; b=UoHhAPepv0PmpkN9q6q/AAtkyorRbs+j1MdqVzpFuk62GWZUemuweIBSdhImt4xJqM79qFvduWSimOVnf0LrbwLJ87xLNtgRlfjUlZqjNtXK2Ss9DXprPusXpCB1e9rP01pTbMdN+Br2dUbsfRrwLBAGOWp7A2+kGvI9jDnjR0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556007; c=relaxed/simple;
	bh=2QFNQC4hlBgvHrnE16j+dyLIZp6idLhknvErN++4uFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbg0wTZeNZ57SLJI+1Pj/wmcBfBPDpP1y4VCXGpQXueoOIFoxoAWjuNm4HjVbQOAy98WLwwLN7rRtH4zpfOHgh477x8eGxBoG3iwGkaOU9LPdgCmX3ska7u9S5suAVFe8u/fY279PzcIS4jnCKKLQwDbNkYC5on0mYqLJypll9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPQr22C83z6K6gm;
	Thu, 10 Oct 2024 18:25:22 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id D2EA6140CB9;
	Thu, 10 Oct 2024 18:26:42 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 12:26:37 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v03 1/3] af_packet: allow fanout_add when socket is not RUNNING
Date: Thu, 10 Oct 2024 13:25:12 +0300
Message-ID: <9e15c0c2cd19d94207a1791de0dc9051a5abb95a.1728555449.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1728555449.git.gur.stavi@huawei.com>
References: <cover.1728555449.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 frapeml500005.china.huawei.com (7.182.85.13)

PACKET socket can retain its fanout membership through link down and up
and leave a fanout while closed regardless of link state.
However, socket was forbidden from joining a fanout while it was not
RUNNING.

This patch allows PACKET socket to join fanout while not RUNNING.

The previous test for RUNNING also implicitly tested that the socket is
bound to a device. An explicit test of ifindex was added instead.

Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
---
 net/packet/af_packet.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index f8942062f776..8137c33ab0fd 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1843,26 +1843,29 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
 		match->prot_hook.ignore_outgoing = type_flags & PACKET_FANOUT_FLAG_IGNORE_OUTGOING;
 		list_add(&match->list, &fanout_list);
 	}
-	err = -EINVAL;
 
 	spin_lock(&po->bind_lock);
-	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
-	    match->type == type &&
-	    match->prot_hook.type == po->prot_hook.type &&
-	    match->prot_hook.dev == po->prot_hook.dev) {
+	if (po->ifindex == -1 || po->num == 0) {
+		/* Socket can not receive packets */
+		err = -ENXIO;
+	} else if (match->type != type ||
+		   match->prot_hook.type != po->prot_hook.type ||
+		   match->prot_hook.dev != po->prot_hook.dev) {
+		/* Joining an existing group, properties must be identical */
+		err = -EINVAL;
+	} else if (refcount_read(&match->sk_ref) >= match->max_num_members) {
 		err = -ENOSPC;
-		if (refcount_read(&match->sk_ref) < match->max_num_members) {
+	} else {
+		/* Paired with packet_setsockopt(PACKET_FANOUT_DATA) */
+		WRITE_ONCE(po->fanout, match);
+		po->rollover = rollover;
+		rollover = NULL;
+		refcount_set(&match->sk_ref, refcount_read(&match->sk_ref) + 1);
+		if (packet_sock_flag(po, PACKET_SOCK_RUNNING)) {
 			__dev_remove_pack(&po->prot_hook);
-
-			/* Paired with packet_setsockopt(PACKET_FANOUT_DATA) */
-			WRITE_ONCE(po->fanout, match);
-
-			po->rollover = rollover;
-			rollover = NULL;
-			refcount_set(&match->sk_ref, refcount_read(&match->sk_ref) + 1);
 			__fanout_link(sk, po);
-			err = 0;
 		}
+		err = 0;
 	}
 	spin_unlock(&po->bind_lock);
 
@@ -3452,8 +3455,12 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 	po->prot_hook.af_packet_net = sock_net(sk);
 
 	if (proto) {
+		/* Implicitly bind socket to "any interface" */
+		po->ifindex = 0;
 		po->prot_hook.type = proto;
 		__register_prot_hook(sk);
+	} else {
+		po->ifindex = -1;
 	}
 
 	mutex_lock(&net->packet.sklist_lock);
-- 
2.45.2


