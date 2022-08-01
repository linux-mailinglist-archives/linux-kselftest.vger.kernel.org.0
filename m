Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC4158657A
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Aug 2022 09:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiHAHDK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Aug 2022 03:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiHAHDG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Aug 2022 03:03:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDB12E69E;
        Mon,  1 Aug 2022 00:03:01 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2714lS9C023845;
        Mon, 1 Aug 2022 07:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=w2CzB8RlNXgMzpTNE7P+a9aNBumv3g7pDGqwsaf3IpU=;
 b=f6t/SuBmwsH2A7/kdWlsuq3ZjJZbpLdtfvqVftb7x4xqEmBwWyUeJirlA+y2Y0qoRECW
 WGpKLHalRHbTXRyHZ04GgvtjM8LUDe2bpw3/lMaw10GNzlyqclTtAVyDO6RgI0YCchuG
 OJxStn47BwUFgTPlw72Fak40/krssxbJ0zdJDCAwJs05KaoNIFrPE14y01kUybycJLb/
 6IUu3pDqcX03MOyqDwfaJbNxfsmoB0T7Vj3sAivDQESNrPgi6mAZ6kn6bPefxyE61oU4
 9nQIN4P6ZTuHSfvnP8CrqSItv4aNLFOZCTUpA4CXJ1r9KABxhDou9ONJ3LOMK8gCrp0x KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hp847bh5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 07:02:55 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2715od7D002060;
        Mon, 1 Aug 2022 07:02:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hp847bh4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 07:02:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2716pn3X028397;
        Mon, 1 Aug 2022 07:02:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3hmv98hu36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 07:02:52 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27172nnQ24052210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Aug 2022 07:02:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C8EFAE053;
        Mon,  1 Aug 2022 07:02:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87BDDAE045;
        Mon,  1 Aug 2022 07:02:44 +0000 (GMT)
Received: from li-efb8054c-3504-11b2-a85c-ca10df28279e.ibm.com.com (unknown [9.43.79.109])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Aug 2022 07:02:44 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tsahu@linux.ibm.com, akpm@linux-foundation.org, shuah@kernel.org,
        jglisse@redhat.com, aneesh.kumar@linux.ibm.com,
        sbhat@linux.ibm.com, vaibhav@linux.ibm.com
Subject: [PATCH]Kselftests: Removing support of libhugetlbfs from kselftests
Date:   Mon,  1 Aug 2022 12:32:31 +0530
Message-Id: <20220801070231.13831-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DPXSt_5IVOrUcBiOSZBJC3PqIAVelhtC
X-Proofpoint-ORIG-GUID: ZRcRRz5EZ69QKfzDnZvmSV5CeVHCkIyG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_03,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

libhugetlbfs, the user side utitlity to work with hugepages, does not
have any active support. There are only 2 selftests which are part of
in vm/hmm_test.c that depends on libhugetlbfs.

This patch modifes the tests so that they will not require
libhugetlb library.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
Instead of using general function from libhugetlbfs, this patch only
uses the required part from it which are actually being used in these
tests.

Results:
I tested it on Power9 with hash page translation(Hugepage size=16M)
and Power10 with radix page translation(Hugepage size=2M).

tools/testing/selftests/vm/Makefile        |  17 ----
 tools/testing/selftests/vm/check_config.sh |  31 ------
 tools/testing/selftests/vm/hmm-tests.c     | 108 ++++++++++++++-------
 3 files changed, 73 insertions(+), 83 deletions(-)
 delete mode 100644 tools/testing/selftests/vm/check_config.sh

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 44f25acfbeca..006b7747b7fd 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -152,23 +152,6 @@ endif
 
 $(OUTPUT)/mlock-random-test $(OUTPUT)/memfd_secret: LDLIBS += -lcap
 
-# HMM_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
-$(OUTPUT)/hmm-tests: LDLIBS += $(HMM_EXTRA_LIBS)
-
 $(OUTPUT)/ksm_tests: LDLIBS += -lnuma
 
 $(OUTPUT)/migration: LDLIBS += -lnuma
