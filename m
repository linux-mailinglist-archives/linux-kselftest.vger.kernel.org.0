Return-Path: <linux-kselftest+bounces-16944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D718C968529
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B73B20E2C
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 10:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED6C1D54E7;
	Mon,  2 Sep 2024 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpeRns8H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A981D54DC;
	Mon,  2 Sep 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273991; cv=none; b=lcFeTEF11oq4h3zVBBdNvfuFJwSeBBth9ZtKLkIctDg9ELB5pIL8lis5R+7s4JwC7cuwmrYIMRqKmUPT6SxzxfptK/CARwta6gQEU9u8HvfcLchmrUXetCcauEFWvVDei1rrT0fCjvHeTk4HzM9CVJOJOZaWOSBPV7w+rGjdqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273991; c=relaxed/simple;
	bh=RjQy6bhiC2D+XOt09U0I3DX7UV2GSih6fnqKazD+QAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4zqE1sZx4i5IU8qauH+Y+VUuXGr5nViFZAaNj7X8NgpTB44+vUPJNMu5W0e/dHcK8Mrk2obo7AbhxKi9m3Z90g+KzCj0IxvAtsEZJ2yz3KaGxSfg5tPFUPLdqMPU1KQUc+DzMxGxMp1NNW5VYyLM3aZEPuS8hTsXm2t/zRN3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpeRns8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25837C4CEC6;
	Mon,  2 Sep 2024 10:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725273990;
	bh=RjQy6bhiC2D+XOt09U0I3DX7UV2GSih6fnqKazD+QAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hpeRns8H4WF0KWYWbxbTAdeUgx3dOjid6fVb+gIg+/VFreZK7HB7maQp3fuRP0EkQ
	 qORG9lcT+OxVKDXcNXFWH7GYP/vCn1KQJyabpUiGHnQLYA4FifJbefh2zgH/oZjbRu
	 l+o+c+F/74zpcdD+oCMbxrDKts/et13o3j75r+araG5AEVEpJmC2qPqnym51BhZdS0
	 fkqtZMKPx7E/KZ32yD4jkhrFr6SMWagk+Y18nyNyRQ7y67wGHyYw9qilhEZj68RZ49
	 2SHosFzkdVYC+dwhzwGnaDSB8nWFkaWo1g5nFm5qUZ4agvdPVLZefVLbZXcNHuhdLL
	 NzhueUvDOqdnA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 12:45:58 +0200
Subject: [PATCH net-next 07/11] selftests: mptcp: join: more explicit check
 name
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-7-d3e0f3773b90@kernel.org>
References: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7942; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RjQy6bhiC2D+XOt09U0I3DX7UV2GSih6fnqKazD+QAo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1ZdtJnEZofCD0jQr9NLgt1DJzF4Z1hsebBDhg
 Nx1X6qn4BWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWXbQAKCRD2t4JPQmmg
 cwDNEACZaqKAVTgUucmVNlmqOXLFfO4kkDGRzBMm2IoSRVR5PB2O2z9H2j2Vi3nSPSr9XLf5qim
 hTKRhQPgXG5cgLZCuIMmAvDXENl4rrFGRS2Py8TR0qSiR0q0eCm/npB/cHVbQAJ/c3XAZYXQMIN
 joln6qReoHCrcQuQvC3IuZ8tnLgbCGoLRWBQaEAXCtfndMI2xb0nK/y2HUMX2weEH2bR2oDWIzx
 LyiCGliLBpc7FUAhWX2hfaQX2jiwBDLD7LYK3icMnCc58zpccEJqtoskBqOsVQBbtNOS8pauzj+
 E6NTaelCUeH50lxUARIqBQLVjwI4ibgdN2J2vMxyFR5XUULcoyV/d4X5FKEgVxzqDHyNZqeKNHs
 cUxjr8da7+uFL5iP4B05Tsce+f6+/PgfANzvAJv4vjlFEJRPVLlaOEsTG9IIEzdF3ZkeLSxTUv4
 M12L3qzkY5iahVRrPaASrZ11vodjU4vSoI5LCWZ/7OuYWS+ghyvHZur77boK3rzMkeA9ZVBB8oX
 BQL+c0PxYtxJCosjiQDosE+7ewJFgiuy8So4WmGps4H/DiBxNA5pL95VXA9zeweHH9HQQ+1drnd
 h2BD3VkyTl1w1sd3kHm/LUp3y2Wq5mBGMxzlulnw2fta3l25xfxpuxXA4+tZ3MxmhhVvTnKEPcc
 hxFFfcwBLIVPl3Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before, the check names had to be very short. It is no longer the case
now that these checks are printed on a dedicated line.

Then, it looks better to have more explicit names.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 65 +++++++++++++------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 23f8e2254064..7993e0e0029e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -865,7 +865,7 @@ chk_cestab_nr()
 	local cestab=$2
 	local count
 
-	print_check "cestab $cestab"
+	print_check "currently established: $cestab"
 	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1141,7 +1141,7 @@ chk_csum_nr()
 		csum_ns2=${csum_ns2:1}
 	fi
 
-	print_check "sum"
+	print_check "checksum server"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ]; then
 		extra_msg+=" ns1=$count"
@@ -1154,7 +1154,8 @@ chk_csum_nr()
 	else
 		print_ok
 	fi
-	print_check "csum"
+
+	print_check "checksum client"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ -n "$count" ] && [ "$count" != "$csum_ns2" ]; then
 		extra_msg+=" ns2=$count"
