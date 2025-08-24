Return-Path: <linux-kselftest+bounces-39812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D624B331FD
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 20:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D953F3AC29B
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 18:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB5D1F1302;
	Sun, 24 Aug 2025 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OAoGvAHR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCF14A8B;
	Sun, 24 Aug 2025 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756059447; cv=none; b=B48uQnsCxpEl2kTRGMvxswCtgZgpTBJ+iM3h1KUXNFfYl1cIFMFb0tTbL32MLbV6nlpD565Kmzub3mwk+zIP1hOshpSw6xbjgNvEBuq1BN0MZ/0v9C5KtVyFfSPis/MXaSsOYTWkyy+KHU0hZ5yiQk//W5wI2TXMbBESRueaQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756059447; c=relaxed/simple;
	bh=Ah+myLjw6RinHRYk5TWerMOeO9as7TkywbCfv0F77X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4mpAY4OWCJZ+4LyPjwXfmzooQ/VwSnupyxGNKyIxzIbOi+39YQatQytQZDrnwKp3f2iq0HfJjCdbkVQ4OCNeONbmqp1zKKb3QRJSx77wYDc4tzqJen5qtXvDPbARDlF1nhHYeQP+Y6RcUOgENv773rHR4a3+vhj2uyRIp8maik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OAoGvAHR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57OHJIua015812;
	Sun, 24 Aug 2025 18:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=rgtPlEuJvshUpOMZGc74jTOEGQwjB
	5yqmoGMZPIu8sw=; b=OAoGvAHRH8H1wABF0qg2Mo/ifbPjQPiV5Q1huWJ4hp8aL
	ye9PQ9gQ9hjBeHxci8A75lgCRmaou34iJuXQeDkWldgcqDHn0Mjhy24KLrXtUlEs
	qtBYcX/70HXQ7dt6NEgobz8Pz6spgUxgKUS/x9UhyMAtUfD9T9vmcehFEs2YxXoD
	VZH34oWHqto8NIIh1SQU5Jtn9hf0IyoONKFAqmdKdYG2lonXdtWhPJG9CDGKvn6h
	4IHyNdqNvcYqEV8zKlRr9BJm2SwvWf/r0TkfQtpg30OeVNNha6XyMh3vxiVya+Rf
	xOv7X4gGSlJN9ltslTqCayTC0Lf+qQkGWYOl/RhJw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt15x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Aug 2025 18:17:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57OE1DK2027171;
	Sun, 24 Aug 2025 18:17:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q437cexr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Aug 2025 18:17:12 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57OIHC3L038105;
	Sun, 24 Aug 2025 18:17:12 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48q437cex9-1;
	Sun, 24 Aug 2025 18:17:12 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: seanjc@google.com, pbonzini@redhat.com, shuah@kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Fix typo in hyperv cpuid test message
Date: Sun, 24 Aug 2025 11:16:40 -0700
Message-ID: <20250824181642.629297-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-08-24_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508240173
X-Proofpoint-ORIG-GUID: CgbUzOsWAuYbnk2x4nPdcDfeiH1slfiF
X-Proofpoint-GUID: CgbUzOsWAuYbnk2x4nPdcDfeiH1slfiF
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68ab5729 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=7ZiSxbHINJ-xqPdSBcQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfXyyfasm8CMFWH
 0qB4Z/4BXnp5kjV5jvzcbWYe34COA0Gw+t71t5wDXLMJjKnJD8C6KdcoVObuRz3heovNJCNWvvg
 dn70O+vOlFp4KdQ4dy3N/E+i9dbJvR5NB2/LuzV6r+ywU7+FonOxRob3ImMbUlQ8R22VPsxZGXk
 Ui2v4wsYCKKLvoS4MMHCOLmHUMs4GlfMgEKUzVZAT2VcvtNIuhJTKLBKUooRvvq0d/63f2uEy/p
 mhRT0V1gXVEbH97Wg5H+TU4jsJK0XetsqndyeW8KZQiJj/dZeGX+znCWIWI9BXkqOi193HacWB7
 ePyU+Tf3hR4UzKCO8EXzSfe/R2YSM1+zKTiThdGQe+zQR4zoicbV/tG/AdwdGwS5xTncBhRLqrC
 0CTyGir3

Fix a typo in hyperv_cpuid.c test assertion log:
replace "our of supported range" -> "out of supported range".

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 tools/testing/selftests/kvm/x86/hyperv_cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86/hyperv_cpuid.c
index c863a689aa985..3c21af811d8f1 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_cpuid.c
@@ -45,7 +45,7 @@ static void test_hv_cpuid(struct kvm_vcpu *vcpu, bool evmcs_expected)
 
 		TEST_ASSERT((entry->function >= 0x40000000) &&
 			    (entry->function <= 0x40000082),
-			    "function %x is our of supported range",
+			    "function %x is out of supported range",
 			    entry->function);
 
 		TEST_ASSERT(entry->index == 0,
-- 
2.50.1


