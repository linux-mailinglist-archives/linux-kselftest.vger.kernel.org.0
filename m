Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5281240B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2019 08:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfLRHxC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Dec 2019 02:53:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbfLRHxB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Dec 2019 02:53:01 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBI7qtbQ048490
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2019 02:53:00 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wybqph0a4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2019 02:52:58 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Wed, 18 Dec 2019 07:52:15 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Dec 2019 07:52:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBI7q99a60424336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 07:52:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90AF0AE051;
        Wed, 18 Dec 2019 07:52:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45850AE053;
        Wed, 18 Dec 2019 07:52:07 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Dec 2019 07:52:07 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, fweimer@redhat.com,
        dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com,
        mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v15 04/23] selftests/vm/pkeys: Move some definitions to arch-specific header
Date:   Wed, 18 Dec 2019 13:21:37 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576645161.git.sandipan@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1576645161.git.sandipan@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19121807-4275-0000-0000-000003903977
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121807-4276-0000-0000-000038A401B0
Message-Id: <50f232822f41eab4d9829748b5c3861cf448fe9e.1576645161.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_01:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=950 lowpriorityscore=0 suspectscore=2
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912180063
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Thiago Jung Bauermann <bauerman@linux.ibm.com>

This moves definitions which have arch-specific values to the
x86-specific header in preparation for multi-arch support.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    | 111 +------------
 tools/testing/selftests/vm/pkey-x86.h        | 156 +++++++++++++++++++
 tools/testing/selftests/vm/protection_keys.c |  47 ------
 3 files changed, 162 insertions(+), 152 deletions(-)
 create mode 100644 tools/testing/selftests/vm/pkey-x86.h

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 6ad1bd54ef94..3ed2f021bf7a 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -21,9 +21,6 @@
 
 #define PTR_ERR_ENOTSUP ((void *)-ENOTSUP)
 
-#define NR_PKEYS 16
-#define PKEY_BITS_PER_PKEY 2
-
 #ifndef DEBUG_LEVEL
 #define DEBUG_LEVEL 0
 #endif
@@ -73,19 +70,13 @@ extern void abort_hooks(void);
 	}					\
 } while (0)
 
+#if defined(__i386__) || defined(__x86_64__) /* arch */
+#include "pkey-x86.h"
+#else /* arch */
+#error Architecture not supported
+#endif /* arch */
+
 extern unsigned int shadow_pkey_reg;
