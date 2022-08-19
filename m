Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E507599389
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 05:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245745AbiHSD2L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 23:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245371AbiHSD1v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 23:27:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C0ADF66A;
        Thu, 18 Aug 2022 20:27:46 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w138so629263pfc.10;
        Thu, 18 Aug 2022 20:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OQCT0FO0WVslxJIMcjKZNm6Rby/uy7EpPrL90KN+hSQ=;
        b=CybQyPbkYCvQGlVB10P7RO0IRUQclIAwSUQVokXbp3WSi/ByrhPLpeNl1Yvxl5IYxW
         uNyKR+ABnQQPt5YBcVjgEpi3gW3hZEUnEIlWpyhKOwCTBnPmLPZ9kcQzss6/1peQyg9r
         aKk/23vDZA4D59XJhClpQsFmg4IonywrIYgrYfHY7dUnUVD3wjXeZjKksq7CdQ/kK4Yh
         dtTSNw8AQc2zgVNBaH796nVTZH2eXpe53ofd+HGkiqQGEFTxnxQYzpn3aIPzVIWN/ojF
         1NmRgrYo/DQFeQb6YNvHt/19CVF7UlEpV1JCgV3+eZOFfbrUwNLvPL75nxu40wDr6pZb
         f7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OQCT0FO0WVslxJIMcjKZNm6Rby/uy7EpPrL90KN+hSQ=;
        b=TYBrKpN2j1NrkdoEiiikn0zDAS0NqiyAhcB3nHsKKL7urCBmtwb6Kmjq8MxnjGLl5V
         gM6ezaY/pyT6oqJfBxadF6keLPqiDKru36/dKZ978SAi42sl13NezdjztyQtW2Pvw25K
         q6wa9GkfCDjJDPd9oSLJNr10FFDpl79eKHsii9bZK069sfdQfiqbRRQ8QmU4Zq0q9eiW
         OSCOvtnwmuFNDAuaV65zsQ1FR2us3y0eIW3y+E2wktqosjXdiqnQevizpJmU33pOuSBU
         MJlGE0s0FUPzKbdxtsHCGWOs9aUVGFUqPLKT2NuecRoXGDUiAEJwAc/LrxhhKVb466vP
         g82g==
X-Gm-Message-State: ACgBeo1OiGv38MZA82FdYCWeYQkQkGTESkLvOECFONhOFI7AqfjtqJar
        NhxFfkq7zc0nYJKmMbcI6m8=
X-Google-Smtp-Source: AA6agR7LRcgC/iSIanDKM5S+6f4T2CP9rhP/BUTZ6seZWD+lpVozXxT7y+5Q/+w6Ubuox5rGnWA2fQ==
X-Received: by 2002:a65:6854:0:b0:41c:feab:e17c with SMTP id q20-20020a656854000000b0041cfeabe17cmr4793670pgt.256.1660879666345;
        Thu, 18 Aug 2022 20:27:46 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902a3c500b0016befc83c6bsm2101032plb.165.2022.08.18.20.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 20:27:46 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn,
        Jeff Xie <xiehuan09@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v15 3/4] selftests/ftrace: Add testcases for objtrace
Date:   Fri, 19 Aug 2022 11:27:05 +0800
Message-Id: <20220819032706.695212-4-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819032706.695212-1-xiehuan09@gmail.com>
References: <20220819032706.695212-1-xiehuan09@gmail.com>
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
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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

