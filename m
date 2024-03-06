Return-Path: <linux-kselftest+bounces-5987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4307B8732EA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA1BB20BDC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 09:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E2B60868;
	Wed,  6 Mar 2024 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuwaaCWV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851F605DF;
	Wed,  6 Mar 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718213; cv=none; b=A1A09aAtK0hMEVl8UriPZDqHBJKEwq2FSmP7hkXPUnu69IGWcmm2PK1PL87BwV+iGS0mfOoT/mHHUVhwFmedLEzgzYhEeEbHFGG3fNnB8NCSTYrVJXJDqkFagHqZpFPEqdwNXvRFVzKBABp0xR5YQgmbNoqDWE8b3C0g2pxcUmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718213; c=relaxed/simple;
	bh=NwkktJOVOyOm11rJZM5DvBJM453FEZ9/E/K3un3haFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVsrzoq9jf36pBvs4kCZWUTDg3p/CKpXUAP6+LMe8QV6yYS5p1WTJeWwtIUqu3FocVeG4vhEK9bPlsohHHhbT0I0bRcxj7nfND/xP1ABT5gfJ9Py+/2yzFhB1dmF6hvAuYMWm7JTgWouku4Yajd+nwzwFkocgWUokH/Qfrx/a40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuwaaCWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53849C43330;
	Wed,  6 Mar 2024 09:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718212;
	bh=NwkktJOVOyOm11rJZM5DvBJM453FEZ9/E/K3un3haFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OuwaaCWVGsiHWDNpC9jrI5NJtCtmdzkOb/YdJB45ESBZkqPHH+cYaWRkvZA11L5Lp
	 DrI3Ys4O03yG5oUH0ljDbPc8zb1SRgDm/Qeq9HpBqR8maRGI7KZf84Z6ftLSm/Tywz
	 Y9QrqSWaWHAsLlpBndtgyoo+I41aQmOBgcmUvmxOrY7nfiNBvgHBNy3m+w6ugub5VR
	 oG71+KmMbr+bMaf3FjgYCHcI5sacYT9KkQBC0L+sFptEriSk2XJNoFgkGdQ8SgMknF
	 PBu7knqWDp1BeVL44anG8L1c/r8xW7k9bTL09OpvZO9ZQC0FU1sTaI0YaCWyy5A9c5
	 wNwvWmD1ARRmw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 06 Mar 2024 10:42:58 +0100
Subject: [PATCH net-next v2 09/12] selftests: mptcp: sockopt: fix
 shellcheck warnings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-9-bc79e6e5e6a0@kernel.org>
References: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
In-Reply-To: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2750; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NwkktJOVOyOm11rJZM5DvBJM453FEZ9/E/K3un3haFI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl6DqmZIHbUJ9Mq482X+B1t+UQFmjtRM/io+YM7
 UV1/+HBMHKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeg6pgAKCRD2t4JPQmmg
 czH2D/4lwAZO4YceOGUm3wEti5VQBo+AgSJauIoRPgXKnoNlb07tN6gRV7HwsBNE335dMF0TiB5
 c6xtTExKLhUf3zSd0Og7zraNCOazsh/JgfB5asm8cUXtCxwUhes4Qk/c4S9k2eQ+ZshxeJXypfp
 /IFVpFR9NXuRdU8OUlBBpdC7f8duDed1fNciX1En1q47GcTXpXC0x7chvacnHIphIExgfLxnFtD
 Nosh8OqfMLwYcIC65WKo8sdfE5mP2nxUzmeZZVezoLC9LYqSU502OgMs3POJMyALseeexbkFQoK
 o1dIy2ZF+YHRiMweTbAgv6oHSt+YQpoqEmIWgcz5zJDvvja3mgEz0ExbfmY50zS+rO4BM6pJ1PI
 TbK5RKNr2qMrFaoYIsbWlJR03roVvPNzOJw+n3HZ1IhOhYeTxQnVfgeHGQ3WwSoakL41L4nYxKl
 UJ59/J5iiEEKyhbOrrSYLyyIo25aluOjWjCj4f9Ko/OcxBP9iysifkm1iYXAkXjXcXlX3q5k9c/
 UOKpININsaD1gox/OqNDOaL/9ArlT5DN2+JbeXTskf88ALHrXh4dZlzde75t408jYaqzs7umHXL
 9jJr2SV5hEZRfbBaoSoNveunHCnGumZPcOE5yVNUaPj3vBAcQHyClerjTh+YqaiZATtlqXRRbHv
 v6A6LyJlHJuDDJQ==
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
  - SC2006: Use $(...) notation instead of legacy backticks `...`.
  - SC2145: Argument mixes string and array. Use * or separate argument.

Now this script is shellcheck (0.9.0) compliant. We can easily spot new
issues.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 7dd0e5467d35..6ed4aa32222f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -1,6 +1,11 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ret=0
@@ -8,7 +13,6 @@ sin=""
 sout=""
 cin=""
 cout=""
-ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 iptables="iptables"
@@ -41,7 +45,7 @@ init()
 	mptcp_lib_ns_init ns1 ns2 ns_sbox
 
 	local i
-	for i in `seq 1 4`; do
+	for i in $(seq 1 4); do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
 		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
 		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
@@ -68,6 +72,8 @@ init()
 	add_mark_rules $ns2 2
 }
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns_sbox}"
@@ -257,12 +263,12 @@ do_tcpinq_test()
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "FAIL: mptcp_inq $@" 1>&2
+		echo "FAIL: mptcp_inq $*" 1>&2
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
 
-	echo "PASS: TCP_INQ cmsg/ioctl $@"
+	echo "PASS: TCP_INQ cmsg/ioctl $*"
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }

-- 
2.43.0