-static inline unsigned int __read_pkey_reg(void)
-{
-	unsigned int eax, edx;
-	unsigned int ecx = 0;
-	unsigned int pkey_reg;
-
-	asm volatile(".byte 0x0f,0x01,0xee\n\t"
-		     : "=a" (eax), "=d" (edx)
-		     : "c" (ecx));
-	pkey_reg = eax;
-	return pkey_reg;
-}
 
 static inline unsigned int _read_pkey_reg(int line)
 {
@@ -100,19 +91,6 @@ static inline unsigned int _read_pkey_reg(int line)
 
 #define read_pkey_reg() _read_pkey_reg(__LINE__)
 
-static inline void __write_pkey_reg(unsigned int pkey_reg)
-{
-	unsigned int eax = pkey_reg;
-	unsigned int ecx = 0;
-	unsigned int edx = 0;
-
-	dprintf4("%s() changing %08x to %08x\n", __func__,
-			__read_pkey_reg(), pkey_reg);
-	asm volatile(".byte 0x0f,0x01,0xef\n\t"
-		     : : "a" (eax), "c" (ecx), "d" (edx));
-	assert(pkey_reg == __read_pkey_reg());
-}
-
 static inline void write_pkey_reg(unsigned int pkey_reg)
 {
 	dprintf4("%s() changing %08x to %08x\n", __func__,
@@ -157,83 +135,6 @@ static inline void __pkey_write_allow(int pkey, int do_allow_write)
 	dprintf4("pkey_reg now: %08x\n", read_pkey_reg());
 }
 
-#define PAGE_SIZE 4096
-#define MB	(1<<20)
-
-static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
-		unsigned int *ecx, unsigned int *edx)
-{
-	/* ecx is often an input as well as an output. */
-	asm volatile(
-		"cpuid;"
-		: "=a" (*eax),
-		  "=b" (*ebx),
-		  "=c" (*ecx),
-		  "=d" (*edx)
-		: "0" (*eax), "2" (*ecx));
-}
-
-/* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx) */
-#define X86_FEATURE_PKU        (1<<3) /* Protection Keys for Userspace */
-#define X86_FEATURE_OSPKE      (1<<4) /* OS Protection Keys Enable */
-
-static inline int cpu_has_pku(void)
-{
-	unsigned int eax;
-	unsigned int ebx;
-	unsigned int ecx;
-	unsigned int edx;
-
-	eax = 0x7;
-	ecx = 0x0;
-	__cpuid(&eax, &ebx, &ecx, &edx);
-
-	if (!(ecx & X86_FEATURE_PKU)) {
-		dprintf2("cpu does not have PKU\n");
-		return 0;
-	}
-	if (!(ecx & X86_FEATURE_OSPKE)) {
-		dprintf2("cpu does not have OSPKE\n");
-		return 0;
-	}
-	return 1;
-}
-
-#define XSTATE_PKEY_BIT	(9)
-#define XSTATE_PKEY	0x200
-
-int pkey_reg_xstate_offset(void)
-{
-	unsigned int eax;
-	unsigned int ebx;
-	unsigned int ecx;
-	unsigned int edx;
-	int xstate_offset;
-	int xstate_size;
-	unsigned long XSTATE_CPUID = 0xd;
-	int leaf;
-
-	/* assume that XSTATE_PKEY is set in XCR0 */
-	leaf = XSTATE_PKEY_BIT;
-	{
-		eax = XSTATE_CPUID;
-		ecx = leaf;
-		__cpuid(&eax, &ebx, &ecx, &edx);
-
-		if (leaf == XSTATE_PKEY_BIT) {
-			xstate_offset = ebx;
-			xstate_size = eax;
-		}
-	}
-
-	if (xstate_size == 0) {
-		printf("could not find size/offset of PKEY in xsave state\n");
-		return 0;
-	}
-
-	return xstate_offset;
-}
-
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
 #define ALIGN_UP(x, align_to)	(((x) + ((align_to)-1)) & ~((align_to)-1))
 #define ALIGN_DOWN(x, align_to) ((x) & ~((align_to)-1))
diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
new file mode 100644
index 000000000000..2f04ade8ca9c
--- /dev/null
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _PKEYS_X86_H
+#define _PKEYS_X86_H
+
+#ifdef __i386__
+
+#ifndef SYS_mprotect_key
+# define SYS_mprotect_key	380
+#endif
+
+#ifndef SYS_pkey_alloc
+# define SYS_pkey_alloc		381
+# define SYS_pkey_free		382
+#endif
+
+#define REG_IP_IDX		REG_EIP
+#define si_pkey_offset		0x14
+
+#else
+
+#ifndef SYS_mprotect_key
+# define SYS_mprotect_key	329
+#endif
+
+#ifndef SYS_pkey_alloc
+# define SYS_pkey_alloc		330
+# define SYS_pkey_free		331
+#endif
+
+#define REG_IP_IDX		REG_RIP
+#define si_pkey_offset		0x20
+
+#endif
+
+#ifndef PKEY_DISABLE_ACCESS
+# define PKEY_DISABLE_ACCESS	0x1
+#endif
+
+#ifndef PKEY_DISABLE_WRITE
+# define PKEY_DISABLE_WRITE	0x2
+#endif
+
+#define NR_PKEYS		16
+#define PKEY_BITS_PER_PKEY	2
+#define HPAGE_SIZE		(1UL<<21)
+#define PAGE_SIZE		4096
+#define MB			(1<<20)
+
+static inline void __page_o_noops(void)
+{
+	/* 8-bytes of instruction * 512 bytes = 1 page */
+	asm(".rept 512 ; nopl 0x7eeeeeee(%eax) ; .endr");
+}
+
+static inline unsigned int __read_pkey_reg(void)
+{
+	unsigned int eax, edx;
+	unsigned int ecx = 0;
+	unsigned int pkey_reg;
+
+	asm volatile(".byte 0x0f,0x01,0xee\n\t"
+		     : "=a" (eax), "=d" (edx)
+		     : "c" (ecx));
+	pkey_reg = eax;
+	return pkey_reg;
+}
+
+static inline void __write_pkey_reg(unsigned int pkey_reg)
+{
+	unsigned int eax = pkey_reg;
+	unsigned int ecx = 0;
+	unsigned int edx = 0;
+
+	dprintf4("%s() changing %08x to %08x\n", __func__,
+			__read_pkey_reg(), pkey_reg);
+	asm volatile(".byte 0x0f,0x01,0xef\n\t"
+		     : : "a" (eax), "c" (ecx), "d" (edx));
+	assert(pkey_reg == __read_pkey_reg());
+}
+
+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+		unsigned int *ecx, unsigned int *edx)
+{
+	/* ecx is often an input as well as an output. */
+	asm volatile(
+		"cpuid;"
+		: "=a" (*eax),
+		  "=b" (*ebx),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (*eax), "2" (*ecx));
+}
+
+/* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx) */
+#define X86_FEATURE_PKU        (1<<3) /* Protection Keys for Userspace */
+#define X86_FEATURE_OSPKE      (1<<4) /* OS Protection Keys Enable */
+
+static inline int cpu_has_pku(void)
+{
+	unsigned int eax;
+	unsigned int ebx;
+	unsigned int ecx;
+	unsigned int edx;
+
+	eax = 0x7;
+	ecx = 0x0;
+	__cpuid(&eax, &ebx, &ecx, &edx);
+
+	if (!(ecx & X86_FEATURE_PKU)) {
+		dprintf2("cpu does not have PKU\n");
+		return 0;
+	}
+	if (!(ecx & X86_FEATURE_OSPKE)) {
+		dprintf2("cpu does not have OSPKE\n");
+		return 0;
+	}
+	return 1;
+}
+
+#define XSTATE_PKEY_BIT	(9)
+#define XSTATE_PKEY	0x200
+
+int pkey_reg_xstate_offset(void)
+{
+	unsigned int eax;
+	unsigned int ebx;
+	unsigned int ecx;
+	unsigned int edx;
+	int xstate_offset;
+	int xstate_size;
+	unsigned long XSTATE_CPUID = 0xd;
+	int leaf;
+
+	/* assume that XSTATE_PKEY is set in XCR0 */
+	leaf = XSTATE_PKEY_BIT;
+	{
+		eax = XSTATE_CPUID;
+		ecx = leaf;
+		__cpuid(&eax, &ebx, &ecx, &edx);
+
+		if (leaf == XSTATE_PKEY_BIT) {
+			xstate_offset = ebx;
+			xstate_size = eax;
+		}
+	}
+
+	if (xstate_size == 0) {
+		printf("could not find size/offset of PKEY in xsave state\n");
+		return 0;
+	}
+
+	return xstate_offset;
+}
+
+#endif /* _PKEYS_X86_H */
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 42ffb58810f2..2d0e881f109d 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -49,9 +49,6 @@ int iteration_nr = 1;
 int test_nr;
 
 unsigned int shadow_pkey_reg;
