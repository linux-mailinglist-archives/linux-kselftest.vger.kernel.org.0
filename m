Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6671E361F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 05:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgE0DEE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 23:04:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbgE0DED (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 23:04:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04R32xoN165476;
        Tue, 26 May 2020 23:03:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3170b8ruxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 23:03:50 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04R330xu165563;
        Tue, 26 May 2020 23:03:50 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3170b8ruwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 23:03:49 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04R31JOW002507;
        Wed, 27 May 2020 03:03:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 316uf8y1es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 03:03:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04R32UYt66191632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 03:02:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C6F111C052;
        Wed, 27 May 2020 03:03:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2CD611C04A;
        Wed, 27 May 2020 03:03:42 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 May 2020 03:03:42 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linuxram@us.ibm.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        fweimer@redhat.com, ruscur@russell.cc
Subject: [PATCH v2] selftests: powerpc: Add test for execute-disabled pkeys
Date:   Wed, 27 May 2020 08:33:42 +0530
Message-Id: <20200527030342.13712-1-sandipan@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_04:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 cotscore=-2147483648 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 bulkscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270021
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Apart from read and write access, memory protection keys can
also be used for restricting execute permission of pages on
powerpc. This adds a test to verify if the feature works as
expected.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---

Previous versions can be found at
v1: https://lore.kernel.org/linuxppc-dev/20200508162332.65316-1-sandipan@linux.ibm.com/

Changes in v2:
- Added .gitignore entry for test binary.
- Fixed builds for older distros where siginfo_t might not have si_pkey as
  a formal member based on discussion with Michael.

---
 tools/testing/selftests/powerpc/mm/.gitignore |   1 +
 tools/testing/selftests/powerpc/mm/Makefile   |   3 +-
 .../selftests/powerpc/mm/pkey_exec_prot.c     | 336 ++++++++++++++++++
 3 files changed, 339 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/pkey_exec_prot.c

diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
index 2ca523255b1b..8f841f925baa 100644
--- a/tools/testing/selftests/powerpc/mm/.gitignore
+++ b/tools/testing/selftests/powerpc/mm/.gitignore
@@ -8,3 +8,4 @@ wild_bctr
 large_vm_fork_separation
 bad_accesses
 tlbie_test
+pkey_exec_prot
diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
index b9103c4bb414..2816229f648b 100644
--- a/tools/testing/selftests/powerpc/mm/Makefile
+++ b/tools/testing/selftests/powerpc/mm/Makefile
@@ -3,7 +3,7 @@ noarg:
 	$(MAKE) -C ../
 
 TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors wild_bctr \
-		  large_vm_fork_separation bad_accesses
+		  large_vm_fork_separation bad_accesses pkey_exec_prot
 TEST_GEN_PROGS_EXTENDED := tlbie_test
 TEST_GEN_FILES := tempfile
 
@@ -17,6 +17,7 @@ $(OUTPUT)/prot_sao: ../utils.c
 $(OUTPUT)/wild_bctr: CFLAGS += -m64
 $(OUTPUT)/large_vm_fork_separation: CFLAGS += -m64
 $(OUTPUT)/bad_accesses: CFLAGS += -m64
+$(OUTPUT)/pkey_exec_prot: CFLAGS += -m64
 
 $(OUTPUT)/tempfile:
 	dd if=/dev/zero of=$@ bs=64k count=1
diff --git a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
new file mode 100644
index 000000000000..147fb9ed47d5
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2020, Sandipan Das, IBM Corp.
+ *
+ * Test if applying execute protection on pages using memory
+ * protection keys works as expected.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+
+#include <time.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include "utils.h"
+
+/* Override definitions as they might be inconsistent */
+#undef PKEY_DISABLE_ACCESS
+#define PKEY_DISABLE_ACCESS	0x3
+
+#undef PKEY_DISABLE_WRITE
+#define PKEY_DISABLE_WRITE	0x2
+
+#undef PKEY_DISABLE_EXECUTE
+#define PKEY_DISABLE_EXECUTE	0x4
+
+/* Older distros might not define this */
+#ifndef SEGV_PKUERR
+#define SEGV_PKUERR	4
+#endif
+
+#define SI_PKEY_OFFSET	0x20
+
+#define SYS_pkey_mprotect	386
+#define SYS_pkey_alloc		384
+#define SYS_pkey_free		385
+
+#define PKEY_BITS_PER_PKEY	2
+#define NR_PKEYS		32
+
+#define PKEY_BITS_MASK		((1UL << PKEY_BITS_PER_PKEY) - 1)
+
+static unsigned long pkeyreg_get(void)
+{
+	unsigned long uamr;
+
+	asm volatile("mfspr	%0, 0xd" : "=r"(uamr));
+	return uamr;
+}
+
+static void pkeyreg_set(unsigned long uamr)
+{
+	asm volatile("isync; mtspr	0xd, %0; isync;" : : "r"(uamr));
+}
+
+static void pkey_set_rights(int pkey, unsigned long rights)
+{
+	unsigned long uamr, shift;
+
+	shift = (NR_PKEYS - pkey - 1) * PKEY_BITS_PER_PKEY;
+	uamr = pkeyreg_get();
+	uamr &= ~(PKEY_BITS_MASK << shift);
+	uamr |= (rights & PKEY_BITS_MASK) << shift;
+	pkeyreg_set(uamr);
+}
+
+static int sys_pkey_mprotect(void *addr, size_t len, int prot, int pkey)
+{
+	return syscall(SYS_pkey_mprotect, addr, len, prot, pkey);
+}
+
+static int sys_pkey_alloc(unsigned long flags, unsigned long rights)
+{
+	return syscall(SYS_pkey_alloc, flags, rights);
+}
+
+static int sys_pkey_free(int pkey)
+{
+	return syscall(SYS_pkey_free, pkey);
+}
+
+static volatile int fpkey, fcode, ftype, faults;
+static unsigned long pgsize, numinsns;
+static volatile unsigned int *faddr;
+static unsigned int *insns;
+
+static void segv_handler(int signum, siginfo_t *sinfo, void *ctx)
+{
+	int pkey;
+
+#ifdef si_pkey
+	pkey = sinfo->si_pkey;
+#else
+	pkey = *((int *)(((char *) sinfo) + SI_PKEY_OFFSET));
+#endif
+
+	/* Check if this fault originated because of the expected reasons */
+	if (sinfo->si_code != SEGV_ACCERR && sinfo->si_code != SEGV_PKUERR) {
+		printf("got an unexpected fault, code = %d\n",
+		       sinfo->si_code);
+		goto fail;
+	}
+
+	/* Check if this fault originated from the expected address */
+	if (sinfo->si_addr != (void *) faddr) {
+		printf("got an unexpected fault, addr = %p\n",
+		       sinfo->si_addr);
+		goto fail;
+	}
+
+	/* Check if the expected number of faults has been exceeded */
+	if (faults == 0)
+		goto fail;
+
+	fcode = sinfo->si_code;
+
+	/* Restore permissions in order to continue */
+	switch (fcode) {
+	case SEGV_ACCERR:
+		if (mprotect(insns, pgsize, PROT_READ | PROT_WRITE)) {
+			perror("mprotect");
+			goto fail;
+		}
+		break;
+	case SEGV_PKUERR:
+		if (pkey != fpkey)
+			goto fail;
+
+		if (ftype == PKEY_DISABLE_ACCESS) {
+			pkey_set_rights(fpkey, 0);
+		} else if (ftype == PKEY_DISABLE_EXECUTE) {
+			/*
+			 * Reassociate the exec-only pkey with the region
+			 * to be able to continue. Unlike AMR, we cannot
+			 * set IAMR directly from userspace to restore the
+			 * permissions.
+			 */
+			if (mprotect(insns, pgsize, PROT_EXEC)) {
+				perror("mprotect");
+				goto fail;
+			}
+		} else {
+			goto fail;
+		}
+		break;
+	}
+
+	faults--;
+	return;
+
+fail:
+	/* Restore all page permissions to avoid repetitive faults */
+	if (mprotect(insns, pgsize, PROT_READ | PROT_WRITE | PROT_EXEC))
+		perror("mprotect");
+	if (sinfo->si_code == SEGV_PKUERR)
+		pkey_set_rights(pkey, 0);
+	faults = -1;	/* Something unexpected happened */
+}
+
+static int pkeys_unsupported(void)
+{
+	bool using_hash = false;
+	char line[128];
+	int pkey;
+	FILE *f;
+
+	f = fopen("/proc/cpuinfo", "r");
+	FAIL_IF(!f);
+
+	/* Protection keys are currently supported on Hash MMU only */
+	while (fgets(line, sizeof(line), f)) {
+		if (strcmp(line, "MMU		: Hash\n") == 0) {
+			using_hash = true;
+			break;
+		}
+	}
+
+	fclose(f);
+	SKIP_IF(!using_hash);
+
+	/* Check if the system call is supported */
+	pkey = sys_pkey_alloc(0, 0);
+	SKIP_IF(pkey < 0);
+	sys_pkey_free(pkey);
+
+	return 0;
+}
+
+static int test(void)
+{
+	struct sigaction act;
+	int pkey, ret, i;
+
+	ret = pkeys_unsupported();
+	if (ret)
+		return ret;
+
+	/* Setup signal handler */
+	act.sa_handler = 0;
+	act.sa_sigaction = segv_handler;
+	FAIL_IF(sigprocmask(SIG_SETMASK, 0, &act.sa_mask) != 0);
+	act.sa_flags = SA_SIGINFO;
+	act.sa_restorer = 0;
+	FAIL_IF(sigaction(SIGSEGV, &act, NULL) != 0);
+
+	/* Setup executable region */
+	pgsize = sysconf(_SC_PAGESIZE);
+	numinsns = pgsize / sizeof(unsigned int);
+	insns = (unsigned int *) mmap(NULL, pgsize, PROT_READ | PROT_WRITE,
+				      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	FAIL_IF(insns == MAP_FAILED);
+
+	/* Write the instruction words */
+	for (i = 0; i < numinsns - 1; i++)
+		insns[i] = 0x60000000;		/* nop */
+
+	/*
+	 * Later, to jump to the executable region, we use a linked
+	 * branch which sets the return address automatically in LR.
+	 * Use that to return back.
+	 */
+	insns[numinsns - 1] = 0x4e800020;	/* blr */
+
+	/* Allocate a pkey that restricts execution */
+	pkey = sys_pkey_alloc(0, PKEY_DISABLE_EXECUTE);
+	FAIL_IF(pkey < 0);
+
+	/*
+	 * Pick a random instruction address from the executable
+	 * region.
+	 */
+	srand(time(NULL));
+	faddr = &insns[rand() % (numinsns - 1)];
+
+	/* The following two cases will avoid SEGV_PKUERR */
+	ftype = -1;
+	fpkey = -1;
+
+	/*
+	 * Read an instruction word from the address when AMR bits
+	 * are not set.
+	 *
+	 * This should not generate a fault as having PROT_EXEC
+	 * implicitly allows reads. The pkey currently restricts
+	 * execution only based on the IAMR bits. The AMR bits are
+	 * cleared.
+	 */
+	faults = 0;
+	FAIL_IF(sys_pkey_mprotect(insns, pgsize, PROT_EXEC, pkey) != 0);
+	printf("read from %p, pkey is execute-disabled\n", (void *) faddr);
+	i = *faddr;
+	FAIL_IF(faults != 0);
+
+	/*
+	 * Write an instruction word to the address when AMR bits
+	 * are not set.
+	 *
+	 * This should generate an access fault as having just
+	 * PROT_EXEC also restricts writes. The pkey currently
+	 * restricts execution only based on the IAMR bits. The
+	 * AMR bits are cleared.
+	 */
+	faults = 1;
+	FAIL_IF(sys_pkey_mprotect(insns, pgsize, PROT_EXEC, pkey) != 0);
+	printf("write to %p, pkey is execute-disabled\n", (void *) faddr);
+	*faddr = 0x60000000;	/* nop */
+	FAIL_IF(faults != 0 || fcode != SEGV_ACCERR);
+
+	/* The following three cases will generate SEGV_PKUERR */
+	ftype = PKEY_DISABLE_ACCESS;
+	fpkey = pkey;
+
+	/*
+	 * Read an instruction word from the address when AMR bits
+	 * are set.
+	 *
+	 * This should generate a pkey fault based on AMR bits only
+	 * as having PROT_EXEC implicitly allows reads.
+	 */
+	faults = 1;
+	FAIL_IF(sys_pkey_mprotect(insns, pgsize, PROT_EXEC, pkey) != 0);
+	printf("read from %p, pkey is execute-disabled, access-disabled\n",
+	       (void *) faddr);
+	pkey_set_rights(pkey, PKEY_DISABLE_ACCESS);
+	i = *faddr;
+	FAIL_IF(faults != 0 || fcode != SEGV_PKUERR);
+
+	/*
+	 * Write an instruction word to the address when AMR bits
+	 * are set.
+	 *
+	 * This should generate two faults. First, a pkey fault based
+	 * on AMR bits and then an access fault based on PROT_EXEC.
+	 */
+	faults = 2;
+	FAIL_IF(sys_pkey_mprotect(insns, pgsize, PROT_EXEC, pkey) != 0);
+	printf("write to %p, pkey is execute-disabled, access-disabled\n",
+	       (void *) faddr);
+	pkey_set_rights(pkey, PKEY_DISABLE_ACCESS);
+	*faddr = 0x60000000;	/* nop */
+	FAIL_IF(faults != 0 || fcode != SEGV_ACCERR);
+
+	/*
+	 * Jump to the executable region. This should generate a pkey
+	 * fault based on IAMR bits. AMR bits will not affect execution.
+	 */
+	faddr = insns;
+	ftype = PKEY_DISABLE_EXECUTE;
+	fpkey = pkey;
+	faults = 1;
+	FAIL_IF(sys_pkey_mprotect(insns, pgsize, PROT_EXEC, pkey) != 0);
+	pkey_set_rights(pkey, PKEY_DISABLE_ACCESS);
+	printf("execute at %p, ", (void *) faddr);
+	printf("pkey is execute-disabled, access-disabled\n");
+
+	/* Branch into the executable region */
+	asm volatile("mtctr	%0" : : "r"((unsigned long) insns));
+	asm volatile("bctrl");
+	FAIL_IF(faults != 0 || fcode != SEGV_PKUERR);
+
+	/* Cleanup */
+	munmap((void *) insns, pgsize);
+	sys_pkey_free(pkey);
+
+	return 0;
+}
+
+int main(void)
+{
+	test_harness(test, "pkey_exec_prot");
+}
-- 
2.25.1

