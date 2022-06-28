Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30F55E7CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 18:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347525AbiF1O4j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jun 2022 10:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347522AbiF1O4i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jun 2022 10:56:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A20331904;
        Tue, 28 Jun 2022 07:56:37 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r66so12465181pgr.2;
        Tue, 28 Jun 2022 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qd9n1b+aaHwGYwpaofHd32mHepvmEuTUbjkVHr6tEU0=;
        b=cpJlNn9h4SVQv7Vwgzv4T2CUsc40ee/3Kd6cbpyqTOOAq/0xHNOsGHcKjZC/hOAaJZ
         dZQ9xdl1eRz6/gFhaHQyJmJAuVURTSuSd+IaE4iSnyipGOXxgyXeu9sn8Ggn85K+CORU
         PfEy/CL4+JfL8wLVHfZjHylcNbYhdd7vDGV3JrJsg3v0fSZssHBHKhU4Qt0R7U0QRXP5
         TqCycyJ3Y/RUx2V7vo7ewq6B1AI8ciJEHupGh1oLFNEfsxAv1rCN042WaxoexHz8dmBd
         JqYJ25dQT8zSdmia98JhpbPHogcxM+Nzl/Y+RTA9ix5z6K9TYI5GR5Uy2HF5l69hm+UH
         9OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qd9n1b+aaHwGYwpaofHd32mHepvmEuTUbjkVHr6tEU0=;
        b=fn/HAHw7kR+OUo7GLxyLLSIMZPHFxDXvBwvkCaEvy5DbFRoNbSaHHIG01iEgV8fCyk
         nUDAUkInmwbbKYehrUZlkQLCWLcOIsiXlL329hiMsWIKVONtHYNpX/mE31+oV2ci6kq7
         3iwqVz1V/J9JDU7JDF8wvNcQm9ETOHLeF+Os2XDl2Sa9wJ7kEoN1Js4FZdpWMuGGi7a5
         MTgV+t3jAPvg9N+sQmDMQ6Jguepk0rC5VW8VHnaY1LDRUvwMvgYb+gCNTS96x5olfegh
         6JoXBViUTVV910I4UrCpfspT5n25OfIEjOQPrPBXKKa9Z7JZ97qMeJX83GdRG2XYfgTb
         8xuw==
X-Gm-Message-State: AJIora8OAwARJfU5abxauqQ+yMeLREnSdSUdLzxdl4gy99Tgdz3aM7tl
        Ctr2PtymBpwXqqt9GJRfvUza98Gn41APTA==
X-Google-Smtp-Source: AGRyM1syfxnneSSKUGWTiyCgnI3fHFAnFyUtdVxacOOtS88eLqXzK17xn4/6VbXtwAglWB0MZa9PvA==
X-Received: by 2002:a05:6a00:21c2:b0:4fa:914c:2c2b with SMTP id t2-20020a056a0021c200b004fa914c2c2bmr4013657pfj.56.1656428196956;
        Tue, 28 Jun 2022 07:56:36 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b0016909678e2csm9502549ple.292.2022.06.28.07.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:56:36 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn,
        Jeff Xie <xiehuan09@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v14 3/4] selftests/ftrace: Add testcases for objtrace
Date:   Tue, 28 Jun 2022 22:55:51 +0800
Message-Id: <20220628145552.349839-4-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628145552.349839-1-xiehuan09@gmail.com>
References: <20220628145552.349839-1-xiehuan09@gmail.com>
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

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
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

