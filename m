Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979A02AF9FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 21:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgKKUqD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 15:46:03 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:60509 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726875AbgKKUqC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 15:46:02 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 51FFDB3D;
        Wed, 11 Nov 2020 15:40:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 11 Nov 2020 15:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=vIYJoxuU5tKu/
        hyJrnZuBp+v7rlQ+F8xeJcONsNriU0=; b=rEuH0PxI3Ns3MdKNLXtW5dHUajYUw
        MkSOswCbZijE/eYkI1/YUCfAUjoGR5Jy7HwMBPWvEI9bURP8DIq/HFpAOVgUY7DT
        HTerQY/NFDRsCgEGfXEuqMTlKXyOE2cE1j1L4h4chdESunEnV9OUzlx0uo+7W3Ns
        VRwRS0rxUcr8CV0KcJgU4oJ5RC3BJv3fq1slKy4LndWlOXzsk0RklUmSGD41rnhe
        dS/9jFHVFl2d6b2LJgVmYg14q16ggYZEP2Kv7TSDCnsNcItU6C5fccZw6ijDUkLN
        2NRSjnCwgnayzD0Ze7FccTLbRaR6Ks7tVykyAwqPDsGaSX8y6pC3Xpp7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=vIYJoxuU5tKu/hyJrnZuBp+v7rlQ+F8xeJcONsNriU0=; b=mmV3IxgO
        RXxP1quVBOCmymvDWIZnKCPcfPZTGXL716YDnRuC0+phHyGMdF8lttuvgA3/UIp+
        iLG+/drOK5/Ex+iXwQ3YGHGCWCCF/61PGlgfhU9VeKP9GkTnfOWw3RMRA+rRb5Yv
        ZKpS8kYqKFktj75TWybTPIPS3k2va+MSYVusVpVuJ+/ba1vfRUY5gA4M/yfmojiw
        csvVTC9Cowem5Gv74ZgqhOlmt441xAfhwkWRW2N5qYZ2rqXarHsT3GpIm8YL9nm3
        MfMZPX9TPr53U017iSgXaWWWcrbWFDGVCzfYnUCumX0Hy2scW0WWOOQROcKIgMPs
        NKdfa9A93Cs0Qw==
X-ME-Sender: <xms:SEysX6fMy-9NnJmjpi2PCR1onYeiiWcQGRvEyVXhcf1PtWd42YzlYQ>
    <xme:SEysX0NJjveXqU5FHBmsabZ7-D4M-csA9J-nMUwSSdL9KtgxxFO7977mDoK77E2Jv
    X1U7h9zXxoquJUWbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvtddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedu
    vddrgeeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:SEysX7i7i9iVjoZXRJSXzuuv27Nmk5zQJ5YTQqz0fdSK28V60CZ-2A>
    <xmx:SEysX3-pqaCmxvdwrw4yc41qgQjp5TLoFrqOSdTiefuihAGhPQhCfg>
    <xmx:SEysX2sJ3XVsLBfKdjaIJynDhrYSo-TMN80hqutQ-F1F7pdfzM10vA>
    <xmx:SEysX3nMFJxzZPU_FiHl_ZhKPviybZiCR_7vSOc10GWWcFft3Z4_5_-6ROY>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id CA8FC328006C;
        Wed, 11 Nov 2020 15:40:39 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 1/6] mm: huge_memory: add new debugfs interface to trigger split huge page on any page range.
Date:   Wed, 11 Nov 2020 15:40:03 -0500
Message-Id: <20201111204008.21332-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201111204008.21332-1-zi.yan@sent.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
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
interface by splitting PMD THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c                              |  98 +++++++++++
 mm/internal.h                                 |   1 +
 mm/migrate.c                                  |   2 +-
 tools/testing/selftests/vm/Makefile           |   1 +
 .../selftests/vm/split_huge_page_test.c       | 161 ++++++++++++++++++
 5 files changed, 262 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 207ebca8c654..c4fead5ead31 100644
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
@@ -2935,10 +2936,107 @@ static int split_huge_pages_set(void *data, u64 va=
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
+	input_buf[80] =3D '\0';
+	ret =3D sscanf(input_buf, "%d,%lx,%lx", &pid, &vaddr_start, &vaddr_end);
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
+	for (addr =3D vaddr_start; addr < vaddr_end;) {
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
+			goto next;
+
+		if (!can_split_huge_page(page, NULL))
+			goto next;
+
+		if (!trylock_page(page))
+			goto next;
+
+		addr +=3D page_size(page) - PAGE_SIZE;
+
+		/* reset addr if split fails */
+		if (split_huge_page(page))
+			addr -=3D (page_size(page) - PAGE_SIZE);
+
+		unlock_page(page);
+next:
+		/* next page */
+		addr +=3D page_size(page);
+		put_page(page);
+	}
+	mmap_read_unlock(mm);
+
+
+	mmput(mm);
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
index 3ea43642b99d..fd841a38830f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -624,4 +624,5 @@ struct migration_target_control {
=20
 bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t e=
nd);
 void page_cache_free_page(struct address_space *mapping, struct page *page=
);
+struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/migrate.c b/mm/migrate.c
index a50bbb0e029b..e35654d1087d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1851,7 +1851,7 @@ static int do_pages_stat(struct mm_struct *mm, unsign=
ed long nr_pages,
 	return nr_pages ? -EFAULT : 0;
 }
=20
-static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
+struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
 {
 	struct task_struct *task;
 	struct mm_struct *mm;
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/=
vm/Makefile
index 62fb15f286ee..d9ead0cdd3e9 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -42,6 +42,7 @@ TEST_GEN_FILES +=3D on-fault-limit
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
index 000000000000..c8a32ae9e13a
--- /dev/null
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -0,0 +1,161 @@
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
+#define PAGE_4KB (4096UL)
+#define PAGE_2MB (512UL*PAGE_4KB)
+#define PAGE_1GB (512UL*PAGE_2MB)
+
+#define PRESENT_MASK (1UL<<63)
+#define SWAPPED_MASK (1UL<<62)
+#define PAGE_TYPE_MASK (1UL<<61)
+#define PFN_MASK     ((1UL<<55)-1)
+
+#define KPF_THP      (1UL<<22)
+#define KPF_PUD_THP      (1UL<<27)
+
+#define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages_in_range_pid"
+#define SMAP_PATH "/proc/self/smaps"
+#define INPUT_MAX 80
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
+	ret =3D snprintf(input, INPUT_MAX, "%d,%lx,%lx", pid, vaddr_start,
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
+static bool check_for_pattern(FILE *fp, char *pattern, char *buf)
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
+	size_t len =3D 4 * PAGE_2MB;
+	uint64_t thp_size;
+
+	one_page =3D memalign(PAGE_1GB, len);
+
+	madvise(one_page, len, MADV_HUGEPAGE);
+
+	memset(one_page, 1, len);
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
+	*one_page =3D 0;
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
+int main(int argc, char **argv)
+{
+	split_pmd_thp();
+
+	return 0;
+}
--=20
2.28.0

