Return-Path: <linux-kselftest+bounces-39115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3324B28516
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 19:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588F47A8C46
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 17:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFB131065E;
	Fri, 15 Aug 2025 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgyelfFl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6C310658;
	Fri, 15 Aug 2025 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278944; cv=none; b=nO2/zt3MQZrqA3iyQeEqlgRxUZRLszq775NXIi9eMQJr/Uk15v1U0wx5kkARB0ef6oHgRYKt6tir6fXbKLD2JaVVP1w/iKsyvxJzA61WsV1gYh5GzUOmysEKOdRWMj+RGpA+z0Dz0nndq4Ye/WxzFR+AmCDK064KIA5emSPvyps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278944; c=relaxed/simple;
	bh=WgjJaS+rdFhCMCImcMRpi0vO9gmWRJGFBiZz38gakh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZ6KQO2YiiZts7+/Yhfv9AULHFIO4yY9DrXFiGcmv6iEiSIwD+pjbJMekwczH+9aqh2z2DgqGKFcfTjw3iyIrX/5xLza/5rN8mPsuyRkSHdezgq3U18tQEIuTBbDbVmte5zpmNoWw3OfRrtn/jxJChN3ku8HDZ7kXRgtYZIH+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgyelfFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6E5C4CEF1;
	Fri, 15 Aug 2025 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278944;
	bh=WgjJaS+rdFhCMCImcMRpi0vO9gmWRJGFBiZz38gakh4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hgyelfFlCiapEJQNA9mFHrdPA8aW41S2aGp0mbWeQml5A5PN+W8chHXKESwY1xCva
	 VfBscPxohyQbQ9yZfXiz+MXr2Q3/bR8gUkyGGHkN/1KoFR5kCHYl0KE0ZNX0wrwCrx
	 lvDDh6J/WhAUx9v1ae5wWkqS7PCihH+EVnGUYKizNc6hUlF/EBQOrabDjC88zOHmHo
	 X28e4bFeAStvveq2bXzoQmGlf/r6pNM+g9YInoYlA2zdOkyPlrIUbhe1sLxO+lM3E4
	 PSyhZskiu4jbuOvd0wh2e62T8BhG7SSP63snf5JGrWLaXcINd4rDveYIYXOYl9cocB
	 VqkSIIZNxNQAQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 Aug 2025 19:28:23 +0200
Subject: [PATCH net 5/8] mptcp: disable add_addr retransmission when
 timeout is 0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-5-521fe9957892@kernel.org>
References: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
In-Reply-To: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jianguo Wu <wujianguo@chinatelecom.cn>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, zhenwei pi <pizhenwei@bytedance.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3042; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=m82o899n5rC/GDPYqz458xzlkCJvdREvDViuEaEDHUA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLm57nZrN0S13TIvylki/Jes33t5o7zf+St1T/K/Oyn0
 dVv4jWfOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACaS9ZKRYZL/rLj73woa5Vp/
 612cJ6tw7cHONv/cr0/UnwrH3Y3iZGf4Z3XZ5LfdWlWRMK5TGX9+/t09QX3FYrtG5tTm68H151z
 38AEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

When add_addr_timeout was set to 0, this caused the ADD_ADDR to be
retransmitted immediately, which looks like a buggy behaviour. Instead,
interpret 0 as "no retransmissions needed".

The documentation is updated to explicitly state that setting the timeout
to 0 disables retransmission.

Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
Cc: stable@vger.kernel.org
Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst |  2 ++
 net/mptcp/pm.c                            | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 5bfab01eff5a9db89e1484787953241c16e147cf..1683c139821e3ba6d9eaa3c59330a523d29f1164 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -12,6 +12,8 @@ add_addr_timeout - INTEGER (seconds)
 	resent to an MPTCP peer that has not acknowledged a previous
 	ADD_ADDR message.
 
+	Do not retransmit if set to 0.
+
 	The default value matches TCP_RTO_MAX. This is a per-namespace
 	sysctl.
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c5f6a53ce5f1e10dada52865e41b685d888a71fa..136a380602cae872b76560649c924330e5f42533 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -274,6 +274,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 							      add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
+	unsigned int timeout;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -291,6 +292,10 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
+	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+	if (!timeout)
+		goto out;
+
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
@@ -302,7 +307,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+			       jiffies + timeout);
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -344,6 +349,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
+	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -368,8 +374,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
-	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+	timeout = mptcp_get_add_addr_timeout(net);
+	if (timeout)
+		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
 
 	return true;
 }

-- 
2.50.0


