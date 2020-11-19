Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339392B975D
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 17:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgKSQGo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 11:06:44 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:39295 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727990AbgKSQGk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 11:06:40 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id AE7AAF1C;
        Thu, 19 Nov 2020 11:06:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 19 Nov 2020 11:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=pFCt70MxzaEzv
        2lOS0NujyPfuPKcEbkEBkSMx2TXvm8=; b=eWpG8C0rUMP9kMFf2cQYzmxS1ksMO
        25b80bTMc7RIyHLAVP1JANvL9jx+iy5+BGte0P7XAJieDLTxiAKH7GMiZd3q3lBv
        g6jXM8ohkMHloNsnUxn1x6QsnHMA+0GTtgCjmPGidfQY2ZqLBQVeiF11TwrTYM88
        n849Ma58v6QalSdmAhASSOW6xwrcjAHoxydNRc75MxCADDwT+b8W3mIcw3Ekyz34
        wyD+NvTp9Njrn+XxbV88NDHHXuo4Zyf7qS5zR04EIRoaFEERNQd6f6u6A4Ef9iCl
        JK4zRGzLcXAy6xSTr9dO564Z/2M/4pXLle013HWXwSlwinjDGwwCbZepA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=pFCt70MxzaEzv2lOS0NujyPfuPKcEbkEBkSMx2TXvm8=; b=LUWPoVjV
        qx6lVoTmyH7gtpmYeYoYqQMGehVMfebDGQABXf/WHWX9Q7LdRdsKYjPU6tD34ikE
        0wiOcj84rTuixwmofGV4DMBMIvf0Nsy8GhEiCh/p2Nq7i8JZ1G24kAoMQHGMAHJz
        oOjIagRMkARl46k5TKWbYzlz7mCAXX+N85Bz/HSNTzdt0GDeKE3WgD/QlCVUosvW
        Tzi2yrcNgWwz0x0LD3rkYsqM5r1qYHcgee5niKGr928CqOBMeKb+j43rhCzlvWa7
        v1mWmieG9gzq2sqPQoPUbNSBK9pcmYDhcAuiXdNYjgYCmDkWzQW7Qgya2kh08Rpu
        SyozUI/fasj4OA==
X-ME-Sender: <xms:DZi2X4bomsxk6flrI8fk9MddJeaesaXa1iUK-T5nTog37dFf7LbfDQ>
    <xme:DZi2XzaBWyIwyvkjsfbpedCT_mj83usaYN26U560lkq41GAE0IrV6YV2YllXiv76Q
    -3YpwL7ConPV400rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedu
    vddrgeeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:Dpi2Xy_gNMCbXauSevF0HFnyKKBbCpB8pvuVurrxE3oglIYXDXdV5A>
    <xmx:Dpi2XyoaJQojbB5e9LniI2EwgF2ZsmfVGcTbN-xILvpQjVPvwff6tg>
    <xmx:Dpi2XzqkSW6l-VXLb9KiR38QDXmA3bfl59AJB6oiikpfoEYo9JTD_Q>
    <xmx:Dpi2Xwi5qU7UWIycIUjDatH6jvp3DGvfRpoGecs2CCHGsJ2z3-nTuAG53rs>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8C2633064ABC;
        Thu, 19 Nov 2020 11:06:37 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH 7/7] mm: huge_memory: enable debugfs to split huge pages to any order.
Date:   Thu, 19 Nov 2020 11:06:05 -0500
Message-Id: <20201119160605.1272425-8-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119160605.1272425-1-zi.yan@sent.com>
References: <20201119160605.1272425-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