-
-#define HPAGE_SIZE	(1UL<<21)
-
 int dprint_in_signal;
 char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
 
@@ -137,12 +134,6 @@ void abort_hooks(void)
 #endif
 }
 
-static inline void __page_o_noops(void)
-{
-	/* 8-bytes of instruction * 512 bytes = 1 page */
-	asm(".rept 512 ; nopl 0x7eeeeeee(%eax) ; .endr");
-}
-
 /*
  * This attempts to have roughly a page of instructions followed by a few
  * instructions that do a write, and another page of instructions.  That
@@ -165,36 +156,6 @@ void lots_o_noops_around_write(int *write_to_me)
 	dprintf3("%s() done\n", __func__);
 }
 
-#ifdef __i386__
-
-#ifndef SYS_mprotect_key
-# define SYS_mprotect_key	380
-#endif
-
-#ifndef SYS_pkey_alloc
-# define SYS_pkey_alloc		381
-# define SYS_pkey_free		382
-#endif
-
-#define REG_IP_IDX		REG_EIP
-#define si_pkey_offset		0x14
-
-#else
-
-#ifndef SYS_mprotect_key
-# define SYS_mprotect_key	329
-#endif
-
-#ifndef SYS_pkey_alloc
-# define SYS_pkey_alloc		330
-# define SYS_pkey_free		331
-#endif
-
-#define REG_IP_IDX		REG_RIP
-#define si_pkey_offset		0x20
-
-#endif
-
 void dump_mem(void *dumpme, int len_bytes)
 {
 	char *c = (void *)dumpme;
@@ -367,14 +328,6 @@ pid_t fork_lazy_child(void)
 	return forkret;
 }
 
-#ifndef PKEY_DISABLE_ACCESS
-# define PKEY_DISABLE_ACCESS	0x1
-#endif
-
-#ifndef PKEY_DISABLE_WRITE
-# define PKEY_DISABLE_WRITE	0x2
-#endif
-
 static u32 hw_pkey_get(int pkey, unsigned long flags)
 {
 	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
-- 
2.17.1

