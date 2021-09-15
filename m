Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F2C40CD8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 21:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhIOT4t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 15:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhIOT4t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 15:56:49 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F74C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 12:55:30 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id k9-20020a05620a138900b003d59b580010so7125477qki.18
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=PYnDsf6Z8HAFankjEIQtAqVz+3xCBBR84fY+jWAUM7E=;
        b=BoI+/9QhGavjQDVL7msVbCCq3P+hCXFgyieI73l2GEOM/6dn97yZdEmwDpxb4FxCiz
         Y4TBchYMeTsl2Y8jJXSqT34mYPaSNvVH80u+xmhofH8yu/fU5/lGrWqHCa9vpWrv2iJO
         PUgpylEz9G+8OW4kioo6cNhi+P8wMyCjGqvaUeOTAUkgou3nx/2hOu9sHmWp2asBWSG+
         lajTgpvxg6C9r12yzmmgnTl8GKjYBryQ4zbs22Bfc8icTypF+mCcRylwY536IB61rVrk
         VvdZs8MlhJkbaSopHwYYMaafTunLjFVIHgnnH0UBwvZo8crluBYwg+PDxYVhsoOB8O6W
         Z+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=PYnDsf6Z8HAFankjEIQtAqVz+3xCBBR84fY+jWAUM7E=;
        b=c7vLtEW2YAAEH7KaxFBgJYVUambsh/ktO8BGvs7A7g38+Bv0gHHaazh9L4qoRyv3/W
         +kvKKpPymeAUjijN8+0qhfdRXZ0pBT+BxL6+pjfHzuS7mxj1/EId31NTqPZaUrf0EkhC
         Z8fp79j2TWevkOMJgPy2qNY/wufx706r8xNThaZ9omK8s+wpg6rcyKdW4MUvKwfDtyxm
         JoqroW5x7amy6ill32clB3R994JNXAycnMztlD3ihnDC+tYN1VRIBlvKMnCY/Iib6DqH
         WqSxSu4fLWscA7w9rs8TI7lmZk4NHgptxmG0W49a8GBG1yUBwTOHcfZ2DN/qang5Agb7
         bBfA==
X-Gm-Message-State: AOAM531ZEpxonCXEn8zcQx3jDoEurJnaNS8c8GG3msGILzsnm4gY+a97
        9DvUMil5HOFt9+bZE86kj/oXBo9/eD9GLYh2Ig==
X-Google-Smtp-Source: ABdhPJxAykTg7RcIHWD9bU0VJvH1BS0A14YALfmkdBBBpqo/ub0jMF31CR0E4xp6QQbm6e5tx2P1UfmTwPW0QxKNoQ==
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:522c:: with SMTP id
 r12mr1556950qvq.17.1631735729298; Wed, 15 Sep 2021 12:55:29 -0700 (PDT)
Date:   Wed, 15 Sep 2021 19:52:48 +0000
In-Reply-To: <20210915195306.612966-1-kaleshsingh@google.com>
Message-Id: <20210915195306.612966-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20210915195306.612966-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 4/5] tracing/selftests: Add tests for hist trigger expression parsing
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tests for the parsing of hist trigger expressions; and to
validate expression evaluation.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 .../testing/selftests/ftrace/test.d/functions |  4 +-
 .../trigger/trigger-hist-expressions.tc       | 73 +++++++++++++++++++
 2 files changed, 75 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 000fd05e84b1..1855a63559ad 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -16,13 +16,13 @@ reset_tracer() { # reset the current tracer
 
 reset_trigger_file() {
     # remove action triggers first
-    grep -H ':on[^:]*(' $@ |
+    grep -H ':on[^:]*(' $@ | tac |
     while read line; do
         cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
 	file=`echo $line | cut -f1 -d:`
 	echo "!$cmd" >> $file
     done
-    grep -Hv ^# $@ |
+    grep -Hv ^# $@ | tac |
     while read line; do
         cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
 	file=`echo $line | cut -f1 -d:`
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
new file mode 100644
index 000000000000..0e2361cd334f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
@@ -0,0 +1,73 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test histogram expression parsing
+# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist error_log
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
+    echo "Test hist trigger expressions - $1"
+    ftrace_errlog_check 'hist:sched:sched_process_fork' "$2" 'events/sched/sched_process_fork/trigger'
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
+# err pos is where the last detected sub-express was detected
+# this can vary depending on how the expression tree generated
+check_error "Too many subexpressions" 'hist:keys=common_pid:x=32+^10*3/20-4'
+check_error "Too many subexpressions" 'hist:keys=common_pid:x=^1+2+3+4+5'
+
+check_error "Unary minus not supported in subexpression" 'hist:keys=common_pid:x=-(^1)+2'
+
+check_error "'.sym-offset' modifier not supported in subexpression" \
+    'hist:keys=common_pid:x=1+common_pid^.sym-offset'
+check_error "'.sym-offset' modifier not supported in subexpression" \
+    'hist:keys=common_pid:x=common_pid^.sym-offset-2'
+check_error "'.sym-offset' modifier not supported in subexpression" \
+    'hist:keys=common_pid:x=4/common_pid^.sym-offset*3'
+
+exit 0
-- 
2.33.0.309.g3052b89438-goog

