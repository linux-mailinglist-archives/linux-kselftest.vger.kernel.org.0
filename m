Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9996259EE11
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 23:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiHWVUH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 17:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHWVUG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 17:20:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA7E57883
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 14:20:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33d356e7629so83293287b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=8VeZYoidRbxCrAGHLIxsjoWrKlcdP3ygGRJKvTGM14s=;
        b=sUPIwT+TKjogJoBV6i+R1coppPbUF2jIqnYJesgbisbTP/7RulqcH/pADy3obDIwqn
         V3qaBMquKA1unRavnFfL+bDjWHEmPa0njGLkzXOkZis6LmBig4WeqzX+4EE7rMXT90NV
         NdLg+cLKCLuT9McTFZPW0hfo5LT3pf11SzNHeUw+e3Jm34tiDHL90ra/kV+xHP0j/ZyK
         9+MFtYY7hOnhrhLtvYQkhrq5iWy5bAuaqauIq3xLvcPxCbl1eU9/IicO6UYeEBT1FC4c
         CJj6znhOj5GOFovB3NWxHB51Jd9lWYsk2wF+fAUm8SjgqVx8u7KMhlZQZn8KFJpqw6YF
         +EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=8VeZYoidRbxCrAGHLIxsjoWrKlcdP3ygGRJKvTGM14s=;
        b=hHmiZWzKradlWWZmD8ww+XyDq0lz73xDMLC5h9QX3L3t/780FESbkAczuSVrZHGyk9
         kB5UKh87H2RCEGky2/+RSnZRrHwJSsyWrCB8QlJMcquQMQnKj+IKMNeo9zU0tXOFLKiP
         0BK8q1ngPCqCbrlO57JQkjXj2U8JLZS6hGz+xAXbWmzXPp2caBN0wafjJl6PxXcbFZYC
         WtpYAWbETurfpQdlqbS1Nbb9u3x0E9bP/szjZLzKSwS7MKdd9OHueckvUsZUjCxyC9jr
         XYs8j0im5nCaZnABLyqK/bKv4VgKw9iaWCvnmh2LsH/4TtQQSb3rs5Q1SGP2joC8+Bbw
         F5Rw==
X-Gm-Message-State: ACgBeo3Kqt5wk/ApYftbahc/tSUNk2KA7e0i5ZrwgSFnZAgAMLlD9Kqe
        5xTKh29nFYkhRVa29lkooAV7wzZKRA==
X-Google-Smtp-Source: AA6agR7dXbMe2QWC6NUqnUS2IDe3BcZnRXK37GUPMMJMhxQYn1ivPx7YVvo/EvE/LSCwIqKikSxMB896Ow==
X-Received: from adelg-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:d1f])
 (user=adelg job=sendgmr) by 2002:a0d:f9c1:0:b0:33b:65f4:9506 with SMTP id
 j184-20020a0df9c1000000b0033b65f49506mr13422629ywf.227.1661289604176; Tue, 23
 Aug 2022 14:20:04 -0700 (PDT)
Date:   Tue, 23 Aug 2022 21:19:58 +0000
Message-Id: <20220823211958.2519055-1-adelg@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] selftests: Add a taint selftest
From:   Andrew Delgadilo <adelg@google.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        dylanbhatch@google.com, sashalevin@google.com, gthelen@google.com,
        adelg@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Andrew Delgadillo <adelg@google.com>

When testing a kernel, one of the earliest signals one can get is if a
kernel has become tainted. For example, an organization might be
interested in mass testing commits on their hardware. An obvious first
step would be to make sure every commit boots, and a next step would be
to make sure there are no warnings/crashes/lockups, hence the utility of
a taint test.

Signed-off-by: Andrew Delgadillo <adelg@google.com>
---
 tools/testing/selftests/core/Makefile |  1 +
 tools/testing/selftests/core/taint.sh | 28 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100755 tools/testing/selftests/core/taint.sh

diff --git a/tools/testing/selftests/core/Makefile b/tools/testing/selftests/core/Makefile
index f6f2d6f473c6a..695bdbfb02f90 100644
--- a/tools/testing/selftests/core/Makefile
+++ b/tools/testing/selftests/core/Makefile
@@ -2,6 +2,7 @@
 CFLAGS += -g -I../../../../usr/include/
 
 TEST_GEN_PROGS := close_range_test
+TEST_PROGS := taint.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/core/taint.sh b/tools/testing/selftests/core/taint.sh
new file mode 100755
index 0000000000000..661c2cb8cd9bf
--- /dev/null
+++ b/tools/testing/selftests/core/taint.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+set -oue pipefail
+
+# By default, we only want to check if our system has:
+# - seen an oops or bug
+# - a warning occurred
+# - a lockup occurred
+# The bit values for these, and more, can be found at
+# Documentation/admin-guide/tainted-kernels.html
+# This value can be overridden by passing a mask as the
+# first positional argument.
+taint_bitmask=$(( 128 + 512 + 16384 ))
+
+# If we have a positional argument, then override our
+# default bitmask.
+if [[ -n "${1-}" ]]; then
+	taint_bitmask=$1
+fi
+
+taint_bits=$(cat /proc/sys/kernel/tainted)
+
+result=$(( taint_bitmask & taint_bits ))
+if [[ "$result" -ne 0 ]]; then
+	exit 1
+fi
+
+exit 0
-- 
2.37.1.595.g718a3a8f04-goog

