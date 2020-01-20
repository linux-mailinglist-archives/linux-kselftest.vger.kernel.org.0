Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99727142C90
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2020 14:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgATNwc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jan 2020 08:52:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726876AbgATNwc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jan 2020 08:52:32 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KDlx4E052768
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2020 08:52:31 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xmg7h7kdx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2020 08:52:31 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Mon, 20 Jan 2020 13:52:29 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Jan 2020 13:52:25 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00KDqOZ543319358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 13:52:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCCE311C04C;
        Mon, 20 Jan 2020 13:52:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CD8F11C05E;
        Mon, 20 Jan 2020 13:52:23 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jan 2020 13:52:23 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-mm@kvack.org, mhiramat@kernel.org,
        aneesh.kumar@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] selftests: vm: Fix 64-bit test builds for powerpc64le
Date:   Mon, 20 Jan 2020 19:22:22 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20012013-0016-0000-0000-000002DF1492
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012013-0017-0000-0000-00003341B876
Message-Id: <20200120135222.92522-1-sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=888 spamscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200119
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some tests are built only for 64-bit systems. This makes
sure that these tests are built for both big and little
endian variants of powerpc64.

Fixes: 7549b3364201 ("selftests: vm: Build/Run 64bit tests only on 64bit arch")
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 7f9a8a8c31da..f3d11f4fca38 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -19,7 +19,7 @@ TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
 
-ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
+ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64 sparc64 x86_64))
 TEST_GEN_FILES += va_128TBswitch
 TEST_GEN_FILES += virtual_address_range
 endif
-- 
2.17.1

