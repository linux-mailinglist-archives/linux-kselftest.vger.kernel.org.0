Return-Path: <linux-kselftest+bounces-27910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF8FA49C36
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 15:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C978E3AA16F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 14:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C88A27183E;
	Fri, 28 Feb 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSN504o+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C39C270ECB;
	Fri, 28 Feb 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753555; cv=none; b=V/tp8SJAGSUkFoywiN9IL4z/aSWerVLFA6DNpOoV432CtsU8HAD/2hs4cbzoR790diWTF6KkS6ufRqzpFIa/UIEakTYFrlpboiDLfpDLPxCKe1fFwNqvqgdxPhn58lWBuogRNM0an5J6D5vfcIiHLKZACJJ56rLPp4gJBwTDFPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753555; c=relaxed/simple;
	bh=SR01wZtxowcLXs3yfy5Y+LMxNUyuNtRfD7LDE0dllEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IbWdtTh2h/NOIcfWDGfFV6EUdkrHAvdEzDAHqt29O+1ouqZ2ME1EZghB0+NxKtUyjMSAcnK3Fg2fsEJnT11rQv03RpzPSFwk+qU9c5nDj3wZwjAAKCY1phNURynpfRIZR5JOJYbnRjDYntzFqaK8v9xFLXhpM2ACkxJc5VCtCa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSN504o+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF384C4CED6;
	Fri, 28 Feb 2025 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740753554;
	bh=SR01wZtxowcLXs3yfy5Y+LMxNUyuNtRfD7LDE0dllEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PSN504o+fdeerOBzbDOBDgBGbpi31KAqYWTJmxnX3OWzM8rklxBlW3kMhaNBOkhdc
	 pgCiVm8f7I5GBG5Ca1So4JbaRTVVQaXEqOYaOvVHcoFhggrQaBfrKsbzPPe/NmEQcq
	 AiWagZl/5OK/fuCgO1MEUJ2cXO623JP6nw3ZIa2EpCz5VRbnHGdwTAY8lN/Vyy7NVq
	 pS/oSmglMWUmNQVc28zWGDBRqyYbQYFw287CGQiqgnVuaIkputc4otbBAz1BVL2wIg
	 SQXZlPXtxtbFfkYLpv+LWNad6E3MCb3dbpCYJb+YcDzWezm+6AvxC+9ljwwJCfjfyb
	 fGaNAiQZ+f0xA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 15:38:37 +0100
Subject: [PATCH net-next 3/5] mptcp: pm: in-kernel: avoid access entry
 without lock
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-net-next-mptcp-coverage-small-opti-v1-3-f933c4275676@kernel.org>
References: <20250228-net-next-mptcp-coverage-small-opti-v1-0-f933c4275676@kernel.org>
In-Reply-To: <20250228-net-next-mptcp-coverage-small-opti-v1-0-f933c4275676@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bhkcrEKDjMhUYJUOxRM2zlReKNBUTor3uckMu+ugIiE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwcqFvzrOx6fNwMZQlnoEMpTz/oLWpwaxhhuot
 ElA54xiL2CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8HKhQAKCRD2t4JPQmmg
 cwPVD/9q05P8hFCgqDiWpqsVltd8uQk1rn1RiU5trR1QdKNJhLgjBFdRrsdf8pxpliUfIxzhuey
 RGjG6tr5MOM0XV8YSEsueYvBGZutZ5i+uhdU1wG6UOi5oeXi/gMld+x16k4SVrLgmy0mk1mTE1q
 DmpG6/2XiPXcqcwz3yhceFwwFHhUVXfuvnQgC7KB3G9y+jOchqqT0y+Q/boJeFbw3Q5CjEZvKTS
 2tr2eWj+EBwRNq0tO1crzm+k9A5e6DlvDM/VartN5wFICjRHLhH3/AnhI5PbeLAC1JundSPZtgI
 Qka/4EWqXbw0rxp6d7lcez3slVepGJvUOgT8cp8cmbLTDvajLhi+hpohz2fW1VcjYdQZ2WCfvKo
 VjC2bow4yXsqrVKVLTnPHYAkfXKsPdFbNwtcK3bYMpmES0yzaoMF8gh+fwMObWUr6i/yoOExOZN
 ZZr0WG0+RqdnLXuR0EgIZXtkvS+DE+/5EmaxBjN+BzBQv5uVF36t4ATZDpAf2qH5Gz+fB6vSHIL
 D5PVeNHOlprRLK3KUsC11+pet7bCCT4rka5waOPHihgjnrN+Jf+u9A1aMkKRwxD33a0Pc6DoceN
 k32uE2LFfqUtnG9UCGpf8nNxnFpnnrzLaDuO/pUKEHG5Ignc+MyzB5EFPL2G42uXbpZygufp4lk
 U2pP0LLhzRkOXHQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_pm_nl_set_flags(), "entry" is copied to "local" when pernet->lock
is held to avoid direct access to entry without pernet->lock.

Therefore, "local->flags" should be passed to mptcp_nl_set_flags instead
of "entry->flags" when pernet->lock is not held, so as to avoid access to
entry.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Fixes: 145dc6cc4abd ("mptcp: pm: change to fullmesh only for 'subflow'")
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d4328443d844dbe52d2b0cc0018dcac1e4245320..fb83eba041f17c09923a8ed1a033983692962c5a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1983,7 +1983,7 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, &local->addr, entry->flags, changed);
+	mptcp_nl_set_flags(net, &local->addr, local->flags, changed);
 	return 0;
 }
 

-- 
2.47.1


