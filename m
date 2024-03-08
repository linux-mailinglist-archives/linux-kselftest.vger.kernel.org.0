Return-Path: <linux-kselftest+bounces-6132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1781876CEE
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6176B1F227CF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6192F65BAD;
	Fri,  8 Mar 2024 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+v54EXi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A465BA9;
	Fri,  8 Mar 2024 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935876; cv=none; b=T0n5+rq1gtE7QaPWxzQRPoUf5uXRHyBBSJBRuF1Dk/pcnBB0If+8tasB786B8VW9hwMbsYY88JYGATogsBlzedp1hebiArIJ0mR/I+ziukaT4PTgm0Oo9QXSmmKgC7l2FHlLiAZR9qts9XawCDGbHVjctk+YSuUppG3gHkqD61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935876; c=relaxed/simple;
	bh=NDO5GUxYDlFqdD8WdhJZtIxFwcsqQH8196TFTWPwy14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3uHKUuWx24kdUBM1wEGAOMUpU9LCRlLfNwuiRfJTBSnFH5oLBUPo8FzOwiaFXlff+qqRtt7NjLZ0dzG5+BVRfin4QX+tEJvD4g+NeRshtDLPh56Z98S6tOuT2pDhLjTcaHO4ma4uoRB26eT73mNmzKpbTX/f7gleECr+2kgu7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+v54EXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71849C43394;
	Fri,  8 Mar 2024 22:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935875;
	bh=NDO5GUxYDlFqdD8WdhJZtIxFwcsqQH8196TFTWPwy14=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m+v54EXif8ZlMTJ7Equ3gKVaVQH8X2Zs5jqRsWksfQI2xWOOByZG7DnH++Q3kKSBa
	 yYldrq1GFieW3gf23iS3yvSlJm8i+TUjsByAstvz6+9CHTdcxj6KMyMD5es5oL+PgW
	 YGPaiMWn29FVpZ4ehvJGFKWHMx7G2oTigcN3TZ6yRIS/uNZBiALCe8hdU1FZR+tM7s
	 zkqbfjQASclPbX9ML6sgj0guUAlKCqNC90AsNpJqUwQbSUtKVXrShfcNtoSxSvUL2f
	 cEFAvs0vwJgYRJMb6jAd4saEcEbY6KhWxcH34HwD2ZJee2ZDpsLA7UuBHb9f/2+nzq
	 jQNxebGULZVHg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:22 +0100
Subject: [PATCH net-next 15/15] selftests: mptcp: use
 KSFT_SKIP/KSFT_PASS/KSFT_FAIL
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-15-4f42c347b653@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7667; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MFPhv4UY1RWRBU0fNNptB2KkxW4wGTFhXA3Gm+mmJuQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zKklzPyBogkU+fFBi02DdhEwZKmZJbLnVKP
 x3ro4RS0sqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMygAKCRD2t4JPQmmg
 czttEACQ2l2oM/feheHfkCJteq36rDV31r/McILK38NIK47znYj0oxSrAw5hQ/rD/WBK3utLNSz
 uU51Dk0qGnxzXnp9tWkmZE7nFe/lYd8Q+C9D5dn9swyniriVy3qs6wjLnPHRtXme9yQqvdHDBwI
 26VgouHTX9yVRSPvg3wieY6bBPQN5xaZCS0e5MADkM7VL52ZohEUBr01ShFBXsEQY/Wz0n0fnbM
 pUoscKHgk0SeVZJTdiBHHf7TeisUxjZIfNWvuBFKu4W/aj7hMlB2pG+IyrAugMzX4RocyXxbEzP
 7p+KaASPLBz4i5Mth/tFPMJuraQwB4NPfAM1E38ccApqmnNwezp19pHEapTd5Qle42eBWjHlJn0
 82g/E38JcHUZGtqpY2Zl4OenSeA792E0Ul6rcmw2ezZ9Pqg6wr1VYGOuGIrb1efPHw4/x+aLH58
 Gf5Z2ruVRLESJmy4Ynwuk8s01DiUojzIwxOvpzUFZKwuL6wvl6OXKNVDbyoN3FNF8anzdXVB4Vv
 aPVW6SGPNvP4yzmzudWPiBsqxyhh0HUrRVJ0jh4YcuJ7weTh6B9d1Fxp+QODpu+l+CgJgfFOOkz
 i00MaZ0Ye/QyOWrImpOdDYBI83cJZqRuOuIZ9A37z2kekwrJGqf7ZXlvMRj4iaasfGTm2fUzRre
 zN+3kPT+wVrnwng==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses the public var KSFT_SKIP in mptcp_lib.sh instead of
