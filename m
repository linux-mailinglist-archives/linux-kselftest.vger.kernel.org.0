Return-Path: <linux-kselftest+bounces-5907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624EC871C11
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D5E1C229B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79715C911;
	Tue,  5 Mar 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVgJkqgZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764A5BADB;
	Tue,  5 Mar 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635369; cv=none; b=Or4XiKzmpK0TWP9AnaUyHrIxOxdjZC0b7xj5QdqvVyO2qOG0aOhk6agdIUVVxpupqdCoug65o/yGtlVdow879F/C7GFCqUXQ7SV2iFc9s7jGbeta5KrqRmmmcTWx5mhxyPEHgVyMYHUbe/aMkBQkqFfSTVcROebSfD/jwaPfy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635369; c=relaxed/simple;
	bh=fNW62RoqvlgK4DVt6pDg+5T3KJXI1LsQBl9zqq5p39E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3sV5bCYBuxXq8HYOsttm7SCt7vIuU2GLW2ymGCeFq2fHIolU0tBXKU5BgHKoBCbXK9HoISQQrGrXNzhHXJSJMbpSAcrvLnJamf4HS7+CQnBSpO1DdQkjq+EPzLHuLDG5EGWU7PpCcNQwQe8T6+BImhOQuqB3ckIjKehIg8SsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVgJkqgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1D6C43390;
	Tue,  5 Mar 2024 10:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635369;
	bh=fNW62RoqvlgK4DVt6pDg+5T3KJXI1LsQBl9zqq5p39E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PVgJkqgZo3NLdB/u8jPtt6VRHx0Y5WGXM7mU0bfpW8IWputmPvjX4RkY0XeV82J1s
	 +5BOFNkrplVgEne3Eau47VGOYeX+LIpznVU4wF/EjBXy75iivHF0kRakpN6TbU2ulO
	 H2QqI+H5AEyRtLvDzojGrzTiH5lIPV2lkJKqAOavt7Wa2g5RJ9bMoBOIZpGzsPTkHI
	 MAk6N2P1qk6FaH8SRg+LRg8wPheukWBVDG18ZqhouvQheTl3FVcwMd6tifENqqnt4Z
	 DIgYfF4+D8NrzT05IHnipVdgo1vTcijBts/kJXNbDTD4NVfQSzKP3JBi6GBu8sfixJ
	 ZYZOZa2UEY6ng==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 11:42:32 +0100
Subject: [PATCH net-next 02/13] selftests: mptcp: add mptcp_lib_check_tools
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-2-66618ea5504e@kernel.org>
References: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7064; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mNejHG+IpDCqO0G/yGU/BV55iutt/FWjzIkbjGVpe0w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vccO9iGAssj2JBuBkHWIPpkah707av0qkMt0
 YBrk/vbHx6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HAAKCRD2t4JPQmmg
 c5FKD/wKIf8Eow2hXgEms7ZhEBfhUvDz5ZaMZA+3V8X9DXabpF1Qwc15ct9ZOM7vtVJQhlaGAjc
 vZYEr9RXdBkzg34bAukFpyfeY8BBF9KCM+bDQfDXRstWBwxU2pK7CBoMaVBvlrJb2Q2PiOh4qVb
 cHpQHsPPWFc1KaIvcF78Tu5PXQEE2MzabDiWfmSm7vym3DZj1t1GKfvW37svWojNi4j2Lna8Ri7
 574CNRVSdrd1ccJi0h/z8Hi197RKkpZtruyNY+eUb3LEFBhhpaMfUqvjEWvgxa2LMQUHN8gDgOX
 BrNBo1V2Fvqp/WATupA4lfp6Y9sPggSAEeWOT6nDAfF/Fa5iaawGVWHjMRSWj6/g8a74X+Hh0IG
 ntQBxuYFky0veHDsw6ecxU4KZzgqV9UL6lWluV6BZxbjMVhnSrc3wfiJEwhZ66JfS1XJeWwZ0Cl
 4mgvAF/U31ZxM+DkjGUMiw6u5JMSJ1rqsdeyEZuoLnecPhedzYIeFScyDeI5xlGqBPyqrkK/rnH
 uBrdd2FBaE6l7r1TqL108kfDLNK1YCW32BpS4MpzVfPoFHgNi4bks6agGyAZsfndqG0qUC9NNBO
 7bXfW/0TuLoe+Bxftvi7xL8MX/BKrPX5cGkddqZ3CuUlvnRJgDv2Th5+TjtgvS79ZzgoOw14f9T
 bnMr240CTZczM0A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch exports check_tools() helper from mptcp_join.sh into
