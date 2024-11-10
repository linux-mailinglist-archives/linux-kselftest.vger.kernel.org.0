Return-Path: <linux-kselftest+bounces-21738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA49C3113
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 07:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF97D281CC9
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 06:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EBF1474B7;
	Sun, 10 Nov 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sHDeDuEH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C24233D62;
	Sun, 10 Nov 2024 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731221361; cv=none; b=rB5oCVC3HyO33LNPp4777V5ymfxmahCSOojtkjcZQ+m5sxKThuCFDVGStFDVkCwhzDCn7oJytwQ2E7ejyIOopet7jI5OtALTvewK9yykPpEPboeflyQAZy1SiTI7ARmWaqxU2JWPnCW3+qBFas1gdZWOp6EPp0OkSyMFPLytPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731221361; c=relaxed/simple;
	bh=LXxsnDmW/CJCUxOm/WH84aaXEMflauGXz984wdrW3gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuJLxeZ1DUavLvQfdJwlrcGtmj6K+3PFSikochnVEgB8RpHycGJkMk3EVrQweG7awBXjjzbxqAxeTjegn/Xbwu8+nz2CU7Q7+GsRV6QX599fPFudR+gwVZYaY7dkKtOp+G9daMEm3eiP0eIG6ajykO6VocPkVP4TdHqTh7dwv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sHDeDuEH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AA5v6kp000347;
	Sun, 10 Nov 2024 06:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jvYaJb6azWo0m8bn1
	1g8QslqBFijvCyAEzFxfFrmX5w=; b=sHDeDuEHD50TLYtl5RDeIIE/DQxShVfjp
	K68y9GQSndOclvoDb9vBinM0ANo7kCcF7kxL7Huxpvcrs8gsTV7w8xhiZl9xl7t0
	V8ALNZJtxrO/dGhq/r07a31k9WUmE6VHOTzq699Xz6BjlwfhcXQvJr3G3byiWGvs
	gbhiDPqZ6oJD6cN2j7tFcmFOGNkmI7r3Diyu4OtyS7yj+81aYdwwNkmIF5pJDUhL
	vWqpPhOBKO/BNSjacmDpujNmtY8Tsiz2XTsQL0pGnATQg0yihUpSCKT3fRvczr06
	imkLVoAdsZfGuCsBItfPRyoA0p2I07VXa9sgFASW+N7An8AYK/rIg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tjg3910e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 06:49:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AA0BMXh010521;
	Sun, 10 Nov 2024 06:49:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tj2s0e84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 06:49:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AA6nA9U21103048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Nov 2024 06:49:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 255D020049;
	Sun, 10 Nov 2024 06:49:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C888F20040;
	Sun, 10 Nov 2024 06:49:08 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.40.194.31])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Nov 2024 06:49:08 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: akpm@linux-foundation.org
Cc: Usama.Anjum@collabora.com, donettom@linux.ibm.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, shuah@kernel.org
Subject: [PATCH] selftests: hugetlb_dio: Fixup  Check for initial conditions to skip in the start
Date: Sun, 10 Nov 2024 00:49:03 -0600
Message-ID: <20241110064903.23626-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109223436.3ddeaf1d60e1ade8f562d757@linux-foundation.org>
References: <20241109223436.3ddeaf1d60e1ade8f562d757@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tCo3NsxOEUKn0qsJpazH5rZ1MBq6zfoW
X-Proofpoint-GUID: tCo3NsxOEUKn0qsJpazH5rZ1MBq6zfoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=689 lowpriorityscore=0 adultscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411100058

This test verifies that a hugepage, used as a user buffer for
DIO operations, is correctly freed upon unmapping. To test this,
we read the count of free hugepages before and after the mmap,
DIO, and munmap operations, then check if the free hugepage count
is the same.

Reading free hugepages before the test was removed by commit
0268d4579901 ('selftests: hugetlb_dio: check for initial conditions
to skip at the start'), causing the test to always fail.

This patch adds back reading the free hugepages before starting
the test. With this patch, the tests are now passing.

Test Results without this patch

./tools/testing/selftests/mm/hugetlb_dio
TAP version 13
1..4
 # No. Free pages before allocation : 0
 # No. Free pages after munmap : 100
not ok 1 : Huge pages not freed!
 # No. Free pages before allocation : 0
 # No. Free pages after munmap : 100
not ok 2 : Huge pages not freed!
 # No. Free pages before allocation : 0
 # No. Free pages after munmap : 100
not ok 3 : Huge pages not freed!
 # No. Free pages before allocation : 0
 # No. Free pages after munmap : 100
not ok 4 : Huge pages not freed!
 # Totals: pass:0 fail:4 xfail:0 xpass:0 skip:0 error:0

Test results with this patch.

./tools/testing/selftests/mm/hugetlb_dio
TAP version 13
1..4
 # No. Free pages before allocation : 0
 # No. Free pages after munmap : 100
not ok 1 : Huge pages not freed!
 # No. Free pages before allocation : 0
 # No. Free pages after munmap : 100
not ok 2 : Huge pages not freed!
 # No. Free pages before allocation : 0
 # No. Free pages after munmap : 100
not ok 3 : Huge pages not freed!
 # No. Free pages before allocation : 0
 # No. Free pages after munmap : 100
not ok 4 : Huge pages not freed!
 # Totals: pass:0 fail:4 xfail:0 xpass:0 skip:0 error:0

Fixes: 0268d4579901 ("selftests: hugetlb_dio: check for initial conditions to skip in the start")
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 tools/testing/selftests/mm/hugetlb_dio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
index 60001c142ce9..432d5af15e66 100644
--- a/tools/testing/selftests/mm/hugetlb_dio.c
+++ b/tools/testing/selftests/mm/hugetlb_dio.c
@@ -44,6 +44,13 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
 	if (fd < 0)
 		ksft_exit_fail_perror("Error opening file\n");
 
+	/* Get the free huge pages before allocation */
+	free_hpage_b = get_free_hugepages();
+	if (free_hpage_b == 0) {
+		close(fd);
+		ksft_exit_skip("No free hugepage, exiting!\n");
+	}
+
 	/* Allocate a hugetlb page */
 	orig_buffer = mmap(NULL, h_pagesize, mmap_prot, mmap_flags, -1, 0);
 	if (orig_buffer == MAP_FAILED) {
-- 
2.43.5


