Return-Path: <linux-kselftest+bounces-28904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C70A5F0BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18B33BCB2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9820A265CA7;
	Thu, 13 Mar 2025 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnmz/Ive"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B4264F90;
	Thu, 13 Mar 2025 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861420; cv=none; b=fmuj7WADfgisvEa8FJQiiYJiHKaHeB0evISfjIdKxDNXON8zAo33gLiCkdY3oRA74uNN8T0NCQ127DiXfM3qBLT6BW3vZX6p+wh7bs3xHclJzA3YjYlj6bPpAeBL1HoRSl9VOaiBc0GA7CBplIvX/W6sj8q2Ug6VRoqIT7ZsgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861420; c=relaxed/simple;
	bh=3F984dgkxbY6fPkXv+6fJCMjPaWNvKS7SFLAjQ5BVr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ad105awX4dWhv+fE91musVaqga7Mu2SRXc/AJPW/wFvspvE+R6WL+R1YuemNru+S0y79VgaWxZ0zb5gHl1Sgq+mWefpSd5I4E2XKg9qEpsl2gctJEmv1icYi9O8vNyM/fAt7hKB8/qHcJUah9sxs3EVd7f+YJwvCJpmjnO9oAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnmz/Ive; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DFCC4CEE3;
	Thu, 13 Mar 2025 10:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741861419;
	bh=3F984dgkxbY6fPkXv+6fJCMjPaWNvKS7SFLAjQ5BVr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fnmz/IvenKzyDaTbcaqWf4f8uu+jh6px4VUuCIEptlCm2OeaDysjT3zmIb3b0Z3wE
	 1yu5TRA8yMXGqQkPLEvs2P74ul2Fu83l5BJ0Ty4PnLaXPCAWpoUbJF/M6E7N2U+egd
	 LByaippAqOHi7557T4pj1nemmRTCWQ9IU1LmAKEup2myWtHfFFv6JXMu6E5gR+eT2f
	 w3TeteCXXOyxAZcwS4fYZuORHmVibqCeqsnjLtWJKu6QY4hAVbE3PqhLINxtI8pE/M
	 9MYdmR4OYJxJd8LgX0TalbgG6rTQR+qAzIKIExva5vqsi8Tt62+x2SJNbaqopUHErn
	 87OMlU4OsUzcg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Mar 2025 11:21:01 +0100
Subject: [PATCH net-next 12/12] selftests: mptcp: add pm sysctl mapping
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-net-next-mptcp-pm-ops-intro-v1-12-f4e4a88efc50@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2235; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Tc4PpQ+Y/jnprgu+15f2z73L06rmBn9s1LlWpDmpj4I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0rGbRH937aT7yKRBus6q5SgVNpqGBqg2hpW9t
 CbZC9NalcCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9KxmwAKCRD2t4JPQmmg
 c5SUD/9Sy+sMpYkhdzaJ4ijw9HCSPkKvL7xPzQB1qvLOh0PkXQlZf2gBvQ8KXhqOJg2P9TtUkJm
 xVW37RogFdsV3ByxlQD0Bib9rUGWIFIj6C8LXi1MBglQdo5xPlYkZzhcWWyXSOMGDANfEKzw4DZ
 j8R4N2rlwwzmbuFNBxR87Nk+Tet4kvHHL6YMG/ts3voh1PT1QyR7se27NrMAIFaqdWVbqAXLZsX
 yF4SlNVYo7Oz7+bZTWywLpT9dZbGkMHV+x0YC8+C1bh/sLT0jtF/tCxUkZLXIjcVNdeg5JRuHq8
 +Yz/5L+XqeocpGfhjp+df4ZGgujez+IlcnlT3YBg00s0Opi/HGY5ELlXYyYKZkJhiNjj7NdVgNW
 f2ARUlaFf1x/yYoLwyR7GzOIfnVhzKiGtmn3c42+iOicAgf311JfFdodVCaPbtrazNTjQTtEiSr
 qZREkGGiOaBcEoA3Z+Wk1TZokBdvtdGHx70LLvspqKZqjzS7QARsc+BAbLqbin/lV9+zGZafmvQ
 /0Ujw1PTSqbNJHWgpWXlGrpO+lFXg9xwOn4/4gpdqxVw9y7+6v5+A+ildw0nSfzpgRsfHekyoUj
 HNLLx9jwaEEARmKat34yC+0/B7TlcAlVsZFWK/PB8IOv6xtJrJs3K1RDJSvtFQ2WTijat9K5jzp
 KkS9TRXHDUJTB8w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch checks if the newly added net.mptcp.path_manager is mapped
successfully from or to the old net.mptcp.pm_type in userspace_pm.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 30 ++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 3651f73451cf8b07d4492c60da45e88aabc44b7a..333064b0b5ac03ae003417d2070f3c08f94743ed 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -117,7 +117,36 @@ cleanup()
 trap cleanup EXIT
 
 # Create and configure network namespaces for testing
+print_title "Init"
 mptcp_lib_ns_init ns1 ns2
+
+# check path_manager and pm_type sysctl mapping
+if [ -f /proc/sys/net/mptcp/path_manager ]; then
+	ip netns exec "$ns1" sysctl -q net.mptcp.path_manager=userspace
+	pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
+	if [ "${pm_type}" != "1" ]; then
+		test_fail "unexpected pm_type: ${pm_type}"
+		mptcp_lib_result_print_all_tap
+		exit ${KSFT_FAIL}
+	fi
+
+	ip netns exec "$ns1" sysctl -q net.mptcp.path_manager=error 2>/dev/null
+	pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
+	if [ "${pm_type}" != "1" ]; then
+		test_fail "unexpected pm_type after error: ${pm_type}"
+		mptcp_lib_result_print_all_tap
+		exit ${KSFT_FAIL}
+	fi
+
+	ip netns exec "$ns1" sysctl -q net.mptcp.pm_type=0
+	pm_name="$(ip netns exec "$ns1" sysctl -n net.mptcp.path_manager)"
+	if [ "${pm_name}" != "kernel" ]; then
+		test_fail "unexpected path-manager: ${pm_name}"
+		mptcp_lib_result_print_all_tap
+		exit ${KSFT_FAIL}
+	fi
+fi
+
 for i in "$ns1" "$ns2" ;do
 	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
 done
@@ -152,7 +181,6 @@ mptcp_lib_events "${ns1}" "${server_evts}" server_evts_pid
 sleep 0.5
 mptcp_lib_subtests_last_ts_reset
 
-print_title "Init"
 print_test "Created network namespaces ns1, ns2"
 test_pass
 

-- 
2.48.1


