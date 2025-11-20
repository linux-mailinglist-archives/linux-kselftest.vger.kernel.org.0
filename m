Return-Path: <linux-kselftest+bounces-46045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0196CC71C81
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 057E935134A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 02:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7404F287263;
	Thu, 20 Nov 2025 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIU00VOP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5128688E;
	Thu, 20 Nov 2025 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604647; cv=none; b=qpj4putLwI6N0qZJQfzz3jMf3VfNatOVLTeCryYJG52lQsz8iPo7kWNu1h5iQhAP3EXe6AnM3FPfgbzOEqd8xMC2jx1UnaYFES/z9HN0WWUEzi7/td+JO///GKARrzs9JRmy5pwSpmqngc2evjNWahTG+sGFeFWAk9XVmXgDTo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604647; c=relaxed/simple;
	bh=j7S+H8j+XXY3HFiMTF8cyzW94wQeMwOhTvg2ru5T63w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBACmMb0JOywWuZEjCHnuzLYOfZK2xh8ShZjR7BFtMRsWLK1pvLhfymtyAqFfu0VamaRKOhDZYJrngOszYQ0F4YgJuZSHg6/TiQqKw5OlnI5Xdscd4VU15xDU5mUXP6OFJJ3MjJUbnReZ6EtuXhXHE/mFcEqGZKpZEpQGSV2RmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIU00VOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9191DC19423;
	Thu, 20 Nov 2025 02:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604647;
	bh=j7S+H8j+XXY3HFiMTF8cyzW94wQeMwOhTvg2ru5T63w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIU00VOPzoqGjIqK3hv4ZxBLZcsL9b0OruSMD5uJO/80ZdRZVs9hDOnusMZn18wH7
	 YdFlVNITLwHiw8IQyQP9v/x2s8AV4agAJnny9PgH3YIFgS76f8MdR6OhIlzwfRsyHg
	 jB/SWx8NEQAjBZUzbHz4649f1msbA1je9SQmn30BIAeZxPA0jaAYSer05b6OS0j5T2
	 NIPulDFn7HBR/PIas7icZlyi9sSIDks9aS9L6dkpMvE2aYGmWkRki9+h2IpGiVYFhh
	 TYDwchRCQpyiv1Ow7D+wSbPLZMyrpxFBiWI26ERDzo2LNAQ+BvwTz9mQVZ3YDJ38vL
	 c1wcesrl6D/Qw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	krakauer@google.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 08/12] netdevsim: pass packets thru GRO on Rx
Date: Wed, 19 Nov 2025 18:10:20 -0800
Message-ID: <20251120021024.2944527-9-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120021024.2944527-1-kuba@kernel.org>
References: <20251120021024.2944527-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To replace veth in software GRO testing with netdevsim we need
GRO support in netdevsim. Luckily we already have NAPI support
so this change is trivial (compared to veth).

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix typo "compared"
v1: https://lore.kernel.org/20251117205810.1617533-9-kuba@kernel.org
---
 drivers/net/netdevsim/netdev.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index fa1d97885caa..2b713db16cd0 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -433,13 +433,8 @@ static int nsim_rcv(struct nsim_rq *rq, int budget)
 		}
 
 		/* skb might be discard at netif_receive_skb, save the len */
-		skblen = skb->len;
-		skb_mark_napi_id(skb, &rq->napi);
-		ret = netif_receive_skb(skb);
-		if (ret == NET_RX_SUCCESS)
-			dev_dstats_rx_add(dev, skblen);
-		else
-			dev_dstats_rx_dropped(dev);
+		dev_dstats_rx_add(dev, skb->len);
+		napi_gro_receive(&rq->napi, skb);
 	}
 
 	nsim_start_peer_tx_queue(dev, rq);
-- 
2.51.1


