Return-Path: <linux-kselftest+bounces-45246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB99C4886E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 19:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325C91887583
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F732ABF3;
	Mon, 10 Nov 2025 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNtxZlkS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7B32ABC7;
	Mon, 10 Nov 2025 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799051; cv=none; b=XE8ZSKaNc8/qaW1hdFi9BmM3Lwg+/R5R8z5ZqNVOa8RdJHnapnxCujPsDfhvsdJsSIugYVjGGP3txkWnLMfsm6ub2rSA9AulOm+x+pDOP6q767IYrZz2zpgc/ZcqCfh0WfY2JAVRqFHObT94pWheKlxnzMGCJh4FRFKmJvwzOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799051; c=relaxed/simple;
	bh=KrF/iIeTRVp7/CVT6bYLvNJMHrgrjbbkvO5N9Q1PkVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BlFRr0+5CFoMiEFLSaiDNOJ5Ve+EgP8PamUEBsJEgTViE7evJyvAo0TUK7IGB5qVh5p3pi3f1volCUGeRjgE2cyigGxH0xAvpB7OmEKv8+aHMhNCPHY3hUWxUG7RTXRuFLC4asrjEEt46Nrc6KgNhCaPhZDWL0uqfYPG90b+Wmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNtxZlkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38609C4AF0B;
	Mon, 10 Nov 2025 18:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799050;
	bh=KrF/iIeTRVp7/CVT6bYLvNJMHrgrjbbkvO5N9Q1PkVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BNtxZlkSoK8S1oDDwQJ9Sr05p3/dsHaKdQeUYdCyVex3wLVm2B4/7UoQsqtJ2n+Wm
	 N6G4S7SSa3MJnHYQaB0OQNRPDtQ9ht3TtjMZ4aGDJLSXKnAm78Ab2LLiiHNEKFq+vJ
	 8XJ5GCM3gZ3UD9BSNPq3ZLXQS8lsoj8USlA9uTU3XFr0E1r8T5AcomDX6Lh6Ey6ARO
	 V7lhyGSw6k9fsfGpHvAGBm2Sq2Tz2HxFEpNWWRW288u8DMYOMZIYoHPQWa3U+/FqDa
	 kVfCw5clCuEtTyGJOPPLgwQ5edX7pwCjHnl8UZw7s1pyZObOWDeOSAIY26h7k65BTb
	 M6FBUwr75czWg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 10 Nov 2025 19:23:40 +0100
Subject: [PATCH net 1/6] selftests: mptcp: connect: fix fallback note due
 to OoO
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-net-mptcp-sft-join-unstable-v1-1-a4332c714e10@kernel.org>
References: <20251110-net-mptcp-sft-join-unstable-v1-0-a4332c714e10@kernel.org>
In-Reply-To: <20251110-net-mptcp-sft-join-unstable-v1-0-a4332c714e10@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KrF/iIeTRVp7/CVT6bYLvNJMHrgrjbbkvO5N9Q1PkVE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKFdPdp6jhMli4TrUkQkry/6XL0VO+bGQuX7zY/1vFmz
 oq0tlyjjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIksW8zIsK3/Xf+lXnums/c+
 amRcWXWI+dq6Yx9fzeFmMRV5tXTbSzdGhv2XD3a3bdQXuBV0emp9Rkf24qUsJwru71vcZbPie6J
 ADSsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The "fallback due to TCP OoO" was never printed because the stat_ooo_now
variable was checked twice: once in the parent if-statement, and one in
the child one. The second condition was then always true then, and the
'else' branch was never taken.

The idea is that when there are more ACK + MP_CAPABLE than expected, the
test either fails if there was no out of order packets, or a notice is
printed.

Fixes: 69ca3d29a755 ("mptcp: update selftest for fallback due to OoO")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 47ecb5b3836e..9b7b93f8eb0c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -492,7 +492,7 @@ do_transfer()
 				  "than expected (${expect_synrx})"
 		retc=1
 	fi
-	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [ ${stat_ooo_now} -eq 0 ]; then
+	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
 			mptcp_lib_pr_fail "lower MPC ACK rx (${stat_ackrx_now_l})" \
 					  "than expected (${expect_ackrx})"

-- 
2.51.0


