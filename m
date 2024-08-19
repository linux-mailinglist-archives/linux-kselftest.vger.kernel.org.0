Return-Path: <linux-kselftest+bounces-15712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72D9574DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D3A1C23D4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADABA1EB493;
	Mon, 19 Aug 2024 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nk/u0Q7T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A01E7A38;
	Mon, 19 Aug 2024 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096761; cv=none; b=C+qlhIt3HeGlx25aa05HatDsuEg682Qmy6bi5CeYssmOsYCMT0XgtpvDNQU4c7a8U6ZjiqAqqCZ9eN1M1RU/x+zOmpnBUlE+ivPOccuyPFSi+UDrbmImCSvxKyedXcTANbW9zjbYsY+AiSZ8PmA94WGDTIrZ+rMq9fyo2kCWQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096761; c=relaxed/simple;
	bh=cGNoHeKCL947W/uprD2LBcdAoCIR32Kpd7CBuyKk0Gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iW1y6dG50581m702fWM9P2i/J60K/nsjk1DAk9UOuFZTkAAYxuAZXXhIoo1XaI4TURgfVtlcWqcg+ygfrAfJerNKjAHRKwlf0LGY1YpQ5A0JrPrxAJV/j33PdbvvtRvV1WnAZKJ7/dIrL/XbDDEgBecYL9PZHQKDxtdx2osHYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nk/u0Q7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF67C4AF0F;
	Mon, 19 Aug 2024 19:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096761;
	bh=cGNoHeKCL947W/uprD2LBcdAoCIR32Kpd7CBuyKk0Gs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nk/u0Q7TccGtR5CCzjRorD/knBnspGFwuNq8O5QjIHWwJi0Ashae7LDwWTEgvWJJP
	 cN60l3IYfw5HVHPsqb1sLw75m3/GrUIcCdHtZerYQIizZU7QO8mVGIF3KesjwUN20X
	 ccxgr4Ry85nYp4dDrm+Gfrnnl5jAu9l7P0EHXZ1jonfvwAvbXip7jKwf2oMH8xDvYH
	 i9StbX3PeQbwi9mDAZKAarVrcZDfjACoPYHD5TGDi3Y4jCLuzkLHnFkxPRZ1Z9kI60
	 ZNkkrCr1UuFG6YCmqtfuZ6gJxgdw04fs5Vt4UnA8SIexZUnYNKka1hyAxQu6vFPDvq
	 8dQYI4nfuNSBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:29 +0200
Subject: [PATCH net 11/14] mptcp: pm: only in-kernel cannot have entries
 with ID 0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-11-38035d40de5b@kernel.org>
References: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
In-Reply-To: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cGNoHeKCL947W/uprD2LBcdAoCIR32Kpd7CBuyKk0Gs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DTUkcdqxZnODu3Vv0DrmcnJaoahmvFbSqwN
 wK4PvfRrt2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0wAKCRD2t4JPQmmg
 c1JeD/9skMtucjpTfEljtH44u9stOu8n73vTjg0yrYWdlW4r0vo50/2ZyiY5m66pF83qUZtkPHx
 /mGH2eKbECwAPInlRkpoBAFsyToL0Tr8VcA4hhZF18HlIUuLMxKbMnQIWfs/VClOhhg0xCNfVx7
 9sgjOn/eGhk+Z/oIrN1YAI+ghKnv0lmz23mWvcG+7WKTvXk5TnGUdf5NN+ahZ3PBTIyhR59Yz2K
 WT/lcWVh2VvkNUAMLxK2Iu0F58S6uuzEc4boBC9MQxRkv21p/T98+f+6eYvahPx2DcznrY54oCP
 9uC/EHJdLy2Troqy/UQSl3N70xjBUpk7BGg5+MTWpLtNKiaDXTwAxxv5lBR7LXa3504raiPDgUf
 rpHO3JjsvujOpmmEw4/7mpy9JDnLr9qdKgrHNArFkBkjKvQWj3i8qY8yTWhwflwrpd65UMtTQBG
 GtDV/rVFB+x/G37vYCLyAhe/nZDG3SReMYtrYHPCOKSlXAIo/zK3huQfZ+UuaWNCQB3s/h+5MiO
 IcTm+hv5OQFJG5rvdUi72zccM+dXmv21A8nob0O+v52RJk5zzsJpg2ziGYq62vZqBYYWY7tgfDr
 BKYJIjwGr+TfUiTyIArJPO2siUPaGGoqQCvs2EJ2QY5V1SeL40HZb508ac9cK/J55LND6NbCm8e
 uTofLnTYt8axPNg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The ID 0 is specific per MPTCP connections. The per netns entries cannot
have this special ID 0 then.

But that's different for the userspace PM where the entries are per
connection, they can then use this special ID 0.

Fixes: f40be0db0b76 ("mptcp: unify pm get_flags_and_ifindex_by_id")
Cc: stable@vger.kernel.org
Acked-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 3 ---
 net/mptcp/pm_netlink.c | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 925123e99889..3e6e0f5510bb 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -434,9 +434,6 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	*flags = 0;
 	*ifindex = 0;
 
-	if (!id)
-		return 0;
-
 	if (mptcp_pm_is_userspace(msk))
 		return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 28a9a3726146..d0a80f537fc3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1395,6 +1395,10 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
 
+	/* No entries with ID 0 */
+	if (id == 0)
+		return 0;
+
 	rcu_read_lock();
 	entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
 	if (entry) {

-- 
2.45.2


