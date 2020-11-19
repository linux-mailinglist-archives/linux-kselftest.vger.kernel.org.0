Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0582B9762
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 17:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgKSQGx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 11:06:53 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:35801 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727983AbgKSQGj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 11:06:39 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 4BF4AEB4;
        Thu, 19 Nov 2020 11:06:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 19 Nov 2020 11:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=6B/FUvKHHScTD
        Z2PaEwUPvScxGZ9bSlz+44XAiXDEiM=; b=YsR7n7kW9Jvv8ACqaj1dWyAH6eKXW
        h5uDkOOwoRc8QTBdpZgX4wGYyBgPO3nL7G9+IyPZtcUqTpGYozxeSnGdTrhrQqLj
        VAhnrQgTxE4a+ipeWbzKP3T3oafEOeB5cboejbI7X+lavexpWCHIph963Fl93d5N
        M29uNM1TAddQdJbi2wFcdPEW4nJwcirnb8lGntEQqOF/X8zrmrghjyiHUvboVSz8
        ZpUf6aY/8++LbCLL5AfUWv9n/j+3CDRTdJ11aUMPI2rwO/lPYfrwGj+FxFVV+ezk
        RZQdq3jU3gySY1iXvj+8PNr5zaBdSc635XWPOMZfMqm70ZahT9JlOXRjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=6B/FUvKHHScTDZ2PaEwUPvScxGZ9bSlz+44XAiXDEiM=; b=R/eTVlyp
        jOZAw0DvdwgtqygGOQqAcaVBwcbkztAAMsP0jnyAgSzzhg/vmBNwzlzQ94DtwFlB
        dTwl92GHJ/804MT7/VwrOelhdvTlDUh2xoUKVZjZ1g9Y+EJPwXJdtKFGo19RjTzz
        VZbGkma7rfG+4I334Kgqq/iDOGlv8DhnjnA+84L7mLAaOIT/dvt0gxzn2L/YlOYX
        FEa0F4GuQY+lrmgQnHkU+AyoHSieSG87fn1VhR+R/2m01oTvQwKwdqzOWcSk8nNT
        LY376r778znoUsN8EuTLRNSpd2jdr6+gqyjahCbWZYdRmpJ684+7F92/YaDX5OLk
        LIONDlJPr+75+A==
X-ME-Sender: <xms:DJi2X7EHD0bSposEM0yC84854gNqhJ5fqXUjxlwGjfhU6SjNuC4WEQ>
    <xme:DJi2X4VocTLm6pzkxRcONk2caJocwRavz7zm4y-6is9ZJjACNDjOn897ZS85yGvGr
    _-tpgZDNO8YQlj3gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedu
    vddrgeeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:DJi2X9JWLQYZ4JkUT2i3SWXtyqVEND7ci7Nr5A9HhQmIfsW06gVSzA>
    <xmx:DJi2X5EPysdwlhdPvcRl8_EJQKRKj-8J5QvZlNFL59R_2TGSCt-ohQ>
    <xmx:DJi2XxWr9O4fk2pe0ZkiKZtu6lDNz_bMAw8wol6oVTYEdrwr2VNCnQ>
    <xmx:DJi2X6MsYIsDlFXIvkM-EYazzKMxJ_ppZI3ibKrr0lkNGI6FJv9SKvk3HFA>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 221EE3064AAF;
        Thu, 19 Nov 2020 11:06:36 -0500 (EST)
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
Subject: [PATCH 2/7] mm: huge_memory: add new debugfs interface to trigger split huge page on any page range.
Date:   Thu, 19 Nov 2020 11:06:00 -0500
Message-Id: <20201119160605.1272425-3-zi.yan@sent.com>
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

Huge pages in the process with the given pid and virtual address range
are split. It is used to test split huge page function. In addition,
a testing program is added to tools/testing/selftests/vm to utilize the
interface by splitting PMD THPs and PTE-mapped THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c                              |  98 ++++++
 mm/internal.h                                 |   1 +
 mm/migrate.c                                  |   2 +-
 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |   1 +
 .../selftests/vm/split_huge_page_test.c       | 313 ++++++++++++++++++
 6 files changed, 415 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1bf51d3f2f2d..88d8b7fce5d7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -7,6 +7,7 @@
=20
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/highmem.h>
@@ -2934,10 +2935,107 @@ static int split_huge_pages_set(void *data, u64 va=
l)
 DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_pages_set,
 		"%llu\n");
