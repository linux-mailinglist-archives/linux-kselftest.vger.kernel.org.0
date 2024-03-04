Return-Path: <linux-kselftest+bounces-5838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA16787065C
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 16:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6401F2466F
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C3C482DF;
	Mon,  4 Mar 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rIV/+q9Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA44C630;
	Mon,  4 Mar 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567976; cv=none; b=KDIMecZKBdOFCoH1tB1LoI9vrkgbYMZ8laR/8ZWSY7o4vgULV6C+XcQMANP4t41Kat3nFCXlnINO/VkAn0A+9A3CvsuAgORAezDIdMwOhLywRy0m5W0roFixdvU3+QnmS1QGGw9SXnP01Yc+1L5X6tk8mpKLzWuEGL34p/7uuec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567976; c=relaxed/simple;
	bh=kWwhagXSgzGBOzzHe1+SkKphXDZuQxr2VZJ2zSGNr7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+Zdr5zBUr09DO/N7jyS/HWKl7MIsp8EXMgDjN0htqlsC5Wq4dcdiW/tQT7eLE5OM6G4an9mq2tx0P2Y7Eix5LALjv/zh3HJ7YTRtB0GeEB4V9qfXtlFvq7O7Kwnme17t3LFnDrJGrJZ6ev6V8MRTX+JaV5dS3lZdA9IiLhd1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rIV/+q9Q; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709567972;
	bh=kWwhagXSgzGBOzzHe1+SkKphXDZuQxr2VZJ2zSGNr7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rIV/+q9QuURjC8AzXzjygtQmgYWce2d1gTJp7ei1RAGregxwsWFdzbRILE0UdcLKd
	 88Fqq5uusnT7lSkf6ryw8INw7HHA1mwyhgUapWWjRdrAdQYvXUtjERJlv0G/xJ6JvB
	 2cUcXz36Xy9fhPAQohalbcgem08UdrxH1P1J952O4sDtQUeE+6ieiSTOi52sgsFFoQ
	 7dWTaFlRKTdqgv3EztYRiQvkQvBaADzN/5zYlOCkto0W3cBw7LCA1XfE2HSASXsFyL
	 d6E4HHMjmVh/00QERi/PY4PfMBcHzNe+joUirI1yK8TnHMkufKlNi8GnEzqrtXlzh1
	 yaYxLDe6g+asA==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3D72237820CC;
	Mon,  4 Mar 2024 15:59:26 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	kernel-janitors@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] selftests/exec: conform test to TAP format output
Date: Mon,  4 Mar 2024 20:59:25 +0500
Message-Id: <20240304155928.1818928-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304155928.1818928-1-usama.anjum@collabora.com>
References: <20240304155928.1818928-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.
While at it, do minor cleanups like move the declarations of the variables
on top of the function.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../testing/selftests/exec/recursion-depth.c  | 53 +++++++++----------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/exec/recursion-depth.c b/tools/testing/selftests/exec/recursion-depth.c
index 2dbd5bc45b3ed..b2f37d86a5f62 100644
--- a/tools/testing/selftests/exec/recursion-depth.c
+++ b/tools/testing/selftests/exec/recursion-depth.c
@@ -23,45 +23,44 @@
 #include <fcntl.h>
 #include <sys/mount.h>
 #include <unistd.h>
+#include "../kselftest.h"
 
 int main(void)
 {
+	int fd, rv;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	if (unshare(CLONE_NEWNS) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
-			fprintf(stderr, "error: unshare, errno %d\n", errno);
-			return 4;
+			ksft_test_result_skip("error: unshare, errno %d\n", errno);
+			ksft_finished();
 		}
-		fprintf(stderr, "error: unshare, errno %d\n", errno);
-		return 1;
-	}
-	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
-		fprintf(stderr, "error: mount '/', errno %d\n", errno);
-		return 1;
+		ksft_exit_fail_msg("error: unshare, errno %d\n", errno);
 	}
+
+	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1)
+		ksft_exit_fail_msg("error: mount '/', errno %d\n", errno);
+
 	/* Require "exec" filesystem. */
-	if (mount(NULL, "/tmp", "ramfs", 0, NULL) == -1) {
-		fprintf(stderr, "error: mount ramfs, errno %d\n", errno);
-		return 1;
-	}
+	if (mount(NULL, "/tmp", "ramfs", 0, NULL) == -1)
+		ksft_exit_fail_msg("error: mount ramfs, errno %d\n", errno);
 
 #define FILENAME "/tmp/1"
 
-	int fd = creat(FILENAME, 0700);
-	if (fd == -1) {
-		fprintf(stderr, "error: creat, errno %d\n", errno);
-		return 1;
-	}
+	fd = creat(FILENAME, 0700);
+	if (fd == -1)
+		ksft_exit_fail_msg("error: creat, errno %d\n", errno);
+
 #define S "#!" FILENAME "\n"
-	if (write(fd, S, strlen(S)) != strlen(S)) {
-		fprintf(stderr, "error: write, errno %d\n", errno);
-		return 1;
-	}
+	if (write(fd, S, strlen(S)) != strlen(S))
+		ksft_exit_fail_msg("error: write, errno %d\n", errno);
+
 	close(fd);
 
-	int rv = execve(FILENAME, NULL, NULL);
-	if (rv == -1 && errno == ELOOP) {
-		return 0;
-	}
-	fprintf(stderr, "error: execve, rv %d, errno %d\n", rv, errno);
-	return 1;
+	rv = execve(FILENAME, NULL, NULL);
+	ksft_test_result(rv == -1 && errno == ELOOP,
+			 "execve failed as expected (ret %d, errno %d)\n", rv, errno);
+	ksft_finished();
 }
-- 
2.39.2


