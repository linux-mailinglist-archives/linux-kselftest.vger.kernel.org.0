Return-Path: <linux-kselftest+bounces-5372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE8861D61
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BB91C22EE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908DB148FEE;
	Fri, 23 Feb 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBpChH4u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319FE14938A;
	Fri, 23 Feb 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719545; cv=none; b=syCak26xb6FpjUhuJtnXi8BNJWBrE9Z63iUTOXf4d/kZd4n7uz05630NSSS64z4Q/mS0Jl6/C41NoLPOPHtJQW2uLUB+kOjiIJGj0tiOlmwrC7ViMhwdhblYo5J0cLZ5pu9ffr58j40dwPtOWuBU2Rqqlx9KSRhfxzQaKbNr0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719545; c=relaxed/simple;
	bh=Dm6ZdORui82/8VoYa4bD5q/6VoXige1uFQXuWG3HMks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrnqrAdN52uY3DbnkMG6uqxP003ynq7onolVinf8nIJolnGdLWhiGKaWjouppeAbQ5RIXnyuxsNb68/+nxu6kNk0w54jHy75Nt+/UmyQbBewP8eOBgHBP/jXySeHL5OxtBcqMhmlUwiXQlCqLvV9YPfEWE/S1dY5rfdkS2DNzBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBpChH4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AED8C433C7;
	Fri, 23 Feb 2024 20:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708719544;
	bh=Dm6ZdORui82/8VoYa4bD5q/6VoXige1uFQXuWG3HMks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sBpChH4ubXj9H2Rq6Zjdq1N8SM3jKzp/2P5UcRMCsk+oNWuTfWTikoN32ya4NJxvN
	 waNiAHkJsQJeAOSPtWISoAmE4U4SixqmrRJpj2yltbcOFlpXtijD8IvuhE6hWEoj3J
	 ZKI0lQlDEVGuKU7NzaiITE+7UwkqFhnK1nFHU8Xt7GhK5Z5CJ6lb15uaPid6c+Yiwp
	 iz4Iz6wq4bDcAchlR4CSbkzGW04c/7f9fAVsw9o9EOT0YONSyooThTGssr13bv8Odn
	 Vl8wXRrwk2BJtE5NelQZ3ZCtysYE8rbs1XURb72/jDu03hQLqRLX9GK+0gePih3s2u
	 SBc+gQsId5SkA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 21:17:54 +0100
Subject: [PATCH net-next 2/8] mptcp: token kunit: set protocol
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-next-20240223-misc-improvements-v1-2-b6c8a10396bd@kernel.org>
References: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
In-Reply-To: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Dm6ZdORui82/8VoYa4bD5q/6VoXige1uFQXuWG3HMks=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2P2q2eS9x43GC5y4A1Ev0Db4KVnezwT0MGWbc
 R/lDEWzoIKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdj9qgAKCRD2t4JPQmmg
 c7jnD/4jD0nW63U92fD3F/Fzyx81Zku0ZzjDDRDfwaZC5/HajMUrJmOWRY24NV0oHlkMYa2J6kY
 jpLpuJyu7+Y8J9L5wTpdKKGIGi7pOSuB9JZQBgjYRBlWsK2nVPbgSJ756oHJPekgEM7nXsCElfO
 mOoq8VG1Qm4vWDxIqxUdBp9/8oiOKN4U3OwQUFxJvMBjxtgH3PxEEV6C2x49oPkfyVWW4bMGFt9
 yVJNcDiZn79hgc+N0Zl0fG0XLNrR99IOCydPxrQKzdwkqRrhGtG7OnAkoBJSQAcrUSrka/WnXC/
 oU7h6RJXdPVb3y8jccAGdgJ/KBhkGIlF6w2bqmQe+9jgrlvY1dp+gAs56Ivgy11kyNKr6kShrzh
 eTgR8KiFg397D/U8YNtVfgWkln52tW+ve0DGUGAgaWBiAtEkP9Lm3xv3RTt5m85JJmyXWVbZ5Jc
 /dzLFX7X3gOUDCZ0Bq/cGJnm98DEMTStHCfAQwP0cFQSgwlmWjDomyw5WnkLsZ/EzX5MFn2ywMf
 ynE0SSyY5b5+tP64CauPOky8+cLM5Dl8mj+foz6KJDOKvZrB577STwUK0XsgQ/ZSbo0PbpTt7u4
 aPqvTj8fyvVtKmVWq8xxNb/7KhwtzsjM+PTr9Tvv0oPvrNVhA0YNQWGgq/4ulnLcoS2Z3Bil1Z6
 OXcc9tkgFMzHwqw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As it would be done when initiating an MPTCP sock.

This is not strictly needed for this test, but it will be when a later
patch will check if the right protocol is being used when calling
mptcp_sk().

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/token_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
index bfff53e668da..4fc39fa2e262 100644
--- a/net/mptcp/token_test.c
+++ b/net/mptcp/token_test.c
@@ -52,14 +52,19 @@ static struct mptcp_subflow_context *build_ctx(struct kunit *test)
 static struct mptcp_sock *build_msk(struct kunit *test)
 {
 	struct mptcp_sock *msk;
+	struct sock *sk;
 
 	msk = kunit_kzalloc(test, sizeof(struct mptcp_sock), GFP_USER);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, msk);
 	refcount_set(&((struct sock *)msk)->sk_refcnt, 1);
 	sock_net_set((struct sock *)msk, &init_net);
 
+	sk = (struct sock *)msk;
+
 	/* be sure the token helpers can dereference sk->sk_prot */
-	((struct sock *)msk)->sk_prot = &tcp_prot;
+	sk->sk_prot = &tcp_prot;
+	sk->sk_protocol = IPPROTO_MPTCP;
+
 	return msk;
 }
 

-- 
2.43.0


