Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC82D6A15FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 05:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBXElR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 23:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBXElQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 23:41:16 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC285EECD
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 20:41:13 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 0FAE87B74EDF; Thu, 23 Feb 2023 20:40:59 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org
Subject: [PATCH v3 3/3] selftests/mm: add new selftests for KSM
Date:   Thu, 23 Feb 2023 20:40:00 -0800
Message-Id: <20230224044000.3084046-4-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230224044000.3084046-1-shr@devkernel.io>
References: <20230224044000.3084046-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,HELO_MISC_IP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds three new tests to the selftests for KSM. These tests use the
new prctl API's to enable and disable KSM.

1) add new prctl flags to prctl header file in tools dir

This adds the new prctl flags to the include file prct.h in the tools
directory. This makes sure they are available for testing.

2) add KSM prctl merge test

This adds the -t option to the ksm_tests program. The -t flag allows to
specify if it should use madvise or prctl ksm merging.

3) add KSM get merge type test

This adds the -G flag to the ksm_tests program to query the KSM status wi=
th
prctl after KSM has been enabled with prctl.

4) add KSM fork test

Add fork test to verify that the MMF_VM_MERGE_ANY flag is inherited by
the child process.

5) add two functions for debugging merge outcome

This adds two functions to report the metrics in /proc/self/ksm_stat and
/sys/kernel/debug/mm/ksm.

The debugging can be enabled with the following command line:
make -C tools/testing/selftests TARGETS=3D"vm" --keep-going \
        EXTRA_CFLAGS=3D-DDEBUG=3D1

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 tools/include/uapi/linux/prctl.h       |   2 +
 tools/testing/selftests/mm/Makefile    |   3 +-
 tools/testing/selftests/mm/ksm_tests.c | 254 +++++++++++++++++++++----
 3 files changed, 219 insertions(+), 40 deletions(-)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/=
prctl.h
index a5e06dcbba13..e4c629c1f1b0 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -284,4 +284,6 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
=20
+#define PR_SET_MEMORY_MERGE		67
+#define PR_GET_MEMORY_MERGE		68
 #endif /* _LINUX_PRCTL_H */
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftest=
s/mm/Makefile
index d90cdc06aa59..507cb22bdebd 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -29,7 +29,8 @@ MACHINE ?=3D $(shell echo $(uname_M) | sed -e 's/aarch6=
4.*/arm64/' -e 's/ppc64.*/p
 # LDLIBS.
 MAKEFLAGS +=3D --no-builtin-rules
=20
-CFLAGS =3D -Wall -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_C=
FLAGS) $(KHDR_INCLUDES)
+CFLAGS =3D -Wall -I $(top_srcdir)/tools/include/uapi
+CFLAGS +=3D -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_CFLAGS=
) $(KHDR_INCLUDES)
 LDLIBS =3D -lrt -lpthread
 TEST_GEN_FILES =3D cow
 TEST_GEN_FILES +=3D compaction_test
diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selft=
ests/mm/ksm_tests.c
index f9eb4d67e0dd..9fb21b982dc9 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
=20
 #include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
 #include <stdbool.h>
 #include <time.h>
 #include <string.h>
@@ -21,6 +23,7 @@
 #define KSM_PROT_STR_DEFAULT "rw"
 #define KSM_USE_ZERO_PAGES_DEFAULT false
 #define KSM_MERGE_ACROSS_NODES_DEFAULT true
+#define KSM_MERGE_TYPE_DEFAULT 0
 #define MB (1ul << 20)
