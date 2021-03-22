Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C965A345071
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 21:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhCVUHL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 16:07:11 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60341 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230284AbhCVUGg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 16:06:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 67A995803A7;
        Mon, 22 Mar 2021 16:06:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 22 Mar 2021 16:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=fm3; bh=oj1ceJWi/BKpKKJJTIfUO7FQEP
        UuLjXI9/JTXBSVp+k=; b=0PwAbi2XYwz6AH8YVWPDkSlDdBQoEGxQYmpF+rjIgD
        voSNKvICG7nXb/QI0k6yVIPfeFZRhvFi9d8EddPTGZMMKApiUdH8xPzykJN5omzR
        R6zow4gYCvKSO7yh145urGfEoti72I4v7WpEgLiohRnud1vBbVY6TpARBLA18DnN
        z2w6LR5jFq+RP6bTwLBhC+aa2ETFIj3Fid05jsVSO5C4FnOmyhfGvT1XqHXCxzma
        1vT04H944uQ+AE/JW/RUivTRcNnnExMcSESgm9t0mkuEuuQfJ94n9ak47vGNuvqR
        gSgE9JW60J+uVEhmotRGB8eTU28Rp48kuKAXiUKQ31Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:reply-to:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oj1ceJ
        Wi/BKpKKJJTIfUO7FQEPUuLjXI9/JTXBSVp+k=; b=BSFKfFR49AyJsAzTw67Wdr
        bhKPc7dksGw+qSDMHeZNxe2p5EVsvljWteXQlGlJDTlzPqgfSuk5ZxW4CC7Z9aM9
        UHdjgVRTu7/h7TrQOwCNSernpB4s/6QhXrqB5XJQZneFHH0xTJS8Rl01QRtNkyv0
        GHW5Joi5DKfuZk8CvRf/yMXUz0JAQWaD61/swQlGpWh86cD/jCbk2+FdJ0heqn+J
        02CtvMTl5riRx3I0u/fIOYzHL4VC0FSs/bvuH8YqEgTtNfyaNt7ZPViGd7c21xEo
        ujFqY0yiffEFfUhYdHsqszNUvBE0jkV6clkjIEpcMInUUWyTQuFzMTKkGnu+JbPA
        ==
X-ME-Sender: <xms:xfhYYJDAkGxf7DegcjrTeVctVNQIBQPAVp_bkJ4pPGOBbNL4Unv46g>
    <xme:xfhYYCZnNhljsL_z7wZkQ4o3zOnv2TfM_jrqdwV2Nv9WM408K19Sm8vSBHO2DRE-9
    XhGe57F8CkVsF3U9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeltedvtd
    dvtddtteffvdekhefftdejhfektdehffejhedvjeeukeetudekudefffenucfkphepvddt
    ledriedrjedurddvudefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:xfhYYMbPDAtEz4R78V1p_y844kWnN-c2c6qwHap2iSrOIs9fX2R_VA>
    <xmx:xfhYYB9pkuP6XBjUG0TdkA2G3JoKGuJAz-THl3PM5f_PInBFEPSlmA>
    <xmx:xfhYYDiqfBPVKXpnNBk-HWw189huUWfQJ6JPKKJ6XK4-ro2fEV5C2A>
    <xmx:xvhYYD4roe3xh0H1H2JlVGd5DyFgS5qhZXeBiGaCfYQIr_Z6D19G8A>
