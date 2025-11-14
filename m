Return-Path: <linux-kselftest+bounces-45664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D92CBC5ECEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 19:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80CFA35F02A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 18:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA0233C535;
	Fri, 14 Nov 2025 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfCeJ6aM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749933B6F8;
	Fri, 14 Nov 2025 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143946; cv=none; b=fP52CpvU8xL3cO//ErOr1Fn0a7WHv58s4GIIiKi6E+lJ6xv99gQKiKglGX8T2msYL21tMvk+c29/4C2cVR7E0qIjpCoO5qE+Gf3yQSEb1WefUXz07/fV9BeGV7GbSXxesdCCTcmM131BMaSl2rESD6s8Szt2nY/jn5WVCa0waqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143946; c=relaxed/simple;
	bh=VFfgcD5O4JfxyrkN935fmcvNNxEM+LjCCXwyjzecXi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zm+HWE3HNt3qZFfJLa5AH7863f7ouNiRUbRdagOQBKWLcx+fs9/qEX3lH6ogcOtPkBnfRiRXx3Qo/fCqDaqqPzqjMqmxWf4DmIiA2REAbjFxpzv0yLf1pVq6fL08YV6oEcpnGVUfKydULCoW4kH/pa+9+kIATG+tTDa+3Z/8DEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfCeJ6aM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C49C113D0;
	Fri, 14 Nov 2025 18:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143946;
	bh=VFfgcD5O4JfxyrkN935fmcvNNxEM+LjCCXwyjzecXi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QfCeJ6aMUm+JtEpCOJOVS9XT11WZpQbeG2xNi828ZF/vThljVCHQFjH82qCO0wCyl
	 Pi+/XkFTobxjxm9avZrpSCBYVvpmWoJgVQcL+MeOJmZP+ZFU3l8gLBQJtMDa5OWwGl
	 4qHdhrA3xKKcIzsox3H+zeq7zefygeC5fRjhNFXfr8c8K97P2AJK/q2UDy7w/DUpPm
	 ZcFHqDKlip0Gup5Ii98Bczsf87KiiHIS8TTqHUXldQxYC0miG6yKqfS2O+pGm7rfIx
	 d/yjyYdn9dX1Gm/J/hK5i4CKWwHizgCSP2t4AHOVWRtAJoUPy7LfgDZOI1oZyMZIzN
	 kFm+z3Zg+IhPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Nov 2025 19:12:05 +0100
Subject: [PATCH net-next 1/8] selftests: mptcp: lib: introduce
 'nstat_{init,get}'
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-1-863cb04e1b7b@kernel.org>
References: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
In-Reply-To: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5895; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VFfgcD5O4JfxyrkN935fmcvNNxEM+LjCCXwyjzecXi8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLFC34bb9Jn3BOwzn6pY2kI8z7OHyZny5RSkmdOyDhr+
 D/03n7BjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkwMzD8L5jHFjv/xNOZIWdm
 pwjEbtmgmF8xkXfa5dKs37onRM/07mNk+Fr5Kbx2y46JRg1ZyRVPzpSzVa7+1rk57qO1/fMqyR+
 3OAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These new helpers are easier to read than the long and multi lines
commands. Plus it will ease the addition of new features related to that
in the next commits.

No behavioural changes intended.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 12 ++++--------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 12 ++++--------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 14 ++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 12 ++++--------
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 12 ++++--------
 5 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 9b7b93f8eb0c..e1f34508490a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -384,11 +384,9 @@ do_transfer()
 		sleep 1
 	fi
 
-	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
-		nstat -n
+	mptcp_lib_nstat_init "${listener_ns}"
 	if [ ${listener_ns} != ${connector_ns} ]; then
-		NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-			nstat -n
+		mptcp_lib_nstat_init "${connector_ns}"
 	fi
 
 	local stat_synrx_last_l
@@ -436,11 +434,9 @@ do_transfer()
 		kill ${cappid_connector}
 	fi
 