=20
 struct ksm_sysfs {
@@ -33,9 +36,17 @@ struct ksm_sysfs {
 	unsigned long use_zero_pages;
 };
=20
+enum ksm_merge_type {
+	KSM_MERGE_MADVISE,
+	KSM_MERGE_PRCTL,
+	KSM_MERGE_LAST =3D KSM_MERGE_PRCTL
+};
+
 enum ksm_test_name {
 	CHECK_KSM_MERGE,
+	CHECK_KSM_MERGE_FORK,
 	CHECK_KSM_UNMERGE,
+	CHECK_KSM_GET_MERGE_TYPE,
 	CHECK_KSM_ZERO_PAGE_MERGE,
 	CHECK_KSM_NUMA_MERGE,
 	KSM_MERGE_TIME,
@@ -82,6 +93,55 @@ static int ksm_read_sysfs(const char *file_path, unsig=
ned long *val)
 	return 0;
 }
=20
+#ifdef DEBUG
+static void ksm_print_sysfs(void)
+{
+	unsigned long max_page_sharing, pages_sharing, pages_shared;
+	unsigned long full_scans, pages_unshared, pages_volatile;
+	unsigned long stable_node_chains, stable_node_dups;
+	long general_profit;
+
+	if (ksm_read_sysfs(KSM_FP("pages_shared"), &pages_shared) ||
+	    ksm_read_sysfs(KSM_FP("pages_sharing"), &pages_sharing) ||
+	    ksm_read_sysfs(KSM_FP("max_page_sharing"), &max_page_sharing) ||
+	    ksm_read_sysfs(KSM_FP("full_scans"), &full_scans) ||
+	    ksm_read_sysfs(KSM_FP("pages_unshared"), &pages_unshared) ||
+	    ksm_read_sysfs(KSM_FP("pages_volatile"), &pages_volatile) ||
+	    ksm_read_sysfs(KSM_FP("stable_node_chains"), &stable_node_chains) |=
|
+	    ksm_read_sysfs(KSM_FP("stable_node_dups"), &stable_node_dups) ||
+	    ksm_read_sysfs(KSM_FP("general_profit"), (unsigned long *)&general_=
profit))
+		return;
+
+	printf("pages_shared      : %lu\n", pages_shared);
+	printf("pages_sharing     : %lu\n", pages_sharing);
+	printf("max_page_sharing  : %lu\n", max_page_sharing);
+	printf("full_scans        : %lu\n", full_scans);
+	printf("pages_unshared    : %lu\n", pages_unshared);
+	printf("pages_volatile    : %lu\n", pages_volatile);
+	printf("stable_node_chains: %lu\n", stable_node_chains);
+	printf("stable_node_dups  : %lu\n", stable_node_dups);
+	printf("general_profit    : %ld\n", general_profit);
+}
+
+static void ksm_print_procfs(void)
+{
+	const char *file_name =3D "/proc/self/ksm_stat";
+	char buffer[512];
+	FILE *f =3D fopen(file_name, "r");
+
+	if (!f) {
+		fprintf(stderr, "f %s\n", file_name);
+		perror("fopen");
+		return;
+	}
+
+	while (fgets(buffer, sizeof(buffer), f))
+		printf("%s", buffer);
+
+	fclose(f);
+}
+#endif
+
 static int str_to_prot(char *prot_str)
 {
 	int prot =3D 0;
@@ -115,7 +175,9 @@ static void print_help(void)
 	       " -D evaluate unmerging time and speed when disabling KSM.\n"
 	       "    For this test, the size of duplicated memory area (in MiB)\=
n"
 	       "    must be provided using -s option\n"
-	       " -C evaluate the time required to break COW of merged pages.\n\=
n");
+	       " -C evaluate the time required to break COW of merged pages.\n"
+	       " -G query merge mode\n"
+	       " -F evaluate that the KSM process flag is inherited\n\n");
=20
 	printf(" -a: specify the access protections of pages.\n"
 	       "     <prot> must be of the form [rwx].\n"
@@ -129,6 +191,10 @@ static void print_help(void)
 	printf(" -m: change merge_across_nodes tunable\n"
 	       "     Default: %d\n", KSM_MERGE_ACROSS_NODES_DEFAULT);
 	printf(" -s: the size of duplicated memory area (in MiB)\n");
+	printf(" -t: KSM merge type\n"
+	       "     Default: 0\n"
+	       "     0: madvise merging\n"
+	       "     1: prctl merging\n");
=20
 	exit(0);
 }
@@ -176,12 +242,21 @@ static int ksm_do_scan(int scan_count, struct times=
pec start_time, int timeout)
 	return 0;
 }
