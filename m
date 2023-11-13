Return-Path: <linux-kselftest+bounces-58-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AA27EA6DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 00:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857D61F2329D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 23:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104FA3D983;
	Mon, 13 Nov 2023 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb/M7yWV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D320B28;
	Mon, 13 Nov 2023 23:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523BFC433C9;
	Mon, 13 Nov 2023 23:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699917422;
	bh=W0b3gyn44KcNCBO6UUaZ6j/sKJtPmQfYULhtG6WJYqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nb/M7yWVUm1sNmkoRbJKG/C+OzPukvvt+bk50xwnwG3hAxNEPIX3qHpd//mulyEEC
	 2pschryKCij7vGHecHbFBxMR4akdqQrO+muyh0ldD0Qxn+sO4GfGa9dOoJxOthMV9Z
	 znRGqDrWBe0NZuFBWxZN4oVmyY87T3BvZ7sI5I6beW4f3d6ijxbQK1rzv/EoUkQtyz
	 eOZ+X22Z2GCYoIJ0RTM6jjKqIv3okl2yw0JE7K5DJXTh7bjjGtCSbJ12xoF/dLgyFv
	 B5snkAKLsuWpVgQDu+SKPRVbxToyB9eVd3BWlRssZgBMyHWxxikTMYuksoy4on83sU
	 D757dO9dyhlhw==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 14 Nov 2023 00:16:16 +0100
Subject: [PATCH net 4/5] mptcp: fix setsockopt(IP_TOS) subflow locking
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-4-7b9cd6a7b7f4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pGUcGEjXJfFkLWEJhM/HAjyXejyxjQ+RM/5QKnxNKLo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlUq5aSKHTJBWyN67lqxuWcs30vPDduo09h2qxF
 iS1s9AGWJOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZVKuWgAKCRD2t4JPQmmg
 c0n6D/9EtGTPQOu6+y+C+gD0tZW1tXp+SwlDwByKowUFh9faPZJKImn6tNpf1WF7mBHFNkmskoi
 nfHH6DzgCev+0xD/Dgytfz/b0nOSoLc46Bg59GySj9YBU3cuMshs8X3YQsWN8WoMEwZrMMHZSL5
 rX50bjvbZUHsfJpniwbS419CtzHwO1fSz4i9JuSQObSuRRe6zmYXWgrWGFVbVx7Zw+2h5hK1cTy
 GAL1fqI5E1oFmGfymAtW6zU4XOolSMUbxNOKGv27bLhKMB8Ifb5v4mhcBG6PbszA7Ju+bcpQ/v4
 tBPwvptoSPQTC0+s0LgfeXkexwQPMxUnWXVPVIhbc3QyFKZBi4ELBJVcg1SMn3AwG+ZvEhJiRxQ
 UOXd3+r0Hbyq5cILSrtJDdFnwJkkn7suxvYt0zSI0JUntO31po3qof9HO7LCsWlIgxk8Ywz7Itz
 CS5sYwemEcT3fVxirExCrHsMRf+hCj+9FB7qimQqy8ACYawckRLxOcd6E31s2d/3QS4ZcVrk+pj
 QwK+QcSIz1jNrjj4jcCrXpBXY46qs771Qob/jz5tGkVn0w5rtQM0LzVR9h8sLvOZObnK51PNVt9
 LI3FQH8SAf8waY/hTWnoy4AZBfZAOOtFtMpc0s4/nffEaeSSdyjHdYxFH5ttfjCZafxRyxpIQCi
 zs6yIRsZaIbJd/Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP implementation of the IP_TOS socket option uses the lockless
variant of the TOS manipulation helper and does not hold such lock at
the helper invocation time.

Add the required locking.

Fixes: ffcacff87cd6 ("mptcp: Support for IP_TOS for MPTCP setsockopt()")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/457
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 77f5e8932abf..353680733700 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -738,8 +738,11 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	val = READ_ONCE(inet_sk(sk)->tos);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
 
+		slow = lock_sock_fast(ssk);
 		__ip_sock_set_tos(ssk, val);
+		unlock_sock_fast(ssk, slow);
 	}
 	release_sock(sk);
 

-- 
2.40.1


