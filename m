Return-Path: <linux-kselftest+bounces-3052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A7A82E4B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 01:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96A31C2255D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 00:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F2E1CF9B;
	Tue, 16 Jan 2024 00:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOOhDcwx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA71DA34;
	Tue, 16 Jan 2024 00:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F1EC433C7;
	Tue, 16 Jan 2024 00:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364042;
	bh=VVXD0aEXGLECdGuWcTI7l7cPwqm3qQKh5NqXRBi7CP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VOOhDcwxuz09650/EDMPMxMoX1NG7aH3s6TiKG3spyaQHXdm6dIZVHUIbxRswcpEZ
	 Md1FCUVL9yfw6UwriWzYrx5Xz0P/jYIb7+gBhPD1w+VAP4QexfWjSbIw30vHGyZcC9
	 3EvsWWiufx1yz0McfWi4fiEWKyz7I/TsuowSkU0kT/AR5dH7dK/u9/zW3fR6/8NG7m
	 R28JSD+zlXTDLo2VmJQijpac2rPpTxFJzZIxu2W7EhCbWl86zSbFd+ZGDp4p4iQjQT
	 B9qmSEPXaKFarm/0rS5ZFk6bzx+SZvHoOS8amkTkfsNpK5FdVzlhPo+n/wvt+xi27H
	 zYOSYXagNHAdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sasha Levin <sashal@kernel.org>,
	w@1wt.eu,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/14] selftests/nolibc: fix testcase status alignment
Date: Mon, 15 Jan 2024 19:13:35 -0500
Message-ID: <20240116001347.213328-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001347.213328-1-sashal@kernel.org>
References: <20240116001347.213328-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index fb3bf91462e2..1fc4998f06bf 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -145,11 +145,11 @@ static void result(int llen, enum RESULT r)
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


