Return-Path: <linux-kselftest+bounces-7267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A3B899B52
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F34E28333D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C6516D4C0;
	Fri,  5 Apr 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npvk0vb9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75E16D33B;
	Fri,  5 Apr 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314369; cv=none; b=kI+YWkQtCOfg8kEeGZYBiX0+pBHa7uL4uwOzGt9ekT/n/JWgJNKZbAFLTXgOtdpHcjEZMkTfy3CowQhVd81Yc2Qg1Wvwmhg2pKph0NvuqcFmxQHKllWfSECK8XDR9lLn74zlnxqUasPmn9fX4FBqstVLI1FOPlg1NLP85f7XCvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314369; c=relaxed/simple;
	bh=waK6o7NL+X08D46c1Uzh5uW3FEozqw+q+E4Twh8dDSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pb6mks1r/NGWRW0NbMzPoIwWAQw8MXu0ifVAxGW4q1UQarzd9QExUM55ilGDgMDW/EXef1oPCHjAu5/jYsZtbmH4+18eD6uH6hWbgsDAlZ/9INOICK6cBtf1AjvZSDFV7033mPmB+1sChOyBm7I7vdLfJwN4+4CwYnuQF+J8tKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npvk0vb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4B9C43390;
	Fri,  5 Apr 2024 10:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314369;
	bh=waK6o7NL+X08D46c1Uzh5uW3FEozqw+q+E4Twh8dDSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=npvk0vb9UoDYGxAQ3aOuBq2cUowzjsvcB/6AvBie3DZjG5sxqw2BfelpwQcL9+3dL
	 fwMQy7DINIM3SL8t1JhA9gl7yA0GqF1auOhRWUK/I+ToH5LDtBKbukyR9JfKHhZhEw
	 fmtnQVMMXSPq3vqaT7T8V3yhTidy+nflxNqhzwEZVTsAwXx9f7SXlowNpyieeOk0J8
	 VEC+7dc9vjeKCn+xwTdTRB9ixQnooWwFpf3JS14C7FWprVkQ9uXesLr04maTen0sQ6
	 zLICxm0GOfcrH5J2wiEyYfr64HzW95O/QQ3dCLEVyYqChEtpyybn/tvz7XB20zgMtN
	 +Ydu8pOKvHyUw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Apr 2024 12:52:12 +0200
Subject: [PATCH net-next 08/11] selftests: mptcp: export pm_nl endpoint ops
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-8-eabc9b960966@kernel.org>
References: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
In-Reply-To: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5563; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UCh5fgsZwb/jdM6yFmZ+1A0KHly8AqybefNoJ/KitEk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD9flQu7izI5fWE0dAqPTFv1BYwRr5MSe9O0Kf
 JJz3rTg+nuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/X5QAKCRD2t4JPQmmg
 c2pjD/406w+NcOUr+QjJsiEj3R8zHXm6nmMPvtXeG2XMPsg+BOtAsMpeGWDGTWvBKZzcRe2w/hZ
 oVtUG7dcsRkNNDwwVZKNReshUnc6AlMk5VbX5l51Sk1Y4fJFA4QR55eNOUFqudgcbdy5d9mVAwB
 f8pAGmKrieyxBxFKHK5ZGFRy3aZwxQsuj6yw7oCN5eRC6gp/RbgJ52vzQaIbPnbn550aLW6v3Tv
 gBs4/ZcfU8ccy+W2N1ojw5OfIbHmWqCUw885c9pxweayhvRApomn9WCjdlX8wM1DSc6vWg1CTIs
 QC1W8uXBiy7uC/ZLSHEYGdLaBYYh2aOhsOb3xjfmUtN+Ww7FIQYvneSN4wv8qO797UtYXqI7UdR
 qGY2ahsf0IUYTAYdlgD0TMt+FmoZSBvdwZisekkvloyfTJDgsE98ZMGHtqjg5Tekh3gA6mwxt0g
 mLi4AIDuCCxpS7NFQPHY0r8vcM7su/yC4fCSQKSKGuyoQufGQIu3mVcJBCKhBY1vd8NfnTkXoej
 WTuNnlRor0f83RMOXEoxv+0eD2lZmlQ1digA1bBi4eyZ5mBpiunH1i0sFI0geEbmwvJCjEetyjm
 POjNO6tPchki6IzUfVrKC6ma+cQKxIMubc7ETTP/jLXjxcWbflIMxn9IPGAZcT7rY/ZEww31ZAo
 xrIBTGWvgyE7z4Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch exports six endpoint operation helpers with pm_nl_ prefix,