Received: from Threadripper.local (209-6-71-213.s2259.c3-0.abr-cbr1.sbo-abr.ma.cable.rcncustomer.com [209.6.71.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id B0E5C1080054;
        Mon, 22 Mar 2021 16:06:28 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Mika Penttila <mika.penttila@nextfour.com>,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v6 1/2] mm: huge_memory: a new debugfs interface for splitting THP tests.
Date:   Mon, 22 Mar 2021 16:05:46 -0400
Message-Id: <20210322200547.68587-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.30.2
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

We did not have a direct user interface of splitting the compound page
backing a THP and there is no need unless we want to expose the THP
implementation details to users. Make <debugfs>/split_huge_pages accept
a new command to do that.

By writing "<pid>,<vaddr_start>,<vaddr_end>" to
<debugfs>/split_huge_pages, THPs within the given virtual address range
from the process with the given pid are split. It is used to test
split_huge_page function. In addition, a selftest program is added to
tools/testing/selftests/vm to utilize the interface by splitting
PMD THPs and PTE-mapped THPs.

This does not change the old behavior, i.e., writing 1 to the interface
to split all THPs in the system.

Changelog:

From v5:
1. Skipped special VMAs and other fixes. (suggested by Yang Shi)

From v4:
1. Fixed the error code return issue, spotted by kernel test robot
   <lkp@intel.com>.

From v3:
1. Factored out split huge pages in the given pid code to a separate
   function.
2. Added the missing put_page for not split pages.
3. pr_debug -> pr_info, make reading results simpler.

From v2:
1. Reused existing <debugfs>/split_huge_pages interface. (suggested by
   Yang Shi)

From v1:
1. Removed unnecessary calling to vma_migratable, spotted by kernel test
   robot <lkp@intel.com>.
2. Dropped the use of find_mm_struct and code it directly, since there
   is no need for the permission check in that function and the function
   is only available when migration is on.
3. Added some comments in the selftest program to clarify how PTE-mapped
   THPs are formed.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/huge_memory.c                              | 151 ++++++++-
 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |   1 +
 .../selftests/vm/split_huge_page_test.c       | 318 ++++++++++++++++++
 4 files changed, 464 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/vm/split_huge_page_test.c

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bff92dea5ab3..b653255a548e 100644
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
@@ -2922,16 +2923,14 @@ static struct shrinker deferred_split_shrinker =3D {
 };
=20
 #ifdef CONFIG_DEBUG_FS
-static int split_huge_pages_set(void *data, u64 val)
+static void split_huge_pages_all(void)
 {
 	struct zone *zone;
 	struct page *page;
 	unsigned long pfn, max_zone_pfn;
 	unsigned long total =3D 0, split =3D 0;
=20
-	if (val !=3D 1)
-		return -EINVAL;
-
+	pr_info("Split all THPs\n");
 	for_each_populated_zone(zone) {
 		max_zone_pfn =3D zone_end_pfn(zone);
 		for (pfn =3D zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
@@ -2959,11 +2958,149 @@ static int split_huge_pages_set(void *data, u64 va=
l)
 	}
=20
 	pr_info("%lu of %lu THP split\n", split, total);
+}
=20
-	return 0;
+static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *v=
ma)
+{
+	return vma_is_special_huge(vma) || (vma->vm_flags & VM_IO) ||
+		    is_vm_hugetlb_page(vma);
 }
-DEFINE_DEBUGFS_ATTRIBUTE(split_huge_pages_fops, NULL, split_huge_pages_set,
-		"%llu\n");
+
+static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
+				unsigned long vaddr_end)
+{
+	int ret =3D 0;
+	struct task_struct *task;
+	struct mm_struct *mm;
+	unsigned long total =3D 0, split =3D 0;
+	unsigned long addr;
+
+	vaddr_start &=3D PAGE_MASK;
+	vaddr_end &=3D PAGE_MASK;
+
+	/* Find the task_struct from pid */
+	rcu_read_lock();
+	task =3D find_task_by_vpid(pid);
+	if (!task) {
+		rcu_read_unlock();
+		ret =3D -ESRCH;
+		goto out;
+	}
+	get_task_struct(task);
+	rcu_read_unlock();
+
+	/* Find the mm_struct */
+	mm =3D get_task_mm(task);
+	put_task_struct(task);
+
+	if (!mm) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	pr_info("Split huge pages in pid: %d, vaddr: [0x%lx - 0x%lx]\n",
+		 pid, vaddr_start, vaddr_end);
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
+		if (!vma || addr < vma->vm_start)
+			break;
+
+		/* skip special VMA and hugetlb VMA */
+		if (vma_not_suitable_for_thp_split(vma)) {
+			addr =3D vma->vm_end;
+			continue;
+		}
+
+		/* FOLL_DUMP to ignore special (like zero) pages */
+		follflags =3D FOLL_GET | FOLL_DUMP;
+		page =3D follow_page(vma, addr, follflags);
+
+		if (IS_ERR(page))
+			continue;
+		if (!page)
+			continue;
+
+		if (!is_transparent_hugepage(page))
+			goto next;
+
+		total++;
+		if (!can_split_huge_page(compound_head(page), NULL))
+			goto next;
+
+		if (!trylock_page(page))
+			goto next;
+
+		if (!split_huge_page(page))
+			split++;
+
+		unlock_page(page);
+next:
+		put_page(page);
+	}
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+	pr_info("%lu of %lu THP split\n", split, total);
+
+out:
+	return ret;
+}
+
+#define MAX_INPUT_BUF_SZ 255
+
+static ssize_t split_huge_pages_write(struct file *file, const char __user=
 *buf,
+				size_t count, loff_t *ppops)
+{
+	static DEFINE_MUTEX(split_debug_mutex);
+	ssize_t ret;
+	char input_buf[MAX_INPUT_BUF_SZ]; /* hold pid, start_vaddr, end_vaddr */
+	int pid;
+	unsigned long vaddr_start, vaddr_end;
+
+	ret =3D mutex_lock_interruptible(&split_debug_mutex);
+	if (ret)
+		return ret;
+
+	ret =3D -EFAULT;
+
+	memset(input_buf, 0, MAX_INPUT_BUF_SZ);
+	if (copy_from_user(input_buf, buf, min_t(size_t, count, MAX_INPUT_BUF_SZ)=
))
+		goto out;
+
+	input_buf[MAX_INPUT_BUF_SZ - 1] =3D '\0';
+	ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &vaddr_en=
d);
+	if (ret =3D=3D 1 && pid =3D=3D 1) {
+		split_huge_pages_all();
+		ret =3D strlen(input_buf);
+		goto out;
+	} else if (ret !=3D 3) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	ret =3D split_huge_pages_pid(pid, vaddr_start, vaddr_end);
+	if (!ret)
+		ret =3D strlen(input_buf);
+out:
+	mutex_unlock(&split_debug_mutex);
+	return ret;
+
+}
+
+static const struct file_operations split_huge_pages_fops =3D {
+	.owner	 =3D THIS_MODULE,
+	.write	 =3D split_huge_pages_write,
+	.llseek  =3D no_llseek,
+};
=20
 static int __init split_huge_pages_debugfs(void)
 {
diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftest=
s/vm/.gitignore
index 9a35c3f6a557..1f651e85ed60 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -22,3 +22,4 @@ map_fixed_noreplace
 write_to_hugetlbfs
 hmm-tests
 local_config.*
+split_huge_page_test
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/=
vm/Makefile
index d42115e4284d..4cbc91d6869f 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -42,6 +42,7 @@ TEST_GEN_FILES +=3D on-fault-limit
 TEST_GEN_FILES +=3D thuge-gen
 TEST_GEN_FILES +=3D transhuge-stress
 TEST_GEN_FILES +=3D userfaultfd
+TEST_GEN_FILES +=3D split_huge_page_test
=20
 ifeq ($(MACHINE),x86_64)
 CAN_BUILD_I386 :=3D $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bi=
t_program.c -m32)
diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/test=
ing/selftests/vm/split_huge_page_test.c
new file mode 100644
index 000000000000..2c0c18e60c57
--- /dev/null
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A test of splitting PMD THPs and PTE-mapped THPs from a specified virtu=
al
+ * address range in a process via <debugfs>/split_huge_pages interface.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <inttypes.h>
+#include <string.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <malloc.h>
+#include <stdbool.h>
+
+uint64_t pagesize;
+unsigned int pageshift;
+uint64_t pmd_pagesize;
+
+#define PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
+#define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
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
+	if (!one_page) {
+		printf("Fail to allocate memory\n");
+		exit(EXIT_FAILURE);
+	}
+
+	madvise(one_page, len, MADV_HUGEPAGE);
+
+	for (i =3D 0; i < len; i++)
+		one_page[i] =3D (char)i;
+
+	thp_size =3D check_huge(one_page);
+	if (!thp_size) {
+		printf("No THP is allocated\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/* split all THPs */
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
+		printf("No THP is allocated\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/* remap the first pagesize of first THP */
+	pte_mapped =3D mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
+
+	/* remap the Nth pagesize of Nth THP */
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
+	/* split all remapped THPs */
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
2.30.2

