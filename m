Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193CD55AE4F
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jun 2022 05:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiFZC5E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 22:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiFZC5D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 22:57:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DCD13F32;
        Sat, 25 Jun 2022 19:57:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso8060997pjz.0;
        Sat, 25 Jun 2022 19:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dN5G1vAgM+iieaUadZcmGZDhYEB0h4tsZbu64ort+c=;
        b=o5t5YO0FJjS7eQ06MNQBt4EBZwG/pZfu3h0d7yLir9SjcB6MoBt5VeQr1HeBjV4+iA
         Fld5IYBDgtT8mUzJBttgV7YscsDL1WMpnBxxzUw5fJolRLeZJVF0KehOSrwmFbgD9Bgm
         IdrPiPg0KapTZCuXetpcq5yTZgeN0V/nis+ViNl1cQLtnalOg/hbtmErwharcRNnxG9X
         lYp/nFokUC69BIXqW0bk4TBGq9lL3i17heB/ZOAnG7g8bsqq+6hzkc7LeJU9Tu7ntiRO
         1k8fXM8Rn9BQwnGlMiuWj7txHaTKabVl9bPmJk05TkdjjYaNOw4G6lk+grim65Ii5ETC
         rLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dN5G1vAgM+iieaUadZcmGZDhYEB0h4tsZbu64ort+c=;
        b=L9yPbixCU3UVLGyVVTR9ag0Crk8YtX3OH5X7jN1rZhoPU4GZSzkD2WW7VtZUvHeOBy
         JJRiv6JbfuzJVpgc0d1ZVoYHFuvY9/j4FiRnJano5/faP/CHStXVlk9eOc4r6yNzH8tP
         lOx7Yc72wgk+lCdTo0yqxbMXsXVQrCRNiDjibrtmVPUHJT+A/xS8Zdtk980PDr+Y4AXh
         JMFe5K4XUlpv/65zVqpepGQ0xg6EjceZLjxlhlb3k0VRuzGd4tQsvjGC287x7JYFTnmE
         LPjz+0Vxof/Ng+D8gJbGjNd4n3vYVhjaL2mFx8k/I7kUaZis+nFurY8KxPkUIOPhdgU8
         hgcg==
X-Gm-Message-State: AJIora/bOsmYYqASquQ5b9Y/pKy2Y/IZoTW4FBm6M9KqWUzpTOyy8QGR
        WE0/29UAO+O1NHhgnz56H9LwpRFtPk3MUrCd
X-Google-Smtp-Source: AGRyM1uqtw12aljp7U4E54+bccQZ5Jso7UfBf5W90/F+JEs9rle9ZZpt3a78AsP0xYLozoVp6d1RKA==
X-Received: by 2002:a17:90b:17c1:b0:1ed:1b79:8c04 with SMTP id me1-20020a17090b17c100b001ed1b798c04mr13366152pjb.53.1656212221405;
        Sat, 25 Jun 2022 19:57:01 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id d15-20020a056a0024cf00b005258df7615bsm1607061pfv.0.2022.06.25.19.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 19:57:01 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
        chensong_2000@189.cn, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v13 3/4] selftests/ftrace: Add testcases for objtrace
Date:   Sun, 26 Jun 2022 10:56:03 +0800
Message-Id: <20220626025604.277413-4-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220626025604.277413-1-xiehuan09@gmail.com>
References: <20220626025604.277413-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a series of testcases to illustrate correct and incorrect usage of
objtrace trigger.

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/trigger/trigger-objtrace.tc | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
new file mode 100644
index 000000000000..d894442b6a30
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
@@ -0,0 +1,41 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test objtrace-trigger
+# requires: kprobe_events "objtrace":README
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+echo 'p bio_add_page arg1=$arg1 arg2=$arg2' > kprobe_events
+
+FEATURE=`grep objtrace events/kprobes/p_bio_add_page_0/trigger`
+if [ -z "$FEATURE" ]; then
+    echo "objtrace trigger is not supported"
+    exit_unsupported
+fi
+
+echo "Test objtrace trigger"
+echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > \
+	events/kprobes/p_bio_add_page_0/trigger
+if [ -z $? ]; then
+	fail "objtrace trigger syntax error"
+fi
+
+echo "Test objtrace semantic errors"
+
+# Being lack of objtrace command
+! echo 'objtrace:arg1,0x28:u32:1' > events/kprobes/p_bio_add_page_0/trigger
+# Bad parameter name
+! echo 'objtrace:add:argx:u32:1' > events/kprobes/p_bio_add_page_0/trigger
+# The parameter existed on event
+! echo 'objtrace:add:arg2:u32:1' > events/kprobes/p_bio_add_page_0/trigger
+
+echo "reset objtrace trigger"
+
+echo '!objtrace:add:arg1,0x28:u32' > \
+	events/kprobes/p_bio_add_page_0/trigger
+echo '-:p_bio_add_page_0' >> ./kprobe_events
+
+exit 0
-- 
2.25.1

