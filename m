Return-Path: <linux-kselftest+bounces-45249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840F2C48898
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 19:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACFC1887EFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 18:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6473332D0DD;
	Mon, 10 Nov 2025 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sgt1RKYY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A1832D0D0;
	Mon, 10 Nov 2025 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799059; cv=none; b=LZXi+mt3xFCpFgQHLYdSbpnqeR30o+cbgz9UDEtaglfFTDPeISCVVziZCbZUbDz3Zw9UDYpNdD00X4DX0xM0So5bnLbKYwYxYWHdPuerkf7Kpb6Dzd4liCrs8KecvxPMd7NGWumr43ThC40jj6T4IWYe2X/iVW2Gr+3lcQuQLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799059; c=relaxed/simple;
	bh=eF6ZSd0wL/kbIM1jEfkTaig8f/aSf92ohx/PwKJfO30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lfn5DGnTPhc6K8q8F/lrY5gYVDH0HHcXZOADYJJ70ZlPiVx0qFONua90BpPWIebPyLNSuT1LGQBL3UOvTMH5g5EBuH2nhBuZoILZNhZTn9XcVbijFV2Vmy6LOR/D35/4cKT+p+62zUXeRUkd2POnqAH5m5H5XlHsgRe+WrArmfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sgt1RKYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1C7C4CEFB;
	Mon, 10 Nov 2025 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799058;
	bh=eF6ZSd0wL/kbIM1jEfkTaig8f/aSf92ohx/PwKJfO30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sgt1RKYY3dNzEb1G8aOm0ejx20YMMcL8nic8DllNr2JhO//Qy0cyuf/sywSCfv49y
	 tE/RSvLDpbfHnPjyrhm6cp+cYVFFY4MjWtU+/l9euM1bxQEsBNTDwwDc6LZJ3Slvj2
	 Hm1SOZznmVgtX6o8FiIqGR5Y582kwAYQ5H12Q8UTp89wh63IOoMc/SE6xcAPHUGPkQ
	 hTvDuOlgAdbIyfkQpKoU5AHuG83fiIzvJLqTyqhaq03jdvnFFcBmL+LeVIur0KbpJW
	 GOb7N2to8cFPALp07DOzmbHLoeiQl9gGuOfnDQCH2IlrshrXfsSjY+IFgrwFiOih5a
	 PD3hm/1cQ1HyQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 10 Nov 2025 19:23:43 +0100
Subject: [PATCH net 4/6] selftests: mptcp: join: userspace: longer transfer
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-net-mptcp-sft-join-unstable-v1-4-a4332c714e10@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3013; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eF6ZSd0wL/kbIM1jEfkTaig8f/aSf92ohx/PwKJfO30=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKFdA9t77v/qVLQ/XWOuqaq+odZ7x3bPp53i1GYkL+lR
 2iKuGd/RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEScJjL8YqpjLm352cj3/Wpp
 U+bp2ZJ8MzRvPeg3nrKHsaSG6dofZoY/nNGNU/rvVy311ni57Y7cw9MLmx+X7HRs+BXMom7fp/i
 OEQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In rare cases, when the test environment is very slow, some userspace
tests can fail because some expected events have not been seen.

Because the tests are expecting a long on-going connection, and they are
not waiting for the end of the transfer, it is fine to make the
connection longer. This connection will be killed at the end, after the
verifications, so making it longer doesn't change anything, apart from
avoid it to end before the end of the verifications

To play it safe, all userspace tests not waiting for the end of the
transfer are now sharing a longer file (128KB) at slow speed.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Cc: stable@vger.kernel.org
Fixes: b2e2248f365a ("selftests: mptcp: userspace pm create id 0 subflow")
Fixes: e3b47e460b4b ("selftests: mptcp: userspace pm remove initial subflow")
Fixes: b9fb176081fb ("selftests: mptcp: userspace pm send RM_ADDR for ID 0")
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 97af8d89ac5c..01273abfdc89 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3806,7 +3806,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 2 2
-		{ speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1
@@ -3839,7 +3839,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		{ speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
@@ -3867,7 +3867,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		{ speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
@@ -3888,7 +3888,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		{ speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
@@ -3912,7 +3912,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		{ speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1

-- 
2.51.0


