Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C410E5C944
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2019 08:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfGBGYL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jul 2019 02:24:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43361 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfGBGYK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jul 2019 02:24:10 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hiCD2-0001z3-Cn
        for linux-kselftest@vger.kernel.org; Tue, 02 Jul 2019 06:24:08 +0000
Received: by mail-pl1-f198.google.com with SMTP id 59so8496673plb.14
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Jul 2019 23:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yDzSSlzz68xbYUEa8P0cxC2ju66W5gHLv670zzKjJew=;
        b=fFDfRT4yA1qa6+0X/ZORyqeaKAeiOYWd8N0CR+W/BGgMi8SpIA7hf8huG84y+10XMs
         FO05Ou+K3mLAdp0MweSAD9a0u0AnVY4AqGW2QeJ+V4MnHrCxK9ZGLtKNN4r1PZc2FTgX
         aKhy+xkfTjaGaLt8YxsokqvZQXJY9DVFwShd/m8x7Pxu+AmY5OY1+mVGhm41GzXyToWy
         n7XXU8laeh9b6vJakA1eCvG6MkCcA28LIMwEN8Ua8eABUed2I7CJ+RA3AEyyiEEF1HAb
         Q3pk3MNG8pTky6XPtxlWrFEQ3Ah7MvxuYEUr1MXZENaWDUAY5nLYKbF6kgCasOrnlQkM
         5lSA==
X-Gm-Message-State: APjAAAXvPfrdUyAsjbgeav+jllVNrg2v12p5tPbktILRbHaQNa0h2boo
        ehoEzdqmNmjpnTw08ZTRpAetJ0ULrxcbnDWFrgg1sSXGd5iQfBljxcMsOjHwjSUgNz49vdVL1nC
        DuOkpMAqmnq7ULJZg88MVniPd4IUijNVSjcvzh5XgMGyW
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr15683734pgc.20.1562048647066;
        Mon, 01 Jul 2019 23:24:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwUpzq2O1mJvjQuO/WoeUFhiR35393YmkG+4pab7PCu9wdkXJehbwSHHo5dvrDOFonRuGu1Ew==
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr15683711pgc.20.1562048646698;
        Mon, 01 Jul 2019 23:24:06 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id l68sm2569488pjb.8.2019.07.01.23.24.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 23:24:06 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     rostedt@goodmis.org, mingo@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/ftrace: skip ftrace test if FTRACE was not enabled
Date:   Tue,  2 Jul 2019 14:23:58 +0800
Message-Id: <20190702062358.7330-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The ftrace test will need to have CONFIG_FTRACE enabled to make the
ftrace directory available.

Add an additional check to skip this test if the CONFIG_FTRACE was not
enabled.

This will be helpful to avoid a false-positive test result when testing
it directly with the following commad against a kernel that does not
have CONFIG_FTRACE enabled:
    make -C tools/testing/selftests TARGETS=ftrace run_tests

The test result on an Ubuntu KVM kernel will be changed from:
    selftests: ftrace: ftracetest
    ========================================
    Error: No ftrace directory found
    not ok 1..1 selftests: ftrace: ftracetest [FAIL]
To:
    selftests: ftrace: ftracetest
    ========================================
    CONFIG_FTRACE was not enabled, test skipped.
    not ok 1..1 selftests: ftrace: ftracetest [SKIP]

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/ftrace/ftracetest | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 6d5e9e8..6c8322e 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -7,6 +7,9 @@
 #  Written by Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
 #
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 usage() { # errno [message]
 [ ! -z "$2" ] && echo $2
 echo "Usage: ftracetest [options] [testcase(s)] [testcase-directory(s)]"
@@ -139,7 +142,13 @@ parse_opts $*
 
 # Verify parameters
 if [ -z "$TRACING_DIR" -o ! -d "$TRACING_DIR" ]; then
-  errexit "No ftrace directory found"
+  ftrace_enabled=`grep "^CONFIG_FTRACE=y" /lib/modules/$(uname -r)/build/.config`
+  if [ -z "$ftrace_enabled" ]; then
+    echo "CONFIG_FTRACE was not enabled, test skipped."
+    exit $ksft_skip
+  else
+    errexit "No ftrace directory found"
+  fi
 fi
 
 # Preparing logs
-- 
2.7.4

