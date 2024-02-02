Return-Path: <linux-kselftest+bounces-4007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 990E6846EF2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 12:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D53A1F257DC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4F913EFE4;
	Fri,  2 Feb 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3bmcXcIj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1EE5FEF7;
	Fri,  2 Feb 2024 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873498; cv=none; b=gpAhJW+E2at1Wx7JwC+6zVp40eVvuULYzfkB4M6cEdZH61XTt9eFLHxgrM+4sDtNeBdnkbip3ftwI8a3K8nP+XgRxvkvqmejmF1tT6gyXEKhfuN5p5xWorJhOYSCfyxcsRL1bHqmqEL5XqoyLwcXroBP3En0mnRNt3RI5TzwXKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873498; c=relaxed/simple;
	bh=y0GUUHT+6utzfuC41fyJPiGU8siNhU+amnQRcBTcLQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yqzgy6GBRaxyB4c6s+z8oPxyaO5Bu/BzZIfWtN3Z5hPWv/5JcQrPMF0SgHiOUCHgHJYY7h2mXgM9JrjHkNDBz4GMpZ4W8Du9JUMNrjdHRbJ6srCKdEXwnX8OsvwSVYURHa+OuwYVZwaSirmlktWKpftSFS5AiZq44EiKC9rRIMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3bmcXcIj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706873495;
	bh=y0GUUHT+6utzfuC41fyJPiGU8siNhU+amnQRcBTcLQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=3bmcXcIj30VRmeCmmY+Ym86LbvMLxAmsZ1+9WkprrVt3iQzevJY56wjJIWdJqBXdj
	 20wNXjG+lGd+mG2USfLDIr1VOhLsdnxXkAJ38OVsd6KMXNK20c36Afs6+L33edOobQ
	 nzVnXBuVi60lDHc9VM0avrt1afmEzshkvl0htyC4cTzsQEYMF2IwSQqjBAsY32EEDN
	 mEwE+U9lR0Ndq508JuKGGS4x0FV/4nXwlPAFU5s7pYU/LOO/tSuUmI6mzcc8mulNRy
	 FYoEjZju5Nlf45G9RTR9Fo9Ckesjkg9pchTtJi0W8TpLpDf0F1ztxnJ7lxoDU4sBH7
	 0w4i1eOJv+LCA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C238237811CF;
	Fri,  2 Feb 2024 11:31:33 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/12] selftests/mm: map_populate: conform test to TAP format output
Date: Fri,  2 Feb 2024 16:31:10 +0500
Message-ID: <20240202113119.2047740-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240202113119.2047740-1-usama.anjum@collabora.com>
References: <20240202113119.2047740-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.
Minor cleanups have also been included.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/map_populate.c | 37 ++++++++++++++---------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/mm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
index 7945d07548751..5c8a53869b1bd 100644
--- a/tools/testing/selftests/mm/map_populate.c
+++ b/tools/testing/selftests/mm/map_populate.c
@@ -16,19 +16,21 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include "../kselftest.h"
 
 #define MMAP_SZ		4096
 
-#define BUG_ON(condition, description)					\
-	do {								\
-		if (condition) {					\
-			fprintf(stderr, "[FAIL]\t%s:%d\t%s:%s\n", __func__, \
-				__LINE__, (description), strerror(errno)); \
-			exit(1);					\
-		}							\
+#define BUG_ON(condition, description)						\
+	do {									\
+		if (condition)							\
+			ksft_exit_fail_msg("[FAIL]\t%s:%d\t%s:%s\n",		\
+					   __func__, __LINE__, (description),	\
+					   strerror(errno));			\
 	} while (0)
 
-static int parent_f(int sock, unsigned long *smap, int child)
+#define TESTS_IN_CHILD 2
+
+static void parent_f(int sock, unsigned long *smap, int child)
 {
 	int status, ret;
 
@@ -43,9 +45,10 @@ static int parent_f(int sock, unsigned long *smap, int child)
 	BUG_ON(ret <= 0, "write(sock)");
 
 	waitpid(child, &status, 0);
-	BUG_ON(!WIFEXITED(status), "child in unexpected state");
 
-	return WEXITSTATUS(status);
+	/* The ksft macros don't keep counters between processes */
+	ksft_cnt.ksft_pass = WEXITSTATUS(status);
+	ksft_cnt.ksft_fail = TESTS_IN_CHILD - WEXITSTATUS(status);
 }
 
 static int child_f(int sock, unsigned long *smap, int fd)
@@ -64,10 +67,11 @@ static int child_f(int sock, unsigned long *smap, int fd)
 	ret = read(sock, &buf, sizeof(int));
 	BUG_ON(ret <= 0, "read(sock)");
 
-	BUG_ON(*smap == 0x22222BAD, "MAP_POPULATE didn't COW private page");
-	BUG_ON(*smap != 0xdeadbabe, "mapping was corrupted");
+	ksft_test_result(*smap != 0x22222BAD, "MAP_POPULATE COW private page\n");
+	ksft_test_result(*smap == 0xdeadbabe, "The mapping state\n");
 
-	return 0;
+	/* The ksft macros don't keep counters between processes */
+	return ksft_cnt.ksft_pass;
 }
 
 int main(int argc, char **argv)
@@ -76,6 +80,9 @@ int main(int argc, char **argv)
 	FILE *ftmp;
 	unsigned long *smap;
 
+	ksft_print_header();
+	ksft_set_plan(TESTS_IN_CHILD);
+
 	ftmp = tmpfile();
 	BUG_ON(!ftmp, "tmpfile()");
 
@@ -101,7 +108,9 @@ int main(int argc, char **argv)
 		ret = close(sock[0]);
 		BUG_ON(ret, "close()");
 
-		return parent_f(sock[1], smap, child);
+		parent_f(sock[1], smap, child);
+
+		ksft_finished();
 	}
 
 	ret = close(sock[1]);
-- 
2.42.0


