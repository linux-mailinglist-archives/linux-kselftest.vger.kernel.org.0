Return-Path: <linux-kselftest+bounces-16945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD57296852B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1021F24802
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678FF1D618B;
	Mon,  2 Sep 2024 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaBAj9Ln"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C681D54FB;
	Mon,  2 Sep 2024 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273994; cv=none; b=cLL/1Za+w7taFCxU8fahyRqS1e8YA86tv9qXG8iX/5Se5NySIxT1LMa9X5h7d3J7RYIsU8ZbLikBb12qaB49yfioadSqKMr+cRfEO4gf/n88lObXVbkp5Ti/WzTvfZRfT4YUFVZ150zRoPyBxRolpu7hB4qOu6N1Pu1797KXPio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273994; c=relaxed/simple;
	bh=epCAipyYDn9gymi3xegOuqC9Tr8hGUkB6xYywrz6Qxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I5q7qWDmf5nT/3cXz/KyjrgGpddNBYj0NIbCPUkjXHtCx0p6KDXW8o0DisiFGBRABpix3ZwAuYqhU4Gie0QOsAI3VXGdnE7QlDJg+iVnk2HWD3rmTS/TKA7VpBXWeonvumrzpGb2exuW+fkgqaNj9FRIxjR4CcByP66ju9QtXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaBAj9Ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EA3C4AF0F;
	Mon,  2 Sep 2024 10:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725273993;
	bh=epCAipyYDn9gymi3xegOuqC9Tr8hGUkB6xYywrz6Qxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VaBAj9LnCGl5Se5anmdSLiTjmIIFI2QTkxJkDWNFSu5PInGip1rcEMeSJdmbnaImx
	 VPgQEeTXOckWIIM7ry/zps+Kj2rMcWIMDpBV0CSlUzM9Cz3v0JLjPRjm7TBhEb9mm5
	 b6L5rGKM95sVvEgSsvNatTQtL6bHxLJ87hT6Kbv8HKPcg4Q1/A5tHoFyYf7rDtaJQ8
	 dRbqw3mz9vte74AyZQEoC4/isRtGpt6ddk/5zY559bf+nrequA1QZSWbbfnsDLE8qJ
	 EFqtqeeJiHd803Zjer//9WEcJI/J9aRM73QgJsSE9fAmVXgciDTXSiBaF6q1DVE/Ug
	 K4xyg5rmTpT1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 12:45:59 +0200
Subject: [PATCH net-next 08/11] selftests: mptcp: join: specify host being
 checked
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-8-d3e0f3773b90@kernel.org>
References: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8724; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=epCAipyYDn9gymi3xegOuqC9Tr8hGUkB6xYywrz6Qxg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1ZdtDNEbWDeGUc8/QnFz8uxnCjirbuWfNn+Tr
 0koGxsdHEWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWXbQAKCRD2t4JPQmmg
 c0x4D/9uLEm4fi7NfqgU2xrywf6J9HUZZLeZ1Imh5xMdJmZIyND97PI5zDDABt4fcXuGptPPxqx
 MQ/dcJeRNnHPnNmrceMRAFaG2rmwXBM3Di0Y1mFUxtF2mM5HYKO+eoJ1rxsPTOsTsqxaVM+yK5S
 Th3GhddFmBJprjjXxJUkFYSJgnhP6Vumb6MiUP38Xaq0OhT5i3eo/J5k9xahK4Ssxf94KzjTcku
 V/I/dn3xKoFv+PWWHSEvgaYuCwpp3H/O4zrW8W/Vv3oUvdgdVju1ejczF5GJfnSH/wzqYCXwwID
 6EbgWKsPYoyvQs0wkZ9bq9aJ1V3HRWxFm/v4vs7Ou1udfCWnTypa+rnX5WpdBORf0orG2+LNi4b
 2WnHFrtbfbB7A3OJ8lGAWqDpO+el4aRGFziMw9jfPPCkqDs/S2sXPx4rP9JKyYKjPrqxbVjFLCH
 6mMFDMsxv0tngPBHjNtkwFyGG14Do48dDJORWLPAjnoimOsdEr0pgnz0Wby+9X7nTvUg41xC9zd
 FKLnofA6MF00A03mlHc1ouk8ivHXyWNdpfGHmgFTKgkcGzb5hdtYrPSVq0EEGYNbgbBsdHgeHBs
 RLGxHGzkySjfHD3qL39ARq0DeMCjMP8+1dHWVpr/+GxioPND25t+YVW6Cxc3rX4i7XV+XzslXXx
 Madqe/LeWR7GzUA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of displaying 'invert' when looking at some events like MP_FAIL,
