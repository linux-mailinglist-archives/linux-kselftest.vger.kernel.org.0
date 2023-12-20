Return-Path: <linux-kselftest+bounces-2270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8129E81A332
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 16:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23DF3B230EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761CC40C1D;
	Wed, 20 Dec 2023 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bRyOBBcJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74464778E;
	Wed, 20 Dec 2023 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKFAj8b027175;
	Wed, 20 Dec 2023 09:52:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=F
	5sbvrgTVmhtel2oNQz7C7epZ+XvoS2wY5UmZpkNQgQ=; b=bRyOBBcJdMaJCN36C
	Iki9b/LW49vdlbV2Ec21znP58uQbtvZci8ndmkXqeha3S/hCIodPB2OKqw9eMxHJ
	gOnyyxRoYgv+RsjHt3RzcNRG4JeI9E+vU0nfWRfTKqZyJc3syvH700CQZ91yJu1h
	iq0laukD8sldBRtr8tlkym30N4A/pAZM03Tj6wbttgsAwtOOHr9SYsOXkHP78nqI
	hBZUUC7XVGpFii0Vs5tJXlv4/fM0/m7JUeYmiHT3u3qreYGJFK0aSlmtr/Iwnlyc
	YohUPaGyIFsqgBzq6Xr3LoWFZ3xYy8ayN3FOaVTQNF4L6FaYwmiU9nq7IShAqOw+
	u8aiQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3v196ndmxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 09:52:57 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 15:52:56 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 20 Dec 2023 15:52:56 +0000
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.82])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4B00B11D1;
	Wed, 20 Dec 2023 15:52:56 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <brendan.higgins@linux.dev>, <davidgow@google.com>, <rmoar@google.com>
CC: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] kunit: Protect string comparisons against NULL
Date: Wed, 20 Dec 2023 15:52:56 +0000
Message-ID: <20231220155256.407974-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CfJWcoIQ1BfjL_JfiueeI0Y0Zpicel4K
X-Proofpoint-GUID: CfJWcoIQ1BfjL_JfiueeI0Y0Zpicel4K
X-Proofpoint-Spam-Reason: safe

Add NULL checks to KUNIT_BINARY_STR_ASSERTION() so that it will fail
cleanly if either pointer is NULL, instead of causing a NULL pointer
dereference in the strcmp().

A test failure could be that a string is unexpectedly NULL. This could
be trapped by KUNIT_ASSERT_NOT_NULL() but that would terminate the test
at that point. It's preferable that the KUNIT_EXPECT_STR*() macros can
handle NULL pointers as a failure.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/kunit/test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index b163b9984b33..c2ce379c329b 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -758,7 +758,7 @@ do {									       \
 		.right_text = #right,					       \
 	};								       \
 									       \
-	if (likely(strcmp(__left, __right) op 0))			       \
+	if (likely((__left) && (__right) && (strcmp(__left, __right) op 0)))   \
 		break;							       \
 									       \
 									       \
-- 
2.30.2