It is used to test split_huge_page_to_list_to_order for pagecache THPs.
Also add test cases for split_huge_page_to_list_to_order via both
debugfs, truncating a file, and punching holes in a file.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c                              |  13 +-
 .../selftests/vm/split_huge_page_test.c       | 192 ++++++++++++++++--
 2 files changed, 186 insertions(+), 19 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cc70f70862d8..d6ce7be65fb2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2999,7 +2999,7 @@ static ssize_t split_huge_pages_in_range_pid_write(st=
ruct file *file,
 	static DEFINE_MUTEX(mutex);
 	ssize_t ret;
 	char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
-	int pid;
+	int pid, to_order =3D 0;
 	unsigned long vaddr_start, vaddr_end, addr;
 	nodemask_t task_nodes;
 	struct mm_struct *mm;
@@ -3016,8 +3016,9 @@ static ssize_t split_huge_pages_in_range_pid_write(st=
ruct file *file,
 		goto out;
=20
 	input_buf[79] =3D '\0';
-	ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &vaddr_en=
d);
-	if (ret !=3D 3) {
+	ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx,%d", &pid, &vaddr_start, &vaddr=
_end, &to_order);
+	/* cannot split to order-1 THP, which is not possible */
+	if ((ret !=3D 3 && ret !=3D 4) || to_order =3D=3D 1) {
 		ret =3D -EINVAL;
 		goto out;
 	}
@@ -3025,8 +3026,8 @@ static ssize_t split_huge_pages_in_range_pid_write(st=
ruct file *file,
 	vaddr_end &=3D PAGE_MASK;
=20
 	ret =3D strlen(input_buf);
-	pr_debug("split huge pages in pid: %d, vaddr: [%lx - %lx]\n",
-		 pid, vaddr_start, vaddr_end);
+	pr_debug("split huge pages in pid: %d, vaddr: [%lx - %lx], to order: %d\n=
",
+		 pid, vaddr_start, vaddr_end, to_order);
=20
 	mm =3D find_mm_struct(pid, &task_nodes);
 	if (IS_ERR(mm)) {
@@ -3066,7 +3067,7 @@ static ssize_t split_huge_pages_in_range_pid_write(st=
ruct file *file,
 		if (!trylock_page(page))
 			continue;
=20
-		if (!split_huge_page(page))
+		if (!split_huge_page_to_list_to_order(page, NULL, to_order))
 			split++;
=20
 		unlock_page(page);
diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/test=
ing/selftests/vm/split_huge_page_test.c
index cd2ced8c1261..bfd35ae9cfd2 100644
--- a/tools/testing/selftests/vm/split_huge_page_test.c
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -16,6 +16,7 @@
 #include <sys/wait.h>
 #include <malloc.h>
 #include <stdbool.h>
+#include <time.h>
=20
 uint64_t pagesize;
 unsigned int pageshift;
@@ -24,6 +25,7 @@ uint64_t pmd_pagesize;
 #define PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages_in_range_pid"
 #define SMAP_PATH "/proc/self/smaps"
+#define THP_FS_PATH "/mnt/thp_fs"
 #define INPUT_MAX 80
=20
 #define PFN_MASK     ((1UL<<55)-1)
@@ -89,19 +91,20 @@ static int write_file(const char *path, const char *buf=
, size_t buflen)
 	return (unsigned int) numwritten;
 }
=20
-static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t vaddr_en=
d)
+static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t vaddr_en=
d, int order)
 {
 	char input[INPUT_MAX];
 	int ret;
=20
-	ret =3D snprintf(input, INPUT_MAX, "%d,0x%lx,0x%lx", pid, vaddr_start,
-			vaddr_end);
+	ret =3D snprintf(input, INPUT_MAX, "%d,0x%lx,0x%lx,%d", pid, vaddr_start,
+			vaddr_end, order);
 	if (ret >=3D INPUT_MAX) {
 		printf("%s: Debugfs input is too long\n", __func__);
 		exit(EXIT_FAILURE);
 	}
=20
-	if (!write_file(SPLIT_DEBUGFS, input, ret + 1)) {
+	/* order =3D=3D 1 is an invalid input that should be detected. */
+	if (order !=3D 1 && !write_file(SPLIT_DEBUGFS, input, ret + 1)) {
 		perror(SPLIT_DEBUGFS);
 		exit(EXIT_FAILURE);
 	}
@@ -118,7 +121,7 @@ static bool check_for_pattern(FILE *fp, const char *pat=
tern, char *buf)
 	return false;
 }
=20
-static uint64_t check_huge(void *addr)
+static uint64_t check_huge(void *addr, const char *prefix)
 {
 	uint64_t thp =3D 0;
 	int ret;
@@ -143,13 +146,13 @@ static uint64_t check_huge(void *addr)
 		goto err_out;
=20
 	/*
-	 * Fetch the AnonHugePages: in the same block and check the number of
+	 * Fetch the @prefix in the same block and check the number of
 	 * hugepages.
 	 */
-	if (!check_for_pattern(fp, "AnonHugePages:", buffer))
+	if (!check_for_pattern(fp, prefix, buffer))
 		goto err_out;
=20
-	if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) !=3D 1) {
+	if (sscanf(&buffer[strlen(prefix)], "%10ld kB", &thp) !=3D 1) {
 		printf("Reading smap error\n");
 		exit(EXIT_FAILURE);
 	}
@@ -173,14 +176,14 @@ void split_pmd_thp(void)
 	for (i =3D 0; i < len; i++)
 		one_page[i] =3D (char)i;
=20
-	thp_size =3D check_huge(one_page);
+	thp_size =3D check_huge(one_page, "AnonHugePages:");
 	if (!thp_size) {
 		printf("No THP is allocatd");
 		exit(EXIT_FAILURE);
 	}
=20
 	/* split all possible huge pages */
-	write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page + len);
+	write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page + len, 0);
=20
 	for (i =3D 0; i < len; i++)
 		if (one_page[i] !=3D (char)i) {
@@ -189,7 +192,7 @@ void split_pmd_thp(void)
 		}
