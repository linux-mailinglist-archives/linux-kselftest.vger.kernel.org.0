Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D2719E794
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Apr 2020 22:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgDDUhp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Apr 2020 16:37:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbgDDUhm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Apr 2020 16:37:42 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 034KYZmI027865
        for <linux-kselftest@vger.kernel.org>; Sat, 4 Apr 2020 16:37:40 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 306x9htrf9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Apr 2020 16:37:40 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <svens@linux.ibm.com>;
        Sat, 4 Apr 2020 21:37:18 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 4 Apr 2020 21:37:15 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 034KaUMg50921918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 4 Apr 2020 20:36:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F216211C054;
        Sat,  4 Apr 2020 20:37:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD7C611C052;
        Sat,  4 Apr 2020 20:37:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  4 Apr 2020 20:37:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 9AFB3E0193; Sat,  4 Apr 2020 22:37:33 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     svens@stackframe.org, Thomas Gleixner <tglx@linutronix.de>,
        Steve Winslow <swinslow@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 2/2] selftests/vDSO: make vDSO test work on s390x
Date:   Sat,  4 Apr 2020 22:37:04 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200404203704.69412-1-svens@linux.ibm.com>
References: <20200404203704.69412-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20040420-0016-0000-0000-000002FE6043
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040420-0017-0000-0000-0000336232A4
Message-Id: <20200404203704.69412-2-svens@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-04_17:2020-04-03,2020-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004040185
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

s390x used 8 byte (Elf64_Xword) sized hash table entries.
Add some code to the vdso test to handle that properly.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 tools/testing/selftests/vDSO/parse_vdso.c | 14 ++++++++++----
 tools/testing/selftests/vDSO/vdso_test.c  | 11 +++++++----
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 8e5a70a24d9a..2e1e88ebee3d 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -58,6 +58,12 @@ extern void *vdso_sym(const char *version, const char *name);
 #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
 #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
 
+#if defined(__s390x__)
+#define	ELF_HASH_TYPE ELF(Xword)
+#else
+#define	ELF_HASH_TYPE ELF(Word)
+#endif
+
 static struct vdso_info
 {
 	bool valid;
@@ -69,8 +75,8 @@ static struct vdso_info
 	/* Symbol table */
 	ELF(Sym) *symtab;
 	const char *symstrings;
-	ELF(Word) *bucket, *chain;
-	ELF(Word) nbucket, nchain;
+	ELF_HASH_TYPE *bucket, *chain;
+	ELF_HASH_TYPE nbucket, nchain;
 
 	/* Version table */
 	ELF(Versym) *versym;
@@ -131,7 +137,7 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 	/*
 	 * Fish out the useful bits of the dynamic table.
 	 */
-	ELF(Word) *hash = 0;
+	ELF_HASH_TYPE *hash = 0;
 	vdso_info.symstrings = 0;
 	vdso_info.symtab = 0;
 	vdso_info.versym = 0;
@@ -149,7 +155,7 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 				 + vdso_info.load_offset);
 			break;
 		case DT_HASH:
-			hash = (ELF(Word) *)
+			hash = (ELF_HASH_TYPE *)
 				((uintptr_t)dyn[i].d_un.d_ptr
 				 + vdso_info.load_offset);
 			break;
diff --git a/tools/testing/selftests/vDSO/vdso_test.c b/tools/testing/selftests/vDSO/vdso_test.c
index 719d5a6bd664..2b21261a5eba 100644
--- a/tools/testing/selftests/vDSO/vdso_test.c
+++ b/tools/testing/selftests/vDSO/vdso_test.c
@@ -22,11 +22,14 @@ extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
 extern void vdso_init_from_auxv(void *auxv);
 
 /*
- * ARM64's vDSO exports its gettimeofday() implementation with a different
- * name and version from other architectures, so we need to handle it as
- * a special case.
+ * Both ARM64's and s390x' vDSO exports its gettimeofday() implementation
+ * with a different name and version from other architectures, so we need
+ * to handle them as a special case.
  */
-#if defined(__aarch64__)
+#if defined(__s390x__)
+const char *version = "LINUX_2.6.29";
+const char *name = "__kernel_gettimeofday";
+#elif defined(__aarch64__)
 const char *version = "LINUX_2.6.39";
 const char *name = "__kernel_gettimeofday";
 #else
-- 
2.17.1

