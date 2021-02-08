Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D064231346C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 15:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhBHOFD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 09:05:03 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:9324 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232400AbhBHODQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 09:03:16 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 118Dv56D010374;
        Mon, 8 Feb 2021 08:02:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4y/KMCv5Ll+ZgNu/hBLzOZq3keYHvT4kV6J7Uxtt17E=;
 b=PAfWsvLeasA48rPQULNCH6f1BenyHSGJbSHVqJd3cNCRB2RGh/ZrJF7uIPpHxwVccwi7
 4gmXuB9H/BirJBLlypiZSh9zT2HzGfTI6/6F6ssGqkNIfsOs+j74L5/6brsidnVhhdtp
 HCd2LHimWJjn3ZFJZTpfQFJ+uWj3/uaWY6GsNldoQVlZ2Ya3DpmTBUuOLyl/NRZjbSfm
 3UvtoNje1Johe9FDCKNbLCBQ25aw+RhhN76ZUm4gS5URvoY2GGLU6nsyKL4FtdJjPFO5
 jcjuEFQyOLnNw87fXaonIUV3WPeW7RIoZHJKuZudBJeHZQantkUBkAlFhlTSFDqE2xRW 1Q== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36jdac99p4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Feb 2021 08:02:00 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 8 Feb 2021
 14:01:59 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 8 Feb 2021 14:01:59 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.240])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B14AB11CC;
        Mon,  8 Feb 2021 14:01:58 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v5 4/4] selftests: lib: Add wrapper script for test_scanf
Date:   Mon, 8 Feb 2021 14:01:54 +0000
Message-ID: <20210208140154.10964-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210208140154.10964-1-rf@opensource.cirrus.com>
References: <20210208140154.10964-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=925 phishscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080095
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