=20
-static int ksm_merge_pages(void *addr, size_t size, struct timespec star=
t_time, int timeout)
+static int ksm_merge_pages(int merge_type, void *addr, size_t size,
+			struct timespec start_time, int timeout)
 {
-	if (madvise(addr, size, MADV_MERGEABLE)) {
-		perror("madvise");
-		return 1;
+	if (merge_type =3D=3D KSM_MERGE_MADVISE) {
+		if (madvise(addr, size, MADV_MERGEABLE)) {
+			perror("madvise");
+			return 1;
+		}
+	} else if (merge_type =3D=3D KSM_MERGE_PRCTL) {
+		if (prctl(PR_SET_MEMORY_MERGE, 1)) {
+			perror("prctl");
+			return 1;
+		}
 	}
+
 	if (ksm_write_sysfs(KSM_FP("run"), 1))
 		return 1;
=20
@@ -211,6 +286,11 @@ static bool assert_ksm_pages_count(long dupl_page_co=
unt)
 	    ksm_read_sysfs(KSM_FP("max_page_sharing"), &max_page_sharing))
 		return false;
=20
+#ifdef DEBUG
+	ksm_print_sysfs();
+	ksm_print_procfs();
+#endif
+
 	/*
 	 * Since there must be at least 2 pages for merging and 1 page can be
 	 * shared with the limited number of pages (max_page_sharing), sometime=
s
@@ -266,7 +346,8 @@ static int ksm_restore(struct ksm_sysfs *ksm_sysfs)
 	return 0;
 }
=20
-static int check_ksm_merge(int mapping, int prot, long page_count, int t=
imeout, size_t page_size)
+static int check_ksm_merge(int merge_type, int mapping, int prot,
+			long page_count, int timeout, size_t page_size)
 {
 	void *map_ptr;
 	struct timespec start_time;
@@ -281,13 +362,16 @@ static int check_ksm_merge(int mapping, int prot, l=
ong page_count, int timeout,
 	if (!map_ptr)
 		return KSFT_FAIL;
=20
-	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeou=
t))
+	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_=
time, timeout))
 		goto err_out;
=20
 	/* verify that the right number of pages are merged */
 	if (assert_ksm_pages_count(page_count)) {
 		printf("OK\n");
-		munmap(map_ptr, page_size * page_count);
+		if (merge_type =3D=3D KSM_MERGE_MADVISE)
+			munmap(map_ptr, page_size * page_count);
+		else if (merge_type =3D=3D KSM_MERGE_PRCTL)
+			prctl(PR_SET_MEMORY_MERGE, 0);
 		return KSFT_PASS;
 	}
=20
@@ -297,7 +381,73 @@ static int check_ksm_merge(int mapping, int prot, lo=
ng page_count, int timeout,
 	return KSFT_FAIL;
 }
=20
-static int check_ksm_unmerge(int mapping, int prot, int timeout, size_t =
page_size)
+/* Verify that prctl ksm flag is inherited. */
+static int check_ksm_fork(void)
+{
+	int rc =3D KSFT_FAIL;
+	pid_t child_pid;
+
+	if (prctl(PR_SET_MEMORY_MERGE, 1)) {
+		perror("prctl");
+		return KSFT_FAIL;
+	}
+
+	child_pid =3D fork();
+	if (child_pid =3D=3D 0) {
+		int is_on =3D prctl(PR_GET_MEMORY_MERGE, 0);
+
+		if (!is_on)
+			exit(KSFT_FAIL);
+
+		exit(KSFT_PASS);
+	}
+
+	if (child_pid < 0)
+		goto out;
+
+	if (waitpid(child_pid, &rc, 0) < 0)
+		rc =3D KSFT_FAIL;
+
+	if (prctl(PR_SET_MEMORY_MERGE, 0)) {
+		perror("prctl");
+		rc =3D KSFT_FAIL;
+	}
+
+out:
+	if (rc =3D=3D KSFT_PASS)
+		printf("OK\n");
+	else
+		printf("Not OK\n");
+
+	return rc;
+}
+
+static int check_ksm_get_merge_type(void)
+{
+	if (prctl(PR_SET_MEMORY_MERGE, 1)) {
+		perror("prctl set");
+		return 1;
+	}
+
+	int is_on =3D prctl(PR_GET_MEMORY_MERGE, 0);
+
+	if (prctl(PR_SET_MEMORY_MERGE, 0)) {
+		perror("prctl set");
+		return 1;
+	}
+
+	int is_off =3D prctl(PR_GET_MEMORY_MERGE, 0);
+
+	if (is_on && is_off) {
+		printf("OK\n");
+		return KSFT_PASS;
+	}
+
+	printf("Not OK\n");
+	return KSFT_FAIL;
+}
+
+static int check_ksm_unmerge(int merge_type, int mapping, int prot, int =
timeout, size_t page_size)
 {
 	void *map_ptr;
 	struct timespec start_time;
@@ -313,7 +463,7 @@ static int check_ksm_unmerge(int mapping, int prot, i=
nt timeout, size_t page_siz
 	if (!map_ptr)
 		return KSFT_FAIL;
=20
-	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeou=
t))
+	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_=
time, timeout))
 		goto err_out;
