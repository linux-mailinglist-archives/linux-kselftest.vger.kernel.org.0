Return-Path: <linux-kselftest+bounces-12182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B8990E058
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF2A1C21275
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 00:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E5B380;
	Wed, 19 Jun 2024 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ua/TTQQY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B5181;
	Wed, 19 Jun 2024 00:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755534; cv=none; b=nwEKATC7Q1UfrFG7lP6WoWklS19TOIpTzm4T+A+8oknzYoAo9OiC6glkhDUS+uuuYHgvvM4V+rAobEoj4ZkhFoPlBVLzRht2KySdUz3xWdq1nrztKKxCp2vXiWKfB0JoO0MZBcXDcnA4MHOZVCc4uWP5qbfV7J44dRnbxOhSWp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755534; c=relaxed/simple;
	bh=mO7uNlI6EqQmvX/oussd84ugeoJdJFRO2MOzE1RAeQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bPJUIzKuw6At5lg+9hIkOh6JMgRHFVVFfWiUgXLANKKgn0cIOCu6+puG2d+DSP/o0rgNGu/UpY6S6a5VntWC5AfvM7vptgtOvpCn8684M4+ujnVGRS4sIBi9hLY2MbDj1d6eTIDBrkjvbDvhNhav5sO4pS6uuTxw7Bw7OzCJel8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ua/TTQQY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IMFwkH016036;
	Wed, 19 Jun 2024 00:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fbO+Vx6FL2r30CUuolgRIrjrd/S25P9zWMEY/WMDOJw=; b=Ua/TTQQYT8glFHXW
	LchHycEnI/XJlu9OkuSKKkzIokPq+WYkDbm9QUpGy0LILerA0qctjtvnnsXBIG2K
	xS5vVGKhdEeLJVuU5ZjxobXgt6siWIs2lxCz8B2vD0HhXc1sZ3AhxaH5TxnBydem
	gKbCo5eOK3cx2W3bF/heGEI/tTuxELAxpjI3qAfX13yZZNW2DGDVxXOMCXWzYcYN
	6jgN2CBe8mpIa1D6DVGWxlbUFFrdLUQltstDGWbuutlONHp11wj/29GjJtA6PjMK
	sdVzcMoJGKsdMO+apXi4QUGIDX9SqGqdQ2NTO5XvHvwvHO24ZveFByS61VBEdxxm
	LwXswg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yujah877q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J05H2c006643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:17 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 17:05:17 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 18 Jun 2024 17:05:10 -0700
Subject: [PATCH RFC 4/5] mm/gup-test: Verify exclusive pinned
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-exclusive-gup-v1-4-30472a19c5d1@quicinc.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
In-Reply-To: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, <maz@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <pbonzini@redhat.com>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ep5_bKbxZPmtupXQY1F98ZZxOd7BDf84
X-Proofpoint-GUID: Ep5_bKbxZPmtupXQY1F98ZZxOd7BDf84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=812
 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180176

Add test that pages have the exclusive pin bias when providing
FOLL_EXCLUSIVE.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 mm/gup_test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/gup_test.c b/mm/gup_test.c
index eeb3f4d87c510..9c6b8c93e44a7 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -66,6 +66,26 @@ static void verify_dma_pinned(unsigned int cmd, struct page **pages,
 	}
 }
 
+static void verify_exclusive_pinned(unsigned int gup_flags, struct page **pages,
+				    unsigned long nr_pages)
+{
+	unsigned long i;
+	const struct folio *folio;
+
+	if (!(gup_flags & FOLL_EXCLUSIVE))
+		return;
+
+	for (i = 0; i < nr_pages; i++) {
+		folio = page_folio(pages[i]);
+
+		if (WARN(!folio_maybe_exclusive_pinned(folio),
+			 "pages[%lu] is not exclusive pinned\n", i)) {
+			dump_page(&folio->page, "gup_test failure");
+			break;
+		}
+	}
+}
+
 static void dump_pages_test(struct gup_test *gup, struct page **pages,
 			    unsigned long nr_pages)
 {
@@ -185,6 +205,8 @@ static int __gup_test_ioctl(unsigned int cmd,
 	 */
 	verify_dma_pinned(cmd, pages, nr_pages);
 
+	verify_exclusive_pinned(gup->gup_flags, pages, nr_pages);
+
 	if (cmd == DUMP_USER_PAGES_TEST)
 		dump_pages_test(gup, pages, nr_pages);
 

-- 
2.34.1


