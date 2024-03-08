Return-Path: <linux-kselftest+bounces-6121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C8A876CCD
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C56C1C21A1A
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9593760DD4;
	Fri,  8 Mar 2024 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXmCT4vi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EAF60DD0;
	Fri,  8 Mar 2024 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935836; cv=none; b=HfdE74q4fwfi2MqrqfnOU9Dv68WqFjYD60ANG3P8uXRn0CZGMhgMrVhhpFz4mLAUhSrMmcLo5nSfq1u7flzkwJFDELoDA/WZhclY2kEGseU+uVx/j62OP8WmIpGxjy8wc+WLikNPWDME1ksMj7PZkBHm9TxQL3190beWfmyE1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935836; c=relaxed/simple;
	bh=VXfS3QkWb4QTBKWtbjBrmOHymSFfzccAQy0CBA3kINA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M42I3RBkSeIXR0I1dQTX4c5MM/a8tOvjHH3CEMZ0emO/L6LpOjQQJFG/CGHt51eucqTbbg6H2hneIpP7RJaq3tWwRYq2I7TvksUF17UWgSgXfkL1oG7iRWGLgVpyzcZbvUAI1pLUt6ZCrkrJBtukyCNuAuxTOq8cPA62ArALKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXmCT4vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A08C433C7;
	Fri,  8 Mar 2024 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935836;
	bh=VXfS3QkWb4QTBKWtbjBrmOHymSFfzccAQy0CBA3kINA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YXmCT4vizmPLwoq0ClyzaFgwRMlabUXwkemg2eYmY0mirb+h3rYd45WnW3YxKYNkh
	 mYQ2CcxyOBufIuUtKTLV7E8luYeBWtsETikqUlEC31WsKnphwlQR7sVWOeQgAl0f8t
	 mMWRZ5IiGpY0FKOULtii2Nn18JnGIUoUPW7Z4CDP5yJpeovco35VsJ/W7xg4Z+0NES
	 Q8niGxs+Q2C+B8mo3LjPr+Ak79aV7HzKwrTlCGMvtY3r+OVUOK7R9R78jYz6IedQgm
	 B1kRh1YJYW6y5qn67eQkjgx2w0UTHSjKHr65nygr3u1JBb4asqLkO6lBcBJEQdc9+x
	 un8R6sfYMir5A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:11 +0100
Subject: [PATCH net-next 04/15] selftests: mptcp: sockopt: print every test
 result
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-4-4f42c347b653@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5499; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ue8QxXqH8/zNeDcEyTf1Ear/bDXhGP/IbYKP00DKFC8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zJ9rczW87UrP/yHM1zd6cRW2a0393PHMzk3
 vChA6BrR5iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyQAKCRD2t4JPQmmg
 c3ZGEACuRatMijxhY5shAnb9VysLLokTsf0MfQ15Fwdr+goTBPbOBCoEHFNncIXKdRxI3KU+9r4
 zNUPCFBKZd6kSGQCabpuni/vg1Oey4owYEvuVjj+8CGGg1rb/uynIQ7vzyfVcPdl89M592ZGIHv
 +VNaYPzGCtRN9fTOwXRZsOqImFdj4VcTr8HVYs+osUtxZZb3b8tO3jeAlkLd4Vd1drQLlLsg5mx
 4G2wjViq0Dcb3xevYo4vCK9+chsEpOur/K4xaUiZQhO77PlOq/IRw7ZsAO/HlQRGZISfroXS/rP
 wMTAT15Abof4H5MKTRxlZMKellUqYu11R3MVDtTxy1S+/HINFL24V3uZu8P4uGZvCKb+eFLui60
 zxBBLUQjyj7sZcyjH5MjuyIiw2fUR+uKn/Z46K6yLehgJ7SlOGAm9cXSChL//3pvrUlNU4OTx9t
 9T1RltHgpdFJIo3DwqVwX4vrClKUfEQzwk8EmFpF9bVRdE+gE67ZNDtIc0EZb7WH0QWIxkcfa1U
 r8YnvtSxYrGWhnaFWJCPpjym2WeGNLB6Mbt5UpFJWmCempTt1ndXjUysH2StGZbQT9t5yqNZl3+
 /v0V0bsx0KhUHgJaJjqcmXxWVnHff2IZGeYWzCqToqGUYj1zkVOj9no0GX9TdvYTK0YIeYx3wnG
 suZiOxQ6FHdw4oQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Only total test results are printed out in mptcp_sockopt.sh:

PASS: all packets had packet mark set
PASS: SOL_MPTCP getsockopt has expected information
PASS: TCP_INQ cmsg/ioctl -t tcp
PASS: TCP_INQ cmsg/ioctl -6 -t tcp
PASS: TCP_INQ cmsg/ioctl -r tcp
PASS: TCP_INQ cmsg/ioctl -6 -r tcp
PASS: TCP_INQ cmsg/ioctl -r tcp -t tcp

They mismatch with the test results:

