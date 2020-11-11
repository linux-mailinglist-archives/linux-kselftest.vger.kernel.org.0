Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB672AF9FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 21:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgKKUqU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 15:46:20 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:47293 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726890AbgKKUqD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 15:46:03 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 32681A17;
        Wed, 11 Nov 2020 15:40:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 11 Nov 2020 15:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=3tDLBowVRIwdz
        IAbCVfBnGR6mqNvKC6lGI+I9eRGP1c=; b=tgYh9jFINu/CLM52sZOzJ3PyVhFcB
        F+QMBFot3z1lIpdUSlvLbQzmo45w3X3WxHo0YYyFPLnNKR0A9ry0LcwX5q9kmpFr
        tCtdsmx7trFjT6hNAslVM7bRZREBgI0ZXLLoKlGuNwvWar2DXNARDEUrb6I8C2b+
        zCO7P6Syt3VmUa/16Lf2NDPcWD8jqCFXFQJ/93szTG2ceM67gKYLNHNwWoKbvNRg
        OvdXMzCWj7YAwdv1MB/FELN+149Hj0Dx6TQOhdbRYU83WcUQEHOVJ9ObC8MUu4Jr
        xhSm7VUm5AuJVIr8VRud1LTP8M4HqkFKSM4I8mHjxc1fRMn4DrpPR8lLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=3tDLBowVRIwdzIAbCVfBnGR6mqNvKC6lGI+I9eRGP1c=; b=iri+JizH
        HvHd8FyUbpHT/ZkIsS+0/aYycXg8HMpN7EM465b6RmbagT7hC+OD2JMv0D9TYuHi
        03A8jIvoNH5EYIskaQgE8VQR1r/rGKse25soUj42Bg4gcyrgE0ouHwRcGehZMAKs
        N6fzdgqbSzxoXhpcaGB8E4Oq4MBvyZ8uI5iu/uQ3mdtXaoZ9x+7FAySUV4a2KqHh
        lMTz89MH4st/I611ycmkSqyMHem7GMbPiALOIEh6PTuurfZGDO50AtuGRJg6cufi
        nh8MM2fECYHZq1r2tLG/LJlthaAeF24aAnKS3dSsfroq0t2KBxJ66yK4vWURY+VO
        rZDxeuT7JiR3RA==
X-ME-Sender: <xms:SUysX1T35r9ap5HK4Ls0uLafocUuQdLE9FI8COOxQva5xWACguWqvg>
    <xme:SUysX-zi8lhDZ--kZs2pR-YZ2po0w5F6koilXY4sdPuluk0wlHOnm9FeePN7YqV5o
    ifmSz0pD9QHF5Ra7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvtddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedu
    vddrgeeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:SUysX63-OuggDBnfzHq2fxyIitrORgohaj7sbuxwMgfXEIXeeDe3ag>
    <xmx:SUysX9BJTfQylIJWkS1XylXBFnVAwJbZn8Rh8dp45c0hYJywU55s9w>
    <xmx:SUysX-gRPR3wgg7mTjokgneAhL02vCBRnOn3jEqSClEqGG172DlVUQ>
    <xmx:SUysXzbuK5QWM55Gm0Ao7ArGADGLvjvgQy1Pqpu5UUMCeVeL22hmWzWTnVU>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3EDFA3280063;
        Wed, 11 Nov 2020 15:40:41 -0500 (EST)
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
Subject: [RFC PATCH 6/6] mm: huge_memory: enable debugfs to split huge pages to any order.
Date:   Wed, 11 Nov 2020 15:40:08 -0500
Message-Id: <20201111204008.21332-7-zi.yan@sent.com>
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

