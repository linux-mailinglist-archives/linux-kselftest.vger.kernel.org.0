Return-Path: <linux-kselftest+bounces-5916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C8B871C31
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B81E1C22C38
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A895F86B;
	Tue,  5 Mar 2024 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkX4hHEA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7095F856;
	Tue,  5 Mar 2024 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635404; cv=none; b=bxBswG+oA1c/EUp02F8gtWYGg0C2FgHrLG+9T4KzBVqhYxVBoo1zwdb7OEp0ZDWzQSBMGEFJ3GlGtH1SXsQiPeGjsMnpxw4+DGEm4pQzm2ZydSVJ5GrTbRkihJ+jmpAgYg1bv1lc6XLuwPjOEmgUwlsriiB9xxO6SEAfyUIDl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635404; c=relaxed/simple;
	bh=jTLgdGpKQfPiNeklV9atb8fDhX9KNQWViIOBx/XoGv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mKtMTpxVDafWpEttanJBjBGbogk7ewK7WTMWinXv+ydYtXXYTFa9vkDULl7ZbGqM46J1O43TlLaR61A9HXffSW+JuyMDf/tH9kXF0o6NK7UaN6Ip8MqTE/mCEfsxk816NOts+nuGJl1+Tm2NRXZku4YsYrDQeKf4FNuHLksBiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkX4hHEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A6DC433B1;
	Tue,  5 Mar 2024 10:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635404;
	bh=jTLgdGpKQfPiNeklV9atb8fDhX9KNQWViIOBx/XoGv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TkX4hHEAMClVUn5nkuG5bKcrNOWmUZP7Qk64sESHK0pPhjNrzXUoh0WG6V6GZizZo
	 fUYHbEI0jtC8x3B66nQ9TLDm+GbtX4dl5ajCSNQHOKKgH6FBJgGf+dOeREJCefcMr7
	 G4v6WTrzon3H4QQgMIO35XBv5dlWSNArRAHFJ/PyjdPHQa1J1PgD4KPc6syje8Ur4N
	 MIXKJiTRyewLqzRnsOopGfmycONRuypVOSWLLamCC3HtRYELFJSuFD1PjtJumO2LdZ
	 x/kHR3rVZHxV/6bEeD3QrIFo/KIpj9qv9gKlzyDIBOE2JJYVXWrHps+JzTYhJa98J+
	 R+2NLfqV02ZcA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 11:42:41 +0100
Subject: [PATCH net-next 11/13] selftests: mptcp: pm netlink: fix
 shellcheck warnings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-11-66618ea5504e@kernel.org>
References: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2721; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jTLgdGpKQfPiNeklV9atb8fDhX9KNQWViIOBx/XoGv0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vcd0nNYXiB6l2gK9AMj8z81KZJvYD2h/Kcwp
 o8JFWhK546JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HQAKCRD2t4JPQmmg
 c1/xEACpHrO9MASyiQCrywtvnuF8Lo5h4lBmRPGQcbLqVmrLGLVKzjADDr1QbIuavPw77HxnGPT
 KB1+v8cQ2BM0YlQ+/tAemy9vy+0yVJ+25UPbyesNf5bjnllSzYvzbliC2WkDZnB0DO6Xk+SRCtd
 0P5Rea6iJMK2y/fKMS/SbD6jNEDBKWh0KN0kERmjJMpGrBa9u5pMM/DaQKZ+M1BJ51uCNHPHBx0
 tFbc+JxqqhgsZsRrM3/OVr+isEpl/D/dzOk5PT2vtMEgKdQ1LDb2W5uxliW4c6/zP2UWqLqiOiz
 4IxcmcCb/mDeXSNn9VP4Q5PkTnuAcVj3bwzba4O1AE5M4Vdsah9Zs08UWET41MPUF8KU/6pqa2x
 N+3jrL6gDWZZyiPqbkfuUzwiQo07m+s4tnQJN6lDIfNQz76ugJ12nFii8PlqS9cLB1HXqWlkN1S
 aeoCi5RzewaFbBFjZHd6ob5gopZ6e6uzbAIuhbUZtNHPGFURn2bRvh1+keDaDjTQ361WICPbfoY
 ZaAznn+nY5B3oT0XvN7cblT+gZSfvCyQ1SYIj6Nxd8I6WQZda9Tmdo5dA6J2IprQJ7Kc38vtSCM
 0xY9u/+b+M7aS2JKBTNuhIQOBL5VUm6TJ9QGa3djffgkEjkq4kLRLOGuiU8JxjTTnkhprKtf+hO
 8tuXecsCBFGyzmQ==
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
  - SC2154: optstring is referenced but not assigned.
  - SC2006: Use $(...) notation instead of legacy backticks `...`.

Now this script is shellcheck (0.9.0) compliant. We can easily spot new
issues.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index c7c46152f6fd..427fc5c70b3c 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -1,16 +1,20 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ksft_skip=4
 ret=0
 
 usage() {
 	echo "Usage: $0 [ -h ]"
 }
 
-
+optstring=h
 while getopts "$optstring" option;do
 	case "$option" in
 	"h")
@@ -27,6 +31,8 @@ done
 ns1=""
 err=$(mktemp)
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	rm -f $err
@@ -91,14 +97,14 @@ check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
 check "ip netns exec $ns1 ./pm_nl_ctl get 4" "id 4 flags signal 10.0.1.4" "id addr increment"
 
-for i in `seq 5 9`; do
+for i in $(seq 5 9); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
 done
 check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9" "hard addr limit"
 check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
 
 ip netns exec $ns1 ./pm_nl_ctl del 9
-for i in `seq 10 255`; do
+for i in $(seq 10 255); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
 	ip netns exec $ns1 ./pm_nl_ctl del $i
 done

-- 
2.43.0


