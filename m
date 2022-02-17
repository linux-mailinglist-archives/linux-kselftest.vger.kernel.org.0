Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308D34B9B2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 09:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbiBQIfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 03:35:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiBQIfP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 03:35:15 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEE029A568
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 00:35:01 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21H8BPnE005051;
        Thu, 17 Feb 2022 08:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=SlFkSE8TI8EEWhz8vgdgRSxXF89n3LuoOfc0LPX2F2g=;
 b=OviyTm76ZspASOWMbusGCXVfzyX9mm+CRKYB7m4deO8wJ2wdgzGCc6KaoiGCUUsSQ38X
 FEz6beSgriF150dDY3gTAwBpUvVxdcMWKj8cvquuw9MT5H8Sjaf/7t7qqhfdmjtJB568
 7e15jHTx0O877NdCsXr69v0uf58WZ0iWcb/jJ4SkpEJ7CANaoBccUJzbVsJpGqQ0H/7o
 axDyv4NFHB8q38eYI+FuUavmgQfHO1wuB/tUdaXtNH6nCt6oeyIIc5ExMh8O+hf6Ovce
 lOIo02vnVRoRVedUM0eq2k0yZiVj1L65HzWGOT5oJRLpxGDx7tRbj2pJzk+H70ddewm/ 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9d0jpae3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 08:34:47 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21H8ELre019833;
        Thu, 17 Feb 2022 08:34:46 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9d0jpadq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 08:34:46 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21H881Fo013800;
        Thu, 17 Feb 2022 08:34:45 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3e64hd1nds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 08:34:45 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21H8YiZi42271048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 08:34:45 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3D34AC05F;
        Thu, 17 Feb 2022 08:34:44 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A82C8AC059;
        Thu, 17 Feb 2022 08:34:41 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.122.166])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 17 Feb 2022 08:34:41 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftest/vm: Fix map_fixed_noreplace test failure
Date:   Thu, 17 Feb 2022 14:04:17 +0530
Message-Id: <20220217083417.373823-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qvnGKmUAeawgUighlxymFLcl8joEiIPI
X-Proofpoint-ORIG-GUID: YEwhqtPEKSm3TXxzh81kY-YSNiLaP0B7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_03,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202170037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On the latest RHEL the test fails due to executable mapped at 256MB address

 # ./map_fixed_noreplace
mmap() @ 0x10000000-0x10050000 p=0xffffffffffffffff result=File exists
10000000-10010000 r-xp 00000000 fd:04 34905657                           /root/rpmbuild/BUILD/kernel-5.14.0-56.el9/linux-5.14.0-56.el9.ppc64le/tools/testing/selftests/vm/map_fixed_noreplace
10010000-10020000 r--p 00000000 fd:04 34905657                           /root/rpmbuild/BUILD/kernel-5.14.0-56.el9/linux-5.14.0-56.el9.ppc64le/tools/testing/selftests/vm/map_fixed_noreplace
10020000-10030000 rw-p 00010000 fd:04 34905657                           /root/rpmbuild/BUILD/kernel-5.14.0-56.el9/linux-5.14.0-56.el9.ppc64le/tools/testing/selftests/vm/map_fixed_noreplace
10029b90000-10029bc0000 rw-p 00000000 00:00 0                            [heap]
7fffbb510000-7fffbb750000 r-xp 00000000 fd:04 24534                      /usr/lib64/libc.so.6
7fffbb750000-7fffbb760000 r--p 00230000 fd:04 24534                      /usr/lib64/libc.so.6
7fffbb760000-7fffbb770000 rw-p 00240000 fd:04 24534                      /usr/lib64/libc.so.6
7fffbb780000-7fffbb7a0000 r--p 00000000 00:00 0                          [vvar]
7fffbb7a0000-7fffbb7b0000 r-xp 00000000 00:00 0                          [vdso]
7fffbb7b0000-7fffbb800000 r-xp 00000000 fd:04 24514                      /usr/lib64/ld64.so.2
7fffbb800000-7fffbb810000 r--p 00040000 fd:04 24514                      /usr/lib64/ld64.so.2
7fffbb810000-7fffbb820000 rw-p 00050000 fd:04 24514                      /usr/lib64/ld64.so.2
7fffd93f0000-7fffd9420000 rw-p 00000000 00:00 0                          [stack]
Error: couldn't map the space we need for the test

