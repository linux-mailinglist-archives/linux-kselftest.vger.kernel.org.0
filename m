Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360357D0D8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 12:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376967AbjJTKnY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 06:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376699AbjJTKnX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 06:43:23 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F82EA4;
        Fri, 20 Oct 2023 03:43:22 -0700 (PDT)
Received: from pwmachine.numericable.fr (unknown [188.24.154.80])
        by linux.microsoft.com (Postfix) with ESMTPSA id CB9AA20B74C0;
        Fri, 20 Oct 2023 03:43:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB9AA20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697798601;
        bh=jHEMFSWvEcx1czRBXUE2OS96KE3ALvaIroFuMgx4g8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4ZwyRGDZ8VV6xRFRRI5YT2sOs4vbJ9C1Ls7T6m8Ll4k+alQa91Ymp65cGpTEHlvM
         fivLgH/sEdRBx51wFJ5cBYSAa87N3p4rUHYZl3JyELXjwSm+WgCsYP86XHT7wto0Fe
         1f9HbJFCI1NfES2mnL2pq6X2moTAjGc68KWZk4qQ=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 2/2] selftests/ftrace: Add new test case which checks non unique symbol
Date:   Fri, 20 Oct 2023 13:42:50 +0300
Message-Id: <20231020104250.9537-3-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020104250.9537-1-flaniel@linux.microsoft.com>
References: <20231020104250.9537-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If name_show() is non unique, this test will try to install a kprobe on this
function which should fail returning EADDRNOTAVAIL.
On kernel where name_show() is not unique, this test is skipped.

Cc: stable@vger.kernel.org
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

