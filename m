Return-Path: <linux-kselftest+bounces-45789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A52F3C662CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 79A2D293AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 20:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A41C34D3B6;
	Mon, 17 Nov 2025 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5maADOB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EEA34D3A7;
	Mon, 17 Nov 2025 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413118; cv=none; b=incXzCus2rlPsMjgSwQ4uqqzBfRvxBlM3YV5UwuQH31tQKgKXcEhyK6r3Sm4cy416Skhk7+00JiHf45ZhwzCiEEODPRXCsx13BXyBen7Bnr6EP+t+37e3AV2jbhqTwEu+vpgMmah3N1dSkiILd1woKdAFf270HdSUui5j8e3UqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413118; c=relaxed/simple;
	bh=MCuliezInHREj7rDrkC/ZdUFHDoRmkGeUHSiJBHdMbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTRPalrW3h/NTetFrE6cjAZ5lQNZvOlNBq9fSaUwNfpXLdPh85ut2y/5rDiILq09757IuoOneem+NzB3QrinRjnjIRz3JG4chXqpX9/AYn2HW2bQ2IvKAJlqEmDJZts5n6z1dXBLdcf13IsYN0XAUxpKHCOkqx4qUIQnxl56zuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5maADOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DB1C4AF13;
	Mon, 17 Nov 2025 20:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413118;
	bh=MCuliezInHREj7rDrkC/ZdUFHDoRmkGeUHSiJBHdMbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5maADOB0DV9R2mczgqyU174E9cKYrpuhMHTqs68ncfkauR+IPpvyADivDcnpylgr
	 PSACRS4r2lJaWS5V/ii6cY3hogZaYVR1yxIj7d36gvX2bID30XetwXqEz07UWyg7RF
	 UMJrryFJ0BO6aOTtTvcrOvMgopNWwDic/HmCt/2Ku2FGkHQDansLuoY8R8NPGx9t2n
	 2noarWDEKbwMLan1ifpsj3PbqAiPSPN/xw7GLEy4bB4Rs1GB1Jidnwu77XyyJ9Ya2R
	 ZBo8d0ASCuFdIdI3xq9BkcwuDBk2g0GGheIN56pWAPHk4LDY/afwFgW+sansKyeBqw
	 lthXOx/bKMC5Q==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 08/12] netdevsim: pass packets thru GRO on Rx
Date: Mon, 17 Nov 2025 12:58:06 -0800
Message-ID: <20251117205810.1617533-9-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117205810.1617533-1-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To replace veth in software GRO testing with netdevsim we need
GRO support in netdevsim. Luckily we already have NAPI support
so this change is trivial (comapred to veth).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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


