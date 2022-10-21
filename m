Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD8B6070C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 09:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJUHOb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 03:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJUHOa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 03:14:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C952465D5;
        Fri, 21 Oct 2022 00:14:24 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtwZb1YNrzVj2r;
        Fri, 21 Oct 2022 15:09:43 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 15:14:22 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <keescook@chromium.org>, <luto@amacapital.net>, <wad@chromium.org>,
        <shuah@kernel.org>, <zhaogongyi@huawei.com>,
        <cristian.marussi@arm.com>
Subject: [PATCH -next 2/2] selftests/mincore: Optimize TEST(check_file_mmap) accoring to filemap read around
Date:   Fri, 21 Oct 2022 15:10:52 +0800
Message-ID: <20221021071052.143393-2-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221021071052.143393-1-zhaogongyi@huawei.com>
References: <20221021071052.143393-1-zhaogongyi@huawei.com>
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

TEST(check_file_mmap) will fail when we set the ra_pages through
blockdev like:
  /sbin/blockdev --setra 8196 /dev/sda

And, for file mmap, kernel will read 'ra_pages/2' pages of the address
on the left hand or right hand. So, add a checking of ra_pages according
to the ra_pages setting of the block dev.

I have tested it on my system like:
  i=0
  while [ $i -lt 9000 ]
  do
        /sbin/blockdev --setra $i /dev/openeuler/*
        ./mincore_selftest  || { echo "$i test failed"; exit 1; }
        let i=$i+1
  done

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 tools/testing/selftests/kselftest_harness.h   |  2 +
 .../selftests/mincore/mincore_selftest.c      | 74 +++++++++++++++----
 2 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 25f4d54067c0..fa40c85a1099 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -781,6 +781,8 @@
 	} \
 }

+#define MIN(a, b)       ((a) < (b) ? (a) : (b))
+
 struct __test_results {
 	char reason[1024];	/* Reason for test result */
 };
diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index 287351a599a2..5eace1750fef 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -17,6 +17,7 @@
 #include <mntent.h>
 #include <sys/stat.h>
 #include <linux/fs.h>
+#include <sys/ioctl.h>

 #include "../kselftest.h"
 #include "../kselftest_harness.h"
@@ -218,11 +219,7 @@ static struct mntent* find_mount_point(const char *name)
  * Test mincore() behavior on a file-backed page.
  * No pages should be loaded into memory right after the mapping. Then,
  * accessing any address in the mapping range should load the page
- * containing the address and a number of subsequent pages (readahead).
- *
- * The actual readahead settings depend on the test environment, so we
- * can't make a lot of assumptions about that. This test covers the most
- * general cases.
+ * containing the address and a number of around pages (read around).
  */
 TEST(check_file_mmap)
 {
@@ -236,6 +233,10 @@ TEST(check_file_mmap)
 	int ra_pages = 0;
 	struct stat s;
 	struct mntent *mount_entry;
+	int ra_size;
+	int exp_ra_pages;
+	int odd = 0;
+	int dev_ra_pages;

 	mount_entry = find_mount_point(".");
 	ASSERT_NE(NULL, mount_entry) {
@@ -248,11 +249,29 @@ TEST(check_file_mmap)
 			"test is not supported");
 	}

+	errno = 0;
+	fd = open(mount_entry->mnt_fsname, O_RDONLY);
+	ASSERT_LT(0, fd) {
+		TH_LOG("Open %s failed: %s",
+			mount_entry->mnt_fsname, strerror(errno));
+	}
+
+	errno = 0;
+	retval = ioctl(fd, BLKRAGET, &ra_size);
+	ASSERT_EQ(0, retval) {
+		TH_LOG("Get block readahead size failed: %s", strerror(errno));
+	}
+
 	page_size = sysconf(_SC_PAGESIZE);
 	vec_size = FILE_SIZE / page_size;
 	if (FILE_SIZE % page_size)
 		vec_size++;

+	dev_ra_pages = (ra_size * 512) / page_size;
+	exp_ra_pages = MIN(vec_size / 2, dev_ra_pages / 2);
+	if (dev_ra_pages <= vec_size)
+		odd = dev_ra_pages % 2;
+
 	vec = calloc(vec_size, sizeof(unsigned char));
 	ASSERT_NE(NULL, vec) {
 		TH_LOG("Can't allocate array");
@@ -296,7 +315,7 @@ TEST(check_file_mmap)

 	/*
 	 * Touch a page in the middle of the mapping. We expect the next
-	 * few pages (the readahead window) to be populated too.
+	 * few pages (the read around window) to be populated too.
 	 */
 	addr[FILE_SIZE / 2] = 1;
 	retval = mincore(addr, FILE_SIZE, vec);
@@ -310,22 +329,49 @@ TEST(check_file_mmap)
 		ra_pages++;
 		i++;
 	}
-	EXPECT_GT(ra_pages, 0) {
-		TH_LOG("No read-ahead pages found in memory");
-	}

-	EXPECT_LT(i, vec_size) {
-		TH_LOG("Read-ahead pages reached the end of the file");
+	if (!exp_ra_pages) {
+		EXPECT_EQ(ra_pages, exp_ra_pages) {
+			TH_LOG("Check read-around pages failed");
+		}
+	} else {
+		EXPECT_EQ(ra_pages + (odd ? 0 : 1), exp_ra_pages) {
+			TH_LOG("Check read-around pages failed");
+		}
 	}
+
 	/*
-	 * End of the readahead window. The rest of the pages shouldn't
-	 * be in memory.
+	 * End of the read around window. The rest of the pages shouldn't
+	 * be in memory for the right hand.
 	 */
 	if (i < vec_size) {
 		while (i < vec_size && !vec[i])
 			i++;
 		EXPECT_EQ(vec_size, i) {
-			TH_LOG("Unexpected page in memory beyond readahead window");
+			TH_LOG("Unexpected page in memory beyond read around window");
+		}
+	}
+
+	i = FILE_SIZE / 2 / page_size - 1;
+	ra_pages = 0;
+	while (i >= 0 && vec[i]) {
+		ra_pages++;
+		i--;
+	}
+
+	EXPECT_EQ(ra_pages, exp_ra_pages) {
+		TH_LOG("Check read-around pages failed");
+	}
+
+	/*
+	 * End of the read around window. The rest of the pages shouldn't
+	 * be in memory for the left hand.
+	 */
+	if (i >= 0) {
+		while (i >= 0 && !vec[i])
+			i--;
+		EXPECT_EQ(-1, i) {
+			TH_LOG("Unexpected page in memory beyond read around window");
 		}
 	}

--
2.17.1

