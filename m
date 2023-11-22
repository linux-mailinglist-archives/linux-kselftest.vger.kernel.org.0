Return-Path: <linux-kselftest+bounces-461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1CE7F5467
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 00:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B741F20CAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 23:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401AC3C0E;
	Wed, 22 Nov 2023 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="A+DzyIWo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45654110;
	Wed, 22 Nov 2023 15:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1700695286;
	bh=UvTHVLrVS7yXSVngtpUNw0aaFtisHMdv5IagkHAb8Vw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A+DzyIWop9H1iQqC4wC7ZOx+e18wBfsDCs2oqTHFLJYmu3W02n86u+DegEehx1vo5
	 zPnK5LHg5A1Gg9qKYUcvDua/04K/8lWDki8Nk6Hw6ybKKJJvjWzvlD3ht04llm2dg3
	 vqI0+I1UGmluY0dWiW/xLGaKI5pZkkW/27NZjQjk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 23 Nov 2023 00:21:27 +0100
Subject: [PATCH 3/3] selftests/nolibc: disable coredump via setrlimit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231123-nolibc-rlimit-v1-3-a428b131de2a@weissschuh.net>
References: <20231123-nolibc-rlimit-v1-0-a428b131de2a@weissschuh.net>
In-Reply-To: <20231123-nolibc-rlimit-v1-0-a428b131de2a@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700695285; l=1257;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=UvTHVLrVS7yXSVngtpUNw0aaFtisHMdv5IagkHAb8Vw=;
 b=6KaZT5arNtlQH/G4RUsDPzhaYavmO+ntu3wPDXuPTC1+AZtPQ7oKArk9dQd3zjNeWdHEh79kF
 0mI+PGBl1gJASvDvJ1nsyTFpMpIFBc+504WY/LcH19X3N09dwik+7xk
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

qemu-user does has its own implementation of coredumping.
That implementation does not respect the call to
prctl(PR_SET_DUMPABLE, 0) in run_protection().
This leads to a coredump for every test run under qemu-user.

Use also setrlimit() to inhibit coredump creation which is respected by
qemu-user.

Link: https://lore.kernel.org/qemu-devel/20231115-qemu-user-dumpable-v1-2-edbe7f0fbb02@t-8ch.de/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index d07cebace107..ccb8d017a3e7 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1167,6 +1167,7 @@ static int run_protection(int min __attribute__((unused)),
 {
 	pid_t pid;
 	int llen = 0, status;
+	struct rlimit rlimit = { 0, 0 };
 
 	llen += printf("0 -fstackprotector ");
 
@@ -1198,6 +1199,7 @@ static int run_protection(int min __attribute__((unused)),
 		close(STDERR_FILENO);
 
 		prctl(PR_SET_DUMPABLE, 0, 0, 0, 0);
+		setrlimit(RLIMIT_CORE, &rlimit);
 		smash_stack();
 		return 1;
 

-- 
2.43.0


