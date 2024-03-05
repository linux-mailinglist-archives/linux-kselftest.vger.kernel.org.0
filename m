Return-Path: <linux-kselftest+bounces-5912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE21871C25
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5666B238E2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5286A535CF;
	Tue,  5 Mar 2024 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVWRJHS+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE35DF0D;
	Tue,  5 Mar 2024 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635390; cv=none; b=j94xffIu5MPIQoB3s1QF0zwuje65KGpqgszKPNGHyU4R1umJY7c0efjNyRmxf2n0EV5PB4gYCUqG2Qc+6CNSFTZwADTlJdvf/AZIw+Mrp1dj3egpzqRiDSKUzJ/xaOPdebnkL+4RIlBeMu3YqsOCO7lhISghpZLYGsXcBhIP/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635390; c=relaxed/simple;
	bh=7MuoN5+40TBUchfvIOx0MBwidvrH7l5RkAVhK7k1HtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ljooETCmo8T4fJoQXvOHXJDs6+b65XpehYqj5Pl9FzvdB7J50+9KAxhtibE0nSdKnTrjtyFa8gRdOtopBOlBs4iVlaMIYqLj4BhGYL38Cq6Q0ARjXFDhES8SyM3p8EtdvZyfNPuj+aYNuOM71aya9dwVjatWlgrUC0Wqvt/dzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVWRJHS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3552FC433F1;
	Tue,  5 Mar 2024 10:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635389;
	bh=7MuoN5+40TBUchfvIOx0MBwidvrH7l5RkAVhK7k1HtE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tVWRJHS+L9Bjz/DQLo3UhB1Vn3rM8Z4CFhPeiri0JAFBaxSjw0H6djCUUsN2VGuPe
	 I/asD4s4i1fG3kflNefJ7mnRP8PtB5yDWVS8J0/ZEc72fee8DiDvO0yRn4kbbV+2fM
	 4W7PlNOr40rUdtk7nBohffV2eARKLWe0WxI8oZKIqk7W2LZ1zSAWkDpQLwlHuE+k/w
	 k/fQ9a3W/3wPMP6CFOUVq3Zj185pteX+6Zn1gzCdzzGpBIZhf1Y+8shlWMqoaNIuT3
	 XacGkND9Z5DsfOwY5TWEu7euhUv6h+SfezivqYbvgSQa4IOrxEF6+R5CrKeYg1YDU6
	 8SIwjEbcTy+JQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 11:42:37 +0100
Subject: [PATCH net-next 07/13] selftests: mptcp: add mptcp_lib_events
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-7-66618ea5504e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3467; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2RK9Mv0/VX8CgX8AP4PwJg4uzfuEN7SHfxg0Gz+tvmU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vcctpe9yIoLdlZI++yeZAQNd6V9UaCh+LWZ5
 e4CcmqSw4uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HAAKCRD2t4JPQmmg
 cz2hD/0beHDIW3LjTJav6xuWQrvvWpal91JrAoQF9jEBW5YSAlLZU/xfjH61FiAIMPrCY3ZW+nq
 elF9s9+i3m59321oIR/ndsB7RJd23GyrQwDGtDaKRwAQTQRfoFfT4BR4l9rCMAbT3Ezl/wT4dRi
 1Dj7zVw/9CWKF3wd7UuTEKrb6CKmcP6sD500cEt4q5oNSQ7D4davEkJOWssQcb2LSOUYJswZDU5
 rIDn/NGxqc6E4LVmTGNbtxEvdwDu/rBNtNhDW5Y+sI0pSHhBXqzFppiq8GIhUVfgaEil8uboUkH
 AR3mRidaJBjGnZ3dONP7cYdWFxhbm+A0gfjQiFhHBBC8EdYGNMO7Y7GOKhjr17HEoVVJOuJ9oDN
 /fDGcUp6e6UKNK9Tju1Jf8qftcnOArTrt9yHQrSVVEwbtqlmsg6vcMkoNFEPN1S+XOKiYH/Qtp7
 yApkYFLEaQ018trhPzCvv8WX7JaDr5gMLd4c5C1j3MoTfAJ46C8NKClC705Vvq3kuWFwAY6BDwG
 yuvUBTTK45exS/wqEfLHv03foB4GwcPav/xysBu51q4/YFHjSz6i11CzdfKKZN3RbD4MSSU7iUR
 JaBpUgxDiAhrKAQqV3l5Qns48F1iLwEA5TPxltrNC9wnI1JkP0F7RN7c53OpHxgMiD53nbaZ+19
 rMC+hLLUHlKi+gw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

To avoid duplicated code in different MPTCP selftests, we can add and
use helpers defined in mptcp_lib.sh.

This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
and mptcp_join.sh into a helper mptcp_lib_events(). Define it in
mptcp_lib.sh and use it in both scripts.

Note that mptcp_lib_kill_wait is now call before starting 'events' for
mptcp_join.sh as well, but that's fine: each test is started from a new
netns, so there will not be any existing pid there, and nothing is done
when mptcp_lib_kill_wait is called with 0.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 10 ++++------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 12 ++++++++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 ++------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2d9cf6f3bbf3..1df2d24979a0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -430,12 +430,8 @@ reset_with_events()
 {
 	reset "${1}" || return 1
 
-	:> "$evts_ns1"
-	:> "$evts_ns2"
-	ip netns exec $ns1 ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
-	evts_ns1_pid=$!
-	ip netns exec $ns2 ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
-	evts_ns2_pid=$!
+	mptcp_lib_events "${ns1}" "${evts_ns1}" evts_ns1_pid
+	mptcp_lib_events "${ns2}" "${evts_ns2}" evts_ns2_pid
 }
 
 reset_with_tcp_filter()
@@ -608,7 +604,9 @@ wait_mpj()
 kill_events_pids()
 {
 	mptcp_lib_kill_wait $evts_ns1_pid
+	evts_ns1_pid=0
 	mptcp_lib_kill_wait $evts_ns2_pid
+	evts_ns2_pid=0
 }
 
 pm_nl_set_limits()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index f98cde130869..5e8a3c4700e4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -422,3 +422,15 @@ mptcp_lib_ns_exit() {
 		rm -f /tmp/"${netns}".{nstat,out}
 	done
 }
+
+mptcp_lib_events() {
+	local ns="${1}"
+	local evts="${2}"
+	declare -n pid="${3}"
+
+	:>"${evts}"
+
+	mptcp_lib_kill_wait "${pid:-0}"
+	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
+	pid=$!
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6d71bf36a1b9..3200d0b96d53 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -178,21 +178,11 @@ make_connection()
 	if [ -z "$client_evts" ]; then
 		client_evts=$(mktemp)
 	fi
-	:>"$client_evts"
-	if [ $client_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $client_evts_pid
-	fi
-	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
-	client_evts_pid=$!
+	mptcp_lib_events "${ns2}" "${client_evts}" client_evts_pid
 	if [ -z "$server_evts" ]; then
 		server_evts=$(mktemp)
 	fi
-	:>"$server_evts"
-	if [ $server_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $server_evts_pid
-	fi
-	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
-	server_evts_pid=$!
+	mptcp_lib_events "${ns1}" "${server_evts}" server_evts_pid
 	sleep 0.5
 
 	# Run the server

-- 
2.43.0


