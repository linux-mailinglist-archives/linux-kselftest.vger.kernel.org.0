Return-Path: <linux-kselftest+bounces-19611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D24B99B8B1
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2024 09:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D929A1F217A2
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2024 07:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506213A3F4;
	Sun, 13 Oct 2024 07:17:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE111770E4;
	Sun, 13 Oct 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728803857; cv=none; b=Lf6iaSsiiizpgCkmaxoNaqX3Psr2n20dd3P0DcDNlgHMQBKN6NeRE729ftB2Wzfm56JpJdMHfxVW2EXenCAEwGb/pZML3X6/6xiH/h7KalYFjuBo98OvHMSvhCr/LRzHcvWRiaUBWndGNudQawbAN8hyZ5plafhlZQ5Wg9PUJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728803857; c=relaxed/simple;
	bh=czfDiGjk4LCl6mAPJecaovDyp8awkvEZyqj2LYUIptM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzv5PKsJTlkr29N9E5rcQXbh0+mmOkLLyYsavZq0L0YBRkZ7PVLXZHC0TCOUyAJFJj7x265V8nx7dYy+72nh9Y8mUcWmi7ub6KsBz1uDL3/aHIyq9BtPMjyilHQVww/8SL+Nxf7sVTvJBTGxS8J8mX5lg9fxdk+23vrYgfW5dK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRBWM0lRtz6K5fZ;
	Sun, 13 Oct 2024 15:17:03 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 57856140114;
	Sun, 13 Oct 2024 15:17:31 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 13 Oct
 2024 09:17:25 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v04 1/3] af_packet: allow fanout_add when socket is not RUNNING
Date: Sun, 13 Oct 2024 10:15:25 +0300
Message-ID: <4f1a3c37dbef980ef044c4d2adf91c76e2eca14b.1728802323.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1728802323.git.gur.stavi@huawei.com>
References: <cover.1728802323.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 frapeml500005.china.huawei.com (7.182.85.13)

PACKET socket can retain its fanout membership through link down and up
and leave a fanout while closed regardless of link state.
However, socket was forbidden from joining a fanout while it was not
RUNNING.

This patch allows PACKET socket to join fanout while not RUNNING.

Socket can be RUNNING if it has a specified protocol. Either directly
from packet_create (being implicitly bound to any interface) or following
a successful bind. Socket RUNNING state is switched off if it is bound to
an interface that went down.

Instead of the test for RUNNING, this patch adds a test that socket can
become RUNNING.

Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
---
 net/packet/af_packet.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index f8942062f776..2ff4b251842d 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1846,21 +1846,22 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
 	err = -EINVAL;
 
 	spin_lock(&po->bind_lock);
-	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
+	if (po->num &&
 	    match->type == type &&
 	    match->prot_hook.type == po->prot_hook.type &&
 	    match->prot_hook.dev == po->prot_hook.dev) {
 		err = -ENOSPC;
 		if (refcount_read(&match->sk_ref) < match->max_num_members) {
-			__dev_remove_pack(&po->prot_hook);
-
 			/* Paired with packet_setsockopt(PACKET_FANOUT_DATA) */
 			WRITE_ONCE(po->fanout, match);
 
 			po->rollover = rollover;
 			rollover = NULL;
 			refcount_set(&match->sk_ref, refcount_read(&match->sk_ref) + 1);
-			__fanout_link(sk, po);
+			if (packet_sock_flag(po, PACKET_SOCK_RUNNING)) {
+				__dev_remove_pack(&po->prot_hook);
+				__fanout_link(sk, po);
+			}
 			err = 0;
 		}
 	}
-- 
2.45.2


