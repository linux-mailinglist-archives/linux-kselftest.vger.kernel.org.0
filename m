Return-Path: <linux-kselftest+bounces-6122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C428876CCF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73E11F225C9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9083D60EC3;
	Fri,  8 Mar 2024 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBHI8nwF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FE260DFF;
	Fri,  8 Mar 2024 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935840; cv=none; b=rsCOexgAsH8HXIYkH9xNrLPCB9VeZlKLTpm8McdOpTQSpDLPDx45Ll+tZppZc6YBFDPQAYqnRTgw0K7dTkRXMvlKPkApTRpN9UALQnZIocQtcdIEJyzWFr07Z9W4udZiPRbR2niWOfPZ44m5T6oPeuHrUng9gyVgE6Gl6MfVyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935840; c=relaxed/simple;
	bh=WCm5fVeBx2RidgxLFnn5lWB43KtM3GQHbIliD1YqVU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iZVpTcQ0VWsgPzi8PMMwMvXfBNl7dkD5ouuyrsRFNV+Jbb7+nCEbJyYgtSf4YdC1e/eViZwP1OTVwZWZdeisNtwoDoMzNlayWXmtrpR3SKXg7P+k+Xz1jeN7W7k0h5oX2e8YONnPtr7pdXvAVRJd2e4DQbQiWpZPae8tO9KnnB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBHI8nwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE099C43142;
	Fri,  8 Mar 2024 22:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935839;
	bh=WCm5fVeBx2RidgxLFnn5lWB43KtM3GQHbIliD1YqVU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XBHI8nwFQndMIUM6NjYZ0MHgfo37727nk+NWK9l2SQlSveTi1VtIjLd/m87SITQgY
	 W5b7kGpmQXklMGEkalapevHdzKd5m/I2w+f9gPEjUvfYOIwxRfOdLSL1ltik9wkfdt
	 TEV9uNKDjqPpPNTCU3jOQ785ohPO+w9pk82QLY0f9xZWTzEm4TlSHl9gTqeyU1Gzx2
	 dxfk5sYYTUXG0xUkR2R7g+KLw/7TnWv1AbqQrN/FBSrGPll/fyXxmqlfKFx+hT8Ssa
	 Zn4OZqkk4gFwZI3JwGIyVDBob6a3WOJ7yLbGF76mNuNAfxsLQEq6o21dPp7IffEQT1
	 hfrukVONWhz7A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:12 +0100
Subject: [PATCH net-next 05/15] selftests: mptcp: export TEST_COUNTER
 variable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-5-4f42c347b653@kernel.org>
References: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
In-Reply-To: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5783; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yurptwHKr74ItMKbFqhWWBfncz+etA7RPQk0wFWUt/I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zJ+Q4f/pWAZHoygOW8iInggyXcavOWjDfCb
 jdNfpmYXrWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyQAKCRD2t4JPQmmg
 cy+oD/9cmJ5MwO5GH8hc6s1Q4nnmwRo/Bz8E4z/Kp+24qWsnFvKMBv8fWcPQ8vmw38R6W8JO3Sf
 mbkw5nhafYlok9dUoZfqTUwmaHp30bo2Di0f8FwvzsF6ihKWYHYkmW3lNvBEG5X65s5qH9/44tC
 Z3K+YSDyryv+ntoy1X9Y575agkjl4RDMZM4kjeHiTNUL/EG0YFOzVe+UjvzeyFjaABd7eEo+HKy
 cr6N+CtQ7S1xhGPJwQMdFQJZaMTCkOBY392YBEMi2GDTfWQw3SwLTDBovnZLsKo1kvHmdpcujv/
 l59WGAjmURcq4i2wQpZepAg1YFMy0h7Oq7goSEevdpvPORXNl4lbDMRBr+bACRrnQEm1Bunt7C2
 8tg7PldRNf2Hzq2rk+LKA8gDXSkGC4tfBPoYWSdYgLJe8oJ4oMDIG5KJ3mpFfsttJRoEL3s8NM4
 /ibI7yfYESGf448D7HQEC7Attsfo+36yLodipUtvIi/PtJyLF9XSssou3mQMvhusrs5hHDw1yo3
 GsvGboE1WJszao0zDi9uUv/WfL5FoZEm6EkDIMc08xLUD0omTfsNl2CPOnJcGdSpuL0g977DrSU
 TsYycSMY10j2+VeqbcMX2fwT+6iS6V/17lkSOSo+obrm8+JLz0rgVEivjHszIpDo/cW7SA3d/eo
 Gx1TU41R/zhRKmQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Variable TEST_COUNT are used in mptcp_connect.sh and mptcp_join.sh as