-
-local_config.mk local_config.h: check_config.sh
-	/bin/sh ./check_config.sh $(CC)
-
-EXTRA_CLEAN += local_config.mk local_config.h
-
-ifeq ($(HMM_EXTRA_LIBS),)
-all: warn_missing_hugelibs
-
-warn_missing_hugelibs:
-	@echo ; \
-	echo "Warning: missing libhugetlbfs support. Some HMM tests will be skipped." ; \
-	echo
-endif
diff --git a/tools/testing/selftests/vm/check_config.sh b/tools/testing/selftests/vm/check_config.sh
deleted file mode 100644
index 079c8a40b85d..000000000000
--- a/tools/testing/selftests/vm/check_config.sh
+++ /dev/null
@@ -1,31 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Probe for libraries and create header files to record the results. Both C
-# header files and Makefile include fragments are created.
-
-OUTPUT_H_FILE=local_config.h
-OUTPUT_MKFILE=local_config.mk
-
-# libhugetlbfs
-tmpname=$(mktemp)
-tmpfile_c=${tmpname}.c
-tmpfile_o=${tmpname}.o
-
-echo "#include <sys/types.h>"        > $tmpfile_c
-echo "#include <hugetlbfs.h>"       >> $tmpfile_c
-echo "int func(void) { return 0; }" >> $tmpfile_c
-
-CC=${1:?"Usage: $0 <compiler> # example compiler: gcc"}
-$CC -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1
-
-if [ -f $tmpfile_o ]; then
-    echo "#define LOCAL_CONFIG_HAVE_LIBHUGETLBFS 1" > $OUTPUT_H_FILE
-    echo "HMM_EXTRA_LIBS = -lhugetlbfs"             > $OUTPUT_MKFILE
-else
-    echo "// No libhugetlbfs support found"      > $OUTPUT_H_FILE
-    echo "# No libhugetlbfs support found, so:"  > $OUTPUT_MKFILE
-    echo "HMM_EXTRA_LIBS = "                    >> $OUTPUT_MKFILE
-fi
-
-rm ${tmpname}.*
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
index 203323967b50..bcb80f35b81b 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -26,10 +26,6 @@
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 
-#include "./local_config.h"
-#ifdef LOCAL_CONFIG_HAVE_LIBHUGETLBFS
-#include <hugetlbfs.h>
-#endif
 
 /*
  * This is a private UAPI to the kernel test module so it isn't exported
@@ -666,7 +662,54 @@ TEST_F(hmm, anon_write_huge)
 	hmm_buffer_free(buffer);
 }
 
-#ifdef LOCAL_CONFIG_HAVE_LIBHUGETLBFS
+/*
+ * Read numeric data from raw and tagged kernel status files.  Used to read
+ * /proc and /sys data (without a tag) and from /proc/meminfo (with a tag).
+ */
+static long file_read_ulong(char *file, const char *tag)
+{
+	int fd;
+	char buf[2048];
+	int len;
+	char *p, *q;
+	long val;
+
+	fd = open(file, O_RDONLY);
+	if (fd < 0) {
+		/* Error opening the file */
+		return -1;
+	}
+
+	len = read(fd, buf, sizeof(buf));
+	close(fd);
+	if (len < 0) {
+		/* Error in reading the file */
+		return -1;
+	}
+	if (len == sizeof(buf)) {
+		/* Error file is too large */
+		return -1;
+	}
+	buf[len] = '\0';
+
+	/* Search for a tag if provided */
+	if (tag) {
+		p = strstr(buf, tag);
+		if (!p)
+			return -1; /* looks like the line we want isn't there */
+		p += strlen(tag);
+	} else
+		p = buf;
+
+	val = strtol(p, &q, 0);
+	if (*q != ' ') {
+		/* Error parsing the file */
+		return -1;
+	}
+
+	return val;
+}
+
 /*
  * Write huge TLBFS page.
  */
@@ -675,29 +718,27 @@ TEST_F(hmm, anon_write_hugetlbfs)
 	struct hmm_buffer *buffer;
 	unsigned long npages;
 	unsigned long size;
+	unsigned long default_hsize;
 	unsigned long i;
 	int *ptr;
 	int ret;
-	long pagesizes[4];
-	int n, idx;
-
-	/* Skip test if we can't allocate a hugetlbfs page. */
 
