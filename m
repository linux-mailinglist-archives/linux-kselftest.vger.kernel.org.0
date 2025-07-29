Return-Path: <linux-kselftest+bounces-38041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D8B1479F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 07:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328514E39DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 05:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4285223496F;
	Tue, 29 Jul 2025 05:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cajxoetV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF32367DC;
	Tue, 29 Jul 2025 05:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767289; cv=none; b=aZsIkgmOT9NIs408hl9+dQItBRNohdsPop6gJn+D2mTEF800Hem3jn7ls0j1VZ+arqQxwkiGPZCygQ1Wygzgy7d+Wl7cD1T5cNKLUJq/ggGBwNZ1ZhGTS1UlE0KATdSvJY0K/DX3stLR3AETsJvMF1BAkgXiafiefEZ+md5duGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767289; c=relaxed/simple;
	bh=tY1DxbaB2AqeY/U4umNsrUKXHAdJe8DWpIN/Q4tfUeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVlrM29hWDDR6QCT0Pup4BdevSaejtrslDocc8+XuAftsito+gA9eiZhCkvnqYFcSgUywdSk5xvaMZA6vZFBwweVrvybFcJnybWjvt8H8vIcGtY+TiBKqAOF8nrrA7rYM/wZ3u3F85LSqtEJBuXUhKlLZkvnrQnpirndWlQ2L+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cajxoetV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T4YuHm001913;
	Tue, 29 Jul 2025 05:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=G8oS+v+giLcHjDbSr
	lGsstMtFDLI0TyfcjEk/ae6+cY=; b=cajxoetVp+siWZ/uyFUbb4sHT6F+8AXYW
	u4UqNMEtAxpgooqkaLNSXft3rTVykH8dv3nuFnNiKV6cKQ0bDYz7r5M5nvRzkvWT
	nwx0jsiUEOQW5bwIpGiTVe4fvofvCj8usN9fL59yepFRWlCTvGfyA5yOdo9ITEK2
	UL3Gza99Y/OnimU2O/ab7DYzD5TJCEHTwyDhV/G1ET5GukEcZW4ap1sApJ4+cAep
	AWR45cXAgAfnRJQHJPMDGU0NcGuMuKfJ4KuROCR1uMo6VAFSawrDM1P7N3cwLv5x
	E7peYN4PVqhDBmG1pD0AQbIXaUtoMdKlX9ThZJd8QZWZyF6COmiBw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hjte0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:28 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56T5YSi4021026;
	Tue, 29 Jul 2025 05:34:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hjtdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56T4VHL1018275;
	Tue, 29 Jul 2025 05:34:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485abp113r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56T5YMwh20840932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 05:34:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D97192004D;
	Tue, 29 Jul 2025 05:34:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5733C20040;
	Tue, 29 Jul 2025 05:34:17 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.150.11.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Jul 2025 05:34:17 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v3 2/7] selftests/mm: Add support to test 4PB VA on PPC64
Date: Tue, 29 Jul 2025 11:03:58 +0530
Message-ID: <20250729053403.1071807-3-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
References: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oaw_REjoX37XzBgjW1cvFZzgafNzvIa5
X-Authority-Analysis: v=2.4 cv=Mbtsu4/f c=1 sm=1 tr=0 ts=68885d64 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=Bqi_dthY5MMbQG-DhooA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: GzwiVAJad7mSRRBHQELlV_wh9Yabou-n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAzOCBTYWx0ZWRfXyUBMSh0aQ5NV
 I45ZiF3m9DMeKyZGo/XrJ/fmIBc67U7IS32oedfmYwFXUTy26JXM+vb40XC51Zvcs7H16gBEfsd
 u9I6tiPTKuqyCXj9vtx+NV0+XomlrBg+Em5mNuBSvr3LgyVFYAD0B0lpAyPRzjPHSZxo7AP+d78
 AFC7vOoHQgoFN+UYPIxvod1lAM5uewvP6Qlo7CGFnnBEENcGw/8fq5yDKkbedt/T6j4Uxz4Sw5e
 5qz2lmBYvN3a/WJvfQjYAj95DIoCLjMAt3sIRY+NBemOV2j/6kzUHhlfeuIut0+UqN4thJLgbAu
 YiZU4XKKjNl4PxrjAgKIQRrm95/UkcpmTGGc6t0hNTdp/K/sPnDCdPEwipuuj8gViDDTV822HB6
 HI0uj50ZI6XTqzIZPZYRGxIThqANT+PxIDlgj1bU2Lt51ZGbdtmWTGG4qkz3cpIDT+QkXFR0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=959
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290038

From: Donet Tom <donettom@linux.ibm.com>

PowerPC64 supports a 4PB virtual address space, but this test was
previously limited to 512TB. This patch extends the coverage up to
the full 4PB VA range on PowerPC64.

Memory from 0 to 128TB is allocated without an address hint, while
allocations from 128TB to 4PB use a hint address.

Reviewed-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Co-developed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 tools/testing/selftests/mm/virtual_address_range.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index e24c36a39f22..81b33d8f78f4 100644
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