ok 1 - mptcp_sockopt: mark ipv4
ok 2 - mptcp_sockopt: transfer ipv4
ok 3 - mptcp_sockopt: mark ipv6
ok 4 - mptcp_sockopt: transfer ipv6
ok 5 - mptcp_sockopt: sockopt v4
ok 6 - mptcp_sockopt: sockopt v6
ok 7 - mptcp_sockopt: TCP_INQ: -t tcp
ok 8 - mptcp_sockopt: TCP_INQ: -6 -t tcp
ok 9 - mptcp_sockopt: TCP_INQ: -r tcp
ok 10 - mptcp_sockopt: TCP_INQ: -6 -r tcp
ok 11 - mptcp_sockopt: TCP_INQ: -r tcp -t tcp

'mptcp_sockopt.sh' now display more detailed results + why (what you had
in a former patch from v6, merged here). It no longer displays 'PASS:',
because it is duplicated info now that the detailed are displayed:

Transfer v4                                       [ OK ]
Mark v4                                           [ OK ]
Transfer v6                                       [ OK ]
Mark v6                                           [ OK ]
SOL_MPTCP sockopt v4                              [ OK ]
SOL_MPTCP sockopt v6                              [ OK ]
TCP_INQ cmsg/ioctl -t tcp                         [ OK ]
TCP_INQ cmsg/ioctl -6 -t tcp                      [ OK ]
TCP_INQ cmsg/ioctl -r tcp                         [ OK ]
TCP_INQ cmsg/ioctl -6 -r tcp                      [ OK ]
TCP_INQ cmsg/ioctl -r tcp -t tcp                  [ OK ]

Also fix the TAP output:

ok 1 - mptcp_sockopt: transfer ipv4
ok 2 - mptcp_sockopt: mark ipv4
ok 3 - mptcp_sockopt: transfer ipv6
ok 4 - mptcp_sockopt: mark ipv6
ok 5 - mptcp_sockopt: sockopt v4
ok 6 - mptcp_sockopt: sockopt v6
ok 7 - mptcp_sockopt: TCP_INQ: -t tcp
ok 8 - mptcp_sockopt: TCP_INQ: -6 -t tcp
ok 9 - mptcp_sockopt: TCP_INQ: -r tcp
ok 10 - mptcp_sockopt: TCP_INQ: -6 -r tcp
ok 11 - mptcp_sockopt: TCP_INQ: -r tcp -t tcp

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 42 +++++++++++++---------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 7c70b52e63c6..17b36c1312f4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -113,6 +113,11 @@ check_mark()
 	return 0
 }
 
+print_title()
+{
+	printf "%-50s" "${@}"
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -162,8 +167,9 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
-		echo " client exit code $retc, server $rets"
+		echo "[FAIL] client exit code $retc, server $rets"
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
 
@@ -175,7 +181,14 @@ do_transfer()
 		ret=1
 		return 1
 	fi
+	if ! mptcp_lib_check_transfer $cin $sout "file received by server"; then
+		rets=1
+	else
+		echo "[ OK ]"
+	fi
+	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
+	print_title "Mark ${ip:2}"
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -184,15 +197,13 @@ do_transfer()
 		check_mark $connector_ns 4 || retc=1
 	fi
 
-	mptcp_lib_check_transfer $cin $sout "file received by server"
-	rets=$?
-
 	mptcp_lib_result_code "${retc}" "mark ${ip}"
-	mptcp_lib_result_code "${rets}" "transfer ${ip}"
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
+		echo "[ OK ]"
 		return 0
 	fi
+	echo "[FAIL]"
 
 	return 1
 }
@@ -221,23 +232,27 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 
+	print_title "SOL_MPTCP sockopt v4"
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt"
+		echo "[FAIL]"
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
+	echo "[ OK ]"
 	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
+	print_title "SOL_MPTCP sockopt v6"
 	if [ $lret -ne 0 ]; then
-		echo "FAIL: SOL_MPTCP getsockopt (ipv6)"
+		echo "[FAIL]"
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
+	echo "[ OK ]"
 	mptcp_lib_result_pass "sockopt v6"
 }
 
@@ -260,16 +275,17 @@ run_tests()
 
 do_tcpinq_test()
 {
+	print_title "TCP_INQ cmsg/ioctl $*"
 	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "FAIL: mptcp_inq $*"
+		echo "[FAIL]"
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
 
-	echo "PASS: TCP_INQ cmsg/ioctl $*"
+	echo "[ OK ]"
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
@@ -315,15 +331,7 @@ trap cleanup EXIT
 run_tests $ns1 $ns2 10.0.1.1
 run_tests $ns1 $ns2 dead:beef:1::1
 
-if [ $ret -eq 0 ];then
-	echo "PASS: all packets had packet mark set"
-fi
-
 do_mptcp_sockopt_tests
-if [ $ret -eq 0 ];then
-	echo "PASS: SOL_MPTCP getsockopt has expected information"
-fi
-
 do_tcpinq_tests
 
 mptcp_lib_result_print_all_tap

-- 
2.43.0


