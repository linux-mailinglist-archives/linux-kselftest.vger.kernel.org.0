Return-Path: <linux-kselftest+bounces-17411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5C196FB67
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 20:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3967B28B79B
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C821D1732;
	Fri,  6 Sep 2024 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u71UqES2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071051D04A4;
	Fri,  6 Sep 2024 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648386; cv=none; b=beO12lV1FlmjJYoYNjMXbk91DQRlhmsu7HUCJEIM5BckiaZb5w6jyaARpqh/MxdJYbnClvwP3TjYHzZLwLT54pqtWyljzu1EJajYN7lyYr3aQizxHoDuONs6vP8Vj1qJ0zPKCRQb8EHvHKTnI2H5Sxy828Dmi58BMFrGS6w40i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648386; c=relaxed/simple;
	bh=exlr1t1z8ANjogMu+0R8MvnEWUoNjycIDoP/fjhm3AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbNd8d2TTNE7snHxFBO2+M62B+1R4gSK6z/OQAPEx16SMHFpvLbLNS3fRX0BRuEfQ0j8Has1btSzn1JH1R++8g8FWBVmDVhaIQCx+DYxs5DW5FTDMxs1n5rsv4fAtJEkZxlH47H/vHgCrQ7lkyjrR477TsruJyrOxZ1/YWc+KwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u71UqES2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BCCC4CECB;
	Fri,  6 Sep 2024 18:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725648385;
	bh=exlr1t1z8ANjogMu+0R8MvnEWUoNjycIDoP/fjhm3AQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u71UqES2gVZnPej8AF81tfVCaK9URlnG/3Fc91SIn+/5SnW/zEphKlc6UGUcaEEao
	 077FcezwFn424Y45usfsWGki16UspBlzA0x6+KVHIq4fN7w3S/mqGPuseRkrDprCtR
	 EUGzpd746ctko49FGbPF3LegABKWlGdbjZZ6xqnYJV8XwlHLymW3sAPYlGegMUvcGI
	 BOGAl8Ri+g2wtLeftQgiUsmCN8N05DGJFE/C7DWmE60KcTgZpRJGwLq0Ji8YBep3kL
	 Q8p70sDcsuU+clvE4mqKGWdU6smj+W8ReyDgyCTe/P3Lysuyals3zeOUA+ZdY9HkgL
	 7ZCCX9vl/bErA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 06 Sep 2024 20:46:07 +0200
Subject: [PATCH net-next v2 1/5] selftests: mptcp: lib: add time per
 subtests in TAP output
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-net-next-mptcp-ksft-subtest-time-v2-1-31d5ee4f3bdf@kernel.org>
References: <20240906-net-next-mptcp-ksft-subtest-time-v2-0-31d5ee4f3bdf@kernel.org>
In-Reply-To: <20240906-net-next-mptcp-ksft-subtest-time-v2-0-31d5ee4f3bdf@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2373; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=exlr1t1z8ANjogMu+0R8MvnEWUoNjycIDoP/fjhm3AQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2037meuM/EqOZ/v7Lm5hMb+yiKG+L/Fcd3kGf
 OqSB4o/omOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZttN+wAKCRD2t4JPQmmg
 c5tSD/0SiCP68FFhvW9bYRz03ZFtiykJJ1+txf5hNGyJPS2HS2Dlr4871msDEvXFIDwT0osgNIW
 +of5X7P09/e/tq49qiGyTE6D4gSP1oNnIhJC5SNArIEbs0SKnjNu3Dn44dVsk2vI7p+Cm0PK9rK
 bZ0uJUD/bgrroLpy/QKjQY7RqJtHtfJamHu+ix4+stQNNT37xEQmZgSec6CUx/IN4aFb57nOQGI
 +77W1AtypZTjRv6Fd41lIL2H+BOAOOj4xAlmNj4thyUakWhf87+T5YisCX025CNLGw9bIfplQFG
 cP9cvoyrrZlZCB+KIzrwlP8dirbLIkl2JJem0woJ2T1IbH6HPeRmK+67G57LThVu0Ilg2lA+tJA
 +R7ANx1OnyTVLz0JTX305K4teeCAA8rG5SVSU+U8r/NtyfUX86/UHK4eFrg29ZAxHSKIVNH2a6i
 CCe+a00lCbEa/hT4/R42Wpaj/qp61GlAw8OPo3KIGcb55Dghq42lzqnGtTtRj5DgoxZpsUqlEkt
 7MyyCDGXy6PIIZtfXCb+3YHDco+eWPECam5XotBDZCYYLZ1swNaaQzHpHZvJgxhgu8Dxohe9uax
 J5X4Zh30qdMhU3845hmxeJNfx8YfKG5G1I17q3BmWP5/AZutdIiXiMZhffQiUWmu0LEeMttbFv1
 CNevKPmTdyftLsQ==
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