=20
+static ssize_t split_huge_pages_in_range_pid_write(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppops)
+{
+	static DEFINE_MUTEX(mutex);
+	ssize_t ret;
+	char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
+	int pid;
+	unsigned long vaddr_start, vaddr_end, addr;
+	nodemask_t task_nodes;
+	struct mm_struct *mm;
+	unsigned long total =3D 0, split =3D 0;
+
+	ret =3D mutex_lock_interruptible(&mutex);
+	if (ret)
+		return ret;
+
+	ret =3D -EFAULT;
+
+	memset(input_buf, 0, 80);
+	if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
+		goto out;
+
+	input_buf[79] =3D '\0';
+	ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &vaddr_en=
d);
+	if (ret !=3D 3) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+	vaddr_start &=3D PAGE_MASK;
+	vaddr_end &=3D PAGE_MASK;
+
+	ret =3D strlen(input_buf);
+	pr_debug("split huge pages in pid: %d, vaddr: [%lx - %lx]\n",
+		 pid, vaddr_start, vaddr_end);
+
+	mm =3D find_mm_struct(pid, &task_nodes);
+	if (IS_ERR(mm)) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	mmap_read_lock(mm);
+	/*
+	 * always increase addr by PAGE_SIZE, since we could have a PTE page
+	 * table filled with PTE-mapped THPs, each of which is distinct.
+	 */
+	for (addr =3D vaddr_start; addr < vaddr_end; addr +=3D PAGE_SIZE) {
+		struct vm_area_struct *vma =3D find_vma(mm, addr);
+		unsigned int follflags;
+		struct page *page;
+
+		if (!vma || addr < vma->vm_start || !vma_migratable(vma))
+			break;
+
+		/* FOLL_DUMP to ignore special (like zero) pages */
+		follflags =3D FOLL_GET | FOLL_DUMP;
+		page =3D follow_page(vma, addr, follflags);
+
+		if (IS_ERR(page))
+			break;
+		if (!page)
+			break;
+
+		if (!is_transparent_hugepage(page))
+			continue;
+
+		total++;
+		if (!can_split_huge_page(compound_head(page), NULL))
+			continue;
+
+		if (!trylock_page(page))
+			continue;
+
+		if (!split_huge_page(page))
+			split++;
+
+		unlock_page(page);
+		put_page(page);
+	}
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+	pr_debug("%lu of %lu THP split\n", split, total);
+out:
+	mutex_unlock(&mutex);
+	return ret;
+
+}
+
+static const struct file_operations split_huge_pages_in_range_pid_fops =3D=
 {
+	.owner	 =3D THIS_MODULE,
+	.write	 =3D split_huge_pages_in_range_pid_write,
+	.llseek  =3D no_llseek,
+};
+
 static int __init split_huge_pages_debugfs(void)
 {
 	debugfs_create_file("split_huge_pages", 0200, NULL, NULL,
 			    &split_huge_pages_fops);
+	debugfs_create_file("split_huge_pages_in_range_pid", 0200, NULL, NULL,
+			    &split_huge_pages_in_range_pid_fops);
 	return 0;
 }
 late_initcall(split_huge_pages_debugfs);
diff --git a/mm/internal.h b/mm/internal.h
index fbebc3ff288c..b94b2d96e47a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -627,4 +627,5 @@ struct migration_target_control {
=20
 bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t e=
nd);
 void page_cache_free_page(struct address_space *mapping, struct page *page=
);
+struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/migrate.c b/mm/migrate.c
index 6dfc7ea08f78..8fb328f9e180 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1853,7 +1853,7 @@ static int do_pages_stat(struct mm_struct *mm, unsign=
ed long nr_pages,
 	return nr_pages ? -EFAULT : 0;
 }
