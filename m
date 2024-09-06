Return-Path: <linux-kselftest+bounces-17413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B963E96FB6D
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 20:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52672B20EFA
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 18:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACFD1D7987;
	Fri,  6 Sep 2024 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx+3/Gcw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF3B1D6DDD;
	Fri,  6 Sep 2024 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648391; cv=none; b=TDHbaVtYGDsoEF0htc84j0pzY6abSz6dP5v02ZCcNiGQoa1zvJ+SYskr9JK+qv1MZG5mJ+DBXxob9ny/axX2n4pH6dCeRN+WrjUey5sdUb4jfPFBPf5rIGgmsCiALSqQLApj824UOBx4ZxhfdO5Th8QzJA6bqfe6Bu9eHGM79q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648391; c=relaxed/simple;
	bh=e1LZMuO1zQTgYSCDSU0RSxNy+M19aD9bysgW3jUoe8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5snR9asegDPKP1wtd1ZNR3w1fGyqxtRhJFvaywjkppe0kgzPDtE62nqet8zYFJ2Naa5b6VVf3ChPRhnuqh+AjAW6kkfStrTtArMyAJgHvLMm5uCtd+IC6Gke0qUsz5p0RgmQUeKq/Uj6OAkNEaKYOTHxXDhlhtVmzRqIlIktuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx+3/Gcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5BCC4CED1;
	Fri,  6 Sep 2024 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725648391;
	bh=e1LZMuO1zQTgYSCDSU0RSxNy+M19aD9bysgW3jUoe8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fx+3/Gcw/mBA1Zn52b5WgLiMDVvT7vrhCJVxNPRKcbMI7CPOOyFunnvzMKUcPp5MK
	 QuSFPM6q4YQG8XEz6bk7eCXC6KEWJRaXBmp+XvSRWgSVvC2Iiis2imOCFKPlQJXiSu
	 OLXDALxTVsryflEbX1plo/8JsNY1ymBlY42rsxtqWlOfn8SEaSpw81/JR3uhPWdsQC
	 yV5EVO5UETWcERjsOFZ2ulpG03YIKDt49PiSo8uD5POHOC7wgBFj5aCYihk473Ze2e
	 4DlC/eaP+zdDILQMAYz4N65Kh/J5mxmUjjsTMN1N8hRJcB7YqpXZPCfRLzKqNEbhIW
	 3ey0REpEc6tYQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 06 Sep 2024 20:46:09 +0200
Subject: [PATCH net-next v2 3/5] selftests: mptcp: reset the last TS before
 the first test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-net-next-mptcp-ksft-subtest-time-v2-3-31d5ee4f3bdf@kernel.org>
References: <20240906-net-next-mptcp-ksft-subtest-time-v2-0-31d5ee4f3bdf@kernel.org>
In-Reply-To: <20240906-net-next-mptcp-ksft-subtest-time-v2-0-31d5ee4f3bdf@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3916; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=e1LZMuO1zQTgYSCDSU0RSxNy+M19aD9bysgW3jUoe8Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm20375HHQbXcKTOOVq788vhuz9QzoF4Mh1l320
 GMwFNhbtY+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZttN+wAKCRD2t4JPQmmg
 c0GFD/4oPHFgCNiJmp6IXMNFGsNHmUhu2yejtyoiXFhA0+I/F1dgmws3LAl/Tx0+ngjwfShpLh4
 xFDZHv1+cNWOa+TVGQCyUo8FtK6uwHMvA6Cto17K4ur5sRKLBeksqwyMrrs/a8iiHoU6Nhr7rZf
 kfVTO3Z4QOiqeMCzP+MO8JyKW3G21r+J1vq98gGgdQOh4ARo9yi2lbF/G4dGtZwrcmZSMFOt+83
 HDKVkjOJSuY72F0jY3ESMfKZaV5iF3JAynOdozCs4FsSPCOoTe29Djq5JcSDl7qn4RWJP0bm01c
 dC3sVoUQe3f1YN5WEybeyfQBURNI2jn177HGdPY+VElxD+x5Sm3WDClaohrsXqyZGw0dRQ88Zd6
 tdY+DKabUEEyZRV12bRr26oM4hchNFL4qA3IOyLn3G/2ekQvUZo3yBDItoVnm58D69fO+TOhS8j
 R+OMXUZKbcHvuPxLH2LrFQ5cpGajg0BrBf2I39JAUTYiSmlp42H50flg5PE4GEtBudIk4bE6tg1
 LYI6gZP7AUlzhRamY+A/hPy3Xpw6rTW2UXHQE1oldn6mhXC/40/c2psAtzVhmM7olADn9L0Qu1K
 hBdKuFA+XjpyJSKM46aixgGvy1j+Wj8JVRwPso5vzh6cvgqeprUF07x7j7otcsX0TpRk0N/6mf/
 8dR3pYuxjE81Zsg==
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
index 43f8a9bd84c4..3564cd06643c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3959,9 +3959,11 @@ if [ ${#tests[@]} -eq 0 ]; then
 	tests=("${all_tests_names[@]}")
 fi
 
+mptcp_lib_subtests_last_ts_reset
 for subtests in "${tests[@]}"; do
 	"${subtests}"
 done
+append_prev_results
 
 if [ ${ret} -ne 0 ]; then
 	echo
@@ -3972,7 +3974,6 @@ if [ ${ret} -ne 0 ]; then
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


