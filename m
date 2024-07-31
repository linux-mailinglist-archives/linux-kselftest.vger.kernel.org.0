Return-Path: <linux-kselftest+bounces-14533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E57942CC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 13:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5361C209D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 11:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269971AED2B;
	Wed, 31 Jul 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9O1HjEJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2B1AED20;
	Wed, 31 Jul 2024 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423983; cv=none; b=slBkKyU5sLP/YN4z70l6TKaR5KR+dMcO1hI4IjefZ4C/gf1e3UqoInTSzkqM1yp28gLyikjKDilYkbnC5eAZJvvYvaqWUWnEprJa+N6ksLg+F00GJ0zfXGFDDi7Re1VEnJ5Y5hP6VZ6vRGCzRClFia9FS7f8B/2EkEInpP1oxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423983; c=relaxed/simple;
	bh=soS1IItRiwvU3ZcudsCwRfsm4gIP9t7k7P3OTrfne/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndV5SROreFfCzdH5UaBBf9AovB2CeBqFobqSJ0UK8Lt1+0YcYsl/H3SCO/YdHZ5IrgL42evNtx0ETKsgFpHt8WQya3yNGm0C81c2GHtVA4gGeM3Jqzi+A2JkL8sKVltXqAfnaoFAriG/cCl4mwJXEtkNvqCe9KCEIfz3IEP5+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9O1HjEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C653C4AF09;
	Wed, 31 Jul 2024 11:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423982;
	bh=soS1IItRiwvU3ZcudsCwRfsm4gIP9t7k7P3OTrfne/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J9O1HjEJYfO+Lvvf5oFcLPjzi1LUc0Vgu92YmIIkaoxiG9tsu5hJXUQJwYzmjHSGe
	 pB3euWZxDGJSWXdr1tUjNb9psKcxILhUdwfCAREaEwzwzvwbyUQ3iYH8Sn+pdmK7d3
	 ZOLPlW9wJtzwz6JZzWeolCAVolHVeWG49V2zEylj7lxLBsM6aVHiNIR9/b3R/EsKmR
	 dFImaOU7jBio8HTo+c7pWebe5TN8JR9L+984O+wuPUAxKizegQMfSkFt7B/g98/gTc
	 d7KShE0T8nXCsAZKF9XRnNRKEUNI1W7nByp4WiMq7hcuU/vf41sIS23KaqXHuCrV9U
	 xi3QzVsx9xZ0g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jul 2024 13:05:55 +0200
Subject: [PATCH net 3/7] mptcp: pm: reduce indentation blocks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-3-c8a9b036493b@kernel.org>
References: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-0-c8a9b036493b@kernel.org>
In-Reply-To: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-0-c8a9b036493b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=soS1IItRiwvU3ZcudsCwRfsm4gIP9t7k7P3OTrfne/k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmqhqiNZDjMzEbvK6znw3TvawjCFq4p2dY7gQaM
 LGj2wO/O4eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqoaogAKCRD2t4JPQmmg
 c5BLEACUSAZDLIvcllvvIGr6OYFIVspsg8xLHr2ouEyUlYAKa/hl1p94ivC12DKB2/qkm/i21QN
 qJ0a9KWxyRnzuvUCw9Irzfqq9VCSTRhSOviExSSFEXOtMuny/Q7qo5k7734O7jQDORqWux7Tis5
 BGOK5botmN1Meen2SLD0A0qLhuEy363JCnt3SevbGUwbysi8l0F3UNhT5iXhBY7N3OytnPWnddZ
 xV3bQ5+cHYdQP4L6SnBf8hdljdplgs1B4Ci+rTk3WcztK641Q2M8Pm0HAblyYnqpUhOHG1TTcXu
 DTu1FejDhS7go/LN5u0jBj2WYuK4rwBVCRPNLHyrQ1wVcqXXUqq4YiAl660CzUFi9aiR47kR0d3
 QyOxHzjvsvWjMuwGLDRs4ZBRI6F60eaLdhxT5rPhMtBJyzL5hbRdbzvUnbZ197eR5P1QuGlVByF
 jPevRAIMMN1cK5GTRa4XqE2O1Ay5V9oYuUBpdvISYy02Yao7ovtFBkki9VK8/dz1jiR/7Zg6tUh
 bdd6qa/M8KDXzfqep+p8YDXRYhp9tRC7U80k7l/SL5c9M7FaoUtYUUxw5nX3E/YJ8ynV4PdmUv3
 Oog83rht8PMajvaAOX04qVFl2pN78TZDrAy9pXcd0xE4HF+nFPWQA2X2q3/LYMeayB2eBK6PIb3
 Ru1TErPI9h+ffWg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

That will simplify the following commits.

No functional changes intended.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c921d07e5940..780f4cca165c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -567,16 +567,19 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
-		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
-				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-				msk->pm.add_addr_signaled++;
-				mptcp_pm_announce_addr(msk, &local->addr, false);
-				mptcp_pm_nl_addr_send_ack(msk);
-			}
-		}
+		if (!local)
+			goto subflow;
+
+		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
+			goto subflow;
+
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		msk->pm.add_addr_signaled++;
+		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
 	}
 
+subflow:
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < local_addr_max &&
 	       msk->pm.subflows < subflows_max) {

-- 
2.45.2


