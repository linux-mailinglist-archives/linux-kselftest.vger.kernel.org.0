Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3219A7CE044
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 16:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjJROlK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 10:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjJROlJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 10:41:09 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4679112;
        Wed, 18 Oct 2023 07:41:04 -0700 (PDT)
Received: from pwmachine.numericable.fr (unknown [188.24.154.80])
        by linux.microsoft.com (Postfix) with ESMTPSA id E6C8E20B74C2;
        Wed, 18 Oct 2023 07:41:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E6C8E20B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697640064;
        bh=xfU7t1LgNcdblzWvppUIKK8lYqVIT5V5QuCHhVdi4XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jj8G1UuN9Bk/jt7qcdNl+3JbxLcchuZl5ENkdpTuNUHmsmpsB+5UyK3Da+JmSQxRE
         iByd2j7wE4UOQvR9Pj58rqHZZb03r+jez6TUt9GqPMe+z43DeK3+J5EEri0uGVFWcw
         IO4XORpsoyWdS8ndO6+MKMW5RVrWhs8Z3mrBTyWo=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v5 2/2] selftests/ftrace: Add new test case which checks non unique symbol
Date:   Wed, 18 Oct 2023 17:40:30 +0300
Message-Id: <20231018144030.86885-3-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018144030.86885-1-flaniel@linux.microsoft.com>
References: <20231018144030.86885-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If name_show() is non unique, this test will try to install a kprobe on this
function which should fail returning EADDRNOTAVAIL.
On kernel where name_show() is not unique, this test is skipped.

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 .../ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc  | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
new file mode 100644
index 000000000000..bc9514428dba
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test failure of registering kprobe on non unique symbol
+# requires: kprobe_events
+
+SYMBOL='name_show'
+
+# We skip this test on kernel where SYMBOL is unique or does not exist.
+if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}" /proc/kallsyms)" -le '1' ]; then
+	exit_unsupported
+fi
+
+! echo "p:test_non_unique ${SYMBOL}" > kprobe_events
--
2.34.1

