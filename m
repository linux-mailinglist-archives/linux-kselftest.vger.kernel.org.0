Return-Path: <linux-kselftest+bounces-45665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F9C5ED0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 19:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C0624F182E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 18:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFD3346774;
	Fri, 14 Nov 2025 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVVBLfZP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A437345CC3;
	Fri, 14 Nov 2025 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143949; cv=none; b=e/pB3a51AAxzTmD2dal4kzT+l+zUCh/6aaar+4B7pHlH/WpD09UH84C5QkyJHcMxLChz4+Z8izPwRroYdvnhzTAR+f+DbeXJcESaofJbUh6p4kH2FhGJB2gcx34xO5Vur9QTJHCsLNbfBmw1EoE+uIeNN8xsoOm003+PjRThORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143949; c=relaxed/simple;
	bh=Rf2tQO+wcr7dGmYv1QqAhIhJCKf3ecXEYZ07njQP2Qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RC0XXUYvs/EnjhybtZAp/+mJDYQLmGwsul2+bhXI3Q2xc5z6bSgtRKvmJCns+yHUxIyr68CBMgfqJvna36wh7IH4R8GFIi/plyuZQgRMWK9pBmBjMzom4IjwRppjGE/icmpk64tiKahm7e+PilTsmxzNRyMlC0JvxAy3IShh2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVVBLfZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8528BC2BC87;
	Fri, 14 Nov 2025 18:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143948;
	bh=Rf2tQO+wcr7dGmYv1QqAhIhJCKf3ecXEYZ07njQP2Qc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kVVBLfZPSs04t/HutQP+8QJbl328ArwWA6t03ZRt34g1xIw9f67/CdzTxAkQIuwYt
	 SMLRvcVhy/URGQKvSeUWFvtqseUuJGkddFvdc61I4JWD2FtQ5Fwb03ZH5vRbIdUh5U
	 BesnE1bKfr/UEOAm6Z+2gLr+pOhH7X5cBLxKEiAMrKJ6+43A+9k24pYfeRV067oz/T
	 VLSBt8+YWFNuI2hTzRpz5poABhrNEXCRnhLme+zFtTxodktuWBpqwTbddejzrZApHk
	 1VMFbjTNBlmdT3g0IBwMm2lFTGOb+XWmiDIPxrx+b0ZCr9hmqhIb5vWj5fFNdDrhZH
	 uUNhrjqW4v5tQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Nov 2025 19:12:06 +0100
Subject: [PATCH net-next 2/8] selftests: mptcp: lib: remove stats files
 args
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-2-863cb04e1b7b@kernel.org>
References: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
In-Reply-To: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4541; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Rf2tQO+wcr7dGmYv1QqAhIhJCKf3ecXEYZ07njQP2Qc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLFC/4sc3r3/izjvoPH3ya2ln7f5v59gfzasqJvMpxX6
 qUsl23k7ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIHk2G/3lVema+jWuDDDNq
 OQrebWWRfn/revQNjcUdhadOfyvIWM3w32dC3ZRKuczlS7nLFXufXZrX7KG04Yfj/I1WnKscHi8
 4xgsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Now that these files are written from MPTCP lib helpers, the stats file
paths are uniformed. Then, no need to specify them from the each
selftest.

No behavioural changes intended.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  3 +--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 15 ++++++++++-----
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  3 +--
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  3 +--
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index e1f34508490a..4ff2d02429d3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -444,8 +444,7 @@ do_transfer()
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
-		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}" \
-			"/tmp/${listener_ns}.out" "/tmp/${connector_ns}.out"
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 
 		echo
 		cat "$capout"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f51c9bf2d37f..aee215d73b7c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1071,8 +1071,7 @@ do_transfer()
 
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		fail_test "client exit code $retc, server $rets"
-		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}" \
-			"/tmp/${listener_ns}.out" "/tmp/${connector_ns}.out"
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 		return 1
 	fi
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1f31746cc519..4a26d4150603 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -106,23 +106,28 @@ mptcp_lib_pr_info() {
 	mptcp_lib_print_info "INFO: ${*}"
 }
 
-# $1-2: listener/connector ns ; $3 port ; $4-5 listener/connector stat file
+mptcp_lib_pr_nstat() {
+	local ns="${1}"
+	local hist="/tmp/${ns}.out"
+
+	cat "${hist}"
+}
+
+# $1-2: listener/connector ns ; $3 port
 mptcp_lib_pr_err_stats() {
 	local lns="${1}"
 	local cns="${2}"
 	local port="${3}"
-	local lstat="${4}"
-	local cstat="${5}"
 
 	echo -en "${MPTCP_LIB_COLOR_RED}"
 	{
 		printf "\nnetns %s (listener) socket stat for %d:\n" "${lns}" "${port}"
 		ip netns exec "${lns}" ss -Menitam -o "sport = :${port}"
-		cat "${lstat}"
+		mptcp_lib_pr_nstat "${lns}"
 
 		printf "\nnetns %s (connector) socket stat for %d:\n" "${cns}" "${port}"
 		ip netns exec "${cns}" ss -Menitam -o "dport = :${port}"
-		[ "${lstat}" != "${cstat}" ] && cat "${cstat}"
+		[ "${lns}" != "${cns}" ] && mptcp_lib_pr_nstat "${cns}"
 	} 1>&2
 	echo -en "${MPTCP_LIB_COLOR_RESET}"
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 343615908558..42d533b95ec7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -198,8 +198,7 @@ do_transfer()
 	print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
-		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}" \
-			"/tmp/${listener_ns}.out" "/tmp/${connector_ns}.out"
+		mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
 
 		mptcp_lib_result_fail "transfer ${ip}"
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index fbd1685d1adc..503cb59571a4 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -200,8 +200,7 @@ do_transfer()
 	fi
 
 	mptcp_lib_pr_fail "client exit code $retc, server $rets"
-	mptcp_lib_pr_err_stats "${ns3}" "${ns1}" "${port}" \
-		"/tmp/${ns3}.out" "/tmp/${ns1}.out"
+	mptcp_lib_pr_err_stats "${ns3}" "${ns1}" "${port}"
 	ls -l $sin $cout
 	ls -l $cin $sout
 

-- 
2.51.0


