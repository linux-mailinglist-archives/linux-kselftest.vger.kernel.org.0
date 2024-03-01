Return-Path: <linux-kselftest+bounces-5756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE286E831
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88A41F22B1A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DF5282F9;
	Fri,  1 Mar 2024 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZLSdb+N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94733D0AD;
	Fri,  1 Mar 2024 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317131; cv=none; b=sReflvjk6uT/OEyvPzRFMnJ9G1TNnSESSrzNqKZ1+/f1RLvTuId2cWf2sOO1RATQQpTVrpuOJC2GlGWP41GLfiXNoS9pLl0ePc0ZoEiPzWORV9elsyJtMzAo1Qrep7udk89xenCwyo9qocre784JrkiNKgWvqpNlXcaD1opqQbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317131; c=relaxed/simple;
	bh=7lG7R/s1q6fLAI6wvapbUgxQWeobDoOOk1BJNjVurX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Or917CM5yaIUWzt/08qHK+xktdyL2+Wcywd7eWnTAsKvHvSITmg7JJKh4IYV+exDJ5VG8lAfJhQzIbXsnOzCMtovs3N70EmQz9gLpJ2d+NmsxEaUOA077E70KIEzp+e/HfnQrBfQy02wGWro/9rVLsdVY8zZ/Jx9AuFLxDnvTH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZLSdb+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6549C433C7;
	Fri,  1 Mar 2024 18:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317130;
	bh=7lG7R/s1q6fLAI6wvapbUgxQWeobDoOOk1BJNjVurX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZZLSdb+N5NXpJTaYIYXiX+5H/FwcVSGg7KIN7oClImmg/uIhgKsqdLpJQGB3P1kvy
	 GW55w7Mm40vzu8sQu4oh9U8VZznVZwRS0iNfGvqnYC/OWJWW0JO1xNUQdYVuvVfL7l
	 Uwzu8nlaDD7VMAdi55J7+NAyCBPhEtGoNQl8QftP758ufSa3kteXTCMbqQ5jHxabAb
	 oLgXtVZQwmiS3qTgCGluX1UV3WuLps0Xxg2FMpFq69D1CBFakCFsHBxiIRdxdCc0tr
	 swdofAUxMAkGfq2r2dGaJy5lO38SHv/uPj0tk9PvAsjzPJUKcdpugk5pC+dzdFsb3z
	 ovHIzGB57YyNg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:30 +0100
Subject: [PATCH net-next 06/15] mptcp: check userspace pm flags
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-6-dc30a420b3a0@kernel.org>
References: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2877; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nB2jr+h3crYGyM6lGO9/xWsi/9FVXdNk/IEW2/03A4s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv0aHCCdqzGFyKJ5B1lx+aiAndXV/nIkk7cf
 gU5gKvfPY+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9AAKCRD2t4JPQmmg
 c/+xEADKUM0XrA6HwxFUnHiadXTzhVe8dW1u6ZBaWr4JMv7xPmJjZaP/RgATUAhPGYwrHWL/V4b
 LzYo4RGTjBHrwI0x+GgCgo+4CTCYDbbJt3M2bdfiSE+R7aILQZNfvGgPeXs1oyZfSCQFksx5Mqx
 TZ/B0tt7T9qsrdDQgc6AbghbmhotHY+i0/EV1lfFTRGlIiCE7xv5BQOu/gcNerMYtNz2JXvNBrK
 pQNWsTyxI2vSzcYuyT9rD7Lv3KN8waoTFh/3cbYH/86BpKekO5WMyf714T2nhUW6k/Dl/RmlDSo
 7Y1gKUgJ08VttoK2ssbNc1GB3lyb3CBod1bkv7NrskKZoF9AlGt4IFPPGiUDtXez0+9CWVqft+8
 c1pbaQfs2QQ2PstgzAn1Zn7aEVOH/RFo6raICKYhiH2u/6GogCzcwxwkyPHIsvKkT4zfgjzw0kV
 /A20TZlKSkpklyDvSPiXbSD0fW42ntSzYLBN3zPuiLlybL9Diz1J/LXOPEnUNq7MDgmbIIWe+dz
 tGZ/C/HrQgH1oGV9y6B4vwBM8RgmqhYKa2p8awI6muJnBV1u4ZGEKCw9uJPc8pq+H4/QtoiLm2e
 2ZUX7A7DW9Phh0G0JKZKaOfLguGpkQKET0K3ronhYTxP5Mgb+aLokcgqRPaX7+VzEuEQ5x9AxMg
 z/Wc3YCbqsOvimw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Just like MPTCP_PM_ADDR_FLAG_SIGNAL flag is checked in userspace PM
announce mptcp_pm_nl_announce_doit(), PM flags should be checked in
mptcp_pm_nl_subflow_create_doit() too.

If MPTCP_PM_ADDR_FLAG_SUBFLOW flag is not set, there's no flags field
in the output of dump_addr. This looks a bit strange:

        id 10 flags  10.0.3.2

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the PM flags of the entry and check it. MPTCP_PM_ADDR_FLAG_SIGNAL
flag shouldn't be set here, and if MPTCP_PM_ADDR_FLAG_SUBFLOW flag is
missing from the netlink attribute, always set this flag.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d6b7be3afbe5..3bd13e94b568 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -334,7 +334,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry local = { 0 };
 	struct mptcp_addr_info addr_r;
-	struct mptcp_addr_info addr_l;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
@@ -360,25 +359,31 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
 
+	if (local.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
+	local.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
+
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
 		goto create_err;
 	}
 
-	if (!mptcp_pm_addr_families_match(sk, &addr_l, &addr_r)) {
+	if (!mptcp_pm_addr_families_match(sk, &local.addr, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
 		err = -EINVAL;
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
@@ -387,7 +392,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
+	err = __mptcp_subflow_connect(sk, &local.addr, &addr_r);
 
 	release_sock(sk);
 

-- 
2.43.0


