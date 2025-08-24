Return-Path: <linux-kselftest+bounces-39813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDE7B33252
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 21:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE1B7AC717
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 19:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCBD1F099C;
	Sun, 24 Aug 2025 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pz+w2RBM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2D314A4F9;
	Sun, 24 Aug 2025 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756063079; cv=none; b=a0gqUq+hn1UolH7DPiVFX7tZWcySUyLgCkt0alr5xu0WMyCxgjFE3axOxlaqKMmEIbPVQtI7W3IOxFki2kVOZZznU9E6SJymbngbu+Dnylyx250tXxJ0qRPafB9BGaGzrwPCDf7ljDo+0W9+os9bCRkkWBMM8MGQeLVfPUEEq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756063079; c=relaxed/simple;
	bh=oYu3AEDa0TRtvcj+z6xaQAuj/MVapve83cGXiYV4UTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYn06/BAZ/qr1OCR3M72m69I8MSTptlQjHneoMltUUXJuNyEf8592DacrqNRhmMBvInT4kkK7d+GEU/hGPsrFptbU0t8C0jF3IQY1cguhc0x3s0lqu72BBdOPas052FSYZZkWynmqXk1uWMvgCQPVJml2onQPLU4N0K+HPpGyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pz+w2RBM; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57OIVKH8017233;
	Sun, 24 Aug 2025 19:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=9lmN5Yioo1QqsiV40k9ebaXaEmTYE
	i9mxlYj+PVkIxw=; b=Pz+w2RBMDehNsI+1Hf1IIT0baB+ZqPLniNqttmx1g1mzf
	4Oij99hWsNDhbDae0xsrxOUowL+8GJYq86gV4PAFLNeTR67MLyfSi28qf1ixvNMs
	VobBbJbimkD1CHLObTh5pHopiPmeenAF3THzR/B0teAVpnOaJnDUWeW/2iwRAF6E
	QCimNzY/pOams71bc8U7BmAMqg551czDL7zueXwj5yE3q/ceWMRS7ht57J7pR5Lq
	zHn4zobhJ+XbCoAwpfCpo7UOjLYZYOTWhxrPkCigwo3mM/By3jARGhpeFKUyOspv
	RsUsC+kdGCaXgK1J1oIVGma3A4SErOQFDN0cbuHHQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt16v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Aug 2025 19:17:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57OIxw0o026772;
	Sun, 24 Aug 2025 19:17:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q437d9w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Aug 2025 19:17:51 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57OJHpYP006658;
	Sun, 24 Aug 2025 19:17:51 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48q437d9vv-1;
	Sun, 24 Aug 2025 19:17:51 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: shuah@kernel.org, dev.jain@arm.com, broonie@kernel.org,
        linux-kselftest@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: fix typo in ss_flags check message for sas.c
Date: Sun, 24 Aug 2025 12:17:16 -0700
Message-ID: <20250824191721.631980-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-24_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508240183
X-Proofpoint-ORIG-GUID: 8Umo7c7tYRFHyJH68gg6IpN7EG6kzA9U
X-Proofpoint-GUID: 8Umo7c7tYRFHyJH68gg6IpN7EG6kzA9U
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68ab6560 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=OQvTAjIdMcoE0BJuZ4YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfX4ENL9DT8fAE8
 2tHOTDmtsdrUvnJ6/UiYOWud0GdBHN4nhLgoeJ/ssALd9fceKmoPgbWYSxrw6LjsokEAO3amGI1
 zyz1v0/B0VJVp8Uk4EnKleLu9W5Q4uhQIUHJY/ac8fknSkReLR3ko0CfbyRsPiNQB6/Yv8AyNRf
 kGdxCF6dE5dTuqWToECa1cZcMltYEqmqDRgy/sgGmLHn9wlhtLsls9pOG2dDSbIGk4qgr9yTKei
 ViF6Dnb9X1gBYM1LWTqoSJQxtWoy7s3XYrVcVhn5nJRB3LODpUSsR95JbE9X/34Jfwt1a7KAo//
 lCipB/A0VRDG/A/24zLbOv90fXtm9jggoy3dovn1Gc4ghdlVGOFQOSUPb7OdT04sWZjPwUXThuE
 XowsTmYn

Fix a typo in the signal alternate stack test where the error
message incorrectly used tss_flags instead of the correct field
name ss_flags.

This change ensures the test output accurately reflects the
structure member being checked.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 tools/testing/selftests/signal/sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/signal/sas.c b/tools/testing/selftests/signal/sas.c
index 07227fab1cc98..476ffa807a61e 100644
--- a/tools/testing/selftests/signal/sas.c
+++ b/tools/testing/selftests/signal/sas.c
@@ -64,7 +64,7 @@ void my_usr1(int sig, siginfo_t *si, void *u)
 		exit(EXIT_FAILURE);
 	}
 	if (stk.ss_flags != SS_DISABLE)
-		ksft_test_result_fail("tss_flags=%x, should be SS_DISABLE\n",
+		ksft_test_result_fail("ss_flags=%x, should be SS_DISABLE\n",
 				stk.ss_flags);
 	else
 		ksft_test_result_pass(
-- 
2.50.1