ksft_skip, and drop 'ksft_skip=4' in mptcp_join.sh.

Use KSFT_PASS and KSFT_FAIL macros instead of 0 and 1 after 'exit '
and 'ret=' in all scripts:

        exit 0 -> exit ${KSFT_PASS}
        exit 1 -> exit ${KSFT_FAIL}
         ret=0 ->  ret=${KSFT_PASS}
         ret=1 ->  ret=${KSFT_FAIL}

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 18 +++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 13 ++++++-------
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  4 ++--
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  8 ++++----
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  4 ++--
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  4 ++--
 6 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index cb1837f2761a..4c4248554826 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -65,14 +65,14 @@ while getopts "$optstring" option;do
 	case "$option" in
 	"h")
 		usage $0
-		exit 0
+		exit ${KSFT_PASS}
 		;;
 	"d")
 		if [ $OPTARG -ge 0 ];then
 			tc_delay="$OPTARG"
 		else
 			echo "-d requires numeric argument, got \"$OPTARG\"" 1>&2
-			exit 1
+			exit ${KSFT_FAIL}
 		fi
 		;;
 	"e")
@@ -96,7 +96,7 @@ while getopts "$optstring" option;do
 			sndbuf="$OPTARG"
 		else
 			echo "-S requires numeric argument, got \"$OPTARG\"" 1>&2
-			exit 1
+			exit ${KSFT_FAIL}
 		fi
 		;;
 	"R")
@@ -104,7 +104,7 @@ while getopts "$optstring" option;do
 			rcvbuf="$OPTARG"
 		else
 			echo "-R requires numeric argument, got \"$OPTARG\"" 1>&2
-			exit 1
+			exit ${KSFT_FAIL}
 		fi
 		;;
 	"m")
@@ -121,7 +121,7 @@ while getopts "$optstring" option;do
 		;;
 	"?")
 		usage $0
-		exit 1
+		exit ${KSFT_FAIL}
 		;;
 	esac
 done
@@ -263,7 +263,7 @@ check_mptcp_disabled()
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
 		mptcp_lib_pr_fail "net.mptcp.enabled sysctl is not 1 by default"
 		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
-		ret=1
+		ret=${KSFT_FAIL}
 		return 1
 	fi
 	ip netns exec ${disabled_ns} sysctl -q net.mptcp.enabled=0
@@ -276,7 +276,7 @@ check_mptcp_disabled()
 	if [ ${err} -eq 0 ]; then
 		mptcp_lib_pr_fail "New MPTCP socket cannot be blocked via sysctl"
 		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
-		ret=1
+		ret=${KSFT_FAIL}
 		return 1
 	fi
 
@@ -302,7 +302,7 @@ do_ping()
 
 	if [ $rc -ne 0 ] ; then
 		mptcp_lib_pr_fail "$listener_ns -> $connect_addr connectivity"
-		ret=1
+		ret=${KSFT_FAIL}
 
 		return 1
 	fi
@@ -821,7 +821,7 @@ log_if_error()
 		mptcp_lib_pr_fail "${msg}"
 
 		final_ret=${ret}
-		ret=0
+		ret=${KSFT_PASS}
 
 		return ${final_ret}
 	fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 728575fd86ea..5e9211e89825 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -25,7 +25,6 @@ err=""
 capout=""
 ns1=""
 ns2=""
-ksft_skip=4
 iptables="iptables"
 ip6tables="ip6tables"
 timeout_poll=30
@@ -392,15 +391,15 @@ setup_fail_rules()
 		-p tcp \
 		-m length --length 150:9999 \
 		-m statistic --mode nth --packet 1 --every 99999 \
