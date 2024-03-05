Return-Path: <linux-kselftest+bounces-5913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC77871C27
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949DE285729
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B925E071;
	Tue,  5 Mar 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdhUdp+r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859A5DF3A;
	Tue,  5 Mar 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635393; cv=none; b=htnzt+n5tgAGt/zA7tCQBQSX6fH1VURD7zw3kPclY8BPzuCvj/jaTKcXrIQ0n+dD3nhcXwj95+1ERAD0UYxhmTGQG3vE1zrZBUwE9j4yBEpVZ2n1A+36RmeCMPB09KHWhSAMTG7dPClKPB7HI0Mi/UgmohLOhikkvzif5H9BBYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635393; c=relaxed/simple;
	bh=nj5zy96gmKnlenBRjur2RORmXzndyrMua5IHgdDEcu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amHoTYXkR770RHMi8o8AQTztTo798yzZw+COQpbMmV8aQEYpCKW1/5WVqK/ghyPJFeux4k07Lj/8P10EI3pCXDUX9ew1KwjmIv9WbNxkO5htgI6UadLfd2Hm1Ob9PqpRZ2h4R6A2R95UYypdmju0Hh/5THn/UthLf7x1hcJ9mZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdhUdp+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA69C433C7;
	Tue,  5 Mar 2024 10:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635393;
	bh=nj5zy96gmKnlenBRjur2RORmXzndyrMua5IHgdDEcu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kdhUdp+rMqncstTrSXPCSRREM+PVrl6uuaQtHSd4OE+SG4ygsjh3ugdrMITenWMNc
	 4PXzHs315uK1lRBoOTgali5+Eq+G9aGCb7iFZsTIJt9t/l7QCo4bm7d5MsNsFN5pDA
	 0UpIBsNzl57YqNNTkvTB9UQ/veDuYgXQ4Cp6dATOpR8j514VyZrrgrbUMwzubZOyoV
	 8lZDy9fNUn8bsE1m1bPm7OGYEx6PXcECN1dqKYpBmGuBVaKoaZ1krUPpzIMQl+1QW7
	 xtKkTKzW2fYRjv5MshBuNWusSeUQ5bKN1rTZOrV0An4JMzqOWP+deKq6GyQ6lg2pme
	 tT5YPmc5dM8FA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 11:42:38 +0100
Subject: [PATCH net-next 08/13] selftests: mptcp: diag: fix shellcheck
 warnings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-8-66618ea5504e@kernel.org>
References: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2683; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nj5zy96gmKnlenBRjur2RORmXzndyrMua5IHgdDEcu8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vcd3LGWePGSG1Mlb2jC+Tsdb0YBuRXuGfR2p
 6dNoqyyEVGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HQAKCRD2t4JPQmmg
 c4XrEACUAERJjxSzeSF/rv5EhpTrCB2Uw22Mb0Qf+8BQ5w6lfDaHTgyQvabGgYXT7wwZqOScVrF
 yXwprARTG7u498tTyHTRPodty+9iYcO9AenM1M5Ub7YS4RT0A+VDf/BEOq2karzMsxaAq4cGWh0
 qnQttttmrKC91fyIKdWZ9bkTnLgDTB54EOVHcoaHzz+xPWhF7pD4sot2jC4I6oBTzvA6r4ECQpe
 MSMRuHRVhFsArqu+5GsbcN5FfhP7hCYdjH6AcENeJSm/jeIOhiMKEPpB+SoT5bsXPgurF696lKv
 aLWtLSjo5UVAL4aSmYXaGWbjrlAQOvFqwHJGeCQaSGWReGl563J1+5TnExgTDbU2NKILYYSWQvs
 SUWdA+Yk6EpYFqhAFW9KPD0pXtBfPau9g5MyUA876KeLaVQWrPyDmzopq7Bnj2QhfO1qjSz3fk9
 PaoIJL/qwVA7URyP5sOTfgsuGv26FhenkYbaG67u0zY9/1rOmt2JghLbG0Hd2LdObIm3WkQnqT9
 kFI1DmwZa94qBERCe/NEzXuJmt++hwbOxfnscd4XYVAUrMIyfZYBzwUWs0l1CEP/tZmgFIvMdmG
 KyepIZ9ytiFIe3+nRD+/Ewls8gBpfsqGXGZOr3dCqKC69SC4rH5E4hbfC/d7RZ7333LmbnFhnaA
 7BABTbNVdEw5t9w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

shellcheck recently helped to prevent issues. It is then good to fix the
other harmless issues in order to spot "real" ones later.

Here, two categories of warnings are now ignored:

- SC2317: Command appears to be unreachable. The cleanup() function is
  invoked indirectly via the EXIT trap.

- SC2086: Double quote to prevent globbing and word splitting. This is
  recommended, but the current usage is correct and there is no need to
  do all these modifications to be compliant with this rule.

For the modifications:

  - SC2034: ksft_skip appears unused.
  - SC2046: Quote '$(get_msk_inuse)' to prevent word splitting.
  - SC2006: Use $(...) notation instead of legacy backticks `...`.

Now this script is shellcheck (0.9.0) compliant. We can easily spot new
issues.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 0ee93915bccb..d8f080f934ac 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -1,10 +1,14 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ns=""
-ksft_skip=4
 test_cnt=1
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
@@ -24,6 +28,8 @@ flush_pids()
 	done
 }
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
@@ -174,7 +180,7 @@ chk_msk_inuse()
 	expected=$((expected + listen_nr))
 
 	for _ in $(seq 10); do
-		if [ $(get_msk_inuse) -eq $expected ];then
+		if [ "$(get_msk_inuse)" -eq $expected ]; then
 			break
 		fi
 		sleep 0.1
@@ -260,7 +266,7 @@ chk_msk_inuse 0 "1->0"
 chk_msk_cestab 0 "1->0"
 
 NR_CLIENTS=100
-for I in `seq 1 $NR_CLIENTS`; do
+for I in $(seq 1 $NR_CLIENTS); do
 	echo "a" | \
 		timeout ${timeout_test} \
 			ip netns exec $ns \
@@ -269,7 +275,7 @@ for I in `seq 1 $NR_CLIENTS`; do
 done
 mptcp_lib_wait_local_port_listen $ns $((NR_CLIENTS + 10001))
 
-for I in `seq 1 $NR_CLIENTS`; do
+for I in $(seq 1 $NR_CLIENTS); do
 	echo "b" | \
 		timeout ${timeout_test} \
 			ip netns exec $ns \

-- 
2.43.0


