Return-Path: <linux-kselftest+bounces-16942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80602968523
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1969B263ED
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E141C1D4616;
	Mon,  2 Sep 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDkJM93M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33E01D4143;
	Mon,  2 Sep 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273984; cv=none; b=r1bLxsUUNcSfCvALpmirDbGxh7ws5HG/sMJ1gjNmhmhsnkMWOsFwfbYa/xDTTRyR9yym3EAr1Al6hX3LwsCRhx1C6J8aZ6PkX4fd6mVgCcKGLv1wSozc9A4PmJ7SsRSImPiPOUXJ6+r6NU24pdx/HrVfBWL9Sux6DxEntQVv2sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273984; c=relaxed/simple;
	bh=tUo0nLrP36L6x+okdrn5Z90Ji+YrwAHRvl46fXw1QCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWspjMduDf9OQxvA6X9clZ0QOLc72/HP9kK/BMmAbfG9PzMFAkW+H5aagTKRlf3oLq5jTg95Coxe30qj2K4EKL3bkYUfwDZXTZjbyzyz87XmXfz8AIhAy7wbiw3pRJo4ZOF74IXwyTAbzyRxeINiMyiTTb0xh2bZ64G6qiwkcI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDkJM93M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04358C4CEC9;
	Mon,  2 Sep 2024 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725273984;
	bh=tUo0nLrP36L6x+okdrn5Z90Ji+YrwAHRvl46fXw1QCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CDkJM93MZKyiTqLD3Aks+OcSgejehAdGXgLzgcksQMhDNb37sQdkiWStUwavJZbzv
	 xA00oWhgWxCfIhV6VXshq87H9c5Gvjxv7IpoBhFkubAbnqW5Vm8iY9u6R2etUjMSbH
	 iDpMdthdguJiZDZlhQ0B+81PPX9rjKYhb5jh75kzpVLRTDBKeeAPHn73mlz1m4xMeG
	 8y+M5HF07443XFvGEXPL8JmxqF2fAiIeKcA3qxIJkBvwHUymZGQqdSkAAJeeVE+pJV
	 uebk6lVEe5FpE4m2aDwgNEDGNJYdP/mRMmdrDLiQC60Xqu0Hb8jg7ON17bQDWP7IVr
	 i53VTjq47cXBA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 12:45:56 +0200
Subject: [PATCH net-next 05/11] selftests: mptcp: join: one line for join
 check
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-5-d3e0f3773b90@kernel.org>
References: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3142; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tUo0nLrP36L6x+okdrn5Z90Ji+YrwAHRvl46fXw1QCE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1ZdtEPeQwahWJkdBAkYgGL4Gxpjyb2PHUW4iN
 l5RsqMKzHqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWXbQAKCRD2t4JPQmmg
 cxS5D/92T2d5kqAXhMi9rzJhdnAFjjuDKxY8bhvxbuxrFrD8jrZwXUnq/Vj8pJOOH2Bp3rYglcY
 /aR36On762L1cdum8QBtjW9Dnda2+erpAugTbDOVDa2Mfmp+1GOXDQAgs3aKCl5+500hvYkO7HT
 nru/u1uNL/7nzS3ULij0UWuGIzG+1K6sFQHISUrLx9xnpKe2znj72qaqRIVQ7FJsHpPGJw8L9qM
 OZP5MJapYfjI2mYIJ6Z4ueqYMo4PiEkZU8kQxHI7wjEKlN9ajMk7aCizMXHY3FZnN4Qjh1j9Y9d
 K0YWedQ8kGWuIXGObmHp/fX5c9eXEBuvQPXi/apPoXXlXf1RPVICXCgMfQpnVTq9YlDyLc6eDf7
 LlINS4et0buwqTuxhuv/S3AxpNSPpUQYMHG793MOV8mP+Qz9/hZF8Ts/IhO2TDX/FQNWecywMfP
 BHzuRM+t4nugrWPvv2vGyU4rJ1U3TPZNC1ZOSexDIjAYpJMpExjycPnmvA7cPPCMr7afmYG96JF
 kxV4uNUUlO6w2SZgUi6uKnz4roEAjVmj0xN0shA1DSx1NzCjE8QCmcVREN3nbC7vl6MyWvL4fdl
 aXUL/xHgECtP7+SZOIxVreC2wsBVJ8HuDSbbRlzKekwFVqUjxsAHmkDGKmvRwnUvry6hjNNEx0a
 keWHyQq1kG/pB0A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Most tests are checking if the expected number of SYN/SYN+ACK/ACK JOINs
have been received, each of them on one line.

More Join related tests are going to be checked soon, no need to add 5
new lines per test in case of success, just one is enough. In case of
issue, the errors will still be reported like before.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 45 ++++++++++++++++---------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 51b226784c6b..63580a5810bf 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -202,6 +202,22 @@ print_skip()
 	mptcp_lib_pr_skip "${@}"
 }
 
+# $1: check name; $2: rc
+print_results()
+{
+	local check="${1}"
+	local rc=${2}
+
+	print_check "${check}"
+	if [ ${rc} = ${KSFT_PASS} ]; then
+		print_ok
+	elif [ ${rc} = ${KSFT_SKIP} ]; then
+		print_skip
+	else
+		fail_test "see above"
+	fi
+}
+
 # [ $1: fail msg ]
 mark_as_skipped()
 {
@@ -1331,6 +1347,7 @@ chk_join_nr()
 	local rst_nr=${join_rst_nr:-0}
 	local infi_nr=${join_infi_nr:-0}
 	local corrupted_pkts=${join_corrupted_pkts:-0}
+	local rc=${KSFT_PASS}
 	local count
 	local with_cookie
 
@@ -1338,43 +1355,41 @@ chk_join_nr()
 		print_info "${corrupted_pkts} corrupted pkts"
 	fi
 
-	print_check "syn"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinSynRx")
 	if [ -z "$count" ]; then
-		print_skip
+		rc=${KSFT_SKIP}
 	elif [ "$count" != "$syn_nr" ]; then
+		rc=${KSFT_FAIL}
+		print_check "syn"
 		fail_test "got $count JOIN[s] syn expected $syn_nr"
-	else
-		print_ok
 	fi
 
-	print_check "synack"
 	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
 	if [ -z "$count" ]; then
-		print_skip
+		rc=${KSFT_SKIP}
 	elif [ "$count" != "$syn_ack_nr" ]; then
 		# simult connections exceeding the limit with cookie enabled could go up to
 		# synack validation as the conn limit can be enforced reliably only after
 		# the subflow creation
-		if [ "$with_cookie" = 2 ] && [ "$count" -gt "$syn_ack_nr" ] && [ "$count" -le "$syn_nr" ]; then
-			print_ok
-		else
+		if [ "$with_cookie" != 2 ] || [ "$count" -le "$syn_ack_nr" ] || [ "$count" -gt "$syn_nr" ]; then
+			rc=${KSFT_FAIL}
+			print_check "synack"
 			fail_test "got $count JOIN[s] synack expected $syn_ack_nr"
 		fi
-	else
-		print_ok
 	fi
 
-	print_check "ack"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
 	if [ -z "$count" ]; then
-		print_skip
+		rc=${KSFT_SKIP}
 	elif [ "$count" != "$ack_nr" ]; then
+		rc=${KSFT_FAIL}
+		print_check "ack"
 		fail_test "got $count JOIN[s] ack expected $ack_nr"
-	else
-		print_ok
 	fi
+
+	print_results "join Rx" ${rc}
+
 	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr

-- 
2.45.2


