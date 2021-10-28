Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE07F43E929
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 21:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhJ1UBB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 16:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhJ1UBB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 16:01:01 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83FEC061745
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 12:58:33 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id jz9-20020a17090b14c900b001a6198de66fso842911pjb.4
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 12:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=BAtqkafADpwzULg+aeC1UZQn1dNACnm78j2C0LgZ8Iw=;
        b=A5Zf/AOSgFV9fSmGXh19RoCb4QnRV+uAz/hj6kwDDgC3a5GZ91tpiAJN2+W8aKGRmw
         p395l/Xctlu5tsTf1MRv825lf4mMGWnoRqBomrGvqIjx+OR5x8bqrTAKn5ppn2AnCqSI
         68I1Km2zkPzg6J44JkN5Yreom5YJ8E/jwpnRtslQ+3VR2QsJAjW8N+SEO02xp6yS/ycK
         LLUxveQZoRQi2/jsSHDmupmrh6uRvg1vqiN5CMI/PrFpZRHdapsnQlfPJiOwv1Yvl2Ab
         LwRgddZlwHH9jjhTHb5aJaXluoaLLYThpYcBoE7Zi5y6I31aBSTNpSnwCUPoU4GU76j6
         EY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=BAtqkafADpwzULg+aeC1UZQn1dNACnm78j2C0LgZ8Iw=;
        b=a4XE3Xipp9rbYF+zUqBfirykqG2cCf2TtTh+PSYjg6QIKBfJdULtORpu71zqJJgqD6
         LZIOZSqATpt+xpQ5RG+116uGH/Lw+9P7wEGnjzLmSob8woq/6OVLzk2l9t++ln1gA83u
         qNKnx8QGbkqz5Z6qR9+GHI3j10GOkzjF23fWrUPG01cE6cv+nlw0tpEK2ZQ8KPgZuZGj
         6LLkUL+wjdlGnSmaABstbhuUOdatFWeD7X9JVcCRPupuWKrv6V8G1E5398+ngaEheE2D
         Ra54n9TArW6WCp0nNAVrpfPQ+YG/Ie7BSELKAs4aEVLkrFXD1Id4emN+4G9Ui8d/RFt+
         PoeA==
X-Gm-Message-State: AOAM533pI88X2iJWzJ8vh0jWIyIAIFZhQdRB3DBIf8zX/1whdxk7G/IG
        6yxnE/CAZ8qg5cOUKGydON28fvqGSctxjmz1lQ==
X-Google-Smtp-Source: ABdhPJzPuc1W8F6odW8JRqiM+d0qiJb02/NUR1m+kdFBA1gJ2l+vRPMlZ8+oaovTUnuembNkG6jSS/0IThRn7kqWFQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:9b57:752f:2f0a:3a13])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6a00:16d2:b029:300:200b:6572 with
 SMTP id l18-20020a056a0016d2b0290300200b6572mr6351628pfc.62.1635451113404;
 Thu, 28 Oct 2021 12:58:33 -0700 (PDT)
Date:   Thu, 28 Oct 2021 12:57:58 -0700
In-Reply-To: <20211028195805.2684854-1-kaleshsingh@google.com>
Message-Id: <20211028195805.2684854-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211028195805.2684854-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v6 2/2] tracing/selftests: Add tests for hist trigger
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
Changes in v6:
  - Read the expression result from the trigger file,
    instead of creating a histogram to print the value.

Changes in v5:
  - Add README pattern to requires tag, per Masami

Changes in v3:
  - Remove .sym-offset error check tests

Changes in v2:
  - Add Namhyung's Reviewed-by
  - Update comment to clarify err_pos in "Too many subexpressions" test


 .../trigger/trigger-hist-expressions.tc       | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
new file mode 100644
index 000000000000..33eb79589b32
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
@@ -0,0 +1,65 @@
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
+test_hist_expr() { # test_name expression expected_val
+    trigger="events/sched/sched_process_fork/trigger"
+
+    reset_trigger_file $trigger
+
+    echo "Test hist trigger expressions - $1"
+
+    echo "hist:keys=common_pid:x=$2" > $trigger
+
+    for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
+
+    x=`grep -o 'x=[[:digit:]]*' $trigger | awk -F= '{ print $2 }'`
+    actual=$(( x + 0 )) # To print negative numbers correctly
+
+    if [ $actual != $3 ]; then
+        fail "Failed hist trigger expression evaluation: Expression: $2 Expected: $3, Actual: $actual"
+    fi
+
+    reset_trigger_file $trigger
+}
+
+check_error() { # test_name command-with-error-pos-by-^
+    trigger="events/sched/sched_process_fork/trigger"
+
+    echo "Test hist trigger expressions - $1"
+    ftrace_errlog_check 'hist:sched:sched_process_fork' "$2" $trigger
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

