Return-Path: <linux-kselftest+bounces-41383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F53B54E85
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8B2189A89B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B907230EF64;
	Fri, 12 Sep 2025 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8Z6AOWz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB73081D6;
	Fri, 12 Sep 2025 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681599; cv=none; b=bww1BJyuTJ3EUARWKenK/jJO9LYUiLiJlU70GEmZ+W2cq0QD+jVnZ1q1Qzy9j8WrQc4ol14IX9XB9JJDamuytcgn11Ccc+ETnQZgm5vpdh1rnqkKhhORtJl41rXIkr/BjQa0Oe4RWovYF2ZU7JsRBs17WtsjzCIUoYBPsFrj0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681599; c=relaxed/simple;
	bh=HIFJWzHgSq2h9T+HcGgSfW0yc/cfScRA14LNQRiK9cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J/NsNUAgBft4P+pn80UOsYQZwRUORrr3fhIZ6+gGM3BHJxZD+Rwbl2PasCCTJRYcnXYruaqeh1TaiZLbyGUtzoJynA1RQcjSwraYkrDVgV8b4uboIjV5DKUXD03/Zjg98+2yubl94HHoEFvvDxhWUuLbiuJYqEzn+DxbscZL1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8Z6AOWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30517C4CEF7;
	Fri, 12 Sep 2025 12:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757681599;
	bh=HIFJWzHgSq2h9T+HcGgSfW0yc/cfScRA14LNQRiK9cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g8Z6AOWzQtjySqdPEHaBoUe5v1/Dv9qja9uhXY8w63kvwKNts9K9hbvwsBKdsBdQX
	 yOlOhUn04h6zMWCOiPx/gLkLT+GfZOcuoZFXriEuIh6Sm2FYEVX5iVD6cA6oiWcicw
	 iR+SFffpnXmwsmqQ2XXkfcVV7mGziQJlVVWzzwiNAoBC638T686YuGy5ZjscHXt1F/
	 Umw3Z1FnC1hWmvRJgPbWj/rxve520weSJPHFg8pPTLWGSLgOWI7Y5xPPPlYDRHEfqR
	 vZu0iIT0js5EmGlfB3zCQUAPq1ppOPwP16L1DHY919Zy8INoiVaZq350jZSsa+0bNB
	 RAU+i5yJ/UreA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 14:52:24 +0200
Subject: [PATCH net 5/5] selftests: mptcp: sockopt: fix error messages
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-5-40171884ade8@kernel.org>
References: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-0-40171884ade8@kernel.org>
In-Reply-To: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-0-40171884ade8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Kishen Maloor <kishen.maloor@intel.com>, 
 Shuah Khan <shuah@kernel.org>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3129; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cpAk7g4LSetFcO9JBtJAi95qFs0Yx7aiWJZhlHLpHW0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOiK+aMkFTyfvr8xUhDedv9i339Nu+JdOh5Nne1tL3i
 rZBzsUnOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZSwsrIcKl97c+l3yM9V9q8
 P35s5s5otp8pm//+2GvmE5q4+pnNRWdGhj2RyrqJNwoerXiw5VfhnwWrv2ZM/2KkbFdolS75W+F
 HBD8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch fixes several issues in the error reporting of the MPTCP sockopt
selftest:

1. Fix diff not printed: The error messages for counter mismatches had
   the actual difference ('diff') as argument, but it was missing in the
   format string. Displaying it makes the debugging easier.

2. Fix variable usage: The error check for 'mptcpi_bytes_acked' incorrectly
   used 'ret2' (sent bytes) for both the expected value and the difference
   calculation. It now correctly uses 'ret' (received bytes), which is the
   expected value for bytes_acked.

3. Fix off-by-one in diff: The calculation for the 'mptcpi_rcv_delta' diff
   was 's.mptcpi_rcv_delta - ret', which is off-by-one. It has been
   corrected to 's.mptcpi_rcv_delta - (ret + 1)' to match the expected
   value in the condition above it.

Fixes: 5dcff89e1455 ("selftests: mptcp: explicitly tests aggregate counters")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index e934dd26a59d9b50445d61e8b8013ce3c8d2a8a0..112c07c4c37a3c827290a0b06d6307abca98c849 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -667,22 +667,26 @@ static void process_one_client(int fd, int pipefd)
 
 	do_getsockopts(&s, fd, ret, ret2);
 	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
-		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - ret);
+		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
+		       s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - (ret + 1));
 
 	/* be nice when running on top of older kernel */
 	if (s.pkt_stats_avail) {
 		if (s.last_sample.mptcpi_bytes_sent != ret2)
-			xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64,
+			xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64
+			       ", diff %" PRId64,
 			       s.last_sample.mptcpi_bytes_sent, ret2,
 			       s.last_sample.mptcpi_bytes_sent - ret2);
 		if (s.last_sample.mptcpi_bytes_received != ret)
-			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64,
+			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64
+			       ", diff %" PRId64,
 			       s.last_sample.mptcpi_bytes_received, ret,
 			       s.last_sample.mptcpi_bytes_received - ret);
 		if (s.last_sample.mptcpi_bytes_acked != ret)
-			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64,
-			       s.last_sample.mptcpi_bytes_acked, ret2,
-			       s.last_sample.mptcpi_bytes_acked - ret2);
+			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64
+			       ", diff %" PRId64,
+			       s.last_sample.mptcpi_bytes_acked, ret,
+			       s.last_sample.mptcpi_bytes_acked - ret);
 	}
 
 	close(fd);

-- 
2.51.0


