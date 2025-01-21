Return-Path: <linux-kselftest+bounces-24882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DCCA17FE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 15:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2314F3A1677
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9D1F37C1;
	Tue, 21 Jan 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLkVc/Yl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741C21F1508;
	Tue, 21 Jan 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470072; cv=none; b=r/bXP+tZg1RJuRC1LU9lOR5nPVK0S/InUt6iw3LKQCk4nV06tSBQLnuqD7KzMmBYviqVhXxNVi45pZRPxobfzGtOGFV6EtI2wxEXAWN6glxQG1Sv5jDkX/P7JqrFbte+F1YTDNS6dyY49hKFsrYsqUckKM3ScoBvXojJeijtQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470072; c=relaxed/simple;
	bh=opwCPYJorhwvT6LPZcF1FJUI08RBTf3CePh0PA5llic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CrI8amJvHainObrJCXsl2tzdlaeJwE4MsKLwEVGkGvBaHywK++kZa05SDOuU3EHqG7q1bsdgKlxEJ2vmFLecGyrairZhvzWusPaCZcAjFOuanB8cxjrxbxigIleI502DFSWbd0Al4ZWg3OaCiGURuNTxg0egslwVeT+kEvLZdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLkVc/Yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7D7C4CEE0;
	Tue, 21 Jan 2025 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737470070;
	bh=opwCPYJorhwvT6LPZcF1FJUI08RBTf3CePh0PA5llic=;
	h=From:To:Cc:Subject:Date:From;
	b=cLkVc/YlAJpwQYy+cYFcs1XhLSNDMvDRKBgPdkIYbK2YYHRHFLNcimHUh8RwYDjOo
	 nq2lplWtdsnshi/g+iIGCxdRo4vU2qTK8IX++5w7ADqDZFfp7O/XHjJojwFvOfZikh
	 ubroASzZtTQvwSAheRQlv2gXiIkll3zEKiW7rjFhgTk1Bk4NhCnRbOTtXYl2zZB3nJ
	 uDFZI6NwazDKUC9j217TmO6B1cGZScFvlB5iuHtr1KsG5RqrANWtdSQdvm//RKsFQA
	 OJal0McGcp6vBCNZran/gqjxIUUMXpqSKpNJag7dgLyR7zDft5hYyS5C8PR+OZCO0a
	 Doluqd+98sfzQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	matttbe@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests/net: packetdrill: more xfail changes (and a correction)
Date: Tue, 21 Jan 2025 06:34:23 -0800
Message-ID: <20250121143423.215261-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent change to add more cases to XFAIL has a broken regex,
the matching needs a real regex not a glob pattern.

While at it add the cases Willem pointed out during review.

Fixes: 3030e3d57ba8 ("selftests/net: packetdrill: make tcp buf limited timing tests benign")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: matttbe@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/packetdrill/ksft_runner.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index e15c43b7359b..ef8b25a606d8 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -39,11 +39,13 @@ if [[ -n "${KSFT_MACHINE_SLOW}" ]]; then
 	# xfail tests that are known flaky with dbg config, not fixable.
 	# still run them for coverage (and expect 100% pass without dbg).
 	declare -ar xfail_list=(
+		"tcp_eor_no-coalesce-retrans.pkt"
 		"tcp_fast_recovery_prr-ss.*.pkt"
+		"tcp_slow_start_slow-start-after-win-update.pkt"
 		"tcp_timestamping.*.pkt"
 		"tcp_user_timeout_user-timeout-probe.pkt"
 		"tcp_zerocopy_epoll_.*.pkt"
-		"tcp_tcp_info_tcp-info-*-limited.pkt"
+		"tcp_tcp_info_tcp-info-.*-limited.pkt"
 	)
 	readonly xfail_regex="^($(printf '%s|' "${xfail_list[@]}"))$"
 	[[ "$script" =~ ${xfail_regex} ]] && failfunc=ktap_test_xfail
-- 
2.48.1


