Return-Path: <linux-kselftest+bounces-40909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7AEB47C18
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 17:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512423C2017
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E028F2848A9;
	Sun,  7 Sep 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maVfkJvI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096327F18B;
	Sun,  7 Sep 2025 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757259193; cv=none; b=OH5cEHTzbZgdbO+TtOD385QiUmGwieoQ8b0SUGavs4nQ20mx69B2FUFp7nmA4Jm5n3Upso+GMjU7zXvUydsWYlE9s4RlSuzxORgcpUC+zMuavuyg6lgwkbEtiyyeQfG4oFGXUfeze6YVvtsNLNvE8BVrIRfAiacSA6He+YAV8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757259193; c=relaxed/simple;
	bh=pNHM5twt0DKjZhFVjKYzgZKU7n8BlxsD8d5xFnhet24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=naOz72cKNF0If2/X+i07MgSn6T5WlETgJHttAkH/Fr5IVbPg9CXMyFjMMqltfFpOBOMi+9WMZ/V88dtw7E//EM/devxH+38FAydTFgei1CJJl2VMlzp53ANICYLpBuuvJdGCZBaeQKsgQi9Si6iVE4wEaYNP+q8VizIfYx3UT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maVfkJvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99741C4CEF0;
	Sun,  7 Sep 2025 15:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757259192;
	bh=pNHM5twt0DKjZhFVjKYzgZKU7n8BlxsD8d5xFnhet24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=maVfkJvI4JqjyuJh/sIII/bX/aWYhsOjZRU2UTPvEC8sDK4wS6omlPR9nHZ6aZeSc
	 IBXzsWiNDVYdCiHo0W0Fr33gLt9cPWMovUPm6wrRPytW4ETm2mw1zPhw5oTgGdmJxq
	 vI8U+GnqL9MPM5lP2CnQv7D+ngHykDjIshHIMUfM73OHLK64eQpuK/Hh83zp/JgVZ6
	 0uz1mDnN7HyTRIPuDdPrrcKerITUblJRyGFdtpp8vm2OWRN0KvVK1maiYHg7iJgEAD
	 U6EBilRh9slpZSfYQTBG/xAp/iMKho7HPaKpqnwLS58dJRRrkMDd0qO8L7qoKibWaj
	 eYgdrKRTBgytA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 07 Sep 2025 17:32:43 +0200
Subject: [PATCH net-next 2/3] selftests: mptcp: join: tolerate more
 ADD_ADDR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-net-next-mptcp-add_addr-retrans-adapt-v1-2-824cc805772b@kernel.org>
References: <20250907-net-next-mptcp-add_addr-retrans-adapt-v1-0-824cc805772b@kernel.org>
In-Reply-To: <20250907-net-next-mptcp-add_addr-retrans-adapt-v1-0-824cc805772b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3664; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pNHM5twt0DKjZhFVjKYzgZKU7n8BlxsD8d5xFnhet24=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL2Ll3zW9Q6Y8252IeuxdwRW/8bT2t6+jni5hvloDyJx
 VlPixw8OkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYSMZmRoXsC/yMLxuQndw0r
 F67gUWtke+Azd+PiJI5fd3ttODPFPjH8r15v/2NvJ7dozn/tQ+eYVr/hOFt0Uea1+cZH3RmrinO
 suQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

ADD_ADDR can be retransmitted, and with, the parent commit, these
retransmissions can be sent quicker: from 2 minutes to less than one
second.

To avoid false positives where retransmitted ADD_ADDR causes higher
counters than expected, it is required to be more tolerant. Errors are
now only reported when fewer ADD_ADDRs have been sent/received, except
if no ADD_ADDR are expected.

Before the parent commit, the tolerance was present for each tests where
the ADD_ADDR could be retransmitted in a reasonable time (1 sec). Now
that all tests can have retransmitted ADD_ADDR, it is normal to apply
the same tolerance for all tests.

An alternative could be to disable the ADD_ADDR retransmissions by
default, but that's changing the default kernel behaviour. Plus,
ADD_ADDR retransmissions can be required for some tests. To avoid adding
exceptions to many tests, it seems better to increase the tolerance.

Later, we could add a new MIB counter to identify the ADD_ADDR
retransmissions, and remove the tolerance when this counter is
available.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2f046167a0b6cc6fb5531a033d8d95c9ea399cf9..e9e11a9e60fd5374c8a98c3b7159ccbca8053030 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -358,6 +358,7 @@ reset_with_add_addr_timeout()
 		tables="${ip6tables}"
 	fi
 
+	# set a maximum, to avoid too long timeout with exponential backoff
 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 
 	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
@@ -1669,7 +1670,6 @@ chk_add_nr()
 	local tx=""
 	local rx=""
 	local count
-	local timeout
 
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns2
@@ -1678,15 +1678,13 @@ chk_add_nr()
 		rx=" server"
 	fi
 
-	timeout=$(ip netns exec ${ns_tx} sysctl -n net.mptcp.add_addr_timeout)
-
 	print_check "add addr rx${rx}"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
 		print_skip
-	# if the test configured a short timeout tolerate greater then expected
-	# add addrs options, due to retransmissions
-	elif [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
+	# Tolerate more ADD_ADDR then expected (if any), due to retransmissions
+	elif [ "$count" != "$add_nr" ] &&
+	     { [ "$add_nr" -eq 0 ] || [ "$count" -lt "$add_nr" ]; }; then
 		fail_test "got $count ADD_ADDR[s] expected $add_nr"
 	else
 		print_ok
@@ -1774,18 +1772,15 @@ chk_add_tx_nr()
 {
 	local add_tx_nr=$1
 	local echo_tx_nr=$2
-	local timeout
 	local count
 
-	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
-
 	print_check "add addr tx"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
 	if [ -z "$count" ]; then
 		print_skip
-	# if the test configured a short timeout tolerate greater then expected
-	# add addrs options, due to retransmissions
-	elif [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
+	# Tolerate more ADD_ADDR then expected (if any), due to retransmissions
+	elif [ "$count" != "$add_tx_nr" ] &&
+	     { [ "$add_tx_nr" -eq 0 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
 		fail_test "got $count ADD_ADDR[s] TX, expected $add_tx_nr"
 	else
 		print_ok

-- 
2.51.0


