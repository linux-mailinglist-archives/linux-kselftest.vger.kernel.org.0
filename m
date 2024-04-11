Return-Path: <linux-kselftest+bounces-7680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6239D8A09BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 09:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA0AEB28805
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 07:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF58D13E8A1;
	Thu, 11 Apr 2024 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2yq9Rak"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629B13E3EA
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820383; cv=none; b=hxPdFy4Lh6mv2H8PQ91VvZIS84wl676jEi3tNrlAyEjJM6ksrkwtKnrLh18FlHNvdGFtqiBG73qqO+EsrYmatMUKr0EhgC+VxoCJTUeDpFFu1gCnWIfhvr6nG8kyDRCKq28x2ZW0O8eEey+USjLzoSGMQtstpLlPr42n4Ifk41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820383; c=relaxed/simple;
	bh=u4Zt6ncn47IgJB14JDZFwjyqGxYcviEbMnt3l0dVYJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMWedbhnraGrBGlOsdhX9Q70gQXKwfJIvPjddm9uOnx/wCGcu876Ea+zCEupee8jjw/E/jPvGcQFHMBFTDsrE46gdM5L8G7SE7Ff1etv8tofDvPxYZwLQvQ5WEgC/8lzZTkFkPtHF6XsvM6UKNmPqb1ifC2z1n7dJa9Ur2rktpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2yq9Rak; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712820381; x=1744356381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u4Zt6ncn47IgJB14JDZFwjyqGxYcviEbMnt3l0dVYJg=;
  b=B2yq9RakZBhX/QBU9GCpqQ8ISnZfXqczB5YY7btJdZ9ss0GLDdjZAb+U
   gkz9LV+g+HdH3fIrH+CbT2FLsRj/K1sU782K2FaCoB3mQwwUdOGaZgz0O
   onCXP1bS7WCn70tmBJ+awNDDKzYF1oy2ItOLDa41vQQ7cOP3UQjmlfl19
   RB2LDGayLVUcMvkjmuV4VYsEpY2/6ScY2aSjN+pQtqZ+eLMFKalMcC9iy
   3P1n3ka4wQvFCaVvxl65Kef/UTU1sWQG1F5iY7Uu8iKwnNkGeM7NuNULY
   e8/o4GoISbqSK8Ruol01c1WJ5xF/WGo8rBfl/GdMwBEzZLeRqOj0CzwVd
   w==;
X-CSE-ConnectionGUID: 8EhH22QcRyKS6wQBOEFHWA==
X-CSE-MsgGUID: H1JtXnHWTh6F4gc/op+RSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8074400"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8074400"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 00:26:04 -0700
X-CSE-ConnectionGUID: lJ3/DrzzRJORhGhCD+Jd/A==
X-CSE-MsgGUID: PvvaWwV2Qnyx++zeZKMVHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20848555"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 00:26:04 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Hugh Dickins <hughd@google.com>,
	Peter Xu <peterx@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	linux-kselftest@vger.kernel.org,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v14 8/8] selftests/udmabuf: Add tests to verify data after page migration
Date: Wed, 10 Apr 2024 23:59:44 -0700
Message-ID: <20240411070157.3318425-9-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411070157.3318425-1-vivek.kasireddy@intel.com>
References: <20240411070157.3318425-1-vivek.kasireddy@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the memfd pages associated with a udmabuf may be migrated
as part of udmabuf create, we need to verify the data coherency
after successful migration. The new tests added in this patch try
to do just that using 4k sized pages and also 2 MB sized huge
pages for the memfd.

Successful completion of the tests would mean that there is no
disconnect between the memfd pages and the ones associated with
a udmabuf. And, these tests can also be augmented in the future
to test newer udmabuf features (such as handling memfd hole punch).

The idea for these tests comes from a patch by Mike Kravetz here:
https://lists.freedesktop.org/archives/dri-devel/2023-June/410623.html

v1->v2: (suggestions from Shuah)
- Use ksft_* functions to print and capture results of tests
- Use appropriate KSFT_* status codes for exit()
- Add Mike Kravetz's suggested-by tag

Cc: Shuah Khan <shuah@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hugh Dickins <hughd@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Junxiao Chang <junxiao.chang@intel.com>
Cc: linux-kselftest@vger.kernel.org
Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 .../selftests/drivers/dma-buf/udmabuf.c       | 214 +++++++++++++++---
 1 file changed, 183 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index c812080e304e..6062723a172e 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -9,52 +9,162 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <malloc.h>
+#include <stdbool.h>
 
 #include <sys/ioctl.h>
 #include <sys/syscall.h>
+#include <sys/mman.h>
 #include <linux/memfd.h>
 #include <linux/udmabuf.h>
+#include "../../kselftest.h"
 
 #define TEST_PREFIX	"drivers/dma-buf/udmabuf"
 #define NUM_PAGES       4
