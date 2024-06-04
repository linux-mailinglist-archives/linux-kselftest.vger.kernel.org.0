Return-Path: <linux-kselftest+bounces-11165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3E78FA82A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 04:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F4628D6C4
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 02:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C363A140E2F;
	Tue,  4 Jun 2024 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jV+VEndQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756ED140366
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466783; cv=none; b=foLC5rlAo+7G8eG6wYQUPzuN0Btrg04VVLQ61igdBubySir3TREar7qJfmtK+UwBaeQ9qFfEF9uJysVzDm5jKSvbEzQbuT8tk28MseTkU5FJ0uxvjqWMDK6F9ezxwcuMQjGieSJ8+EeJoaQTLLBDfUMRDzLe597SvYLtzvVNwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466783; c=relaxed/simple;
	bh=q3DyF7+oo54Jxd1cz3e3x7LUbFTHRR4P/k6/pzucz0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S7RRiY+ZlKhC5hzdQOuoy4CxYnH64SLCI0EINtjnOzf5HNEMVOkkKsvItVNX+UsH1qblSbYO+lPeYIfapz032r2VFBQ5KbL4+8JTs5WueHR3iyGq03LdLEXAgW0VcPlttB4s6NYAXFC17mnmOrN8/+mbAPdys/dSBEP/eyNT6+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jV+VEndQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62c7a4f8cd6so70946637b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2024 19:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717466780; x=1718071580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFXr85ron2toDBErygQNuv7Zt41ZsUWhKpGsReFw+QE=;
        b=jV+VEndQv8hB4kgqOTjuR6XQSlO4EKFKETM6l7XHJIpoNi0RCP5jOw9OD1IRLcq2NR
         g9EdUf+IRvPl5vQTIXNkDGgUU7uzNgZQnRgsW/BZagtLDP82zwq4nSmGLOBhF2kV5Rb6
         RoXhOJhKcHTEiWxI9KugNINgn8D08wl19EWo1poPr4K5Jkya0i2TDtmNIxnx3G4B8WfQ
         TPGy7ITjiOW3mqJhZNg0lHSnnpyzukhNp+bzaL6kuxY+V83WvPNsIhjtGQ8ltrYWulzY
         1YvuwKDIz1FwnyDaD3Yefy+JeJC8ORVnwma1OmaENpvTVl6KAutyXb+C6Fd9c6NhH0X+
         LiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717466780; x=1718071580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFXr85ron2toDBErygQNuv7Zt41ZsUWhKpGsReFw+QE=;
        b=hSBy1wxVx7scRknOuaYZ4S0VCT3kmiWuFTH8zgaGai5+UExnV5o2Eqbry7LrOlzvsb
         zj5Dl6+D/ON27b7uJm11W1qGThN1+9mN+v00D49kVXjZodFBqh5TSQLGJS+DEPDiBPyL
         G7FgRXM/xCFM7OJ4jPBwhPexHkKYpku4E5U474jghuCSV72PNzI3RsrZOLEf3ydNqpAl
         yyAFzmrqZyIYTJ54zEsm+Rx8aje9+J4hjPrlmOVfUdy4Oe1qAqjZzNJpkZq5d/z0lY6k
         CHWcVEF+3kzCLX7xM4MXQpi21qby3Cb1t8bV1Asi3NoTQ3gnldBvrnwdF25M0Iwt3wFE
         R4og==
X-Forwarded-Encrypted: i=1; AJvYcCVwAR7jo10C9TsAae5g2QyHTQPurEfbWb+KLRXVFfL7t4yK6smCMnSuUeNmIZ55EE6bMTXS54IdAwrmd1KfofSxj72R6VAHrZdkCluyk1Mw
X-Gm-Message-State: AOJu0Yx56lPheFlyMaYyOi5YeKg/OEVUci3CyogURGWQY8F+DorB/j4h
	PHVuFlQtDSaS59sgkte5Z9c7EGfy8QtjIAkxDUoPAFZZGJRCQPfFx2+SvkJY1GeYUi00cUOKPrm
	rCMHibw==
