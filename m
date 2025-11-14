Return-Path: <linux-kselftest+bounces-45668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B029EC5ED24
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 19:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 960734F4583
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 18:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D875F34A794;
	Fri, 14 Nov 2025 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7mY24nA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19E34A78D;
	Fri, 14 Nov 2025 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143956; cv=none; b=YOBtIio5K+AdvGY5XPawceczOsGTZ6XRBO3oaN9FQrF0kSyqLYtzysbaw3FDXAwNNjVwxCB53ppL8cr+OI5QDdDsjfmHhA8RvfcHf+BcXrZLp4WwM/gTjjR54QJafdO1a3JLzQSSGv3vnXtIVpYGL/iyXqpyexITWRDymORp0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143956; c=relaxed/simple;
	bh=K4SzendUUYN9DOQQta3hYzu5L/TjoJ7vxCCcZDK4XbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ukOclbFjo/w2ekeofQdD01qktQZoGolnJTkO5w5JAy9uqQKLhSJmKgKvkuI52hCVPPfdrDcPZKsl2IyBlV97C5X/IuSB4820QB5Yi5q/+Jh+s7iYPoWWG/8s6CH3vJ61VodwfwFlpBKW0IMBJVxxJyxFAaxc5/2ZAjol37n9hJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7mY24nA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583B7C4CEF8;
	Fri, 14 Nov 2025 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143956;
	bh=K4SzendUUYN9DOQQta3hYzu5L/TjoJ7vxCCcZDK4XbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F7mY24nA7QDU2jOhVJC0N/kl8cIEFaXQrLE0Zdtp5XMdryIszSWxGfLyHH75TWVXS
	 5TVdtM4eUtY3bDskow2ksKuvdUCNDGD7jyXb85tqL3aMO7pcm5Cf+Qm5CeRJhK6s3D
	 FS49QGoYk6sACTVxRR78fk/qXuNla+oC+MpKzoxjuCJapdeWlq8k5Y4QhSyqLv3bOZ
	 HDfRkmgGeVb5Tr18A+pKI2ma4vqU07pzi0D+4ibMwDjb5xO2k+IxP/pUml4zAcVEdj
	 6QJaGZVnSebSqDIlP7YuSHwof4Gyq7tzRFfg1i36jMffgJqwpxRIRRUQ3SlhxVSg8+
	 7uUYYWk2owxCQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Nov 2025 19:12:09 +0100
Subject: [PATCH net-next 5/8] selftests: mptcp: lib: get counters from
 nstat history
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-5-863cb04e1b7b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9455; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=K4SzendUUYN9DOQQta3hYzu5L/TjoJ7vxCCcZDK4XbU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLFCxnmVO7XNg/K+6Xgcnuecez8cIUjUYcd7oeum1+Y3
 q2X47qho5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLVNxkZFvhYMd3/tVn7U6aW
 1eTa3dXHXrdPVaw801U/Xannxp3Epwz/1HMOfHqzX8R4a/KO0twZDF7XNuUk3yjdr9rveUyHadl
 EJgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before, 'nstat' was used to retrieve each individual counter: this means
querying 4 different sources from /proc/net and iterating over 100+
counters each time. Instead, the stats could be retrieved once, and the
output file could be parsed for each counter. Even better, such file is
already present: the nstat history file.

To be able to get this working, the nstat history file also needs to
contains zero counters too, so it is still possible to know if a counter
is missing or set to 0.

This also simplifies mptcp_connect.sh: instead of checking multiple
counters before and after a test to compute the difference, the stats
history files can be reset before each test, and nstat can display only
the difference.

mptcp_lib_get_counter() continues to work when no history file is
available: by fetching nstat directly, like before. This is the case in
diag.sh and userspace_pm.sh where there is no need to save the history
file. This is also the case in mptcp_join.sh, when 'run_tests' is
executed in the background: easier to continue fetching counters than
updating the history each time it is needed.

Note: 'nstat' is called with '-s' in mptcp_lib_nstat_get(), so this
helper can be called multiple times during the test if needed.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 85 +++++++++-------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 16 +++-
 2 files changed, 46 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 4ff2d02429d3..3a804abebd2c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -389,21 +389,6 @@ do_transfer()
 		mptcp_lib_nstat_init "${connector_ns}"
 	fi
 
