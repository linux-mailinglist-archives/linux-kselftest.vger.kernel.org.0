Return-Path: <linux-kselftest+bounces-42302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8358DB9EB60
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A2A18849FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F902FB964;
	Thu, 25 Sep 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMvblnpx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBFB2FB62F;
	Thu, 25 Sep 2025 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796425; cv=none; b=lzsoDTnTgfuP1VAjQRMJG5b0sIq5yA68XyFDMBCrtuLrDBwiz1nGi/dTs7aXBo9astMm3wD7rTTqnWpJJfymtYxZ/hd/jur7MWK3kUnkmehF3tXT9VpWfSOI65e4TKmr+Zv1/vDHbpWrui2AuFMX95VpxvkTWeXcKKCO22KCErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796425; c=relaxed/simple;
	bh=ZwvGpOAAHhOuaPqOqLVHeWu/iUrJNjj0MNyn5eAlLAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dGuMAga9RWOStpENVjDQmlWHe6YAu7tHetdR0cmjYPPE7aiGwkbCmzlZMgeOIrUtseEPzlAhiK+jeTqIjRgFe1D3jV++mzA+EiitMb38AMMcWg3DHOw5HYt18jZo3th5Td3vjAF4S9cksalLyIcqEZrIJO+TW4m/oHlofANhmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMvblnpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCA4C4CEF4;
	Thu, 25 Sep 2025 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796424;
	bh=ZwvGpOAAHhOuaPqOqLVHeWu/iUrJNjj0MNyn5eAlLAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OMvblnpxSd/6lWKbsQFylw55y4C9V+Ia5vRnmdovAlfB8vWCqbdDdSWrobwl9l2u5
	 oIHGsIbzw5fSqAwzdNw4lQQ3ZZkwHKxDey0htufsO8FMYSCzM6wC9ZqGwv1cHxqYBE
	 suABLnf/+WzKesK3qlT3qccUHbpZu1bGQmqsRy407BGN3K/AG1XZrbbN+H0D46Im6z
	 yvmuND2yEBa1R5d4ommFhpiHjWDBIICIMqknhL65Yh4/CcejeNFoQkDXTZKF68qAtq
	 ojlJ5iXMU1bcL7zr3RQEJ4pQEnC+J6yET+W5/P/ZA4c/K/jdYNX0PKJU1qM8+ZXD3J
	 fZkHVY1J3pdTA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 12:32:45 +0200
Subject: [PATCH net-next 10/15] mptcp: pm: in-kernel: rename
 'local_addr_list' to 'endp_list'
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-net-next-mptcp-c-flag-laminar-v1-10-ad126cc47c6b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4782; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZwvGpOAAHhOuaPqOqLVHeWu/iUrJNjj0MNyn5eAlLAU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuSiU8bVZ6L/Z5sebjiOh/ynpaEYms5aYTln4w9DjmZ
 bzcJ62jo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLuBQz/HVYV5sc9cmCM/CnH
 IRMg5MCiVtEwgUtBtmdCusY5ya7DjAw/9kQ+Np2y3kfps2QGw9OGjWrrmHczfFqlY1XTEr1GxoQ
 NAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few variables linked to the in-kernel Path-Manager are confusing, and
it would help current and future developers, to clarify them.

One of them is 'local_addr_list', which in fact represents the list of
endpoints, and not only the 'subflow' endpoints.

No functional changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index e62e21eb9da12a7b361049efce1ba193fcbdc572..056624965546dac7e087c82c9df8c496c8959f33 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -17,7 +17,7 @@ static int pm_nl_pernet_id;
 struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
-	struct list_head	local_addr_list;
+	struct list_head	endp_list;
 	unsigned int		addrs;
 	unsigned int		stale_loss_cnt;
 	unsigned int		endp_signal_max;
@@ -110,7 +110,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 	msk_owned_by_me(msk);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
 
@@ -141,7 +141,7 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
 	 * Note: removal from the local address list during the msk life-cycle
 	 * can lead to additional addresses not being announced.
 	 */
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
 		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
 			continue;
 
@@ -250,7 +250,7 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list,
 				lockdep_is_held(&pernet->lock)) {
 		if (entry->addr.id == id)
 			return entry;
@@ -263,7 +263,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list,
 				lockdep_is_held(&pernet->lock)) {
 		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
@@ -413,7 +413,7 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
 		bool is_id0;
 
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
@@ -650,7 +650,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	 */
 	if (!address_use_port(entry))
 		entry->addr.port = 0;
-	list_for_each_entry(cur, &pernet->local_addr_list, list) {
+	list_for_each_entry(cur, &pernet->endp_list, list) {
 		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
 					  cur->addr.port || entry->addr.port)) {
 			/* allow replacing the exiting endpoint only if such
@@ -712,9 +712,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 
 	pernet->addrs++;
 	if (!entry->addr.port)
-		list_add_tail_rcu(&entry->list, &pernet->local_addr_list);
+		list_add_tail_rcu(&entry->list, &pernet->endp_list);
 	else
-		list_add_rcu(&entry->list, &pernet->local_addr_list);
+		list_add_rcu(&entry->list, &pernet->endp_list);
 	ret = entry->addr.id;
 
 out:
@@ -1199,7 +1199,7 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	LIST_HEAD(free_list);
 
 	spin_lock_bh(&pernet->lock);
-	list_splice_init(&pernet->local_addr_list, &free_list);
+	list_splice_init(&pernet->endp_list, &free_list);
 	__reset_counters(pernet);
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
@@ -1464,7 +1464,7 @@ static int __net_init pm_nl_init_net(struct net *net)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
 
-	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
+	INIT_LIST_HEAD_RCU(&pernet->endp_list);
 
 	/* Cit. 2 subflows ought to be enough for anybody. */
 	pernet->limit_extra_subflows = 2;
@@ -1490,7 +1490,7 @@ static void __net_exit pm_nl_exit_net(struct list_head *net_list)
 		 * other modifiers, also netns core already waited for a
 		 * RCU grace period.
 		 */
-		__flush_addrs(&pernet->local_addr_list);
+		__flush_addrs(&pernet->endp_list);
 	}
 }
 

-- 
2.51.0


