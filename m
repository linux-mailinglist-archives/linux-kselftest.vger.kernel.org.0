Return-Path: <linux-kselftest+bounces-39008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A5AB26FD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 21:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150E5AA3CCA
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 19:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69A7242D6B;
	Thu, 14 Aug 2025 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMJzbTEL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2311991BF;
	Thu, 14 Aug 2025 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755200611; cv=none; b=dybKx7gKgDftVZRwZiInkb3XCkOScfmKlIoq/7b4gp3881QspSkX6dXG6rXFLRmmy+Dn97/YaEQkYdM7f4H3zqkcg1qYjvRB8lMVkcBg/mGMNi1aHUmr3/0BP7wUb3MdwuHcB73KCdkIvDbjHZJWppgT1mEhSgTOyw3HYIvDEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755200611; c=relaxed/simple;
	bh=q5AbTToVeTbzvJZvo8fb7oqCH+wqqEcYWQpSYbQgF1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHTvrAKjw+xV29nF61hTi/SGdMtjS2I929lkNzlTaNCkh500xxw9w+3ToQIQc1bukrjw6BIXbFbpzhxNythtwX29QD2JrTtFXuRTxB3eUENnfH0uw6J4dNEThw+ZVBMm65Nfdv/PVSuJ/QANMWzhrB8G8coZsdcmXMSVRQr7GWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMJzbTEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBFDC4CEED;
	Thu, 14 Aug 2025 19:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755200611;
	bh=q5AbTToVeTbzvJZvo8fb7oqCH+wqqEcYWQpSYbQgF1o=;
	h=From:To:Cc:Subject:Date:From;
	b=EMJzbTELcSa0YALSMaq6XynS1y3GJUI1kDkGLG+iiSWqA1cK6kb82SudEoQd/l7C0
	 b0FznvleqQ5juRanb0W5YYsa3S/idbrwTIybLEpd70pYpQfQ74+P35wHP5SbcGY8zS
	 hEt1gYwyTuXoKPGsSd0MZbBZU0r/4ZberJ8MQMw67t7ZSTfXa+pedu73rX8P8+hcx3
	 R+RgFbBu2EgylhsTYiG2crcizTnno/+QUPthjl0P+kSRbi9VS0QxF/5FWKorbQaMXA
	 1CMRG0xAAmtDVgxOaqyiti6YywtARr+pSDR5MKzkUG5lC3nFynos7m3DGWG9krORDB
	 M5oclsegGRiXg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] selftests: tls: make the new data_steal test less flaky
Date: Thu, 14 Aug 2025 12:43:23 -0700
Message-ID: <20250814194323.2014650-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CI has hit a couple of cases of:

  RUN           global.data_steal ...
 tls.c:2762:data_steal:Expected recv(cfd, buf2, sizeof(buf2), MSG_DONTWAIT) (20000) == -1 (-1)
 data_steal: Test terminated by timeout
          FAIL  global.data_steal

Looks like the 2msec sleep is not long enough. Make the sleep longer,
and then instead of second sleep wait for the thieving process to exit.
That way we can be sure it called recv() before us.

While at it also avoid trying to steal more than a record, this seems
to be causing issues in manual testing as well.

Fixes: d7e82594a45c ("selftests: tls: test TCP stealing data from under the TLS socket")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/tls.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index dd82e198d21f..8df86ca630e0 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2875,17 +2875,18 @@ TEST(data_steal) {
 	pid = fork();
 	ASSERT_GE(pid, 0);
 	if (!pid) {
-		EXPECT_EQ(recv(cfd, buf, sizeof(buf), MSG_WAITALL),
-			  sizeof(buf));
+		EXPECT_EQ(recv(cfd, buf, sizeof(buf) / 2, MSG_WAITALL),
+			  sizeof(buf) / 2);
 		exit(!__test_passed(_metadata));
 	}
 
-	usleep(2000);
+	usleep(10000);
 	ASSERT_EQ(setsockopt(fd, SOL_TLS, TLS_TX, &tls, tls.len), 0);
 	ASSERT_EQ(setsockopt(cfd, SOL_TLS, TLS_RX, &tls, tls.len), 0);
 
 	EXPECT_EQ(send(fd, buf, sizeof(buf), 0), sizeof(buf));
-	usleep(2000);
+	EXPECT_EQ(wait(&status), pid);
+	EXPECT_EQ(status, 0);
 	EXPECT_EQ(recv(cfd, buf2, sizeof(buf2), MSG_DONTWAIT), -1);
 	/* Don't check errno, the error will be different depending
 	 * on what random bytes TLS interpreted as the record length.
@@ -2893,9 +2894,6 @@ TEST(data_steal) {
 
 	close(fd);
 	close(cfd);
-
-	EXPECT_EQ(wait(&status), pid);
-	EXPECT_EQ(status, 0);
 }
 
 static void __attribute__((constructor)) fips_check(void) {
-- 
2.50.1