Fix this by finding a free address using mmap instead of hardcoding BASE_ADDRESS.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jann Horn <jannh@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 .../selftests/vm/map_fixed_noreplace.c        | 49 ++++++++++++++-----
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/vm/map_fixed_noreplace.c b/tools/testing/selftests/vm/map_fixed_noreplace.c
index d91bde511268..eed44322d1a6 100644
--- a/tools/testing/selftests/vm/map_fixed_noreplace.c
+++ b/tools/testing/selftests/vm/map_fixed_noreplace.c
@@ -17,9 +17,6 @@
 #define MAP_FIXED_NOREPLACE 0x100000
 #endif
 
-#define BASE_ADDRESS	(256ul * 1024 * 1024)
-
-
 static void dump_maps(void)
 {
 	char cmd[32];
@@ -28,18 +25,46 @@ static void dump_maps(void)
 	system(cmd);
 }
 
+static unsigned long find_base_addr(unsigned long size)
+{
+	void *addr;
+	unsigned long flags;
+
+	flags = MAP_PRIVATE | MAP_ANONYMOUS;
+	addr = mmap(NULL, size, PROT_NONE, flags, -1, 0);
+	if (addr == MAP_FAILED) {
+		printf("Error: couldn't map the space we need for the test\n");
+		return 0;
+	}
+
+	if (munmap(addr, size) != 0) {
+		printf("Error: couldn't map the space we need for the test\n");
+		return 0;
+	}
+	return (unsigned long)addr;
+}
+
 int main(void)
 {
+	unsigned long base_addr;
 	unsigned long flags, addr, size, page_size;
 	char *p;
 
 	page_size = sysconf(_SC_PAGE_SIZE);
 
+	//let's find a base addr that is free before we start the tests
+	size = 5 * page_size;
+	base_addr = find_base_addr(size);
+	if (!base_addr) {
+		printf("Error: couldn't map the space we need for the test\n");
+		return 1;
+	}
+
 	flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE;
 
 	// Check we can map all the areas we need below
 	errno = 0;
-	addr = BASE_ADDRESS;
+	addr = base_addr;
 	size = 5 * page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 
@@ -60,7 +85,7 @@ int main(void)
 	printf("unmap() successful\n");
 
 	errno = 0;
-	addr = BASE_ADDRESS + page_size;
+	addr = base_addr + page_size;
 	size = 3 * page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
@@ -80,7 +105,7 @@ int main(void)
 	 *     +4 |  free  | new
 	 */
 	errno = 0;
-	addr = BASE_ADDRESS;
+	addr = base_addr;
 	size = 5 * page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
@@ -101,7 +126,7 @@ int main(void)
 	 *     +4 |  free  |
 	 */
 	errno = 0;
-	addr = BASE_ADDRESS + (2 * page_size);
+	addr = base_addr + (2 * page_size);
 	size = page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
@@ -121,7 +146,7 @@ int main(void)
 	 *     +4 |  free  | new
 	 */
 	errno = 0;
-	addr = BASE_ADDRESS + (3 * page_size);
+	addr = base_addr + (3 * page_size);
 	size = 2 * page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
@@ -141,7 +166,7 @@ int main(void)
 	 *     +4 |  free  |
 	 */
 	errno = 0;
-	addr = BASE_ADDRESS;
+	addr = base_addr;
 	size = 2 * page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
@@ -161,7 +186,7 @@ int main(void)
 	 *     +4 |  free  |
 	 */
 	errno = 0;
-	addr = BASE_ADDRESS;
+	addr = base_addr;
 	size = page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
@@ -181,7 +206,7 @@ int main(void)
 	 *     +4 |  free  |  new
 	 */
 	errno = 0;
-	addr = BASE_ADDRESS + (4 * page_size);
+	addr = base_addr + (4 * page_size);
 	size = page_size;
 	p = mmap((void *)addr, size, PROT_NONE, flags, -1, 0);
 	printf("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
@@ -192,7 +217,7 @@ int main(void)
 		return 1;
 	}
 
-	addr = BASE_ADDRESS;
+	addr = base_addr;
 	size = 5 * page_size;
 	if (munmap((void *)addr, size) != 0) {
 		dump_maps();
-- 
2.35.1

