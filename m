Return-Path: <linux-kselftest+bounces-3048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AA082E475
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 01:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13A4B229FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 00:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE5611721;
	Tue, 16 Jan 2024 00:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFwLD7yx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCA6134A4;
	Tue, 16 Jan 2024 00:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543B9C433F1;
	Tue, 16 Jan 2024 00:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364005;
	bh=+Z+bUBm6QBYZs0lVBU0c766gxq1FeMkkfKCQFbedMpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFwLD7yxirJoMrA3u5HILIyw8koHpwgTjl52xOPlaNut/tVjoQcqBqycB6RlEeRIn
	 xcPilo04PnU+f6bgiL6WpPMMgD78QOV3IDOlopT/JMiNhOjF7xt/jDP+ofwixYfz9j
	 ytkKamPcKIdeo1HGHUugTgQB27i079nNENAcSbaaAtrz0FZJAMN7ZAfkZsM2HZBsKN
	 HYkhY9WgtAM7RQUmX5ZtFOd5VYO2LctlNfAO5H0LEPZcL5Mz8AxdL+JZ+Sk8UWDEqb
	 jOBN22GtL8IYzvofe6hKYZQkUD/2PwaBstgeTnQlxjiQ7rMYxNcOxfgndL1cqvVZcZ
	 w9KHMqSAfmMYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sasha Levin <sashal@kernel.org>,
	w@1wt.eu,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 10/18] selftests/nolibc: fix testcase status alignment
Date: Mon, 15 Jan 2024 19:12:52 -0500
Message-ID: <20240116001308.212917-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001308.212917-1-sashal@kernel.org>
References: <20240116001308.212917-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 07f679b50252dc9e3d0c19aca5801f82c230c527 ]

Center-align all possible status reports.
Before OK and FAIL were center-aligned in relation to each other but
SKIPPED and FAILED would be left-aligned.

Before:

7 environ_addr = <0x7fffef3e7c50>                                [OK]
8 environ_envp = <0x7fffef3e7c58>                               [FAIL]
9 environ_auxv                                                  [SKIPPED]
10 environ_total                                                [SKIPPED]
11 environ_HOME = <0x7fffef3e99bd>                               [OK]
12 auxv_addr                                                    [SKIPPED]
13 auxv_AT_UID = 1000                                            [OK]

After:

7 environ_addr = <0x7ffff13b00a0>                                 [OK]
8 environ_envp = <0x7ffff13b00a8>                                [FAIL]
9 environ_auxv                                                  [SKIPPED]
10 environ_total                                                [SKIPPED]
11 environ_HOME = <0x7ffff13b19bd>                                [OK]
12 auxv_addr                                                    [SKIPPED]
13 auxv_AT_UID = 1000                                             [OK]

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 2f10541e6f38..e173014f6b66 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -150,11 +150,11 @@ static void result(int llen, enum RESULT r)
 	const char *msg;
 
 	if (r == OK)
-		msg = " [OK]";
+		msg = "  [OK]";
 	else if (r == SKIPPED)
 		msg = "[SKIPPED]";
 	else
-		msg = "[FAIL]";
+		msg = " [FAIL]";
 
 	if (llen < 64)
 		putcharn(' ', 64 - llen);
-- 
2.43.0


