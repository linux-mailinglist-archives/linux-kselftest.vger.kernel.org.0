Return-Path: <linux-kselftest+bounces-14296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4BF93DDF3
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 11:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3CB283438
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56764D8D0;
	Sat, 27 Jul 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLR4M/jJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B64D8BA;
	Sat, 27 Jul 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071073; cv=none; b=dx6az8wy79+S8K08KPbYHAQ5OJ5T5kVAR1RJYSD6isidcGADJftNrtv4QxqjHUysZ17FqoM3JUGcXi+fwtBwrrrPCVsONTP0pl0xLWnWUED5r64gxKc9e6pJQs8hNZpcDrjlejF91bziKiThegm2LQ9gHKP+rKtD4u9wHWEjYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071073; c=relaxed/simple;
	bh=pn2hIRT1RrJODV0kTBUrju3+oLj48rM81icGCX71GDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PSxbC3LShWcdoRQvOPgCjRgMSp/Y05Du5pSN64pKPVkV3KFuR8rr9gbnAOcRWbYaoPGfim9B+Gg40ErOfSlLkKui4GxGqqFp2riaE/N44rHziPKfAJdnbxb4OVJLAtYz7h4/AtfoSM00vL4sJ+FuQg3w9z8J6oUad9SZ/KRjSK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLR4M/jJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F04DC4AF0A;
	Sat, 27 Jul 2024 09:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722071073;
	bh=pn2hIRT1RrJODV0kTBUrju3+oLj48rM81icGCX71GDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lLR4M/jJ6yAbkeJgXWnxbpA0FgaAdRFoO3Toy+rK2X4KqrwrO5YKpxJPuQiEbMdit
	 Mn1ET40t9uNYfsd3U9Gm/sAiXNEjQtmTe1yH5dr3qsCQ1j9GkNFbVr35J7OSAk50Sb
	 gbHuLnXnnxuGNGM6jn2jk/rXBqklTg7mu0mzOPPE5y64cEzQ9MlLDo8uuUXFu97ZMw
	 tjCeEKLnReAMtR5EtlmAHMvEzTu4reLeGR2IDF17iyHuAtf9aEDFwcHKkbbqb4jsgR
	 3XEDNVE76TiuapvwEUnoD2/IzZ5JPqNvVNJoibOxO0z9+o07lkI5wNxLFP8XToTHnf
	 s/ocQ96n1DbuA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 11:03:59 +0200
Subject: [PATCH net 1/5] mptcp: fix user-space PM announced address
 accounting
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-1-1e7d25a23362@kernel.org>
References: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-0-1e7d25a23362@kernel.org>
In-Reply-To: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-0-1e7d25a23362@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8ys1pb4FgWbv1b46VcKxx8z0yyqmgTUcPtfWhv86Vzo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpLga2oUq3nKrg/FJmKzGXRw7EdI82AgtBcfRP
 ETPr4CbAsaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqS4GgAKCRD2t4JPQmmg
 c8ZnD/98RkZpHp7pRIkZ9gIZim2P3bjZqRv20l9YfIJ4lOa7YDJxV5VNnUIfOmsY7HtksbWb6ey
 sdmP3kuyVnIK84at4OiqAeEdpCIHFaZott2HlREGQT/rMcB3EvWL91jo8F6efTKpaNFjWDZc7CB
 e3TK/U4KOVbavmOPVRnqnJPdnYLR1KCX5VgNyiZYP8n7Sp7BoYspcZpvhXgMRi5b2Kku7H5ZRH0
 RiI3/F23WehhUSiz7j6/HDnenp7nK7656pFGB0lR39TMSEddYOrzy0DAJSrrjvCuLWPJBhpOjMP
 ZXKS+bLgHskSgKGT1Ofo5kpZTMOoFKJ4vAftgMtp5dRAWg93q1O7s72qaK2sK0KPngOcb09u1Aj
 Utf+nUfBKMNcfoK+l6bNmX2U7x6ueIvgHpikhrdPmloeGrEB05NWEM/FNFB4qOdt7KsRqk5Iex7
 rCMwifFfrhW6MhWFy9oXQZYtZAG7vALt72yS2FCStZFgZ4vzANldtFBSZmi9IJMD963gmrcxzIf
 e5a8GNGllxQ6a/z8GHaZKe90YZx6BWp+Q9CJCcuyEY4FCWYDU2/DN+qfIBcrXpFeuYVASstDXby
 OeckESXWyt3jmZvzpN5C/+eNmW6sAUUmE7ImFoj4tj1atHH8OqHje0CCCPJJGx+zMQi6n1C3sIE
 Eo9iPUiCUFVeAlw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Currently the per-connection announced address counter is never
decreased. When the user-space PM is in use, this just affect
the information exposed via diag/sockopt, but it could still foul
the PM to wrong decision.

Add the missing accounting for the user-space PM's sake.

Fixes: 8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ea9e5817b9e9..b399f2b7a369 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1534,16 +1534,25 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
+	int anno_nr = 0;
 
 	list_for_each_entry(entry, rm_list, list) {
-		if ((remove_anno_list_by_saddr(msk, &entry->addr) ||
-		     lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) &&
-		    alist.nr < MPTCP_RM_IDS_MAX)
-			alist.ids[alist.nr++] = entry->addr.id;
+		if (alist.nr >= MPTCP_RM_IDS_MAX)
+			break;
+
+		/* only delete if either announced or matching a subflow */
+		if (remove_anno_list_by_saddr(msk, &entry->addr))
+			anno_nr++;
+		else if (!lookup_subflow_by_saddr(&msk->conn_list,
+						  &entry->addr))
+			continue;
+
+		alist.ids[alist.nr++] = entry->addr.id;
 	}
 
 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= anno_nr;
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}

-- 
2.45.2


