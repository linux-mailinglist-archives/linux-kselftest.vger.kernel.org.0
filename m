Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19A47CD21E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 04:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjJRCFg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 22:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJRCFf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 22:05:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DBDFA;
        Tue, 17 Oct 2023 19:05:28 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9DdG4fWszrTWX;
        Wed, 18 Oct 2023 10:02:42 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 10:05:20 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <skhan@linuxfoundation.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <rostedt@goodmis.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <shuah@kernel.org>,
        <mhiramat@kernel.org>
Subject: [RESEND PATCH 2/2] selftests/ftrace: Add riscv support for kprobe arg tests
Date:   Wed, 18 Oct 2023 10:08:58 +0800
Message-ID: <20231018020858.1304218-3-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018020858.1304218-1-liaoyu15@huawei.com>
References: <20231018020858.1304218-1-liaoyu15@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is the riscv variant of commit 9855c4626c67 ("selftests/ftrace:
Add ppc support for kprobe args tests").

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc        | 3 +++
 .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc      | 3 +++
 .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc      | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
index 2b04603a3b40..21db6b720754 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
@@ -31,6 +31,9 @@ mips*)
 loongarch*)
   ARG1=%r4
 ;;
+riscv*)
+  ARG1=%a0
+;;
 *)
   echo "Please implement other architecture here"
   exit_untested
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index a202b2ea4baf..4e086f871cee 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -31,6 +31,9 @@ mips*)
 loongarch*)
   ARG1=%r4
 ;;
+riscv*)
+  ARG1=%a0
+;;
 *)
   echo "Please implement other architecture here"
   exit_untested
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
index 1df61e13a812..8f1292ad80ff 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -44,6 +44,10 @@ loongarch*)
   GOODREG=%r4
   BADREG=%r12
 ;;
+riscv*)
+  GOODREG=%a0
+  BADREG=%a8
+;;
 *)
   echo "Please implement other architecture here"
   exit_untested
-- 
2.25.1