=20
 	/* change 1 byte in each of the 2 pages -- KSM must automatically unmer=
ge them */
@@ -337,8 +487,8 @@ static int check_ksm_unmerge(int mapping, int prot, i=
nt timeout, size_t page_siz
 	return KSFT_FAIL;
 }
=20
-static int check_ksm_zero_page_merge(int mapping, int prot, long page_co=
unt, int timeout,
-				     bool use_zero_pages, size_t page_size)
+static int check_ksm_zero_page_merge(int merge_type, int mapping, int pr=
ot, long page_count,
+				int timeout, bool use_zero_pages, size_t page_size)
 {
 	void *map_ptr;
 	struct timespec start_time;
@@ -356,7 +506,7 @@ static int check_ksm_zero_page_merge(int mapping, int=
 prot, long page_count, int
 	if (!map_ptr)
 		return KSFT_FAIL;
=20
-	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeou=
t))
+	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_=
time, timeout))
 		goto err_out;
=20
        /*
@@ -402,8 +552,8 @@ static int get_first_mem_node(void)
 	return get_next_mem_node(numa_max_node());
 }
=20
-static int check_ksm_numa_merge(int mapping, int prot, int timeout, bool=
 merge_across_nodes,
-				size_t page_size)
+static int check_ksm_numa_merge(int merge_type, int mapping, int prot, i=
nt timeout,
+				bool merge_across_nodes, size_t page_size)
 {
 	void *numa1_map_ptr, *numa2_map_ptr;
 	struct timespec start_time;
@@ -439,8 +589,8 @@ static int check_ksm_numa_merge(int mapping, int prot=
, int timeout, bool merge_a
 	memset(numa2_map_ptr, '*', page_size);
=20
 	/* try to merge the pages */
-	if (ksm_merge_pages(numa1_map_ptr, page_size, start_time, timeout) ||
-	    ksm_merge_pages(numa2_map_ptr, page_size, start_time, timeout))
+	if (ksm_merge_pages(merge_type, numa1_map_ptr, page_size, start_time, t=
imeout) ||
+	    ksm_merge_pages(merge_type, numa2_map_ptr, page_size, start_time, t=
imeout))
 		goto err_out;
