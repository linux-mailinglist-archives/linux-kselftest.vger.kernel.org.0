Return-Path: <linux-kselftest+bounces-12546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F327291431C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 09:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA831F23D8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 07:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C12381A4;
	Mon, 24 Jun 2024 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJyJa5MV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20AE376
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719212728; cv=none; b=QZ98Z2vq7IR6OZ4F1y3U/GF0DLCPtJLdGExuQWxXaW7VUCTh9U2tEGzjZ2k8ywjCzR6I0MX8/XHHwAYw5OsPjG7QsutI/mE5Yb+7gn2qaEijBXLKhS/pVVhdKVGR56JNLUHO52Rm/j3v9R/pfi8xKPLhawm5/PXIIjJ60m85OcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719212728; c=relaxed/simple;
	bh=mwX/Ut3liG+2eL4EiqMYYCOWpRlKdeioXbS3wyxFBs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsc8L+J4u1Zr0a+d1/XWBsGqTREXHUlaqkDCEZztWUS067bfWZu+C8Wh0ix9yxh5J+xI4a2Q88Ike050ogKfYrlLdSPzCnyxzNo5koeNvwgz3Ltd1EIQsKBBy2mflOXr6ytalbVGj/uH93OIfexdvPUVQL+ZRHuHf7rsuzM5e6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJyJa5MV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719212727; x=1750748727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mwX/Ut3liG+2eL4EiqMYYCOWpRlKdeioXbS3wyxFBs0=;
  b=VJyJa5MVnpZhsu29nt2ND2g5LH2RcIKnTlPTynBimVIpqsFr926XQene
   PRCGAdPhziR5brGblQKzab4+EMnmA86ZSVVty/21UPgOOMVtKAJ6lTV9y
   FSo2wr4NckuGuVAM4sYEyC7bCCm5SlciIFzfsIjHq7qGwnLFsbWo2QLO5
   nmkpGPW2PXENc3tElnL4WjPW3M1rHB5fLNBAVQTuP7Vta2tEzrMvY3YvR
   NLYAkMdMtYDjxf31WhXIe0KGd1vwGb+DCsGd++SFBGpztRnqAHPnc23eP
   JYYOI22kS3wJ6LXXmw/ZVtBEiQDg/kh+gVoTTtyr+IvRehea6l0NHeY4z
   w==;
X-CSE-ConnectionGUID: fRWpua8JT+SBhHX+EXNmNg==
X-CSE-MsgGUID: yNN8yzZyQsWJ0PECA25jgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16134994"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="16134994"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 00:05:27 -0700
X-CSE-ConnectionGUID: r8OaYolhSbGcZ+TgCa9tdA==
X-CSE-MsgGUID: WyAqrCRFRzW+3jfsoMu6/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="73955893"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 00:05:26 -0700
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
	Mike Kravetz <mike.kravetz@oracle.com>,
	Dave Airlie <airlied@redhat.com>
Subject: [PATCH v16 9/9] selftests/udmabuf: Add tests to verify data after page migration
Date: Sun, 23 Jun 2024 23:36:17 -0700
Message-ID: <20240624063952.1572359-10-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624063952.1572359-1-vivek.kasireddy@intel.com>
References: <20240624063952.1572359-1-vivek.kasireddy@intel.com>
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
Acked-by: Dave Airlie <airlied@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
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
2.45.1


