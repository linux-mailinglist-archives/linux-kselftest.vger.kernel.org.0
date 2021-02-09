Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF67315346
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 16:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhBIP5m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 10:57:42 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:54474 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232294AbhBIP5j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 10:57:39 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119Fh3J1011740;
        Tue, 9 Feb 2021 09:56:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4y/KMCv5Ll+ZgNu/hBLzOZq3keYHvT4kV6J7Uxtt17E=;
 b=LzyvM/a3qtRWG2HunrBfNB5bj7JpKteFl2/QlJmLYSwb42Hy4j0iVYQp6RJcnAz0RxCe
 kI8tv4wE+tVHrvzOfO3Fb6d7KGJPsv1evpPRfh1MiywyUEsulvUVdENLywMOPDHACsdp
 wqNSExJPoqhb+QCk8ITmDEH668GQVaIKDLsji1Q+up+xLtbhK2Wq4VFG4f+jq8Jfx4t9
 VV8FAFkBKbsAW4LiyvHNjDriWQIn87+1hSNA/amAcDI/hNzOMxwpeUNX8UIonhDCsDZG
 FzjogiEzB+rGLhaWEQKDngsRxKAen1V5R6a1wmKSDrsLGY9nZ3pNDZGzhtTSh9JtQel8 Fg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36jdacaw94-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 09:56:24 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 9 Feb 2021
 15:56:21 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 9 Feb 2021 15:56:21 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.240])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7156F2AB;
        Tue,  9 Feb 2021 15:56:21 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v6 4/4] selftests: lib: Add wrapper script for test_scanf
Date:   Tue, 9 Feb 2021 15:56:04 +0000
Message-ID: <20210209155604.6998-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210209155604.6998-1-rf@opensource.cirrus.com>
References: <20210209155604.6998-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=929 phishscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090081
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds a wrapper shell script for the test_scanf module.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

