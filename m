Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44334E2AA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 15:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbiCUO3E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 10:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349287AbiCUO1x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 10:27:53 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9412019E;
        Mon, 21 Mar 2022 07:21:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 90CA35C01C5;
        Mon, 21 Mar 2022 10:21:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 21 Mar 2022 10:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=U2V6naZTN2l9Vn
        KhbqbkZBPTbIZWhGoV3DWXyWLzNW0=; b=x8kPTimY8qfbhFJYezAvUUMDyE2bAs
        C9SQw8Z/8Mdhv+DkOvE7BJtwcBTUPKk5cXeClx5R2vT2ppyN6+PTA5JZxmvQ+WcI
        b1bLAw+KQQe1Z9TBH9UIJLCXenuh18K/P/Hx+N6AKs/FobnZAq3fG9fR1Hh9V2ih
        0o5ERWa9e4qz73VnChACKPUTuOcH27zbx5WYRN3XL7iVUo1rrdEgVW/+Q8BTz7m1
        Vd7yvqfGFMz9YLz6QnBBqx8faQE4B+F5FQCbsBO/kf0hbpcvm4uknWYava/yKOdr
        Llo/d856dwWclxQmcDZpUseTA0HX9mzAHIDnhFr5Y/McfOaDa1klByRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=U2V6naZTN2l9VnKhbqbkZBPTbIZWhGoV3DWXyWLzNW0=; b=dmlyux77
        IbBQWWQFTzBrZFvHDATunOQU5xyGXGuFKyhU43ssIM9CcL/K9SyRebsKK8kLbN9d
        Wf4AC5q6AXurzY6OJ7cwpzwpnpzE81p+aTlCGhTzQsu1L/MuXWgdYMx8q41Gct/A
        lhyRP1uwA53V7hnV8Y+SIbwhdGmEQraicdmUD0U37RXg7EUTaw4ksY5NNmaeUMSm
        Cpkp93TJcQ2RcZsC7/j7MM4eAexoNcZJVTm7Jje/w/JiT1EqQb06RnNXeUvuVmEO
        /RmxIQIlHYGNWwr9ossUU9PRExGdJeAxZzp2YfZtTiZQahcOOoHlnT6Oq8BvuFYA
        IiQ+iYdrLK+eHQ==
X-ME-Sender: <xms:84k4Yt5AVEoLlvZoP-K_9lIFEKLAGXDrsa3rJTKuBqK4rP_mY8yAdg>
    <xme:84k4Yq4uxfBdM0HbS9bcpqESCE9aSldJvpBnIB9ItcKW2lJ-i017i8fidYj_6qV3G
    _-yri2X6NXS-9h7TQ>
X-ME-Received: <xmr:84k4YkeMrY-XYBfWw9weYgblqMej8RhR39SJbJz35MbDXASKz47b2GDuKoT7fCankLI9c0ARIwTwTEzwZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:84k4YmLwQ0F8yzFPeYEQUAVXQIw1145a0WlApoUUOJQ8uFChrdRhDQ>
    <xmx:84k4YhIqgaZE2HKHGurGkAJPkl8RLfMIKbiZbpbG-MS7Oeibjl_hNA>
    <xmx:84k4YvyxSdZjtJXqGjSvwAQzx829Fi0mhstAXvK8ZhZZl60bBJpvaQ>
    <xmx:84k4YuBkrqkOp-aWOWcl46G17yZNgXWuWEwfa6PtnqYRn805rew0tQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 10:21:38 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 5/5] mm: huge_memory: enable debugfs to split huge pages to any order.
Date:   Mon, 21 Mar 2022 10:21:28 -0400
Message-Id: <20220321142128.2471199-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321142128.2471199-1-zi.yan@sent.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

It is used to test split_huge_page_to_list_to_order for pagecache THPs.
Also add test cases for split_huge_page_to_list_to_order via both
debugfs, truncating a file, and punching holes in a file.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c                              |  26 ++-
 .../selftests/vm/split_huge_page_test.c       | 219 +++++++++++++++---
 2 files changed, 201 insertions(+), 44 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 76db0092a1e2..7645bb12fcbc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2856,7 +2856,7 @@ static inline bool vma_not_suitable_for_thp_split(str=
uct vm_area_struct *vma)
 }