X-Google-Smtp-Source: AGHT+IFMlcay6XF4ua+TyOfXgCRZBAfcOugLyJT670B/gtTfpnXAqB6fBBX7EL4l62Xcg856n16+j8Gxc2Th
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:367f:7387:3dd2:73f1])
 (user=yuanchu job=sendgmr) by 2002:a05:690c:a82:b0:627:d549:c40b with SMTP id
 00721157ae682-62c7981f58amr32392627b3.5.1717466780405; Mon, 03 Jun 2024
 19:06:20 -0700 (PDT)
Date: Mon,  3 Jun 2024 19:05:48 -0700
In-Reply-To: <20240604020549.1017540-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240604020549.1017540-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240604020549.1017540-8-yuanchu@google.com>
Subject: [PATCH v2 7/8] selftest: test system-wide workingset reporting
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A basic test that verifies the working set size of a simple memory
accessor. It should work with or without the aging thread.

When running tests with run_vmtests.sh, file workingset report testing
requires an environment variable WORKINGSET_REPORT_TEST_FILE_PATH to
store a temporary file, which is passed into the test invocation as a
parameter.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   3 +
 tools/testing/selftests/mm/run_vmtests.sh     |   5 +
 .../testing/selftests/mm/workingset_report.c  | 306 ++++++++++++++++
 .../testing/selftests/mm/workingset_report.h  |  39 +++
 .../selftests/mm/workingset_report_test.c     | 329 ++++++++++++++++++
 6 files changed, 683 insertions(+)
 create mode 100644 tools/testing/selftests/mm/workingset_report.c
 create mode 100644 tools/testing/selftests/mm/workingset_report.h
 create mode 100644 tools/testing/selftests/mm/workingset_report_test.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 0b9ab987601c..f1570923019d 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -49,3 +49,4 @@ hugetlb_fault_after_madv
 hugetlb_madv_vs_map
 mseal_test
 seal_elf
+workingset_report_test
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 3b49bc3d0a3b..6c96a65078f2 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -73,6 +73,7 @@ TEST_GEN_FILES += ksm_functional_tests
 TEST_GEN_FILES += mdwe_test
 TEST_GEN_FILES += hugetlb_fault_after_madv
 TEST_GEN_FILES += hugetlb_madv_vs_map
+TEST_GEN_FILES += workingset_report_test
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
@@ -131,6 +132,8 @@ $(TEST_GEN_FILES): vm_util.c thp_settings.c
 $(OUTPUT)/uffd-stress: uffd-common.c
 $(OUTPUT)/uffd-unit-tests: uffd-common.c
 
+$(OUTPUT)/workingset_report_test: workingset_report.c
+
 ifeq ($(ARCH),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 3157204b9047..41419084b481 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -75,6 +75,8 @@ separated by spaces:
 	read-only VMAs
 - mdwe
 	test prctl(PR_SET_MDWE, ...)
+- workingset_report
+	test workingset reporting
 
 example: ./run_vmtests.sh -t "hmm mmap ksm"
 EOF
@@ -446,6 +448,9 @@ CATEGORY="mkdirty" run_test ./mkdirty
 
 CATEGORY="mdwe" run_test ./mdwe_test
 
+CATEGORY="workingset_report" run_test ./workingset_report_test \
+  "${WORKINGSET_REPORT_TEST_FILE_PATH}"
+
 echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}" | tap_prefix
 echo "1..${count_total}" | tap_output
 
