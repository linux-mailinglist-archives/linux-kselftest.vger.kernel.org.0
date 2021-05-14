Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759F4380E32
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 May 2021 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhENQbF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 May 2021 12:31:05 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:21614 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230009AbhENQbF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 May 2021 12:31:05 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14EGPuvd011562;
        Fri, 14 May 2021 11:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=pURXyEbufO34s3H/mKKyt6oXSIaLkoflKS02BSTQm1A=;
 b=djQIDzJ/vuj9kK9AqV77XJhzqR8P7VYpX4UgcS6MEfeyiKODhuZVyRKCuFmFuJOpz/Bz
 RPk4qgDYDtCYTClbQJMFl6539zlCjscbi/SiJ50Y1KewlYuffnLwvmQy3oh6ag9ixnVI
 eiZ4ZrZOTdO7Vu7mS4Xee3yozZAj43mAvQIXYAQJpssNzB+i2fAZ/nAVa+ucn402bmoh
 y29HN0H0DdCmx+kSUTuaT5voR4us2+IsDf+Sn+7hOXs4mGCXsGDHMeuxvYOHjH6FwFku
 Xsw2D3N1XF9Po0rktVO5IPkHoHxPsXkwlCAMJpy3hlDUXV8IRJYopaPlVk7Php+DTuvX bw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 38hdbrh1xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 May 2021 11:29:20 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 17:12:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 17:12:14 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1464611CD;
        Fri, 14 May 2021 16:12:14 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v8 RESEND 4/4] selftests: lib: Add wrapper script for test_scanf
Date:   Fri, 14 May 2021 17:12:06 +0100
Message-ID: <20210514161206.30821-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210514161206.30821-1-rf@opensource.cirrus.com>
References: <20210514161206.30821-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BfgYvkxBsmuFc-exjcHroR4RsLwSEwxp
X-Proofpoint-ORIG-GUID: BfgYvkxBsmuFc-exjcHroR4RsLwSEwxp
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140130
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds a wrapper shell script for the test_scanf module.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changed since v6:
Fixed typo in tools/testing/selftests/lib/config:

	-CONFIG_TEST_SCANTF=m
	+CONFIG_TEST_SCANF=m

As this is a trivial change I have kept Petr Mladek's Reviewed-by and
Andy Shevchenko's ack.
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
index b80ee3f6e265..645839b50b0a 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -1,4 +1,5 @@
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANF=m
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