-	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
-		nstat | grep Tcp > /tmp/${listener_ns}.out
+	mptcp_lib_nstat_get "${listener_ns}"
 	if [ ${listener_ns} != ${connector_ns} ]; then
-		NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-			nstat | grep Tcp > /tmp/${connector_ns}.out
+		mptcp_lib_nstat_get "${connector_ns}"
 	fi
 
 	local duration
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f0efbf985625..f51c9bf2d37f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -983,10 +983,8 @@ do_transfer()
 
 	cond_start_capture ${listener_ns}
 
-	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
-		nstat -n
-	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-		nstat -n
+	mptcp_lib_nstat_init "${listener_ns}"
+	mptcp_lib_nstat_init "${connector_ns}"
 
 	local extra_args
 	if [ $speed = "fast" ]; then
@@ -1068,10 +1066,8 @@ do_transfer()
 
 	cond_stop_capture
 
-	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
-		nstat | grep Tcp > /tmp/${listener_ns}.out
-	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-		nstat | grep Tcp > /tmp/${connector_ns}.out
+	mptcp_lib_nstat_get "${listener_ns}"
+	mptcp_lib_nstat_get "${connector_ns}"
 
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		fail_test "client exit code $retc, server $rets"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index f4388900016a..1f31746cc519 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -376,6 +376,20 @@ mptcp_lib_is_v6() {
 	[ -z "${1##*:*}" ]
 }
 
+mptcp_lib_nstat_init() {
+	local ns="${1}"
+
+	NSTAT_HISTORY="/tmp/${ns}.nstat" ip netns exec "${ns}" nstat -n
+}
+
+mptcp_lib_nstat_get() {
+	local ns="${1}"
+
+	# filter out non-*TCP stats
+	NSTAT_HISTORY="/tmp/${ns}.nstat" ip netns exec "${ns}" nstat |
+		grep Tcp > "/tmp/${ns}.out"
+}
+
 # $1: ns, $2: MIB counter
 mptcp_lib_get_counter() {
 	local ns="${1}"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index f01989be6e9b..343615908558 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -169,10 +169,8 @@ do_transfer()
 		cmsg+=",TCPINQ"
 	fi
 
-	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
-		nstat -n
-	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-		nstat -n
+	mptcp_lib_nstat_init "${listener_ns}"
+	mptcp_lib_nstat_init "${connector_ns}"
 
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -194,10 +192,8 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
-		nstat | grep Tcp > /tmp/${listener_ns}.out
-	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-		nstat | grep Tcp > /tmp/${connector_ns}.out
+	mptcp_lib_nstat_get "${listener_ns}"
+	mptcp_lib_nstat_get "${connector_ns}"
 
 	print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 1903e8e84a31..fbd1685d1adc 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -155,10 +155,8 @@ do_transfer()
 		sleep 1
 	fi
 
-	NSTAT_HISTORY=/tmp/${ns3}.nstat ip netns exec ${ns3} \
-		nstat -n
-	NSTAT_HISTORY=/tmp/${ns1}.nstat ip netns exec ${ns1} \
-		nstat -n
+	mptcp_lib_nstat_init "${ns3}"
+	mptcp_lib_nstat_init "${ns1}"
 
 	timeout ${timeout_test} \
 		ip netns exec ${ns3} \
@@ -185,10 +183,8 @@ do_transfer()
 		kill ${cappid_connector}
 	fi
 
-	NSTAT_HISTORY=/tmp/${ns3}.nstat ip netns exec ${ns3} \
-		nstat | grep Tcp > /tmp/${ns3}.out
-	NSTAT_HISTORY=/tmp/${ns1}.nstat ip netns exec ${ns1} \
-		nstat | grep Tcp > /tmp/${ns1}.out
+	mptcp_lib_nstat_get "${ns3}"
+	mptcp_lib_nstat_get "${ns1}"
 
 	cmp $sin $cout > /dev/null 2>&1
 	local cmps=$?

-- 
2.51.0