diff --git a/tools/testing/selftests/mm/workingset_report.c b/tools/testing/selftests/mm/workingset_report.c
new file mode 100644
index 000000000000..ee4dda5c371d
--- /dev/null
+++ b/tools/testing/selftests/mm/workingset_report.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "workingset_report.h"
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+#include "../kselftest.h"
+
+#define SYSFS_NODE_ONLINE "/sys/devices/system/node/online"
+#define PROC_DROP_CACHES "/proc/sys/vm/drop_caches"
+
+/* Returns read len on success, or -errno on failure. */
+static ssize_t read_text(const char *path, char *buf, size_t max_len)
+{
+	ssize_t len;
+	int fd, err;
+	size_t bytes_read = 0;
+
+	if (!max_len)
+		return -EINVAL;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	while (bytes_read < max_len - 1) {
+		len = read(fd, buf + bytes_read, max_len - 1 - bytes_read);
+
+		if (len <= 0)
+			break;
+		bytes_read += len;
+	}
+
+	buf[bytes_read] = '\0';
+
+	err = -errno;
+	close(fd);
+	return len < 0 ? err : bytes_read;
+}
+
+/* Returns written len on success, or -errno on failure. */
+static ssize_t write_text(const char *path, const char *buf, ssize_t max_len)
+{
+	int fd, len, err;
+	size_t bytes_written = 0;
+
+	fd = open(path, O_WRONLY | O_APPEND);
+	if (fd < 0)
+		return -errno;
+
+	while (bytes_written < max_len) {
+		len = write(fd, buf + bytes_written, max_len - bytes_written);
+
+		if (len < 0)
+			break;
+		bytes_written += len;
+	}
+
+	err = -errno;
+	close(fd);
+	return len < 0 ? err : bytes_written;
+}
+
+static long read_num(const char *path)
+{
+	char buf[21];
+
+	if (read_text(path, buf, sizeof(buf)) <= 0)
+		return -1;
+	return (long)strtoul(buf, NULL, 10);
+}
+
+static int write_num(const char *path, unsigned long n)
+{
+	char buf[21];
+
+	sprintf(buf, "%lu", n);
+	if (write_text(path, buf, strlen(buf)) < 0)
+		return -1;
+	return 0;
+}
+
+long sysfs_get_refresh_interval(int nid)
+{
+	char file[128];
+
+	snprintf(file, sizeof(file),
+		"/sys/devices/system/node/node%d/workingset_report/refresh_interval",
+		nid);
+	return read_num(file);
+}
+
+int sysfs_set_refresh_interval(int nid, long interval)
+{
+	char file[128];
+
+	snprintf(file, sizeof(file),
+		"/sys/devices/system/node/node%d/workingset_report/refresh_interval",
+		nid);
+	return write_num(file, interval);
+}
+
+int sysfs_get_page_age_intervals_str(int nid, char *buf, int len)
+{
+	char path[128];
+
+	snprintf(path, sizeof(path),
+		"/sys/devices/system/node/node%d/workingset_report/page_age_intervals",
+		nid);
+	return read_text(path, buf, len);
+
+}
+
+int sysfs_set_page_age_intervals_str(int nid, const char *buf, int len)
+{
+	char path[128];
+
+	snprintf(path, sizeof(path),
+		"/sys/devices/system/node/node%d/workingset_report/page_age_intervals",
+		nid);
+	return write_text(path, buf, len);
+}
+
+int sysfs_set_page_age_intervals(int nid, const char *const intervals[],
+				 int nr_intervals)
+{
+	char file[128];
+	char buf[1024];
+	int i;
+	int err, len = 0;
+
+	for (i = 0; i < nr_intervals; ++i) {
+		err = snprintf(buf + len, sizeof(buf) - len, "%s", intervals[i]);
+
+		if (err < 0)
+			return err;
+		len += err;
+
+		if (i < nr_intervals - 1) {
+			err = snprintf(buf + len, sizeof(buf) - len, ",");
+			if (err < 0)
+				return err;
+			len += err;
+		}
+	}
+
+	snprintf(file, sizeof(file),
+		"/sys/devices/system/node/node%d/workingset_report/page_age_intervals",
+		nid);
+	return write_text(file, buf, len);
+}
+
+int get_nr_nodes(void)
+{
+	char buf[22];
+	char *found;
+
+	if (read_text(SYSFS_NODE_ONLINE, buf, sizeof(buf)) <= 0)
+		return -1;
+	found = strstr(buf, "-");
+	if (found)
+		return (int)strtoul(found + 1, NULL, 10) + 1;
+	return (long)strtoul(buf, NULL, 10) + 1;
+}
+
+int drop_pagecache(void)
+{
+	return write_num(PROC_DROP_CACHES, 1);
+}
+
+ssize_t sysfs_page_age_read(int nid, char *buf, size_t len)
+
+{
+	char file[128];
+
+	snprintf(file, sizeof(file),
+		 "/sys/devices/system/node/node%d/workingset_report/page_age",
+		 nid);
+	return read_text(file, buf, len);
+}
+
+/*
+ * Finds the first occurrence of "N<nid>\n"
+ * Modifies buf to terminate before the next occurrence of "N".
+ * Returns a substring of buf starting after "N<nid>\n"
+ */
+char *page_age_split_node(char *buf, int nid, char **next)
+{
+	char node_str[5];
+	char *found;
+	int node_str_len;
+
+	node_str_len = snprintf(node_str, sizeof(node_str), "N%u\n", nid);
+
+	/* find the node prefix first */
+	found = strstr(buf, node_str);
+	if (!found) {
+		ksft_print_msg("cannot find '%s' in page_idle_age", node_str);
+		return NULL;
+	}
+	found += node_str_len;
+
+	*next = strchr(found, 'N');
+	if (*next)
+		*(*next - 1) = '\0';
+
+	return found;
+}
+
+ssize_t page_age_read(const char *buf, const char *interval, int pagetype)
+{
+	static const char * const type[ANON_AND_FILE] = { "anon=", "file=" };
+	char *found;
+
+	found = strstr(buf, interval);
+	if (!found) {
+		ksft_print_msg("cannot find %s in page_age", interval);
+		return -1;
+	}
+	found = strstr(found, type[pagetype]);
+	if (!found) {
+		ksft_print_msg("cannot find %s in page_age", type[pagetype]);
+		return -1;
+	}
+	found += strlen(type[pagetype]);
+	return (long)strtoul(found, NULL, 10);
+}
+
+static const char *TEMP_FILE = "/tmp/workingset_selftest";
+void cleanup_file_workingset(void)
+{
+	remove(TEMP_FILE);
+}
+
+int alloc_file_workingset(void *arg)
+{
+	int err = 0;
+	char *ptr;
+	int fd;
+	int ppid;
+	char *mapped;
+	size_t size = (size_t)arg;
+	size_t page_size = getpagesize();
+
+	ppid = getppid();
+
+	fd = open(TEMP_FILE, O_RDWR | O_CREAT);
+	if (fd < 0) {
+		err = -errno;
+		ksft_perror("failed to open temp file\n");
+		goto cleanup;
+	}
+
+	if (fallocate(fd, 0, 0, size) < 0) {
+		err = -errno;
+		ksft_perror("fallocate");
+		goto cleanup;
+	}
+
+	mapped = (char *)mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
+			      fd, 0);
+	if (mapped == NULL) {
+		err = -errno;
+		ksft_perror("mmap");
+		goto cleanup;
+	}
+
+	while (getppid() == ppid) {
+		sync();
+		for (ptr = mapped; ptr < mapped + size; ptr += page_size)
+			*ptr = *ptr ^ 0xFF;
+	}
+
+cleanup:
+	cleanup_file_workingset();
+	return err;
+}
+
+int alloc_anon_workingset(void *arg)
+{
+	char *buf, *ptr;
+	int ppid = getppid();
+	size_t size = (size_t)arg;
+	size_t page_size = getpagesize();
+
+	buf = malloc(size);
+
+	if (!buf) {
+		ksft_print_msg("cannot allocate anon workingset");
+		exit(1);
+	}
+
+	while (getppid() == ppid) {
+		for (ptr = buf; ptr < buf + size; ptr += page_size)
+			*ptr = *ptr ^ 0xFF;
+	}
+
+	free(buf);
+	return 0;
+}
diff --git a/tools/testing/selftests/mm/workingset_report.h b/tools/testing/selftests/mm/workingset_report.h
new file mode 100644
index 000000000000..c5c281e4069b
--- /dev/null
+++ b/tools/testing/selftests/mm/workingset_report.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef WORKINGSET_REPORT_H_
+#define WORKINGSET_REPORT_H_
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <stdint.h>
+#include <sys/types.h>
+
+#define PAGETYPE_ANON 0
+#define PAGETYPE_FILE 1
+#define ANON_AND_FILE 2
+
+int get_nr_nodes(void);
+int drop_pagecache(void);
+
+long sysfs_get_refresh_interval(int nid);
+int sysfs_set_refresh_interval(int nid, long interval);
+
+int sysfs_get_page_age_intervals_str(int nid, char *buf, int len);
+int sysfs_set_page_age_intervals_str(int nid, const char *buf, int len);
+
+int sysfs_set_page_age_intervals(int nid, const char *const intervals[],
+				 int nr_intervals);
+
+char *page_age_split_node(char *buf, int nid, char **next);
+ssize_t sysfs_page_age_read(int nid, char *buf, size_t len);
+ssize_t page_age_read(const char *buf, const char *interval, int pagetype);
+
+int alloc_file_workingset(void *arg);
+void cleanup_file_workingset(void);
+int alloc_anon_workingset(void *arg);
+
+#endif /* WORKINGSET_REPORT_H_ */
diff --git a/tools/testing/selftests/mm/workingset_report_test.c b/tools/testing/selftests/mm/workingset_report_test.c
new file mode 100644
index 000000000000..73246f18ed8d
--- /dev/null
+++ b/tools/testing/selftests/mm/workingset_report_test.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "workingset_report.h"
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <signal.h>
+#include <time.h>
+
+#include "../clone3/clone3_selftests.h"
+
+#define REFRESH_INTERVAL 5000
+#define MB(x) (x << 20)
+
+static void sleep_ms(int milliseconds)
+{
+	struct timespec ts;
+
+	ts.tv_sec = milliseconds / 1000;
+	ts.tv_nsec = (milliseconds % 1000) * 1000000;
+	nanosleep(&ts, NULL);
+}
+
+/*
+ * Checks if two given values differ by less than err% of their sum.
+ */
+static inline int values_close(long a, long b, int err)
+{
+	return labs(a - b) <= (a + b) / 100 * err;
+}
+
+static const char * const PAGE_AGE_INTERVALS[] = {
+	"6000", "10000", "15000", "18446744073709551615",
+};
+#define NR_PAGE_AGE_INTERVALS (ARRAY_SIZE(PAGE_AGE_INTERVALS))
+
+static int set_page_age_intervals_all_nodes(const char *intervals, int nr_nodes)
+{
+	int i;
+
+	for (i = 0; i < nr_nodes; ++i) {
+		int err = sysfs_set_page_age_intervals_str(
+			i, &intervals[i * 1024], strlen(&intervals[i * 1024]));
+
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+static int get_page_age_intervals_all_nodes(char *intervals, int nr_nodes)
+{
+	int i;
+
+	for (i = 0; i < nr_nodes; ++i) {
+		int err = sysfs_get_page_age_intervals_str(
+			i, &intervals[i * 1024], 1024);
+
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+static int set_refresh_interval_all_nodes(const long *interval, int nr_nodes)
+{
+	int i;
+
+	for (i = 0; i < nr_nodes; ++i) {
+		int err = sysfs_set_refresh_interval(i, interval[i]);
+
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+static int get_refresh_interval_all_nodes(long *interval, int nr_nodes)
+{
+	int i;
+
+	for (i = 0; i < nr_nodes; ++i) {
+		long val = sysfs_get_refresh_interval(i);
+
+		if (val < 0)
+			return val;
+		interval[i] = val;
+	}
+	return 0;
+}
+
+static pid_t clone_and_run(int fn(void *arg), void *arg)
+{
+	pid_t pid;
+
+	struct __clone_args args = {
+		.exit_signal = SIGCHLD,
+	};
+
+	pid = sys_clone3(&args, sizeof(struct __clone_args));
+
+	if (pid == 0)
+		exit(fn(arg));
+
+	return pid;
+}
+
+static int read_workingset(int pagetype, int nid,
+			   unsigned long page_age[NR_PAGE_AGE_INTERVALS])
+{
+	int i, err;
+	char buf[4096];
+
+	err = sysfs_page_age_read(nid, buf, sizeof(buf));
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < NR_PAGE_AGE_INTERVALS; ++i) {
+		err = page_age_read(buf, PAGE_AGE_INTERVALS[i], pagetype);
+		if (err < 0)
+			return err;
+		page_age[i] = err;
+	}
+
+	return 0;
+}
+
+static ssize_t read_interval_all_nodes(int pagetype, int interval)
+{
+	int i, err;
+	unsigned long page_age[NR_PAGE_AGE_INTERVALS];
+	ssize_t ret = 0;
+	int nr_nodes = get_nr_nodes();
+
+	for (i = 0; i < nr_nodes; ++i) {
+		err = read_workingset(pagetype, i, page_age);
+		if (err < 0)
+			return err;
+
+		ret += page_age[interval];
+	}
+
+	return ret;
+}
+
+#define TEST_SIZE MB(500l)
+
+static int run_test(int f(void))
+{
+	int i, err, test_result;
+	long *old_refresh_intervals;
+	long *new_refresh_intervals;
+	char *old_page_age_intervals;
+	int nr_nodes = get_nr_nodes();
+
+	if (nr_nodes <= 0) {
+		ksft_print_msg("failed to get nr_nodes\n");
+		return KSFT_FAIL;
+	}
+
+	old_refresh_intervals = calloc(nr_nodes, sizeof(long));
+	new_refresh_intervals = calloc(nr_nodes, sizeof(long));
+	old_page_age_intervals = calloc(nr_nodes, 1024);
+
+	if (!(old_refresh_intervals && new_refresh_intervals &&
+	      old_page_age_intervals)) {
+		ksft_print_msg("failed to allocate memory for intervals\n");
+		return KSFT_FAIL;
+	}
+
+	err = get_refresh_interval_all_nodes(old_refresh_intervals, nr_nodes);
+	if (err < 0) {
+		ksft_print_msg("failed to read refresh interval\n");
+		return KSFT_FAIL;
+	}
+
+	err = get_page_age_intervals_all_nodes(old_page_age_intervals, nr_nodes);
+	if (err < 0) {
+		ksft_print_msg("failed to read page age interval\n");
+		return KSFT_FAIL;
+	}
+
+	for (i = 0; i < nr_nodes; ++i)
+		new_refresh_intervals[i] = REFRESH_INTERVAL;
+
+	for (i = 0; i < nr_nodes; ++i) {
+		err = sysfs_set_page_age_intervals(i, PAGE_AGE_INTERVALS,
+						   NR_PAGE_AGE_INTERVALS - 1);
+		if (err < 0) {
+			ksft_print_msg("failed to set page age interval\n");
+			test_result = KSFT_FAIL;
+			goto fail;
+		}
+	}
+
+	err = set_refresh_interval_all_nodes(new_refresh_intervals, nr_nodes);
+	if (err < 0) {
+		ksft_print_msg("failed to set refresh interval\n");
+		test_result = KSFT_FAIL;
+		goto fail;
+	}
+
+	sync();
+	drop_pagecache();
+
+	test_result = f();
+
+fail:
+	err = set_refresh_interval_all_nodes(old_refresh_intervals, nr_nodes);
+	if (err < 0) {
+		ksft_print_msg("failed to restore refresh interval\n");
+		test_result = KSFT_FAIL;
+	}
+	err = set_page_age_intervals_all_nodes(old_page_age_intervals, nr_nodes);
+	if (err < 0) {
+		ksft_print_msg("failed to restore page age interval\n");
+		test_result = KSFT_FAIL;
+	}
+	return test_result;
+}
+
+static char *file_test_path;
+static int test_file(void)
+{
+	ssize_t ws_size_ref, ws_size_test;
+	int ret = KSFT_FAIL, i;
+	pid_t pid = 0;
+
+	if (!file_test_path) {
+		ksft_print_msg("Set a path to test file workingset\n");
+		return KSFT_SKIP;
+	}
+
+	ws_size_ref = read_interval_all_nodes(PAGETYPE_FILE, 0);
+	if (ws_size_ref < 0)
+		goto cleanup;
+
+	pid = clone_and_run(alloc_file_workingset, (void *)TEST_SIZE);
+	if (pid < 0)
+		goto cleanup;
+
+	read_interval_all_nodes(PAGETYPE_FILE, 0);
+	sleep_ms(REFRESH_INTERVAL);
+
+	for (i = 0; i < 3; ++i) {
+		sleep_ms(REFRESH_INTERVAL);
+		ws_size_test = read_interval_all_nodes(PAGETYPE_FILE, 0);
+		ws_size_test += read_interval_all_nodes(PAGETYPE_FILE, 1);
+		if (ws_size_test < 0)
+			goto cleanup;
+
+		if (!values_close(ws_size_test - ws_size_ref, TEST_SIZE, 10)) {
+			ksft_print_msg(
+				"file working set size difference too large: actual=%ld, expected=%ld\n",
+				ws_size_test - ws_size_ref, TEST_SIZE);
+			goto cleanup;
+		}
+	}
+	ret = KSFT_PASS;
+
+cleanup:
+	if (pid > 0)
+		kill(pid, SIGKILL);
+	cleanup_file_workingset();
+	return ret;
+}
+
+static int test_anon(void)
+{
+	ssize_t ws_size_ref, ws_size_test;
+	pid_t pid = 0;
+	int ret = KSFT_FAIL, i;
+
+	ws_size_ref = read_interval_all_nodes(PAGETYPE_ANON, 0);
+	if (ws_size_ref < 0)
+		goto cleanup;
+
+	pid = clone_and_run(alloc_anon_workingset, (void *)TEST_SIZE);
+	if (pid < 0)
+		goto cleanup;
+
+	sleep_ms(REFRESH_INTERVAL);
+	read_interval_all_nodes(PAGETYPE_ANON, 0);
+
+	for (i = 0; i < 5; ++i) {
+		sleep_ms(REFRESH_INTERVAL);
+		ws_size_test = read_interval_all_nodes(PAGETYPE_ANON, 0);
+		ws_size_test += read_interval_all_nodes(PAGETYPE_ANON, 1);
+		if (ws_size_test < 0)
+			goto cleanup;
+
+		if (!values_close(ws_size_test - ws_size_ref, TEST_SIZE, 10)) {
+			ksft_print_msg(
+				"anon working set size difference too large: actual=%ld, expected=%ld\n",
+				ws_size_test - ws_size_ref, TEST_SIZE);
+			goto cleanup;
+		}
+	}
+	ret = KSFT_PASS;
+
+cleanup:
+	if (pid > 0)
+		kill(pid, SIGKILL);
+	return ret;
+}
+
+
+#define T(x) { x, #x }
+struct workingset_test {
+	int (*fn)(void);
+	const char *name;
+} tests[] = {
+	T(test_anon),
+	T(test_file),
+};
+#undef T
+
+int main(int argc, char **argv)
+{
+	int i, err;
+
+	if (argc > 1)
+		file_test_path = argv[1];
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		err = run_test(tests[i].fn);
+		ksft_test_result_code(err, tests[i].name, NULL);
+	}
+	return 0;
+}
-- 
2.45.1.467.gbab1589fc0-goog


