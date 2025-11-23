Return-Path: <linux-kselftest+bounces-46339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7871AC7DAC3
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 03:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E925C352A71
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 02:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C251F91D6;
	Sun, 23 Nov 2025 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OutvcRMG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E161B532F;
	Sun, 23 Nov 2025 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763864167; cv=none; b=sK8Aptyt9CY+CY4DgTfEsbCV80AZe8uJ9ufFvRcNcI1FN1BnaVNQShUKqbn8ZIzQj9QUXLJG0zlmJCfjKu27FvPtTWbWEODHgbRI79zrL0DFh/imDUrWloD2Y1pRY/I8LjMFnIavGbijXSSoXzOFLWPDN1O/rftvg4UXPGgKcpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763864167; c=relaxed/simple;
	bh=e94l83o1RWwx3LdVcJkpyQgQwHfMYIJ+I+UxsnyuSQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7APugHChnfgB1x9wP5trFM0biRrcXaiINwJMb5FfLCi9iJw7L4IKWyFXIR7duQZ5tLUNoTd48tnS/KN7I9t3h/Kr1R0GL+cR55yOd2N9yIRnNKnmMDZW1JzgcFcbXLuuHKeD/7gx6FdzHJ1imCk0JmH0bo6cDKP2CL/DtGCmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OutvcRMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6495AC4CEF5;
	Sun, 23 Nov 2025 02:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763864166;
	bh=e94l83o1RWwx3LdVcJkpyQgQwHfMYIJ+I+UxsnyuSQ4=;
	h=From:To:Cc:Subject:Date:From;
	b=OutvcRMGS51L+tCg2ClFkt/7I+juAVXAjqWOTCpTMqL5JcTvwuihzJRCLCLEgD1Hs
	 CvYiQZKaxSAbZhVi27U3sxI5IZxZuoL/fP4JDZKnO/aWG01ucAB3B+c6PbE9hbQkRR
	 Je3e3XBu3Uq6GzRZ8U5GsQ7XNj/CKgqL+JyJrUWyASYHcQVTlBYva/KBQ6t5dYsmTv
	 O7UKwDcP1reNZSVTBOm4RLwpyVvgnAx/6VuSR8Qt1xfxhbH9W7YGVug46j10gJGtfY
	 xYW4Gp0dTmkW59TQwMjPcbI0O9M8vuL7HKpt4w93RtIIXvLN3gIrgWzWVe1KgsTtDk
	 3QiS1VVW+XZBQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	kuniyu@google.com,
	adelodunolaoluwa@yahoo.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: af_unix: don't use SKIP for expected failures
Date: Sat, 22 Nov 2025 18:16:01 -0800
Message-ID: <20251123021601.158709-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev CI reserves SKIP in selftests for cases which can't be executed
due to setup issues, like missing or old commands. Tests which are
expected to fail must use XFAIL.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: kuniyu@google.com
CC: adelodunolaoluwa@yahoo.com
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/af_unix/unix_connreset.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools/testing/selftests/net/af_unix/unix_connreset.c
index bffef2b54bfd..6eb936207b31 100644
--- a/tools/testing/selftests/net/af_unix/unix_connreset.c
+++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
@@ -161,8 +161,12 @@ TEST_F(unix_sock, reset_closed_embryo)
 	char buf[16] = {};
 	ssize_t n;
 
-	if (variant->socket_type == SOCK_DGRAM)
-		SKIP(return, "This test only applies to SOCK_STREAM and SOCK_SEQPACKET");
+	if (variant->socket_type == SOCK_DGRAM) {
+		snprintf(_metadata->results->reason,
+			 sizeof(_metadata->results->reason),
+			 "Test only applies to SOCK_STREAM and SOCK_SEQPACKET");
+		exit(KSFT_XFAIL);
+	}
 
 	/* Close server without accept()ing */
 	close(self->server);
-- 
2.51.1


