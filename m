Return-Path: <linux-kselftest+bounces-40908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB86B47C14
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 17:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7F217E031
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CF628369A;
	Sun,  7 Sep 2025 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzC9dVx7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F6F28312D;
	Sun,  7 Sep 2025 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757259189; cv=none; b=V/qNtMU6rX8bZo5H09NZGPKpHgan681YFRWjrzYMaq16N2efAnes0WTnt30c1R9nx7aHKSVbNtksF4ACbUA7M3gYq0uHDYOmIvVNN5CMvvk5piUhbi5Y/4ylyrTRZmwtTO+2uT05ZvdiWz94sjoKNcRWdmZ9/dHTFMD4VrpQtv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757259189; c=relaxed/simple;
	bh=mX9xiuWhw94j6IoO98BR9E5TyWLzVUtyfa496iHMOfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AU0Er7C81id+lxjn3/Hpxd7cMuFmAoFXljp/2Etgs8B0jOcpoG5l0/8sT2CcXgTY4CY0D1rJOupvLfJ9GyZ+kZqKquoYInnwyQgtuOEfqljkG5hudNayF09RiZB6YebfItoV8T4rG/z429fmyLYT7nYh5ke2B4CitiJuHP4ncAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzC9dVx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B98AC4CEFE;
	Sun,  7 Sep 2025 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757259189;
	bh=mX9xiuWhw94j6IoO98BR9E5TyWLzVUtyfa496iHMOfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rzC9dVx7lW95ezuxrk7WM+FGZ0QBDbRgujI6P7svzLvv3PHzqrWV5P9EyztQcGRYU
	 fRJFy2FJfiAwCWlfnDtyuojILb6GhiLm1dQClMFs+8p/TwrmuusB0UAoMq6IgblYyP
	 l+6SnQS6ceEbShltJnPa2GaP/BN0TOq2q5S+sRlfmAD2pCYgMPgYTz0gVzgrhdXd0T
	 P1E/ULY5OD6ekMNXv5l3ourQaUop7VpxetKWut75agREAGX/UygYmB6Ma9U4Ajvdc3
	 utxwUfsuX2RaWc1BqxXhbA0HR8Lwy0KunPTZaMg3ML4xwC/G/pIYD+/NFFQOBA3oXF
	 98zFfF+L4Q9mA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 07 Sep 2025 17:32:42 +0200
Subject: [PATCH net-next 1/3] mptcp: make ADD_ADDR retransmission timeout
 adaptive
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-net-next-mptcp-add_addr-retrans-adapt-v1-1-824cc805772b@kernel.org>
References: <20250907-net-next-mptcp-add_addr-retrans-adapt-v1-0-824cc805772b@kernel.org>
In-Reply-To: <20250907-net-next-mptcp-add_addr-retrans-adapt-v1-0-824cc805772b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Christoph Paasch <cpaasch@openai.com>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4651; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fMWnGvfcxJeoK7vUJLijfKLkoWF3gYKAIXDJbZpQ7lw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL2Ll0trh9xKF9mX0ysWmf/5pl5Pvqft6RklDCUSl59d
 7bXxTi3o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJlLxj+13x59iTi9rPDNp4B
 l/hvyVfe/V1gdOPfnMlzOX967BHr8mBk2B6kHjeTObdzDUuo8bmdJ4smNIZyXG2d86d+YoPF8Y+
 HWQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Currently the ADD_ADDR option is retransmitted with a fixed timeout. This
patch makes the retransmission timeout adaptive by using the maximum RTO
among all the subflows, while still capping it at the configured maximum
value (add_addr_timeout_max). This improves responsiveness when
establishing new subflows.

Specifically:
1. Adds mptcp_adjust_add_addr_timeout() helper to compute the adaptive
timeout.
2. Uses maximum subflow RTO (icsk_rto) when available.
3. Applies exponential backoff based on retransmission count.
4. Maintains fallback to configured max timeout when no RTO data exists.

This slightly changes the behaviour of the MPTCP "add_addr_timeout"
sysctl knob to be used as a maximum instead of a fixed value. But this
is seen as an improvement: the ADD_ADDR might be sent quicker than
before to improve the overall MPTCP connection. Also, the default
value is set to 2 min, which was already way too long, and caused the
ADD_ADDR not to be retransmitted for connections shorter than 2 minutes.

Suggested-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/576
Reviewed-by: Christoph Paasch <cpaasch@openai.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: no changes.
---
 Documentation/networking/mptcp-sysctl.rst |  8 +++++---
 net/mptcp/pm.c                            | 28 ++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 1683c139821e3ba6d9eaa3c59330a523d29f1164..1eb6af26b4a7acdedd575a126c576210a78f0d4d 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -8,9 +8,11 @@ MPTCP Sysfs variables
 ===============================
 
 add_addr_timeout - INTEGER (seconds)
-	Set the timeout after which an ADD_ADDR control message will be
-	resent to an MPTCP peer that has not acknowledged a previous
-	ADD_ADDR message.
+	Set the maximum value of timeout after which an ADD_ADDR control message
+	will be resent to an MPTCP peer that has not acknowledged a previous
+	ADD_ADDR message. A dynamically estimated retransmission timeout based
+	on the estimated connection round-trip-time is used if this value is
+	lower than the maximum one.
 
 	Do not retransmit if set to 0.
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 136a380602cae872b76560649c924330e5f42533..204e1f61212e2be77a8476f024b59be67d04b80a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -268,6 +268,27 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
+static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
+{
+	const struct net *net = sock_net((struct sock *)msk);
+	unsigned int rto = mptcp_get_add_addr_timeout(net);
+	struct mptcp_subflow_context *subflow;
+	unsigned int max = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		struct inet_connection_sock *icsk = inet_csk(ssk);
+
+		if (icsk->icsk_rto > max)
+			max = icsk->icsk_rto;
+	}
+
+	if (max && max < rto)
+		rto = max;
+
+	return rto;
+}
+
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
 	struct mptcp_pm_add_entry *entry = timer_container_of(entry, timer,
@@ -292,7 +313,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
-	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (!timeout)
 		goto out;
 
@@ -307,7 +328,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + timeout);
+			       jiffies + (timeout << entry->retrans_times));
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -348,7 +369,6 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct net *net = sock_net(sk);
 	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
@@ -374,7 +394,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
-	timeout = mptcp_get_add_addr_timeout(net);
+	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)
 		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
 

-- 
2.51.0


