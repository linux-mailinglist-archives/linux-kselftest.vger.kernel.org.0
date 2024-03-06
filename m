Return-Path: <linux-kselftest+bounces-5980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3968732D3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606222850F8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBC85F847;
	Wed,  6 Mar 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABb6MASP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2A55DF2E;
	Wed,  6 Mar 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718192; cv=none; b=SbhUDx3CTsLfKr15TtQ9rZz0zZRPp1FpPfrTeNoGKQ7HMHMlpZs1fxGkQFLU13h1dNyb8GvWZxWZe0Q48Q3AgQ/18k/bxndCBzp2zWt7UmrpOCyoa8ecsNiP1N2yq7NSiOjIy4/TqkeAwpnI+Z25v/eDho5+5zcOyV+j6G0Xr1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718192; c=relaxed/simple;
	bh=fNW62RoqvlgK4DVt6pDg+5T3KJXI1LsQBl9zqq5p39E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4xqqdTubaG3mR8hpAD1yY1uQQAxiJ9iH3wIlaQj3BF5RbdS+tDgC49nkYlbGXBEfZF1CSWD9SrtR48owXNgpW0uLTXxDUZ6UyKVixkUaTHO61jg2312+OaXN1fuSmkD9UmhPN68WGZMhWJEJ2e7eqbzkGkKl6FAqqblqY1osn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABb6MASP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E16C43394;
	Wed,  6 Mar 2024 09:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718192;
	bh=fNW62RoqvlgK4DVt6pDg+5T3KJXI1LsQBl9zqq5p39E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ABb6MASPx+kyyYyAjUbHTNp1KheRq4jM9hKI5kU23kRQbcSjm8SMOUbNSPBfj4UWh
	 keCywIx0mF6226J7YLL+5DyI1Ggt1vLZCaLk6Fh+wwmF09ekntYEHy/4eergqEdvY0
	 V35oWCXlPPrJ17BH77w7/546thl7CbghQg6H61SvlWO1iMAPJQFm0bSbAOPmxlLjhQ
	 LGRm/5tvNY5MhKJUaBC87yONVsDtjv+Rm8dreM+TaYCD8MHiPwI8JRNqM9FkkeJPk1
	 NM0q6EKy4cKI6zAEvZeuekqXsb4uHFP172FrCaFMp3YIlSuInKP0nz1P7o6DSltQqU
	 +f69dNSIVBM8A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 06 Mar 2024 10:42:51 +0100
Subject: [PATCH net-next v2 02/12] selftests: mptcp: add
 mptcp_lib_check_tools helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-2-bc79e6e5e6a0@kernel.org>
References: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
In-Reply-To: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
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
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl6DqmWtuuOuy8X5VyXu7bKliGBUC1bItYEwqm/
 VnmoWBbI92JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeg6pgAKCRD2t4JPQmmg
 c4TOEACSOsjqR/88iOqipGggd5fEcP5TD50h7jwtJZhy3aOivgZbUR9ez2FVrauYfDeSVpmwVJA
 lqch49TzTTEI4DXsgf0oCx6NQ3pBwnKkDyCwaE/bG2IkR6ZEAczFAzkzLsJc363+fRaxEyqPvP1
 CTNOjAjEd7srdKUL/+0egaoysc5KgEOATWUVpKLtew6JzYm3RcScg7z+hiwfnUYZLpklgMr51mP
 o6QoFOgQM/YYGgWunI0qW6QQpJua9bLsin8UP1xy4DislHAahw/gB2WUZ0QO2x+2pnINKliiIhi
 WWKmgihGy+2jykluGTCHZcRArx6XNJnPLIal6gwQW5iQJcyJ2Pg4NPYaoG/+UOU0bNvXM2D1D9E
 wOdKdNX1hJAEgWpbRZfhU1OwWV0St/IpgsMLesYD8gqFbX+PtfKZkj0Vbpczs1gyo8q86JFItR5
 Tdv+jc5cWVIsK/O7wIYzVlCHH/0EZbGyPHkn1cnueUZGuF1iI7oQqtB8CKZy/iQOgQiF1sAVKyq
 WLp5oIuge855tIqaX/PZdxJjT5eQetkhhlDlgHKxdRVwzCMgb/0Dx0ZNxH6UazdDepkproAFLmw
 zq4Hg7sfgvmc3BXmQ0gYdMMJLIg3LU3ZtwYFXnHmQwz8HlAvvbP1rV97MokmhPIlzA0HAApZIRO
 tmO/Ebsl2281rCg==
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


