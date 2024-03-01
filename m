Return-Path: <linux-kselftest+bounces-5759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B819886E83A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D306C1C231F4
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C463D998;
	Fri,  1 Mar 2024 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTqv9C3b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC83D995;
	Fri,  1 Mar 2024 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317139; cv=none; b=F3M7419Pm7P3Wu3GKl/u7+Zz0M2GN5dBfTya6atQ8A9TUfgwppu3eVaYWm2FWr9fdedBUEJkgbcTE87cHDVRKSLnPpETq5mtrjKS0DEB+Mb0vVms8NA6Odx4cNH7OrslKFft1rEXEjU4bf7Ehv73Cl0INe3YC+C9cqS2mwYLKfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317139; c=relaxed/simple;
	bh=pbqWEmCOrykbN/GmGwrYxgoy7cTcujW3whDie7ZBw5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EWmVGVFOZgI15ZS4w4rh7DgKSphXC2wNt3nb4pEje++VnBh9ooSqxa+eHSf9nMJFVMp3EinJrylSUD6a1wA3tAJfqEl+eRfBFNku/YHjnnToquhzDU4bgVAGXYNho57vKvC9Xqj/++Exvkkdl5UzvKxuSdyRY8nUVYKhm/8MIfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTqv9C3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E684C43330;
	Fri,  1 Mar 2024 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317139;
	bh=pbqWEmCOrykbN/GmGwrYxgoy7cTcujW3whDie7ZBw5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DTqv9C3bboz/UoIlDOPGanIwf0RoRP+8hosq5krfQ+0ep6bGthSf4s7vXPwmH+BWH
	 UICkaPn3KcpFdTQDLJBYc0R+T0Z9ZgYpjC3nQtrH1UnF9kIlqt+RUNwCYsbLclu5Fu
	 SO0n8tOWGc1dHiqpIr76XsxxvpMw0IfL/2AaEONUufrSTMabcCSPkla0zWzGJHKR3V
	 DT7Hsld9g7ndILI6RgUcODIMAz5daZTlvILV1htx3PZMyYEGoFMLBNDk25akvrmpnB
	 3KHgLLkYJa9O6u03PRYyz76ypD3/yBLkmEBpfjvUmIp6tgKpv6Y37F2tn8vPrX0erV
	 TioarPwAMdUcg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:33 +0100
Subject: [PATCH net-next 09/15] selftests: mptcp: add
 mptcp_lib_check_output helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-9-dc30a420b3a0@kernel.org>
References: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2654; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6G31hnNo4MBSwHsVBP5DRx+fol84lvZ27A4ZWK/RMcQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv0fr8VDllyWbt545znoPYiaNbnRbSvoaZCw
 kAPBIRufj+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9AAKCRD2t4JPQmmg
 c9EAD/9l8P/kyWHAIO+BWefN0NfyktQogWxXy01+AiE4kA3q9k6K7NDfU0977yhMlbi5sluK8A6
 A1H4r6/0I5rryLJAF7eMPmxtiRpeq78oQh4l3zoyjwAx1pXajvHgj7eKVcLxL2w72Qb4bvftgdp
 oXbjqwnGITYzzFTB9Qwj1R88YgRUt1cPYYyawB5u674WZj4lmKUzFPkNUZiSKYyLtxynX9OEgJL
 RiCSQO+fXw+XXscCmjNSTDrlq/k7bz2DFapPTU8uw9sAhZSIk/VQ9vfbMO3k1n7blnw0K+zKic/
 NrUsTSJIsnrdBNbobaCCzFgzxdhqIxT1JDJmLh5hQNv2HGjwdTCQdPKamtxBPTdyE23erqSJHiE
 D5w01t+d4V5Qdjly3iPXSLWG4xaZvxV9LH2EO7xgQhLuVO+U3+frjE07LarPfn5uFhU1xld++pE
 LdrYl1pBrrP++/dGwkukmUI4cfMABl1VJW0WxdLaVuw8hp47lcYkC5Kv0TdPblGmWVoY2iGDSLJ
 8GOZ8KcYx99iNsQbmjnXTHOI8Ai14Twf21n+i59WusIwYME1gjBtgrZ1Zhye828zqfQD0faCVim
 ArwmOhM4GoVpAAnwS39C/tKmQrlw7o9oFnF4mucq3V7UJND21R0sLKkGdu+fEkhVIl2OxAMas5a
 qHk5eb8Rx00koVg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Extract the main part of check() in pm_netlink.sh into a new helper
named mptcp_lib_check_output in mptcp_lib.sh.

This helper will be used for userspace dump addresses tests.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 23 +++++++++++++++++++++++
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 18 +++++++-----------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 108a1e12436c..438f557aac90 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -319,3 +319,26 @@ mptcp_lib_wait_local_port_listen() {
 		sleep 0.1
 	done
 }
+
+mptcp_lib_check_output() {
+	local err="${1}"
+	local cmd="${2}"
+	local expected="${3}"
+	local cmd_ret=0
+	local out
+
+	if ! out=$(${cmd} 2>"${err}"); then
+		cmd_ret=${?}
+	fi
+
+	if [ ${cmd_ret} -ne 0 ]; then
+		mptcp_lib_print_err "[FAIL] command execution '${cmd}' stderr"
+		cat "${err}"
+		return 2
+	elif [ "${out}" = "${expected}" ]; then
+		return 0
+	else
+		mptcp_lib_print_err "[FAIL] expected '${expected}' got '${out}'"
+		return 1
+	fi
+}
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index ebfefae71e13..705106d60db5 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -54,21 +54,17 @@ check()
 	local cmd="$1"
 	local expected="$2"
 	local msg="$3"
-	local out=`$cmd 2>$err`
-	local cmd_ret=$?
+	local rc=0
 
 	printf "%-50s" "$msg"
-	if [ $cmd_ret -ne 0 ]; then
-		echo "[FAIL] command execution '$cmd' stderr "
-		cat $err
-		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
+	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
+	if [ ${rc} -eq 2 ]; then
+		mptcp_lib_result_fail "${msg} # error ${rc}"
 		ret=1
-	elif [ "$out" = "$expected" ]; then
-		echo "[ OK ]"
+	elif [ ${rc} -eq 0 ]; then
+		mptcp_lib_print_ok "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
-	else
-		echo -n "[FAIL] "
-		echo "expected '$expected' got '$out'"
+	elif [ ${rc} -eq 1 ]; then
 		mptcp_lib_result_fail "${msg} # different output"
 		ret=1
 	fi

-- 
2.43.0


