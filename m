Return-Path: <linux-kselftest+bounces-36392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16407AF6A0E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D43C1BC77CD
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 06:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738FF291C33;
	Thu,  3 Jul 2025 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D3fPPjEq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFABB291C25;
	Thu,  3 Jul 2025 06:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751522861; cv=none; b=Cq5q9UU6Fb4C+ntzE4yenjyhkzYnzvlZor9k8Yn3bR5yAm/oBY2m443nj1lhhQC0OhYtTCzOus3PX0bQ2uMp1Mvv57kuxvLgkz8YllUjvBVnQUdJorH++1nHGoSsvhyfYkySgrJ1XdeEMzHzMJ39WHk8YZOGjOdmiVrRh5yhqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751522861; c=relaxed/simple;
	bh=21pULq5A3TF7YG4dFtWsyFOIHRJM8Ew9Cip7tElmeVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRIzvzqaQrThPXvOX6mIQ2lSexTsmRx7vW3xmnGEpy3OggcUqH271cA0UPr7LxZlhiaDPKtdpix42J9iB3jH1sNeM2J3aGxuR1jldifasqJqvoPXu+NNnh5++OFUUI0lZxXkcws6fVT07CVVTpUJEZl+44csbUnsqZ/s5P+xdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D3fPPjEq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56365KWL023252;
	Thu, 3 Jul 2025 06:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=u7YIbQiP+/ef1u/7u
	uFPRUmmaRlSBehAK9LbebQcf3Q=; b=D3fPPjEqas22CSkn0/H/lrYoJa0hGIox5
	5Prfae1S0i+M8Rs3x4UsBlvr7nP1gRa8zOUpEptQUn4+SQPh40rcWID49jbL5C+e
	4gXcET9QtNGtNoZYAh8DjMChnme8c4Mi2jnxI1F6p97qD82bN5bDdTJwcHe6Hgno
	tfaQPVomj4cHTyaMFdhZL+5NTohl7ds7R4EvfPSqnpQcAwTOmr6fJZiusWysEPJF
	TY/lQk8WtZW0yt2USHDErZUfq7bE+CdduMRJ42UyUY5j+oMRjPkeY7u16WGk/WuM
	9i4szsAisvLagk/t8BmgkxwKq6c/jq4JN38oxlytO+7f12+UqYXJw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dhtey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:23 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5635vciI006792;
	Thu, 3 Jul 2025 06:07:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dhtet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5635rbCN032216;
	Thu, 3 Jul 2025 06:07:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47ju40uf0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56367Hk716974318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 06:07:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C1662004E;
	Thu,  3 Jul 2025 06:07:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA86F20043;
	Thu,  3 Jul 2025 06:07:11 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.39.26.205])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 06:07:11 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v2 2/7] selftests/mm: Add support to test 4PB VA on PPC64
Date: Thu,  3 Jul 2025 11:36:51 +0530
Message-ID: <20250703060656.54345-3-aboorvad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: tmbFQJNISn6HPBQMdf9Cf-XNvSsH9xNB
X-Proofpoint-GUID: uVk-xLyp3Zx-I3ZLfzuU-_vwFZSdFFNq
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=68661e1b cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=jWZC2Vw2s6trTHuKtcwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA0NCBTYWx0ZWRfXzo8+nRTYMaqz VPVFqmxs3+tAq0W7AkhcIxYjwDqUh+vryUl8OSzyk1HSIuU6UocWZVShahFywq245/72GqkRt7h Zv7sCgqwmxHCo2j6a64fZ+RhiXw+xqSnzavdxQh4GnqaMIis9O5lGeFfOdvbY7w0L2eJgnIIbLM
 Vl8+H03XjBGt5Sbv1hReaBIXr+lpyw1OqbG4Xqc4YLys4agNHggiFecTSTxOisB1pCLUUZHxvD0 GcCrzHMUOvCcPNsUqScHLdMRJdGnIKh83YwStMrkqpS5G049DuGtRi5m7X1MmDQAy3wIJsLGfed VxCow+CLWqFyS59RL6zhQk+Ev8IwK/69rDtyvgkrfgzUOPVPmgd+KcpdDGgstNrjzpa01IjNMrW
 1sW694dCDJxI9t9/0V/ww0YMsGfhMfWrsaGysZc2ztEuEn+FNCkrVXejVwtGd5wVrVNKIvzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=818 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030044

From: Donet Tom <donettom@linux.ibm.com>

PowerPC64 supports a 4PB virtual address space, but this test was
previously limited to 512TB. This patch extends the coverage up to
the full 4PB VA range on PowerPC64.

Memory from 0 to 128TB is allocated without an address hint, while
allocations from 128TB to 4PB use a hint address.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 tools/testing/selftests/mm/virtual_address_range.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index e24c36a39f22..619acf0b9239 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -50,6 +50,7 @@
 #define NR_CHUNKS_256TB   (NR_CHUNKS_128TB * 2UL)
 #define NR_CHUNKS_384TB   (NR_CHUNKS_128TB * 3UL)
 #define NR_CHUNKS_3840TB  (NR_CHUNKS_128TB * 30UL)
+#define NR_CHUNKS_3968TB  (NR_CHUNKS_128TB * 31UL)
 
 #define ADDR_MARK_128TB  (1UL << 47) /* First address beyond 128TB */
 #define ADDR_MARK_256TB  (1UL << 48) /* First address beyond 256TB */
@@ -59,6 +60,11 @@
 #define HIGH_ADDR_SHIFT 49
 #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
 #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
+#elif defined(__PPC64__)
+#define HIGH_ADDR_MARK  ADDR_MARK_128TB
+#define HIGH_ADDR_SHIFT 48
+#define NR_CHUNKS_LOW   NR_CHUNKS_128TB
+#define NR_CHUNKS_HIGH  NR_CHUNKS_3968TB
 #else
 #define HIGH_ADDR_MARK  ADDR_MARK_128TB
 #define HIGH_ADDR_SHIFT 48
-- 
2.43.5


