Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF3A21425B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2020 09:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgATIgp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jan 2020 03:36:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbgATIgp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jan 2020 03:36:45 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K8W3tM091080
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2020 03:36:44 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgc4qrm7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2020 03:36:44 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Mon, 20 Jan 2020 08:36:41 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Jan 2020 08:36:37 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00K8aaPQ58130590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 08:36:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDD7611C05B;
        Mon, 20 Jan 2020 08:36:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78A6811C04A;
        Mon, 20 Jan 2020 08:36:33 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jan 2020 08:36:33 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, fweimer@redhat.com,
        dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com,
        mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        msuchanek@suse.de, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v17 04/24] selftests/vm/pkeys: Move generic definitions to header file
Date:   Mon, 20 Jan 2020 14:06:01 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579507768.git.sandipan@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579507768.git.sandipan@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20012008-0020-0000-0000-000003A24814
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012008-0021-0000-0000-000021F9D227
Message-Id: <a454a369d8e11308dc7d9ad9ad52d4d24ef77bad.1579507768.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-19_08:2020-01-16,2020-01-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200076
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

Moved all the generic definition and helper functions to the
header file.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    | 35 +++++++++++++++++---
 tools/testing/selftests/vm/protection_keys.c | 27 ---------------
 2 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index d5779be4793f..6ad1bd54ef94 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -13,6 +13,14 @@
 #include <ucontext.h>
 #include <sys/mman.h>
 
+/* Define some kernel-like types */
+#define  u8 uint8_t
+#define u16 uint16_t
+#define u32 uint32_t
+#define u64 uint64_t
+
+#define PTR_ERR_ENOTSUP ((void *)-ENOTSUP)
+
 #define NR_PKEYS 16
 #define PKEY_BITS_PER_PKEY 2
 
@@ -53,6 +61,18 @@ static inline void sigsafe_printf(const char *format, ...)
 #define dprintf3(args...) dprintf_level(3, args)
 #define dprintf4(args...) dprintf_level(4, args)
 
+extern void abort_hooks(void);
+#define pkey_assert(condition) do {		\
+	if (!(condition)) {			\
+		dprintf0("assert() at %s::%d test_nr: %d iteration: %d\n", \
+				__FILE__, __LINE__,	\
+				test_nr, iteration_nr);	\
+		dprintf0("errno at assert: %d", errno);	\
+		abort_hooks();			\
+		exit(__LINE__);			\
+	}					\
+} while (0)
+
 extern unsigned int shadow_pkey_reg;
 static inline unsigned int __read_pkey_reg(void)
 {
@@ -137,11 +157,6 @@ static inline void __pkey_write_allow(int pkey, int do_allow_write)
 	dprintf4("pkey_reg now: %08x\n", read_pkey_reg());
 }
 
-#define PROT_PKEY0     0x10            /* protection key value (bit 0) */
-#define PROT_PKEY1     0x20            /* protection key value (bit 1) */
-#define PROT_PKEY2     0x40            /* protection key value (bit 2) */
-#define PROT_PKEY3     0x80            /* protection key value (bit 3) */
-
 #define PAGE_SIZE 4096
 #define MB	(1<<20)
 
@@ -219,4 +234,14 @@ int pkey_reg_xstate_offset(void)
 	return xstate_offset;
 }
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
+#define ALIGN_UP(x, align_to)	(((x) + ((align_to)-1)) & ~((align_to)-1))
+#define ALIGN_DOWN(x, align_to) ((x) & ~((align_to)-1))
+#define ALIGN_PTR_UP(p, ptr_align_to)	\
+	((typeof(p))ALIGN_UP((unsigned long)(p), ptr_align_to))
+#define ALIGN_PTR_DOWN(p, ptr_align_to)	\
+	((typeof(p))ALIGN_DOWN((unsigned long)(p), ptr_align_to))
+#define __stringify_1(x...)     #x
+#define __stringify(x...)       __stringify_1(x)
+
 #endif /* _PKEYS_HELPER_H */
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 2f4ab81c570d..42ffb58810f2 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -51,31 +51,10 @@ int test_nr;
 unsigned int shadow_pkey_reg;
 
 #define HPAGE_SIZE	(1UL<<21)
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
-#define ALIGN_UP(x, align_to)	(((x) + ((align_to)-1)) & ~((align_to)-1))
-#define ALIGN_DOWN(x, align_to) ((x) & ~((align_to)-1))
-#define ALIGN_PTR_UP(p, ptr_align_to)	((typeof(p))ALIGN_UP((unsigned long)(p),	ptr_align_to))
-#define ALIGN_PTR_DOWN(p, ptr_align_to)	((typeof(p))ALIGN_DOWN((unsigned long)(p),	ptr_align_to))
-#define __stringify_1(x...)     #x
-#define __stringify(x...)       __stringify_1(x)
-
-#define PTR_ERR_ENOTSUP ((void *)-ENOTSUP)
 
 int dprint_in_signal;
 char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
 
-extern void abort_hooks(void);
-#define pkey_assert(condition) do {		\
-	if (!(condition)) {			\
-		dprintf0("assert() at %s::%d test_nr: %d iteration: %d\n", \
-				__FILE__, __LINE__,	\
-				test_nr, iteration_nr);	\
-		dprintf0("errno at assert: %d", errno);	\
-		abort_hooks();			\
-		exit(__LINE__);			\
-	}					\
-} while (0)
-
 void cat_into_file(char *str, char *file)
 {
 	int fd = open(file, O_RDWR);
@@ -186,12 +165,6 @@ void lots_o_noops_around_write(int *write_to_me)
 	dprintf3("%s() done\n", __func__);
 }
 
-/* Define some kernel-like types */
-#define  u8 uint8_t
-#define u16 uint16_t
-#define u32 uint32_t
-#define u64 uint64_t
-
 #ifdef __i386__
 
 #ifndef SYS_mprotect_key
-- 
2.17.1