-	local stat_synrx_last_l
-	local stat_ackrx_last_l
-	local stat_cookietx_last
-	local stat_cookierx_last
-	local stat_csum_err_s
-	local stat_csum_err_c
-	local stat_tcpfb_last_l
-	stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
-	stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
-	stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
-	stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
-	stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
-	stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
-	stat_tcpfb_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
-
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
 			./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -458,38 +443,38 @@ do_transfer()
 	rets=$?
 
 	local extra=""
-	local stat_synrx_now_l
-	local stat_ackrx_now_l
-	local stat_cookietx_now
-	local stat_cookierx_now
-	local stat_ooo_now
-	local stat_tcpfb_now_l
-	stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
-	stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
-	stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
-	stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
-	stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
-	stat_tcpfb_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
+	local stat_synrx
+	local stat_ackrx
+	local stat_cookietx
+	local stat_cookierx
+	local stat_ooo
+	local stat_tcpfb
+	stat_synrx=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
+	stat_ackrx=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
+	stat_cookietx=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
+	stat_cookierx=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
+	stat_ooo=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
+	stat_tcpfb=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
-	expect_synrx=$((stat_synrx_last_l))
-	expect_ackrx=$((stat_ackrx_last_l))
+	expect_synrx=0
+	expect_ackrx=0
 
 	cookies=$(ip netns exec ${listener_ns} sysctl net.ipv4.tcp_syncookies)
 	cookies=${cookies##*=}
 
 	if [ ${cl_proto} = "MPTCP" ] && [ ${srv_proto} = "MPTCP" ]; then
-		expect_synrx=$((stat_synrx_last_l+connect_per_transfer))
-		expect_ackrx=$((stat_ackrx_last_l+connect_per_transfer))
+		expect_synrx=${connect_per_transfer}
+		expect_ackrx=${connect_per_transfer}
 	fi
 
-	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
-		mptcp_lib_pr_fail "lower MPC SYN rx (${stat_synrx_now_l})" \
+	if [ ${stat_synrx} -lt ${expect_synrx} ]; then
+		mptcp_lib_pr_fail "lower MPC SYN rx (${stat_synrx})" \
 				  "than expected (${expect_synrx})"
 		retc=1
 	fi
-	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ]; then
-		if [ ${stat_ooo_now} -eq 0 ]; then
-			mptcp_lib_pr_fail "lower MPC ACK rx (${stat_ackrx_now_l})" \
+	if [ ${stat_ackrx} -lt ${expect_ackrx} ]; then
+		if [ ${stat_ooo} -eq 0 ]; then
+			mptcp_lib_pr_fail "lower MPC ACK rx (${stat_ackrx})" \
 					  "than expected (${expect_ackrx})"
 			rets=1
 		else
@@ -503,47 +488,45 @@ do_transfer()
 		csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
 		csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
 
-		local csum_err_s_nr=$((csum_err_s - stat_csum_err_s))
-		if [ $csum_err_s_nr -gt 0 ]; then
-			mptcp_lib_pr_fail "server got ${csum_err_s_nr} data checksum error[s]"
+		if [ $csum_err_s -gt 0 ]; then
+			mptcp_lib_pr_fail "server got ${csum_err_s} data checksum error[s]"
 			rets=1
 		fi
 
-		local csum_err_c_nr=$((csum_err_c - stat_csum_err_c))
-		if [ $csum_err_c_nr -gt 0 ]; then
-			mptcp_lib_pr_fail "client got ${csum_err_c_nr} data checksum error[s]"
+		if [ $csum_err_c -gt 0 ]; then
+			mptcp_lib_pr_fail "client got ${csum_err_c} data checksum error[s]"
 			retc=1
 		fi
 	fi
 
-	if [ ${stat_ooo_now} -eq 0 ] && [ ${stat_tcpfb_last_l} -ne ${stat_tcpfb_now_l} ]; then
+	if [ ${stat_ooo} -eq 0 ] && [ ${stat_tcpfb} -gt 0 ]; then
 		mptcp_lib_pr_fail "unexpected fallback to TCP"
 		rets=1
 	fi
 
 	if [ $cookies -eq 2 ];then
