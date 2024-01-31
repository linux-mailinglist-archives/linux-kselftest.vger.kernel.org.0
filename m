Return-Path: <linux-kselftest+bounces-3895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEEA844A92
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA75D2818C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB3C3BB30;
	Wed, 31 Jan 2024 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9daojn3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21445C14;
	Wed, 31 Jan 2024 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737855; cv=none; b=r7rc6AmH3ibMcWPeD6yLPvzAaf91Oah23SLDNHF4rqZOthVFfLo2bmAT1XAp830il3nvXsRumit4WF3NLZjsU11tdmS+dupWYFYMbA0laIHi4IVtRor09CcPHAywcOzxvcESnNMCNF9Jgm9vxMIUZyHv2xdATbVt6Ia6e6/LYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737855; c=relaxed/simple;
	bh=dx7wRnDCqrDJsKtDK7xNZDoVY35TSIKa32jxbefvqs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rC+MMUVSNmEmmcmB2nTnqp7hY/fNCPtm5mO2ABI3edLAN1N9U1sb7zDrKXp7Fll7R8dNNBTq+5tBxs6Z4UiaBtqPSESlPGh+rl5cbyUhDuFSvfjufBrJp7aHlgeJrF3Jmk0iTXGJfUduTbBgGHJI2VBse5xYLqb/yzS+dzlI8kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9daojn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F93C43142;
	Wed, 31 Jan 2024 21:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706737855;
	bh=dx7wRnDCqrDJsKtDK7xNZDoVY35TSIKa32jxbefvqs8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M9daojn3WbUrsdJtg1dQ9fqgqRcCQUGre2GSemGntl5aSWpQU5Cg6olIjoyK6BM+l
	 5c165+TnyQslNZaV7+qDdLAmgj2ywWw7UcLy+sOsyOUGY3zq/RUjjP0slIdtkw7VQi
	 G4tf8pcPIuZhWNfxqF+9RVVtJwqZ5W2WZGaqscjp5I+987xwjPXVUbyFD41ysnxGqw
	 P1DPLbzEoleACw1NAMJb4hnbfpszLvuS8PKZJGMPJHHROB3QhrXK7ea6Pgx/9OCfD1
	 UdSYUNHrsFurJIZtai8xrRNA7TsopgEi7VvakM01qEA73vOd0NLDz8uCuBW374Put2
	 lacjjKtO7sdqQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 22:49:54 +0100
Subject: [PATCH net 9/9] selftests: mptcp: join: stop transfer when check
 is done (part 2)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-9-4c1c11e571ff@kernel.org>
References: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
In-Reply-To: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3349; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dx7wRnDCqrDJsKtDK7xNZDoVY35TSIKa32jxbefvqs8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlusCg8SsXtieygSIwUgQbQ/KEVDAVd9jBEbaTy
 8Ttrh5Cuf6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbrAoAAKCRD2t4JPQmmg
 c2qWD/sHFGNL8EnWdDMRDcbajqT+mC1/pA+MR1y08Rcc5IrWGV4a36pl0oPJx5GSSsi7WQVReJc
 PtpFb/fS3hK2n5yE6dFvLPCIrUUeEpSQqxkmk/NDrDLyqA3E2Wrz038AxVMdL/POsunfqWsLu/E
 VBH6Wg1SoQ2IgEpU8vnyvgSeybuCIabbIfE1sVYmcKqXVstCTnbrT3CSH7PM3prdPlmxZzMX/r1
 X2+9purLs4XA7Bovfk1gE5velSO/fYCQ590la+fE0XKZatDojZRTXK7WfAWAieeDy/Fo/JRh1jX
 pSq0aOMBBAK4HRJjc5wFERRj+E0BoRLM/ql+sioT2SJTTjbuUonF/44+rG9yk7MpRRcjIN/PDb5
 xUYndv/WmkSvUph2Cl+8kp2hShWtMkgCe7FVodmz3+ZkZ6EXZiXLM8WffRT2N0gidXRHTBDx9at
 gNi6n1En3iqG4edgR9umbcffTADzZimiGZkSboMm1TVDRnMSTZQpRW0pP/jFNrXCRLblpun8wjQ
 q5LUZaxRYiPFnsZRTjBUD5cBgF0IfjezSEOXzE/gjOUVi4x4isI9GO7sZ5aN/7z/mlvKIqjaH0h
 Rf7j8BmGWMqEbt2Gsittp6wMXyOc42/W30j8UPS/f/5UY9pH35Ue+ONoOas9Jj4w/5EGb6Ew/8p
 vzmCCRJFxSng30g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the "Fixes" commits mentioned below, the newly added "userspace
pm" subtests of mptcp_join selftests are launching the whole transfer in
the background, do the required checks, then wait for the end of
transfer.

There is no need to wait longer, especially because the checks at the
end of the transfer are ignored (which is fine). This saves quite a few
seconds on slow environments.

While at it, use 'mptcp_lib_kill_wait()' helper everywhere, instead of
on a specific one with 'kill_tests_wait()'.

Fixes: b2e2248f365a ("selftests: mptcp: userspace pm create id 0 subflow")
Fixes: e3b47e460b4b ("selftests: mptcp: userspace pm remove initial subflow")
Fixes: b9fb176081fb ("selftests: mptcp: userspace pm send RM_ADDR for ID 0")
Cc: stable@vger.kernel.org
Reviewed-and-tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 85bcc95f4ede..c07386e21e0a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -643,13 +643,6 @@ kill_events_pids()
 	mptcp_lib_kill_wait $evts_ns2_pid
 }
 
-kill_tests_wait()
-{
-	#shellcheck disable=SC2046
-	kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
-	wait
-}
-
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -3494,7 +3487,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm remove initial subflow
@@ -3518,7 +3511,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm send RM_ADDR for ID 0
@@ -3544,7 +3537,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 }
 
@@ -3558,7 +3551,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		speed=slow \
-			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint "creation" \
@@ -3573,7 +3567,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
-		kill_tests_wait
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	if reset "delete and re-add" &&
@@ -3582,7 +3576,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 speed=20 \
-			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
 
 		wait_mpj $ns2
 		chk_subflow_nr "before delete" 2
@@ -3597,7 +3592,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 2
 		chk_mptcp_info subflows 1 subflows 1
-		kill_tests_wait
+		mptcp_lib_kill_wait $tests_pid
 	fi
 }
 

-- 
2.43.0


