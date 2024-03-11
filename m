Return-Path: <linux-kselftest+bounces-6205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD83878301
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 16:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB74281F77
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C406153E22;
	Mon, 11 Mar 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtlyvqH0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491F44375;
	Mon, 11 Mar 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169967; cv=none; b=pb8FUnN568E8SgK0pHr2R7JdHo7p/wnyvWcy792FQmcdzsiIJjmwDV+6+6W/nXF+DT/tXk3IapbhiIpEmRMiO23Uf/cUKcBhVKNkGxkY5LWwzr1TYmg16UW8boQP9GU3Q9pSTmx9/Fnk0w64UdxwypKSIP32HCkIMvDloSudqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169967; c=relaxed/simple;
	bh=jkL9pcfs3sRnSPlvjikdgvSxArB73ECs5GBn3OKS72M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flCxS9g26vIusfjyY4vvNd72ZZp30W368XNC/uisboK0Loo5UJOXsnFEJi0chLLkdLABXKQEXiN5xJMMAlKM6+ZL9aQ10o8cyiKhmmQN28xMGItHG20QabubNtXi71mPR0BBn4D0DT5d9Ng622NUJUCYd9MOrkqTjPcHZe6C+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtlyvqH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BD3C43390;
	Mon, 11 Mar 2024 15:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169967;
	bh=jkL9pcfs3sRnSPlvjikdgvSxArB73ECs5GBn3OKS72M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JtlyvqH06S4VHV2OHqCDORJvywxAOJjBE5neDUZjwzd/ayHWzQhwwJ29uUlaxPvk1
	 SmYRSWZq7jgnoM0dPIjCy1qTThaupgcXsJCBXPtDSjH0LRkOJeGDfA4cgHlIOIHfJC
	 ScgZylm90YEWKSaSgcdDwhvZKfC0JorhMDzQUSxSP+bHF0DQ7ZLTNdkt3AL9k6pCzY
	 gVZau+v+LFavx6QjM5m2TDuktSk9zv2XtodDxyDd8SzlXmk/ZE6wTRqxlRUHQAZ6RR
	 HAtj7sucwtWkG1gVvICu9iLOQgFVyfVsuXFdJ/cstfg9lEDBq/cL3O7Guc1AjwzCvT
	 c2Vl0DXJOOGeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 14/23] selftests: mptcp: explicitly trigger the listener diag code-path
Date: Mon, 11 Mar 2024 11:11:54 -0400
Message-ID: <20240311151217.317068-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit b4b51d36bbaa3ddb93b3e1ca3a1ef0aa629d6521 ]

The mptcp diag interface already experienced a few locking bugs
that lockdep and appropriate coverage have detected in advance.

Let's add a test-case triggering the relevant code path, to prevent
similar issues in the future.

Be careful to cope with very slow environments.

Note that we don't need an explicit timeout on the mptcp_connect
subprocess to cope with eventual bug/hang-up as the final cleanup
terminating the child processes will take care of that.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240223-upstream-net-20240223-misc-fixes-v1-10-162e87e48497@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 30 ++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4d8c59be1b30c..ff9a4f45f852f 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -20,7 +20,7 @@ flush_pids()
 
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
 
-	for _ in $(seq 10); do
+	for _ in $(seq $((timeout_poll * 10))); do
 		[ -z "$(ip netns pids "${ns}")" ] && break
 		sleep 0.1
 	done
@@ -91,6 +91,15 @@ chk_msk_nr()
 	__chk_msk_nr "grep -c token:" "$@"
 }
 
+chk_listener_nr()
+{
+	local expected=$1
+	local msg="$2"
+
+	__chk_nr "ss -inmlHMON $ns | wc -l" "$expected" "$msg - mptcp" 0
+	__chk_nr "ss -inmlHtON $ns | wc -l" "$expected" "$msg - subflows"
+}
+
 wait_msk_nr()
 {
 	local condition="grep -c token:"
@@ -306,5 +315,24 @@ flush_pids
 chk_msk_inuse 0 "many->0"
 chk_msk_cestab 0 "many->0"
 
+chk_listener_nr 0 "no listener sockets"
+NR_SERVERS=100
+for I in $(seq 1 $NR_SERVERS); do
+	ip netns exec $ns ./mptcp_connect -p $((I + 20001)) \
+		-t ${timeout_poll} -l 0.0.0.0 >/dev/null 2>&1 &
+done
+
+for I in $(seq 1 $NR_SERVERS); do
+	mptcp_lib_wait_local_port_listen $ns $((I + 20001))
+done
+
+chk_listener_nr $NR_SERVERS "many listener sockets"
+
+# graceful termination
+for I in $(seq 1 $NR_SERVERS); do
+	echo a | ip netns exec $ns ./mptcp_connect -p $((I + 20001)) 127.0.0.1 >/dev/null 2>&1 &
+done
+flush_pids
+
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.43.0


