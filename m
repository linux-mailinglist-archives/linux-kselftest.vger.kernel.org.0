Return-Path: <linux-kselftest+bounces-7262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3C899B44
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C55A2838FD
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C3C16C689;
	Fri,  5 Apr 2024 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTJHfJG6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55416C687;
	Fri,  5 Apr 2024 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314355; cv=none; b=AROmmgFPFd6CLPorvbvP2YbrXwn6suHmIcuDOpuRDIG2QO7m2ptRnxPwAHqwC8Zh60/Htgn9pSfba1A7q8lO1wQ8OLKLf3xuEwEcWckFN0OfXSBhuS4/7n60DXr27BkGA+kmo/ezgONM5IxPKnHSN/w7mQb33tJ4og18SDClmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314355; c=relaxed/simple;
	bh=LXsOIJ8NsONyTTN3FulDWgUH6xKocdzz/TorHovE29s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iH8bQ+rjpWxSTZKhAS7vPI3N7D9qkcaj+KHB3VY2CXabztHbsWk5omA+BohlVu+g88DiUPy1zfU8p5KNXhc8oNKiFoW1duTAMtV2eCOFyqQLgHx0ZeUitdYVdyhAcManaSWRChRSzIoZzU4tnS+ca7NMWkOigA8hNINvaGcXse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTJHfJG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCAEC433F1;
	Fri,  5 Apr 2024 10:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314354;
	bh=LXsOIJ8NsONyTTN3FulDWgUH6xKocdzz/TorHovE29s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HTJHfJG6dJW4vX6auzQLEgI2PSIdLAXJn7bOoUsYt2gzD3hNteELo/sil7H9VrRPC
	 Cn+hvHPNlyb2JRWb/6QY+aHWcOJcEfSEgzv9E2t3hHLo/QAuURJtYyVOeEnp4Cb6nJ
	 JHBb82Cx+teX+DgYec+mZ5nCLQ81JEBBs2MrJmh0HDlOJJNNsoxNemFarEjBOaj/T0
	 h2YbypUiNFMpMHWElBr/82eNLo/JJQgj8MkczVRXBi85aecyEiCXUMN5tntmCWr5ow
	 hkgtv52GZSeMZLg8rqDSM9w3YPvJV35q0wqiZMvw19VqAC5H5Wborzi1dVUNNy3AKb
	 +DViii7BCuaSw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Apr 2024 12:52:07 +0200
Subject: [PATCH net-next 03/11] selftests: mptcp: export ip_mptcp to
 mptcp_lib
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-3-eabc9b960966@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3892; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VtaspLDZBNzR12vEqg16R7/RqEeGwnjSqjPIkQ3di7U=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD9fl1+jhpBmTVDHnfbc1qQNhQPBjf8Bx+qFnL
 MF6uxS9IamJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/X5QAKCRD2t4JPQmmg
 cy6yD/sH0uQbpRTPT1shdKXLkyyHXWUTQpd5wfJkhc7HdZwNrKpOl6v7QhtMbIJKE1Jbj8f4D0o
 CyUXwXpxtwbvMZYcMnHou+3IhGW3W/AqByxpmWlnSv1ADi74rCMPl3oLIkMiCwlFFxceEXFILU1
 Ts7tw6ohqIyalnA0eYP689FZ4QbAdD3U9mPw56VEDDcOwuqkYqWDwF7qspIVlqAHubLOKIfq+X8
 49/p7oO5QIE+G7OZHpbiDLVDlUrv7kT0M+px8Hpd91bgQU5Yr7Ti9IhB6Du6QgsNF2AZ3A2gI3I
 SVJ9iv9oyG/nW+pd9KO74uOSIC7s7FLb/yDdCo42sd/sCJ5uc54ZE+Bun9DHbP+JifKJbYSIHdq
 V1lwE9NN3blSbuAWYsjJdwL1G2vPoCLF1ouprHkpVNeKNTUkbQGjzK/jIpNf4AHwI8fP+VBJCfE
 pXtTw8qZwTIQgqRdt/x7+XSzcrNZHQBBScpCyUuCpMGdWiZu/RjGPuFrPthDhBPvqBY0x2TQx7u
 m8OtipDOML14VbEBBQoidILEz9HchQv3NPlrZdhh9OsuQLyt7VQJllE25ldNM12IaJotuMWZnuc
 Mx72tAZSxdcHNumzIG+2DxaNXfAWkHa4AbvLNOFZKZtOzYZ/ZBDPGehLwS4p1tGaC6HwK23L6sG
 eD2Arz/kSdyH/rA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch exports ip_mptcp into mptcp_lib.sh as a public variable,
