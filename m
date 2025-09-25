Return-Path: <linux-kselftest+bounces-42296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7630B9EB12
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF7B1BC7972
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B362F6564;
	Thu, 25 Sep 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+H5DZE7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BF62F60CB;
	Thu, 25 Sep 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796407; cv=none; b=BV3iRJZLqo/aKEN6liaZxh3kJWOS+CAXo+nrXq5A/9XlmEn0kEwE9ECmWeyFR/ZZp540UAJ9zyX6MmG9huFP8MUEmAtQVePYk0CNyNb84MbllgpKLp5ds8buQYFS2XZTwX5/6a/AECPc1dDZEtd1ue+tvi/BslWx0EjIVT0PRjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796407; c=relaxed/simple;
	bh=/itRLGcCTMYqntDjfZiHo1eI1Vw2kdlkY8CCsSCxHZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sebi4wTz9tbrjBESDvy+Dkf48CUpJBZCA3VyxqX2OJp8aaFGgHMV2RvXWu/KtRXBryJcUHryREir+68ckUxhybZ2/7/ZEOJ+Kv+PGZcuValx5ZmS/5g7K09JbKQ/cfhZvNdfUznkHqVrQUJ2PC7ZrcYbjgiyVcpRXZ7XFMypvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+H5DZE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D78BC4CEF4;
	Thu, 25 Sep 2025 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796407;
	bh=/itRLGcCTMYqntDjfZiHo1eI1Vw2kdlkY8CCsSCxHZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L+H5DZE7pd7b+EpS3+LshvPLECNXuPpDDkndzj4LyO5GIKje8gpeigGezCQfEnnkR
	 ueJwSL6ehCZINhurOrol5Aa3A6iFIHpvBca8xAeVaQOz50dwqsi5WI5uZJTJtyvRxq
	 2nnwtOFax31mEglnxJJn4Wms7uBuFPgVdMZIFC/3ZEVpPdrt/O7uPKAvs+3ltQMAp+
	 7MSdCjc6OlYycHVrY/illWA4DZHy8ItGqNlq6DxInJ798krEq2l4ofcI+/ZgwY6S7x
	 IQ/WDmhoTJwrk05VibyhAO9AgUiAuPdMY4VyLcCGmfWn/pznlzLQeWV4k4q/uK7rA9
	 ocIl7o4vtB4GA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 12:32:39 +0200
Subject: [PATCH net-next 04/15] mptcp: pm: in-kernel: refactor
 fill_remote_addresses_vec
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-net-next-mptcp-c-flag-laminar-v1-4-ad126cc47c6b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5408; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/itRLGcCTMYqntDjfZiHo1eI1Vw2kdlkY8CCsSCxHZQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuSoXLZyQz9s7cvf503/LlT2vVTvzL7hDqSF5ssvLR8
 2CxTVlyHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOZG8HwVyo/fNGJicUaB22m
 NWSa8+h8m7Gj03qReK7f3OrJ96OVBRgZfpevX39H9fuEdpmbC3zbnqbtPVB1/L5ABKO4Uc3H4wY
 XWAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this modification, this function was quite long with many levels
of indentations.

Each case can be split in a dedicated function: fullmesh, non-fullmesh.

To remove one level of indentation, msk->pm.subflows >= subflows_max is
now checked after having added one subflow, and stops the loop if it is
no longer possible to add new subflows. This is fine to do this because
this function should only be called if msk->pm.subflows < subflows_max.

No functional changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 116 +++++++++++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 49 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index c8f2af2277c2c28bc7ad393bc4ef8507ddd3a875..a82c077b8a20ccda2b4fc3cf7a55141bd01760f2 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -159,74 +159,92 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
 	return found;
 }
 
