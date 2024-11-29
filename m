Return-Path: <linux-kselftest+bounces-22149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67069D0042
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 19:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DB2284909
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 18:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F161B982E;
	Sat, 16 Nov 2024 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="ZgeRCMC7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B32D1AE009
	for <linux-kselftest@vger.kernel.org>; Sat, 16 Nov 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731779977; cv=none; b=kpnbhz+4+Q0kEeY8dbeC0y+SUDVf3YoDwyBRaQKSjGvClQOC5sX8sGlL6QkY9HpApKQAadzfrMpuMxqzQqeY4K/FWP9cEmz+o/zmqYl3FDphF926POuQxgKTbfpvXblM9QZA9WNPQ6SvWgjZ0SAYjVHkaftnl7aCcH3dSNXyjog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731779977; c=relaxed/simple;
	bh=gIzFSiC//DiZiq0wL/Iq55LMoM2qIz6dlYeRUHR7b/g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mp01pVOKTbeq1WSkpXHsOur9MZogRkHtyLf2EgqPZfCt9QsaHkV50uZ9roZpOEI95SAKCiUdl2eUSRBoZQV29U6xS0Gk4W1pfgYVbu1WDDy7JO0Z+JhNvNjcT9TcXNtpSOPrtCQR4D9Uime/gep1g/iFnWYhYFUVhTX3Ivyjc0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=ZgeRCMC7; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b1b224f6c6so55967085a.3
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Nov 2024 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731779973; x=1732384773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QG3SRrOSiFJ9NPWhEP5q+JEDCSQKlJpYQw3cIJlKt/Q=;
        b=ZgeRCMC7Yv1S/YrwdzUPBMMtkhDkkVcUTKHxBef23QKdACOwvWbppCyns0gq5htATT
         gzVxOpFrVyWAAx3zdCxlQrV3LLmZUShQr+4g8VE4y4FuCcqDLWqgDWD0BrYhdHQdKBtQ
         oCk8tA9DyqsvIWb3J/IJWQPuWXXraId1jeCz2HcqXXQnmhpYVXYlQVf5a7EG3PBdtvRM
         3GC09fVi8XQsXPMwUffMWpNiBCA7HdCcP5jwvgVHLgIVyTmB8Jsbmwd0ZATHe3C+GA44
         sjAVX8afts0EwFp4Dxy8bIPwaKML392EgpwDoWhM7oJHzcV3QIMwtax0Zibk1jyg1VIk
         zHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731779973; x=1732384773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QG3SRrOSiFJ9NPWhEP5q+JEDCSQKlJpYQw3cIJlKt/Q=;
        b=PKCpJlS5Ji5K8wjFTl2UHrpXz1pYfueANmD4UtwuoGOzblbMxrTmqvMDhjXbrDqbYW
         8EbVAszgSueourr8sCFhcHlsUsIZLiO+Jt6CxjHuz4/W2uK3O1IZNpDQd+1xfZsKPggN
         Xp+TwKk48mkpLJR2h3FQQecbGno6r5qL4mX2XBdVH4h290vtv0HhZhaPlwmCqbHWrb0r
         OdGbpgik9u9Ca79YyPZCcAcHZFqOkLjtCMdiYqofKukkA6y0qAYxpVk6pyUWMievbVCO
         h8FacdLopw7CJL8Uwc/92VGJSwp7guZq1cWoPMPB7BynU9pDxqXgJ3lRzC6HJlqISPyk
         UNzg==
X-Forwarded-Encrypted: i=1; AJvYcCWm8XK6WrQL97h9TDEgRYJJm2JojFmZzyQ6/KqjBgopWB7rp0gJF+QYUpDgMzwYFCSnpBxyBj0DnbTf3PTiErg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwehuFqWJ00VtNt+z7HU5eoZ6zqNfnJIax2ZtVSND/QaoP/nSbS
	O9uTlLb46w/sLrFpTgYeHrFBdyEGOZY27tcuXHy6koxbnw3djgtS+TOaOWs9ba4=
