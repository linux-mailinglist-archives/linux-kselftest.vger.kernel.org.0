Return-Path: <linux-kselftest+bounces-45926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B44FEC6BC76
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 22:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9428A4EBE51
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 21:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAE0315777;
	Tue, 18 Nov 2025 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHxd+O0T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC430DECD;
	Tue, 18 Nov 2025 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502728; cv=none; b=NdYazOIEvEapNj0SvfKt/UCWQwhkW5TCgOikXJduOZKyPeiL+aLZYiC3oeHr3qapuudw/iMpetqR0Ys5TaaU1cHmPZadvMd+XDcOVZ5RLnlImuGsBoQJJMSk6oZb6aETL0QYuIr+WuWu72K8x2yshUAX1nmjNv5i2eoQibvbvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502728; c=relaxed/simple;
	bh=N8RmN9BEIbAbo7i/AueWrbn4wqWbToznvNWQpMocDPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWfEnxgdV5rbvAOmqd86vhCTMwFTu+vKjII+Et1PelJIpmPnUH4D612C1b69kZgwjrgV5Xp7FnAMA7UPBRTU9GfH0KdcHtyoQrQ5lS4+kvkroyvkdbf/TAmnmaaPbXXLaef0uV9ArPN21tNWsr4BjohFjwHfnKWlRJt01rD7aS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHxd+O0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30422C2BCC4;
	Tue, 18 Nov 2025 21:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502727;
	bh=N8RmN9BEIbAbo7i/AueWrbn4wqWbToznvNWQpMocDPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHxd+O0TOAZZLBrCEpDbNDuMBlv+mwUD0xubplBDj/5YDk0ZV8a5UWOLKPVkeQCUd
	 LpisOVpYjzHWausZv4qj7Li4CKdbBDR9ARd9DwlJ14fZ0OrISMeesrB7uz40+mXLLk
	 tneULMtXG7UoAx9zkbdn9mUh+KE7FIfoTznEqnMY5acRlU3IgyJtkVcziKlloxExgC
	 j7ErrUpNNrBKIhRG3pUU3sXRwAGpVa8vY6vo/mo1jYEx8MhNEydlw4N2r8HkP+eng4
	 0A6ZqFr+es6j+SoiGU2H+QSuaa3kSmM0zROq5OUBz+QX6cMDXusUtDEMINpwG/YOPu
	 ZqAFVtT5P9bow==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 08/12] netdevsim: pass packets thru GRO on Rx
Date: Tue, 18 Nov 2025 13:51:22 -0800
Message-ID: <20251118215126.2225826-9-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118215126.2225826-1-kuba@kernel.org>
References: <20251118215126.2225826-1-kuba@kernel.org>
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


