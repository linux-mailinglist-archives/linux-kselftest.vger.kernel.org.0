Return-Path: <linux-kselftest+bounces-4795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3010856C6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15061B25AF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50569139578;
	Thu, 15 Feb 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTEz7pyN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D541139570;
	Thu, 15 Feb 2024 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021541; cv=none; b=VwttGvSWOTrdeziLbXOdWvvglzg44ZlPvcHbnG7kdqldWovN26SFKAwzIknC4eQy7vuM5X2VfTgna88ueKjlVjif+V6FVOmUC6Gn9E+6a0lE3byITSp+9SJwOM6EtjtFebBoTWFFiyg6yKDQgV4WPsYsUp/7WnYvJADOcQmqL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021541; c=relaxed/simple;
	bh=Pj0an6pet6JMiQN6jgmDWHTcNSh1WHDRJPkGt5MvGWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BOw9dopYOMWJXJa7JnhY8VatPAuBfGfw9wS+gqtOvXDkPxP12+42APAcDQWeOga+A7Rjp8+ZNKz1CIxhvqIgXwnptYeU7Hqgx9sU/YrGP1uOA5YUjyj3QawKHa2YaaPD91sqp40knGh9FlXT8UozRNt9mTBBjLOrmOSJ04UgfU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTEz7pyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EACFC433A6;
	Thu, 15 Feb 2024 18:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021540;
	bh=Pj0an6pet6JMiQN6jgmDWHTcNSh1WHDRJPkGt5MvGWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cTEz7pyN7WTrZTMkSFtRN7Tu2fMRRRaCNlmaFWXLCt882LHWuT+YG9xGTigJloCr0
	 QUrNJdNehqiwxvrLbuWQ0gaWExW7SxnOpBaVYdpOlqeNVBIQYmIAnsKgfllLftfkv0
	 7TdV4wfQG6qC5xBmG3HIvBXe4OpvahAm9yJwB/rhOLBzYFu5if8Og86AmsKo+ANKhH
	 9x63S/SJjvPxRaZX8vKMmi95wPR16fwsAMZA8ah63G4VeZcZNpvM0q/b+1+/uW5xCA
	 NLQ2lO92hEEOWclSjfFTNfRbea3gXgQuoo9dYYhuZaMollpVnhPX14mP1+jtla5tyv
	 NIoqdIFPmo16Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 19:25:28 +0100
Subject: [PATCH net 01/13] mptcp: add needs_id for userspace appending addr
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-1-8c01a55d8f6a@kernel.org>
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
In-Reply-To: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3724; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JleY60xju9PrfhZyS6qCMKbVrnKGfzFaq0Li9qSQ99c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlccaQjOy2U2xZ7H2PNfZBsGDjJ4QoD+1g4dX
 +/4Fva7TFeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHAAKCRD2t4JPQmmg
 c4HuD/9Z5qAcWnv3ThiJ5fT1htqwPM55HNWgbc3HryOUQtBeFy33c2ZCpHPQpDWw2lYDlOerwOk
 Gbd8KoFzmSe592a7MRORYpQvXgb0PuOGU72Y2Hhu70jIaJstPo1zab59oe1Mwnw8CwA8FhmJCvW
 nTVPy8HLlf6VIqxJS9GkPyurjU1e+G7ucUGBTHhhaUixN8c/VSN/3Uc2MBtW6ysuCEzWLk/ez19
 Vufkf98Z8efCUYa7/4HT4+JjUk3zIBm9MuylkbvfglZV03MApUfUCHyKJ6cNE0KRbw/ep2AsmXe
 laXUmeIl/nvxA5qHH9z0whyw2+gLyquwkTJ++FZCAdanulL0QVgWOHsapKEQRolO4Xpy4c9+EDg
 RwqyPsNRTxWCiz/yv3QCDiNnqWtsFTXmP7raBbtXDy2j+26e3hJwFMuLJMlvhpLO9Xjq0AdAFan
 StSM2PYHWPvLe/F8wCvxDr7GkZaw3Pm/N5Q/sZP95YZ5+GwTiL9kbx0oPe2dJpkC2kW4KuB1a0L
 fhU3sGtEZsUsNnR5okz1/KVZpVeZnrkZhmRZnDtBKGM+cD/hMVH84umJx1oJIMO0T62orimQk8G
 mS9fkjhbBQEjJ0ghC6ZUYTRDUQ61Ljd52jnlQQJAWpuadQaxsQ0ZZz7r4LzVdrvshtp68iN+P/S
 +EC1eoXg5Rq57aA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

When userspace PM requires to create an ID 0 subflow in "userspace pm
create id 0 subflow" test like this:

        userspace_pm_add_sf $ns2 10.0.3.2 0

An ID 1 subflow, in fact, is created.

Since in mptcp_pm_nl_append_new_local_addr(), 'id 0' will be treated as
no ID is set by userspace, and will allocate a new ID immediately:

     if (!e->addr.id)
             e->addr.id = find_next_zero_bit(pernet->id_bitmap,
                                             MPTCP_PM_MAX_ADDR_ID + 1,
                                             1);

To solve this issue, a new parameter needs_id is added for
mptcp_userspace_pm_append_new_local_addr() to distinguish between
whether userspace PM has set an ID 0 or whether userspace PM has
not set any address.

needs_id is true in mptcp_userspace_pm_get_local_id(), but false in
mptcp_pm_nl_announce_doit() and mptcp_pm_nl_subflow_create_doit().

Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4f3901d5b8ef..e582b3b2d174 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -26,7 +26,8 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 }
 
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-						    struct mptcp_pm_addr_entry *entry)
+						    struct mptcp_pm_addr_entry *entry,
+						    bool needs_id)
 {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_pm_addr_entry *match = NULL;
@@ -41,7 +42,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
-		if (addr_match && entry->addr.id == 0)
+		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
 		if (addr_match && id_match) {
@@ -64,7 +65,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		}
 
 		*e = *entry;
-		if (!e->addr.id)
+		if (!e->addr.id && needs_id)
 			e->addr.id = find_next_zero_bit(id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
@@ -153,7 +154,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	if (new_entry.addr.port == msk_sport)
 		new_entry.addr.port = 0;
 
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
+	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
 }
 
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
@@ -198,7 +199,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto announce_err;
@@ -378,7 +379,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	local.addr = addr_l;
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto create_err;

-- 
2.43.0


