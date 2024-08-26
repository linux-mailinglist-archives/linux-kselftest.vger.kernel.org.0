Return-Path: <linux-kselftest+bounces-16302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B55295F5D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4649A283502
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92701991C1;
	Mon, 26 Aug 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lST0/Yzx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004D194A6C;
	Mon, 26 Aug 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687991; cv=none; b=gVDOmd9SXw3nDngVqJL4S9piSSVDlB80WwIx9aUdDppBjmPwNwJR1486LzeQFr4RdqUjG6gdFZiO6USE3bb7eHPQrLJN1H1GpO9LPL1xSkdji3r+RGJtRY6PPQFu9YWqED36PmT9KZ+wUpZuhET2gem1L91n3MthOQd9Ax+8GbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687991; c=relaxed/simple;
	bh=KJeX440D0lgAaATQxMR6d7ml7Kmd14Njfgm9c+2vehU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kl0bvcIgfyIjwlUiHiJ0y4Z9N+Twjz/vKcmGsr64/L8RvY41k5nC2afzgMAVSaUe8WdrVVrob1GzEB/RlU3qTHzMB5HlJL7UaDbeqeMW8zvZJUjql6NkMxrA3TY3+vY/LFT01eVBuftoX/T0PkdQwbDyQQR9tWWQdfs8O8OOuds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lST0/Yzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E20BC4DDEC;
	Mon, 26 Aug 2024 15:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687991;
	bh=KJeX440D0lgAaATQxMR6d7ml7Kmd14Njfgm9c+2vehU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lST0/YzxBw2A8dgKNlzdyM4ASHapmjmlHTbM5S1AZMoaU4CYzyjHp4yqYjxgPlUuA
	 TDynITgyCkMCLorca76S+dizks0wf4PADvMLIioqfSvJPfRPrv6Q2PVrsxtNR/35cI
	 dzWraOZIMt9PfSBUw1qrz6UP2A0TVfKgn/kpm3NMl3bF+V1pQuRc/fg+FG06rKpfDI
	 19Rl6wO1T5SFPhDBz5gaw006JIGxYkQJzebePYqK1EhLC9Gho7CpcXbW2g0Mff5vyL
	 rBzS0sfPauTCBd7jKp/QwlF1lLIVU51QWleHC33ElaDrKLkDkUBw1YmZwXoK7dVHee
	 kTz7IY4RrCE4g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:07 +0200
Subject: [PATCH net 08/15] selftests: mptcp: join: no extra msg if no
 counter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-8-8cd6c87d1d6d@kernel.org>
References: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
In-Reply-To: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3270; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KJeX440D0lgAaATQxMR6d7ml7Kmd14Njfgm9c+2vehU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZWMilAosh/GrvXhEjYKlHkZ09midWZh+eey
 SX42jEF7W6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVgAKCRD2t4JPQmmg
 cyWFD/48d+q6ixKoZJQKgd4T1pLlcVbmdqNqTnqg6k9YZsU9hbqVZKv1Nhk/IGBD9bEKoMQjGIJ
 RdPm0MbGQStZcJkILvjYvx/O3iXnFEvaNgBf+XsUt9ZlRoxWD2AccjyQW7N+dbCpPBrsbiMhTDR
 AMJFVe7sJBveNDeyBSH0nG3tV9RHjJBgbXh394k/MnlZzHxgAlT6eMaj0qM5T8lDuSKcMrFpz/1
 7FnCnSHetfduxC36IXQEYFlhj4CjFnNLRNSH515x1IgOIAS65AcfU1xLaAPeXCOXaUmXlj5wVpT
 yJI491yMLpy3dAnEH6ZDNuVDJAOioclbnsSmGVh1EE1COaGRD4m/yyBM95w3psa3fI85MICG0As
 DcjmJmiSLL9SFxQdzzqDp68znZNRvp2cnKY6/h8tND9jhev0js8epZnA9sWkJkgSoeQiAnmp7HF
 JL0HCKJShj0F+GxOxjqnR7XHyc6joj6sAtDVV9m+KEDu1/G8v2GT33621rNkgv+vOVDvuK61/e1
 lEi2KvueyXMqmuwTj30DCTJwNq191jM6bvma0QmJrO84idQwiIfoDo3Xhng9lUsSYB+z5UiNP/O
 XyGi8EylBW54c4rjcZDdseBxEUk+DR/+qBB/AmxS8ikSRmVGaQWM6lpeozqx7YMQ+Er2OsFAFu5
 rdsRPyyNtEzAO1Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The checksum and fail counters might not be available. Then no need to
display an extra message with missing info.

While at it, fix the indentation around, which is wrong since the same
commit.

Fixes: 47867f0a7e83 ("selftests: mptcp: join: skip check if MIB counter not supported")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0fd4bd609565..0ffa6f6b04e2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1112,26 +1112,26 @@ chk_csum_nr()
 
 	print_check "sum"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns1" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ]; then
 		extra_msg+=" ns1=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
-	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
+	     { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
 		fail_test "got $count data checksum error[s] expected $csum_ns1"
 	else
 		print_ok
 	fi
 	print_check "csum"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns2" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns2" ]; then
 		extra_msg+=" ns2=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
-	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
+	     { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
 		fail_test "got $count data checksum error[s] expected $csum_ns2"
 	else
 		print_ok
@@ -1169,13 +1169,13 @@ chk_fail_nr()
 
 	print_check "ftx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
-	if [ "$count" != "$fail_tx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
 		extra_msg+=",tx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		fail_test "got $count MP_FAIL[s] TX expected $fail_tx"
 	else
 		print_ok
@@ -1183,13 +1183,13 @@ chk_fail_nr()
 
 	print_check "failrx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
-	if [ "$count" != "$fail_rx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
 		extra_msg+=",rx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
 	elif { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		fail_test "got $count MP_FAIL[s] RX expected $fail_rx"
 	else
 		print_ok

-- 
2.45.2


