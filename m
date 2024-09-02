Return-Path: <linux-kselftest+bounces-16952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7660A9685F0
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 13:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044C11F22207
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 11:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2961D54EB;
	Mon,  2 Sep 2024 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tt9U1E/0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F3D1D54E2;
	Mon,  2 Sep 2024 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275606; cv=none; b=nif8a4gvebTjob45NtAb6UnCVKzzeunCq7qQ0GAHsiMVJ9LQE4ieMNArOOSjqfDtGqdQSFFNhF//SgOSoV2W16ZIazHTmf+idwQTa6qRMMLniyreBNtghnApc1y1MSOo2QXanjlPPPa6HaRVJPbrVDS0E80xq1/OJr84pJDA0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275606; c=relaxed/simple;
	bh=coivBrklEI2JUZwekWv4TknuYZt59LSzSjx3B0A/NVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zgml8V+EzeFUQ0iHtCsrAnDCaX+6aBklcdeGKNsrbLmmugI4n6HPzcPgPraJG4FZwuZbziXOGwPS+5/G5MgG3cL3W0j8cykdeZq5ukGGX8RrG/Q+84YQsQ9d63d2/HYfkb6sIb9STDFKeZUERn7WZe7/kgzeY+hviCV1m3tccs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tt9U1E/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19ADC4CEC2;
	Mon,  2 Sep 2024 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725275606;
	bh=coivBrklEI2JUZwekWv4TknuYZt59LSzSjx3B0A/NVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tt9U1E/0P2dARXlbZA+/ZvoPav5Mi+XWYWe+GTgDH4KOAaCMciOGzSuQaxTv1YpXA
	 /lwPWwnc4yJyxna/Sf5zNlEYAb7ctkPUoB3W/Wk6wODvSUrzCe3c/48/Bfw73OP823
	 21/aI6jqwRQsubNNsxFXcWSxrk9lFN/QI0IBsao3Z9NspPiQSXvn0KarMUWU6Msrxy
	 Yl0ypyYD7PPAYO59yd1TwpA4y+3yvc8j2VSbNAG3dAbbBN2mxzxBT+xB5D5Eppx7EO
	 tW1eaJQPRgfYnGRpKd1rC/KKSdvaLwTSGbP9/r9kkgRjNvecexL1Zoc9m1JtrVCHko
	 avGZNpILYgQKQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 13:13:06 +0200
Subject: [PATCH net-next 3/3] selftests: mptcp: reset the last TS before
 the first test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-ksft-subtest-time-v1-3-f1ed499a11b1@kernel.org>
References: <20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3916; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=coivBrklEI2JUZwekWv4TknuYZt59LSzSjx3B0A/NVY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1Z3LG1SnxwFVM5q2+pzQSq0NpdMHS6zwszaod
 Kl8843EtkiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWdywAKCRD2t4JPQmmg
 cyErD/0WernVGS/e4FYg55+ajfdTimHSiDpmTWBe7ZeZGoKWXIn1hdehr4wOxDDqKzLhXiQ198v
 hrxD6kYCbJVfZ+77R6L0wSeZjW14e0a5t3IkOAV2w+gjGBwg7gqgAC7TIiSjuGukO2J0qKRtZxp
 Qd1cde/uhLKLtoe1YeYss9eGYJJ3Yklx4VML1yQCQCNCrb3wJ8v9wpdWdflBbqvCreL5JtRhqAu
 kqwknF7WWLtMTylYRUA9pBBYPrszcMXNR7F+AmnLlz1fLtzJ1IaPJYlYn6txQCWcdZS6/IqcqPq
 UKldJeUTfdQO4qch0DzetHY9an00nb9kqaiAkTnt2Q1+mxQdJmihaAoxzTusbsd6NPiE3UFSkbV
 mfB6pF+Tw4lh7X9P854dHQv9cTOYuLP2yr7pdbR4/Kcon/d1DEQCoi+x7i9Ee+nlkwgF18fRT9n
 9ODWgKgdd4d7puJGBjMU8mkyraHSTr5iDsW3uytFP5ZdJ+CH3KJFeF7FbYf/5XiPeTgaKJYU3Pn
 GciUD61lwwLK/70k8IWexlPLNdNlzkUH15NjqUv0uAACv/tvcUaDGvX7WcDK0fmluYcLTKe/Wgt
 UO1Y9lBWOsbRhlILDijVvVhsdJOLILcCQaM13wJY2f9d5IrTmmzIBkmiDP9PbILKFKRRhABRPur
 /Ej1Fi2hJsLluZA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Just to slightly improve the precision of the duration of the first
test.

In mptcp_join.sh, the last append_prev_results is now done as soon as
the last test is over: this will add the last result in the list, and
get a more precise time for this last test.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 ++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 2 ++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 1 +
 6 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index f61e2f5870ea..49d90c4dbc01 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -847,6 +847,8 @@ stop_if_error()
 make_file "$cin" "client"
 make_file "$sin" "server"
 
+mptcp_lib_subtests_last_ts_reset
+
 check_mptcp_disabled
 
 stop_if_error "The kernel configuration is not valid for MPTCP"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a4762c49a878..c31387b74010 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3883,9 +3883,11 @@ if [ ${#tests[@]} -eq 0 ]; then
 	tests=("${all_tests_names[@]}")
 fi
 
+mptcp_lib_subtests_last_ts_reset
 for subtests in "${tests[@]}"; do
 	"${subtests}"
 done
+append_prev_results
 
 if [ ${ret} -ne 0 ]; then
 	echo
@@ -3896,7 +3898,6 @@ if [ ${ret} -ne 0 ]; then
 	echo
 fi
 
-append_prev_results
 mptcp_lib_result_print_all_tap
 
 exit $ret
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 68899a303a1a..5e8d5b83e2d0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -349,6 +349,7 @@ init
 make_file "$cin" "client" 1
 make_file "$sin" "server" 1
 trap cleanup EXIT
+mptcp_lib_subtests_last_ts_reset
 
 run_tests $ns1 $ns2 10.0.1.1
 run_tests $ns1 $ns2 dead:beef:1::1
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 2757378b1b13..2e6648a2b2c0 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -137,6 +137,8 @@ check()
 	fi
 }
 
+mptcp_lib_subtests_last_ts_reset
+
 check "show_endpoints" "" "defaults addr list"
 
 default_limits="$(get_limits)"
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index f74e1c3c126d..8fa77c8e9b65 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -286,6 +286,7 @@ while getopts "bcdhi" option;do
 done
 
 setup
+mptcp_lib_subtests_last_ts_reset
 run_test 10 10 0 0 "balanced bwidth"
 run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 9cb05978269d..3651f73451cf 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -150,6 +150,7 @@ mptcp_lib_events "${ns2}" "${client_evts}" client_evts_pid
 server_evts=$(mktemp)
 mptcp_lib_events "${ns1}" "${server_evts}" server_evts_pid
 sleep 0.5
+mptcp_lib_subtests_last_ts_reset
 
 print_title "Init"
 print_test "Created network namespaces ns1, ns2"

-- 
2.45.2


