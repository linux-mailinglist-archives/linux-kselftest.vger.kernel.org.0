Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0B62DD6BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 19:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgLQSCP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 13:02:15 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:51660 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727368AbgLQSCP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 13:02:15 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHHpgXN007072;
        Thu, 17 Dec 2020 12:01:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=uVWPaUAEkQl2q9gPD+VtCUXeC+LPB+fA8dWpPP4F8/A=;
 b=Wd9qA1gg3lwnieonb8GeT8R9Prn298peWouPQOMjoTADRBvRkXafbp05I9DyGcKczYiP
 2XRrXXvQbA/6km/F7nXllbKkJYhmTY/yQeYvTeCruGl2sE0ZMwstjIhK0618KZXDpvnx
 kLtvjTGLnJhCFqg0LPdngSSzcfU1N24vP2Wl+hrty+EosQ4ROnKFzSB+GAW3MhuyxNsb
 uBuPI138NqaUqiOtm6C2gR9ieBfMgis9NINdgKgxE1GtG22P7eHXxoBXdZE+UgEsrcaf
 17317mshz2PFYIOAS9MA3NpT6GLVV6mb8RpY20+ZqFIGlK5Wo5tqxDzPj02kmhpznuum 1g== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35cu5ry5ne-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Dec 2020 12:01:03 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 17 Dec
 2020 18:01:01 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 17 Dec 2020 18:01:01 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.236])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0639D11CE;
        Thu, 17 Dec 2020 18:01:00 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>, <shuah@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 4/4] selftests: lib: Add wrapper script for test_scanf
Date:   Thu, 17 Dec 2020 18:00:57 +0000
Message-ID: <20201217180057.23786-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201217180057.23786-1-rf@opensource.cirrus.com>
References: <20201217180057.23786-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=822 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170123
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds a wrapper shell script for the test_scanf module.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
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

