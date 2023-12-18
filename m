Return-Path: <linux-kselftest+bounces-2158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E70817513
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 16:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E841F24B56
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF2F3D557;
	Mon, 18 Dec 2023 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bZt4B8QU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08515485;
	Mon, 18 Dec 2023 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BICT98m005192;
	Mon, 18 Dec 2023 09:17:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=e
	vsG9arND7+YtX1uYAIhQEshiu9bxevrDqV1h0a/GAc=; b=bZt4B8QU6qyHnFsIi
	6HSq1Le18T5l/9eVaZmZcV0n9xix1cRyg7dpCxbwulV6BUUg1eGE3nxZKiw8qkYz
	PD6srcbonzKPOf+Nl4M15eNSs4O5pT0ew/4Izu9ugFV63LLJIBDS4Kba+0EM+M0K
	X/2p123O7HrJjBA0YMuvVem8fpFDZxHUho8cQSuwzovL87bS2zQMNhCGlzgBFp8l
	2kCsl6bxd2jSNVlXKqvWjM3fNHMN0FzOlOF1tm+YzaAqjq3BzMg/O93R5nk+cipC
	8tEovEmEYhYXnbLlhFS6IXlf/o9zcGWnUiGY/aq3rqUT7HbmPnHirSKVM68Vpopl
	dAR/g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3v196nau46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 09:17:33 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 15:17:32 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 18 Dec 2023 15:17:32 +0000
Received: from work-debian.ad.cirrus.com (EDINJ39Q8D3.ad.cirrus.com [198.61.65.115])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B1FD515A0;
	Mon, 18 Dec 2023 15:17:31 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <brendan.higgins@linux.dev>, <davidgow@google.com>, <rmoar@google.com>
CC: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] kunit: Fix NULL-dereference in kunit_init_suite() if suite->log is NULL
Date: Mon, 18 Dec 2023 15:17:29 +0000
Message-ID: <20231218151729.210027-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6-WZmN5DLqvHa1b2pkx3jcJdWCidvtaj
X-Proofpoint-GUID: 6-WZmN5DLqvHa1b2pkx3jcJdWCidvtaj
X-Proofpoint-Spam-Reason: safe

suite->log must be checked for NULL before passing it to
string_stream_clear(). This was done in kunit_init_test() but was missing
from kunit_init_suite().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 6d696c4695c5 ("kunit: add ability to run tests after boot using debugfs")
---
 lib/kunit/test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e803d998e855..ea7f0913e55a 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -658,7 +658,9 @@ static void kunit_init_suite(struct kunit_suite *suite)
 	kunit_debugfs_create_suite(suite);
 	suite->status_comment[0] = '\0';
 	suite->suite_init_err = 0;
-	string_stream_clear(suite->log);
+
+	if (suite->log)
+		string_stream_clear(suite->log);
 }
 
 bool kunit_enabled(void)
-- 
2.30.2


