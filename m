Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D7477A4DF
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Aug 2023 05:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjHMDho (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Aug 2023 23:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHMDhn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Aug 2023 23:37:43 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B8510FD
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Aug 2023 20:37:45 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79093c0c68bso127336939f.0
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Aug 2023 20:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691897865; x=1692502665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtcqjFzhwuRZbHBWxqdoLTlD9EjBr/XxEKJhU3JgK1M=;
        b=TbwS2mSknEe09vKa3AsnGeLaGAIA3D0J/Su6rlHkPPn6kUlgotZk7wMKaHc9FybSRR
         t46YYPbXz1BfNTP1xKLoxCgoeKwHGPeM8d5QZzHifyFIN4qzS8ciApeJRXmwfA3oexTz
         TWt7B7S7RtpmxO45lIRzZSIBxucqpfdw0zeD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691897865; x=1692502665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtcqjFzhwuRZbHBWxqdoLTlD9EjBr/XxEKJhU3JgK1M=;
        b=JHHKCLedzHNLLmkPbwy3N4bKX2g8Px1SNoyBqFWqZa76BcDxAwIPT0AKJStuq3V7i7
         jT6Lld6ogtpucyeRWwoHgt0dlUUrIjIMLIsbhe5hMixVYrlXREHUlNL44IN3vvEJUZZw
         hQKKki5PrZM3Kg94MAziBS+QJ1Sndl1jpp/JEvouAY4Ks+7/HxJCXjg8GXoLcr/zKj8b
         OqPz+JWlsOp7lYeooES900T++zh4F1KHtNgVsXhrZUBERoxUvuHaEliQvq1JLfxlxLnE
         vwwaGZuSSqJHjIlOXAPAVcM0LTHxw2rSL4b8OMR5R5GQuUKF3wxCzJgtjLG5kVHEkOJt
         rN/g==
X-Gm-Message-State: AOJu0YzslO4EKcsDxvQcH98nPHkBFMq6Q0oWhf/PJ/QEsQ74ovlvo4d8
        CRDW4UQ8LvFZ8OccMZmEfs3fzw==
X-Google-Smtp-Source: AGHT+IH2gu3Bucb4GNzQK6gTtVqojpQAgMq26mLfou+abJe1boc/851+SvyYyMbTU+0lzyeVGlVzrg==
X-Received: by 2002:a05:6e02:1bee:b0:349:2d1d:e463 with SMTP id y14-20020a056e021bee00b003492d1de463mr10131258ilv.13.1691897865244;
        Sat, 12 Aug 2023 20:37:45 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id y8-20020a92c988000000b0034a92425cbcsm489635iln.84.2023.08.12.20.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 20:37:44 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joel <agnel.joel@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] rcutorture: Copy out ftrace into its own console file
Date:   Sun, 13 Aug 2023 03:37:36 +0000
Message-ID: <20230813033737.3731290-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Joel <agnel.joel@gmail.com>

Often times it is difficult to jump to the ftrace buffers and treat it
independently during debugging. Copy the contents of the buffers into
its own file.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../selftests/rcutorture/bin/functions.sh     | 24 +++++++++++++++++++
 .../selftests/rcutorture/bin/parse-console.sh |  7 ++++++
 2 files changed, 31 insertions(+)
 mode change 100644 => 100755 tools/testing/selftests/rcutorture/bin/functions.sh

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
old mode 100644
new mode 100755
index b8e2ea23cb3f..2ec4ab87a7f0
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -331,3 +331,27 @@ specify_qemu_net () {
 		echo $1 -net none
 	fi
 }
+
+# Extract the ftrace output from the console log output
+# The ftrace output looks in the logs looks like:
+# Dumping ftrace buffer:
+# ---------------------------------
+# [...]
+# ---------------------------------
+extract_ftrace_from_console() {
+        awk '
+        /Dumping ftrace buffer:/ {
+        capture = 1
+        next
+    }
+    /---------------------------------/ {
+        if(capture == 1) {
+            capture = 2
+            next
+        } else if(capture == 2) {
+            capture = 0
+        }
+    }
+    capture == 2
+    ' "$1";
+}
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 9ab0f6bc172c..e3d2f69ec0fb 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -182,3 +182,10 @@ if ! test -s $file.diags
 then
 	rm -f $file.diags
 fi
+
+# Call extract_ftrace_from_console function, if the output is empty,
+# don't create $file.ftrace. Otherwise output the results to $file.ftrace
+extract_ftrace_from_console $file > $file.ftrace
+if [ ! -s $file.ftrace ]; then
+	rm -f $file.ftrace
+fi
-- 
2.41.0.640.ga95def55d0-goog