-		-j MARK --set-mark 42 || return ${ksft_skip}
+		-j MARK --set-mark 42 || return ${KSFT_SKIP}
 
-	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${ksft_skip}
+	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${KSFT_SKIP}
 	tc -n $ns2 filter add dev ns2eth$i egress \
 		protocol ip prio 1000 \
 		handle 42 fw \
 		action pedit munge offset 148 u8 invert \
 		pipe csum tcp \
-		index 100 || return ${ksft_skip}
+		index 100 || return ${KSFT_SKIP}
 }
 
 reset_with_fail()
@@ -414,7 +413,7 @@ reset_with_fail()
 	local rc=0
 	setup_fail_rules "${@}" || rc=$?
 
-	if [ ${rc} -eq ${ksft_skip} ]; then
+	if [ ${rc} -eq ${KSFT_SKIP} ]; then
 		mark_as_skipped "unable to set the 'fail' rules"
 		return 1
 	fi
@@ -450,7 +449,7 @@ reset_with_tcp_filter()
 # $1: err msg
 fail_test()
 {
-	ret=1
+	ret=${KSFT_FAIL}
 
 	if [ ${#} -gt 0 ]; then
 		print_fail "${@}"
@@ -3632,7 +3631,7 @@ usage()
 {
 	if [ -n "${1}" ]; then
 		echo "${1}"
-		ret=1
+		ret=${KSFT_FAIL}
 	fi
 
 	echo "mptcp_join usage:"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 96aa8f71bbb0..e2d70c18786e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -105,7 +105,7 @@ check_mark()
 		if [ $v -ne 0 ]; then
 			mptcp_lib_pr_fail "got $tables $values in ns $ns," \
 					  "not 0 - not all expected packets marked"
-			ret=1
+			ret=${KSFT_FAIL}
 			return 1
 		fi
 	done
@@ -178,7 +178,7 @@ do_transfer()
 
 		mptcp_lib_result_fail "transfer ${ip}"
 
-		ret=1
+		ret=${KSFT_FAIL}
 		return 1
 	fi
 	if ! mptcp_lib_check_transfer $cin $sout "file received by server"; then
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 69ffff8b076b..6ab8c5d36340 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -19,11 +19,11 @@ while getopts "$optstring" option;do
 	case "$option" in
 	"h")
 		usage $0
-		exit 0
+		exit ${KSFT_PASS}
 		;;
 	"?")
 		usage $0
-		exit 1
+		exit ${KSFT_FAIL}
 		;;
 	esac
 done
@@ -57,13 +57,13 @@ check()
 	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
 	if [ ${rc} -eq 2 ]; then
 		mptcp_lib_result_fail "${msg} # error ${rc}"
-		ret=1
+		ret=${KSFT_FAIL}
 	elif [ ${rc} -eq 0 ]; then
 		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
 	elif [ ${rc} -eq 1 ]; then
 		mptcp_lib_result_fail "${msg} # different output"
-		ret=1
+		ret=${KSFT_FAIL}
 	fi
 }
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index e62052c3206d..1b2366220388 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -263,7 +263,7 @@ while getopts "bcdh" option;do
 	case "$option" in
 	"h")
 		usage $0
-		exit 0
+		exit ${KSFT_PASS}
 		;;
 	"b")
 		bail=1
@@ -276,7 +276,7 @@ while getopts "bcdh" option;do
 		;;
 	"?")
 		usage $0
-		exit 1
+		exit ${KSFT_FAIL}
 		;;
 	esac
 done
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 72dca742280f..9e2981f2d7f5 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -89,7 +89,7 @@ test_fail()
 	then
 		mptcp_lib_pr_fail "${@}"
 	fi
-	ret=1
+	ret=${KSFT_FAIL}
 	mptcp_lib_result_fail "${test_name}"
 }
 
@@ -209,7 +209,7 @@ make_connection()
 	else
 		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
 		mptcp_lib_result_print_all_tap
-		exit 1
+		exit ${KSFT_FAIL}
 	fi
 
 	if [ "$is_v6" = "v6" ]

-- 
2.43.0


