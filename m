Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C458363B1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Apr 2021 07:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhDSFr3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Apr 2021 01:47:29 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:54054 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230022AbhDSFr3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Apr 2021 01:47:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UW-Jzif_1618811217;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UW-Jzif_1618811217)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Apr 2021 13:46:58 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     ricardo.canuelo@collabora.com, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>
Subject: [PATCH v4] selftests/mincore: get readahead size for check_file_mmap()
Date:   Mon, 19 Apr 2021 13:46:55 +0800
Message-Id: <20210419054655.40140-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The readahead size used to be 2MB, thus it's reasonable to set the file
size as 4MB when checking check_file_mmap().

However since commit c2e4cd57cfa1 ("block: lift setting the readahead
size into the block layer"), readahead size could be as large as twice
the io_opt, and thus the hardcoded file size no longer works.
check_file_mmap() may report "Read-ahead pages reached the end of the
file" when the readahead size actually exceeds the file size in this
case.

To fix this issue, read the exact readahead window size via BLKRAGET
ioctl. Since now we have the readahead window size, take a more
fine-grained check. It is worth noting that this fine-grained check may
be broken as the sync readahead algorithm of kernel changes. It may be
acceptable since the algorithm of readahead ranging should be quite
stable, and we could tune the test case accorddingly if the algorithm
indeed changes.

Reported-by: James Wang <jnwang@linux.alibaba.com>
Acked-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
changes since v3:
- make the check more fine-grained since we have the exact readahead
  window size now, as suggested by Ricardo Cañuelo

chnages since v2:
- add 'Reported-by'

chnages since v1:
- add the test name "mincore" in the subject line
- add the error message in commit message
- rename @filesize to @file_size to keep a more consistent naming
  convention
---
 .../selftests/mincore/mincore_selftest.c      | 96 +++++++++++++------
 1 file changed, 68 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index 5a1e85ff5d32..369b35af4b4f 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -15,6 +15,11 @@
 #include <string.h>
 #include <fcntl.h>
 #include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <sys/sysmacros.h>
+#include <sys/mount.h>
 
 #include "../kselftest.h"
 #include "../kselftest_harness.h"
@@ -193,12 +198,44 @@ TEST(check_file_mmap)
 	int retval;
 	int page_size;
 	int fd;
-	int i;
+	int i, start, end;
 	int ra_pages = 0;
+	long ra_size, file_size;
+	struct stat stats;
+	dev_t devt;
+	unsigned int major, minor;
+	char devpath[32];
+
+	retval = stat(".", &stats);
+	ASSERT_EQ(0, retval) {
+		TH_LOG("Can't stat pwd: %s", strerror(errno));
+	}
+
+	devt = stats.st_dev;
+	major = major(devt);
+	minor = minor(devt);
+	snprintf(devpath, sizeof(devpath), "/dev/block/%u:%u", major, minor);
+
+	fd = open(devpath, O_RDONLY);
+	ASSERT_NE(-1, fd) {
+		TH_LOG("Can't open underlying disk %s", strerror(errno));
+	}
+
+	retval = ioctl(fd, BLKRAGET, &ra_size);
+	ASSERT_EQ(0, retval) {
+		TH_LOG("Error ioctl with the underlying disk: %s", strerror(errno));
+	}
+
+	/*
+	 * BLKRAGET ioctl returns the readahead size in sectors (512 bytes).
+	 * Make file_size large enough to contain the readahead window.
+	 */
+	ra_size *= 512;
+	file_size = ra_size * 2;
 
 	page_size = sysconf(_SC_PAGESIZE);
-	vec_size = FILE_SIZE / page_size;
-	if (FILE_SIZE % page_size)
+	vec_size = file_size / page_size;
+	if (file_size % page_size)
 		vec_size++;
 
 	vec = calloc(vec_size, sizeof(unsigned char));
@@ -213,7 +250,7 @@ TEST(check_file_mmap)
 			strerror(errno));
 	}
 	errno = 0;
-	retval = fallocate(fd, 0, 0, FILE_SIZE);
+	retval = fallocate(fd, 0, 0, file_size);
 	ASSERT_EQ(0, retval) {
 		TH_LOG("Error allocating space for the temporary file: %s",
 			strerror(errno));
@@ -223,12 +260,12 @@ TEST(check_file_mmap)
 	 * Map the whole file, the pages shouldn't be fetched yet.
 	 */
 	errno = 0;
-	addr = mmap(NULL, FILE_SIZE, PROT_READ | PROT_WRITE,
+	addr = mmap(NULL, file_size, PROT_READ | PROT_WRITE,
 			MAP_SHARED, fd, 0);
 	ASSERT_NE(MAP_FAILED, addr) {
 		TH_LOG("mmap error: %s", strerror(errno));
 	}
-	retval = mincore(addr, FILE_SIZE, vec);
+	retval = mincore(addr, file_size, vec);
 	ASSERT_EQ(0, retval);
 	for (i = 0; i < vec_size; i++) {
 		ASSERT_EQ(0, vec[i]) {
@@ -240,38 +277,41 @@ TEST(check_file_mmap)
 	 * Touch a page in the middle of the mapping. We expect the next
 	 * few pages (the readahead window) to be populated too.
 	 */
-	addr[FILE_SIZE / 2] = 1;
-	retval = mincore(addr, FILE_SIZE, vec);
+	addr[file_size / 2] = 1;
+	retval = mincore(addr, file_size, vec);
 	ASSERT_EQ(0, retval);
-	ASSERT_EQ(1, vec[FILE_SIZE / 2 / page_size]) {
-		TH_LOG("Page not found in memory after use");
-	}
 
-	i = FILE_SIZE / 2 / page_size + 1;
-	while (i < vec_size && vec[i]) {
-		ra_pages++;
-		i++;
-	}
-	EXPECT_GT(ra_pages, 0) {
-		TH_LOG("No read-ahead pages found in memory");
-	}
+	/*
+	 * Readahead window is [start, end). So far the sync readahead
+	 * algorithm takes the page that triggers the page fault as the
+	 * midpoint.
+	 */
+	ra_pages = ra_size / page_size;
+	start = file_size / 2 / page_size - ra_pages / 2;
+	end = start + ra_pages;
 
-	EXPECT_LT(i, vec_size) {
-		TH_LOG("Read-ahead pages reached the end of the file");
+	/*
+	 * Check there's no hole in the readahead window.
+	 */
+	for (i = start; i < end; i++) {
+		ASSERT_EQ(1, vec[i]) {
+			TH_LOG("Hole found in read-ahead window");
+		}
 	}
+
 	/*
-	 * End of the readahead window. The rest of the pages shouldn't
-	 * be in memory.
+	 * Check there's no page beyond the readahead window.
 	 */
-	if (i < vec_size) {
-		while (i < vec_size && !vec[i])
-			i++;
-		EXPECT_EQ(vec_size, i) {
+	for (i = 0; i < vec_size; i++) {
+		if (i == start)
+			i = end;
+
+		EXPECT_EQ(0, vec[i]) {
 			TH_LOG("Unexpected page in memory beyond readahead window");
 		}
 	}
 
-	munmap(addr, FILE_SIZE);
+	munmap(addr, file_size);
 	close(fd);
 	free(vec);
 }
-- 
2.27.0