MP_FASTCLOSE, MP_RESET, RM_ADDR, which is a bit vague because they are
not traditionnaly sent from one side, the host being checked is now
printed.

For the ADD_ADDR, only display the host when it is the client sending
it, which is more unusual.

Also before, the 'invert' message was printed after a few checks, but it
was not clear which ones exactly.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 89 +++++++++++++------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7993e0e0029e..321197d8977e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1180,6 +1180,8 @@ chk_fail_nr()
 	local count
 	local ns_tx=$ns1
 	local ns_rx=$ns2
+	local tx="server"
+	local rx="client"
 	local extra_msg=""
 	local allow_tx_lost=0
 	local allow_rx_lost=0
@@ -1187,7 +1189,8 @@ chk_fail_nr()
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns2
 		ns_rx=$ns1
-		extra_msg="invert"
+		tx="client"
+		rx="server"
 	fi
 
 	if [[ "${fail_tx}" = "-"* ]]; then
@@ -1199,10 +1202,10 @@ chk_fail_nr()
 		fail_rx=${fail_rx:1}
 	fi
 
-	print_check "fail tx"
+	print_check "fail tx ${tx}"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
-		extra_msg+=",tx=$count"
+		extra_msg+=" tx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1213,10 +1216,10 @@ chk_fail_nr()
 		print_ok
 	fi
 
-	print_check "fail rx"
+	print_check "fail rx ${rx}"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
-		extra_msg+=",rx=$count"
+		extra_msg+=" rx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1238,37 +1241,35 @@ chk_fclose_nr()
 	local count
 	local ns_tx=$ns2
 	local ns_rx=$ns1
-	local extra_msg=""
+	local tx="client"
+	local rx="server"
 
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns1
 		ns_rx=$ns2
-		extra_msg="invert"
+		tx="server"
+		rx="client"
 	fi
 
-	print_check "fast close tx"
+	print_check "fast close tx ${tx}"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_tx" ]; then
-		extra_msg+=",tx=$count"
 		fail_test "got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
 	else
 		print_ok
 	fi
 
-	print_check "fast close rx"
+	print_check "fast close rx ${rx}"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_rx" ]; then
-		extra_msg+=",rx=$count"
 		fail_test "got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
 	else
 		print_ok
 	fi
-
-	print_info "$extra_msg"
 }
 
 chk_rst_nr()
@@ -1279,15 +1280,17 @@ chk_rst_nr()
 	local count
 	local ns_tx=$ns1
 	local ns_rx=$ns2
-	local extra_msg=""
+	local tx="server"
+	local rx="client"
 
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns2
 		ns_rx=$ns1
-		extra_msg="invert"
+		tx="client"
+		rx="server"
 	fi
 
-	print_check "reset tx"
+	print_check "reset tx ${tx}"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1299,7 +1302,7 @@ chk_rst_nr()
 		print_ok
 	fi
 
-	print_check "reset rx"
+	print_check "reset rx ${rx}"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1310,8 +1313,6 @@ chk_rst_nr()
 	else
 		print_ok
 	fi
-
-	print_info "$extra_msg"
 }
 
 chk_infi_nr()
@@ -1320,7 +1321,7 @@ chk_infi_nr()
 	local infi_rx=$2
 	local count
 
-	print_check "infi tx"
+	print_check "infi tx client"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtInfiniteMapTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1330,7 +1331,7 @@ chk_infi_nr()
 		print_ok
 	fi
 
