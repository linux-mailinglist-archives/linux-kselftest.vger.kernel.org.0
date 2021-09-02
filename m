Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4643FEAF3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 11:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244800AbhIBJJw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 05:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244578AbhIBJJv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 05:09:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDE3C061575
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Sep 2021 02:08:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z4so1728267wrr.6
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Sep 2021 02:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWTPpneMqSrnaTUXRE0EMYARU3bbZryaUSfXNPXDso0=;
        b=QSADQ1DM4wvesWoVzLRlasAzQUNPaY0/OW9czId+o7eyf9RN0GONbAMG6MlsN2lOu7
         4FfINahpo0XvAtOmWgJRhHYPAzjtVKskvcICLGqw1qA4GvBC2XS3rM+1P+ItUGQqOcXf
         up1lXSO20e8pE9+tcBr97pmWx1dyzjM50j6Wfl9ZuySkkV/VPZkJyTpRXWfchtkmIxmu
         qr89jRpRrn9UbvzuZJC9hLhPTdAGbBjfQ69GFdz5JC5NdYbt0B43xD0M+U5QqNaORhth
         WTbnVb6LTc2RnQgRfvbrSrkdWsraAmQkYBL9aV5epu92cV67+cDFBOo8VZkQpEycgMGw
         zrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWTPpneMqSrnaTUXRE0EMYARU3bbZryaUSfXNPXDso0=;
        b=exY61bqGtYFtKTP8PtRrLvjVVYRU5MQfYSGcGV9Z+k1mgEEQaReLl0+BxFZu3WBc5O
         IT0pLBOuV/L7J6aPci2sy/0rtFpX7IK6+Nw3wG38F/5EjS1MdIM/gFSpQzcxyuIvuyYq
         9whKVBoN/hwBAZG78reNEroFStW4oSas/3ACb6A9xJveX5r6dwmdkQjDNzgs06KTq9aW
         PCceoF1wQh+WEWH50toWnxu+uvn/YWazW+kJLM5Svml1wozfhVR+iq7aoUME8wGRFytO
         zHnsgxYSVRND0HU6H1GVsZ1Kq9+4puRixuUMV84jyMSLMYH5IFb2Le8WQ5EVo7xXn6mu
         1JKg==
X-Gm-Message-State: AOAM53133fhjgX8jCTB6dGkfr2BA7NTqrE930J6vL0wAliIKTbE4B4lZ
        vrHKsQrDIIFZx8cXYYewcKLhBA==
X-Google-Smtp-Source: ABdhPJzS97LWxRcdFC0/4Xbcrwypbqkdsdz1TuXoRfZpJXz6xMazkZ1W8M+c3qLTcqrcp++95ckOrw==
X-Received: by 2002:a05:6000:1627:: with SMTP id v7mr2481698wrb.54.1630573732230;
        Thu, 02 Sep 2021 02:08:52 -0700 (PDT)
Received: from localhost.localdomain (19.11.114.78.rev.sfr.net. [78.114.11.19])
        by smtp.gmail.com with ESMTPSA id x18sm1279657wmj.36.2021.09.02.02.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 02:08:51 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, dxu@dxuuu.xyz,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix build of task_pt_regs tests for arm64
Date:   Thu,  2 Sep 2021 11:09:26 +0200
Message-Id: <20210902090925.2010528-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

struct pt_regs is not exported to userspace on all archs. arm64 and s390
export "user_pt_regs" instead, which causes build failure at the moment:

  progs/test_task_pt_regs.c:8:16: error: variable has incomplete type 'struct pt_regs'
  struct pt_regs current_regs = {};

Use the multi-arch macros defined by tools/lib/bpf/bpf_tracing.h to copy
the pt_regs into a locally-defined struct.

Copying the user_pt_regs struct on arm64 wouldn't work because the
struct is too large and the compiler complains about using too much
stack.

Fixes: 576d47bb1a92 ("bpf: selftests: Add bpf_task_pt_regs() selftest")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../selftests/bpf/bpf_pt_regs_helpers.h       | 30 +++++++++++++++++++
 .../selftests/bpf/prog_tests/task_pt_regs.c   |  1 +
 .../selftests/bpf/progs/test_task_pt_regs.c   | 10 ++++---
 3 files changed, 37 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_pt_regs_helpers.h

diff --git a/tools/testing/selftests/bpf/bpf_pt_regs_helpers.h b/tools/testing/selftests/bpf/bpf_pt_regs_helpers.h
new file mode 100644
index 000000000000..7531f4824ead
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_pt_regs_helpers.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BPF_PT_REGS_HELPERS
+#define __BPF_PT_REGS_HELPERS
+
+#include <bpf/bpf_tracing.h>
+
+struct bpf_pt_regs {
+	unsigned long long parm[5];
+	unsigned long long ret;
+	unsigned long long fp;
+	unsigned long long rc;
+	unsigned long long sp;
+	unsigned long long ip;
+};
+
+static inline void bpf_copy_pt_regs(struct bpf_pt_regs *dest, struct pt_regs *src)
+{
+	dest->parm[0]	= PT_REGS_PARM1(src);
+	dest->parm[1]	= PT_REGS_PARM2(src);
+	dest->parm[2]	= PT_REGS_PARM3(src);
+	dest->parm[3]	= PT_REGS_PARM4(src);
+	dest->parm[4]	= PT_REGS_PARM5(src);
+	dest->ret	= PT_REGS_RET(src);
+	dest->fp	= PT_REGS_FP(src);
+	dest->rc	= PT_REGS_RC(src);
+	dest->sp	= PT_REGS_SP(src);
+	dest->ip	= PT_REGS_IP(src);
+}
+
+#endif /* __BPF_PT_REGS_HELPERS */
diff --git a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
index 53f0e0fa1a53..196453b75937 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
@@ -2,6 +2,7 @@
 #define _GNU_SOURCE
 #include <test_progs.h>
 #include <linux/ptrace.h>
+#include "bpf_pt_regs_helpers.h"
 #include "test_task_pt_regs.skel.h"
 
 void test_task_pt_regs(void)
diff --git a/tools/testing/selftests/bpf/progs/test_task_pt_regs.c b/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
index 6c059f1cfa1b..348da3509093 100644
--- a/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
+++ b/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
@@ -5,8 +5,10 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-struct pt_regs current_regs = {};
-struct pt_regs ctx_regs = {};
+#include "bpf_pt_regs_helpers.h"
+
+struct bpf_pt_regs current_regs = {};
+struct bpf_pt_regs ctx_regs = {};
 int uprobe_res = 0;
 
 SEC("uprobe/trigger_func")
@@ -17,8 +19,8 @@ int handle_uprobe(struct pt_regs *ctx)
 
 	current = bpf_get_current_task_btf();
 	regs = (struct pt_regs *) bpf_task_pt_regs(current);
-	__builtin_memcpy(&current_regs, regs, sizeof(*regs));
-	__builtin_memcpy(&ctx_regs, ctx, sizeof(*ctx));
+	bpf_copy_pt_regs(&current_regs, regs);
+	bpf_copy_pt_regs(&ctx_regs, ctx);
 
 	/* Prove that uprobe was run */
 	uprobe_res = 1;
-- 
2.33.0

