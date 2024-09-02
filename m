Return-Path: <linux-kselftest+bounces-16943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8415E968526
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3EBB26498
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0557B1D54C6;
	Mon,  2 Sep 2024 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3hYHyu9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7CD17BEB2;
	Mon,  2 Sep 2024 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273987; cv=none; b=oXtEZS92tlT5VItepQht1jEhluJ+xo1aHhxEml4yZFVu3RWWpq98GzyCnPxyEJhfTfIjVDbutkKTAHr1NDkrMJr33YrQsH8FEI8HZGGvrNTUOxyDgfu4oX0ZsW4rQtrBLESFPBcwZVR1U7adjtvc5booguqwNydaLj7Rvh15ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273987; c=relaxed/simple;
	bh=ZY9zZaWNbVt54txYJGS4lxZ2J2RcmPqPjJsO2UzD9RU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bBVNxoo/bxPfFLB2sa/y+UU7xu/AldAiwbpmjq1JWDrt4KV9ZOsipUxFqCy7hJlUSFVhwxItcZKGQ43v9PW7VtgXRqtQalFLPKJd1Q8TNoZ6o1X6qU6YvqF+uwt6JwXb33YtoRdr7f3UUyknhy6UIZE+OXfI0cEDIlJUChVya8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3hYHyu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140FFC4CED4;
	Mon,  2 Sep 2024 10:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725273987;
	bh=ZY9zZaWNbVt54txYJGS4lxZ2J2RcmPqPjJsO2UzD9RU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I3hYHyu9Er1eJbWXCCkBK8FnEYP+8Fl+8MTEigUe6jbg88mphYvEEQenHIpaeuORg
	 t4sWbkunCaSbm7ffdYlmEZrzzBd7z9q0triVAff3/k4Y9xH09vjWprfaWxI05iV3v4
	 ok9OV5K5tKZ07s+m+EX9x8IQ0kf5l7Lg0x5iz4VTEZ2/nO8NsAa2dshAN50ZEyBxvy
	 ipOXWMgIPdcazSZcDHz84+FAOPrbzj7e7xqMxEFNOziEG+bfiDtTgEXzWsiTEgQnxB
	 yJPADlzLpef954F1R+8FrtAwcP9ANYYNeLLvvG/5lAVWF+bXN/tctjmzKYKuLRfS+H
	 BPxexM00RpgMA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 12:45:57 +0200
Subject: [PATCH net-next 06/11] selftests: mptcp: join: validate MPJ SYN TX
 MIB counters
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-6-d3e0f3773b90@kernel.org>
References: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6034; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZY9zZaWNbVt54txYJGS4lxZ2J2RcmPqPjJsO2UzD9RU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1ZdtZqJfbARCE4TrElYcQ4P9oCW5/KmhCTEDP
 EwHJ0dVkA+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWXbQAKCRD2t4JPQmmg
 c9z+EAC/MNUpYfauS6tpW5dhzLPlvWB9Ms9B0rhFX0wAoHnMoLGh2qA9mYIoIxeODTY5Y5fZpt8
 YY1OA3Je1kUOewTRhjHOPKEcQQJgNC0Vg5G4hF7OYxJqG6pu9A9U9wyiITbg84k3WljDedFxecK
 4/mUEWoKrwRf9emOHIVB81ntd6Bl8GtFIvjm5Ct8sVtxiQ6QqwIOq2nr+3xSP/uqSejy2LFyydT
 L8uojoo6MBZMTpgN68Yal2fMj8ikSBm2//svH+mZ4LotzDgnUrWRbbYwKW0FXVWFmUayAZG/RkE
 XVkGxTFTivBNhMOeO8NxtIm/B12T81Sb74Lsesv8QohZUbxANGJ7VpMjic5ms2RMy5LR/hqjtDj
 HERWFHINfp3FU59QexmMQuee3ltCOHW4XgZeCLG0gpTfWa6JBN+iBvNDHhGrxidu3R0sQKCNR+5
 IMUP9Pood7LBWCYhyBT6vMU25BD53+ReAj7Jq8YnEGB0qrlJiRzZZfbOOsyD5NJJ5nJSKK7hJb8
 4lKvXZRyuAB3iRVr3DUn5d3oCtBCkF5XG7cgPdnr/kgQ1e43s9hmS7ALn6by89wnVtIMSnMGAhG
 YeDOBU6AlYT4idviPybxe6TquVx9XJXm4NaA2nJoc9FdB09AIQwbGFJDaO0Rx4XTf1LvliV8WAD
 8WbhoxqLJ7BsrKQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few new MPJoinSynTx MIB counters have been added in a previous commit.
