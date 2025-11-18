Return-Path: <linux-kselftest+bounces-45838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B351DC67F29
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F256535CC13
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 07:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328703081D9;
	Tue, 18 Nov 2025 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9fnYbQi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA63081B9;
	Tue, 18 Nov 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450478; cv=none; b=F7Uyqwm9RW7jxTLH6e2MUMT2SXSgzQSPtcNgATHouwFO6sGxESqGaueevMLwNYPx4A4MjExZCRp+kNaQjfV37q3Xc3J6E5NtAKIPuwYmnGePZ4SwRVGAylOPxaQBx4oSaKalCKD8Bc5vA2gbp/t83/F4jX6L+IbqwiSYolPy8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450478; c=relaxed/simple;
	bh=PsNkfnJCyxo7NMXegdzKziVjOZ7caxE9x0t2PWtbAE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYeIN6g1eTA3ztAtGBdRB/z2uuOy6wXnPdoykeqhRH5IAEHOW20MpszSJol4qJmHq3A3R1+dQ4P58V7j3ksDLeBMViv0WdWbUpXVF+gp49mPYya3DxEXjdR5R0E1gZAzCw7LGUpIPzRzrG6JVB0WuefNPPf/4REt8g8tayDL+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9fnYbQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11552C4CEF5;
	Tue, 18 Nov 2025 07:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450477;
	bh=PsNkfnJCyxo7NMXegdzKziVjOZ7caxE9x0t2PWtbAE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h9fnYbQiTrqXQbz5e0DmwT2QMAH62kJNzrPgVvUHlrGMD9hbSoEj6z9MmemiG/NrL
	 DNafV212bhFiPv4EUUVH+WE64Q8p7jYf9IBvCc9ZX2Fzj0K1USfse2lKkwsgWP423l
	 vLsWrsy9JkCy27sl6ddMrYdyhwsLhd9JbPDMcKMLsRFKz4j0EC67QQyqNj34U0N3Dy
	 HSSXUcec8aRVvtYwhQGvtgkWgNXjTxJSRTpLW2V1nrf497QgBff1eRCXLUFO+fQire
	 DUNaKNI2zMG+N2fAGdi2McwFIY3p6ILB+B2ZdqPWiWXUblNKzZvIBEVjPWIiZ15Egw
	 1mhui04l+7MzQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Nov 2025 08:20:26 +0100
Subject: [PATCH net 08/11] selftests: mptcp: join: endpoints: longer
 timeout
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-8-806d3781c95f@kernel.org>
References: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
In-Reply-To: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2833; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PsNkfnJCyxo7NMXegdzKziVjOZ7caxE9x0t2PWtbAE8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJl5Pzc1Zc7qFcsml75dsuOLS7LnfrCVwSvenL1QPc2p
 RSpUpu4jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIk8fMPIsFX0drOw35wpkXsM
 Yw6F9bktWKHz1biGZ7d3gd9r63U6mgz//XP2nyhc5yba/P7/zzm6/kXX193J7419178lpcZ5X9p
 efgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In rare cases, when the test environment is very slow, some endpoints
tests can fail because some expected events have not been seen.

Because the tests are expecting a long on-going connection, and they are
not waiting for the end of the transfer, it is fine to have a longer
timeout, and even go over the default one. This connection will be
killed at the end, after the verifications: increasing the timeout
doesn't change anything, apart from avoiding it to end before the end of
the verifications.

To play it safe, all endpoints tests not waiting for the end of the
transfer are now having a longer timeout: 2 minutes.

The Fixes commit was making the connection longer, but still, the
default timeout would have stopped it after 1 minute, which might not be
enough in very slow environments.

Fixes: 6457595db987 ("selftests: mptcp: join: endpoints: longer transfer")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 303abbca59fc..93d38ded5e4e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3941,7 +3941,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		{ test_linkfail=128 speed=slow \
+		{ timeout_test=120 test_linkfail=128 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -3968,7 +3968,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -4046,7 +4046,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -4119,7 +4119,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		{ test_linkfail=128 speed=20 \
+		{ timeout_test=120 test_linkfail=128 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 

-- 
2.51.0


