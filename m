Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4736CCF6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 03:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjC2BRq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 21:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjC2BRm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 21:17:42 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901AC270B;
        Tue, 28 Mar 2023 18:17:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CB9E35C00EA;
        Tue, 28 Mar 2023 21:17:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 28 Mar 2023 21:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680052659; x=1680139059; bh=BxqGc0evZec652+iCiid1CZrCHeD4aKdhQK
        P2Da/cdE=; b=WLPo7fI0z9NuknUbDxKzkiZcoueiJ0DMONyqrTBCIctzyn2PZE4
        C63FkhOUBLOMKZZGlMX8U/Wcpwyn9rDM2gIrH/Zx9fZSqAY9YivFElDw0/M/OMBU
        WkSUDvCL12p8WYbfb9oCoTxV8j5UTAd2cTGpDQOBaHTYIU7tcIkFj9Oa9S1QcFcn
        l6yqxkTcT/brSQuaJdpdxRQ+52HanqxvlJkz8qQSK/mnJkYeizdyeYqrb2wCotOI
        JvG0e1HjbplbsdjmVZQIRwj0O+HxPnvHtQL/+h+w3RsZYEBWhov3wXQcrFrF00Xl
        YXF1aQEsSQoCQAn434g4CwueoSyIsAGmTzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680052659; x=1680139059; bh=BxqGc0evZec652+iCiid1CZrCHeD4aKdhQK
        P2Da/cdE=; b=KjgraFA3pUHek1i5HwjjNMt0bKZi7Mlgtm1I8nt/SmiRLfwtIEH
        o0KKM3WEc53CcB39sq7h/B4ZY447nyikhA65HgU0nmB5kMgHoiemfFb+MQ3PYppE
        tb2IUNCVEz477UksEOHPnXBOUabJr6fLunpKycJMMk3O06l+WLBB7DJ0U2NaJWh/
        ZlarVVl909onmO11QKfuoriFSPsmxuhGKbr7WzF31IHIJvUlgwNak2Wms3MhbKhs
        WZj5kts2CfnRIXTiqYUNBrI2qZ+7ukRemXvCRisq+6lGDL0RNbMtCf/e6wdW2hBv
        iuneQU4pEwOi5DyiD6TRjhHeG8v6YYzPZ5g==
X-ME-Sender: <xms:s5EjZC5mBrSnNnoexY0cT9uShKToNOgCstwp5ndh4kVDzGFtQw71wQ>
    <xme:s5EjZL7x5MTPlGnlgPEBCSH9xmLQfPrUaPUyfgIrxpMUGYH7TUy5NWMl3BseKkiYz
    ou1rla6USXOj_PyAg>
X-ME-Received: <xmr:s5EjZBf6Mx3TSwv6m3VzjEYDIZlw4vxxL0hCwvIddSl4wJOrz3XUTUddvUVCfcHm3CrLBtPcik2NPu1ljfqUi-JlfZv1XMkPttD5-MCcCC5nxjTtAvWBEVq4e4wtGAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehhedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:s5EjZPKR6eV1v1qnKMGWaIyY9P-JQa3QmddjGFTdq8MUlb0UyiZtfw>
    <xmx:s5EjZGJU7mCbmqdvR9vDiTYaptEe5gaEssziFvF9D4ePhfWdBrumKA>
    <xmx:s5EjZAyWiKxiuPgWNC6-wGolUCD5gTbBx5MiGR0QV9FhHjUGAWOGEQ>
    <xmx:s5EjZBanMpwN9CGDKy0165vpTBFfn1k5NP6h9X4yuOmJYGyTfzubLw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Mar 2023 21:17:39 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org
Cc:     Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 7/7] mm: huge_memory: enable debugfs to split huge pages to any order.
Date:   Tue, 28 Mar 2023 21:17:12 -0400
Message-Id: <20230329011712.3242298-8-zi.yan@sent.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329011712.3242298-1-zi.yan@sent.com>
References: <20230329011712.3242298-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
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
 mm/huge_memory.c                              |  34 ++-
 .../selftests/mm/split_huge_page_test.c       | 225 +++++++++++++++++-
 2 files changed, 242 insertions(+), 17 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 619d25278340..ad5b29558a51 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3023,7 +3023,7 @@ static inline bool vma_not_suitable_for_thp_split(str=
uct vm_area_struct *vma)
 }