test counters, which are initialized to 0, while variable test_cnt are used
in diag.sh and simult_flows.sh, which are initialized to 1. To maintain
consistency, this patch renames them all as MPTCP_LIB_TEST_COUNTER,
initializes it to 1, and exports it into mptcp_lib.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh          |  5 ++---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 15 +++++++--------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  2 ++
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  5 ++---
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index afe862895946..b63510ce2327 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -9,7 +9,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ns=""
-test_cnt=1
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ret=0
@@ -69,7 +68,7 @@ __chk_nr()
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 }
 
 __chk_msk_nr()
@@ -127,7 +126,7 @@ wait_msk_nr()
 		echo "[  ok  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 }
 
 chk_msk_fallback_nr()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index ce9342b241cd..915faee77e25 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -131,7 +131,6 @@ ns2=""
 ns3=""
 ns4=""
 
-TEST_COUNT=0
 TEST_GROUP=""
 
 # This function is used in the cleanup trap
@@ -321,7 +320,7 @@ do_transfer()
 	local extra_args="$7"
 
 	port=$((port + 1))
-	TEST_COUNT=$((TEST_COUNT+1))
+	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
 		extra_args="$extra_args -R $rcvbuf"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1df2d24979a0..4ef0d5ae9dae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -48,7 +48,6 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
-TEST_COUNT=0
 TEST_NAME=""
 nr_blank=6
 
@@ -172,7 +171,7 @@ cleanup()
 
 print_title()
 {
-	printf "%03u %s\n" "${TEST_COUNT}" "${TEST_NAME}"
+	printf "%03u %s\n" "${MPTCP_LIB_TEST_COUNTER}" "${TEST_NAME}"
 }
 
 print_check()
@@ -233,7 +232,7 @@ skip_test()
 
 	local i
 	for i in "${only_tests_ids[@]}"; do
-		if [ "${TEST_COUNT}" -eq "${i}" ]; then
+		if [ "${MPTCP_LIB_TEST_COUNTER}" -eq "${i}" ]; then
 			return 1
 		fi
 	done
@@ -268,7 +267,7 @@ reset()
 
 	TEST_NAME="${1}"
 
-	TEST_COUNT=$((TEST_COUNT+1))
+	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 
 	if skip_test; then
 		last_test_ignored=1
@@ -462,7 +461,7 @@ fail_test()
 
 	# just in case a test is marked twice as failed
 	if [ ${last_test_failed} -eq 0 ]; then
-		failed_tests[${TEST_COUNT}]="${TEST_NAME}"
+		failed_tests[${MPTCP_LIB_TEST_COUNTER}]="${TEST_NAME}"
 		dump_stats
 		last_test_failed=1
 	fi
@@ -973,7 +972,7 @@ do_transfer()
 	local srv_proto="$4"
 	local connect_addr="$5"
 
-	local port=$((10000 + TEST_COUNT - 1))
+	local port=$((10000 + MPTCP_LIB_TEST_COUNTER - 1))
 	local cappid
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
@@ -991,9 +990,9 @@ do_transfer()
 			capuser="-Z $SUDO_USER"
 		fi
 
-		capfile=$(printf "mp_join-%02u-%s.pcap" "$TEST_COUNT" "${listener_ns}")
+		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "${listener_ns}")
 
-		echo "Capturing traffic for test $TEST_COUNT into $capfile"
+		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
 		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
 		cappid=$!
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 5d071b6eb780..63abf4431993 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -10,6 +10,8 @@ readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
+# shellcheck disable=SC2034 # unused at this moment
+MPTCP_LIB_TEST_COUNTER=0
 
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 365fb3d6ef55..3ad663e38c42 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -14,7 +14,6 @@ ns3=""
 capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-test_cnt=1
 ret=0
 bail=0
 slack=50
@@ -126,8 +125,8 @@ do_transfer()
 	local sin=$2
 	local max_time=$3
 	local port
-	port=$((10000+test_cnt))
-	test_cnt=$((test_cnt+1))
+	port=$((10000+MPTCP_LIB_TEST_COUNTER))
+	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 
 	:> "$cout"
 	:> "$sout"

-- 
2.43.0


