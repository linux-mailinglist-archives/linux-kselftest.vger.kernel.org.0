Return-Path: <linux-kselftest+bounces-45248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B606EC48883
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 19:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3540A1888146
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 18:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606732C92A;
	Mon, 10 Nov 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR877Em7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8133F328622;
	Mon, 10 Nov 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799056; cv=none; b=euXCRpEYvQzC3yfUTzJkfe6CeTzyhsxk87z67oRgkCAiZ4Mg4fqR9QcZd6F61S89bmRizKn5LQrL3aKTdXcV4exMIJThikDF6bWmxbjTNdEIwwyWYHYy7TetwuEm4vDG3LG6Cid3cbuVy1SDYbJb+YgQbu1PmukETG/EB53W2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799056; c=relaxed/simple;
	bh=/xQ8ASAESSyjnLeK3jPf5wYdRgTYOmQMlj4qSPa8Gdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2dPJjabTQbJ21nL1a4+0gnyUCUCbJf9oQMGBHYOpHwciN2azlZDJJ+YWPTmitXEp8rJKMJGHbBeKNYmMAJHe1nScHrvlvvLF0MBVDM1VVB4ExbxRYRIKqv6exa3ZsBbT3HnQAdWmBV7YFXR4aLleTvYGCPSTLVuxFqUD+r1qfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR877Em7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B169EC4CEF5;
	Mon, 10 Nov 2025 18:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799056;
	bh=/xQ8ASAESSyjnLeK3jPf5wYdRgTYOmQMlj4qSPa8Gdo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mR877Em7C69YAKB7SIQIeG16R0D20FR/xyHZVkTxsDAAlbMf9NVgQ0aGXt+1qslUV
	 dbe2r5kGQSSmnsfIMXHeJA9ouhZAo/xdfqvX8XMri12Oj6UsYaNgWqWQT0Bp7/6Fqv
	 Gx3GhN/yGLKkiwayhduhhdTxsOspOcqPcOrMZ1UrWXDGQ+tux1nLdF/kiKH1o18Z8b
	 4d0HxF3gJxPFaBBLRTpy7vBNQtsWSKm1pzcnqgIWo6ZCxO+mCM/uIL2wgWX+tgT5xa
	 QkwpwI/YrtgGK5XxyWBGhPyEbjp6Slac/RngtHn+Wn3zu6DLrjTudWUxFsw0aDsM+C
	 AT5sdZGxoloeQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 10 Nov 2025 19:23:42 +0100
Subject: [PATCH net 3/6] selftests: mptcp: join: endpoints: longer transfer
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-net-mptcp-sft-join-unstable-v1-3-a4332c714e10@kernel.org>
References: <20251110-net-mptcp-sft-join-unstable-v1-0-a4332c714e10@kernel.org>
In-Reply-To: <20251110-net-mptcp-sft-join-unstable-v1-0-a4332c714e10@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2819; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/xQ8ASAESSyjnLeK3jPf5wYdRgTYOmQMlj4qSPa8Gdo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKFdA+s+/86+LEAg3bXDNZ3eizrVtwIOHG1Sf3L9wb+J
 4wG11/N7ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIqjgjw6UQPrfcieJ7X25M
 3VXB0+SmUNIv8WX79KpF2hLf2K62MjD84dsSaR/jxpd0/uKkvISN8q2FnCqetfm9zyQCOtq4/jx
 mBwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In rare cases, when the test environment is very slow, some userspace
tests can fail because some expected events have not been seen.

Because the tests are expecting a long on-going connection, and they are
not waiting for the end of the transfer, it is fine to make the
connection longer. This connection will be killed at the end, after the
verifications, so making it longer doesn't change anything, apart from
avoid it to end before the end of the verifications

To play it safe, all endpoints tests not waiting for the end of the
transfer are now sharing a longer file (128KB) at slow speed.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Cc: stable@vger.kernel.org
Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
Fixes: b5e2fb832f48 ("selftests: mptcp: add explicit test case for remove/readd")
Fixes: e06959e9eebd ("selftests: mptcp: join: test for flush/re-add endpoints")
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9ed9ec7202d6..97af8d89ac5c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3943,7 +3943,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		{ speed=slow \
+		{ test_linkfail=128 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -3970,7 +3970,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		{ test_linkfail=4 speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -4048,7 +4048,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		{ test_linkfail=4 speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -4121,7 +4121,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		{ test_linkfail=4 speed=20 \
+		{ test_linkfail=128 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 

-- 
2.51.0