@@ -1198,7 +1199,7 @@ chk_fail_nr()
 		fail_rx=${fail_rx:1}
 	fi
 
-	print_check "ftx"
+	print_check "fail tx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
 		extra_msg+=",tx=$count"
@@ -1212,7 +1213,7 @@ chk_fail_nr()
 		print_ok
 	fi
 
-	print_check "failrx"
+	print_check "fail rx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
 		extra_msg+=",rx=$count"
@@ -1245,7 +1246,7 @@ chk_fclose_nr()
 		extra_msg="invert"
 	fi
 
-	print_check "ctx"
+	print_check "fast close tx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1256,7 +1257,7 @@ chk_fclose_nr()
 		print_ok
 	fi
 
-	print_check "fclzrx"
+	print_check "fast close rx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1286,7 +1287,7 @@ chk_rst_nr()
 		extra_msg="invert"
 	fi
 
-	print_check "rtx"
+	print_check "reset tx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1298,7 +1299,7 @@ chk_rst_nr()
 		print_ok
 	fi
 
-	print_check "rstrx"
+	print_check "reset rx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1319,7 +1320,7 @@ chk_infi_nr()
 	local infi_rx=$2
 	local count
 
-	print_check "itx"
+	print_check "infi tx"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtInfiniteMapTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1329,7 +1330,7 @@ chk_infi_nr()
 		print_ok
 	fi
 
-	print_check "infirx"
+	print_check "infi rx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtInfiniteMapRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1412,8 +1413,8 @@ chk_join_nr()
 		rc=${KSFT_SKIP}
 	elif [ "$count" != "$syn_nr" ]; then
 		rc=${KSFT_FAIL}
-		print_check "syn"
-		fail_test "got $count JOIN[s] syn expected $syn_nr"
+		print_check "syn rx"
+		fail_test "got $count JOIN[s] syn rx expected $syn_nr"
 	fi
 
 	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
@@ -1426,8 +1427,8 @@ chk_join_nr()
 		# the subflow creation
 		if [ "$with_cookie" != 2 ] || [ "$count" -le "$syn_ack_nr" ] || [ "$count" -gt "$syn_nr" ]; then
 			rc=${KSFT_FAIL}
-			print_check "synack"
-			fail_test "got $count JOIN[s] synack expected $syn_ack_nr"
+			print_check "synack rx"
+			fail_test "got $count JOIN[s] synack rx expected $syn_ack_nr"
 		fi
 	fi
 
@@ -1436,8 +1437,8 @@ chk_join_nr()
 		rc=${KSFT_SKIP}
 	elif [ "$count" != "$ack_nr" ]; then
 		rc=${KSFT_FAIL}
-		print_check "ack"
-		fail_test "got $count JOIN[s] ack expected $ack_nr"
+		print_check "ack rx"
+		fail_test "got $count JOIN[s] ack rx expected $ack_nr"
 	fi
 
 	print_results "join Rx" ${rc}
@@ -1517,7 +1518,7 @@ chk_add_nr()
 
 	timeout=$(ip netns exec ${ns_tx} sysctl -n net.mptcp.add_addr_timeout)
 
-	print_check "add"
+	print_check "add addr rx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1529,7 +1530,7 @@ chk_add_nr()
 		print_ok
 	fi
 
-	print_check "echo"
+	print_check "add addr echo rx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1540,7 +1541,7 @@ chk_add_nr()
 	fi
 
 	if [ $port_nr -gt 0 ]; then
-		print_check "pt"
+		print_check "add addr rx with port"
 		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1550,7 +1551,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "syn"
+		print_check "syn rx port"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1561,7 +1562,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "synack"
+		print_check "synack rx port"
 		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1572,7 +1573,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "ack"
+		print_check "ack rx port"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1583,7 +1584,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "syn"
+		print_check "syn rx port mismatch"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1594,7 +1595,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "ack"
+		print_check "ack rx port mismatch"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1618,7 +1619,7 @@ chk_add_tx_nr()
 
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
-	print_check "add TX"
+	print_check "add addr tx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1630,7 +1631,7 @@ chk_add_tx_nr()
 		print_ok
 	fi
 
-	print_check "echo TX"
+	print_check "add addr echo tx"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtEchoAddTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1668,7 +1669,7 @@ chk_rm_nr()
 		extra_msg="invert"
 	fi
 
-	print_check "rm"
+	print_check "rm addr rx"
 	count=$(mptcp_lib_get_counter ${addr_ns} "MPTcpExtRmAddr")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1678,7 +1679,7 @@ chk_rm_nr()
 		print_ok
 	fi
 
-	print_check "rmsf"
+	print_check "rm subflow"
 	count=$(mptcp_lib_get_counter ${subflow_ns} "MPTcpExtRmSubflow")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1713,7 +1714,7 @@ chk_rm_tx_nr()
 {
 	local rm_addr_tx_nr=$1
 
-	print_check "rm TX"
+	print_check "rm addr tx"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtRmAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1732,7 +1733,7 @@ chk_prio_nr()
 	local mpj_syn_ack=$4
 	local count
 
-	print_check "ptx"
+	print_check "mp_prio tx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1742,7 +1743,7 @@ chk_prio_nr()
 		print_ok
 	fi
 
-	print_check "prx"
+	print_check "mp_prio rx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioRx")
 	if [ -z "$count" ]; then
 		print_skip

-- 
2.45.2


