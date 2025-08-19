Return-Path: <linux-kselftest+bounces-39281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F51B2B84B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 06:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D6D5E5B8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 04:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EF430F558;
	Tue, 19 Aug 2025 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CZJuOyNl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B021E0BB;
	Tue, 19 Aug 2025 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576795; cv=none; b=kM8rFRcpAxvwgk4xZRLlzuJ9S+nl/VlmifZ+61oGMCk2oaHc+eMoG/ICaSuyjh017mVt2+xMKLWpDHk/VYN5YqV+/k2FlzkV1d5oMKdmgnpa688oeQtm5Kxcnk08BBu3Xj/1+DEGciX4h+HVlojN/GPjXx9Jxi6u/gigYJtGQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576795; c=relaxed/simple;
	bh=S/XeDBXYDwq3p3qukbHZCju54+owXP+zRjuDBF6bmWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyasTkkMn+Z80q+rT6Gt7HerYeVzzXMGzB5iqyaezF+DNrYwv5PDVfp1m9vHIVg54kNtPifyystzd6hbQQCWn/E9atQ+a6PkAoKUij0FNSYSChf26c+vobORjy3eWn2hR4V58CMEotKwRKq0Nbj4sFZOzqm4bOkncYymKDgZBUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CZJuOyNl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IJR3nC018787;
	Tue, 19 Aug 2025 04:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZFlr9XZgtlNb+evn5
	eEZ1lChPKLSA2WkgbkwzuLvENE=; b=CZJuOyNlIKOZy0rlXXgcLwa6do0EIfp8b
	4WR8qFQJGjIlXpt2SxTRaBj6ZcjIYSmYLXLzGKZ+ytm2k8KTuwjMsS00v39XZFBf
	etVnja4oBxP5deSrkMGpCxtB1lY/lN6Y8yk8K9hSOtT1VVqPasL9Hl87Emgc+U/9
	mcXBjHrKWyn91HZBNnpOcS90+P1tD04ofe8/vabgO2AWNxcnVfr/I7y2dn8+evZb
	uUWtZm3SgmKKOBm0mcZCRwAcYkGzRglSdObF0rw2cgKZa7u8Sy0ltrk1Sx+u3Vkm
	Uocklo8Zu6ztQiz0TW/bU2bMPJ1aMjUo3tKbbbAEQ4zxD9Y+H7TGQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhn3vbs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 04:12:58 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57J4CvRG000433;
	Tue, 19 Aug 2025 04:12:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhn3vbs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 04:12:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57INkjlm028695;
	Tue, 19 Aug 2025 04:12:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48k5apgncw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 04:12:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57J4CqYb42140152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 04:12:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C470020049;
	Tue, 19 Aug 2025 04:12:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF9C120040;
	Tue, 19 Aug 2025 04:12:42 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.150.8.12])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Aug 2025 04:12:42 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
        pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, baohua@kernel.org, richard.weiyang@gmail.com,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [Fixup PATCH] mm/selftests: Fix formattig in split_huge_page_test
Date: Tue, 19 Aug 2025 09:42:39 +0530
Message-ID: <20250819041239.167537-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816040113.760010-5-aboorvad@linux.ibm.com>
References: <20250816040113.760010-5-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qMWmbQ09cn0A6Ai_j_mOSLJ5h7QLc1sg
X-Authority-Analysis: v=2.4 cv=L6wdQ/T8 c=1 sm=1 tr=0 ts=68a3f9ca cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=QMRzLW034-kUWS3sVu0A:9
X-Proofpoint-GUID: LlP27Rf4mfaXWxbFPVAWuPF00on4V6Bf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX+xUG2hwsfxGw
 ops6hgBiWNDUJyuuhWaWgIV2pryAekhcuDSZGQYnxMlCQL73osbzyasdZHPxdtTdbhxJ7mKmyVe
 O8s+ITkYUL1zI6T/+P2ckIt2Ln6o9beDTMXF8kBoCU2zeS3RSCcnUijFubMeU3YsOMveoP0Hpcs
 sP9XZRHcIva7G30tVSgWh9KDwPQ9QDmSLp1aC+zWNgLRnV67Os3MJFeEpZbjfITk+UkTJyaDQgu
 +6KyRK2jdQfsuur++ikjTZYQfMe06lQ+DyDqRKF/eV8sFc6lY4aFqdOl9qnnW6rNhSWwI4HEqaj
 roKv6FecKkjY2Ld1V2Gfx1L8q5XlSidSKXmd3/E2gDgZWenyXrlKnN8QxEeiSF3JgzODQsE2MpN
 mdAB1nbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027

Removed an extra space in split_huge_page_test that was introduced
by commit 4b76e221794b ("mm/selftests: fix split_huge_page_test
failure on systems with 64KB page size").

Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 54e86f00aabc..faf7e1f88743 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -544,7 +544,7 @@ int main(int argc, char **argv)
 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 
 	nr_pages = pmd_pagesize / pagesize;
-	max_order =  sz2ord(pmd_pagesize, pagesize);
+	max_order = sz2ord(pmd_pagesize, pagesize);
 	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
 	ksft_set_plan(tests);
 
-- 
2.47.1