They are being validated here in mptcp_join.sh selftest, each time the
number of received MPJ are checked.

Most of the time, the number of sent SYN+MPJ is the same as the received
ones. But sometimes, there are more, because there are dropped, or there
are errors.

While at it, the "no MPC reuse with single endpoint" subtest has been
modified to force a bind() error.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 89 ++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 63580a5810bf..23f8e2254064 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -67,6 +67,10 @@ unset join_fail_nr
 unset join_rst_nr
 unset join_infi_nr
 unset join_corrupted_pkts
+unset join_syn_tx
+unset join_create_err
+unset join_bind_err
+unset join_connect_err
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -1336,6 +1340,54 @@ chk_infi_nr()
 	fi
 }
 
+chk_join_tx_nr()
+{
+	local syn_tx=${join_syn_tx:-0}
+	local create=${join_create_err:-0}
+	local bind=${join_bind_err:-0}
+	local connect=${join_connect_err:-0}
+	local rc=${KSFT_PASS}
+	local count
+
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTx")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$syn_tx" ]; then
+		rc=${KSFT_FAIL}
+		print_check "syn tx"
+		fail_test "got $count JOIN[s] syn tx expected $syn_tx"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxCreatSkErr")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$create" ]; then
+		rc=${KSFT_FAIL}
+		print_check "syn tx create socket error"
+		fail_test "got $count JOIN[s] syn tx create socket error expected $create"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxBindErr")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$bind" ]; then
+		rc=${KSFT_FAIL}
+		print_check "syn tx bind error"
+		fail_test "got $count JOIN[s] syn tx bind error expected $bind"
+	fi
+
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxConnectErr")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$connect" ]; then
+		rc=${KSFT_FAIL}
+		print_check "syn tx connect error"
+		fail_test "got $count JOIN[s] syn tx connect error expected $connect"
+	fi
+
+	print_results "join Tx" ${rc}
+}
+
 chk_join_nr()
 {
 	local syn_nr=$1
@@ -1390,6 +1442,9 @@ chk_join_nr()
 
 	print_results "join Rx" ${rc}
 
+	join_syn_tx="${join_syn_tx:-${syn_nr}}" \
+		chk_join_tx_nr
+
 	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
@@ -1930,9 +1985,11 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.12.2 flags subflow
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
+		join_bind_err=1 \
+			chk_join_nr 0 0 0
 	fi
 
 	# multiple subflows, with subflow creation error
@@ -1944,7 +2001,8 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=2 \
+			chk_join_nr 1 1 1
 	fi
 
 	# multiple subflows, with subflow timeout on MPJ
@@ -1956,7 +2014,8 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=2 \
+			chk_join_nr 1 1 1
 	fi
 
 	# multiple subflows, check that the endpoint corresponding to
@@ -1977,7 +2036,8 @@ subflows_error_tests()
 
 		# additional subflow could be created only if the PM select
 		# the later endpoint, skipping the already used one
-		chk_join_nr 1 1 1
+		join_syn_tx=2 \
+			chk_join_nr 1 1 1
 	fi
 }
 
@@ -2063,7 +2123,8 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
 		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=3 \
+			chk_join_nr 1 1 1
 		chk_add_nr 3 3
 	fi
 
@@ -2231,7 +2292,8 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns2 2 2
 		speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=2 \
+			chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
 }
@@ -2331,7 +2393,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 2 2
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=2 join_connect_err=1 \
+			chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
 		chk_rst_nr 0 0
@@ -2396,7 +2459,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-8 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
+		join_syn_tx=3 \
+			chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
 		chk_rst_nr 0 0
@@ -3703,7 +3767,8 @@ endpoint_tests()
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 6
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 5 # one has been closed before estab
 
-		chk_join_nr 6 6 6
+		join_syn_tx=7 \
+			chk_join_nr 6 6 6
 		chk_rm_nr 4 4
 	fi
 
@@ -3775,7 +3840,8 @@ endpoint_tests()
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
-		chk_join_nr 5 5 5
+		join_connect_err=1 \
+			chk_join_nr 5 5 5
 		chk_add_nr 6 6
 		chk_rm_nr 4 3 invert
 	fi
@@ -3806,7 +3872,8 @@ endpoint_tests()
 		wait_mpj $ns2
 		mptcp_lib_kill_wait $tests_pid
 
-		chk_join_nr 2 2 2
+		join_syn_tx=3 join_connect_err=1 \
+			chk_join_nr 2 2 2
 		chk_add_nr 2 2
 		chk_rm_nr 1 0 invert
 	fi

-- 
2.45.2


