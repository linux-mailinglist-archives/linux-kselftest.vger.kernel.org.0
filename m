Return-Path: <linux-kselftest+bounces-11073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7A38D6D0F
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 01:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813C4B2434E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 23:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38CE12FB09;
	Fri, 31 May 2024 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gNw23xcu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DE812F5A0;
	Fri, 31 May 2024 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717199930; cv=none; b=B+HeIiD64TwHcEJb0tRBNFuIwEKC2w7lWKA6tBkVhM3JHgxsRu6v43gQEXYGkebqf/D24QIglFHRj+RXY5WKqsrKb+kHv4HsNrJuxtiAvF+EcBR614pHz/bYsp381kE1TKSw+B0zEnXd+NCqC++L8NiVkViVf21lPUqTpCHE8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717199930; c=relaxed/simple;
	bh=ldIqUKdLlJfwvkEVGQ3sHNe9S9oGV6k/RiEd6WbAtWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Ove6f+sqRgHZeY/0XtlnDJR6rxLmbyvJFk9U9NDCcwC7DAKnTL8Uedj8cazd5AlJqspbSw7iet+ZsnyrYZVa8gGWWLFe8tSq/kok5s08xGlgUQhgvgZBY8z5TJGaPOLW0e19eNLlh62+awwH2P4H/8R/oaA8h/AzA7SdrdcUNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gNw23xcu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VFKboI031609;
	Fri, 31 May 2024 23:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JMeDuGU3mIo/lZd4M3HI1L
	MWPzQogOGjr4Ob9FJRdK0=; b=gNw23xcuRtPSeK25vws03U1S4hNRLRmf6LfwDm
	YSE5JBN7PyUjmkPAENkDO8ddSTebvIsdxiHgHANCvnGWed5aZa6iz0OZtgGj1++f
	DqttMFcmyKRpquPqmnf6c+jsf0YJ8WZnwehccdVkF49yhkJ8EmjHJ2/xc09wOk8Y
	Fowlt8PrfOdQZwUOSZyEfZlO/rWDMSkzeio7lL8LSKR41huddOMBkLZhZcwEhyOa
	2j6fBW+ROevE9T3tbNUX0ApqP2G6zqPY3VEKS6Qt2/GNORIo7jO6h1Maqm+gt9p3
	GXxYYrUaa7bMvmGcPujDgr/PCoV06Q42rFHSpqLDc6ushItw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yf8xa2jjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 23:58:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VNwgDE003553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 23:58:42 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 16:58:42 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 16:58:42 -0700
Subject: [PATCH] list: test: add the missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-list-test-v1-1-50b79241cbb0@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADFkWmYC/x2MQQ6CQAxFr0K6tsnAqKBXIS5mhipNYDTtaEgId
 6ey+D95i/dWUBImhXu1gtCPld/ZoD5VkMaQX4Q8GEPjmrO7+BrnASeONi1YyO7a3jrvqPVdSmD
 aR+jJy5HsH8YxKGGUkNP4D02cvwvOQQsJbNsOoFZUp4EAAAA=
To: David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>, <kernel-janitors@vger.kernel.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UimDwExmiURfXs7MqVUsKGisFAUfD5VG
X-Proofpoint-ORIG-GUID: UimDwExmiURfXs7MqVUsKGisFAUfD5VG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310183

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/list-test.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/list-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 0cc27de9cec8..e87b9941206a 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -1499,4 +1499,5 @@ static struct kunit_suite klist_test_module = {
 
 kunit_test_suites(&list_test_module, &hlist_test_module, &klist_test_module);
 
+MODULE_DESCRIPTION("KUnit test for the Kernel Linked-list structures");
 MODULE_LICENSE("GPL v2");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-lib-list-test-679830e738cc


