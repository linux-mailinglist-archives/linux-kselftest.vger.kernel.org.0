Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B23A515F
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jun 2021 01:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFLXYe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Jun 2021 19:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFLXYe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Jun 2021 19:24:34 -0400
X-Greylist: delayed 92 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Jun 2021 16:22:33 PDT
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BA4C061574
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Jun 2021 16:22:33 -0700 (PDT)
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net (vla1-fdfb804fb3f3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 9E8212E131C;
        Sun, 13 Jun 2021 02:20:58 +0300 (MSK)
Received: from vla5-d6d5ce7a4718.qloud-c.yandex.net (vla5-d6d5ce7a4718.qloud-c.yandex.net [2a02:6b8:c18:341e:0:640:d6d5:ce7a])
        by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id jSwUFIDoiG-Kw103prR;
        Sun, 13 Jun 2021 02:20:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1623540058; bh=QVmH0vG3ut7uHTVd6NJfI4q7ACcQ76InMyG+bHNDI4w=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=ABoQFJsncN6kdvpw0YPzw2adWPunjppdyu6/NzGcTOnAqk8aO38z0QkduBZuZNbn/
         tZMI4MU+QHoQFPiZ+LADznPsR8WiOeAXrAyDo75qofcEmuzYvFIqhSGHxWh4UAWnOu
         dymO+xKcf061GsP+KyHpKg8DDeQaas5hv2k4A0+c=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from ov.vla.yp-c.yandex.net (ov.vla.yp-c.yandex.net [2a02:6b8:c0f:1a86:0:696:9377:0])
        by vla5-d6d5ce7a4718.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id iFFaKTA8EI-Kw2q07Le;
        Sun, 13 Jun 2021 02:20:58 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Alexander Ovechkin <ovov@yandex-team.ru>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, laoar.shao@gmail.com, guro@fb.com,
        dmtrmonakhov@yandex-team.ru
Subject: [PATCH] selftests: cgroup: add stale mem protection values test
Date:   Sun, 13 Jun 2021 02:20:01 +0300
Message-Id: <20210612232001.11399-1-ovov@yandex-team.ru>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add test case that reproduces premature oom caused by usage of stale
mem protection. Usage of stale mem protection could lead to throttle
of reclaim in target memcg and thus could trigger OOM.

This bug was fixed in 22f7496f0b90 ("mm, memcg: avoid stale protection
values when cgroup is above protection").

Signed-off-by: Alexander Ovechkin <ovov@yandex-team.ru>
---
 tools/testing/selftests/cgroup/cgroup_util.c  | 21 ++--
 tools/testing/selftests/cgroup/cgroup_util.h  |  1 +
 .../selftests/cgroup/test_memcontrol.c        | 96 +++++++++++++++++++
 3 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 027014662fb2..b4e90fe56c11 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -12,6 +12,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/mman.h>
 #include <unistd.h>
 
 #include "cgroup_util.h"
@@ -456,22 +457,28 @@ int get_temp_fd(void)
 	return open(".", O_TMPFILE | O_RDWR | O_EXCL);
 }
 
+int touch_file(int fd, size_t size, off_t offset) {
+	char *buf;
+
+	buf = mmap(0, size, PROT_READ, MAP_SHARED | MAP_POPULATE, fd, offset);
+	if (!buf)
+		return -1;
+	munmap(buf, size);
+	return 0;
+}
+
 int alloc_pagecache(int fd, size_t size)
 {
-	char buf[PAGE_SIZE];
 	struct stat st;
-	int i;
 
 	if (fstat(fd, &st))
 		goto cleanup;
 
-	size += st.st_size;
-
-	if (ftruncate(fd, size))
+	if (ftruncate(fd, st.st_size + size))
 		goto cleanup;
 
-	for (i = 0; i < size; i += sizeof(buf))
-		read(fd, buf, sizeof(buf));
+	if (touch_file(fd, size, st.st_size))
+		goto cleanup;
 
 	return 0;
 
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 5a1305dd1f0b..c9f3af07d969 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -42,6 +42,7 @@ extern int cg_run_nowait(const char *cgroup,
 			 int (*fn)(const char *cgroup, void *arg),
 			 void *arg);
 extern int get_temp_fd(void);
+extern int touch_file(int fd, size_t size, off_t offset);
 extern int alloc_pagecache(int fd, size_t size);
 extern int alloc_anon(const char *cgroup, void *arg);
 extern int is_swap_enabled(void);
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index c19a97dd02d4..63b0b4403f4d 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -20,6 +20,7 @@
 #include "../kselftest.h"
 #include "cgroup_util.h"
 
+
 /*
  * This test creates two nested cgroups with and without enabling
  * the memory controller.
@@ -579,6 +580,24 @@ static int alloc_pagecache_max_30M(const char *cgroup, void *arg)
 
 }
 
+static int touch_pagecache(const char *cgroup, void *arg) {
+	int fd = (long)arg;
+	struct stat st;
+
+	if (fstat(fd, &st))
+		return -1;
+
+	return touch_file(fd, st.st_size, 0);
+}
+
+static int alloc_pagecache_300M(const char *cgroup, void *arg)
+{
+	int fd = (long)arg;
+
+	return alloc_pagecache(fd, MB(300));
+}
+
+
 /*
  * This test checks that memory.high limits the amount of
  * memory which can be consumed by either anonymous memory
@@ -1169,6 +1188,82 @@ static int test_memcg_oom_group_score_events(const char *root)
 	return ret;
 }
 
+/* 
+ * First, this test creates the following hierarchy: 
+ * A   memory.low = 200M, memory.max = 200M
+ * A/B memory.low = 200M, memory.max = 200M
+ * A/C memory.low = 200M, memory.max = 200M
+ *
+ * Then it triggers relaim in A, by allocating A/B and A/C
+ * pagecaches. During this reclaim elow values of A/B and A/C are
+ * filled.  
+ * Then it lowers limits for A/C to create memory pressure
+ * and trigger reclaim in A/C. Usage of elow value assigned during
+ * previous step as memory protection will lead with high probabilty
+ * to OOM.
+ */
+static int test_memcg_stale_protection_oom(const char *root) {
+	int i;
+	int fd = -1;
+	char *memcgs[3] = {0};
+	const int memcgs_count = sizeof(memcgs)/sizeof(memcgs[0]);
+	int ret = -1;
+	char *low1 = "200M", *low2 = "100M";
+
+	for (i = 0; i < memcgs_count; ++i) {
+		char name[] = "memcg_test_\0";
+		name[sizeof(name)-2] = '0' + i;
+		memcgs[i] = cg_name(memcgs[0] ? : root, name);
+		if (!memcgs[i])
+			goto cleanup;
+		if (cg_create(memcgs[i]))
+			goto cleanup;
+	}
+
+	if (cg_write(memcgs[0], "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	for (i = 0; i < memcgs_count; ++i) {
+		if (cg_write(memcgs[i], "memory.max", low1)) {
+			goto cleanup;
+		}
+		if (cg_write(memcgs[i], "memory.low", low1)) {
+			goto cleanup;
+		}
+	}
+
+	fd = get_temp_fd();
+	if (fd < 0)
+		goto cleanup;
+
+	if (cg_run(memcgs[1], alloc_pagecache_300M, (void*)(long)fd)) {
+		goto cleanup;
+	}
+	if (cg_run(memcgs[2], touch_pagecache, (void*)(long)fd)) {
+		goto cleanup;
+	}
+
+	if (cg_write(memcgs[2], "memory.max", low2))
+		goto cleanup;
+	if (cg_write(memcgs[2], "memory.low", low2))
+		goto cleanup;
+	if (cg_run(memcgs[2], touch_pagecache, (void*)(long)fd))
+		goto cleanup;
+
+	ret = 0;
+cleanup:
+	for (i = memcgs_count; i > 0; --i) {
+		if (memcgs[i - 1]) {
+			cg_destroy(memcgs[i - 1]);
+			free(memcgs[i - 1]);
+		}
+	}
+
+	if (fd >= 0)
+		close(fd);
+	return ret;
+}
+
 
 #define T(x) { x, #x }
 struct memcg_test {
@@ -1187,6 +1282,7 @@ struct memcg_test {
 	T(test_memcg_oom_group_leaf_events),
 	T(test_memcg_oom_group_parent_events),
 	T(test_memcg_oom_group_score_events),
+	T(test_memcg_stale_protection_oom),
 };
 #undef T
 
-- 
2.17.1