=20
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end)
+				unsigned long vaddr_end, unsigned int new_order)
 {
 	int ret =3D 0;
 	struct task_struct *task;
@@ -3085,13 +3085,19 @@ static int split_huge_pages_pid(int pid, unsigned l=
ong vaddr_start,
 			goto next;
=20
 		total++;
-		if (!can_split_folio(page_folio(page), NULL))
+		/*
+		 * For folios with private, split_huge_page_to_list_to_order()
+		 * will try to drop it before split and then check if the folio
+		 * can be split or not. So skip the check here.
+		 */
+		if (!folio_test_private(page_folio(page)) &&
+		    !can_split_folio(page_folio(page), NULL))
 			goto next;
=20
 		if (!trylock_page(page))
 			goto next;
=20
-		if (!split_huge_page(page))
+		if (!split_huge_page_to_list_to_order(page, NULL, new_order))
 			split++;
=20
 		unlock_page(page);
@@ -3109,7 +3115,7 @@ static int split_huge_pages_pid(int pid, unsigned lon=
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
@@ -3148,7 +3154,7 @@ static int split_huge_pages_in_file(const char *file_=
path, pgoff_t off_start,
 		if (!folio_trylock(folio))
 			goto next;
=20
-		if (!split_folio(folio))
+		if (!split_huge_page_to_list_to_order(&folio->page, NULL, new_order))
 			split++;
=20
 		folio_unlock(folio);
@@ -3173,10 +3179,14 @@ static ssize_t split_huge_pages_write(struct file *=
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
@@ -3205,29 +3215,29 @@ static ssize_t split_huge_pages_write(struct file *=
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
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/test=
ing/selftests/mm/split_huge_page_test.c
index b8558c7f1a39..cbb5e6893cbf 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -16,6 +16,7 @@
 #include <sys/mount.h>
 #include <malloc.h>
 #include <stdbool.h>
+#include <time.h>
 #include "vm_util.h"
=20
 uint64_t pagesize;
@@ -23,10 +24,12 @@ unsigned int pageshift;
 uint64_t pmd_pagesize;
=20
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
+#define SMAP_PATH "/proc/self/smaps"
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
@@ -113,7 +116,7 @@ void split_pmd_thp(void)
=20
 	/* split all THPs */
 	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
-		(uint64_t)one_page + len);
+		(uint64_t)one_page + len, 0);
=20
 	for (i =3D 0; i < len; i++)
 		if (one_page[i] !=3D (char)i) {
@@ -203,7 +206,7 @@ void split_pte_mapped_thp(void)
=20
 	/* split all remapped THPs */
 	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
-		      (uint64_t)pte_mapped + pagesize * 4);
+		      (uint64_t)pte_mapped + pagesize * 4, 0);
=20
 	/* smap does not show THPs after mremap, use kpageflags instead */
 	thp_size =3D 0;
@@ -269,7 +272,7 @@ void split_file_backed_thp(void)
 	}
=20
 	/* split the file-backed THP */
-	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end);
+	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end, 0);
=20
 	status =3D unlink(testfile);
 	if (status)
