Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68D0350B02
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Apr 2021 01:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhCaXxa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 19:53:30 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:49047 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhCaXxU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 19:53:20 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1CD065808BE;
        Wed, 31 Mar 2021 19:53:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 31 Mar 2021 19:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=aMTk12SYydQOR
        4tVPSaMqQA7+l6NP8cZ1IKoESLTZ5c=; b=g40iLeBK22TFPo//FglIhNO8KC3d5
        CZ71TU9Er896OAlZ7CS78CwqtytEBRyiW4vdRDHFQbX7oNEtabBSuMwMZ5JBlaVj
        H8TjJjpRLcxvStFx7/OnPJ7Er8awYyOqASZQkda0AOXOWMujdSdmoCrv2tbvYvdR
        jRLz8YWCrTxurIwn4SKYIisankV94UGfPxxzdklqiQaYtXoRKds6HpihV0x2/jPu
        4wEUYTinEq0CaduiufHxNQ5bhGclkyjNqKoCMoWu2wMySCq0lKQ8evpyxos7jdNc
        /+7skB0FUqSe5+JBkWp7yhWPlycyGOmrk9q+wwM5X+G5CaiVCJezg0lCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=aMTk12SYydQOR4tVPSaMqQA7+l6NP8cZ1IKoESLTZ5c=; b=qCZVd6hq
        niY4gsQRO4A202gSiCGXFBQVwidCw4jEWVzvLXcfeuzY6aK1btNKJUxgSbD99555
        G8rC8fVTcM+mJV5mhDRbQrCWHDZk4DVs4UoCtQ7qjINvAPmwWa4f7P5s4bpe/afe
        QoM2SoYZu9aWmUSkNNi5akc8zdt7PNqKL45jCnsC27j6wxhvdVwD/P9lfdnDdFEy
        m4W+/pUsC0AOhIRlL6dTDPr39t1y9uOecddMxyOfgQFSdVQHBg77Lgv9Kw+h3R0a
        +uqWMIaU8sEwxkrQDEuEkrE92zJFTYJj5Dkf6OGMOxvG7mY8XnroPq44HDM8N7et
        SkkIwQCgzY/eBQ==
X-ME-Sender: <xms:bwtlYPpg8Ixkuw1pqq8duQZ0xa3-8GlMLI7hi3Yyd3FHzOezS6xQtA>
    <xme:bwtlYJoC6HMwArHROunc0Ov5dFMRgCB0zOQvOoUdyVvqY8bOAXjBBhUyoaT6OawBw
    wBS3J1tR6wzY0LgHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeifedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppeeh
    gedrudeiiedrudehledrvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:bwtlYMPPd7V4xXVxIDVXw1-sSTskVbY1FAnal4cdSDL3M746uLl7Vg>
    <xmx:bwtlYC4UVM_3fKVsJYbjKsCR3lwke-D5pPikZ1nkkDJx1PHWxqZDNg>
    <xmx:bwtlYO6vmYsYvgpGaeE_lt4p3Lk4sg_3ioE_sQqy_ZvY5pZ8CwwVDA>
    <xmx:cAtlYGjly9O2cK0WiB0pQxtJNqP6Sv9y7RAfMSl_07R4Cd1HOTeO_g>
Received: from Threadripper.local (ec2-54-166-159-27.compute-1.amazonaws.com [54.166.159.27])
        by mail.messagingengine.com (Postfix) with ESMTPA id C1D4024005B;
        Wed, 31 Mar 2021 19:53:18 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Mika Penttila <mika.penttila@nextfour.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH v8 2/2] mm: huge_memory: debugfs for file-backed THP split.
Date:   Wed, 31 Mar 2021 19:53:09 -0400
Message-Id: <20210331235309.332292-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331235309.332292-1-zi.yan@sent.com>
References: <20210331235309.332292-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Further extend <debugfs>/split_huge_pages to accept
"<path>,<pgoff_start>,<pgoff_end>" for file-backed THP split tests since
tmpfs may have file backed by THP that mapped nowhere.

Update selftest program to test file-backed THP split too.

Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/huge_memory.c                              | 90 ++++++++++++++++++-
 .../selftests/vm/split_huge_page_test.c       | 82 +++++++++++++++--
 2 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1bcab247aea8..eb0f3aaf49f1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3062,6 +3062,65 @@ static int split_huge_pages_pid(int pid, unsigned lo=
ng vaddr_start,
 	return ret;
 }
