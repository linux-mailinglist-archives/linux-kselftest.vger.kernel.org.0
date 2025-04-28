Return-Path: <linux-kselftest+bounces-31783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55130A9F20D
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 15:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A403716BCAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 13:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E97266B67;
	Mon, 28 Apr 2025 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OPPXYSvF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F0268698;
	Mon, 28 Apr 2025 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846453; cv=none; b=MS6pGPnJT24u814vThGyg2FUUV3TEjave8HHENExcfdH+v7ZkVx1/gSb0n8IWgoM/UGl2l+F4ghLfrFISbH+HaqXH8vrK2x8g5aGNnm7J7H37rHS8FQIz+gof6hTgo20KKpYQX1SnQ3V2m2LAcUYs4T0Bge4drTtlcOfCNHN9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846453; c=relaxed/simple;
	bh=a1t7bCBBT1JqFXgoLpLPIzAFz5gO1F7ujmkJJ0Hkl5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rc5TCcZaZXG5ZjMV+PfmLQ0f7pSirtkagWgjS18hKm4ARfMUvIG2jQRTpdfJ3G6/xYTOXId61VAYZkPwTxHWBy/sPuRPaM8RTHQxI/3ibL44fyMSAT78fkky+RKYlXnuaqJxQ00360OTVVaoDQXA/SGadtI6Ck49ZTsnIFzwqr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OPPXYSvF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SAefKA022824;
	Mon, 28 Apr 2025 13:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=seDaDRAvts/ybRbfT
	6WMEYoOYh8mM6UN+9cj9JMviUI=; b=OPPXYSvFureZeDPfUYkpg2ZphpQJWYHIg
	muUzzRUn+IS8ohSg0tgQKFf/GzwD3mld4INOqAdkmZ+CHj/uKCMLzYBCSl+qfElW
	kuYmE57CemecZRTlBOtdDIB+2K6P1gs8Aci4ly2mJKObteksZYKITT1ySdbnxfhj
	Lz47MnWfyhFcbVX6hM8qgz+hZBMai7j1CeD61AagMaFFEMxBUeplTPRo0nuamwei
	OAA9Plo+hTMzfQTCWKI8E4a2gCZ4IvDaFAl60SFTxlxcxAvyLpzcUp1/8t5KBC6E
	3XAVggsVW5aKSH+g7H9dEcSu5HMQz31p4gxY9f2gRWd/4FFYe9sBQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46a84s0qgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 13:20:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53SBZD1F001799;
	Mon, 28 Apr 2025 13:20:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bamegag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 13:20:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53SDKJQY50397596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 13:20:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0E8620040;
	Mon, 28 Apr 2025 13:20:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6F7D20043;
	Mon, 28 Apr 2025 13:20:15 +0000 (GMT)
Received: from li-80eaad4c-2afd-11b2-a85c-af8123d033e3.ibm.com (unknown [9.124.219.50])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Apr 2025 13:20:15 +0000 (GMT)
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/mm: Fix a build failure on powerpc
Date: Mon, 28 Apr 2025 18:49:35 +0530
Message-ID: <20250428131937.641989-2-nysal@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428131937.641989-1-nysal@linux.ibm.com>
References: <20250428131937.641989-1-nysal@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Mchsu4/f c=1 sm=1 tr=0 ts=680f8098 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=eIFaomMv7K_DaQaFpIwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEwOCBTYWx0ZWRfX9cHEmT6RPkmt ULlIMp7J8N67EZZRn6YjvouXN1NecTs93kQx0CYtEpWO1ithBn6qlGoscJj85CSPjnpdjMdQFsX kso9E+w0Jv9BT+HjfjPDd6krV119bAWk8HMwcQQSYORuStzlXdepzd5v69qUr/hthr/9ivRWVit
 4auy2DRbPhfP+876HGUlZxPBWayrwOvwo9bsah3IuW70JON/vy2woJTMEZTqIdUpzBT4O8Px/Z+ frq7QhdXfYGrYBS/KFRK2vJicHGuvgDjPQ/1z65CNanQ47NviMvQqGJvxyGQV7fw1zXXyHb8jU8 C0lImHInMPqt+P6kk1XHqsBoFOEsqq5FqmgrLlvJKb/oSI2f8ZZUMehCNjNwQqp+oaM767xIGF6
 WzLjuoQr4oGmlJQNCpRW0uRGGy5qpEPLbR3pyiJGUvdL/wmn4IhoQjvCChgP/tFXe3BHGorE
X-Proofpoint-ORIG-GUID: NWPF_M0em3vCenetzMbNZhpYx1xdGHLc
X-Proofpoint-GUID: NWPF_M0em3vCenetzMbNZhpYx1xdGHLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=853 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280108

The compiler is unaware of the size of code generated by the ".rept"
assembler directive. This results in the compiler emitting branch
instructions where the offset to branch to exceeds the maximum allowed
value, resulting in build failures like the following:

  CC       protection_keys
  /tmp/ccypKWAE.s: Assembler messages:
  /tmp/ccypKWAE.s:2073: Error: operand out of range (0x0000000000020158
  is not between 0xffffffffffff8000 and 0x0000000000007ffc)
  /tmp/ccypKWAE.s:2509: Error: operand out of range (0x0000000000020130
  is not between 0xffffffffffff8000 and 0x0000000000007ffc)

Fix the issue by manually adding nop instructions using the preprocessor.

Fixes: 46036188ea1f5 ("selftests/mm: build with -O2")
Reported-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
---
 tools/testing/selftests/mm/pkey-powerpc.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/pkey-powerpc.h b/tools/testing/selftests/mm/pkey-powerpc.h
index d8ec906b8120..17bf2d1b0192 100644
--- a/tools/testing/selftests/mm/pkey-powerpc.h
+++ b/tools/testing/selftests/mm/pkey-powerpc.h
@@ -104,8 +104,18 @@ static inline void expect_fault_on_read_execonly_key(void *p1, int pkey)
 	return;
 }
 
+#define REPEAT_8(s) s s s s s s s s
+#define REPEAT_64(s) REPEAT_8(s) REPEAT_8(s) REPEAT_8(s) REPEAT_8(s) \
+		     REPEAT_8(s) REPEAT_8(s) REPEAT_8(s) REPEAT_8(s)
+#define REPEAT_512(s) REPEAT_64(s) REPEAT_64(s) REPEAT_64(s) REPEAT_64(s) \
+		      REPEAT_64(s) REPEAT_64(s) REPEAT_64(s) REPEAT_64(s)
+#define REPEAT_4096(s) REPEAT_512(s) REPEAT_512(s) REPEAT_512(s) REPEAT_512(s) \
+		       REPEAT_512(s) REPEAT_512(s) REPEAT_512(s) REPEAT_512(s)
+#define REPEAT_16384(s) REPEAT_4096(s) REPEAT_4096(s) \
+			REPEAT_4096(s) REPEAT_4096(s)
+
 /* 4-byte instructions * 16384 = 64K page */
-#define __page_o_noops() asm(".rept 16384 ; nop; .endr")
+#define __page_o_noops() asm(REPEAT_16384("nop\n"))
 
 static inline void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
 {
-- 
2.47.0


