Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD33B33C7C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Mar 2021 21:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhCOUeh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Mar 2021 16:34:37 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:51473 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232326AbhCOUeP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Mar 2021 16:34:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 455CB58085D;
        Mon, 15 Mar 2021 16:34:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Mar 2021 16:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=Ju/qJPEIt+hVK
        sU4F7gHNCQi+tcKnZ6rDQLg3bCv5zc=; b=AIASMqpMUWvL0EYtTM33P9sZILhQY
        xNeNVaLYJJx8CqcXUf4lCWZ6MPteXlgLX+wAOU0e0UEv59ru/MTLUsm2xUTA5qSM
        LgaT/E9lIRusKIKDmJVquwaFfuZp+m6l0fTvaiC6prETpUxSvLGpRkkzqRFlF4pz
        5dTFdhkuT44hIk6ln8oDR5JSQ8uPBH5dvkNWWmg7Iv2Bm9MdS0pH1Mvg0FB4MqJC
        ylAHGUlDBuV/Hr9lSAUhAFac5PrFo5MvzAP+sYT24ZDNtyEV5FKK7OgXfaerhSSZ
        aIM4A5n1+/voNPweakElhGKGDtUsboYww4+5XdAx7sRN+GM0bjzUV/xuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Ju/qJPEIt+hVKsU4F7gHNCQi+tcKnZ6rDQLg3bCv5zc=; b=ZmQyqQvm
        nG6DeNc9N27vY+RVWq4yCF1IHOMiFQadKPRgHcHWXXS8gwnBhStkEfJwfyfA+Zts
        ztbBu0K4Jq61LdzBoyG1jBaGGdy1PlyED3uTgUFgyipBhr9lJt/+3xD23V51UmZw
        Q6pnNYC+YSfbAM8q6m94JRTsgTGYYDjUhseRsiPYQdBXFj25r/JYemJcy3DjcrH/
        rGuwIUN36dIFvjBHEsw8OBZNXUdXkaP3xRIctSMzf4moQ/0QgIX95TgRloyLuEHn
        ya3ivmKJ5gCZfYjKmPQlnmhNktAa3ri1PAzXjK2cjUQaxgkjithRYitkNws1eMHW
        LaKJAFsXvf33Jg==
X-ME-Sender: <xms:xcRPYLN8iVO8IC_9JKWqQMEhK7lMC6td_S7Ktuq8yW6Ih3n3hfahMQ>
    <xme:xcRPYM-qxanLrU4ZKr59MkjkT2cI-m7RtZTdpqmRP_-R1tWKi-tiL0ZCTihAoXs5H
    6Y8A6zeRSZe0pBHBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeije
    euvdeuudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucfkphep
    vddtledriedrjedurddvudefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:xcRPYPTBXUcbqdZOhiZzuuuTC2sQk67JtbIxGGvYws_xXPosyFFlMA>
    <xmx:xcRPYOnaPN3k7ejEPUTwMjy2tT59rlnBa7cZE9ZrmvjdVlIMcgs_lw>
    <xmx:xcRPYPTAo2me94oEqgfk8HG4A1FOkXX5f0Xtr1BTWaY0DWwwauaqpg>
    <xmx:xsRPYKPg0MSybVeLdK4P1zPL-M_awkr4alg5qXqqZNDcPAyo65ml7A>
Received: from Threadripper.local (209-6-71-213.s2259.c3-0.abr-cbr1.sbo-abr.ma.cable.rcncustomer.com [209.6.71.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id D16431080068;
        Mon, 15 Mar 2021 16:34:12 -0400 (EDT)
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
Subject: [PATCH v4 2/2] mm: huge_memory: debugfs for file-backed THP split.
Date:   Mon, 15 Mar 2021 16:33:49 -0400
Message-Id: <20210315203349.171760-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315203349.171760-1-zi.yan@sent.com>
References: <20210315203349.171760-1-zi.yan@sent.com>
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
 mm/huge_memory.c                              | 95 ++++++++++++++++++-
 .../selftests/vm/split_huge_page_test.c       | 79 ++++++++++++++-
 2 files changed, 166 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3bfee54e2cd0..da91ee97d944 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3043,12 +3043,72 @@ static int split_huge_pages_pid(int pid, unsigned l=
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
 static ssize_t split_huge_pages_write(struct file *file, const char __user=
 *buf,
 				size_t count, loff_t *ppops)
 {
 	static DEFINE_MUTEX(mutex);
 	ssize_t ret;
-	char input_buf[80]; /* hold pid, start_vaddr, end_vaddr */
+	/* hold pid, start_vaddr, end_vaddr or file_path, off_start, off_end */
+	char input_buf[MAX_INPUT];
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
=20
@@ -3058,11 +3118,40 @@ static ssize_t split_huge_pages_write(struct file *=
file, const char __user *buf,
=20
 	ret =3D -EFAULT;
=20
-	memset(input_buf, 0, 80);
+	memset(input_buf, 0, MAX_INPUT);
 	if (copy_from_user(input_buf, buf, min_t(size_t, count, 80)))
 		goto out;
=20
-	input_buf[79] =3D '\0';
+	input_buf[MAX_INPUT - 1] =3D '\0';
+
+	if (input_buf[0] =3D=3D '/') {
+		char *tok;
+		char *buf =3D input_buf;
+		char file_path[MAX_INPUT];
+		pgoff_t off_start =3D 0, off_end =3D 0;
+		size_t input_len =3D strlen(input_buf);
+
+		tok =3D strsep(&buf, ",");
+		if (tok) {
+			strncpy(file_path, tok, MAX_INPUT);
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
index 9f33ddbb3182..0202702f7eda 100644
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
@@ -178,7 +186,8 @@ void split_pmd_thp(void)
 	}
=20
 	/* split all THPs */
-	write_debugfs(getpid(), (uint64_t)one_page, (uint64_t)one_page + len);
+	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
+		(uint64_t)one_page + len);
=20
 	for (i =3D 0; i < len; i++)
 		if (one_page[i] !=3D (char)i) {
@@ -269,7 +278,7 @@ void split_pte_mapped_thp(void)
 	}
=20
 	/* split all remapped THPs */
-	write_debugfs(getpid(), (uint64_t)pte_mapped,
+	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
 		      (uint64_t)pte_mapped + pagesize * 4);
=20
 	/* smap does not show THPs after mremap, use kpageflags instead */
@@ -295,6 +304,65 @@ void split_pte_mapped_thp(void)
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
@@ -308,6 +376,7 @@ int main(int argc, char **argv)
=20
 	split_pmd_thp();
 	split_pte_mapped_thp();
+	split_file_backed_thp();
=20
 	return 0;
 }
--=20
2.30.1