=20
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end)
+				unsigned long vaddr_end, unsigned int new_order)
 {
 	int ret =3D 0;
 	struct task_struct *task;
@@ -2926,7 +2926,7 @@ static int split_huge_pages_pid(int pid, unsigned lon=
g vaddr_start,
 		if (!trylock_page(page))
 			goto next;
=20
-		if (!split_huge_page(page))
+		if (!split_huge_page_to_list_to_order(page, NULL, new_order))
 			split++;
=20
 		unlock_page(page);
@@ -2944,7 +2944,7 @@ static int split_huge_pages_pid(int pid, unsigned lon=
g vaddr_start,
 }
=20
 static int split_huge_pages_in_file(const char *file_path, pgoff_t off_sta=
rt,
-				pgoff_t off_end)
+				pgoff_t off_end, unsigned int new_order)
 {
 	struct filename *file;
 	struct file *candidate;
@@ -2984,7 +2984,7 @@ static int split_huge_pages_in_file(const char *file_=
path, pgoff_t off_start,
 		if (!trylock_page(fpage))
 			goto next;
=20
-		if (!split_huge_page(fpage))
+		if (!split_huge_page_to_list_to_order(fpage, NULL, new_order))
 			split++;
=20
 		unlock_page(fpage);
@@ -3009,10 +3009,14 @@ static ssize_t split_huge_pages_write(struct file *=
file, const char __user *buf,
 {
 	static DEFINE_MUTEX(split_debug_mutex);
 	ssize_t ret;
-	/* hold pid, start_vaddr, end_vaddr or file_path, off_start, off_end */
+	/*
+	 * hold pid, start_vaddr, end_vaddr, new_order or
+	 * file_path, off_start, off_end, new_order
+	 */
 	char input_buf[MAX_INPUT_BUF_SZ];
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
+	unsigned int new_order =3D 0;
=20
 	ret =3D mutex_lock_interruptible(&split_debug_mutex);
 	if (ret)
@@ -3041,29 +3045,29 @@ static ssize_t split_huge_pages_write(struct file *=
file, const char __user *buf,
 			goto out;
 		}
=20
-		ret =3D sscanf(buf, "0x%lx,0x%lx", &off_start, &off_end);
-		if (ret !=3D 2) {
+		ret =3D sscanf(buf, "0x%lx,0x%lx,%d", &off_start, &off_end, &new_order);
+		if (ret !=3D 2 && ret !=3D 3) {
 			ret =3D -EINVAL;
 			goto out;
 		}
-		ret =3D split_huge_pages_in_file(file_path, off_start, off_end);
+		ret =3D split_huge_pages_in_file(file_path, off_start, off_end, new_orde=
r);
 		if (!ret)
 			ret =3D input_len;
=20
 		goto out;
 	}
=20
-	ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &vaddr_en=
d);
+	ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx,%d", &pid, &vaddr_start, &vaddr=
_end, &new_order);
 	if (ret =3D=3D 1 && pid =3D=3D 1) {
 		split_huge_pages_all();
 		ret =3D strlen(input_buf);
 		goto out;
-	} else if (ret !=3D 3) {
+	} else if (ret !=3D 3 && ret !=3D 4) {
 		ret =3D -EINVAL;
 		goto out;
 	}
=20
-	ret =3D split_huge_pages_pid(pid, vaddr_start, vaddr_end);
+	ret =3D split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order);
 	if (!ret)
 		ret =3D strlen(input_buf);
 out:
diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/test=
ing/selftests/vm/split_huge_page_test.c
index 52497b7b9f1d..af01e7dca9c8 100644
--- a/tools/testing/selftests/vm/split_huge_page_test.c
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -16,6 +16,7 @@
 #include <sys/mount.h>
 #include <malloc.h>
 #include <stdbool.h>
+#include <time.h>
=20
 uint64_t pagesize;
 unsigned int pageshift;
@@ -24,10 +25,11 @@ uint64_t pmd_pagesize;
 #define PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
 #define SMAP_PATH "/proc/self/smaps"
+#define THP_FS_PATH "/mnt/thp_fs"
 #define INPUT_MAX 80
=20
-#define PID_FMT "%d,0x%lx,0x%lx"
-#define PATH_FMT "%s,0x%lx,0x%lx"
+#define PID_FMT "%d,0x%lx,0x%lx,%d"
+#define PATH_FMT "%s,0x%lx,0x%lx,%d"
=20
 #define PFN_MASK     ((1UL<<55)-1)
 #define KPF_THP      (1UL<<22)
@@ -75,23 +77,6 @@ static uint64_t read_pmd_pagesize(void)
 	return strtoul(buf, NULL, 10);
 }
=20
-static int write_file(const char *path, const char *buf, size_t buflen)
-{
-	int fd;
-	ssize_t numwritten;
-
-	fd =3D open(path, O_WRONLY);
-	if (fd =3D=3D -1)
-		return 0;
-
-	numwritten =3D write(fd, buf, buflen - 1);
-	close(fd);
-	if (numwritten < 1)
-		return 0;
-
-	return (unsigned int) numwritten;
-}
-
 static void write_debugfs(const char *fmt, ...)
 {
 	char input[INPUT_MAX];
@@ -106,11 +91,6 @@ static void write_debugfs(const char *fmt, ...)
 		printf("%s: Debugfs input is too long\n", __func__);
 		exit(EXIT_FAILURE);
 	}
-
-	if (!write_file(SPLIT_DEBUGFS, input, ret + 1)) {
-		perror(SPLIT_DEBUGFS);
-		exit(EXIT_FAILURE);
-	}
 }
=20
 #define MAX_LINE_LENGTH 500
@@ -124,7 +104,7 @@ static bool check_for_pattern(FILE *fp, const char *pat=
tern, char *buf)
 	return false;
 }
