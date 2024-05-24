Return-Path: <linux-kselftest+bounces-10676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225898CE8B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 18:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CA01F21C4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1112F381;
	Fri, 24 May 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLZzraza"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC25C12F376;
	Fri, 24 May 2024 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568271; cv=none; b=A4TDHokGyWQYuTg4HlyzAznQ9vj0M+ijldFivCBLkZUkNjT5P7nHL1vI5KW83WgSm5vuNvS2wQ9+A6hTNfmjCdlMtpLa5OjtsShjKtXHgcAOji46JTQjDk11dcuTg13xbhMfq8DGc+eVXJxVg/iWfsO9Vms718dnBwAO+SpIAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568271; c=relaxed/simple;
	bh=yPbJdqedAncEfT9IzQBXiQKofuqC24Di2UVNAhdVr8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4jSP0xnE9JEPMAqLLDv8qC/4L09Pb8U1xak0RatNQxoEN7rNxm34qREQuKSXWlNFIrifooPh+hP+p+3uiL24VXlntA7JQ4FzMcA4K+zgFVxoQTUZ0nuulsyGQGvkE+KGmjoNw2C9WA04EXiho8gbUBUCYasPdKsj5W6VzVHx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLZzraza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFBEC2BD11;
	Fri, 24 May 2024 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716568270;
	bh=yPbJdqedAncEfT9IzQBXiQKofuqC24Di2UVNAhdVr8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sLZzrazaIibQ5T5WyD9u/2TYer8rLSQfZxwV9vQKz44HLRBJnngS9/m5//VAg0bQG
	 KNBrt9ypGtCENRomuWlJ09aYc6SukFFJNjDDWP/++Vf0XDvPdn3FOtNs6ni1MTLeWm
	 AbqlMMED9FFoEoXsgC3QvoiK/VXVkmZYhShqhIcWQ6b3Z3kQDTf0pFJQ4wDNnie6AL
	 z7iotGnZ9NN4UrVZH1MtD/rsBIQouVB9eT+IQ68msdngHFIOfVAilQ3p1P5Mp+GPmM
	 jwpMk0V6a1G1Ykqm0qptrMfn81c1s0XhREjbc/n6FaBxZynMGOr3x6vmvbrE0Ztwy2
	 p5O/YndBgbbOQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 May 2024 18:30:56 +0200
Subject: [PATCH net 1/4] selftests: mptcp: lib: support flaky subtests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-1-a352362f3f8e@kernel.org>
References: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-0-a352362f3f8e@kernel.org>
In-Reply-To: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-0-a352362f3f8e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2969; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yPbJdqedAncEfT9IzQBXiQKofuqC24Di2UVNAhdVr8g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUMDItdM/SWeKpNfMnuffNtE+vb+fB1JmoEoz4
 zoVGlb1VyWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlDAyAAKCRD2t4JPQmmg
 c35LD/4lqaM6MJarjFRt6PaKbiGLcgwwsS7B1M2hMZXcOlZdwzHTgdAVykgT4tAg706JjnB1RCE
 ZVnOp5wLspFf5Orj9nc4TZ9POGeOQSc4MLV2NMyYoD2J2F1GiNMW+DchObTWjGeFF2KwR6Ip8UC
 QPhTQ/3Rhn+eVAdChopjbUTs3GduncC1lZ5m0DSejvhJiGZpTjaF5HS5TdHzI4uoGSAjuFpEme9
 SerOuOHJzxMKAJIoFoD4Ool3huj5TQv770zkKKAvVpc8ZxYlIexft6GuckUdcMqHSXSBRUwPYXf
 hUjeHqj+1c5buki7zG9trATieSl9uNZoplxoXEwm7t5fjZlANJieDPYRlUwkbnv8DdHXw7AeMiI
 0XNuyShnH9CaLiML3Sgi90YJUBWzb5GJC0ORFRTeZ8BL4mGIwBN4Z15bwaRsk7lM4KMW/kX8QOm
 wlX5Ke7dDNvE0aPGulrLYPEBvO+uEK1aj+2G8JNMKtixsIXqW3FiKc2fvbq8cbOLe6r/hQ5iiKw
 6GrqgJXSoy+t6XwqrS7dRq52loe6Dtl+HQycHKFrJwgQUvL7vBGT87zFrP2dLoD2KNlM0sqmBx+
 F9CpAsuexfEe+XDhjqNf7H/g2byi95hwxhY7f/1aaCSG5PTri0XDPqaZWHabh1z0rwccc02+VgR
 Wb2sEsZIPPTBJ8A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some subtests can be unstable, failing once every X runs. Fixing them