It is used to test split_huge_page_to_list_to_order for pagecache THPs.
Also add test cases for split_huge_page_to_list_to_order via both
debugfs and truncating a file.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c                              |  13 +--
 .../selftests/vm/split_huge_page_test.c       | 102 +++++++++++++++++-
 2 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 88f50da40c9b..b7470607a08b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2974,7 +2974,7 @@ static ssize_t split_huge_pages_in_range_pid_write(st=
ruct file *file,
 	static DEFINE_MUTEX(mutex);
 	ssize_t ret;
 	char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
-	int pid;
+	int pid, to_order =3D 0;
 	unsigned long vaddr_start, vaddr_end, addr;
 	nodemask_t task_nodes;
 	struct mm_struct *mm;
@@ -2990,8 +2990,9 @@ static ssize_t split_huge_pages_in_range_pid_write(st=
ruct file *file,
 		goto out;
=20
 	input_buf[80] =3D '\0';
-	ret =3D sscanf(input_buf, "%d,%lx,%lx", &pid, &vaddr_start, &vaddr_end);
-	if (ret !=3D 3) {
+	ret =3D sscanf(input_buf, "%d,%lx,%lx,%d", &pid, &vaddr_start, &vaddr_end=
, &to_order);
+	/* cannot split to order-1 THP, which is not possible */
+	if ((ret !=3D 3 && ret !=3D 4) || to_order =3D=3D 1) {
 		ret =3D -EINVAL;
 		goto out;
 	}
@@ -2999,8 +3000,8 @@ static ssize_t split_huge_pages_in_range_pid_write(st=
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
@@ -3038,7 +3039,7 @@ static ssize_t split_huge_pages_in_range_pid_write(st=
ruct file *file,
 		addr +=3D page_size(page) - PAGE_SIZE;
=20
 		/* reset addr if split fails */
-		if (split_huge_page(page))
+		if (split_huge_page_to_list_to_order(page, NULL, to_order))
 			addr -=3D (page_size(page) - PAGE_SIZE);
=20
 		unlock_page(page);
diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/test=
ing/selftests/vm/split_huge_page_test.c
index c8a32ae9e13a..bcbc5a9d327c 100644
--- a/tools/testing/selftests/vm/split_huge_page_test.c
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -16,6 +16,7 @@
 #include <sys/wait.h>
 #include <malloc.h>
 #include <stdbool.h>
+#include <time.h>
=20
 #define PAGE_4KB (4096UL)
 #define PAGE_2MB (512UL*PAGE_4KB)
@@ -31,6 +32,7 @@
=20
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages_in_range_pid"
 #define SMAP_PATH "/proc/self/smaps"
+#define THP_FS_PATH "/mnt/thp_fs"
 #define INPUT_MAX 80
=20
 static int write_file(const char *path, const char *buf, size_t buflen)
@@ -50,13 +52,13 @@ static int write_file(const char *path, const char *buf=
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
-	ret =3D snprintf(input, INPUT_MAX, "%d,%lx,%lx", pid, vaddr_start,
-			vaddr_end);
+	ret =3D snprintf(input, INPUT_MAX, "%d,%lx,%lx,%d", pid, vaddr_start,
+			vaddr_end, order);
 	if (ret >=3D INPUT_MAX) {
 		printf("%s: Debugfs input is too long\n", __func__);
 		exit(EXIT_FAILURE);
@@ -139,7 +141,7 @@ void split_pmd_thp(void)
 	}
=20
 	/* split all possible huge pages */
-	write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page + len);
+	write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page + len, 0);
=20
 	*one_page =3D 0;
=20
@@ -153,9 +155,101 @@ void split_pmd_thp(void)
 	free(one_page);
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
+
+	for (i =3D 0; i < fd_size; i++) {
+		unsigned char byte =3D rand();
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
+}
+
+void split_thp_in_pagecache_to_order(int order)
+{
+	int fd;
+	char *addr;
+	size_t fd_size =3D 2 * PAGE_2MB, i;
+
+	create_pagecache_thp_and_fd(fd_size, &fd, &addr);
+
+	printf("split %ld kB pagecache page to order %d ... ", fd_size >> 10, ord=
er);
+	write_debugfs(getpid(), (uint64_t)addr, (uint64_t)addr + fd_size, order);
+
+	for (i =3D 0; i < fd_size; i++)
+		*(addr + i) =3D (char)i;
+
+	close(fd);
+	printf("done\n");
+}
+
+void truncate_thp_in_pagecache_to_order(int order)
+{
+	int fd;
+	char *addr;
+	size_t fd_size =3D 2 * PAGE_2MB, i;
+
+	create_pagecache_thp_and_fd(fd_size, &fd, &addr);
+
+	printf("truncate %ld kB pagecache page to size %lu kB ... ", fd_size >> 1=
0, 4UL << order);
+	ftruncate(fd, PAGE_4KB << order);
+
+	for (i =3D 0; i < (PAGE_4KB << order); i++)
+		*(addr + i) =3D (char)i;
+
+	close(fd);
+	printf("done\n");
+}
+
 int main(int argc, char **argv)
 {
+	int i;
+
+	if (geteuid() !=3D 0) {
+		printf("Please run the benchmark as root\n");
+		exit(EXIT_FAILURE);
+	}
+
 	split_pmd_thp();
=20
+	for (i =3D 8; i >=3D 0; i--)
+		if (i !=3D 1)
+			split_thp_in_pagecache_to_order(i);
+
+	for (i =3D 8; i >=3D 0; i--)
+		if (i !=3D 1)
+			truncate_thp_in_pagecache_to_order(i);
+
 	return 0;
 }
--=20
2.28.0

