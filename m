Return-Path: <linux-kselftest+bounces-19232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C745994565
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 12:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC331286BA9
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E41B1C231E;
	Tue,  8 Oct 2024 10:29:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7081779B1;
	Tue,  8 Oct 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383366; cv=none; b=aZiZWnvP/p0DBpFiKDKUVCYRAvjwimVAKZZOe5vzoGDZDgjKBR2Dymyg/CC2lZuxWMij39ggLDWiQp/vLQVz1Z2KtjcAXV/a68kfpx1DvkWGJeG72XXYRAXXNUIQLkjKZWGPvXz3+r4ywfF67ibZyo5xm5Gf0isnrWeVvA6ePOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383366; c=relaxed/simple;
	bh=pjtIaP4a1Q8eXmJbm5mUwmzGh9nInGfQha9qscS3zLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSFGbYjht2t52lgNAVDxKmKlFz/fYftp5OnJRVTXgY5aLfJs+yjHN5RU5Wasz3YGg4j/PZxcYRNYP1H3115uBjXnKwrbkJj89CCgHYVahkc84E6jUaW4JCp+gD3d3DKUrwgARHovALVq+h3s8RFoic03cLPNsVGwIcz3dcCSBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNC1H5Mxgz6K9Bm;
	Tue,  8 Oct 2024 18:29:07 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C8EB140133;
	Tue,  8 Oct 2024 18:29:22 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Oct
 2024 12:29:16 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v02 1/2] af_packet: allow fanout_add when socket is not RUNNING
Date: Tue, 8 Oct 2024 13:27:58 +0300
Message-ID: <05852e3043d2b0a7a5ca51d456e82966dcb72f03.1728382839.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1728382839.git.gur.stavi@huawei.com>
References: <cover.1728382839.git.gur.stavi@huawei.com>
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

Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
---
 net/packet/af_packet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index f8942062f776..fb2cca73d953 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1846,21 +1846,21 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
 	err = -EINVAL;
 
 	spin_lock(&po->bind_lock);
-	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
-	    match->type == type &&
+	if (match->type == type &&
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