-/* Fill all the remote addresses into the array addrs[],
- * and return the array size.
- */
-static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
-					      struct mptcp_addr_info *local,
-					      bool fullmesh,
-					      struct mptcp_addr_info *addrs)
+static unsigned int
+fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
+		 struct mptcp_addr_info *addrs)
 {
 	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
+	struct mptcp_addr_info remote = { 0 };
+	struct sock *sk = (struct sock *)msk;
+
+	if (deny_id0)
+		return 0;
+
+	mptcp_remote_address((struct sock_common *)sk, &remote);
+
+	if (!mptcp_pm_addr_families_match(sk, local, &remote))
+		return 0;
+
+	msk->pm.subflows++;
+	*addrs = remote;
+
+	return 1;
+}
+
+static unsigned int
+fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
+			       struct mptcp_addr_info *local,
+			       struct mptcp_addr_info *addrs)
+{
+	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
+	DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct sock *sk = (struct sock *)msk, *ssk;
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_addr_info remote = { 0 };
 	unsigned int subflows_max;
 	int i = 0;
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
-	mptcp_remote_address((struct sock_common *)sk, &remote);
 
-	/* Non-fullmesh endpoint, fill in the single entry
-	 * corresponding to the primary MPC subflow remote address
+	/* Forbid creation of new subflows matching existing ones, possibly
+	 * already created by incoming ADD_ADDR
 	 */
-	if (!fullmesh) {
-		if (deny_id0)
-			return 0;
+	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+	mptcp_for_each_subflow(msk, subflow)
+		if (READ_ONCE(subflow->local_id) == local->id)
+			__set_bit(subflow->remote_id, unavail_id);
 
-		if (!mptcp_pm_addr_families_match(sk, local, &remote))
-			return 0;
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
+		addrs[i].id = READ_ONCE(subflow->remote_id);
+		if (deny_id0 && !addrs[i].id)
+			continue;
 
+		if (test_bit(addrs[i].id, unavail_id))
+			continue;
+
+		if (!mptcp_pm_addr_families_match(sk, local, &addrs[i]))
+			continue;
+
+		/* forbid creating multiple address towards this id */
+		__set_bit(addrs[i].id, unavail_id);
 		msk->pm.subflows++;
-		addrs[i++] = remote;
-	} else {
-		DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+		i++;
 
-		/* Forbid creation of new subflows matching existing
-		 * ones, possibly already created by incoming ADD_ADDR
-		 */
-		bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
-		mptcp_for_each_subflow(msk, subflow)
-			if (READ_ONCE(subflow->local_id) == local->id)
-				__set_bit(subflow->remote_id, unavail_id);
-
-		mptcp_for_each_subflow(msk, subflow) {
-			ssk = mptcp_subflow_tcp_sock(subflow);
-			mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
-			addrs[i].id = READ_ONCE(subflow->remote_id);
-			if (deny_id0 && !addrs[i].id)
-				continue;
-
-			if (test_bit(addrs[i].id, unavail_id))
-				continue;
-
-			if (!mptcp_pm_addr_families_match(sk, local, &addrs[i]))
-				continue;
-
-			if (msk->pm.subflows < subflows_max) {
-				/* forbid creating multiple address towards
-				 * this id
-				 */
-				__set_bit(addrs[i].id, unavail_id);
-				msk->pm.subflows++;
-				i++;
-			}
-		}
+		if (msk->pm.subflows >= subflows_max)
+			break;
 	}
 
 	return i;
 }
 
+/* Fill all the remote addresses into the array addrs[],
+ * and return the array size.
+ */
+static unsigned int
+fill_remote_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *local,
+			  bool fullmesh, struct mptcp_addr_info *addrs)
+{
+	/* Non-fullmesh: fill in the single entry corresponding to the primary
+	 * MPC subflow remote address, and return 1, corresponding to 1 entry.
+	 */
+	if (!fullmesh)
+		return fill_remote_addr(msk, local, addrs);
+
+	/* Fullmesh endpoint: fill all possible remote addresses */
+	return fill_remote_addresses_fullmesh(msk, local, addrs);
+}
+
 static struct mptcp_pm_addr_entry *
 __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 {

-- 
2.51.0