-	n = gethugepagesizes(pagesizes, 4);
-	if (n <= 0)
+	default_hsize = file_read_ulong("/proc/meminfo", "Hugepagesize:");
+	if (default_hsize < 0 || default_hsize*1024 < default_hsize)
 		SKIP(return, "Huge page size could not be determined");
-	for (idx = 0; --n > 0; ) {
-		if (pagesizes[n] < pagesizes[idx])
-			idx = n;
-	}
-	size = ALIGN(TWOMEG, pagesizes[idx]);
+	default_hsize = default_hsize*1024; /* KB to B */
+
+	size = ALIGN(TWOMEG, default_hsize);
 	npages = size >> self->page_shift;
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
 
-	buffer->ptr = get_hugepage_region(size, GHR_STRICT);
-	if (buffer->ptr == NULL) {
+	buffer->ptr = mmap(NULL, size,
+				   PROT_READ | PROT_WRITE,
+				   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+				   -1, 0);
+	if (buffer->ptr == MAP_FAILED) {
 		free(buffer);
 		SKIP(return, "Huge page could not be allocated");
 	}
@@ -721,11 +762,10 @@ TEST_F(hmm, anon_write_hugetlbfs)
 	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
 		ASSERT_EQ(ptr[i], i);
 
-	free_hugepage_region(buffer->ptr);
+	munmap(buffer->ptr, buffer->size);
 	buffer->ptr = NULL;
 	hmm_buffer_free(buffer);
 }
-#endif /* LOCAL_CONFIG_HAVE_LIBHUGETLBFS */
 
 /*
  * Read mmap'ed file memory.
@@ -1384,7 +1424,6 @@ TEST_F(hmm2, snapshot)
 	hmm_buffer_free(buffer);
 }
 
-#ifdef LOCAL_CONFIG_HAVE_LIBHUGETLBFS
 /*
  * Test the hmm_range_fault() HMM_PFN_PMD flag for large pages that
  * should be mapped by a large page table entry.
@@ -1394,30 +1433,30 @@ TEST_F(hmm, compound)
 	struct hmm_buffer *buffer;
 	unsigned long npages;
 	unsigned long size;
+	unsigned long default_hsize;
 	int *ptr;
 	unsigned char *m;
 	int ret;
-	long pagesizes[4];
-	int n, idx;
 	unsigned long i;
 
 	/* Skip test if we can't allocate a hugetlbfs page. */
 
-	n = gethugepagesizes(pagesizes, 4);
-	if (n <= 0)
-		return;
-	for (idx = 0; --n > 0; ) {
-		if (pagesizes[n] < pagesizes[idx])
-			idx = n;
-	}
-	size = ALIGN(TWOMEG, pagesizes[idx]);
+	default_hsize = file_read_ulong("/proc/meminfo", "Hugepagesize:");
+	if (default_hsize < 0 || default_hsize*1024 < default_hsize)
+		SKIP(return, "Huge page size could not be determined");
+	default_hsize = default_hsize*1024; /* KB to B */
+
+	size = ALIGN(TWOMEG, default_hsize);
 	npages = size >> self->page_shift;
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
 
-	buffer->ptr = get_hugepage_region(size, GHR_STRICT);
-	if (buffer->ptr == NULL) {
+	buffer->ptr = mmap(NULL, size,
+				   PROT_READ | PROT_WRITE,
+				   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+				   -1, 0);
+	if (buffer->ptr == MAP_FAILED) {
 		free(buffer);
 		return;
 	}
@@ -1456,11 +1495,10 @@ TEST_F(hmm, compound)
 		ASSERT_EQ(m[i], HMM_DMIRROR_PROT_READ |
 				HMM_DMIRROR_PROT_PMD);
 
-	free_hugepage_region(buffer->ptr);
+	munmap(buffer->ptr, buffer->size);
 	buffer->ptr = NULL;
 	hmm_buffer_free(buffer);
 }
-#endif /* LOCAL_CONFIG_HAVE_LIBHUGETLBFS */
 
 /*
  * Test two devices reading the same memory (double mapped).
-- 
2.35.1