-		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
+		if [ $stat_cookietx -eq 0 ] ;then
 			extra+=" WARN: CookieSent: did not advance"
 		fi
-		if [ $stat_cookierx_last -ge $stat_cookierx_now ] ;then
+		if [ $stat_cookierx -eq 0 ] ;then
 			extra+=" WARN: CookieRecv: did not advance"
 		fi
 	else
-		if [ $stat_cookietx_last -ne $stat_cookietx_now ] ;then
+		if [ $stat_cookietx -gt 0 ] ;then
 			extra+=" WARN: CookieSent: changed"
 		fi
-		if [ $stat_cookierx_last -ne $stat_cookierx_now ] ;then
+		if [ $stat_cookierx -gt 0 ] ;then
 			extra+=" WARN: CookieRecv: changed"
 		fi
 	fi
 
-	if [ ${stat_synrx_now_l} -gt ${expect_synrx} ]; then
+	if [ ${stat_synrx} -gt ${expect_synrx} ]; then
 		extra+=" WARN: SYNRX: expect ${expect_synrx},"
-		extra+=" got ${stat_synrx_now_l} (probably retransmissions)"
+		extra+=" got ${stat_synrx} (probably retransmissions)"
 	fi
-	if [ ${stat_ackrx_now_l} -gt ${expect_ackrx} ]; then
+	if [ ${stat_ackrx} -gt ${expect_ackrx} ]; then
 		extra+=" WARN: ACKRX: expect ${expect_ackrx},"
-		extra+=" got ${stat_ackrx_now_l} (probably retransmissions)"
+		extra+=" got ${stat_ackrx} (probably retransmissions)"
 	fi
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index fa91eebdbc47..91ec75ddcb96 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -111,7 +111,7 @@ mptcp_lib_pr_nstat() {
 	local hist="/tmp/${ns}.out"
 
 	if [ -f "${hist}" ]; then
-		awk '{ print "  "$0 }' "${hist}"
+		awk '$2 != 0 { print "  "$0 }' "${hist}"
 	else
 		ip netns exec "${ns}" nstat -as | grep Tcp
 	fi
@@ -388,6 +388,7 @@ mptcp_lib_is_v6() {
 mptcp_lib_nstat_init() {
 	local ns="${1}"
 
+	rm -f "/tmp/${ns}."{nstat,out}
 	NSTAT_HISTORY="/tmp/${ns}.nstat" ip netns exec "${ns}" nstat -n
 }
 
@@ -395,18 +396,25 @@ mptcp_lib_nstat_get() {
 	local ns="${1}"
 
 	# filter out non-*TCP stats, and the rate (last column)
-	NSTAT_HISTORY="/tmp/${ns}.nstat" ip netns exec "${ns}" nstat |
+	NSTAT_HISTORY="/tmp/${ns}.nstat" ip netns exec "${ns}" nstat -sz |
 		grep -o ".*Tcp\S\+\s\+[0-9]\+" > "/tmp/${ns}.out"
 }
 
 # $1: ns, $2: MIB counter
+# Get the counter from the history (mptcp_lib_nstat_{init,get}()) if available.
+# If not, get the counter from nstat ignoring any history.
 mptcp_lib_get_counter() {
 	local ns="${1}"
 	local counter="${2}"
+	local hist="/tmp/${ns}.out"
 	local count
 
-	count=$(ip netns exec "${ns}" nstat -asz "${counter}" |
-		awk 'NR==1 {next} {print $2}')
+	if [[ -s "${hist}" && "${counter}" == *"Tcp"* ]]; then
+		count=$(awk "/^${counter} / {print \$2; exit}" "${hist}")
+	else
+		count=$(ip netns exec "${ns}" nstat -asz "${counter}" |
+			awk 'NR==1 {next} {print $2}')
+	fi
 	if [ -z "${count}" ]; then
 		mptcp_lib_fail_if_expected_feature "${counter} counter"
 		return 1

-- 
2.51.0


