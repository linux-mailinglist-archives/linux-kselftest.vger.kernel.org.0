Return-Path: <linux-kselftest+bounces-4556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A5A8532EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 15:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017DCB20D63
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67F85788C;
	Tue, 13 Feb 2024 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNRHTFuW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65D58121;
	Tue, 13 Feb 2024 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834061; cv=none; b=gq+XHw/DSR0X5GQyxqVvjspy8ksn3o8hhZVHqmQzQzmEWfxvqXjbJ3ZHVDvMNtkXSqIc9szlqA42Yd/NbGO/04/C7nbsS+DfxJkK1gPPIN4gBgsELvD/BgHiDMjCxGjRXr6uIRwqHqtsgTVU4lY4/ANxJkdRhz2x3chi+9q1inw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834061; c=relaxed/simple;
	bh=g/Vzu87lH2Q3mBnaJ/7cY2bunu60dk3+AfUkoZ1uVZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQ1icyPqC8Mo4hu4A8MhJ3k20eUC6vcQiRm83kAT4q5LalmV/qKdTGpod4k9E2370a1DV4auUv8ZhkULnSCl0Mwsv83DR7iGwxwknj/5bgGT4GqMXZA08XpkayWkLWxsLg6wJUoNt408vMalKcBqEauPr1PSP0jVTY8MBYQc0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNRHTFuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE27C433C7;
	Tue, 13 Feb 2024 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707834061;
	bh=g/Vzu87lH2Q3mBnaJ/7cY2bunu60dk3+AfUkoZ1uVZ8=;
	h=From:To:Cc:Subject:Date:From;
	b=UNRHTFuWlo6rhIMsaQ+gQuTvhY/kOUYmVeKQhfcezLmZjMGV3ET/WXZzqim5rdZgF
	 0wTuWwmhR9iMf3BQiKrfVTFY/UL+wqOMehUFBBbBHMSrqRLVCPo6c0K/erXzX4wo5f
	 346Jbs0uxvcAa3J9dQWHPZYNbwtP/enp9Jq7D4XydwNiV9wGcK8laS68DRmOuFpqFM
	 Li0L9N7lK+AZQCKsdvfNeWekw5Eo99kKfMePPIikpr/8WXEM1QryXV24p21spj8x6P
	 rMBoEycxONaZFK0uzuqbZWhX8w0I5nSTb01WS9s2svvt6b+qzbYpMtFQt7nd7VupLg
	 31Y+K4V+JXbUA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: tls: increase the wait in poll_partial_rec_async
Date: Tue, 13 Feb 2024 06:20:55 -0800
Message-ID: <20240213142055.395564-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test runners on debug kernels occasionally fail with:

 # #  RUN           tls_err.13_aes_gcm.poll_partial_rec_async ...
 # # tls.c:1883:poll_partial_rec_async:Expected poll(&pfd, 1, 5) (0) == 1 (1)
 # # tls.c:1870:poll_partial_rec_async:Expected status (256) == 0 (0)
 # # poll_partial_rec_async: Test failed at step #17
 # #          FAIL  tls_err.13_aes_gcm.poll_partial_rec_async
 # not ok 699 tls_err.13_aes_gcm.poll_partial_rec_async
 # # FAILED: 698 / 699 tests passed.

This points to the second poll() in the test which is expected
to wait for the sender to send the rest of the data.
Apparently under some conditions that doesn't happen within 5ms,
bump the timeout to 20ms.

Fixes: 23fcb62bc19c ("selftests: tls: add tests for poll behavior")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/tls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index bc36c91c4480..49c84602707f 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1874,13 +1874,13 @@ TEST_F(tls_err, poll_partial_rec_async)
 		/* Child should sleep in poll(), never get a wake */
 		pfd.fd = self->cfd2;
 		pfd.events = POLLIN;
-		EXPECT_EQ(poll(&pfd, 1, 5), 0);
+		EXPECT_EQ(poll(&pfd, 1, 20), 0);
 
 		EXPECT_EQ(write(p[1], &token, 1), 1); /* Barrier #1 */
 
 		pfd.fd = self->cfd2;
 		pfd.events = POLLIN;
-		EXPECT_EQ(poll(&pfd, 1, 5), 1);
+		EXPECT_EQ(poll(&pfd, 1, 20), 1);
 
 		exit(!_metadata->passed);
 	}
-- 
2.43.0


