Return-Path: <linux-kselftest+bounces-6206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD97287833F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 16:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99192282C93
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403E76024B;
	Mon, 11 Mar 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9QWlWqa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE9D5FDC4;
	Mon, 11 Mar 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170011; cv=none; b=euejs2DLLOOq1TvVV0dWQ+ZbgS16F7hzdOdkb9ksZ2qpTyBJ9RroScAmD8tGAP8Dsh4V10Y2lSjcm19lXswXh2oB8xOE/fUnYicUMj1NA6D+uFdA4LjF3WCm8qN+f/hlJwLyZp13R2wGZpUG51aPzomNPb01VFQY77IWOwJCsvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170011; c=relaxed/simple;
	bh=jkL9pcfs3sRnSPlvjikdgvSxArB73ECs5GBn3OKS72M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gENI335pp6riwPCax9UP1HV4RSSVk69SOrHScCMuKhM3/lrGpEhFBjFtzfGn22dKy69hcXT/w16xc73h5qF024W8Q/yxbHME7M9MhII9K9X+hPc/6ExaHknloDMt0ikdPKRBo7JfriVlvQTK8kzGnYswcl7uU+MJMIbWfJP6eIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9QWlWqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E755C43390;
	Mon, 11 Mar 2024 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170010;
	bh=jkL9pcfs3sRnSPlvjikdgvSxArB73ECs5GBn3OKS72M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K9QWlWqabci0aYqlvGxyzbo/QVzT4Bp0zl3AgOdgTbNGNFn5PG+AOlJqebJDclynF
	 X/LFEhvpU0xJDBxrt4QJq5+Y6QVEbK3zA0soyo6bnTWp5LG9c4OPaQDC/5lA6sAxD/
	 pO4rtklwxvBjh+PrUTtyI/e9ulO1SnNfYM0J+8rzjmg8UciD/4GR6KvU8zfZ6AEwug
	 s1IaA25VPK8K5w5QO2DLuUTvi7Ewagu+BLkwox35V+1bW9LKowDYPdWsAFsRs/QF0I
	 l2WbUPy5zf8BMuGE4XlCQ1pBnKfPqTsPMRlpgFc4/x4W1vudmwqp5l+KkmEGD8rMYe
	 pT161nPGrKpIQ==
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
Subject: [PATCH AUTOSEL 6.6 09/17] selftests: mptcp: explicitly trigger the listener diag code-path
Date: Mon, 11 Mar 2024 11:13:00 -0400
Message-ID: <20240311151314.317776-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151314.317776-1-sashal@kernel.org>
References: <20240311151314.317776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
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