mptcp_lib.sh as a public one mptcp_lib_check_tools(). The arguments
"ip", "ss", "iptables" and "ip6tables" are passed into this helper
to indicate whether to check ip tool, ss tool, iptables and ip6tables
tools.

This helper can be used in every scripts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 12 +--------
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  7 +----
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 28 +++----------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 31 ++++++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 15 +----------
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  7 +----
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  7 +----
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  6 +----
 8 files changed, 40 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index e87cf76b3e4a..e42603be03f3 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -34,17 +34,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
-ss -h | grep -q MPTCP
-if [ $? -ne 0 ];then
-	echo "SKIP: ss tool does not support MPTCP"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools ip ss
 
 get_msk_inuse()
 {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7898d62fce0b..ea52110c3fbc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -147,12 +147,7 @@ cleanup()
 
 mptcp_lib_check_mptcp
 mptcp_lib_check_kallsyms
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools ip
 
 sin=$(mktemp)
 sout=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6a4af95cd4c3..aedc5698f26a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -152,34 +152,12 @@ cleanup_partial()
 	done
 }
 
-check_tools()
-{
-	mptcp_lib_check_mptcp
-	mptcp_lib_check_kallsyms
-
-	if ! ip -Version &> /dev/null; then
-		echo "SKIP: Could not run test without ip tool"
-		exit $ksft_skip
-	fi
-
-	if ! ss -h | grep -q MPTCP; then
-		echo "SKIP: ss tool does not support MPTCP"
-		exit $ksft_skip
-	fi
-
-	if ! "${iptables}" -V &> /dev/null; then
-		echo "SKIP: Could not run all tests without ${iptables} tool"
-		exit $ksft_skip
-	elif ! "${ip6tables}" -V &> /dev/null; then
-		echo "SKIP: Could not run all tests without ${ip6tables} tool"
-		exit $ksft_skip
-	fi
-}
-
 init() {
 	init=1
 
-	check_tools
+	mptcp_lib_check_mptcp
+	mptcp_lib_check_kallsyms
+	mptcp_lib_check_tools ip ss "${iptables}" "${ip6tables}"
 
 	sin=$(mktemp)
 	sout=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 438f557aac90..b1fe354cfe96 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -342,3 +342,34 @@ mptcp_lib_check_output() {
 		return 1
 	fi
 }
+
+mptcp_lib_check_tools() {
+	local tool
+
+	for tool in "${@}"; do
+		case "${tool}" in
+		"ip")
+			if ! ip -Version &> /dev/null; then
+				mptcp_lib_print_warn "SKIP: Could not run test without ip tool"
+				exit ${KSFT_SKIP}
+			fi
+			;;
+		"ss")
+			if ! ss -h | grep -q MPTCP; then
+				mptcp_lib_print_warn "SKIP: ss tool does not support MPTCP"
+				exit ${KSFT_SKIP}
+			fi
+			;;
+		"iptables"* | "ip6tables"*)
+			if ! "${tool}" -V &> /dev/null; then
+				mptcp_lib_print_warn "SKIP: Could not run all tests without ${tool}"
+				exit ${KSFT_SKIP}
+			fi
+			;;
+		*)
+			mptcp_lib_print_err "Internal error: unsupported tool: ${tool}"
+			exit ${KSFT_FAIL}
+			;;
+		esac
+	done
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index dac8e1fc7143..fd7de1b3dc55 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -89,20 +89,7 @@ cleanup()
 
 mptcp_lib_check_mptcp
 mptcp_lib_check_kallsyms
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
-
-if ! "${iptables}" -V &> /dev/null; then
-	echo "SKIP: Could not run all tests without ${iptables} tool"
-	exit $ksft_skip
-elif ! "${ip6tables}" -V &> /dev/null; then
-	echo "SKIP: Could not run all tests without ${ip6tables} tool"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools ip "${iptables}" "${ip6tables}"
 
 check_mark()
 {
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 705106d60db5..1ec9d8622fc9 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -36,12 +36,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools ip
 
 trap cleanup EXIT
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ed0165c15a24..dbbb13d1d74e 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -43,12 +43,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
-
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
+mptcp_lib_check_tools ip
 
 #  "$ns1"              ns2                    ns3
 #     ns1eth1    ns2eth1   ns2eth3      ns3eth1
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 1b94a75604fe..629fc5d0ecc5 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -17,11 +17,7 @@ if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 	echo "userspace pm tests are not supported by the kernel: SKIP"
 	exit ${KSFT_SKIP}
 fi
-
-if ! ip -Version &> /dev/null; then
-	echo "SKIP: Cannot not run test without ip tool"
-	exit ${KSFT_SKIP}
-fi
+mptcp_lib_check_tools ip
 
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
 REMOVED=7          # MPTCP_EVENT_REMOVED

-- 
2.43.0


