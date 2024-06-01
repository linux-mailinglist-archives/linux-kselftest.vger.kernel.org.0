Return-Path: <linux-kselftest+bounces-11087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF50C8D7155
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 19:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C809B220FE
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E359D154BE0;
	Sat,  1 Jun 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VL1ZwYSG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4344150985;
	Sat,  1 Jun 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717262371; cv=none; b=pVVhxd6fAd2liCgTHTcdGVDjE+DTomC8dpQD27YIHUJAtjKdYBZpYAXIua9CfsN6lqDXA7HQ+SIgH1uswRu94/PHqH/PFWW+zl0nAQeN/rzn5FUhpPVMzvQPJkgH4+qdnkHJZA95gRvJ0qfB/kCd81DqnFdYCg1579jm2ttOLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717262371; c=relaxed/simple;
	bh=lIhn43BwQ32JA6UG4cK0p+IYzQuCHKH2dan2bZP6Kfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=PNVClUZvoUmaGJ8dmNvuOk+mm/vMThACOx7Ep+erUL2XGUCof5hesLzEljjLARs5toZsV84Q78J3ABnK3IOo+BjO6sVPsakRrM4D9RJDoRL2iziGUTYWK14S58Iy7wTrk1ZDuJmZBZn7GuHGZHJnNm9JWZKtAHJ3lQyATcQU9RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VL1ZwYSG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4515aBin026061;
	Sat, 1 Jun 2024 17:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WolRTNGs22Qwu5W/wrcTRr
	Mf/7sM+ga4NIe988M9EP0=; b=VL1ZwYSGrMfUCgmf/Anf8pmVGsR9A+EHehsuWq
	rEirhkeBKdybSObVukQNN8AOO5zbav5gUOqybamlWJakKvfdECxk7CJahha8raU1
	3OnVUaiqFn/GZdXTMkjokqP9SS3LR4fHDJMu71k+610cKtOTmO9yzCSi1nq/QLG9
	ecx1QolGIwQQi7iv+n7pBeMHGIN6o7OTMh/j6wovG/J15o3mKvaz82mDNhAxwaT8
	m+QQq1mdKN5kSHJb7kb05xC5VdG4P3826ta/D0fQ4NJJWxCtWIAowmpZJ26MSGSh
	E42xUkbePU4lSw2sm3IzFbMDjMHVictQFKhy+5qoWFFIp/eA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw59h2qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 17:19:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 451HJCQb026303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 17:19:12 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Jun 2024
 10:19:12 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 1 Jun 2024 10:19:11 -0700
Subject: [PATCH] kunit: add missing MODULE_DESCRIPTION() macros to core
 modules
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240601-md-lib-kunit-framework-v1-1-f406bb629bde@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAA5YW2YC/x3MQQ6CMBBA0auQWTtJabQar2JctHQqE2gxM4Akh
 LtbXb7F/zsoCZPCvdlBaGXlqVS0pwa63pcXIcdqsMaejTMt5ogjBxyWwjMm8Zk+kwxI0cZbcOl
 CVwc1fgsl3v7jx7M6eCUM4kvX/3Yjl2XD7HUmgeP4Asntrn+HAAAA
To: Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow
	<davidgow@google.com>, Rae Moar <rmoar@google.com>
CC: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RNeXgOlWJIMjqVBM7aTCq01U20WHj6U-
X-Proofpoint-ORIG-GUID: RNeXgOlWJIMjqVBM7aTCq01U20WHj6U-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1011 mlxlogscore=987 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406010136

make allmodconfig && make W=1 C=1 reports in lib/kunit:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/kunit-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/kunit-example-test.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/kunit/kunit-example-test.c | 1 +
 lib/kunit/kunit-test.c         | 1 +
 lib/kunit/test.c               | 1 +
 3 files changed, 3 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 798924f7cc86..3056d6bc705d 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -374,4 +374,5 @@ static struct kunit_suite example_init_test_suite = {
  */
 kunit_test_init_section_suites(&example_init_test_suite);
 
+MODULE_DESCRIPTION("Example KUnit test suite");
 MODULE_LICENSE("GPL v2");
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index e3412e0ca399..37e02be1e710 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -871,4 +871,5 @@ kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
 		  &kunit_current_test_suite, &kunit_device_test_suite,
 		  &kunit_fault_test_suite);
 
+MODULE_DESCRIPTION("KUnit test for core test infrastructure");
 MODULE_LICENSE("GPL v2");
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index b8514dbb337c..e8b1b52a19ab 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -938,4 +938,5 @@ static void __exit kunit_exit(void)
 }
 module_exit(kunit_exit);
 
+MODULE_DESCRIPTION("Base unit test (KUnit) API");
 MODULE_LICENSE("GPL v2");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240601-md-lib-kunit-framework-ed2d8b6f5e76