=20
+static int split_huge_pages_in_file(const char *file_path, pgoff_t off_sta=
rt,
+				pgoff_t off_end)
+{
+	struct filename *file;
+	struct file *candidate;
+	struct address_space *mapping;
+	int ret =3D -EINVAL;
+	pgoff_t index;
+	int nr_pages =3D 1;
+	unsigned long total =3D 0, split =3D 0;
+
+	file =3D getname_kernel(file_path);
+	if (IS_ERR(file))
+		return ret;
+
+	candidate =3D file_open_name(file, O_RDONLY, 0);
+	if (IS_ERR(candidate))
+		goto out;
+
+	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0x%lx=
]\n",
+		 file_path, off_start, off_end);
+
+	mapping =3D candidate->f_mapping;
+
+	for (index =3D off_start; index < off_end; index +=3D nr_pages) {
+		struct page *fpage =3D pagecache_get_page(mapping, index,
+						FGP_ENTRY | FGP_HEAD, 0);
+
+		nr_pages =3D 1;
+		if (xa_is_value(fpage) || !fpage)
+			continue;
+
+		if (!is_transparent_hugepage(fpage))
+			goto next;
+
+		total++;
+		nr_pages =3D thp_nr_pages(fpage);
+
+		if (!trylock_page(fpage))
+			goto next;
+
+		if (!split_huge_page(fpage))
+			split++;
+
+		unlock_page(fpage);
+next:
+		put_page(fpage);
+		cond_resched();
+	}
+
+	filp_close(candidate, NULL);
+	ret =3D 0;
+
+	pr_debug("%lu of %lu file-backed THP split\n", split, total);
+out:
+	putname(file);
+	return ret;
+}
+
 #define MAX_INPUT_BUF_SZ 255
