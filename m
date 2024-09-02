Return-Path: <linux-kselftest+bounces-16950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEFE96860D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 13:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9097DB29179
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 11:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793B41D2F7B;
	Mon,  2 Sep 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCneOO71"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEDF1D2F60;
	Mon,  2 Sep 2024 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275601; cv=none; b=lW+AgtACmgc47NJJDZQgOe2D+BaJf5MN7oquNeBOOb7uHLi7MIKc5r75309XYWYETQFqpBd4972iRGKiD20wnjPZxJoDc2XOYLDys3GhII+OMlEyxEfv1YPkfTBLw12Bl2TwqlvaGPOZ9kd9Owck3UHuQPzFggy6lzZRMh2Vmf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275601; c=relaxed/simple;
	bh=exlr1t1z8ANjogMu+0R8MvnEWUoNjycIDoP/fjhm3AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hH06UMlAJCWewK25ahZKXzaCan38GiPpDBCoSYIIrHv+YMA/sIsraPDgndcyvt0oN2CNG4KKVZ2L64VpQ/MTrMfc00kXb1vdSUKVey9k6Sjm/fFKyQdz4CJfNQa4P1tvxQjLy/AgLqvKeLl9STHQX0XDnbSE8Vn4cOGahwBW6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCneOO71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F6FC4CEC6;
	Mon,  2 Sep 2024 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725275600;
	bh=exlr1t1z8ANjogMu+0R8MvnEWUoNjycIDoP/fjhm3AQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SCneOO712KHGvJrk8xaYXjAg1gTzOf5Y8+i3s7trQc1gxgiqu9ciX+LlEcErCgfzM
	 xPNs7UH2102Iy0ytRLHHvqRob/uETMa/ZiLsI0JixlmhzfONV4otuZ/Ez/dxn0zBCP
	 BJtnd9/kS3Zebrn1jP5ui3ttltNaFJ9tXU+a8o6Y81BAOtV2S1Rq91TY3IiOAt5g8M
	 bA6EluaVU+VyOFjC2JU5IIp1IzJBTRnEJPOqBiDAt5qfxldFd7fMpXT9zltjm4u1JE
	 AEeeLQumlnL0eZyj7eXtRG3Hv9StBul6+uqFugF2juFgN9zBVWKuD4fDKFcZ3lQN13
	 X2Knbw57430SQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 13:13:04 +0200
Subject: [PATCH net-next 1/3] selftests: mptcp: lib: add time per subtests
 in TAP output
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-ksft-subtest-time-v1-1-f1ed499a11b1@kernel.org>
References: <20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2373; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=exlr1t1z8ANjogMu+0R8MvnEWUoNjycIDoP/fjhm3AQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1Z3LD2+yD+uDX4oHBXbvNlVai5dKy7+0+4EDp
 +rldDEmOTuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWdywAKCRD2t4JPQmmg
 c7j8EACooITxXsLdLumO1s23HEYDx7DF5qYzOsnXEQwyEZ1i0bfHiqio/USi+NNJ13ZXI+cQGes
 qDKgotLl8EYf1MJ2udJLJZETHNk/bViF+XdqG9iO7yMr6cs6WHH+soYvxK0wSREkIKVhnl+qku6
 be8yLYSnyE7C9YXCn35u0ugCVPZOZ9b3B83H6Q/pbZ7KER2IlVrbduMvdnz2pcAYqQPq4G/iPO2
 CaZ7qpEemxgnXtEUl40t8Iw1WwEWu3/X56MDAFrsVQHO8XYrfGYn6uO0jAni2/Zn+tqitKFVZKn
 Lyo5mrplF1y6FEsLlcrGaEi++K9SbtFNZ8gmqtxqM0k0UX57hek/D1PH2d1xtFA4Fo8pvm6vduv
 e3fWIfgSumz5T5xYkdmOQGiHryPr4ChQE4p07dRgO76wjvPAMy8a+3m0nVzecSlxouXR2Hh+KIZ
 mh5itA+H05iwIRDnK5TOtADuF06uWxQvYFKXrVskM1MDxsZBDz0S3/5nUokFSp+HN/K9Kr1A6qi
 rsnls6jCsOej3RaOFp0/eb1YUJudr8NTlJDEXjbUUqn2qHD9feDS0jAKIW+U2D/zwWfgzg6qbuo
 Rx7+l9cZsRnSrhNaRmuaqCrldsRip2rfKCyVFokZ1jKcNjK4K3LWXos2Nx0NJR1C6heeVWrk5x0
 Y65icQujE9b4e7A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It adds 'time=<N>ms' in the diagnostic data of the TAP output, e.g.

  ok 1 - pm_netlink: defaults addr list # time=9ms

This addition is useful to quickly identify which subtests are taking a
longer time than the others, or more than expected.

Note that there are no specific formats to follow to show this time
according to the TAP 13 [1], TAP 14 [2] and KTAP [3] specifications.
Let's then define this one here.

Link: https://testanything.org/tap-version-13-specification.html [1]
Link: https://testanything.org/tap-version-14-specification.html [2]
Link: https://docs.kernel.org/dev-tools/ktap.html [3]
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 4578a331041e..975d4d4c862a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -29,6 +29,7 @@ declare -rx MPTCP_LIB_AF_INET6=10
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
 MPTCP_LIB_SUBTEST_FLAKY=0
+MPTCP_LIB_SUBTESTS_LAST_TS_MS=
 MPTCP_LIB_TEST_COUNTER=0
 MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 MPTCP_LIB_IP_MPTCP=0
@@ -205,6 +206,11 @@ mptcp_lib_kversion_ge() {
 	mptcp_lib_fail_if_expected_feature "kernel version ${1} lower than ${v}"
 }
 
+mptcp_lib_subtests_last_ts_reset() {
+	MPTCP_LIB_SUBTESTS_LAST_TS_MS="$(date +%s%3N)"
+}
+mptcp_lib_subtests_last_ts_reset
+
 __mptcp_lib_result_check_duplicated() {
 	local subtest
 
@@ -219,13 +225,22 @@ __mptcp_lib_result_check_duplicated() {
 
 __mptcp_lib_result_add() {
 	local result="${1}"
+	local time="time="
+	local ts_prev_ms
 	shift
 
 	local id=$((${#MPTCP_LIB_SUBTESTS[@]} + 1))
 
 	__mptcp_lib_result_check_duplicated "${*}"
 
-	MPTCP_LIB_SUBTESTS+=("${result} ${id} - ${KSFT_TEST}: ${*}")
+	# not to add two '#'
+	[[ "${*}" != *"#"* ]] && time="# ${time}"
+
+	ts_prev_ms="${MPTCP_LIB_SUBTESTS_LAST_TS_MS}"
+	mptcp_lib_subtests_last_ts_reset
+	time+="$((MPTCP_LIB_SUBTESTS_LAST_TS_MS - ts_prev_ms))ms"
+
+	MPTCP_LIB_SUBTESTS+=("${result} ${id} - ${KSFT_TEST}: ${*} ${time}")
 }
 
 # $1: test name

-- 
2.45.2


