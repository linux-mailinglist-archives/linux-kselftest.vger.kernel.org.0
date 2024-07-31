Return-Path: <linux-kselftest+bounces-14536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F00942CD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 13:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5551C209E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 11:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BF91B1423;
	Wed, 31 Jul 2024 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkFaRPmT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2A41B1417;
	Wed, 31 Jul 2024 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423992; cv=none; b=XeOFRgVAWlTwqX4kaVgbaQddRoSTsOalT9t5J5UqDEaUmsN7IdkUkKVguIY7flEzCHqGF+1MyLsGopV6PrPDQEDPZnVQwGWHbQ1z2u4VGOrJJ0t/9j0/2xJSXC0Tca2Ski52dLS7jnnlqo+b/jSQA760w4N65nU3uAv1liBsHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423992; c=relaxed/simple;
	bh=GF9ZuUb1kC7ALkbKTAdDrcfBWVUj2E5ba2obD4Bwp5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXkJzxQ6YjSZcEPv3j1GMuSBQn9nOKxVHAevvJB0f3+P6STIC2mC9zuxhbeVKqzXGlLFBwAM2fForf386spArSQn3N7qLRytEVDWL12tNzVLJaPm1WoPoLff72GHP89YgzggZPNKx03+YceEHbHn5poenbQd9pQxDE51HvHUjZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkFaRPmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF6DC4AF10;
	Wed, 31 Jul 2024 11:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423992;
	bh=GF9ZuUb1kC7ALkbKTAdDrcfBWVUj2E5ba2obD4Bwp5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QkFaRPmTofrGDHBzophnwvQs52/o8dLjL0DgIPiWuJczP+laDoqk7OXtKnfe5Mxwi
	 7b5m8nT8CXvoCyk2kT22SGtQfl5JoJA+GLVaK5ajQrxPnBnUltNGcThT+fB+5c9c3n
	 MrJUsByVIbr6+wu1U74nmLoDtXZZ7FfUOSsmv2ICaKiqEd6+Q7A82KWQYZyPuU7HMQ
	 gzVzikARQTxyDEwwY9sprCy7yEd5XQLa3iJO6IwOIGWirNCmpzesr0ek5JL8aGc/T1
	 PAk7VcFgLWlAm7z99bwkWGf9jW3788qf+r56OiMoLSeMZ2I/ideLmxI6hFA8SV90Hm
	 NSlGe74BUpWlg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jul 2024 13:05:58 +0200
Subject: [PATCH net 6/7] selftests: mptcp: join: ability to invert ADD_ADDR
 check
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-6-c8a9b036493b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4336; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GF9ZuUb1kC7ALkbKTAdDrcfBWVUj2E5ba2obD4Bwp5I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmqhqi7s6RNgEUk85ovrvmaAHGLEk++7ljJcA+U
 gRV0bKTKpSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqoaogAKCRD2t4JPQmmg
 c3IrD/9Mut2dYeV3HYEKGvVtEvg9Dw5pWHvinVqlI5nSmsAR762+NtDsAhS6VYokYzNFfyScwAj
 w2rDoeUHAUdaLa5BoDwm1Gjq9kpmqLt0ygyGDcPJSf7cKG9XphnPhWg8NtsQQ92X9V6vm7nNCyZ
 70jfKY5WCHEzGJmBR8N8fIpGoPnVQUKXm8s6KdpsIZOvpxdkuy5e/v7jWypLiSeAR2saRGq6Dz9
 Pcq1lOU4PWQBjq2hKd+3BLc32byM6ZAJrepCoSB9oZbZTseQ4JoK+l3CrfdbFURrfcPCOJttE1L
 XOk2eTESQ0Z8owjCo1YFHjJotOUv+EnQjKhTculjT3y7L0/WFVuXF/RmpogVg+0WuykuWQehRlU
 IFTUpayFSdZAnjCuxezntCXgf+qaP4XKPqbSnnN1s4YjHDGi2AA6+mhFFkE28tO+zXn4mRyzyg/
 DrFIC4hKBgtn+DcZ2+6hCOUyu9XMReHA2pFWw0ewoXDAxh+AQEsh4Kxr2zTgmfXLeLhK+DJ1KVd
 iHm2nd7Id/3Mki2aaZwqcxK3OtjKcHC0Kkos+RrnVDCIN1B8zUqWKM/tRh/e80Lx4XqGv/+RZGD
 83PncMgDHzGHpNhXHii6jAzonT9+5rCTYpHAox66/8hBR0yOUQ0V9TgNXob88Y/foEWA3RVdfHH
 ZENFvLZeX+BHu6Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In the following commit, the client will initiate the ADD_ADDR, instead
of the server. We need to way to verify the ADD_ADDR have been correctly
sent.

Note: the default expected counters for when the port number is given
are never changed by the caller, no need to accept them as parameter
then.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 40 ++++++++++++++++---------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4df48f1f14ab..52a25ac43d10 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1415,18 +1415,28 @@ chk_add_nr()
 	local add_nr=$1
 	local echo_nr=$2
 	local port_nr=${3:-0}
-	local syn_nr=${4:-$port_nr}
-	local syn_ack_nr=${5:-$port_nr}
-	local ack_nr=${6:-$port_nr}
-	local mis_syn_nr=${7:-0}
-	local mis_ack_nr=${8:-0}
+	local ns_invert=${4:-""}
+	local syn_nr=$port_nr
+	local syn_ack_nr=$port_nr
+	local ack_nr=$port_nr
+	local mis_syn_nr=0
+	local mis_ack_nr=0
+	local ns_tx=$ns1
+	local ns_rx=$ns2
+	local extra_msg=""
 	local count
 	local timeout
 
-	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
+	if [[ $ns_invert = "invert" ]]; then
+		ns_tx=$ns2
+		ns_rx=$ns1
+		extra_msg="invert"
+	fi
+
+	timeout=$(ip netns exec ${ns_tx} sysctl -n net.mptcp.add_addr_timeout)
 
 	print_check "add"
-	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtAddAddr")
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
 		print_skip
 	# if the test configured a short timeout tolerate greater then expected
@@ -1438,7 +1448,7 @@ chk_add_nr()
 	fi
 
 	print_check "echo"
-	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtEchoAdd")
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$echo_nr" ]; then
@@ -1449,7 +1459,7 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		print_check "pt"
-		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtPortAdd")
+		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$port_nr" ]; then
@@ -1459,7 +1469,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_nr" ]; then
@@ -1470,7 +1480,7 @@ chk_add_nr()
 		fi
 
 		print_check "synack"
-		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
+		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_ack_nr" ]; then
@@ -1481,7 +1491,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$ack_nr" ]; then
@@ -1492,7 +1502,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_syn_nr" ]; then
@@ -1503,7 +1513,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_ack_nr" ]; then
@@ -1513,6 +1523,8 @@ chk_add_nr()
 			print_ok
 		fi
 	fi
+
+	print_info "$extra_msg"
 }
 
 chk_add_tx_nr()

-- 
2.45.2


