Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD57551FAC
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jun 2022 17:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiFTPER (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jun 2022 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242850AbiFTPDe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jun 2022 11:03:34 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F06B186D8
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jun 2022 07:35:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z11so9243347edp.9
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jun 2022 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M7gM0wP0+sIb7H3gCRONWN64BT1n/VaMtz6QFS7EwXM=;
        b=RFIUvaSLtaC87H/gtRAbXdAd5CqgCLltDnO/O6KHLQxWsbEwdsDYB7UK4unPoaBZtS
         V7ZPrJhFn51kNPVaWQJJXpV68KCQ5wqBdTXrKpNLYyqn3Ds/WjXVuxybluarzdD1zQCl
         MFFqH9AnZ7GQbRdnDHp3JyUWzFQMOkz4Tshg95eLyhwz0W4qrNjRubrNxc05SyaGy/ka
         eUL2jGCf9bwGStISyRWW/o0vc5wrVapAbPvTVp5Z1S47fHUaGXC3AkuIqx1M+vSJMqJ8
         IK/TlM/ExjHwpqp4L96jgA/L/CDrRknwvPaS6BiYn9DNJ8YnctGQx7rDJv0LZOw4XbPu
         FA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M7gM0wP0+sIb7H3gCRONWN64BT1n/VaMtz6QFS7EwXM=;
        b=XzaT/w8vPkQb8EQCYkSMr0GTV1i35JagBM4Ha53tmf3J9ISP9w4+sKnd12EGhQO480
         jgNoL1MZ8UW0hjseoJT1VS0/yB/Ai2G+5R3pxgDnUihGP0/5wzgncOKADa/d5+Jz8i0/
         4RkPOEHv535O5YYwuiBYoAprdnZHK3ervN23ga0eRGmKBQkPCbvScMAHwkpEwp2l4yam
         sCnY6FIrl2QeZJL269g4OujTs9u/wQ1DdHxG0eSQBmMYis9j16RA8xzoyX7TJooPQX8y
         xI/pxZZGkjLKLsFId6NVuoGwcL3oRTR+Ti3lWns1bZJIK/WdkPS+CUYhzPBKKbZprFsc
         qM+w==
X-Gm-Message-State: AJIora9Z2wAicvQKSfF+gZ3IHZn0UOEGnxnGbeMytI0FtnqniD8spGfX
        EpzBcj0Bsepd9EhCHMWeHamtPirGIx1mstEoE5WFrw==
X-Google-Smtp-Source: AGRyM1sf+R7fPgNDROixrBdE7KPXww0jVCpSttQY7YMNTZ0aJrbMBWN41RXmm1B7kDmN4bsck7XBDg==
X-Received: by 2002:a05:6402:11c7:b0:42e:c47a:ffdf with SMTP id j7-20020a05640211c700b0042ec47affdfmr29709943edw.113.1655735744509;
        Mon, 20 Jun 2022 07:35:44 -0700 (PDT)
Received: from localhost (fwdproxy-lla-111.fbsv.net. [2a03:2880:30ff:6f::face:b00c])
        by smtp.gmail.com with ESMTPSA id mm15-20020a170906cc4f00b006f3ef214e14sm6023802ejb.122.2022.06.20.07.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 07:35:44 -0700 (PDT)
From:   Adam Sindelar <adam@wowsignal.io>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, Adam Sindelar <adam@wowsignal.io>,
        Adam Sindelar <ats@fb.com>, David Vernet <dvernet@fb.com>
Subject: [PATCH] selftests/vm: Only run the 128TB boundary test if 5-level paging is enabled
Date:   Mon, 20 Jun 2022 07:35:36 -0700
Message-Id: <20220620143536.2767866-1-adam@wowsignal.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test va_128TBswitch.c expects to be able to pass mmap an address hint
and length that cross the address 1<<47. This is not possible without
5-level page tables, so the test fails.

The test is already only run on 64-bit powerpc and x86 archs, but this
patch adds an additional check that skips the test if PG_TABLE_LEVELS < 5.
There is precedent for checking /proc/config.gz in selftests, e.g. in
selftests/firmware.

Signed-off-by: Adam Sindelar <adam@wowsignal.io>
---
 tools/testing/selftests/vm/Makefile          |  1 +
 tools/testing/selftests/vm/run_vmtests.sh    | 13 +++++++---
 tools/testing/selftests/vm/va_128TBswitch.sh | 26 ++++++++++++++++++++
 3 files changed, 36 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/vm/va_128TBswitch.sh

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 68cacffc93ec..bc64ca1e0de3 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -80,6 +80,7 @@ endif
 TEST_PROGS := run_vmtests.sh
 
 TEST_FILES := test_vmalloc.sh
+TEST_FILEs += va_128TBswitch.sh
 
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index e953f3cd9664..10cccbedaaa1 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -290,12 +290,17 @@ fi
 echo "-----------------------------"
 echo "running virtual address 128TB switch test"
 echo "-----------------------------"
-./va_128TBswitch
-if [ $? -ne 0 ]; then
+./va_128TBswitch.sh
+ret_val=$?
+
+if [ $ret_val -eq 0 ]; then
+    echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	 echo "[SKIP]"
+	 exitcode=$ksft_skip
+else
     echo "[FAIL]"
     exitcode=1
-else
-    echo "[PASS]"
 fi
 fi # VADDR64
 
diff --git a/tools/testing/selftests/vm/va_128TBswitch.sh b/tools/testing/selftests/vm/va_128TBswitch.sh
new file mode 100755
index 000000000000..f7b9db0bfd33
--- /dev/null
+++ b/tools/testing/selftests/vm/va_128TBswitch.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2022 Adam Sindelar (Meta) <adam@wowsignal.io>
+#
+# This is a test for mmap behavior with 5-level paging. This script wraps the
+# real test to check that the kernel is configured to support at least 5
+# pagetable levels.
+
+# 1 means the test failed
+exitcode=1
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+check_test_requirements()
+{
+    pg_table_levels=$(gzip -dcfq /proc/config.gz | grep PGTABLE_LEVELS | cut -d'=' -f 2)
+    if [ $pg_table_levels -lt 5 ]; then
+    echo "$0: PG_TABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
+        exit $ksft_skip
+    fi
+}
+
+check_test_requirements
+./va_128TBswitch
-- 
2.30.2

