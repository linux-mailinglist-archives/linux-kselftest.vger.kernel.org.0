Return-Path: <linux-kselftest+bounces-39136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA563B28A70
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 06:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3680E5C6328
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 04:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A321D5CFB;
	Sat, 16 Aug 2025 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jzp9cuL8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61A51DED5C;
	Sat, 16 Aug 2025 04:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755316935; cv=none; b=NBYI+VEsERJQivVdttvcJjgDpgQojAL2OEdpCOmpW4SqeLwYZfdd5ps7WgR6YIu+I6aFd+DtUh5izsFZyX8H4w+g5+m1wlIGlNRbFbUk6uKfoYiAC/mHogbyROzeN6EWc7rI++TDPcWd3GrBiZY6AinNDDxuFZkCUW1GaWGSLDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755316935; c=relaxed/simple;
	bh=q8JJeSZbtLNfmDIRH5jDCkCzKl+LwQxebgtzPRqy1eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pd94Npd9NP8QDIzDj9rtiUQRcW67naGbeHfz+fCIEPzTtKbPbXzdrehTyfEKMcGDZNpXPUApEKPCJrc71/bExndoWrfHyRlqZTVFmUcJRz6U5pfrK9a7rpnxgKXznDRV7IrqYrgYYO3MV9ZdllXXbOagKIQU7C41OhsvvwIQThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jzp9cuL8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G2xgUO026356;
	Sat, 16 Aug 2025 04:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xPy3sO++d8R7+mZ5S
	3adOnuOng0bHe11Z8Kz+7bq/u4=; b=jzp9cuL8K2QAO/SpfDovAltSasgSptj0o
	3wCjKdBMOcCLLDC+bf7e2HuVR6G2r7EFG22kLXh1eFwp/KSodzkxTskcvUCJ/Zgo
	+qD/vgEfiznQ1smFpohHj+uY4MHK9tCcGXQ3MVTJWXAw6tS5VEnIUVNTZrdeBpLC
	tbocL4PHlQQeaxHWjyVcRVw758k7BqbzCm33bfmDJnsagNIMLM71Arxp7WtWnqMq
	kgWTj/QOf1wdZKQFo+F4P9/9oZkeJ7mEw4SIhNu898lw+gqLX7L7m1sHIsAbmURQ
	NCDdE9zCxbSEOxXfazF2Ob/D+7Lwz0BorLCEqGSkHSrSx0xNM3SYA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhnxr44x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:01:58 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57G3wb69030745;
	Sat, 16 Aug 2025 04:01:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhnxr44t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:01:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57G3VL5w017606;
	Sat, 16 Aug 2025 04:01:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc43f7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:01:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57G41rPR53805428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Aug 2025 04:01:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 224432004B;
	Sat, 16 Aug 2025 04:01:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 121EE20040;
	Sat, 16 Aug 2025 04:01:41 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.36.5.210])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 Aug 2025 04:01:40 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, richard.weiyang@gmail.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v4 2/7] selftests/mm: Add support to test 4PB VA on PPC64
Date: Sat, 16 Aug 2025 09:31:08 +0530
Message-ID: <20250816040113.760010-3-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816040113.760010-1-aboorvad@linux.ibm.com>
References: <20250816040113.760010-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbqJzJ55 c=1 sm=1 tr=0 ts=68a002b6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=WmnS56O_TwYD7c2XGFoA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: ejoYArjV969070TmiEX0lepj9eH35uQD
X-Proofpoint-GUID: CPC1I9ANuAlCecLDI3vFdpLyyCUnehTQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX5NAKPf+ZWHY6
 C1LwpL8fxKLpg4r66NlosVvl+4FXGALI8k7u8jP23tZlK0FIPPZm1ePuJuRbQJAzrgXRNwCZscj
 l3pt7Ec6hPOtQoJYKztSj0RUt7dxG5W3A92OvHQ7F5AgaeYJTLiyvOrRJIb83Wyxf4EoKsnEIGa
 HkITpwJnz3VKolGPHTnWu53KpiUN7Bz+4urtojVkMtkZLyf7jZ5xdvHGMTQbuNvfi3WxUnkMZKE
 lI1WOZfPOnIjhurE8f82iWZLZWtOIOyisqiiTl+4jSc3dB8zPTRlqY5S2n11+Ay7dK9bNzIZwEd
 6urW80DoF1uCitB5K97S89r9lIod5VMH/E51MPRMMIf2SFqz9jHcfSwJq0NUfRVcgTcR1NCdIiR
 +0XooGjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027

From: Donet Tom <donettom@linux.ibm.com>

PowerPC64 supports a 4PB virtual address space, but this test was
previously limited to 512TB. This patch extends the coverage up to
the full 4PB VA range on PowerPC64.

Memory from 0 to 128TB is allocated without an address hint, while
allocations from 128TB to 4PB use a hint address.

Co-developed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 tools/testing/selftests/mm/virtual_address_range.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index e7ef6759baa1..1de62f6cadc7 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -44,12 +44,18 @@
  * On Arm64 the address space is 256TB and support for
  * high mappings up to 4PB virtual address space has
  * been added.
+ *
+ * On PowerPC64, the address space up to 128TB can be
+ * mapped without a hint. Addresses beyond 128TB, up to
+ * 4PB, can be mapped with a hint.
+ *
  */
 
 #define NR_CHUNKS_128TB   ((128 * SZ_1TB) / MAP_CHUNK_SIZE) /* Number of chunks for 128TB */
 #define NR_CHUNKS_256TB   (NR_CHUNKS_128TB * 2UL)
 #define NR_CHUNKS_384TB   (NR_CHUNKS_128TB * 3UL)
 #define NR_CHUNKS_3840TB  (NR_CHUNKS_128TB * 30UL)
+#define NR_CHUNKS_3968TB  (NR_CHUNKS_128TB * 31UL)
 
 #define ADDR_MARK_128TB  (1UL << 47) /* First address beyond 128TB */
 #define ADDR_MARK_256TB  (1UL << 48) /* First address beyond 256TB */
@@ -59,6 +65,11 @@
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
2.47.1