named MPTCP_LIB_IP_MPTCP. Add a helper mptcp_lib_set_ip_mptcp() to set
it, and a helper mptcp_lib_is_ip_mptcp() to test whether it is set. Use
these two helpers in mptcp_join.sh.

This patch is prepared for coming commits.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 ++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  9 +++++++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 73a2131e6da2..62fcfeaa3430 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -31,7 +31,6 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 capture=false
 checksum=false
-ip_mptcp=0
 check_invert=0
 validate_checksum=false
 init=0
@@ -610,7 +609,7 @@ pm_nl_set_limits()
 	local addrs=$2
 	local subflows=$3
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		ip -n $ns mptcp limits set add_addr_accepted $addrs subflows $subflows
 	else
 		ip netns exec $ns ./pm_nl_ctl limits $addrs $subflows
@@ -650,7 +649,7 @@ pm_nl_add_endpoint()
 		nr=$((nr + 1))
 	done
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		ip -n $ns mptcp endpoint add $addr ${_flags//","/" "} $dev $id $port
 	else
 		ip netns exec $ns ./pm_nl_ctl add $addr $flags $dev $id $port
@@ -663,7 +662,7 @@ pm_nl_del_endpoint()
 	local id=$2
 	local addr=$3
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		[ $id -ne 0 ] && addr=''
 		ip -n $ns mptcp endpoint delete id $id $addr
 	else
@@ -675,7 +674,7 @@ pm_nl_flush_endpoint()
 {
 	local ns=$1
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		ip -n $ns mptcp endpoint flush
 	else
 		ip netns exec $ns ./pm_nl_ctl flush
@@ -686,7 +685,7 @@ pm_nl_show_endpoints()
 {
 	local ns=$1
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		ip -n $ns mptcp endpoint show
 	else
 		ip netns exec $ns ./pm_nl_ctl dump
@@ -699,7 +698,7 @@ pm_nl_change_endpoint()
 	local id=$2
 	local flags=$3
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
 	else
 		ip netns exec $ns ./pm_nl_ctl set id $id flags $flags
@@ -749,7 +748,7 @@ pm_nl_check_endpoint()
 		return
 	fi
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		# get line and trim trailing whitespace
 		line=$(ip -n $ns mptcp endpoint show $id)
 		line="${line% }"
@@ -3702,7 +3701,7 @@ while getopts "${all_tests_args}cCih" opt; do
 			checksum=true
 			;;
 		i)
-			ip_mptcp=1
+			mptcp_lib_set_ip_mptcp
 			;;
 		h)
 			usage
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1fa05405f65e..ca01d949fad8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -23,6 +23,7 @@ MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
 MPTCP_LIB_TEST_COUNTER=0
 MPTCP_LIB_TEST_FORMAT="%02u %-50s"
+MPTCP_LIB_IP_MPTCP=0
 
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
@@ -511,3 +512,11 @@ mptcp_lib_verify_listener_events() {
 	mptcp_lib_check_expected "type" "family" "saddr" "sport" || rc="${?}"
 	return "${rc}"
 }
+
+mptcp_lib_set_ip_mptcp() {
+	MPTCP_LIB_IP_MPTCP=1
+}
+
+mptcp_lib_is_ip_mptcp() {
+	[ "${MPTCP_LIB_IP_MPTCP}" = "1" ]
+}

-- 
2.43.0