+#define NUM_ENTRIES     4
+#define MEMFD_SIZE      1024 /* in pages */
 
-static int memfd_create(const char *name, unsigned int flags)
+static unsigned int page_size;
+
+static int create_memfd_with_seals(off64_t size, bool hpage)
+{
+	int memfd, ret;
+	unsigned int flags = MFD_ALLOW_SEALING;
+
+	if (hpage)
+		flags |= MFD_HUGETLB;
+
+	memfd = memfd_create("udmabuf-test", flags);
+	if (memfd < 0) {
+		ksft_print_msg("%s: [skip,no-memfd]\n", TEST_PREFIX);
+		exit(KSFT_SKIP);
+	}
+
+	ret = fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK);
+	if (ret < 0) {
+		ksft_print_msg("%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
+		exit(KSFT_SKIP);
+	}
+
+	ret = ftruncate(memfd, size);
+	if (ret == -1) {
+		ksft_print_msg("%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
+		exit(KSFT_FAIL);
+	}
+
+	return memfd;
+}
+
+static int create_udmabuf_list(int devfd, int memfd, off64_t memfd_size)
+{
+	struct udmabuf_create_list *list;
+	int ubuf_fd, i;
+
+	list = malloc(sizeof(struct udmabuf_create_list) +
+		      sizeof(struct udmabuf_create_item) * NUM_ENTRIES);
+	if (!list) {
+		ksft_print_msg("%s: [FAIL, udmabuf-malloc]\n", TEST_PREFIX);
+		exit(KSFT_FAIL);
+	}
+
+	for (i = 0; i < NUM_ENTRIES; i++) {
+		list->list[i].memfd  = memfd;
+		list->list[i].offset = i * (memfd_size / NUM_ENTRIES);
+		list->list[i].size   = getpagesize() * NUM_PAGES;
+	}
+
+	list->count = NUM_ENTRIES;
+	list->flags = UDMABUF_FLAGS_CLOEXEC;
+	ubuf_fd = ioctl(devfd, UDMABUF_CREATE_LIST, list);
+	free(list);
+	if (ubuf_fd < 0) {
+		ksft_print_msg("%s: [FAIL, udmabuf-create]\n", TEST_PREFIX);
+		exit(KSFT_FAIL);
+	}
+
+	return ubuf_fd;
+}
+
+static void write_to_memfd(void *addr, off64_t size, char chr)
+{
+	int i;
+
+	for (i = 0; i < size / page_size; i++) {
+		*((char *)addr + (i * page_size)) = chr;
+	}
+}
+
+static void *mmap_fd(int fd, off64_t size)
 {
-	return syscall(__NR_memfd_create, name, flags);
+	void *addr;
+
+	addr = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED) {
+		ksft_print_msg("%s: ubuf_fd mmap fail\n", TEST_PREFIX);
+		exit(KSFT_FAIL);
+	}
+
+	return addr;
+}
+
+static int compare_chunks(void *addr1, void *addr2, off64_t memfd_size)
+{
+	off64_t off;
+	int i = 0, j, k = 0, ret = 0;
+	char char1, char2;
+
+	while (i < NUM_ENTRIES) {
+		off = i * (memfd_size / NUM_ENTRIES);
+		for (j = 0; j < NUM_PAGES; j++, k++) {
+			char1 = *((char *)addr1 + off + (j * getpagesize()));
+			char2 = *((char *)addr2 + (k * getpagesize()));
+			if (char1 != char2) {
+				ret = -1;
+				goto err;
+			}
+		}
+		i++;
+	}
+err:
+	munmap(addr1, memfd_size);
+	munmap(addr2, NUM_ENTRIES * NUM_PAGES * getpagesize());
+	return ret;
 }
 
 int main(int argc, char *argv[])
 {
 	struct udmabuf_create create;
 	int devfd, memfd, buf, ret;
-	off_t size;
-	void *mem;
+	off64_t size;
+	void *addr1, *addr2;
+
+	ksft_print_header();
+	ksft_set_plan(6);
 
 	devfd = open("/dev/udmabuf", O_RDWR);
 	if (devfd < 0) {
-		printf("%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
-		       TEST_PREFIX);
-		exit(77);
+		ksft_print_msg(
+			"%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
+			TEST_PREFIX);
+		exit(KSFT_SKIP);
 	}
 
 	memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
 	if (memfd < 0) {
-		printf("%s: [skip,no-memfd]\n", TEST_PREFIX);
-		exit(77);
+		ksft_print_msg("%s: [skip,no-memfd]\n", TEST_PREFIX);
+		exit(KSFT_SKIP);
 	}
 
 	ret = fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK);
 	if (ret < 0) {
-		printf("%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
-		exit(77);
+		ksft_print_msg("%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
+		exit(KSFT_SKIP);
 	}
 
-
 	size = getpagesize() * NUM_PAGES;
 	ret = ftruncate(memfd, size);
 	if (ret == -1) {
-		printf("%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
-		exit(1);
+		ksft_print_msg("%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
+		exit(KSFT_FAIL);
 	}
 
 	memset(&create, 0, sizeof(create));
@@ -64,44 +174,86 @@ int main(int argc, char *argv[])
 	create.offset = getpagesize()/2;
 	create.size   = getpagesize();
 	buf = ioctl(devfd, UDMABUF_CREATE, &create);
-	if (buf >= 0) {
-		printf("%s: [FAIL,test-1]\n", TEST_PREFIX);
-		exit(1);
-	}
+	if (buf >= 0)
+		ksft_test_result_fail("%s: [FAIL,test-1]\n", TEST_PREFIX);
+	else
+		ksft_test_result_pass("%s: [PASS,test-1]\n", TEST_PREFIX);
 
 	/* should fail (size not multiple of page) */
 	create.memfd  = memfd;
 	create.offset = 0;
 	create.size   = getpagesize()/2;
 	buf = ioctl(devfd, UDMABUF_CREATE, &create);
-	if (buf >= 0) {
-		printf("%s: [FAIL,test-2]\n", TEST_PREFIX);
-		exit(1);
-	}
+	if (buf >= 0)
+		ksft_test_result_fail("%s: [FAIL,test-2]\n", TEST_PREFIX);
+	else
+		ksft_test_result_pass("%s: [PASS,test-2]\n", TEST_PREFIX);
 
 	/* should fail (not memfd) */
 	create.memfd  = 0; /* stdin */
 	create.offset = 0;
 	create.size   = size;
 	buf = ioctl(devfd, UDMABUF_CREATE, &create);
-	if (buf >= 0) {
-		printf("%s: [FAIL,test-3]\n", TEST_PREFIX);
-		exit(1);
-	}
+	if (buf >= 0)
+		ksft_test_result_fail("%s: [FAIL,test-3]\n", TEST_PREFIX);
+	else
+		ksft_test_result_pass("%s: [PASS,test-3]\n", TEST_PREFIX);
 
 	/* should work */
+	page_size = getpagesize();
+	addr1 = mmap_fd(memfd, size);
+	write_to_memfd(addr1, size, 'a');
 	create.memfd  = memfd;
 	create.offset = 0;
 	create.size   = size;
 	buf = ioctl(devfd, UDMABUF_CREATE, &create);
-	if (buf < 0) {
-		printf("%s: [FAIL,test-4]\n", TEST_PREFIX);
-		exit(1);
-	}
+	if (buf < 0)
+		ksft_test_result_fail("%s: [FAIL,test-4]\n", TEST_PREFIX);
+	else
+		ksft_test_result_pass("%s: [PASS,test-4]\n", TEST_PREFIX);
+
+	munmap(addr1, size);
+	close(buf);
+	close(memfd);
+
+	/* should work (migration of 4k size pages)*/
+	size = MEMFD_SIZE * page_size;
+	memfd = create_memfd_with_seals(size, false);
+	addr1 = mmap_fd(memfd, size);
+	write_to_memfd(addr1, size, 'a');
+	buf = create_udmabuf_list(devfd, memfd, size);
+	addr2 = mmap_fd(buf, NUM_PAGES * NUM_ENTRIES * getpagesize());
+	write_to_memfd(addr1, size, 'b');
+	ret = compare_chunks(addr1, addr2, size);
+	if (ret < 0)
+		ksft_test_result_fail("%s: [FAIL,test-5]\n", TEST_PREFIX);
+	else
+		ksft_test_result_pass("%s: [PASS,test-5]\n", TEST_PREFIX);
+
+	close(buf);
+	close(memfd);
+
+	/* should work (migration of 2MB size huge pages)*/
+	page_size = getpagesize() * 512; /* 2 MB */
+	size = MEMFD_SIZE * page_size;
+	memfd = create_memfd_with_seals(size, true);
+	addr1 = mmap_fd(memfd, size);
+	write_to_memfd(addr1, size, 'a');
+	buf = create_udmabuf_list(devfd, memfd, size);
+	addr2 = mmap_fd(buf, NUM_PAGES * NUM_ENTRIES * getpagesize());
+	write_to_memfd(addr1, size, 'b');
+	ret = compare_chunks(addr1, addr2, size);
+	if (ret < 0)
+		ksft_test_result_fail("%s: [FAIL,test-6]\n", TEST_PREFIX);
+	else
+		ksft_test_result_pass("%s: [PASS,test-6]\n", TEST_PREFIX);
 
-	fprintf(stderr, "%s: ok\n", TEST_PREFIX);
 	close(buf);
 	close(memfd);
 	close(devfd);
+
+	ksft_print_msg("%s: ok\n", TEST_PREFIX);
+	ksft_print_cnts();
+
 	return 0;
 }
-- 
2.43.0


