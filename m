Return-Path: <linux-kselftest+bounces-2796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B5829536
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 09:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DDB289D8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B6779DD;
	Wed, 10 Jan 2024 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jeJNV/GF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73015EDF;
	Wed, 10 Jan 2024 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40A8WjVa005535;
	Wed, 10 Jan 2024 08:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=GQLmdzTFvokN1N5EM1lR19Xz2d+PKMEyH5r0sANs38s=;
 b=jeJNV/GFGOMjMkhcI6J8PGwyQZgbFboUFjUx7WBkX7YPgfaAk9yFNSZYgsI9ljRF253w
 jS67iErR0xXwmy2ManTYBrEH3pfpzsRWcT5JCRIYOWRYcslZWnBEJZRq7ZZc9HoRm5pt
 b5CzTlC82JYwrExgszisyjiFr/iRBHEwGGX/KjFIp0U+wjQdRUez+sGrrr82N60ZNZNB
 UvtnmnogN6wJgDNVT3nAzCOJICsgMm1yf6gaUVHySdOhZQfJK1uk/sOfdEnJQXBF66tV
 lDU9A7xRNt/9/nHrfD6ahNWy0BARJcI2WxFjp49yPhZ1yjKtIHQmqXwhnpSzoTp2Om5I Vg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhqtng0xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 08:33:41 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40A7a5Ob028052;
	Wed, 10 Jan 2024 08:33:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vgwfsr3xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 08:33:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40A8Xb4W14680706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 08:33:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8B292004B;
	Wed, 10 Jan 2024 08:33:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D80FE20040;
	Wed, 10 Jan 2024 08:33:35 +0000 (GMT)
Received: from li-06431bcc-2712-11b2-a85c-a6fe68df28f9.in.ibm.com (unknown [9.109.245.191])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jan 2024 08:33:35 +0000 (GMT)
From: Donet Tom <donettom@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org
Cc: Aneesh Kumar <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Geetika Moolchandani <geetika@linux.ibm.com>
Subject: [PATCH 1/1] selftests: mm: hugepage-vmemmap fails on 64K page size systems.
Date: Wed, 10 Jan 2024 14:03:35 +0530
Message-ID: <3b3a3ae37ba21218481c482a872bbf7526031600.1704865754.git.donettom@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZSKpAOiSoWt1ETnpvKHBG_uRZdBm_ixf
X-Proofpoint-ORIG-GUID: ZSKpAOiSoWt1ETnpvKHBG_uRZdBm_ixf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_02,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401100069

The kernel sefltest mm/hugepage-vmemmap fails on architectures
which has different page size other than 4K. In hugepage-vmemmap
page size used is 4k so the pfn calculation will go wrong on systems
which has different page size .The length of MAP_HUGETLB memory must
be hugepage aligned but in hugepage-vmemmap map length is 2M so this
will not get aligned if the system has differnet hugepage size.

Added  psize() to get the page size and default_huge_page_size() to
get the default hugepage size at run time, hugepage-vmemmap test pass
on powerpc with 64K page size and x86 with 4K page size.

Result on powerpc without patch (page size 64K)
*# ./hugepage-vmemmap
Returned address is 0x7effff000000 whose pfn is 0
Head page flags (100000000) is invalid
check_page_flags: Invalid argument
*#

Result on powerpc with patch (page size 64K)
*# ./hugepage-vmemmap
Returned address is 0x7effff000000 whose pfn is 600
*#

Result on x86 with patch (page size 4K)
*# ./hugepage-vmemmap
Returned address is 0x7fc7c2c00000 whose pfn is 1dac00
*#

Signed-off-by: Donet Tom <donettom@linux.vnet.ibm.com>
Reported-by : Geetika Moolchandani (geetika@linux.ibm.com)
Tested-by : Geetika Moolchandani (geetika@linux.ibm.com)
---
 tools/testing/selftests/mm/hugepage-vmemmap.c | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-vmemmap.c b/tools/testing/selftests/mm/hugepage-vmemmap.c
index 5b354c209e93..894d28c3dd47 100644
--- a/tools/testing/selftests/mm/hugepage-vmemmap.c
+++ b/tools/testing/selftests/mm/hugepage-vmemmap.c
@@ -10,10 +10,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-
-#define MAP_LENGTH		(2UL * 1024 * 1024)
-
-#define PAGE_SIZE		4096
+#include "vm_util.h"
 
 #define PAGE_COMPOUND_HEAD	(1UL << 15)
 #define PAGE_COMPOUND_TAIL	(1UL << 16)
@@ -39,6 +36,9 @@
 #define MAP_FLAGS		(MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB)
 #endif
 
+static size_t pagesize;
+static size_t maplength;
+
 static void write_bytes(char *addr, size_t length)
 {
 	unsigned long i;
@@ -56,7 +56,7 @@ static unsigned long virt_to_pfn(void *addr)
 	if (fd < 0)
 		return -1UL;
 
-	lseek(fd, (unsigned long)addr / PAGE_SIZE * sizeof(pagemap), SEEK_SET);
+	lseek(fd, (unsigned long)addr / pagesize * sizeof(pagemap), SEEK_SET);
 	read(fd, &pagemap, sizeof(pagemap));
 	close(fd);
 
@@ -86,7 +86,7 @@ static int check_page_flags(unsigned long pfn)
 	 * this also verifies kernel has correctly set the fake page_head to tail
 	 * while hugetlb_free_vmemmap is enabled.
 	 */
-	for (i = 1; i < MAP_LENGTH / PAGE_SIZE; i++) {
+	for (i = 1; i < maplength / pagesize; i++) {
 		read(fd, &pageflags, sizeof(pageflags));
 		if ((pageflags & TAIL_PAGE_FLAGS) != TAIL_PAGE_FLAGS ||
 		    (pageflags & HEAD_PAGE_FLAGS) == HEAD_PAGE_FLAGS) {
@@ -106,18 +106,25 @@ int main(int argc, char **argv)
 	void *addr;
 	unsigned long pfn;
 
-	addr = mmap(MAP_ADDR, MAP_LENGTH, PROT_READ | PROT_WRITE, MAP_FLAGS, -1, 0);
+	pagesize  = psize();
+	maplength = default_huge_page_size();
+	if (!maplength) {
+		printf("Unable to determine huge page size\n");
+		exit(1);
+	}
+
+	addr = mmap(MAP_ADDR, maplength, PROT_READ | PROT_WRITE, MAP_FLAGS, -1, 0);
 	if (addr == MAP_FAILED) {
 		perror("mmap");
 		exit(1);
 	}
 
 	/* Trigger allocation of HugeTLB page. */
-	write_bytes(addr, MAP_LENGTH);
+	write_bytes(addr, maplength);
 
 	pfn = virt_to_pfn(addr);
 	if (pfn == -1UL) {
-		munmap(addr, MAP_LENGTH);
+		munmap(addr, maplength);
 		perror("virt_to_pfn");
 		exit(1);
 	}
@@ -125,13 +132,13 @@ int main(int argc, char **argv)
 	printf("Returned address is %p whose pfn is %lx\n", addr, pfn);
 
 	if (check_page_flags(pfn) < 0) {
-		munmap(addr, MAP_LENGTH);
+		munmap(addr, maplength);
 		perror("check_page_flags");
 		exit(1);
 	}
 
 	/* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
-	if (munmap(addr, MAP_LENGTH)) {
+	if (munmap(addr, maplength)) {
 		perror("munmap");
 		exit(1);
 	}
-- 
2.43.0


