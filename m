Return-Path: <linux-kselftest+bounces-45251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9E3C488AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 19:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B00C188F681
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 18:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C888532E6B3;
	Mon, 10 Nov 2025 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYU+YtIQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E2832E6A7;
	Mon, 10 Nov 2025 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799064; cv=none; b=G+JxJoPAubeRFjaftNR7mU6GLYH6Yc75PMT6Q39qlyAL9pB365Crv2JQ2yKequ6jGa5efyu0uOmiyJR0ggiKHTRk9p0IQdCF7Oofi7Z4Wfi5akC/SDdJSo+OmhepwW8Zf8wIanCTlZ12jG8SeGUfKyo+hjAwESqYiIQkUm6VI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799064; c=relaxed/simple;
	bh=rNX/qv1b1iAPPSF9UvN11BhMKo9TT2zldKEZXZLB5Uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGQq0BbeS8lbcp4jwyF+gmYGbixck4ngZhwGIrYHVKppjxVYj4FIwNXMfTUzl7w4WHNrYJKkcpc1ESTlM4DMgaYJ//Y01x1vrZ2JVbJe6EOrGVo7aX6u7/owBejgLJ35JCntTiAJ5H6T4NholVBkMzr67iekxoCfIhvgwww370E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYU+YtIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D822EC116D0;
	Mon, 10 Nov 2025 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799064;
	bh=rNX/qv1b1iAPPSF9UvN11BhMKo9TT2zldKEZXZLB5Uo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mYU+YtIQo8XQwOFl6334IV7EZGLLffUzMWY2YN+3GrKmU77HZAKI+jOoZbqPd9fSh
	 7S5pJJC+8kSwRqLqkvZo5RLxJAFVf6JsIzNMXELoS7pRHljGjeTcHfD0ZHmWAjy8di
	 nvps2BMwZkH2rcqvdYg0/KIkEYp1GsnvqnwYz0hFCuI2J5TiV0LTeh/oLxz+hAbm8S
	 v2EdktNHapsYFVzShFYwz6clzCYrfwFJF5dA+uDuxozwVGOBj3caU1Sy5Yjaq0Sjfp
	 gf0ZevQtUoLLm6KqYWWyD8XsEi6Xv9pyVCl8UsaTURjWBx6rG1mnfDK6eU0y+gu1sr
	 0yUxi5yJJbQxw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 10 Nov 2025 19:23:45 +0100
Subject: [PATCH net 6/6] selftests: mptcp: join: properly kill background
 tasks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-net-mptcp-sft-join-unstable-v1-6-a4332c714e10@kernel.org>
References: <20251110-net-mptcp-sft-join-unstable-v1-0-a4332c714e10@kernel.org>
In-Reply-To: <20251110-net-mptcp-sft-join-unstable-v1-0-a4332c714e10@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4441; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rNX/qv1b1iAPPSF9UvN11BhMKo9TT2zldKEZXZLB5Uo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKFdI/oNM2oODzD4O70uSH5F56d2nomOPIX25HXJ7jD8
 nKFQyc6dJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExExo7hf+QKwz7j0N1Rsy/f
 StP9YXVi2uuoLu09wZXlLJLVyr/CyxgZ9ik/6ww/J5EhInQ6qv3gxRdrhC0mnfu6rPZVrMGj2wK
 M/AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'run_tests' function is executed in the background, but killing its
associated PID would not kill the children tasks running in the
background.

To properly kill all background tasks, 'kill -- -PID' could be used, but
this requires kill from procps-ng. Instead, all children tasks are
listed using 'ps', and 'kill' is called with all PIDs of this group.

Fixes: 31ee4ad86afd ("selftests: mptcp: join: stop transfer when check is done (part 1)")
Cc: stable@vger.kernel.org
Fixes: 04b57c9e096a ("selftests: mptcp: join: stop transfer when check is done (part 2)")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 +++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 01273abfdc89..41503c241989 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3831,7 +3831,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
@@ -3859,7 +3859,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	# userspace pm create id 0 subflow
@@ -3880,7 +3880,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	# userspace pm remove initial subflow
@@ -3904,7 +3904,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	# userspace pm send RM_ADDR for ID 0
@@ -3930,7 +3930,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 }
 
@@ -3960,7 +3960,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
@@ -4015,7 +4015,7 @@ endpoint_tests()
 			chk_mptcp_info subflows 3 subflows 3
 		done
 
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 
 		kill_events_pids
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
@@ -4089,7 +4089,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 
 		kill_events_pids
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
@@ -4137,7 +4137,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 
 		join_syn_tx=3 join_connect_err=1 \
 			chk_join_nr 2 2 2
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d62e653d48b0..f4388900016a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -350,6 +350,27 @@ mptcp_lib_kill_wait() {
 	wait "${1}" 2>/dev/null
 }
 
+# $1: PID
+mptcp_lib_pid_list_children() {
+	local curr="${1}"
+	# evoke 'ps' only once
+	local pids="${2:-"$(ps o pid,ppid)"}"
+
+	echo "${curr}"
+
+	local pid
+	for pid in $(echo "${pids}" | awk "\$2 == ${curr} { print \$1 }"); do
+		mptcp_lib_pid_list_children "${pid}" "${pids}"
+	done
+}
+
+# $1: PID
+mptcp_lib_kill_group_wait() {
+	# Some users might not have procps-ng: cannot use "kill -- -PID"
+	mptcp_lib_pid_list_children "${1}" | xargs -r kill &>/dev/null
+	wait "${1}" 2>/dev/null
+}
+
 # $1: IP address
 mptcp_lib_is_v6() {
 	[ -z "${1##*:*}" ]

-- 
2.51.0