can take time: there could be an issue in the kernel or in the subtest,
and it is then important to do a proper analysis, not to hide real bugs.

To avoid creating noises on the different CIs, it is important to have a
simple way to mark subtests as flaky, and ignore the errors. This is
what this patch introduces: subtests can be marked as flaky by setting
MPTCP_LIB_SUBTEST_FLAKY env var to 1, e.g.

  MPTCP_LIB_SUBTEST_FLAKY=1 <run flaky subtest>

The subtest will be executed, and errors (if any) will be ignored. It is
still good to run these subtests, as it exercises code, and the results
can still be useful for the on-going investigations.

Note that the MPTCP CI will continue to track these flaky subtests by
setting SELFTESTS_MPTCP_LIB_OVERRIDE_FLAKY env var to 1, and a ticket
has to be created before marking subtests as flaky.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 30 ++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ad2ebda5cb64..6ffa9b7a3260 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -21,6 +21,7 @@ declare -rx MPTCP_LIB_AF_INET6=10
 
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
+MPTCP_LIB_SUBTEST_FLAKY=0
 MPTCP_LIB_TEST_COUNTER=0
 MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 MPTCP_LIB_IP_MPTCP=0
@@ -41,6 +42,16 @@ else
 	readonly MPTCP_LIB_COLOR_RESET=
 fi
 
+# SELFTESTS_MPTCP_LIB_OVERRIDE_FLAKY env var can be set not to ignore errors
+# from subtests marked as flaky
+mptcp_lib_override_flaky() {
+	[ "${SELFTESTS_MPTCP_LIB_OVERRIDE_FLAKY:-}" = 1 ]
+}
+
+mptcp_lib_subtest_is_flaky() {
+	[ "${MPTCP_LIB_SUBTEST_FLAKY}" = 1 ] && ! mptcp_lib_override_flaky
+}
+
 # $1: color, $2: text
 mptcp_lib_print_color() {
 	echo -e "${MPTCP_LIB_START_PRINT:-}${*}${MPTCP_LIB_COLOR_RESET}"
@@ -72,7 +83,16 @@ mptcp_lib_pr_skip() {
 }
 
 mptcp_lib_pr_fail() {
-	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
+	local title cmt
+
+	if mptcp_lib_subtest_is_flaky; then
+		title="IGNO"
+		cmt=" (flaky)"
+	else
+		title="FAIL"
+	fi
+
+	mptcp_lib_print_err "[${title}]${cmt}${1:+ ${*}}"
 }
 
 mptcp_lib_pr_info() {
@@ -208,7 +228,13 @@ mptcp_lib_result_pass() {
 
 # $1: test name
 mptcp_lib_result_fail() {
-	__mptcp_lib_result_add "not ok" "${1}"
+	if mptcp_lib_subtest_is_flaky; then
+		# It might sound better to use 'not ok # TODO' or 'ok # SKIP',
+		# but some CIs don't understand 'TODO' and treat SKIP as errors.
+		__mptcp_lib_result_add "ok" "${1} # IGNORE Flaky"
+	else
+		__mptcp_lib_result_add "not ok" "${1}"
+	fi
 }
 
 # $1: test name

-- 
2.43.0