X-Google-Smtp-Source: AGHT+IGVCl6rH2CJUvmAwSg/6gzKEwfvGbuKVgBlp4JYH/2BQo3mFCfAA8mR+IzxB5NHlDV6V4Jxiw==
X-Received: by 2002:a05:620a:4625:b0:7b1:43e2:712b with SMTP id af79cd13be357-7b3622c6430mr1076751285a.11.1731779973279;
        Sat, 16 Nov 2024 09:59:33 -0800 (PST)
Received: from soleen.c.googlers.com.com (51.57.86.34.bc.googleusercontent.com. [34.86.57.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca309d6sm280530085a.94.2024.11.16.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 09:59:32 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	derek.kiernan@amd.com,
	dragan.cvetic@amd.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	shuah@kernel.org,
	vegard.nossum@oracle.com,
	vattunuru@marvell.com,
	schalla@marvell.com,
	david@redhat.com,
	willy@infradead.org,
	osalvador@suse.de,
	usama.anjum@collabora.com,
	andrii@kernel.org,
	ryan.roberts@arm.com,
	peterx@redhat.com,
	oleg@redhat.com,
	tandersen@netflix.com,
	rientjes@google.com,
	gthelen@google.com
Subject: [RFCv1 6/6] selftests/page_detective: Introduce self tests for Page Detective
Date: Sat, 16 Nov 2024 17:59:22 +0000
Message-ID: <20241116175922.3265872-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add self tests for Page Detective, it contains testing of several memory
types, and also some negative/bad input tests.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/page_detective/.gitignore       |   1 +
 .../testing/selftests/page_detective/Makefile |   7 +
 tools/testing/selftests/page_detective/config |   4 +
 .../page_detective/page_detective_test.c      | 727 ++++++++++++++++++
 6 files changed, 741 insertions(+)
 create mode 100644 tools/testing/selftests/page_detective/.gitignore
 create mode 100644 tools/testing/selftests/page_detective/Makefile
 create mode 100644 tools/testing/selftests/page_detective/config
 create mode 100644 tools/testing/selftests/page_detective/page_detective_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 654d4650670d..ec09b28776b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17456,6 +17456,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/misc-devices/page_detective.rst
 F:	drivers/misc/page_detective.c
+F:	tools/testing/selftests/page_detective/
 
 PAGE POOL
 M:	Jesper Dangaard Brouer <hawk@kernel.org>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 363d031a16f7..9c828025fdfa 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -72,6 +72,7 @@ TARGETS += net/packetdrill
 TARGETS += net/rds
 TARGETS += net/tcp_ao
 TARGETS += nsfs
+TARGETS += page_detective
 TARGETS += perf_events
 TARGETS += pidfd
 TARGETS += pid_namespace
diff --git a/tools/testing/selftests/page_detective/.gitignore b/tools/testing/selftests/page_detective/.gitignore
new file mode 100644
index 000000000000..21a78bee7b4a
--- /dev/null
+++ b/tools/testing/selftests/page_detective/.gitignore
@@ -0,0 +1 @@
+page_detective_test
diff --git a/tools/testing/selftests/page_detective/Makefile b/tools/testing/selftests/page_detective/Makefile
new file mode 100644
index 000000000000..43c4dccb6a13
--- /dev/null
+++ b/tools/testing/selftests/page_detective/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -g -Wall
+
+TEST_GEN_PROGS := page_detective_test
+
+include ../lib.mk
+
diff --git a/tools/testing/selftests/page_detective/config b/tools/testing/selftests/page_detective/config
new file mode 100644
index 000000000000..ddfeed4ddf13
--- /dev/null
+++ b/tools/testing/selftests/page_detective/config
@@ -0,0 +1,4 @@
+CONFIG_PAGE_TABLE_CHECK=y
+CONFIG_MEMCG=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_PAGE_DETECTIVE=y
diff --git a/tools/testing/selftests/page_detective/page_detective_test.c b/tools/testing/selftests/page_detective/page_detective_test.c
new file mode 100644
index 000000000000..f86cf0fdd8fc
--- /dev/null
+++ b/tools/testing/selftests/page_detective/page_detective_test.c
@@ -0,0 +1,727 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+#include <time.h>
+#include <sys/mman.h>
+#include <alloca.h>
+#include "../kselftest.h"
+
+#define OPT_STR "hpvaAsnHtbBS"
+#define HELP_STR							\
+"Usage: %s [-h] [-p] [-v] [-a] [-A] [-s] [-n] [-H] [-t] [-b] [-S]\n"	\
+"-h\tshow this help\n"							\
+"Interfaces:\n"								\
+"-p\tphysical address page detective interface\n"			\
+"-v\tvirtual address page detective  interface\n"			\
+"Tests:\n"								\
+"-a\ttest anonymous page\n"						\
+"-A\ttest anonymous huge page\n"					\
+"-s\ttest anonymous shared page\n"					\
+"-n\ttest named shared page\n"						\
+"-H\ttest HugeTLB shared page\n"					\
+"-t\ttest tmpfs page\n"							\
+"-b\ttest bad/fail input cases\n"					\
+"-S\ttest stack page\n"							\
+"If no arguments specified all tests are performed\n"			\
+
+#define FIRST_LINE_PREFIX	"Page Detective: Investigating "
+#define LAST_LINE_PREFIX	"Page Detective: Finished investigation of "
+
+#define TMP_FILE		"/tmp/page_detective_test.out"
+
+#define NR_HUGEPAGES		"/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages"
+
+#define NANO			1000000000ul
+#define MICRO			1000000ul
+#define MILLI			1000ul
+#define BIT(nr)			(UL(1) << (nr))
+
+#define ARG_INTERFACE_PHYS	BIT(0)
+#define ARG_INTERFACE_VIRT	BIT(1)
+
+#define ARG_TEST_ANON		BIT(2)
+#define ARG_TEST_ANON_HUGE	BIT(3)
+#define ARG_TEST_ANON_SHARED	BIT(4)
+#define ARG_TEST_NAMED_SHARED	BIT(5)
+#define ARG_TEST_HUGETLB_SHARED	BIT(6)
+#define ARG_TEST_TMPFS		BIT(7)
+#define ARG_TEST_FAIL_CASES	BIT(8)
+#define ARG_TEST_STACK		BIT(9)
+
+#define ARG_DEFAULT		(~0)		/* Run verything by default */
+
+#define ARG_INTERFACE_MASK	(ARG_INTERFACE_PHYS | ARG_INTERFACE_VIRT)
+#define ARG_TEST_MASK		(~ARG_INTERFACE_MASK)
+
+#define INTERFACE_NAME(in) (((in) == ARG_INTERFACE_PHYS) ?		\
+	"/sys/kernel/debug/page_detective/phys" :			\
+	"/sys/kernel/debug/page_detective/virt")
+
+#define PAGE_SIZE		((unsigned long)sysconf(_SC_PAGESIZE))
+#define HUGE_PAGE_SIZE		(PAGE_SIZE * PAGE_SIZE / sizeof(uint64_t))
+
+#ifndef MAP_HUGE_2MB
+#define MAP_HUGE_2MB		(21 << MAP_HUGE_SHIFT)
+#endif
+
+#ifndef MFD_HUGEPAGE
+#define MFD_HUGEPAGE (MFD_GOOGLE_SPECIFIC_BASE << 0)
+#endif
+
+#ifndef MFD_GOOGLE_SPECIFIC_BASE
+#define MFD_GOOGLE_SPECIFIC_BASE 0x0200U
+#endif
+
+static int old_dmesg;
+
+static uint64_t virt_to_phys(uint64_t virt, uint64_t *physp)
+{
+	uint64_t tbloff, offset, tblen, pfn;
+	int fd, nr;
+
+	fd = open("/proc/self/pagemap", O_RDONLY);
+	if (fd < 0) {
+		ksft_print_msg("%s open(/proc/self/pagemap): %s\n", __func__,
+			       strerror(errno));
+		return 1;
+	}
+
+	/* see: Documentation/admin-guide/mm/pagemap.rst */
+	tbloff = virt / PAGE_SIZE * sizeof(uint64_t);
+	offset = lseek(fd, tbloff, SEEK_SET);
+	if (offset == (off_t)-1) {
+		ksft_print_msg("%s lseek: %s\n", __func__, strerror(errno));
+		return 1;
+	}
+
+	if (offset != tbloff) {
+		ksft_print_msg("%s: cannot find virtual address\n", __func__);
+		return 1;
+	}
+
+	nr = read(fd, &tblen, sizeof(uint64_t));
+	if (nr != sizeof(uint64_t)) {
+		ksft_print_msg("%s: read\n", __func__);
+		return 1;
+	}
+	close(fd);
+
+	if (!(tblen & (1ul << 63))) {
+		ksft_print_msg("%s: present bit is not set\n", __func__);
+		return 1;
+	}
+
+	/* Bits 0-54  page frame number (PFN) if present */
+	pfn = tblen & 0x7fffffffffffffULL;
+
+	*physp =  PAGE_SIZE * pfn | (virt & (PAGE_SIZE - 1));
+
+	return 0;
+}
+
+static int __phys_test(unsigned long long phys)
+{
+	char phys_str[128];
+	int fd, nr;
+
+	fd = open("/sys/kernel/debug/page_detective/phys", O_WRONLY);
+	if (fd < 0) {
+		ksft_print_msg("%s open: %s\n", __func__, strerror(errno));
+		return 4;
+	}
+
+	sprintf(phys_str, "%llu", phys);
+
+	nr = write(fd, phys_str, strlen(phys_str));
+	if (nr != strlen(phys_str)) {
+		ksft_print_msg("%s write failed\n", __func__);
+		return 1;
+	}
+	close(fd);
+
+	return 0;
+}
+
+static int phys_test(char *mem)
+{
+	uint64_t phys;
+
+	if (virt_to_phys((uint64_t)mem, &phys))
+		return 1;
+
+	return __phys_test(phys);
+}
+
+static int __virt_test(int pid, unsigned long virt)
+{
+	char virt_str[128];
+	int fd, nr;
+
+	fd = open("/sys/kernel/debug/page_detective/virt", O_WRONLY);
+	if (fd < 0) {
+		ksft_print_msg("%s open: %s\n", __func__, strerror(errno));
+		return 4;
+	}
+
+	sprintf(virt_str, "%d %#lx", pid, virt);
+	nr = write(fd, virt_str, strlen(virt_str));
+	if (nr != strlen(virt_str)) {
+		ksft_print_msg("%s: write(%s): %s\n", __func__, virt_str,
+			       strerror(errno));
+		close(fd);
+
+		return 1;
+	}
+	close(fd);
+
+	return 0;
+}
+
+static int virt_test(char *mem)
+{
+	return __virt_test(getpid(), (unsigned long)mem);
+}
+
+static int test_anon(int in)
+{
+	char *mem;
+	int rv;
+
+	mem = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (mem == MAP_FAILED) {
+		ksft_print_msg("%s mmap: %s\n", __func__, strerror(errno));
+		return 1;
+	}
+
+	if (madvise(mem, PAGE_SIZE, MADV_NOHUGEPAGE)) {
+		ksft_print_msg("%s madvise: %s\n", __func__, strerror(errno));
+		return 1;
+	}
+
+	mem[0] = 0;
+
+	if (in == ARG_INTERFACE_PHYS)
+		rv = phys_test(mem);
+	else
+		rv = virt_test(mem);
+
+	munmap(mem, PAGE_SIZE);
+
+	return rv;
+}
+
+static int test_anon_huge(int in)
+{
+	uint64_t i;
+	char *mem;
+	int rv;
+
+	mem = mmap(NULL, HUGE_PAGE_SIZE * 8, PROT_READ | PROT_WRITE,
+		   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (mem == MAP_FAILED) {
+		ksft_print_msg("%s mmap: %s\n", __func__, strerror(errno));
+		return 1;
+	}
+
+	if (madvise(mem, HUGE_PAGE_SIZE * 8, MADV_HUGEPAGE)) {
+		ksft_print_msg("%s madvise: %s\n", __func__, strerror(errno));
+		return 1;
+	}
+
+	/* Fault huge pages */
+	for (i = 0; i < HUGE_PAGE_SIZE * 8; i += HUGE_PAGE_SIZE)
+		mem[i] = 0;
+
+	/* In case huge pages were not used for some reason */
+	mem[HUGE_PAGE_SIZE * 7 + 101 * PAGE_SIZE] = 0;
+
+	if (in == ARG_INTERFACE_PHYS)
+		rv = phys_test(mem + HUGE_PAGE_SIZE * 7 + 101 * PAGE_SIZE);
+	else
+		rv = virt_test(mem + HUGE_PAGE_SIZE * 7 + 101 * PAGE_SIZE);
+
+	munmap(mem, HUGE_PAGE_SIZE * 8);
+
+	return rv;
+}
+
+static int test_anon_shared(int in)
+{
+	char *mem;
+	int rv;
+
+	mem = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+	if (mem == MAP_FAILED) {
+		ksft_print_msg("%s mmap: %s\n", __func__, strerror(errno));
+		return 1;
+	}
+
+	if (madvise(mem, PAGE_SIZE, MADV_NOHUGEPAGE)) {
+		ksft_print_msg("%s madvise: %s\n", __func__, strerror(errno));
+		return 1;
+	}
+
+	mem[0] = 0;
+
+	if (in == ARG_INTERFACE_PHYS)
+		rv = phys_test(mem);
+	else
+		rv = virt_test(mem);
+
+	munmap(mem, PAGE_SIZE);
+
+	return rv;
+}
+
+static int test_named_shared(int in)
+{
+	char *mem;
+	int rv;
+
+	mem = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+	if (mem == MAP_FAILED) {
+		ksft_print_msg("%s mmap: %s\n", __func__, strerror(errno));
+		return 1;
+	}
+
+	if (madvise(mem, PAGE_SIZE, MADV_NOHUGEPAGE)) {
+		ksft_print_msg("%s madvise: %s\n", __func__, strerror(errno));
+		return 1;
+	}
+
+	mem[0] = 0;
+
+	if (in == ARG_INTERFACE_PHYS)
+		rv = phys_test(mem);
+	else
+		rv = virt_test(mem);
+
+	munmap(mem, PAGE_SIZE);
+
+	return rv;
+}
+
+static int test_hugetlb_shared(int in)
+{
+	char hugepg_add_cmd[256], hugepg_rm_cmd[256];
+	unsigned long nr_hugepages;
+	char *mem;
+	FILE *f;
+	int rv;
+
+	f = fopen(NR_HUGEPAGES, "r");
+	if (!f) {
+		ksft_print_msg("%s fopen: %s\n", __func__, strerror(errno));
+		return 4;
+	}
+
+	fscanf(f, "%lu", &nr_hugepages);
+	fclose(f);
+	sprintf(hugepg_add_cmd, "echo %lu > " NR_HUGEPAGES, nr_hugepages + 1);
+	sprintf(hugepg_rm_cmd, "echo %lu > " NR_HUGEPAGES, nr_hugepages);
+
+	if (system(hugepg_add_cmd)) {
+		ksft_print_msg("%s system(hugepg_add_cmd): %s\n", __func__,
+			       strerror(errno));
+		return 4;
+	}
+
+	mem = mmap(NULL, HUGE_PAGE_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_HUGETLB | MAP_HUGE_2MB | MAP_ANONYMOUS | MAP_SHARED,
+		   -1, 0);
+	if (mem == MAP_FAILED) {
+		ksft_print_msg("%s mmap: %s\n", __func__, strerror(errno));
+		return 1;
+	}
+
+	mem[0] = 0;
+
+	if (in == ARG_INTERFACE_PHYS)
+		rv = phys_test(mem);
+	else
+		rv = virt_test(mem);
+
+	munmap(mem, HUGE_PAGE_SIZE);
+
+	if (system(hugepg_rm_cmd)) {
+		ksft_print_msg("%s system(hugepg_rm_cmd): %s\n", __func__,
+			       strerror(errno));
+		return 1;
+	}
+
+	return rv;
+}
+
+static int test_tmpfs(int in)
+{
+	char *mem;
+	int fd;
+	int rv;
+
+	fd = memfd_create("tmpfs_page",
+			  MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	if (fd < 0) {
+		ksft_print_msg("%s memfd_create: %s\n", __func__,
+			       strerror(errno));
+		return 1;
+	}
+
+	if (ftruncate(fd, PAGE_SIZE) == -1) {
+		ksft_print_msg("%s ftruncate: %s\n", __func__, strerror(errno));
+		return 1;
+	}
+
+	mem = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, fd, 0);
+	if (mem == MAP_FAILED) {
+		ksft_print_msg("%s mmap: %s\n", __func__, strerror(errno));
+		return 1;
+	}
+
+	mem[0] = 0;
+
+	if (in == ARG_INTERFACE_PHYS)
+		rv = phys_test(mem);
+	else
+		rv = virt_test(mem);
+
+	munmap(mem, PAGE_SIZE);
+	close(fd);
+
+	return rv;
+}
+
+static int test_stack(int in)
+{
+	char *mem = alloca(PAGE_SIZE);
+	int rv;
+
+	mem[0] = 0;
+	if (in == ARG_INTERFACE_PHYS)
+		rv = phys_test(mem);
+	else
+		rv = virt_test(mem);
+
+	return rv;
+}
+
+static int test_bad_phys(void)
+{
+	int rv;
+
+	rv = __phys_test(0);
+	if (rv)
+		return rv;
+
+	rv = __phys_test(1);
+	if (rv)
+		return rv;
+
+	rv = __phys_test(~0);
+
+	return rv;
+}
+
+static int test_bad_virt(void)
+{
+	int rv;
+
+	rv = __virt_test(0, 0);
+	if (rv == 4)
+		return rv;
+
+	if (!rv) {
+		ksft_print_msg("%s: write(0, 0) did not fail\n", __func__);
+		return 1;
+	}
+
+	if (!__virt_test(0, -1)) {
+		ksft_print_msg("%s: write(0, -1) did not fail\n", __func__);
+		return 1;
+	}
+
+	if (!__virt_test(0, -1)) {
+		ksft_print_msg("%s: write(0, -1) did not fail\n", __func__);
+		return 1;
+	}
+
+	if (!__virt_test(-1, 0)) {
+		ksft_print_msg("%s: write(-1, 0) did not fail\n", __func__);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int test_fail_cases(int in)
+{
+	if (in == ARG_INTERFACE_VIRT)
+		return test_bad_virt();
+	else
+		return test_bad_phys();
+}
+
+/* Return time in nanosecond since epoch */
+static uint64_t gethrtime(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_REALTIME, &ts);
+
+	return (ts.tv_sec * NANO) + ts.tv_nsec;
+}
+
+static int sanity_check_fail_cases(int in, int test_ttpe, FILE *f)
+{
+	char *line;
+	size_t len;
+	ssize_t nr;
+
+	line = NULL;
+	len = 0;
+	while ((nr = getline(&line, &len, f)) != -1) {
+		char *l = strchr(line, ']') + 2;	/* skip time stamp */
+
+		if (l == (char *)2)
+			continue;
+
+		ksft_print_msg("%s", l);
+	}
+
+	free(line);
+
+	return 0;
+}
+
+static int sanity_check_test_result(int in, int test_type, uint64_t start)
+{
+	uint64_t end = gethrtime() + NANO;
+	char dmesg[256], *line;
+	int first_line, last_line;
+	size_t len;
+	ssize_t nr;
+	FILE *f;
+
+	sprintf(dmesg, "dmesg --since=@%ld.%06ld --until=@%ld.%06ld > "
+		TMP_FILE, start / NANO, (start / MILLI) % MICRO, end / NANO,
+		(end / MILLI) % MICRO);
+
+	if (old_dmesg)
+		system("dmesg > " TMP_FILE);
+	else
+		system(dmesg);
+	f = fopen(TMP_FILE, "r");
+	if (!f) {
+		ksft_print_msg("%s: %s", __func__, strerror(errno));
+		return 1;
+	}
+
+	if (test_type == ARG_TEST_FAIL_CASES) {
+		sanity_check_fail_cases(in, test_type, f);
+		fclose(f);
+		unlink(TMP_FILE);
+		return 0;
+	}
+
+	line = NULL;
+	len = 0;
+	first_line = 0;
+	last_line = 0;
+	while ((nr = getline(&line, &len, f)) != -1) {
+		char *l = strchr(line, ']') + 2;	/* skip time stamp */
+
+		if (l == (char *)2)
+			continue;
+
+		if (!first_line) {
+			first_line = !strncmp(l, FIRST_LINE_PREFIX,
+					     strlen(FIRST_LINE_PREFIX));
+		} else if (!last_line) {
+			last_line = !strncmp(l, LAST_LINE_PREFIX,
+					     strlen(LAST_LINE_PREFIX));
+			if (last_line)
+				ksft_print_msg("%s", l);
+		}
+
+		/*
+		 * Output everything between the first and last line of page
+		 * detective output
+		 */
+		if (first_line && !last_line)
+			ksft_print_msg("%s", l);
+	}
+	ksft_print_msg("\n");
+
+	free(line);
+	fclose(f);
+	unlink(TMP_FILE);
+
+	if (!first_line) {
+		ksft_print_msg("Test failed, bad first line\n");
+		return 1;
+	}
+	if (!last_line) {
+		ksft_print_msg("Test failed, bad last line\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * interface	ARG_INTERFACE_VIRT or ARG_INTERFACE_PHYS
+ * test_arg	one of the ARG_TEST_*
+ * test_f	function for this test
+ * arg		the provided user arguments.
+ *
+ * Run the test using the provided interface if it is requested interface arg.
+ */
+#define TEST(interface, test_type, test_f, arg)					\
+	do {									\
+		int __in = (interface);						\
+		int __tt = (test_type);						\
+		int __rv;							\
+										\
+		if ((arg) & __tt) {						\
+			uint64_t start = gethrtime();				\
+										\
+			if (old_dmesg)						\
+				system("dmesg -C");				\
+			else							\
+				usleep(100000);					\
+										\
+			__rv = test_f(__in);					\
+			if (__rv == 4) {					\
+				ksft_test_result_skip(#test_f " via [%s]\n",	\
+						      INTERFACE_NAME(__in));	\
+				break;						\
+			}							\
+										\
+			if (__rv) {						\
+				ksft_test_result_fail(#test_f " via [%s]\n",	\
+						      INTERFACE_NAME(__in));	\
+				break;						\
+			}							\
+										\
+			if (sanity_check_test_result(__in, __tt,		\
+						     start)) {			\
+				ksft_test_result_fail(#test_f " via [%s]\n",	\
+						      INTERFACE_NAME(__in));	\
+				break;						\
+			}							\
+			ksft_test_result_pass(#test_f " via [%s]\n",		\
+					      INTERFACE_NAME(__in));		\
+		}								\
+	} while (0)
+
+static void run_tests(int in, int arg)
+{
+	if (in & arg) {
+		TEST(in, ARG_TEST_ANON, test_anon, arg);
+		TEST(in, ARG_TEST_ANON_HUGE, test_anon_huge, arg);
+		TEST(in, ARG_TEST_ANON_SHARED, test_anon_shared, arg);
+		TEST(in, ARG_TEST_NAMED_SHARED, test_named_shared, arg);
+		TEST(in, ARG_TEST_HUGETLB_SHARED, test_hugetlb_shared, arg);
+		TEST(in, ARG_TEST_TMPFS, test_tmpfs, arg);
+		TEST(in, ARG_TEST_STACK, test_stack, arg);
+		TEST(in, ARG_TEST_FAIL_CASES, test_fail_cases, arg);
+	}
+}
+
+static int count_tests(int in, int arg)
+{
+	int tests = 0;
+
+	if (in & arg) {
+		tests += (arg & ARG_TEST_ANON) ? 1 : 0;
+		tests += (arg & ARG_TEST_ANON_HUGE) ? 1 : 0;
+		tests += (arg & ARG_TEST_ANON_SHARED) ? 1 : 0;
+		tests += (arg & ARG_TEST_NAMED_SHARED) ? 1 : 0;
+		tests += (arg & ARG_TEST_HUGETLB_SHARED) ? 1 : 0;
+		tests += (arg & ARG_TEST_TMPFS) ? 1 : 0;
+		tests += (arg & ARG_TEST_STACK) ? 1 : 0;
+		tests += (arg & ARG_TEST_FAIL_CASES) ? 1 : 0;
+	}
+
+	return tests;
+}
+
+int main(int argc, char **argv)
+{
+	int arg = 0;
+	int opt;
+
+	while ((opt = getopt(argc, argv, OPT_STR)) != -1) {
+		switch (opt) {
+		case 'h':
+			printf(HELP_STR, argv[0]);
+			exit(EXIT_SUCCESS);
+		case 'v':
+			arg |= ARG_INTERFACE_VIRT;
+			break;
+		case 'p':
+			arg |= ARG_INTERFACE_PHYS;
+			break;
+		case 'a':
+			arg |= ARG_TEST_ANON;
+			break;
+		case 'A':
+			arg |= ARG_TEST_ANON_HUGE;
+			break;
+		case 's':
+			arg |= ARG_TEST_ANON_SHARED;
+			break;
+		case 'n':
+			arg |= ARG_TEST_NAMED_SHARED;
+			break;
+		case 'H':
+			arg |= ARG_TEST_HUGETLB_SHARED;
+			break;
+		case 't':
+			arg |= ARG_TEST_TMPFS;
+			break;
+		case 'S':
+			arg |= ARG_TEST_STACK;
+			break;
+		case 'b':
+			arg |= ARG_TEST_FAIL_CASES;
+			break;
+		default:
+			errx(EXIT_FAILURE, HELP_STR, argv[0]);
+		}
+	}
+
+	if (arg == 0)
+		arg = ARG_DEFAULT;
+	if (!(arg & ARG_INTERFACE_MASK))
+		errx(EXIT_FAILURE, "No page detective interface specified");
+
+	if (!(arg & ARG_TEST_MASK))
+		errx(EXIT_FAILURE, "No tests specified");
+
+	/* Return 1 when dmesg does not have --since and --until arguments */
+	old_dmesg = system("dmesg --since @0 > /dev/null 2>&1");
+
+	ksft_print_header();
+	ksft_set_plan(count_tests(ARG_INTERFACE_VIRT, arg)
+		      + count_tests(ARG_INTERFACE_PHYS, arg));
+
+	run_tests(ARG_INTERFACE_VIRT, arg);
+	run_tests(ARG_INTERFACE_PHYS, arg);
+	ksft_finished();
+}
-- 
2.47.0.338.g60cca15819-goog