@@ -290,20 +293,232 @@ void split_file_backed_thp(void)
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
+		goto err_out_unlink;
+	}
+	if (write(*fd, "3", 1) !=3D 1) {
+		perror("write to drop_caches");
+		goto err_out_unlink;
+	}
+	close(*fd);
+
+	*fd =3D open(testfile, O_RDWR);
+	if (*fd =3D=3D -1) {
+		perror("Failed to open a file at "THP_FS_PATH);
+		goto err_out_unlink;
+	}
+
+	*addr =3D mmap(NULL, fd_size, PROT_READ|PROT_WRITE, MAP_SHARED, *fd, 0);
+	if (*addr =3D=3D (char *)-1) {
+		perror("cannot mmap");
+		goto err_out_close;
+	}
+	madvise(*addr, fd_size, MADV_HUGEPAGE);
+
+	for (size_t i =3D 0; i < fd_size; i++)
+		dummy +=3D *(*addr + i);
+
+	if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) {
+		printf("No pagecache THP generated, please mount a filesystem supporting=
 pagecache THP at "THP_FS_PATH"\n");
+		goto err_out_close;
+	}
+	return;
+err_out_close:
+	close(*fd);
+err_out_unlink:
+	unlink(testfile);
+	exit(EXIT_FAILURE);
+}
+
+void split_thp_in_pagecache_to_order(size_t fd_size, int order)
+{
+	int fd;
+	char *addr;
+	size_t i;
+	const char testfile[] =3D THP_FS_PATH "/test";
+	int err =3D 0;
+
+	create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
+
+	printf("split %ld kB PMD-mapped pagecache page to order %d ... ", fd_size=
 >> 10, order);
+	write_debugfs(PID_FMT, getpid(), (uint64_t)addr, (uint64_t)addr + fd_size=
, order);
+
+	for (i =3D 0; i < fd_size; i++)
+		if (*(addr + i) !=3D (char)i) {
+			printf("%lu byte corrupted in the file\n", i);
+			err =3D EXIT_FAILURE;
+			goto out;
+		}
+
+	if (!check_huge_file(addr, 0, pmd_pagesize)) {
+		printf("Still FilePmdMapped not split\n");
+		err =3D EXIT_FAILURE;
+		goto out;
+	}
+
+	printf("done\n");
+out:
+	close(fd);
+	unlink(testfile);
+	if (err)
+		exit(err);
+}
+
+void truncate_thp_in_pagecache_to_order(size_t fd_size, int order)
+{
+	int fd;
+	char *addr;
+	size_t i;
+	const char testfile[] =3D THP_FS_PATH "/test";
+	int err =3D 0;
+
+	create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
+
+	printf("truncate %ld kB PMD-mapped pagecache page to size %lu kB ... ",
+		fd_size >> 10, 4UL << order);
+	ftruncate(fd, pagesize << order);
+
+	for (i =3D 0; i < (pagesize << order); i++)
+		if (*(addr + i) !=3D (char)i) {
+			printf("%lu byte corrupted in the file\n", i);
+			err =3D EXIT_FAILURE;
+			goto out;
+		}
+
+	if (!check_huge_file(addr, 0, pmd_pagesize)) {
+		printf("Still FilePmdMapped not split after truncate\n");
+		err =3D EXIT_FAILURE;
+		goto out;
+	}
+
+	printf("done\n");
+out:
+	close(fd);
+	unlink(testfile);
+	if (err)
+		exit(err);
+}
+
+void punch_hole_in_pagecache_thp(size_t fd_size, off_t offset[], off_t len=
[],
+			int n, int num_left_thps)
+{
+	int fd, j;
+	char *addr;
+	size_t i;
+	const char testfile[] =3D THP_FS_PATH "/test";
+	int err =3D 0;
+
+	create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
+
+	for (j =3D 0; j < n; j++) {
+		printf("punch a hole to %ld kB PMD-mapped pagecache page at addr: %lx, o=
ffset %ld, and len %ld ...\n",
+			fd_size >> 10, (unsigned long)addr, offset[j], len[j]);
+		fallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, offset[j], len[j=
]);
+	}
+
+	for (i =3D 0; i < fd_size; i++) {
+		int in_hole =3D 0;
+
+		for (j =3D 0; j < n; j++)
+			if (i >=3D offset[j] && i < (offset[j] + len[j])) {
+				in_hole =3D 1;
+				break;
+			}
+
+		if (in_hole) {
+			if (*(addr + i)) {
+				printf("%lu byte non-zero after punch\n", i);
+				err =3D EXIT_FAILURE;
+				goto out;
+			}
+			continue;
+		}
+		if (*(addr + i) !=3D (char)i) {
+			printf("%lu byte corrupted in the file\n", i);
+			err =3D EXIT_FAILURE;
+			goto out;
+		}
+	}
+
+	if (!check_huge_file(addr, num_left_thps, pmd_pagesize)) {
+		printf("Still FilePmdMapped not split after punch\n");
+		goto out;
+	}
+	printf("done\n");
+out:
+	close(fd);
+	unlink(testfile);
+	if (err)
+		exit(err);
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
+	offset[0] =3D 123;
+	offset[1] =3D 4 * pagesize;
+	len[0] =3D 200 * pagesize;
+	len[1] =3D 16 * pagesize;
+	punch_hole_in_pagecache_thp(fd_size, offset, len, 2, 1);
+
+	offset[0] =3D 259 * pagesize + pagesize / 2;
+	offset[1] =3D 33 * pagesize;
+	len[0] =3D 129 * pagesize;
+	len[1] =3D 16 * pagesize;
+	punch_hole_in_pagecache_thp(fd_size, offset, len, 2, 1);
+
 	return 0;
 }
--=20
2.39.2

