Return-Path: <linux-kselftest+bounces-45670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3B0C5ECE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 19:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B113B3260
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B134CFA0;
	Fri, 14 Nov 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJBmJsGR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6533225A38;
	Fri, 14 Nov 2025 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143962; cv=none; b=WTikGMbJ3Mr4h5E098n7rXKAcB0s1Kec3A26040rtpD4FYzEUMSCXOivbwFIcTrJyPgyUiW/2tAQNS/JCZ3+TwzoGZuYipNay7ERTFtAjRE9xUc8xp0+ulN79v5vKjFK9N13G4zATlNu/y9BeamtYUcPDOJx6+GDZtMZVLDhLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143962; c=relaxed/simple;
	bh=tvWbDLJvMCusXB4MivXMB5KMx6BdY5fajVKVbvHmzSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4+zsB+dgp4+MKnPMaQGFz+AQ1SzuoRXZfebsegd3kL/5/vPKVMQEQHhUT9Yci5Ef/Wss2qcNB9q1spQtAbIscRXH8oGlkVF7OAAJRQjnxSIBgyFAqXplGhKnv3LTluHmq7RStBDOzWisyYbyL3EuDGmcRxXAX7qWkHPT4XErWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJBmJsGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B524C116D0;
	Fri, 14 Nov 2025 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143961;
	bh=tvWbDLJvMCusXB4MivXMB5KMx6BdY5fajVKVbvHmzSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mJBmJsGRGtzjXu3MoutQqFm2kguaytRSUepx2estzTJOq+LAUwU/VAeInyRXrW2b4
	 UMbIFXzxKZTkuSEzTXSQCJOBQb+9vOqBjd5fz5yKa4ppQu5dQ1q/fbCXohYI/Hf+lI
	 jiSbxMHIw9icaU5npKWBOCL5OyudmnV4VihK46PQ5HLPzxjZyXtD0QLkKSH/7ZSK8O
	 sUCOL1M/3VpLDNGI/0ML7BPj0yMYq+99JPVRRagq79lZsKSZuwHRu8XuNxhN5lZI3T
	 Ei3IgRkmBs3Iamt2VLfKeZwFTMSbhpWhO9NkYiuHwB4fXtaFP3WZh3WMch5c5z6Tw9
	 C9vazwMLr3+VQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Nov 2025 19:12:11 +0100
Subject: [PATCH net-next 7/8] selftests: mptcp: wait for port instead of
 sleep
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-7-863cb04e1b7b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tvWbDLJvMCusXB4MivXMB5KMx6BdY5fajVKVbvHmzSg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLFC5mPbefr3qdfMT2FUf6378STyyZzLdmf3PdkZx73D
 D2Ou46zO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACaSr83IMF1XZKXD5Vr/Q39T
 091LHvyb7TPZp7y6kO//lLbEmxx9uYwMe+Yt72h6bFnGbplRbpucoXJRJ4ThFrPvYcEtuSkzln3
 jBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After having started mptcp_connect in listening mode,
'mptcp_lib_wait_local_port_listen' can be used to wait for the listening
socket to be ready.

This is better than using the 'sleep' command, not to pause for a fixed
amount of time, but waiting for an event. This helper is used in all
other MPTCP selftests, but not in these two.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 42d533b95ec7..6cde7429104b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -178,7 +178,7 @@ do_transfer()
 				${local_addr} < "$sin" > "$sout" &
 	local spid=$!
 
-	sleep 1
+	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 87323942cb8a..e9ae1806ab07 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -211,7 +211,8 @@ make_connection()
 	ip netns exec "$ns1" \
 	   ./mptcp_connect -s MPTCP -w 300 -p $app_port -l $listen_addr > /dev/null 2>&1 &
 	local server_pid=$!
-	sleep 0.5
+
+	mptcp_lib_wait_local_port_listen "${ns1}" "${port}"
 
 	# Run the client, transfer $file and stay connected to the server
 	# to conduct tests

-- 
2.51.0


