Return-Path: <linux-kselftest+bounces-5984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBA38732E1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA051F23B9C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 09:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02445EE75;
	Wed,  6 Mar 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFa3EGlK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A206C604AD;
	Wed,  6 Mar 2024 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718205; cv=none; b=mUc9XMVpj82YLOrvuaq0qG/jaAp0IZLod4SQIihbFm8mxrJYX5hqzkuQE/SJMdJfxcvpUaY/QWs7ysypLxXqKAwkwexqMdB0AyMCjzJKjHCdojqY6Ov/yqqYBjAJKHF3V3tXjUP8dW7XH4+ipCOlQtquLYudGA3qpQfougc//hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718205; c=relaxed/simple;
	bh=Cy5OZ0UopSJ8ayXyNJyzR01FZeyqxB46Wwi2MPX5dxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nC3il/bi6y0pj0AuSZyfsdquc0eTaPhoTbL/3zzZF8pUr8gCiOIW7V2ePcIBjBbovs69R8Y2EvqFFhHHj4Vrqj8Uamk1hMLn9/DM/xHgc6U701Mp9B+mhNsveHa10+tOaSfDIVI4LYmqgsDk/uCz3RbgK9qL4Jknh5JrALZ2k6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFa3EGlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1118C43143;
	Wed,  6 Mar 2024 09:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718204;
	bh=Cy5OZ0UopSJ8ayXyNJyzR01FZeyqxB46Wwi2MPX5dxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eFa3EGlKW6pSwiTdL02C6NdXeeeUYSSE2Y1rBgKQUPPJzWMrmNyKb5hLGGOT8HMLi
	 u7JNtrlf0Vk0CWo1xNtC3qr2ch+dJlJXXk7w0Uxun9oCpBuZ90SLcOvNYwBeptel5n
	 cRYidl6ePdz2qojKMajOQPGGkWPoGwD4FgFynOCqoDkg/bUmsCe+X5eQtOg00Gf9p6
	 4gkomOCunAbS0ctCz3zO0E7UTMhGdpNvgnahMEnLkSeC4u75KgRtbiy0mUqDByA8uQ
	 8jPXpkn9f+hFTcaM0lkS6H/nG/uzhG0LfbLEPS2zbsoEKnYwthOnj18erxfkdvbvNT
	 SMDFWJ2KXBN0g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 06 Mar 2024 10:42:55 +0100
Subject: [PATCH net-next v2 06/12] selftests: mptcp: add mptcp_lib_events
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-6-bc79e6e5e6a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3467; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LDj4VMmcr55UdujwQlhsdRt2+33t1o+1jYIS98CwZdc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl6DqmCaXRMKf7o+vUbBo3aH9myzQo2Ad2z5134
 s4eilWKqKSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeg6pgAKCRD2t4JPQmmg
 cwyFD/44kocG4UcFCaEvVIiHMyZ8aVDuIqgH0us+Qc0WkuTL93z03BTabGtMWs1lczJfU0bBopZ
 icrGQcz030ToQFxz6nStAnwe93IBqyxT4o2GnygCA2aSs4Y8VXdkGvZ2E/26HcX6CHmFnweON3O
 Dpf8aG4RlJ2EQKsv+A+31gl1NzozxCoug6qo8g35nAvFgxNUUDWBG24nn78DGI66wP7/NgCRfJO
 Hct3aatpC2iAstwTunhQjn2R+H+6wlkLg/S1mtf0vamlLIXlm6D25yyJTAe4E6QXsOri9DWAx6l
 Bp9elTHubtAxf+JaBIfhFs7VWZJtspiVDzY9wJomcREqeCXHFC5UkiuqaEb2xc8iKMkl4R2yuy8
 gADgFUzdRs7+1e66uxrHRX3tInZNXdgPYa4hoduPPICSE0KYHvVCxW4w4MXrdqR7mfOUSFX60jl
 86BMfvnZo5/w2vVoQRVz0E1Gy6x25/NQOoZxbT9D5djb6q89IFPcIm50YTRV7mNol7U7tZN8zTe
 1uBqdXK9fdPs2v6V7zixfeZfXjB/EbhNmYgzC4sachkMo8bOdtXC23Eko86L56V5R3T+nR9cr12
 6My05sZU3iB4YhW9qCdToIvcPvGbtG1ldpBV3gOjPE7GSedHwtPYP+GAXeT7UM9/8/5swlbUgD2
 M6tET1H/+1h6Ecg==
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
index 5f44a4ebd185..5d071b6eb780 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -398,3 +398,15 @@ mptcp_lib_ns_exit() {
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


