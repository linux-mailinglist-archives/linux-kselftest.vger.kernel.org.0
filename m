Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8D843D369
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 23:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbhJ0VCx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 17:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbhJ0VCx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 17:02:53 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF89C061570
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 14:00:27 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id w13-20020a63934d000000b002a2935891daso2136491pgm.15
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 14:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=SdbyZiNQ4LiMxmB2YhYdQuIseQ920FQ9o4MrrCvG7tM=;
        b=dHaDKVwDNSZBeGyeNhMjTQIOFLsMxJ8Nd5psJlS/RRb39poaQwp3vTOEMJghwBPmwZ
         YrU7vuea9ypx0AdSkZsH0z3FKZadGC7VEqoi5ltjkC74PwR8a0tZphDp/ehkh3PQwrQ6
         9bO1NDO7GTiZyH/vx+qu8h9AB7Tyx2+dMTvm6ozruam1hJ1hOiw4L98B0t9+vopLBHA9
         Yr1R5PLstW6gSlsg0eykjELz/DeivF720v1CFY6AAeCYX5i+leDARtf4jvcoKTJry69K
         NjheHNzPe88PP15hppLg2gs7BNkTlSsXNXZs0y/OVFLkcl550VG03iV42OZTISA1+pFM
         2xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=SdbyZiNQ4LiMxmB2YhYdQuIseQ920FQ9o4MrrCvG7tM=;
        b=MxliLbqxl6X+vYU6oa6lE5JjEuYv9NmTM4vDMOuu1VuKk0Y4oZyTcNHVN0PvhJkx5Y
         DJ7iKZP0SVojy3OkGodp+BqmyOYsZlVOjkgDypRJMxZLENDNaM+690jJofvZE5HOtTC5
         wLrd2wieidmhX4p7Yx5n9I4cqcVTmRDXotZZOpcXF3u3E6BqGe7YWoOewDx5l0j4ln2w
         Q//RJ+3GsJs197DyXA3L7t2KHlOf9UM0Pw9YJ6JG+sEXVcgb3lnodm12xovp3nD5GFjl
         0Bwr0Kv1jm7u9J0ZcuTu6hkRd6mRzNmgCsVeIv90iHYlIag1Q1o/hrD+GyMVamyRFHJW
         VeUA==
X-Gm-Message-State: AOAM530odIgsxEFCbKqFfcj8zJsuGlCKrFkmKnGaAAX1RyCpt5vpfkXR
        z3gEawva+zLQPRSLOc5fgs2g9x6tRK0XsZkjIw==
X-Google-Smtp-Source: ABdhPJzk+4wCnwzsBsYgw3jRdzH6WJEm2BS0UpBvlX8mr693q5unlLTnR17AAmB4YJ5xCOfVMUDKQPMO2AVZiCNLiA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:ac51:b6be:9b51:3a7c])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6a00:8d0:b0:44c:26e6:1c13 with
 SMTP id s16-20020a056a0008d000b0044c26e61c13mr60235pfu.28.1635368426770; Wed,
 27 Oct 2021 14:00:26 -0700 (PDT)
Date:   Wed, 27 Oct 2021 13:59:10 -0700
In-Reply-To: <20211027205919.1648553-1-kaleshsingh@google.com>
Message-Id: <20211027205919.1648553-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211027205919.1648553-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 3/3] tracing/selftests: Add tests for hist trigger
 expression parsing
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tests for the parsing of hist trigger expressions; and to
validate expression evaluation.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
Changes in v5:
  - Add README pattern to requires tag, per Masami

Changes in v3:
  - Remove .sym-offset error check tests

Changes in v2:
  - Add Namhyung's Reviewed-by
  - Update comment to clarify err_pos in "Too many subexpressions" test

 .../trigger/trigger-hist-expressions.tc       | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
new file mode 100644
index 000000000000..9690f9f809e7
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
@@ -0,0 +1,72 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test histogram expression parsing
+# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist error_log "<var1>=<field|var_ref|numeric_literal>":README
+
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+get_hist_var() { #var_name hist_path
+    hist_output=`grep -m1 "$1: " $2`
+    hitcount=`echo $hist_output | awk '{ for (i=1; i<=NF; ++i) { if ($i ~ "hitcount:") print $(i+1)} }'`
+    var_sum=`echo $hist_output | awk '{ for (i=1; i<=NF; ++i) { if ($i ~ "'$1':") print $(i+1)} }'`
+    var_val=$(( var_sum / hitcount ))
+    echo $var_val
+}
+
+test_hist_expr() { # test_name expression expected_val
+    reset_trigger
+
+    echo "Test hist trigger expressions - $1"
+
+    echo "hist:keys=common_pid:x=$2" > events/sched/sched_process_fork/trigger
+    echo 'hist:keys=common_pid:vals=$x' >> events/sched/sched_process_fork/trigger
+    for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
+
+    actual=`get_hist_var x events/sched/sched_process_fork/hist`
+
+    if [ $actual != $3 ]; then
+        fail "Failed hist trigger expression evaluation: Expression: $2 Expected: $3, Actual: $actual"
+    fi
+
+    reset_trigger
+}
+
+check_error() { # test_name command-with-error-pos-by-^
+    reset_trigger
+
+    echo "Test hist trigger expressions - $1"
+    ftrace_errlog_check 'hist:sched:sched_process_fork' "$2" 'events/sched/sched_process_fork/trigger'
+
+    reset_trigger
+}
+
+test_hist_expr "Variable assignment" "123" "123"
+
+test_hist_expr "Subtraction not associative" "16-8-4-2" "2"
+
+test_hist_expr "Division not associative" "64/8/4/2" "1"
+
+test_hist_expr "Same precedence operators (+,-) evaluated left to right" "16-8+4+2" "14"
+
+test_hist_expr "Same precedence operators (*,/) evaluated left to right" "4*3/2*2" "12"
+
+test_hist_expr "Multiplication evaluated before addition/subtraction" "4+3*2-2" "8"
+
+test_hist_expr "Division evaluated before addition/subtraction" "4+6/2-2" "5"
+
+# Division by zero returns -1
+test_hist_expr "Handles division by zero" "3/0" "-1"
+
+# err pos for "too many subexpressions" is dependent on where
+# the last subexpression was detected. This can vary depending
+# on how the expression tree was generated.
+check_error "Too many subexpressions" 'hist:keys=common_pid:x=32+^10*3/20-4'
+check_error "Too many subexpressions" 'hist:keys=common_pid:x=^1+2+3+4+5'
+
+check_error "Unary minus not supported in subexpression" 'hist:keys=common_pid:x=-(^1)+2'
+
+exit 0
-- 
2.33.0.1079.g6e70778dc9-goog

