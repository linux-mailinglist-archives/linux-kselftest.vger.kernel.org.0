Return-Path: <linux-kselftest+bounces-42303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B67B9EB4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1377B59EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777FC2FC866;
	Thu, 25 Sep 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kd1F3V49"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCC72F1FD0;
	Thu, 25 Sep 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796427; cv=none; b=AWNwB1gbhV7xlS48AZe6XnI9PLvEAcP8W4+jOJLMO0oAzZp/RFhfqWyEf61YVVyvyjHZBwKwHA/KXTXuDWYEdtZTKb9z4JJx5nfQAgVadpji4K1q0QeN53R8UaC6E9UdwIq7v8DL0sKT/4mdSlWbn/bbY0JU8hdDuViNWfRTjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796427; c=relaxed/simple;
	bh=9Rxcp6xUNgO4WzrQnwT97LAScNxi/Gv/TTGgIqDK5PQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rp07iExS7U+mp2ij1rN1OXJemX0aAKuKVvHKnfHoAr4RVQ13ORxmrDmphCHZQBBjhBzurrTP07N4aGGFwG/6ncVyKOfJ5QOAAIMUxlTbU+g8YuxpihVKBV2iNlcB0cdFpwDOLKxpMOzIZSoFg/fo3MdnIQ+GOyFExHVPt6/rbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kd1F3V49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27C9C4CEF7;
	Thu, 25 Sep 2025 10:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796427;
	bh=9Rxcp6xUNgO4WzrQnwT97LAScNxi/Gv/TTGgIqDK5PQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Kd1F3V492pEa3HNNJ5bivrkLEr9X+TeRKBttjDmLnkGlbDwQz5Kwle2NIv0R7kkm9
	 0hbZb43P/ifHfkZLXePINWwrTiD1MoIzmwKpMSS8fO5RdNahWE+Xhgmlzgsp/JLPHD
	 piy5bxNCqr8qqDWaaCG2q80tIqYeEF5PjNUjb3XPIIfD5yQuO3+dO5GLVgVfjemABe
	 XLOYQZt0jtA6pU6Qo05ZoOT77ncQ90apCcTdASaYfTT2o3LWCKVfDa/BxF4rzEFD4p
	 JdHKJtdlRKFS3f6PTI6fdDtmMdcM5QbPYutEhZ8pWKaxqmPHoJBVwxC/2YZ1AhArLV
	 UR4UadyIrlnqQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 12:32:46 +0200
Subject: [PATCH net-next 11/15] mptcp: pm: in-kernel: rename 'addrs' to
 'endpoints'
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-net-next-mptcp-c-flag-laminar-v1-11-ad126cc47c6b@kernel.org>
References: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
In-Reply-To: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2502; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9Rxcp6xUNgO4WzrQnwT97LAScNxi/Gv/TTGgIqDK5PQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuSiXOSo2/YlLnrZxc9vddvZFe35/8B0pb6vlEV2bm3
 77dMGF+RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwES2OjEyzDxtyZ3lFTp9+vNz
 ohuaS8XX28Ur7V5994jikirpiFxBe4b/4eenbW8p3byPl/vHPO7f3R6HvuW3ZxkYsGwLPdOkcE+
 HFwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few variables linked to the in-kernel Path-Manager are confusing, and
it would help current and future developers, to clarify them.

One of them is 'addrs', which in fact represents the number of declared
endpoints, and not only the 'signal' endpoints.

No functional changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 056624965546dac7e087c82c9df8c496c8959f33..d30b06605f623aaaf38152ab6750841c5deeb0b5 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -18,7 +18,7 @@ struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
 	struct list_head	endp_list;
-	unsigned int		addrs;
+	unsigned int		endpoints;
 	unsigned int		stale_loss_cnt;
 	unsigned int		endp_signal_max;
 	unsigned int		endp_subflow_max;
@@ -636,7 +636,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	 */
 	if (pernet->next_id == MPTCP_PM_MAX_ADDR_ID)
 		pernet->next_id = 1;
-	if (pernet->addrs >= MPTCP_PM_ADDR_MAX) {
+	if (pernet->endpoints >= MPTCP_PM_ADDR_MAX) {
 		ret = -ERANGE;
 		goto out;
 	}
@@ -675,7 +675,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 				goto out;
 			}
 
-			pernet->addrs--;
+			pernet->endpoints--;
 			entry->addr.id = cur->addr.id;
 			list_del_rcu(&cur->list);
 			del_entry = cur;
@@ -710,7 +710,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		WRITE_ONCE(pernet->endp_subflow_max, addr_max + 1);
 	}
 
-	pernet->addrs++;
+	pernet->endpoints++;
 	if (!entry->addr.port)
 		list_add_tail_rcu(&entry->list, &pernet->endp_list);
 	else
@@ -1109,7 +1109,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		WRITE_ONCE(pernet->endp_subflow_max, addr_max - 1);
 	}
 
-	pernet->addrs--;
+	pernet->endpoints--;
 	list_del_rcu(&entry->list);
 	__clear_bit(entry->addr.id, pernet->id_bitmap);
 	spin_unlock_bh(&pernet->lock);
@@ -1190,7 +1190,7 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 {
 	WRITE_ONCE(pernet->endp_signal_max, 0);
 	WRITE_ONCE(pernet->endp_subflow_max, 0);
-	pernet->addrs = 0;
+	pernet->endpoints = 0;
 }
 
 int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)

-- 
2.51.0