=20
 static ssize_t split_huge_pages_write(struct file *file, const char __user=
 *buf,
@@ -3069,7 +3128,8 @@ static ssize_t split_huge_pages_write(struct file *fi=
le, const char __user *buf,
 {
 	static DEFINE_MUTEX(split_debug_mutex);
 	ssize_t ret;
-	char input_buf[MAX_INPUT_BUF_SZ]; /* hold pid, start_vaddr, end_vaddr */
+	/* hold pid, start_vaddr, end_vaddr or file_path, off_start, off_end */
+	char input_buf[MAX_INPUT_BUF_SZ];
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
=20
@@ -3084,6 +3144,34 @@ static ssize_t split_huge_pages_write(struct file *f=
ile, const char __user *buf,
 		goto out;
=20
 	input_buf[MAX_INPUT_BUF_SZ - 1] =3D '\0';
+
+	if (input_buf[0] =3D=3D '/') {
+		char *tok;
+		char *buf =3D input_buf;
+		char file_path[MAX_INPUT_BUF_SZ];
+		pgoff_t off_start =3D 0, off_end =3D 0;
+		size_t input_len =3D strlen(input_buf);
+
+		tok =3D strsep(&buf, ",");
+		if (tok) {
+			strncpy(file_path, tok, MAX_INPUT_BUF_SZ);
+		} else {
+			ret =3D -EINVAL;
+			goto out;
+		}
+
+		ret =3D sscanf(buf, "0x%lx,0x%lx", &off_start, &off_end);
+		if (ret !=3D 2) {
+			ret =3D -EINVAL;
+			goto out;
+		}
+		ret =3D split_huge_pages_in_file(file_path, off_start, off_end);
+		if (!ret)
+			ret =3D input_len;
+
+		goto out;
+	}
+
 	ret =3D sscanf(input_buf, "%d,0x%lx,0x%lx", &pid, &vaddr_start, &vaddr_en=
d);
 	if (ret =3D=3D 1 && pid =3D=3D 1) {
 		split_huge_pages_all();
diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/test=
ing/selftests/vm/split_huge_page_test.c
index 2c0c18e60c57..1af16d2c2a0a 100644
--- a/tools/testing/selftests/vm/split_huge_page_test.c
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -7,11 +7,13 @@
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include <unistd.h>
 #include <inttypes.h>
 #include <string.h>
 #include <fcntl.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 #include <malloc.h>
 #include <stdbool.h>
=20
@@ -24,6 +26,9 @@ uint64_t pmd_pagesize;
 #define SMAP_PATH "/proc/self/smaps"
 #define INPUT_MAX 80
=20
+#define PID_FMT "%d,0x%lx,0x%lx"
+#define PATH_FMT "%s,0x%lx,0x%lx"
+
 #define PFN_MASK     ((1UL<<55)-1)
 #define KPF_THP      (1UL<<22)
=20
@@ -87,13 +92,16 @@ static int write_file(const char *path, const char *buf=
, size_t buflen)
 	return (unsigned int) numwritten;
 }
=20
-static void write_debugfs(int pid, uint64_t vaddr_start, uint64_t vaddr_en=
d)
+static void write_debugfs(const char *fmt, ...)
 {
 	char input[INPUT_MAX];
 	int ret;
+	va_list argp;
+
+	va_start(argp, fmt);
+	ret =3D vsnprintf(input, INPUT_MAX, fmt, argp);
+	va_end(argp);
=20
-	ret =3D snprintf(input, INPUT_MAX, "%d,0x%lx,0x%lx", pid, vaddr_start,
-			vaddr_end);
 	if (ret >=3D INPUT_MAX) {
 		printf("%s: Debugfs input is too long\n", __func__);
 		exit(EXIT_FAILURE);
@@ -183,7 +191,8 @@ void split_pmd_thp(void)
 	}
=20
 	/* split all THPs */
-	write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page + len);
+	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
+		(uint64_t)one_page + len);
=20
 	for (i =3D 0; i < len; i++)
 		if (one_page[i] !=3D (char)i) {
@@ -274,7 +283,7 @@ void split_pte_mapped_thp(void)
 	}
=20
 	/* split all remapped THPs */
-	write_debugfs(getpid(), (uint64_t)pte_mapped,
+	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
 		      (uint64_t)pte_mapped + pagesize * 4);
=20
 	/* smap does not show THPs after mremap, use kpageflags instead */
@@ -300,6 +309,68 @@ void split_pte_mapped_thp(void)
 	close(kpageflags_fd);
 }
=20
+void split_file_backed_thp(void)
+{
+	int status;
+	int fd;
+	ssize_t num_written;
+	char tmpfs_template[] =3D "/tmp/thp_split_XXXXXX";
+	const char *tmpfs_loc =3D mkdtemp(tmpfs_template);
+	char testfile[INPUT_MAX];
+	uint64_t pgoff_start =3D 0, pgoff_end =3D 1024;
+
+	printf("Please enable pr_debug in split_huge_pages_in_file() if you need =
more info.\n");
+
+	status =3D mount("tmpfs", tmpfs_loc, "tmpfs", 0, "huge=3Dalways,size=3D4m=
");
+
+	if (status) {
+		printf("Unable to create a tmpfs for testing\n");
+		exit(EXIT_FAILURE);
+	}
+
+	status =3D snprintf(testfile, INPUT_MAX, "%s/thp_file", tmpfs_loc);
+	if (status >=3D INPUT_MAX) {
+		printf("Fail to create file-backed THP split testing file\n");
+		goto cleanup;
+	}
+
+	fd =3D open(testfile, O_CREAT|O_WRONLY);
+	if (fd =3D=3D -1) {
+		perror("Cannot open testing file\n");
+		goto cleanup;
+	}
+
+	/* write something to the file, so a file-backed THP can be allocated */
+	num_written =3D write(fd, tmpfs_loc, sizeof(tmpfs_loc));
+	close(fd);
+
+	if (num_written < 1) {
+		printf("Fail to write data to testing file\n");
+		goto cleanup;
+	}
+
+	/* split the file-backed THP */
+	write_debugfs(PATH_FMT, testfile, pgoff_start, pgoff_end);
+
+	status =3D unlink(testfile);
+	if (status)
+		perror("Cannot remove testing file\n");
+
+cleanup:
+	status =3D umount(tmpfs_loc);
+	if (status) {
+		printf("Unable to umount %s\n", tmpfs_loc);
+		exit(EXIT_FAILURE);
+	}
+	status =3D rmdir(tmpfs_loc);
+	if (status) {
+		perror("cannot remove tmp dir");
+		exit(EXIT_FAILURE);
+	}
+
+	printf("file-backed THP split test done, please check dmesg for more info=
rmation\n");
+}
+
 int main(int argc, char **argv)
 {
 	if (geteuid() !=3D 0) {
@@ -313,6 +384,7 @@ int main(int argc, char **argv)
=20
 	split_pmd_thp();
 	split_pte_mapped_thp();
+	split_file_backed_thp();
=20
 	return 0;
 }
--=20
2.30.2

