Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403721EE4DF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jun 2020 14:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgFDM46 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Jun 2020 08:56:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17394 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbgFDM46 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Jun 2020 08:56:58 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 054CXZD2178236;
        Thu, 4 Jun 2020 08:56:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31c542fnjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jun 2020 08:56:45 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 054CXkpx178889;
        Thu, 4 Jun 2020 08:56:35 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31c542fnet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jun 2020 08:56:35 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 054CtqE4026050;
        Thu, 4 Jun 2020 12:56:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 31bf4842tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jun 2020 12:56:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 054CuEWd10092926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jun 2020 12:56:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65F36AE056;
        Thu,  4 Jun 2020 12:56:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3E71AE05A;
        Thu,  4 Jun 2020 12:56:12 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jun 2020 12:56:12 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linuxram@us.ibm.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        fweimer@redhat.com, ruscur@russell.cc
Subject: [PATCH v3 1/3] selftests: powerpc: Fix pkey access right updates
Date:   Thu,  4 Jun 2020 18:26:08 +0530
Message-Id: <20200604125610.649668-2-sandipan@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200604125610.649668-1-sandipan@linux.ibm.com>
References: <20200604125610.649668-1-sandipan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-04_07:2020-06-02,2020-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 cotscore=-2147483648 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=1 malwarescore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040085
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The Power ISA mandates that all writes to the Authority
Mask Register (AMR) must always be preceded as well as
succeeded by a context synchronizing instruction.

This makes sure that the tests follow this requirement
when attempting to update a pkey's access rights.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/powerpc/include/reg.h        | 6 ++++++
 tools/testing/selftests/powerpc/ptrace/core-pkey.c   | 2 +-
 tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/include/reg.h b/tools/testing/selftests/powerpc/include/reg.h
index 022c5076b2c5..c0f2742a3a59 100644
--- a/tools/testing/selftests/powerpc/include/reg.h
+++ b/tools/testing/selftests/powerpc/include/reg.h
@@ -57,6 +57,12 @@
 #define SPRN_PPR       896	/* Program Priority Register */
 #define SPRN_AMR       13	/* Authority Mask Register - problem state */
 
+#define set_amr(v)	asm volatile("isync;" \
+				     "mtspr " __stringify(SPRN_AMR) ",%0;" \
+				     "isync" : \
+				    : "r" ((unsigned long)(v)) \
+				    : "memory")
+
 /* TEXASR register bits */
 #define TEXASR_FC	0xFE00000000000000
 #define TEXASR_FP	0x0100000000000000
diff --git a/tools/testing/selftests/powerpc/ptrace/core-pkey.c b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
index d5c64fee032d..bbc05ffc5860 100644
--- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
@@ -150,7 +150,7 @@ static int child(struct shared_info *info)
 	printf("%-30s AMR: %016lx pkey1: %d pkey2: %d pkey3: %d\n",
 	       user_write, info->amr, pkey1, pkey2, pkey3);
 
-	mtspr(SPRN_AMR, info->amr);
+	set_amr(info->amr);
 
 	/*
 	 * We won't use pkey3. This tests whether the kernel restores the UAMOR
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
index bdbbbe8431e0..904c04f8c919 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
@@ -126,7 +126,7 @@ static int child(struct shared_info *info)
 	printf("%-30s AMR: %016lx pkey1: %d pkey2: %d pkey3: %d\n",
 	       user_write, info->amr1, pkey1, pkey2, pkey3);
 
-	mtspr(SPRN_AMR, info->amr1);
+	set_amr(info->amr1);
 
 	/* Wait for parent to read our AMR value and write a new one. */
 	ret = prod_parent(&info->child_sync);
-- 
2.25.1

