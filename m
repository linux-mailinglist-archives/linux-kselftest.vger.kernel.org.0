Return-Path: <linux-kselftest+bounces-5915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB274871C2D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89140284731
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482CF5F555;
	Tue,  5 Mar 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSTaQOpL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE85F548;
	Tue,  5 Mar 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635400; cv=none; b=NptnbmcETa/PjscLJlUBNgO3A878i9W50RBNItbNc+4JfZWgRRE0hEKsGAPIFfueWtEM/N6nrnO3/km9px/0HGickPE7LXCHcIKZ/Xl8ekQ4HDCRXpU1WxRIWe27JNS2E5tAjOsh/jxF0g7pZD4R8VgtAQo4LEDKHkbjwLAdQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635400; c=relaxed/simple;
	bh=NwkktJOVOyOm11rJZM5DvBJM453FEZ9/E/K3un3haFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N7mZrMT2zpGArkTXyw99Ymyl0pj4xQKWXm8dh0/o2Ftk0KWQ0iLs7FYqfjgrPPdFHn4+NJO4NV+Q7TOHhrLL/2v5YS8/Eh/9IuwYzyBAD0oVG8lonp7i7yonnu2/10axdpZ7m0F/oVgXMO50XyG99x0FvTmHuGOCQMm4EP1hmrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSTaQOpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DAEC43390;
	Tue,  5 Mar 2024 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635399;
	bh=NwkktJOVOyOm11rJZM5DvBJM453FEZ9/E/K3un3haFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gSTaQOpLbM2m9FnXoiHtFSXIPYIt4OdLankiCwkXMWdRVy27AaWtrk1Eq3P283i3O
	 JCcQnCwMMB+sVJk4A2lQ0QgnDTCv3t4d/oOhitjPCNJK5ruEm5rD8o2KygZbOSR2Fh
	 sXToWEr0GFX0hX+i3BvgqBD4WIxMpELymhOFNZ3Bi9pLB6MjNVfwQm59dw454sv1fS
	 u55gWslwr9SqoSfy5SF+D3wBQR78Ru7ZWBwppjW2pZ+LaVojwhoxSpvb92hnIxsqCy
	 /Ayta7zjzBICdAIXQQVkLlTADDx0htkRnDJePQ3kPfJJCPUt0vfBa6dDjiJ0mrMwSE
	 OggQ4LTRlmz7w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 11:42:40 +0100
Subject: [PATCH net-next 10/13] selftests: mptcp: sockopt: fix shellcheck
 warnings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-10-66618ea5504e@kernel.org>
References: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2750; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NwkktJOVOyOm11rJZM5DvBJM453FEZ9/E/K3un3haFI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vcdWuaAlevIvO3ifWFKv9tGrfikFIKMdj4wt
 f0fW7Fz4lGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HQAKCRD2t4JPQmmg
 czWVEACCKYZ+tBpEoaIRq1Z2Y+/SjIK6yEtcaJzJn5VKSfVoNs9EH/lxNN7qE6iYjGs9apkSQxp
 Y855JIRJwfDb+qoxQWot6kHIV7gSXvGBNuRj3tWs5hGnt8JJIEiy4kZnB3NKTMHDwgFU4ji/nHb
 ZCSNVr76zJP/+mIc03Jxlaug0J6th60CWwn4iHeoiU6BnLeBjt9DY0gi24rogm9hZ76/7M92sLG
 8fZwf8qmLc2N8Y2ULDzK25jFEbqAJnFyR1fyrMf2vt1qiXshX+11FaR1KCsQCkGNKJ+RX3MCAME
 rw7nrpuUvs0MVEB7s0FgoQhD3Pz2OmVyu58C5zSGO0kNhHFntMFYZkdOR5dIwhoAZBLl6KuKAeH
 jlJB9CDAVCsHavRJGZBBjnBLdkiOSTnkAI6cIBgZBSCGrbDi9uaMwrgHwN1MEQemptP+JUa7zOp
 m1zJxo54PcZI/KsM1V8f01M+z5+G81yUodLE6idzqD83p1Std4p6R5Z9zESMVgM5ND2/NCQleyD
 ArHWyqoOjy0/XLTI9lIhMx9XD0RsXHgLkxKPNLwPaEUGxX6Ix0w3JpBbdMtKwbmRI4kJQhA2068
 3chMa396dymrTOw8DTtQNTwTm+g8H1LBtbgff49NI2ZofAB8lhpMy9aKn8hc6dXp7URgmbvRvv4
 LWCs+Og5hHlmhGg==
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


