Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C46070BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 09:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJUHOa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJUHO3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 03:14:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C726627B;
        Fri, 21 Oct 2022 00:14:23 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MtwZQ6P4Lz15Lx3;
        Fri, 21 Oct 2022 15:09:34 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 15:14:20 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <keescook@chromium.org>, <luto@amacapital.net>, <wad@chromium.org>,
        <shuah@kernel.org>, <zhaogongyi@huawei.com>,
        <cristian.marussi@arm.com>
Subject: [PATCH -next 1/2] selftests/mincore: Add checking of block dev for TEST(check_file_mmap)
Date:   Fri, 21 Oct 2022 15:10:51 +0800
Message-ID: <20221021071052.143393-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

TEST(check_file_mmap) will fail when we run the test on tmpfs and report:
  mincore_selftest.c:261:check_file_mmap:Expected ra_pages (0) > 0 (0)
  mincore_selftest.c:262:check_file_mmap:No read-ahead pages found in memory

For some embaded system, maybe there is only tmpfs file system exist,
run the test will fail, or we install the test on a filesystem that
has no backend, also it will fail as unepected.

So add a checking of block dev for the filesystem at first.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../selftests/mincore/mincore_selftest.c      | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index 4c88238fc8f0..287351a599a2 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -14,6 +14,9 @@
 #include <sys/mman.h>
 #include <string.h>
 #include <fcntl.h>
+#include <mntent.h>
+#include <sys/stat.h>
+#include <linux/fs.h>

 #include "../kselftest.h"
 #include "../kselftest_harness.h"
@@ -173,6 +176,43 @@ TEST(check_huge_pages)
 	munmap(addr, page_size);
 }

+static struct mntent* find_mount_point(const char *name)
+{
+	struct stat s;
+	FILE *mtab_fp;
+	struct mntent *mountEntry;
+	dev_t devno_of_name;
+
+	if (stat(name, &s) != 0)
+		return NULL;
+
+	devno_of_name = s.st_dev;
+
+	mtab_fp = setmntent("/proc/mounts", "r");
+	if (!mtab_fp)
+		return NULL;
+
+	while ((mountEntry = getmntent(mtab_fp)) != NULL) {
+		if (strcmp(name, mountEntry->mnt_dir) == 0
+			|| strcmp(name, mountEntry->mnt_fsname) == 0) {
+			break;
+		}
+
+		if (mountEntry->mnt_fsname[0] == '/'
+			&& stat(mountEntry->mnt_fsname, &s) == 0
+			&& s.st_rdev == devno_of_name) {
+			break;
+		}
+
+		if (stat(mountEntry->mnt_dir, &s) == 0
+				&& s.st_dev == devno_of_name) {
+			break;
+		}
+	}
+	endmntent(mtab_fp);
+
+	return mountEntry;
+}

 /*
  * Test mincore() behavior on a file-backed page.
@@ -194,6 +234,19 @@ TEST(check_file_mmap)
 	int fd;
 	int i;
 	int ra_pages = 0;
+	struct stat s;
+	struct mntent *mount_entry;
+
+	mount_entry = find_mount_point(".");
+	ASSERT_NE(NULL, mount_entry) {
+		TH_LOG("Find mount point of '.' failed");
+	}
+
+	ASSERT_EQ(0, (stat(mount_entry->mnt_fsname, &s) != 0
+		|| !S_ISBLK(s.st_mode))) {
+		TH_LOG("There is no a block dev on mount point, "
+			"test is not supported");
+	}

 	page_size = sysconf(_SC_PAGESIZE);
 	vec_size = FILE_SIZE / page_size;
--
2.17.1

