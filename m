Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B86D3411A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 01:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhCSAwc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Mar 2021 20:52:32 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51339 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231892AbhCSAw2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Mar 2021 20:52:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id BC08C58089E;
        Thu, 18 Mar 2021 20:52:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 18 Mar 2021 20:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=pSnbBxOun2OMD
        hTC4+cbBE7aLYGsc8mCmhE9/gavhzg=; b=ond98dxUTO6pQfdquxnO35Z1ie1gi
        LEaE5lMhB7rZXVVPrHhgVPSwJnJDD93/ye7+OV6CNJwsZFhfWj8nBkpZFPa37+df
        loeomj/SKBjSyt7IDafDJdkXuDunTtLtclNFd5PtbIccOWN8k23eD2ASYLYlLJz4
        /ozkULMxF/RDdg+T6AKr766rhMs4gNIV5K6dKFNMJ6iqmZqchUi9B+UkkAWvoSWm
        AVj+x/BFYRVU88qJrm1Hv8QdY684jp4RZ71tfwIRn/Na7bixrehwa6NH67lsvVQR
        8jmE5bQ6zSeGL4Qso7iDxdS03mV6++FWeS7xG5sa1RrPUiRBFsE2nqK4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=pSnbBxOun2OMDhTC4+cbBE7aLYGsc8mCmhE9/gavhzg=; b=vAiESObS
        A7mPUEsbW2kIlbDmzNkDk67Ub8gnnFGjb4xwSulGguoTcewlv/xYk+cQQs2bmhJt
        dEyUSiEh/sRNSn7LHVwzcMuIcTF1zb10GCiQ7tRm7DiW2vNYAvpalmJHoR9s6pPp
        F3UHLykxDpit67SYFxJJLjCZqHgqMOv/lx6GKR2Jivz4RiQPY324iBA/ogFBHppV
        k3N6g4MBh+8MbprDuLX5Pf+AWmG7kCbNn2GhPlHLodYT8c+gWGh0OESgICav/NGs
        r1Nrh0FIVAHdN/M9NWpjSpKTn0BmvgBPcRlIyVY0LCLpWvX1LDiIEkeEl1yAF5ul
        UuLCQ+cEDuATZg==
X-ME-Sender: <xms:y_VTYOpk1vfAihfvMpbuQLNuI3aO94EbrJGBQPYvg7Mc5FObKQdTPQ>
    <xme:y_VTYMpPoWDvVRlUcRjOFcQEEQ7wTDF99ah0JN5uSDd8gJ8uj7vB7AxowFzROgxT5
    u9G4f_GTT2BZHU-sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefjedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedv
    tdelrdeirdejuddrvddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:y_VTYDPN9sPA0-JgavcEw4c4TQEij_DNxSvWm2d-jlc1S8J-tNdaog>
    <xmx:y_VTYN6cWNaz2zjjw73UhiczAGI3oBineAoure3Mk1oXkt3j5-mx9Q>
    <xmx:y_VTYN4Clj0MAjKAICMxQ0i5NR31KVq0dJPyHxDKvVLF1RTAXjRAmg>
    <xmx:y_VTYCGxZo-PG8laBNA-FIFgpXlt9NpXZczfKmKfZ5BRsWiUPqaEcA>
Received: from Threadripper.local (209-6-71-213.s2259.c3-0.abr-cbr1.sbo-abr.ma.cable.rcncustomer.com [209.6.71.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id C126924005A;
        Thu, 18 Mar 2021 20:52:26 -0400 (EDT)
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
Subject: [PATCH v5 2/2] mm: huge_memory: debugfs for file-backed THP split.
Date:   Thu, 18 Mar 2021 20:52:19 -0400
Message-Id: <20210319005219.13595-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319005219.13595-1-zi.yan@sent.com>
References: <20210319005219.13595-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Further extend <debugfs>/split_huge_pages to accept
"<path>,<off_start>,<off_end>" for file-backed THP split tests since
tmpfs may have file backed by THP that mapped nowhere.

Update selftest program to test file-backed THP split too.

Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c                              | 97 ++++++++++++++++++-
 .../selftests/vm/split_huge_page_test.c       | 79 ++++++++++++++-
 2 files changed, 168 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9bf9bc489228..6d6537cc8c56 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3049,12 +3049,74 @@ static int split_huge_pages_pid(int pid, unsigned l=
ong vaddr_start,
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
+	pgoff_t off_cur;
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
+	pr_info("split file-backed THPs in file: %s, offset: [0x%lx - 0x%lx]\n",
+		 file_path, off_start, off_end);
+
+	mapping =3D candidate->f_mapping;
+
+	for (off_cur =3D off_start; off_cur < off_end;) {
+		struct page *fpage =3D pagecache_get_page(mapping, off_cur,
+						FGP_ENTRY | FGP_HEAD, 0);
+
+		if (xa_is_value(fpage) || !fpage) {
+			off_cur +=3D PAGE_SIZE;
+			continue;
+		}
+
+		if (!is_transparent_hugepage(fpage)) {
+			off_cur +=3D PAGE_SIZE;
+			goto next;
+		}
+		total++;
+		off_cur =3D fpage->index + thp_size(fpage);
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
+	}
+
+	filp_close(candidate, NULL);
+	ret =3D 0;
+
+	pr_info("%lu of %lu file-backed THP split\n", split, total);
+out:
+	putname(file);
+	return ret;
+}
+
+#define MAX_INPUT_BUF_SZ 255
+
 static ssize_t split_huge_pages_write(struct file *file, const char __user=
 *buf,
 				size_t count, loff_t *ppops)
 {
 	static DEFINE_MUTEX(split_debug_mutex);
 	ssize_t ret;
-	char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
+	/* hold pid, start_vaddr, end_vaddr or file_path, off_start, off_end */
+	char input_buf[MAX_INPUT_BUF_SZ];
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
=20
@@ -3064,11 +3126,40 @@ static ssize_t split_huge_pages_write(struct file *=
file, const char __user *buf,
=20
 	ret =3D -EFAULT;
=20
-	memset(input_buf, 0, 80);
+	memset(input_buf, 0, MAX_INPUT_BUF_SZ);
 	if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
 		goto out;
=20
-	input_buf[79] =3D '\0';
+	input_buf[MAX_INPUT_BUF_SZ - 1] =3D '\0';
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
+			pr_info("ret: %ld\n", ret);
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
index 2c0c18e60c57..ebdf2d738978 100644
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
@@ -300,6 +309,65 @@ void split_pte_mapped_thp(void)
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
+	write_debugfs(PATH_FMT, testfile, 0, 1024);
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
@@ -313,6 +381,7 @@ int main(int argc, char **argv)
=20
 	split_pmd_thp();
 	split_pte_mapped_thp();
+	split_file_backed_thp();
=20
 	return 0;
 }
--=20
2.30.2

