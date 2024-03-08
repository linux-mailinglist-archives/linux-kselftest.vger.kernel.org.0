Return-Path: <linux-kselftest+bounces-6127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BD8876CDE
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0DB2827AD
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BCD629F1;
	Fri,  8 Mar 2024 22:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9cutr8c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36246629E2;
	Fri,  8 Mar 2024 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935858; cv=none; b=KBrRMyzY3LpYQTF1XTOUnlZk0lHS+P+0/JMaZ7FveNRpCQikhwa9Lik0LXZuOk3GUeNh8iXkmizPPFoYblV2a3w7NBctUEfrwYoU4QBgW66/AiytmL1+YKnNQPsNfGNKcgzIn49gBGk3Yb8tKfvwgKAvYcVIButBhZcu94/v10g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935858; c=relaxed/simple;
	bh=qhWKz2Hx+SC+H9/gRU/WVHYJNNy2Y+xaeP8ticJ8Clo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f+r+bQUEPdX+TFilYe+vRIcRo41rI0WBFW6uz3fWq0gLYQHcZE3SL8k/VWtXCAbXI49BMyfiNZbQbfXOW7R+pOLjt9qpNDhvxfZ6d2eBVV553DXJXlC3Ns587qNYwkhwQ88epTpQFLI23lDqLuK2k3Bm3Mooqvr2VU8k8hvfkQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9cutr8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3991C43394;
	Fri,  8 Mar 2024 22:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935857;
	bh=qhWKz2Hx+SC+H9/gRU/WVHYJNNy2Y+xaeP8ticJ8Clo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S9cutr8cVnAGZ+0+U60qZ15JFOgcPicvwRumj8vW+1Q8bJV9XVNj3twU2xmG8TfVn
	 wIlBJjZvQywS3uTAmQ6ON4R8q7ftsjurNQV04O1g/7h2XtNOikZXo4PptIbDUgIeWY
	 4uQ2xVqbFfbnm7i/GvvE5d5X6nN+WFaWZ1anT9okaNLqMKGg+GGCaYFk5x97gLijha
	 SGvl9JCx6xicYiArKscN1W8V3xDl4sdUanGueLXSgxtAgGAyptIGsfa0ZnqSJ2OqWg
	 2lOZ6Zfst30P9bRm3Rmi0SmrqHIaT152Xpztnbhc4LvCvVDPCG5BBiPwz/7zEz5ZZy
	 hSTaM7TCeI5sA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:17 +0100
Subject: [PATCH net-next 10/15] selftests: mptcp: call test_fail without
 argument
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-10-4f42c347b653@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2735; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hyKC6Mx+pB1z+Ddbi6L//7nB2D7vJLp369U14/WWHzc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zJmqFOtfe7CB9QgpGxydbJnWN0jqXZ809Xv
 U41c9p8UEaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyQAKCRD2t4JPQmmg
 czwvD/9De9QKe5Zxvv4hxisXhRIUJYxEldA89+8zDFVZuAhCSU7qgRFX73kvU2CMS49dX7G3NPT
 SvXiQ85vBsQqPqT/DCOMrvJN1+7p3tbvz5hZR5qtqAPlUX4ffkYqvXYhxvuAPcAwZVDiLHxGQy0
 VQKXmfWRZHeIdBqPQHgB6TJH8HBxI0AqTObL55O85aTqJclrHUJ28K7yClN8HAss9UHdaO5Ncev
 z4966/oifLuBwLSDhR1N9Nri1L1JUp5EX3LP45Ka/NlBt56YlJeY0Le0qGBPd5W4v5srXgKYaOV
 ToQO6+QBPjZ+P+W5UPhu5P+OwZXYWzpA5NtF+W9PPkZAc28ok3L3WIxCQXPAsdkZvZqhPWmzPqJ
 Y0wEoGEfXXFYnQJahC0ePEu7AdLW8Tjsv6DtmEwBAc0iSMX3APQidlwNCn6UX2OA/Td35JoMTrO
 qnmpevZL1ulgaqL3zdbwylxJs/UVQ7eHzPeETp0cU4Gs/77awTV1oyLCIfCxkGO1N5q7o8GeZty
 ZCTTXvWrTBNpSODDrYi89bhnmSNe8xFaOOtIR/d3itt6t9VbCOt3lWxEvMkcBTD2IojrTzu9yZm
 E562xQx2DrApH70qyeviA07SEG4l1EImJ/vV/+ljzvIoKBr5fEgreXiPQQhe5gDSfRPV9wkko9P
 rlxj+7Aa+GtryzQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch modifies test_fail() to call mptcp_lib_pr_fail() only if there
are arguments (if [ ${#} -gt 0 ]) in userspace_pm.sh, add arguments
"unexpected type: ${type}" when calling test_fail() from test_remove().
Then mptcp_lib_pr_fail() can be used in check_expected_one() instead of
test_fail().

The same in mptcp_join.sh, calling fail_test() without argument, and adapt
this helper not to call print_fail() in this case.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |  7 +++++--
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 ++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9f67b9ba97d8..041175ec1304 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -452,7 +452,9 @@ fail_test()
 {
 	ret=1
 
-	print_fail "${@}"
+	if [ ${#} -gt 0 ]; then
+		print_fail "${@}"
+	fi
 
 	# just in case a test is marked twice as failed
 	if [ ${last_test_failed} -eq 0 ]; then
@@ -2834,7 +2836,8 @@ verify_listener_events()
 		print_ok
 		return 0
 	fi
-	fail_test "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
+	print_fail "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
+	fail_test
 }
 
 add_addr_ports_tests()
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 4e29aa9c2529..bc2f0184b1eb 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -85,7 +85,10 @@ test_skip()
 # $1: msg
 test_fail()
 {
-	mptcp_lib_pr_fail "${@}"
+	if [ ${#} -gt 0 ]
+	then
+		mptcp_lib_pr_fail "${@}"
+	fi
 	ret=1
 	mptcp_lib_result_fail "${test_name}"
 }
@@ -239,7 +242,7 @@ check_expected_one()
 
 	if [ "${prev_ret}" = "0" ]
 	then
-		test_fail
+		mptcp_lib_pr_fail
 	fi
 
 	mptcp_lib_print_err "\tExpected value for '${var}': '${!exp}', got '${!var}'."
@@ -263,6 +266,7 @@ check_expected()
 		return 0
 	fi
 
+	test_fail
 	return 1
 }
 
@@ -412,7 +416,7 @@ test_remove()
 	then
 		test_pass
 	else
-		test_fail
+		test_fail "unexpected type: ${type}"
 	fi
 
 	# RM_ADDR using an invalid addr id should result in no action
@@ -425,7 +429,7 @@ test_remove()
 	then
 		test_pass
 	else
-		test_fail
+		test_fail "unexpected type: ${type}"
 	fi
 
 	# RM_ADDR from the client to server machine

-- 
2.43.0


