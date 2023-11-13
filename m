Return-Path: <linux-kselftest+bounces-57-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DED37EA6D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 00:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8CC1F2336F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 23:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2186A3D969;
	Mon, 13 Nov 2023 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC7HNDCc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4B3D3B9;
	Mon, 13 Nov 2023 23:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6682EC433AB;
	Mon, 13 Nov 2023 23:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699917418;
	bh=6NjuMMfupABGOprM2E0ZdnQVNhlyr/LPmz4PlYvGCTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HC7HNDCcy5FHfuZzRQGhnvg1b7giJxLSyvVUv6vL/nLouZlkcd2kcIUiWw5sEHcW2
	 c3SZpked9FZlIJByQH7LiT5VqRKstbTuVa0q99QJjOL2acUcLGw3EnhPWxnE0k6vzN
	 c7mNnRRdDvDpMwySXdYbVnb5fCzXnZ9ZtESY6Z3HzTZkXcWSWKlvuzJKaTkzIywdyQ
	 yypjOiuqOw9Ov0FZBnlFVYStT6CltQ0KpbNpKZBSOV+C2x2n5voyaaB6XO4gm6ISfL
	 N7Z5DRbK0jDYpZmatXq1fsD5fLF7KL74o4tCcMnv1wzLSjfJ899G+b9fxprt4VEvnC
	 objWKes5MwC6Q==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 14 Nov 2023 00:16:15 +0100
Subject: [PATCH net 3/5] mptcp: add validity check for sending RM_ADDR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-3-7b9cd6a7b7f4@kernel.org>
References: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
In-Reply-To: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Poorva Sonparote <psonparo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=De6XueuAtSX4KlkXPDBKo4EbKmfgtMyfgEamAykmwTo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlUq5aj1GKYa5rYyWGNMRIArHYv1uqvRXCYxJ8m
 bGU4Tz4AXeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZVKuWgAKCRD2t4JPQmmg
 c9A1D/9BunX1yiZIGndUkzDF+IhU6xLrvv3v1GoZFnmZpv463cDEqV+c42hHDi8CHBsXCq/pbc/
 OpKxNAGhp9DOGyAHZIsE9gH9SYDvsgoDtBtiKdQpNZVaJ4XDzAQ4Gt+r2CKHWRN80wgJSnNRUae
 Ucgds34h46cZMmg8VyaRNAtQud1sWnNRLPrdUpfoSN39aQgPXSmkuYSNoY1VY9krPIHwf3Pry6B
 8tg6HG4gIQCx/WHhUI3gxc0ramKniKa+NuSlAcuYpdcOYqMSP7mujp0Y28wcZf12UCOfFR/wGq+
 MaEfOfOvRi5oGy2Cqc4tcMMZ4mOF5bRecyNU7WplDRHec6z2oL9I0Sx/MP8fUk0pz9STCpu5mAw
 LZaUBDtDz37p49hmfLdLGbNtKKIswWOCZe//hvW4pXXUU5AASNm5SFSNA2UZYryUNMFjispNAdB
 IMfYM/0Z4wPyCl5hKsL28SvRFBxwaR9zSFtRLpgPGPFanuvPGpZAWa9Ecj4pU80RXZ4TH6Prnon
 QnbipvsqtnbUWY5MtlprzzSZjwEDlQbf2I5U5vCZbarEoelVh8ZhzKi2ftmUR+/1NciWYJfZlB7
 aiz4YSvCVA7QT3xXiQ/DzVntFiXuyKjykMYH6W5Ve7h9dNH3D+FjmMKWf+azVEe1TyP7QCxbBpe
 p+3kIxCkw3RMt4A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang.tang@suse.com>

This patch adds the validity check for sending RM_ADDRs for userspace PM
in mptcp_pm_remove_addrs(), only send a RM_ADDR when the address is in the
anno_list or conn_list.

Fixes: 8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1529ec358815..bf4d96f6f99a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1515,8 +1515,9 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		remove_anno_list_by_saddr(msk, &entry->addr);
-		if (alist.nr < MPTCP_RM_IDS_MAX)
+		if ((remove_anno_list_by_saddr(msk, &entry->addr) ||
+		     lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) &&
+		    alist.nr < MPTCP_RM_IDS_MAX)
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
 

-- 
2.40.1


