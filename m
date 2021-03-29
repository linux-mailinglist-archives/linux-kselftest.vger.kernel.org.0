Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E924734D424
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Mar 2021 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhC2PkE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Mar 2021 11:40:04 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50825 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230167AbhC2Pjh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Mar 2021 11:39:37 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7F07F58059D;
        Mon, 29 Mar 2021 11:39:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Mar 2021 11:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=B02kY17mfGts1
        USvLJhcoqNJjZkeReodTLssTpl/N5g=; b=Iw4w28g95lN7V/tI8MaqHVxn7i+Z0
        qHMI/Q2kjpVqPA1DKnWj1f11Z0+ctnHkBt/0zTFuxvlyCiOnhHeYvw7vnOJPkHa+
        Zq+HeQHwnfBAjo7g2IKzPvSuOrFgRLS0xFrB869yCJwV+S5auuQJUVPvmo9dL4eE
        lXmYVgh1NjeFRBLlag+oR0ds/fPbcit7mIw9XZnq7EcEm29W5p/ZWN4i8wUckcgA
        iSSqNgzFpUBAe4BAp0FKUBjW2/IYEzKUK8NXgjPfJmlHx9pfT6Ntj8tcocAa6Ekj
        Wr7bCKoDKA/tksY1+ZrswipFHq8EGNhk5ZRXF0a4MOswv6uVykDk/wjzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=B02kY17mfGts1USvLJhcoqNJjZkeReodTLssTpl/N5g=; b=gQzFiKZE
        QKfoJOrJhLc0/KB440VMCjyMo5OVxZpc41SU7WVVMqplm5ZEan5Kf2Qx1oetW4fy
        grZHIYHxL7JvgA44tRbtKyi6m481ezkKhmcoHoHj4VGWXTVpMdKgbTpA3GtKp0n9
        99bAD2gpMU8173F83C/oCwpDYBAWgzQGDvFzXFJKiA0qXGluLK9VSzINMPmgoF+l
        kiTPfkbegYRdn4es+JeUOB9EB62TtGTp8F50NmAZy2ih7f7Ca07kdTG4AC2d5Vx/
        BcaUwfiZkMYil26GsrWuMyFmfWjD6w1Rp5DPKw4+fADPQQDfv+NTGiM2lIQfpbKi
        nwt35YQqbp13Ag==
X-ME-Sender: <xms:t_RhYEcIqFOmLGP2FpcZf2t7zUmQxW-t1I_HT7muaiiZhQ___NrDRQ>
    <xme:t_RhYGNsZRGeHHwu6Im1kxi0ejABKDLsSODsQAitfguFsY0TTzOMLKkoGfhRGOYlq
    n9JxpguM1Rt3Ie3HA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehkedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecukfhppedv
    tdelrdeirdejuddrvddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:t_RhYFhwNESfGdadaIu59bra6jzdoR7khkD3Ebknbd_3ItIzKZVILg>
    <xmx:t_RhYJ9RRk1BOA5IdR1X2q_CrWOGjI9R3k02996jlFZxry3nCE7X3w>
    <xmx:t_RhYAtfHXFTE8w3ZoMWZ6FDXDem8P3hfGCsjL0IXKRVcBSUdZVTxA>
    <xmx:uPRhYBnKlbQxS-EOyPx4TJfzEzq8KfljNKR91RlLvy9geXc0KoV86A>
Received: from Threadripper.local (209-6-71-213.s2259.c3-0.abr-cbr1.sbo-abr.ma.cable.rcncustomer.com [209.6.71.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id 588B6240065;
        Mon, 29 Mar 2021 11:39:35 -0400 (EDT)
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
        David Rientjes <rientjes@google.com>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH v7 2/2] mm: huge_memory: debugfs for file-backed THP split.
Date:   Mon, 29 Mar 2021 11:39:32 -0400
Message-Id: <20210329153932.134510-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329153932.134510-1-zi.yan@sent.com>
References: <20210329153932.134510-1-zi.yan@sent.com>
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
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/huge_memory.c                              | 91 ++++++++++++++++++-
 .../selftests/vm/split_huge_page_test.c       | 81 ++++++++++++++++-
 2 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1bcab247aea8..ca47f5a317f3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3062,6 +3062,66 @@ static int split_huge_pages_pid(int pid, unsigned lo=
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
+	pr_debug("split file-backed THPs in file: %s, offset: [0x%lx - 0x%lx]\n",
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
@@ -3069,7 +3129,8 @@ static ssize_t split_huge_pages_write(struct file *fi=
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
@@ -3084,6 +3145,34 @@ static ssize_t split_huge_pages_write(struct file *f=
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
index 2c0c18e60c57..845a63cdb052 100644
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
@@ -300,6 +309,67 @@ void split_pte_mapped_thp(void)
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
@@ -313,6 +383,7 @@ int main(int argc, char **argv)
=20
 	split_pmd_thp();
 	split_pte_mapped_thp();
+	split_file_backed_thp();
=20
 	return 0;
 }
--=20
2.30.2