pm_nl_set_limits(), pm_nl_add_endpoint(), pm_nl_del_endpoint(),
pm_nl_flush_endpoint(), pm_nl_show_endpoints() and pm_nl_change_endpoint()
into mptcp_lib.sh as public functions, and renamed each of them with a
mptcp_lib_ prefix. Then these old pm_nl_ prefix helpers in mptcp_join.sh
can be wrappers of mptcp_lib_ prefix ones.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 72 ++-------------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 85 +++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8862b6a5caa0..fefa9173bdaa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -605,92 +605,32 @@ kill_events_pids()
 
 pm_nl_set_limits()
 {
-	local ns=$1
-	local addrs=$2
-	local subflows=$3
-
-	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp limits set add_addr_accepted $addrs subflows $subflows
-	else
-		ip netns exec $ns ./pm_nl_ctl limits $addrs $subflows
-	fi
+	mptcp_lib_pm_nl_set_limits "${@}"
 }
 
 pm_nl_add_endpoint()
 {
-	local ns=$1
-	local addr=$2
-	local flags dev id port
-	local nr=2
-
-	local p
-	for p in "${@}"
-	do
-		case "${p}" in
-		"flags" | "dev" | "id" | "port")
-			eval "${p}"=\$"${nr}"
-			;;
-		esac
-
-		nr=$((nr + 1))
-	done
-
-	if mptcp_lib_is_ip_mptcp; then
-		ip -n "${ns}" mptcp endpoint add "${addr}" ${flags//","/" "} \
-			${dev:+dev "${dev}"} ${id:+id "${id}"} ${port:+port "${port}"}
-	else
-		ip netns exec "${ns}" ./pm_nl_ctl add "${addr}" ${flags:+flags "${flags}"} \
-			${dev:+dev "${dev}"} ${id:+id "${id}"} ${port:+port "${port}"}
-	fi
+	mptcp_lib_pm_nl_add_endpoint "${@}"
 }
 
 pm_nl_del_endpoint()
 {
-	local ns=$1
-	local id=$2
-	local addr=$3
-
-	if mptcp_lib_is_ip_mptcp; then
-		[ $id -ne 0 ] && addr=''
-		ip -n $ns mptcp endpoint delete id $id ${addr:+"${addr}"}
-	else
-		ip netns exec $ns ./pm_nl_ctl del $id $addr
-	fi
+	mptcp_lib_pm_nl_del_endpoint "${@}"
 }
 
 pm_nl_flush_endpoint()
 {
-	local ns=$1
-
-	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp endpoint flush
-	else
-		ip netns exec $ns ./pm_nl_ctl flush
-	fi
+	mptcp_lib_pm_nl_flush_endpoint "${@}"
 }
 
 pm_nl_show_endpoints()
 {
-	local ns=$1
-
-	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp endpoint show
-	else
-		ip netns exec $ns ./pm_nl_ctl dump
-	fi
+	mptcp_lib_pm_nl_show_endpoints "${@}"
 }
 
 pm_nl_change_endpoint()
 {
-	local ns=$1
-	local id=$2
-	local flags=$3
-
-	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
-	else
-		ip netns exec $ns ./pm_nl_ctl set id $id flags $flags
-	fi
+	mptcp_lib_pm_nl_change_endpoint "${@}"
 }
 
 pm_nl_check_endpoint()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 4fabb0091940..ad2ebda5cb64 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -555,3 +555,88 @@ mptcp_lib_pm_nl_get_endpoint() {
 		ip netns exec "${ns}" ./pm_nl_ctl get "${id}"
 	fi
 }
+
+mptcp_lib_pm_nl_set_limits() {
+	local ns=${1}
+	local addrs=${2}
+	local subflows=${3}
+
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns}" mptcp limits set add_addr_accepted "${addrs}" subflows "${subflows}"
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl limits "${addrs}" "${subflows}"
+	fi
+}
+
+mptcp_lib_pm_nl_add_endpoint() {
+	local ns=${1}
+	local addr=${2}
+	local flags dev id port
+	local nr=2
+
+	local p
+	for p in "${@}"; do
+		case "${p}" in
+		"flags" | "dev" | "id" | "port")
+			eval "${p}"=\$"${nr}"
+			;;
+		esac
+
+		nr=$((nr + 1))
+	done
+
+	if mptcp_lib_is_ip_mptcp; then
+		# shellcheck disable=SC2086 # blanks in flags, no double quote
+		ip -n "${ns}" mptcp endpoint add "${addr}" ${flags//","/" "} \
+			${dev:+dev "${dev}"} ${id:+id "${id}"} ${port:+port "${port}"}
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl add "${addr}" ${flags:+flags "${flags}"} \
+			${dev:+dev "${dev}"} ${id:+id "${id}"} ${port:+port "${port}"}
+	fi
+}
+
+mptcp_lib_pm_nl_del_endpoint() {
+	local ns=${1}
+	local id=${2}
+	local addr=${3}
+
+	if mptcp_lib_is_ip_mptcp; then
+		[ "${id}" -ne 0 ] && addr=''
+		ip -n "${ns}" mptcp endpoint delete id "${id}" ${addr:+"${addr}"}
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl del "${id}" "${addr}"
+	fi
+}
+
+mptcp_lib_pm_nl_flush_endpoint() {
+	local ns=${1}
+
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns}" mptcp endpoint flush
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl flush
+	fi
+}
+
+mptcp_lib_pm_nl_show_endpoints() {
+	local ns=${1}
+
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns}" mptcp endpoint show
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl dump
+	fi
+}
+
+mptcp_lib_pm_nl_change_endpoint() {
+	local ns=${1}
+	local id=${2}
+	local flags=${3}
+
+	if mptcp_lib_is_ip_mptcp; then
+		# shellcheck disable=SC2086 # blanks in flags, no double quote
+		ip -n "${ns}" mptcp endpoint change id "${id}" ${flags//","/" "}
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl set id "${id}" flags "${flags}"
+	fi
+}

-- 
2.43.0


