Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F3C2C874C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Nov 2020 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgK3O73 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Nov 2020 09:59:29 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:58910 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727846AbgK3O73 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Nov 2020 09:59:29 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AUEonkS002183;
        Mon, 30 Nov 2020 08:58:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ROkKUZtQlKRaD5HWMT165kYH8ibelo6zlyPRXKnM1E4=;
 b=onLLdufSoirHEXsy92kOH4gQy86PhnN6LxzbfGuyBObXWf4qnMSvh18u6rXJQj/ziiT6
 +V1aCbCJk3qVcZIMG49dp87EZopQJBmUFV46uUrXiuDVY2JXNxSYa9/r9XZk9b37nVFr
 dh5l8VBqV4WO6c+kthzZSMpuyNKnnxUpZcq45IFZuVft9PQnGwhYCRewPyTQxhbhS0SI
 JtnXTztEZ/lBpvul587osXy5L+MV0vCrgK+rBwflPfpSUJwC9XwY9ZuzFY/CxHGvB8J/
 tA6hRG2P/GGexp16uhs82qfi1aDy5S02knvzPiYBCksrfOPYF5S3wGReLQFVreCWIAfQ DA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 353mu7a4sd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 08:58:16 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 30 Nov
 2020 14:58:14 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 30 Nov 2020 14:58:14 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.188])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A4E3745;
        Mon, 30 Nov 2020 14:58:13 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>, <shuah@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 3/4] selftests: lib: Add wrapper script for test_scanf
Date:   Mon, 30 Nov 2020 14:57:59 +0000
Message-ID: <20201130145800.19960-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201130145800.19960-1-rf@opensource.cirrus.com>
References: <20201130145800.19960-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=825
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300097
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds a wrapper shell script for the test_scanf module.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 tools/testing/selftests/lib/Makefile | 2 +-
 tools/testing/selftests/lib/config   | 1 +
 tools/testing/selftests/lib/scanf.sh | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/lib/scanf.sh

diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index a105f094676e..ee71fc99d5b5 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -4,6 +4,6 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh strscpy.sh
+TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh scanf.sh strscpy.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index b80ee3f6e265..776c8c42e78d 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -1,4 +1,5 @@
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_TEST_STRSCPY=m
diff --git a/tools/testing/selftests/lib/scanf.sh b/tools/testing/selftests/lib/scanf.sh
new file mode 100755
index 000000000000..b59b8ba561c3
--- /dev/null
+++ b/tools/testing/selftests/lib/scanf.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Tests the scanf infrastructure using test_scanf kernel module.
+$(dirname $0)/../kselftest/module.sh "scanf" test_scanf
-- 
2.20.1