=20
-static uint64_t check_huge(void *addr)
+static uint64_t check_huge(void *addr, const char *prefix)
 {
 	uint64_t thp =3D 0;
 	int ret;
@@ -149,13 +129,13 @@ static uint64_t check_huge(void *addr)
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
@@ -184,7 +164,7 @@ void split_pmd_thp(void)
 	for (i =3D 0; i < len; i++)
 		one_page[i] =3D (char)i;
=20
-	thp_size =3D check_huge(one_page);
+	thp_size =3D check_huge(one_page, "AnonHugePages:");
 	if (!thp_size) {
 		printf("No THP is allocated\n");
 		exit(EXIT_FAILURE);
@@ -192,7 +172,7 @@ void split_pmd_thp(void)
=20
 	/* split all THPs */
 	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
-		(uint64_t)one_page + len);
+		(uint64_t)one_page + len, 0);
=20
 	for (i =3D 0; i < len; i++)
 		if (one_page[i] !=3D (char)i) {
@@ -201,7 +181,7 @@ void split_pmd_thp(void)
 		}
=20
=20
-	thp_size =3D check_huge(one_page);
+	thp_size =3D check_huge(one_page, "AnonHugePages:");
 	if (thp_size) {
 		printf("Still %ld kB AnonHugePages not split\n", thp_size);
 		exit(EXIT_FAILURE);
@@ -249,7 +229,7 @@ void split_pte_mapped_thp(void)
 	for (i =3D 0; i < len; i++)
 		one_page[i] =3D (char)i;
=20
-	thp_size =3D check_huge(one_page);
+	thp_size =3D check_huge(one_page, "AnonHugePages:");
 	if (!thp_size) {
 		printf("No THP is allocated\n");
 		exit(EXIT_FAILURE);
@@ -284,7 +264,7 @@ void split_pte_mapped_thp(void)
=20
 	/* split all remapped THPs */
 	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
-		      (uint64_t)pte_mapped + pagesize * 4);
+		      (uint64_t)pte_mapped + pagesize * 4, 0);
=20
 	/* smap does not show THPs after mremap, use kpageflags instead */
 	thp_size =3D 0;
@@ -371,20 +351,193 @@ void split_file_backed_thp(void)
 	printf("file-backed THP split test done, please check dmesg for more info=
rmation\n");
 }
=20
+void create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int=
 *fd, char **addr)
+{
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
+			"supporting pagecache THP at "THP_FS_PATH"\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
+void split_thp_in_pagecache_to_order(size_t fd_size, int order)
+{
+	int fd;
+	char *addr;
+	size_t i;
+	const char testfile[] =3D THP_FS_PATH "/test";
+
+	create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
+
+	printf("split %ld kB pagecache page to order %d ... ", fd_size >> 10, ord=
er);
+	write_debugfs(PID_FMT, getpid(), (uint64_t)addr, (uint64_t)addr + fd_size=
, order);
+
+	for (i =3D 0; i < fd_size; i++)
+		if (*(addr + i) !=3D (char)i) {
+			printf("%lu byte corrupted in the file\n", i);
+			exit(EXIT_FAILURE);
+		}
+
+	close(fd);
+	unlink(testfile);
+	printf("done\n");
+}
+
+void truncate_thp_in_pagecache_to_order(size_t fd_size, int order)
+{
+	int fd;
+	char *addr;
+	size_t i;
+	const char testfile[] =3D THP_FS_PATH "/test";
+
+	create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
+
+	printf("truncate %ld kB pagecache page to size %lu kB ... ", fd_size >> 1=
0, 4UL << order);
+	ftruncate(fd, pagesize << order);
+
+	for (i =3D 0; i < (pagesize << order); i++)
+		if (*(addr + i) !=3D (char)i) {
+			printf("%lu byte corrupted in the file\n", i);
+			exit(EXIT_FAILURE);
+		}
+
+	close(fd);
+	unlink(testfile);
+	printf("done\n");
+}
+
+void punch_hole_in_pagecache_thp(size_t fd_size, off_t offset[], off_t len=
[], int n)
+{
+	int fd, j;
+	char *addr;
+	size_t i;
+	const char testfile[] =3D THP_FS_PATH "/test";
+
+	create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
+
+	for (j =3D 0; j < n; j++) {
+		printf("addr: %lx, punch a hole at offset %ld kB with len %ld kB ... ",
+			(unsigned long)addr, offset[j] >> 10, len[j] >> 10);
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
+		if (in_hole) {
+			if (*(addr + i)) {
+				printf("%lu byte non-zero after punch\n", i);
+				exit(EXIT_FAILURE);
+			}
+			continue;
+		}
+		if (*(addr + i) !=3D (char)i) {
+			printf("%lu byte corrupted in the file\n", i);
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	close(fd);
+	unlink(testfile);
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
 	split_file_backed_thp();
=20
+	for (i =3D 8; i >=3D 0; i--)
+		if (i !=3D 1)
+			split_thp_in_pagecache_to_order(fd_size, i);
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
+	offset[0] =3D 259 * pagesize + pagesize / 2;
+	offset[1] =3D 33 * pagesize;
+	len[0] =3D 129 * pagesize;
+	len[1] =3D 16 * pagesize;
+	punch_hole_in_pagecache_thp(fd_size, offset, len, 2);
+
 	return 0;
 }
--=20
2.35.1