=20
        /*
@@ -466,7 +616,8 @@ static int check_ksm_numa_merge(int mapping, int prot=
, int timeout, bool merge_a
 	return KSFT_FAIL;
 }
=20
-static int ksm_merge_hugepages_time(int mapping, int prot, int timeout, =
size_t map_size)
+static int ksm_merge_hugepages_time(int merge_type, int mapping, int pro=
t,
+				int timeout, size_t map_size)
 {
 	void *map_ptr, *map_ptr_orig;
 	struct timespec start_time, end_time;
@@ -508,7 +659,7 @@ static int ksm_merge_hugepages_time(int mapping, int =
prot, int timeout, size_t m
 		perror("clock_gettime");
 		goto err_out;
 	}
-	if (ksm_merge_pages(map_ptr, map_size, start_time, timeout))
+	if (ksm_merge_pages(merge_type, map_ptr, map_size, start_time, timeout)=
)
 		goto err_out;
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
 		perror("clock_gettime");
@@ -533,7 +684,7 @@ static int ksm_merge_hugepages_time(int mapping, int =
prot, int timeout, size_t m
 	return KSFT_FAIL;
 }
=20
-static int ksm_merge_time(int mapping, int prot, int timeout, size_t map=
_size)
+static int ksm_merge_time(int merge_type, int mapping, int prot, int tim=
eout, size_t map_size)
 {
 	void *map_ptr;
 	struct timespec start_time, end_time;
@@ -549,7 +700,7 @@ static int ksm_merge_time(int mapping, int prot, int =
timeout, size_t map_size)
 		perror("clock_gettime");
 		goto err_out;
 	}
-	if (ksm_merge_pages(map_ptr, map_size, start_time, timeout))
+	if (ksm_merge_pages(merge_type, map_ptr, map_size, start_time, timeout)=
)
 		goto err_out;
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_time)) {
 		perror("clock_gettime");
@@ -574,7 +725,7 @@ static int ksm_merge_time(int mapping, int prot, int =
timeout, size_t map_size)
 	return KSFT_FAIL;
 }
=20
-static int ksm_unmerge_time(int mapping, int prot, int timeout, size_t m=
ap_size)
+static int ksm_unmerge_time(int merge_type, int mapping, int prot, int t=
imeout, size_t map_size)
 {
 	void *map_ptr;
 	struct timespec start_time, end_time;
@@ -589,7 +740,7 @@ static int ksm_unmerge_time(int mapping, int prot, in=
t timeout, size_t map_size)
 		perror("clock_gettime");
 		goto err_out;
 	}
-	if (ksm_merge_pages(map_ptr, map_size, start_time, timeout))
+	if (ksm_merge_pages(merge_type, map_ptr, map_size, start_time, timeout)=
)
 		goto err_out;
=20
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
@@ -621,7 +772,7 @@ static int ksm_unmerge_time(int mapping, int prot, in=
t timeout, size_t map_size)
 	return KSFT_FAIL;
 }
=20
-static int ksm_cow_time(int mapping, int prot, int timeout, size_t page_=
size)
+static int ksm_cow_time(int merge_type, int mapping, int prot, int timeo=
ut, size_t page_size)
 {
 	void *map_ptr;
 	struct timespec start_time, end_time;
@@ -660,7 +811,7 @@ static int ksm_cow_time(int mapping, int prot, int ti=
meout, size_t page_size)
 		memset(map_ptr + page_size * i, '+', i / 2 + 1);
 		memset(map_ptr + page_size * (i + 1), '+', i / 2 + 1);
 	}
-	if (ksm_merge_pages(map_ptr, page_size * page_count, start_time, timeou=
t))
+	if (ksm_merge_pages(merge_type, map_ptr, page_size * page_count, start_=
time, timeout))
 		goto err_out;
=20
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_time)) {
@@ -697,6 +848,7 @@ int main(int argc, char *argv[])
 	int ret, opt;
 	int prot =3D 0;
 	int ksm_scan_limit_sec =3D KSM_SCAN_LIMIT_SEC_DEFAULT;
+	int merge_type =3D KSM_MERGE_TYPE_DEFAULT;
 	long page_count =3D KSM_PAGE_COUNT_DEFAULT;
 	size_t page_size =3D sysconf(_SC_PAGESIZE);
 	struct ksm_sysfs ksm_sysfs_old;
@@ -705,7 +857,7 @@ int main(int argc, char *argv[])
 	bool merge_across_nodes =3D KSM_MERGE_ACROSS_NODES_DEFAULT;
 	long size_MB =3D 0;
=20
-	while ((opt =3D getopt(argc, argv, "ha:p:l:z:m:s:MUZNPCHD")) !=3D -1) {
+	while ((opt =3D getopt(argc, argv, "ha:p:l:z:m:s:t:FGMUZNPCHD")) !=3D -=
1) {
 		switch (opt) {
 		case 'a':
 			prot =3D str_to_prot(optarg);
@@ -745,6 +897,20 @@ int main(int argc, char *argv[])
 				printf("Size must be greater than 0\n");
 				return KSFT_FAIL;
 			}
+		case 't':
+			{
+				int tmp =3D atoi(optarg);
+
+				if (tmp < 0 || tmp > KSM_MERGE_LAST) {
+					printf("Invalid merge type\n");
+					return KSFT_FAIL;
+				}
+				merge_type =3D atoi(optarg);
+			}
+			break;
+		case 'F':
+			test_name =3D CHECK_KSM_MERGE_FORK;
+			break;
 		case 'M':
 			break;
 		case 'U':
@@ -753,6 +919,9 @@ int main(int argc, char *argv[])
 		case 'Z':
 			test_name =3D CHECK_KSM_ZERO_PAGE_MERGE;
 			break;
+		case 'G':
+			test_name =3D CHECK_KSM_GET_MERGE_TYPE;
+			break;
 		case 'N':
 			test_name =3D CHECK_KSM_NUMA_MERGE;
 			break;
@@ -795,35 +964,42 @@ int main(int argc, char *argv[])
=20
 	switch (test_name) {
 	case CHECK_KSM_MERGE:
-		ret =3D check_ksm_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, page_count,
+		ret =3D check_ksm_merge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,=
 page_count,
 				      ksm_scan_limit_sec, page_size);
 		break;
+	case CHECK_KSM_MERGE_FORK:
+		ret =3D check_ksm_fork();
+		break;
 	case CHECK_KSM_UNMERGE:
-		ret =3D check_ksm_unmerge(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_=
limit_sec,
-					page_size);
+		ret =3D check_ksm_unmerge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, pro=
t,
+					ksm_scan_limit_sec, page_size);
+		break;
+	case CHECK_KSM_GET_MERGE_TYPE:
+		ret =3D check_ksm_get_merge_type();
 		break;
 	case CHECK_KSM_ZERO_PAGE_MERGE:
-		ret =3D check_ksm_zero_page_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, p=
age_count,
-						ksm_scan_limit_sec, use_zero_pages, page_size);
+		ret =3D check_ksm_zero_page_merge(merge_type, MAP_PRIVATE | MAP_ANONYM=
OUS, prot,
+						page_count, ksm_scan_limit_sec, use_zero_pages,
+						page_size);
 		break;
 	case CHECK_KSM_NUMA_MERGE:
-		ret =3D check_ksm_numa_merge(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_sc=
an_limit_sec,
-					   merge_across_nodes, page_size);
+		ret =3D check_ksm_numa_merge(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, =
prot,
+					ksm_scan_limit_sec, merge_across_nodes, page_size);
 		break;
 	case KSM_MERGE_TIME:
 		if (size_MB =3D=3D 0) {
 			printf("Option '-s' is required.\n");
 			return KSFT_FAIL;
 		}
-		ret =3D ksm_merge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_lim=
it_sec,
-				     size_MB);
+		ret =3D ksm_merge_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
+				ksm_scan_limit_sec, size_MB);
 		break;
 	case KSM_MERGE_TIME_HUGE_PAGES:
 		if (size_MB =3D=3D 0) {
 			printf("Option '-s' is required.\n");
 			return KSFT_FAIL;
 		}
-		ret =3D ksm_merge_hugepages_time(MAP_PRIVATE | MAP_ANONYMOUS, prot,
+		ret =3D ksm_merge_hugepages_time(merge_type, MAP_PRIVATE | MAP_ANONYMO=
US, prot,
 				ksm_scan_limit_sec, size_MB);
 		break;
 	case KSM_UNMERGE_TIME:
@@ -831,12 +1007,12 @@ int main(int argc, char *argv[])
 			printf("Option '-s' is required.\n");
 			return KSFT_FAIL;
 		}
-		ret =3D ksm_unmerge_time(MAP_PRIVATE | MAP_ANONYMOUS, prot,
+		ret =3D ksm_unmerge_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot=
,
 				       ksm_scan_limit_sec, size_MB);
 		break;
 	case KSM_COW_TIME:
-		ret =3D ksm_cow_time(MAP_PRIVATE | MAP_ANONYMOUS, prot, ksm_scan_limit=
_sec,
-				   page_size);
+		ret =3D ksm_cow_time(merge_type, MAP_PRIVATE | MAP_ANONYMOUS, prot,
+				ksm_scan_limit_sec, page_size);
 		break;
 	}
=20
--=20
2.30.2