-	print_check "infi rx"
+	print_check "infi rx server"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtInfiniteMapRx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1506,19 +1507,21 @@ chk_add_nr()
 	local mis_ack_nr=0
 	local ns_tx=$ns1
 	local ns_rx=$ns2
-	local extra_msg=""
+	local tx=""
+	local rx=""
 	local count
 	local timeout
 
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns2
 		ns_rx=$ns1
-		extra_msg="invert"
+		tx=" client"
+		rx=" server"
 	fi
 
 	timeout=$(ip netns exec ${ns_tx} sysctl -n net.mptcp.add_addr_timeout)
 
-	print_check "add addr rx"
+	print_check "add addr rx${rx}"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1530,7 +1533,7 @@ chk_add_nr()
 		print_ok
 	fi
 
-	print_check "add addr echo rx"
+	print_check "add addr echo rx${tx}"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1541,7 +1544,7 @@ chk_add_nr()
 	fi
 
 	if [ $port_nr -gt 0 ]; then
-		print_check "add addr rx with port"
+		print_check "add addr rx with port${rx}"
 		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1551,7 +1554,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "syn rx port"
+		print_check "syn rx port${tx}"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1562,7 +1565,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "synack rx port"
+		print_check "synack rx port${rx}"
 		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1573,7 +1576,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "ack rx port"
+		print_check "ack rx port${tx}"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1584,7 +1587,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "syn rx port mismatch"
+		print_check "syn rx port mismatch${tx}"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1595,7 +1598,7 @@ chk_add_nr()
 			print_ok
 		fi
 
-		print_check "ack rx port mismatch"
+		print_check "ack rx port mismatch${tx}"
 		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
@@ -1606,8 +1609,6 @@ chk_add_nr()
 			print_ok
 		fi
 	fi
-
-	print_info "$extra_msg"
 }
 
 chk_add_tx_nr()
@@ -1651,6 +1652,8 @@ chk_rm_nr()
 	local count
 	local addr_ns=$ns1
 	local subflow_ns=$ns2
+	local addr="server"
+	local subflow="client"
 	local extra_msg=""
 
 	shift 2
@@ -1660,16 +1663,14 @@ chk_rm_nr()
 		shift
 	done
 
-	if [ -z $invert ]; then
-		addr_ns=$ns1
-		subflow_ns=$ns2
-	elif [ $invert = "true" ]; then
+	if [ "$invert" = "true" ]; then
 		addr_ns=$ns2
 		subflow_ns=$ns1
-		extra_msg="invert"
+		addr="client"
+		subflow="server"
 	fi
 
-	print_check "rm addr rx"
+	print_check "rm addr rx ${addr}"
 	count=$(mptcp_lib_get_counter ${addr_ns} "MPTcpExtRmAddr")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1679,7 +1680,7 @@ chk_rm_nr()
 		print_ok
 	fi
 
-	print_check "rm subflow"
+	print_check "rm subflow ${subflow}"
 	count=$(mptcp_lib_get_counter ${subflow_ns} "MPTcpExtRmSubflow")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1693,7 +1694,7 @@ chk_rm_nr()
 		count=$((count + cnt))
 		if [ "$count" != "$rm_subflow_nr" ]; then
 			suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
-			extra_msg+=" simult"
+			extra_msg="simult"
 		fi
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
@@ -1714,7 +1715,7 @@ chk_rm_tx_nr()
 {
 	local rm_addr_tx_nr=$1
 
-	print_check "rm addr tx"
+	print_check "rm addr tx client"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtRmAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1733,7 +1734,7 @@ chk_prio_nr()
 	local mpj_syn_ack=$4
 	local count
 
-	print_check "mp_prio tx"
+	print_check "mp_prio tx server"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioTx")
 	if [ -z "$count" ]; then
 		print_skip
@@ -1743,7 +1744,7 @@ chk_prio_nr()
 		print_ok
 	fi
 
-	print_check "mp_prio rx"
+	print_check "mp_prio rx client"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioRx")
 	if [ -z "$count" ]; then
 		print_skip

-- 
2.45.2


