Return-Path: <linux-kselftest+bounces-36391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520E9AF6A0C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651C3523C7C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 06:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28E28DEFC;
	Thu,  3 Jul 2025 06:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kp6R8TIu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CE2DE6FC;
	Thu,  3 Jul 2025 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751522858; cv=none; b=F2o8GJDDcekZeF68mO4NRcEMj6WPSOKG8NYTEzus0oktmawZ+FD3ISvmnnBTpPHJW/c+6LShwTO6I6L/MU/PsgCHZUTqVcg0sw1cNa/O3PTG9cu9XSEqBdmSu/95dhjXo1RQO7FrhlBnzAE+ZXIuTbFpU1RJn6Rg2R0VBvqmQRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751522858; c=relaxed/simple;
	bh=/P1eHfHl1L4qFmCM4kwBP23IvldlxFppS3yN64Cgcxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9D8DgZ9sVT02aMU0b0W33KEz+p70HssV9/RYrusrEPKcvhsNvgxX1M8k7BcfroL75XGddVpk2PFjbUVylxsgWG6T/A+3054quOht6LGAFX+m4yTPKo1nkMJkGbpViKyKj7qqVjl6nSV7BRTiJ05G76nDrGB5EMUyS5RrzZzXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kp6R8TIu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562KSZs0011086;
	Thu, 3 Jul 2025 06:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xVl1ZnerADps5kjzZ
	QU5n2XjwSyP/GvOGz6w5Rf0Wug=; b=kp6R8TIuxkUpt81Eab5k+HDb6Eu/vFpW9
	5tw7JXiY7NoIpKSZsnaszcH+hgVpTfuM/kPsmx17ce9H7eey6ckP7nWH3YQZNJdU
	ieUskmlNeEJBvI+SUBpOxL3BVEV19pgA1BWy5dkOigF0pnrfQXtyz2JiBFOriZlu
	XWtdwggOKu9bNbyBP6Esb59a7RUH+c4GlXt1ex2sH8AenGiBRawLA7W1j5Q7iU/Z
	lKL8DT6OJYkCHPykIlmRhLlh8hvv9X6C75vBWE4LbTs6yl3LGrV8cfvt/eand26X
	jwvG/cZ3ASq3n9TdoscKnUkbDfOGYJQnfKX9Ebh6OzepC2qDzyuSQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82g19j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:16 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56366xZT028836;
	Thu, 3 Jul 2025 06:07:15 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82g19hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5632noMB006881;
	Thu, 3 Jul 2025 06:07:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxmk4je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56367BVh56295712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 06:07:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F0BE20043;
	Thu,  3 Jul 2025 06:07:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA44220040;
	Thu,  3 Jul 2025 06:07:05 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.39.26.205])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 06:07:05 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v2 1/7] mm/selftests: Fix incorrect pointer being passed to mark_range()
Date: Thu,  3 Jul 2025 11:36:50 +0530
Message-ID: <20250703060656.54345-2-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703060656.54345-1-aboorvad@linux.ibm.com>
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Z4mAURdhI9lJQMMn2CZAQuUThE9NPT80
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA0NCBTYWx0ZWRfX3BGdKC5KA2lZ iqlaOJH9CqbyEDHsjPlEIT0VjfY93mEGPxldrjGbupG8b1m4hfIO6znHqoCVothMiVZFZ9ePJm4 tvAAWLfG3kQ+JPpCj+aio8p/cPnCMJYUUQM84jjJu5Ec/wHV0YIzUeFIMUiELafQWKKiikQ8xTE
 //h8WuFSI2yPg74zY/w4q4HWgEVJLlwmFpR2QTrZG1n4qzWYa3TYk9d2ZD5XU8EXwa4/nd3wAkb DR8H2n50bfi/SIixgkyFCjeV9YbTcfL974n4t+pW/l9++e0luY21TuxnPyW00SLIxlSHRqbnGj8 CqtHqcYJ/DvEdu/CNOfWKGmlDHlXYzTrmESmjZnDSkOqruydSb722i9hANSz3AuR4n3OX9SNCgA
 c0wun5Jf8G2jINWwldXaF7L+m1RomQlxwno0q2EzzfISl0VrYSrmE6cfNS18QgkBLIPBre1e
X-Authority-Analysis: v=2.4 cv=LpeSymdc c=1 sm=1 tr=0 ts=68661e14 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=USQBeCa_g6oaaad9oeAA:9
X-Proofpoint-GUID: VLtHMn6lJKbdzMCOUOS_LFdvTIcYyUu_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=925 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030044

From: Donet Tom <donettom@linux.ibm.com>

In main(), the high address is stored in hptr, but for mark_range(),
the address passed is ptr, not hptr. Fixed this by changing ptr[i] to
hptr[i] in mark_range() function call.

Fixes: b2a79f62133a ("selftests/mm: virtual_address_range: unmap chunks after validation")
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 tools/testing/selftests/mm/virtual_address_range.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 169dbd692bf5..e24c36a39f22 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -227,7 +227,7 @@ int main(int argc, char *argv[])
 		if (hptr[i] == MAP_FAILED)
 			break;
 
-		mark_range(ptr[i], MAP_CHUNK_SIZE);
+		mark_range(hptr[i], MAP_CHUNK_SIZE);
 		validate_addr(hptr[i], 1);
 	}
 	hchunks = i;
-- 
2.43.5


