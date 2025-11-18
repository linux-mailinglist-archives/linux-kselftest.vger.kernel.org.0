Return-Path: <linux-kselftest+bounces-45839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 923EBC67EAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0FF292A24F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 07:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DAC3093C6;
	Tue, 18 Nov 2025 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezP7JTMj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97653093A6;
	Tue, 18 Nov 2025 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450481; cv=none; b=Un8Bqc+5rQgEfj8sbuGs8ST0teWwn57M5JJEYhD7PKdREFVqiNPyjoQEV0bekvilH8ZZdOLUcfJcwkm6lM+RmZsc/dP3pxvumFtCSLqUElVKghZg1RUcNGV5q56zLZVBVd214MOfoscZqm/TJAq1eAcW6FHxqJfWcbbOTgdNO9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450481; c=relaxed/simple;
	bh=bAcKyJTl5+BIraX49wqM5hclDHdO8ieXranCvHNp3SA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KN/MoBbbVMJBHY4mHXG9OObCru7wCIq4wx+qmeMzFAVAYnwjc9z79CPZ8FDTc5CB0sMG35vq2nNnne3gSSe4ObZSvgz6wp/YSKYVv2i1mr4N9r6YqRz2OoOrd5QX+HI5SUOwAlr3bx5ouQG+Trid+ahxO78rVwMZbcIEuBZzNkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezP7JTMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02023C4CEF1;
	Tue, 18 Nov 2025 07:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450480;
	bh=bAcKyJTl5+BIraX49wqM5hclDHdO8ieXranCvHNp3SA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ezP7JTMjzQwMr/IH2IZpp987ciP45uMNnKZWGgviQoRRT/9KyqwqPKIndNfPdP2Nj
	 9QBvLyuKgkA1OIy1lR3nW152XD8XzzobShtI3IIV4cwCNA088dtmlRLi5upqwzYeqT
	 RXso7pr1kk+arYG97SafNdDAGncLW1JsY/DQQKcAkUH4MvZa/eM9C049IbIKphzkQx
	 gSunnVji9veT3wyf670TKHOdj24xCqlpnEaOpMeCRnRvvavxYfrjTzFmb6d8838eGy
	 P/HQ0ACJN6OlIpYJpFwaahDm3xIqvlcIzrsCQw9+zTVOAwPORwN7YDAt6HaPqUyinX
	 J9sBoiNWEuImw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Nov 2025 08:20:27 +0100
Subject: [PATCH net 09/11] selftests: mptcp: join: userspace: longer
 timeout
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-9-806d3781c95f@kernel.org>
References: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
In-Reply-To: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3112; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bAcKyJTl5+BIraX49wqM5hclDHdO8ieXranCvHNp3SA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJl5ALmB2+OnOunwWyr8NXVNXBtz7p1Sx6VlP2YfqmDw
 +HykZKAjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImczGP4wyt69IyysF+G1cWZ
 Wca3Gr55VT5dXBmjvW5X3pzNzonSMxkZrtwObWEKFpO+t3b75aPJX/LrNC9mTTurL/a8WKxLSi+
 XCwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In rare cases, when the test environment is very slow, some userspace
tests can fail because some expected events have not been seen.

Because the tests are expecting a long on-going connection, and they are
not waiting for the end of the transfer, it is fine to have a longer
timeout, and even go over the default one. This connection will be
killed at the end, after the verifications: increasing the timeout
doesn't change anything, apart from avoiding it to end before the end of
the verifications.

To play it safe, all userspace tests not waiting for the end of the
transfer are now having a longer timeout: 2 minutes.

The Fixes commit was making the connection longer, but still, the
default timeout would have stopped it after 1 minute, which might not be
enough in very slow environments.

Fixes: 290493078b96 ("selftests: mptcp: join: userspace: longer transfer")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 93d38ded5e4e..74632beae2c6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3804,7 +3804,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 2 2
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1
@@ -3837,7 +3837,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
@@ -3865,7 +3865,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
@@ -3886,7 +3886,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
@@ -3910,7 +3910,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1

-- 
2.51.0