=20
-static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
+struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
 {
 	struct task_struct *task;
 	struct mm_struct *mm;
diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftest=
s/vm/.gitignore
index c8deddc81e7a..da92ded5a27c 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -23,3 +23,4 @@ write_to_hugetlbfs
 hmm-tests
 memfd_secret
 local_config.*
+split_huge_page_test
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/=
vm/Makefile
index 9ab98946fbf2..1cc4e5b76dac 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -43,6 +43,7 @@ TEST_GEN_FILES +=3D on-fault-limit
 TEST_GEN_FILES +=3D thuge-gen
 TEST_GEN_FILES +=3D transhuge-stress
 TEST_GEN_FILES +=3D userfaultfd
+TEST_GEN_FILES +=3D split_huge_page_test
=20
 ifeq ($(ARCH),x86_64)
 CAN_BUILD_I386 :=3D $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bi=
t_program.c -m32)
diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/test=
ing/selftests/vm/split_huge_page_test.c
new file mode 100644
index 000000000000..cd2ced8c1261
--- /dev/null
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include "numa.h"
+#include <unistd.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <malloc.h>
+#include <stdbool.h>
+
+uint64_t pagesize;
+unsigned int pageshift;
+uint64_t pmd_pagesize;
+
+#define PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
+#define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages_in_range_pid"
+#define SMAP_PATH "/proc/self/smaps"
+#define INPUT_MAX 80
+
+#define PFN_MASK     ((1UL<<55)-1)
+#define KPF_THP      (1UL<<22)
+
+int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
+{
+	uint64_t paddr;
+	uint64_t page_flags;
+
+	if (pagemap_file) {
+		pread(pagemap_file, &paddr, sizeof(paddr),
+			((long)vaddr >> pageshift) * sizeof(paddr));
+
+		if (kpageflags_file) {
+			pread(kpageflags_file, &page_flags, sizeof(page_flags),
+				(paddr & PFN_MASK) * sizeof(page_flags));
+
+			return !!(page_flags & KPF_THP);
+		}
+	}
+	return 0;
+}
+
+
+static uint64_t read_pmd_pagesize(void)
+{
+	int fd;
+	char buf[20];
+	ssize_t num_read;
+
+	fd =3D open(PMD_SIZE_PATH, O_RDONLY);
+	if (fd =3D=3D -1) {
+		perror("Open hpage_pmd_size failed");
+		exit(EXIT_FAILURE);
+	}
+	num_read =3D read(fd, buf, 19);
+	if (num_read < 1) {
+		close(fd);
+		perror("Read hpage_pmd_size failed");
+		exit(EXIT_FAILURE);
+	}
+	buf[num_read] =3D '\0';
+	close(fd);
+
+	return strtoul(buf, NULL, 10);
+}
+
+static int write_file(const char *path, const char *buf, size_t buflen)
+{
+	int fd;
+	ssize_t numwritten;
+
+	fd =3D open(path, O_WRONLY);
+	if (fd =3D=3D -1)
+		return 0;
+
+	numwritten =3D write(fd, buf, buflen - 1);
+	close(fd);
+	if (numwritten < 1)
+		return 0;
+
+	return (unsigned int) numwritten;
+}
+
+static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t vaddr_en=
d)
+{
+	char input[INPUT_MAX];
+	int ret;
+
+	ret =3D snprintf(input, INPUT_MAX, "%d,0x%lx,0x%lx", pid, vaddr_start,
+			vaddr_end);
+	if (ret >=3D INPUT_MAX) {
+		printf("%s: Debugfs input is too long\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+
+	if (!write_file(SPLIT_DEBUGFS, input, ret + 1)) {
+		perror(SPLIT_DEBUGFS);
+		exit(EXIT_FAILURE);
+	}
+}
+
+#define MAX_LINE_LENGTH 500
+
+static bool check_for_pattern(FILE *fp, const char *pattern, char *buf)
+{
+	while (fgets(buf, MAX_LINE_LENGTH, fp) !=3D NULL) {
+		if (!strncmp(buf, pattern, strlen(pattern)))
+			return true;
+	}
+	return false;
+}
+
+static uint64_t check_huge(void *addr)
+{
+	uint64_t thp =3D 0;
+	int ret;
+	FILE *fp;
+	char buffer[MAX_LINE_LENGTH];
+	char addr_pattern[MAX_LINE_LENGTH];
+
+	ret =3D snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
+		       (unsigned long) addr);
+	if (ret >=3D MAX_LINE_LENGTH) {
+		printf("%s: Pattern is too long\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+
+
+	fp =3D fopen(SMAP_PATH, "r");
+	if (!fp) {
+		printf("%s: Failed to open file %s\n", __func__, SMAP_PATH);
+		exit(EXIT_FAILURE);
+	}
+	if (!check_for_pattern(fp, addr_pattern, buffer))
+		goto err_out;
+
+	/*
+	 * Fetch the AnonHugePages: in the same block and check the number of
+	 * hugepages.
+	 */
+	if (!check_for_pattern(fp, "AnonHugePages:", buffer))
+		goto err_out;
+
+	if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) !=3D 1) {
+		printf("Reading smap error\n");
+		exit(EXIT_FAILURE);
+	}
+
+err_out:
+	fclose(fp);
+	return thp;
+}
+
+void split_pmd_thp(void)
+{
+	char *one_page;
+	size_t len =3D 4 * pmd_pagesize;
+	uint64_t thp_size;
+	size_t i;
+
+	one_page =3D memalign(pmd_pagesize, len);
+
+	madvise(one_page, len, MADV_HUGEPAGE);
+
+	for (i =3D 0; i < len; i++)
+		one_page[i] =3D (char)i;
+
+	thp_size =3D check_huge(one_page);
+	if (!thp_size) {
+		printf("No THP is allocatd");
+		exit(EXIT_FAILURE);
+	}
+
+	/* split all possible huge pages */
+	write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page + len);
+
+	for (i =3D 0; i < len; i++)
+		if (one_page[i] !=3D (char)i) {
+			printf("%ld byte corrupted\n", i);
+			exit(EXIT_FAILURE);
+		}
+
+
+	thp_size =3D check_huge(one_page);
+	if (thp_size) {
+		printf("Still %ld kB AnonHugePages not split\n", thp_size);
+		exit(EXIT_FAILURE);
+	}
+
+	printf("Split huge pages successful\n");
+	free(one_page);
+}
+
+void split_pte_mapped_thp(void)
+{
+	char *one_page, *pte_mapped, *pte_mapped2;
+	size_t len =3D 4 * pmd_pagesize;
+	uint64_t thp_size;
+	size_t i;
+	const char *pagemap_template =3D "/proc/%d/pagemap";
+	const char *kpageflags_proc =3D "/proc/kpageflags";
+	char pagemap_proc[255];
+	int pagemap_fd;
+	int kpageflags_fd;
+
+	if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0) {
+		perror("get pagemap proc error");
+		exit(EXIT_FAILURE);
+	}
+	pagemap_fd =3D open(pagemap_proc, O_RDONLY);
+
+	if (pagemap_fd =3D=3D -1) {
+		perror("read pagemap:");
+		exit(EXIT_FAILURE);
+	}
+
+	kpageflags_fd =3D open(kpageflags_proc, O_RDONLY);
+
+	if (kpageflags_fd =3D=3D -1) {
+		perror("read kpageflags:");
+		exit(EXIT_FAILURE);
+	}
+
+	one_page =3D mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+
+	madvise(one_page, len, MADV_HUGEPAGE);
+
+	for (i =3D 0; i < len; i++)
+		one_page[i] =3D (char)i;
+
+	thp_size =3D check_huge(one_page);
+	if (!thp_size) {
+		printf("No THP is allocatd");
+		exit(EXIT_FAILURE);
+	}
+
+	pte_mapped =3D mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
+
+	for (i =3D 1; i < 4; i++) {
+		pte_mapped2 =3D mremap(one_page + pmd_pagesize * i + pagesize * i,
+				     pagesize, pagesize,
+				     MREMAP_MAYMOVE|MREMAP_FIXED,
+				     pte_mapped + pagesize * i);
+		if (pte_mapped2 =3D=3D (char *)-1) {
+			perror("mremap failed");
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	/* smap does not show THPs after mremap, use kpageflags instead */
+	thp_size =3D 0;
+	for (i =3D 0; i < pagesize * 4; i++)
+		if (i % pagesize =3D=3D 0 &&
+		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
+			thp_size++;
+
+	if (thp_size !=3D 4) {
+		printf("Some THPs are missing during mremap\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/* split all possible huge pages */
+	write_debugfs(getpid(), (uint64_t)pte_mapped,
+		      (uint64_t)pte_mapped + pagesize * 4);
+
+	/* smap does not show THPs after mremap, use kpageflags instead */
+	thp_size =3D 0;
+	for (i =3D 0; i < pagesize * 4; i++) {
+		if (pte_mapped[i] !=3D (char)i) {
+			printf("%ld byte corrupted\n", i);
+			exit(EXIT_FAILURE);
+		}
+		if (i % pagesize =3D=3D 0 &&
+		    is_backed_by_thp(&pte_mapped[i], pagemap_fd, kpageflags_fd))
+			thp_size++;
+	}
+
+	if (thp_size) {
+		printf("Still %ld THPs not split\n", thp_size);
+		exit(EXIT_FAILURE);
+	}
+
+	printf("Split PTE-mapped huge pages successful\n");
+	munmap(one_page, len);
+	close(pagemap_fd);
+	close(kpageflags_fd);
+}
+
+int main(int argc, char **argv)
+{
+	if (geteuid() !=3D 0) {
+		printf("Please run the benchmark as root\n");
+		exit(EXIT_FAILURE);
+	}
+
+	pagesize =3D getpagesize();
+	pageshift =3D ffs(pagesize) - 1;
+	pmd_pagesize =3D read_pmd_pagesize();
+
+	split_pmd_thp();
+	split_pte_mapped_thp();
+
+	return 0;
+}
--=20
2.28.0

