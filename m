Return-Path: <linux-kselftest+bounces-40421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D02AB3DECA
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 11:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009093BF7B9
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063A830F7FE;
	Mon,  1 Sep 2025 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usB4Ybyx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42830BBA4;
	Mon,  1 Sep 2025 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719613; cv=none; b=Fly6ZD6dTzsJ5hobLfi8U3OsY9nTFHj5+IQnSx5qgTQ/ZSpqCWMZAKuS71V66DGgCMsKuskuMbAPOeyxqXEboezg0Yp2Mzk4e3Pyy3JfFphOlmLjLidtzwskHBjebkrTTE2H34Dz2L/rLPqoaYhNVjaTJrzvxcbVphNkpz0JCFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719613; c=relaxed/simple;
	bh=dTJO1tCQOaPXCW9+vy4vy4eJa6ytua6sNKJ/OHhhNxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=giQNQ6nYUR+DEQHc500Ig5bSpuK4mZwCPiA4iFxCNTCq2OYMoV2WlQdEewwh/InvSrpMfXsTXG0YxLfjsBXIvmVL3a84JwsJ/ATquYUvBBwoOCcP5i7oNCTH0rbyaaUOP/dFhbGzaV2nQ86XUzr3Ljjznesj0HkS4LQGqXLy7cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usB4Ybyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7D6C4CEF0;
	Mon,  1 Sep 2025 09:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756719613;
	bh=dTJO1tCQOaPXCW9+vy4vy4eJa6ytua6sNKJ/OHhhNxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=usB4Ybyx6nDuZseT+7sTTTH0ygaQIOw2TDRlEZkpWR0W1ijfZyNVma5LphI+fQ90L
	 WaqWnrHGLzqGmqLhIaoP4pMh6KKILTMcGQcRMjV91proCAvYJ7O9nV3fnNQbI4Lg8Q
	 OZhsW0AaLY8FI1Z80oRdw2v+zTY5phad7JIwNUSkq/XzTReJ/2egZF3o4QA4UQmLhC
	 99Q59lKWjtkCCU5/5499iUM30McfSUZ6acNEUJUZsr9qRwwrr98fP66XvnnliAsWdg
	 Mis4ymigYbvHpqUN2vnKwtBJxoA41trqyGxR0pIB8TVGBPvpYW9n8e/qygKJsMcAJS
	 Zup01X6R5gJIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Sep 2025 11:39:13 +0200
Subject: [PATCH net-next 4/6] selftests: mptcp: add checks for fallback
 counters
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-net-next-mptcp-misc-feat-6-18-v1-4-80ae80d2b903@kernel.org>
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
In-Reply-To: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5270; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TFqzr/DMh0lYxvep2tdsVTHnsEaN2pnZvUQretOY304=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK2Zr50mXLoTL5jjSTjzdcPzirYtiepTnnt28AiX/Bp5
 62Ka7dzOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbiEsTIcM7f5PKXT6JTkm9+
 P1olEZgY7nhgk//BZY9cb5dnGu0//JThv/d/nm3rao76J1UfmFv12F2ya73knjsZ6wJ+vd4dVGK
 awQkA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

Recently, some mib counters about fallback has been added, this patch
provides a method to check the expected behavior of these mib counters
during the test execution.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/571
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 123 ++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e85bb62046e020dbacbbd44e1f9e110e1d0104c7..a97b568104bc284f050b2f0e09fe3fdd3341c5cb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -74,6 +74,17 @@ unset join_create_err
 unset join_bind_err
 unset join_connect_err
 
+unset fb_ns1
+unset fb_ns2
+unset fb_infinite_map_tx
+unset fb_dss_corruption
+unset fb_simult_conn
+unset fb_mpc_passive
+unset fb_mpc_active
+unset fb_mpc_data
+unset fb_md5_sig
+unset fb_dss
+
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
 CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
@@ -1397,6 +1408,115 @@ chk_join_tx_nr()
 	print_results "join Tx" ${rc}
 }
 
+chk_fallback_nr()
+{
+	local infinite_map_tx=${fb_infinite_map_tx:-0}
+	local dss_corruption=${fb_dss_corruption:-0}
+	local simult_conn=${fb_simult_conn:-0}
+	local mpc_passive=${fb_mpc_passive:-0}
+	local mpc_active=${fb_mpc_active:-0}
+	local mpc_data=${fb_mpc_data:-0}
+	local md5_sig=${fb_md5_sig:-0}
+	local dss=${fb_dss:-0}
+	local rc=${KSFT_PASS}
+	local ns=$1
+	local count
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtInfiniteMapTx")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$infinite_map_tx" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns infinite map tx fallback"
+		fail_test "got $count infinite map tx fallback[s] in $ns expected $infinite_map_tx"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtDSSCorruptionFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$dss_corruption" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns dss corruption fallback"
+		fail_test "got $count dss corruption fallback[s] in $ns expected $dss_corruption"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtSimultConnectFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$simult_conn" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns simult conn fallback"
+		fail_test "got $count simult conn fallback[s] in $ns expected $simult_conn"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableFallbackACK")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$mpc_passive" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns mpc passive fallback"
+		fail_test "got $count mpc passive fallback[s] in $ns expected $mpc_passive"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableFallbackSYNACK")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$mpc_active" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns mpc active fallback"
+		fail_test "got $count mpc active fallback[s] in $ns expected $mpc_active"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableDataFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$mpc_data" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns mpc data fallback"
+		fail_test "got $count mpc data fallback[s] in $ns expected $mpc_data"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMD5SigFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$md5_sig" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns MD5 Sig fallback"
+		fail_test "got $count MD5 Sig fallback[s] in $ns expected $md5_sig"
+	fi
+
+	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtDssFallback")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$dss" ]; then
+		rc=${KSFT_FAIL}
+		print_check "$ns dss fallback"
+		fail_test "got $count dss fallback[s] in $ns expected $dss"
+	fi
+
+	return $rc
+}
+
+chk_fallback_nr_all()
+{
+	local netns=("ns1" "ns2")
+	local fb_ns=("fb_ns1" "fb_ns2")
+	local rc=${KSFT_PASS}
+
+	for i in 0 1; do
+		if [ -n "${!fb_ns[i]}" ]; then
+			eval "${!fb_ns[i]}" \
+				chk_fallback_nr ${netns[i]} || rc=${?}
+		else
+			chk_fallback_nr ${netns[i]} || rc=${?}
+		fi
+	done
+
+	if [ "${rc}" != "${KSFT_PASS}" ]; then
+		print_results "fallback" ${rc}
+	fi
+}
+
 chk_join_nr()
 {
 	local syn_nr=$1
@@ -1482,6 +1602,8 @@ chk_join_nr()
 	join_syn_tx="${join_syn_tx:-${syn_nr}}" \
 		chk_join_tx_nr
 
+	chk_fallback_nr_all
+
 	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
@@ -3334,6 +3456,7 @@ fail_tests()
 		join_csum_ns1=+1 join_csum_ns2=+0 \
 			join_fail_nr=1 join_rst_nr=0 join_infi_nr=1 \
 			join_corrupted_pkts="$(pedit_action_pkts)" \
+			fb_ns1="fb_dss=1" fb_ns2="fb_infinite_map_tx=1" \
 			chk_join_nr 0 0 0
 		chk_fail_nr 1 -1 invert
 	fi

-- 
2.50.1


