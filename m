Return-Path: <linux-kselftest+bounces-3894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C743844A8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3411F22478
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF6C3BB24;
	Wed, 31 Jan 2024 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qY3JcUtz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51D3FE55;
	Wed, 31 Jan 2024 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737852; cv=none; b=kbNNag6lLJEPiCcaDpGjwqSHObMwlEhONa1+czwF5J5xc1VXjH0cKin3RMTmSFLRKQeOp6nht5SJF4nIiOcyh+b07gMPRqXdZ9aqUtiBSSTxzIXTQAl+djXS2TlzkQ726JXuvrbB2xmLcu9a6mDgBJk70K/g9WQwDZRszhGwCG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737852; c=relaxed/simple;
	bh=7ex8wXU91IizPjh0jQ/bphZFec3+13vRX9xVzm9eVCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MdU0+xR2p+cR24de7jGowGOShw9dXeVBgXbOTTK9F0BoTDYuHVoJbQMxZUvhEGbAAEB2VlAFjIZbsFxXPjwgtjIRxpp+/tNnh+7FOe6K5fBDeBXnw1gFdpq0Y7kY6ERZMEwyK7HODWiXwHt5eFXEoYVU1W7BGisgTvnABoXpY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qY3JcUtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA7EC43394;
	Wed, 31 Jan 2024 21:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706737852;
	bh=7ex8wXU91IizPjh0jQ/bphZFec3+13vRX9xVzm9eVCw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qY3JcUtz53czGFGWDQzCYMqGHTnbczPVuwSg8sRLt/wdie8wybw27nU9h2jQEEiju
	 rX/Do5I9SCd7iM3oD+YZzF+wtgON7453KG5il7kvg3yJL8TJ+h4lQYe/x7NztyPoaT
	 0sgmQqcKf/ck7UIDDWKi+tOBhEQGuL+yzLGJKSQK6gMhXrBncWk3QZDj+GFXnhw0IV
	 Oauql7P9KjActzZRh0mI735OV2KEAq+KWSax5488aAuGXplqfFavlNTwVb1F2WZrMT
	 ip50WNAxhRMPe85TXAfbGJbM1dbxtiBnb9HHbZ1QNj7pF/DNmNtP5GwUA12lcRNj+5
	 qQG5PaduGtu0g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 22:49:53 +0100
Subject: [PATCH net 8/9] selftests: mptcp: join: stop transfer when check
 is done (part 1)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-8-4c1c11e571ff@kernel.org>
References: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
In-Reply-To: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7ex8wXU91IizPjh0jQ/bphZFec3+13vRX9xVzm9eVCw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlusCgR9aLuvRWOXlG6MziszCQ8mp2GsEAiqtW0
 GXUzTOESNOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbrAoAAKCRD2t4JPQmmg
 c5qfD/9eiCtto60omKuatyDP2V240ksPxO8Qmyf8GNq1eMuF0/67ZZ7+oYWkmftNkti34UhFUeD
 21p2ny633/am7IEOyloRo8FP9hEZrSBwDN+YRRI44eygEABZtAYGL9ACVNBI2VsYNJOHwYwCCco
 JC6BZRxhWjrM54PaBiRAaj8wBHupAhKl1M0MMv04mb+dTVL/FaTDVefjhi4nskpU/9+/1Bc+8BH
 bpth1dk/DukVe3qjiOkzinjOVby5M4EnBoHwhyXBVToVnGi0IADC6KKXuY0l4Y/i9GnI7PzL8Ke
 QrHgb0/e/PS0oQtGCa8ipYlEvEZV/PYKUQwSovQ2OdshLT13QgcaZ4SY9CGdifRKgPlH5zuAf++
 vdITJ2AJvb2zKJukU3BGc4hx19uyxfthenEn8Cr0qv9dsO8A5g06SukguhFZIf6V64c8IpwgsN9
 I8opQ12Agbgv2Xubx4AEFxwicXSYDBJX9/5qHMZl16yl3laaPOO2Q4pW/0PnjXz4mC0gaSwXhYA
 IV6D8WipJqcv0HnERcgMGKX5eT8XeLTgCY2VkyiOF7kwPugpJzdDCTfAUlP6e5KFAsr7ilZcrwk
 XanxsGXAuxdKeJplYs/e7HAke8ewM+IVlDgB81MuujXnv5SLkyrUTEqWZEeZQsmy0BOOn6K3A7o
 K1mgUQ4j+uJhgFg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the "Fixes" commit mentioned below, "userspace pm" subtests of
mptcp_join selftests introduced in v6.5 are launching the whole transfer
in the background, do the required checks, then wait for the end of
transfer.

There is no need to wait longer, especially because the checks at the
end of the transfer are ignored (which is fine). This saves quite a few
seconds in slow environments.

Note that old versions will need commit bdbef0a6ff10 ("selftests: mptcp:
add mptcp_lib_kill_wait") as well to get 'mptcp_lib_kill_wait()' helper.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Cc: stable@vger.kernel.org # 6.5.x: bdbef0a6ff10: selftests: mptcp: add mptcp_lib_kill_wait
Cc: stable@vger.kernel.org # 6.5.x
Reviewed-and-tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3a5b63026191..85bcc95f4ede 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3453,7 +3453,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
@@ -3475,7 +3475,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm create id 0 subflow

-- 
2.43.0