=20
=20
-	thp_size =3D check_huge(one_page);
+	thp_size =3D check_huge(one_page, "AnonHugePages:");
 	if (thp_size) {
 		printf("Still %ld kB AnonHugePages not split\n", thp_size);
 		exit(EXIT_FAILURE);
@@ -237,7 +240,7 @@ void split_pte_mapped_thp(void)
 	for (i =3D 0; i < len; i++)
 		one_page[i] =3D (char)i;
=20
-	thp_size =3D check_huge(one_page);
+	thp_size =3D check_huge(one_page, "AnonHugePages:");
 	if (!thp_size) {
 		printf("No THP is allocatd");
 		exit(EXIT_FAILURE);
@@ -270,7 +273,7 @@ void split_pte_mapped_thp(void)
=20
 	/* split all possible huge pages */
 	write_debugfs(getpid(), (uint64_t)pte_mapped,
-		      (uint64_t)pte_mapped + pagesize * 4);
+		      (uint64_t)pte_mapped + pagesize * 4, 0);
=20
 	/* smap does not show THPs after mremap, use kpageflags instead */
 	thp_size =3D 0;
@@ -295,19 +298,182 @@ void split_pte_mapped_thp(void)
 	close(kpageflags_fd);
 }
=20
+void create_pagecache_thp_and_fd(size_t fd_size, int *fd, char **addr)
+{
+	const char testfile[] =3D THP_FS_PATH "/test";
+	size_t i;
+	int dummy;
+
+	srand(time(NULL));
+
+	*fd =3D open(testfile, O_CREAT | O_RDWR, 0664);
+	if (*fd =3D=3D -1) {
+		perror("Failed to create a file at "THP_FS_PATH);
+		exit(EXIT_FAILURE);
+	}
+
+	for (i =3D 0; i < fd_size; i++) {
+		unsigned char byte =3D (unsigned char)i;
+
+		write(*fd, &byte, sizeof(byte));
+	}
+	close(*fd);
+	sync();
+	*fd =3D open("/proc/sys/vm/drop_caches", O_WRONLY);
+	if (*fd =3D=3D -1) {
+		perror("open drop_caches");
+		exit(EXIT_FAILURE);
+	}
+	if (write(*fd, "3", 1) !=3D 1) {
+		perror("write to drop_caches");
+		exit(EXIT_FAILURE);
+	}
+	close(*fd);
+
+	*fd =3D open(testfile, O_RDWR);
+	if (*fd =3D=3D -1) {
+		perror("Failed to open a file at "THP_FS_PATH);
+		exit(EXIT_FAILURE);
+	}
+
+	*addr =3D mmap(NULL, fd_size, PROT_READ|PROT_WRITE, MAP_SHARED, *fd, 0);
+	if (*addr =3D=3D (char *)-1) {
+		perror("cannot mmap");
+		exit(1);
+	}
+	madvise(*addr, fd_size, MADV_HUGEPAGE);
+
+	for (size_t i =3D 0; i < fd_size; i++)
+		dummy +=3D *(*addr + i);
+
+	if (!check_huge(*addr, "FilePmdMapped:")) {
+		printf("No pagecache THP generated, please mount a filesystem "
+		       "supporting pagecache THP at "THP_FS_PATH"\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
+void split_thp_in_pagecache_to_order(size_t fd_size, int order)
+{
+	int fd;
+	char *addr;
+	size_t i;
+
+	create_pagecache_thp_and_fd(fd_size, &fd, &addr);
+
+	printf("split %ld kB pagecache page to order %d ... ", fd_size >> 10, ord=
er);
+	write_debugfs(getpid(), (uint64_t)addr, (uint64_t)addr + fd_size, order);
+
+	for (i =3D 0; i < fd_size; i++)
+		if (*(addr + i) !=3D (char)i) {
+			printf("%lu byte corrupted in the file\n");
+			exit(EXIT_FAILURE);
+		}
+
+	close(fd);
+	printf("done\n");
+}
+
+void truncate_thp_in_pagecache_to_order(size_t fd_size, int order)
+{
+	int fd;
+	char *addr;
+	size_t i;
+
+	create_pagecache_thp_and_fd(fd_size, &fd, &addr);
+
+	printf("truncate %ld kB pagecache page to size %lu kB ... ", fd_size >> 1=
0, 4UL << order);
+	ftruncate(fd, pagesize << order);
+
+	for (i =3D 0; i < (pagesize << order); i++)
+		if (*(addr + i) !=3D (char)i) {
+			printf("%lu byte corrupted in the file\n");
+			exit(EXIT_FAILURE);
+		}
+
+	close(fd);
+	printf("done\n");
+}
+
+void punch_hole_in_pagecache_thp(size_t fd_size, off_t offset[], off_t len=
[], int n)
+{
+	int fd, j;
+	char *addr;
+	size_t i;
+
+	create_pagecache_thp_and_fd(fd_size, &fd, &addr);
+
+	for (j =3D 0; j < n; j++) {
+		printf("addr: %lx, punch a hole at offset %ld kB with len %ld kB ... ",
+			addr, offset[j] >> 10, len[j] >> 10);
+		fallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, offset[j], len[j=
]);
+		printf("done\n");
+	}
+
+	for (i =3D 0; i < fd_size; i++) {
+		int in_hole =3D 0;
+
+		for (j =3D 0; j < n; j++)
+			if (i >=3D offset[j] && i <=3D (offset[j] + len[j])) {
+				in_hole =3D 1;
+				break;
+			}
+
+		if (in_hole)
+			continue;
+		if (*(addr + i) !=3D (char)i) {
+			printf("%lu byte corrupted in the file\n", i);
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	close(fd);
+
+}
+
 int main(int argc, char **argv)
 {
+	int i;
+	size_t fd_size;
+	off_t offset[2], len[2];
+
 	if (geteuid() !=3D 0) {
 		printf("Please run the benchmark as root\n");
 		exit(EXIT_FAILURE);
 	}
=20
+	setbuf(stdout, NULL);
+
 	pagesize =3D getpagesize();
 	pageshift =3D ffs(pagesize) - 1;
 	pmd_pagesize =3D read_pmd_pagesize();
+	fd_size =3D 2 * pmd_pagesize;
=20
 	split_pmd_thp();
 	split_pte_mapped_thp();
=20
+	for (i =3D 8; i >=3D 0; i--)
+		split_thp_in_pagecache_to_order(fd_size, i);
+
+	/*
+	 * for i is 1, truncate code in the kernel should create order-0 pages
+	 * instead of order-1 THPs, since order-1 THP is not supported. No error
+	 * is expected.
+	 */
+	for (i =3D 8; i >=3D 0; i--)
+		truncate_thp_in_pagecache_to_order(fd_size, i);
+
+	offset[0] =3D 123 * pagesize;
+	offset[1] =3D 4 * pagesize;
+	len[0] =3D 200 * pagesize;
+	len[1] =3D 16 * pagesize;
+	punch_hole_in_pagecache_thp(fd_size, offset, len, 2);
+
+	offset[0] =3D 259 * pagesize;
+	offset[1] =3D 33 * pagesize;
+	len[0] =3D 129 * pagesize;
+	len[1] =3D 16 * pagesize;
+	punch_hole_in_pagecache_thp(fd_size, offset, len, 2);
+
 	return 0;
 }
--=20
2.28.0

