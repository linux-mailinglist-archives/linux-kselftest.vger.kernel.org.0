Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C736EA689
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjDUJGW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 05:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjDUJGO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 05:06:14 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FFD6EB6
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 02:05:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-246fa478d45so1713790a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 02:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682067947; x=1684659947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0gJQV+jBsuJN+dqapwDGx8wuqSDbN1mALWddpdSsEk=;
        b=S5Ivxp968YSA3NDLM8BeS1NCb2DfvXA3IuISPyCNzeNTePZMImiqO1QFMplQ3aXvDz
         /JvtVHFnfcDqRSLbbaCRYizZ6eVphwrfwkjJf7dk2xAGd6ln9qyu2KFaV5fIQGQLEGbh
         UFTjg240tmdYVaKwG8OZ6gX0sCfvi3mqh0IFgjtv3fmK0Ctvild8XBJs1iZoKvJFwu54
         qQqD2rnDRafbasd6xUreABRj/ccs0fL2FTpiONAYRciJzBzv3/2xzI1k/ZZ/gFwxgUY5
         HePnsiegALfcpVVlCX9aIdraq+Dy+PNzgb9CdkwgZPAqjAbqksx1axNBgTMMnjnnUNXn
         zPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682067947; x=1684659947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0gJQV+jBsuJN+dqapwDGx8wuqSDbN1mALWddpdSsEk=;
        b=OELWq9AmZRvN7CvX9H31OH0KH619alDfMckyB3m1Iyv9fvyXECywIzwrdgIS78jSO8
         hcwkSW99op9A1lKwFfVW3Ifizx0oz7/Pgg4/pajecvA5HlayQv+U54H6iHKzNC9vysGO
         aBIMgX5RKw5q/clfJNiauv6fUVKqnjB5zso4Zm5c5yQHt1sfSnpb7jwgvkk0Pf6oRfZa
         yaqrwPDtELwP+Kw2ooXPm+PLvpujtr8SVllpAZ6IS7n6kv2WLoCWntpTLWAuNPg2KjEY
         ruExG+xRUiNanslGUI9eBT+RVkYWTmkmtwLDne9ZcVEiN6uDLKkFcfAKwmf4aHYuTr67
         bR/g==
X-Gm-Message-State: AAQBX9cMH1aF27x9awh+upmJh4U/3Xssjoa2mUCRTB66ArZvty5LTg/c
        15UazuD6178LI2MLIO2fRDYAMzz+5EoI1MzZdi3ZDg==
X-Google-Smtp-Source: AKy350Yq/tolYlOhf1pDRg+pi8crdvgzu8tht/po/DMcygONgBqFFU6dDpp2J5xJKwIpk+nmGlNlMw==
X-Received: by 2002:a17:90a:3004:b0:246:681c:71fd with SMTP id g4-20020a17090a300400b00246681c71fdmr4294867pjb.6.1682067946936;
        Fri, 21 Apr 2023 02:05:46 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090a950300b0024796ddd19bsm4192309pjo.7.2023.04.21.02.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:05:46 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add testcase for bpf_task_under_cgroup
Date:   Fri, 21 Apr 2023 17:04:03 +0800
Message-Id: <20230421090403.15515-3-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230421090403.15515-1-zhoufeng.zf@bytedance.com>
References: <20230421090403.15515-1-zhoufeng.zf@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

test_progs:
Tests new kfunc bpf_task_under_cgroup().

The bpf program saves the pid which call the getuid syscall within a
given cgroup to the remote_pid, which is convenient for the user-mode
program to verify the test correctness.

The user-mode program creates its own mount namespace, and mounts the
cgroupsv2 hierarchy in there, call the getuid syscall, then check if
remote_pid and local_pid are equal.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 .../bpf/prog_tests/task_under_cgroup.c        | 46 +++++++++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_common.h   |  1 +
 .../bpf/progs/test_task_under_cgroup.c        | 40 ++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_under_cgroup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
new file mode 100644
index 000000000000..bd3deb469938
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Bytedance */
+
+#include <test_progs.h>
+#include <cgroup_helpers.h>
+#include "test_task_under_cgroup.skel.h"
+
+#define FOO	"/foo"
+
+void test_task_under_cgroup(void)
+{
+	struct test_task_under_cgroup *skel;
+	int ret, foo = -1;
+
+	foo = test__join_cgroup(FOO);
+	if (!ASSERT_OK(foo < 0, "cgroup_join_foo"))
+		return;
+
+	skel = test_task_under_cgroup__open();
+	if (!ASSERT_OK_PTR(skel, "test_task_under_cgroup__open"))
+		goto cleanup;
+
+	skel->rodata->local_pid = getpid();
+	skel->rodata->cgid = get_cgroup_id(FOO);
+
+	ret = test_task_under_cgroup__load(skel);
+	if (!ASSERT_OK(ret, "test_task_under_cgroup__load"))
+		goto cleanup;
+
+	ret = test_task_under_cgroup__attach(skel);
+	if (!ASSERT_OK(ret, "test_task_under_cgroup__attach"))
+		goto cleanup;
+
+	syscall(__NR_getuid);
+
+	test_task_under_cgroup__detach(skel);
+
+	ASSERT_EQ(skel->bss->remote_pid, skel->rodata->local_pid,
+		  "test task_under_cgroup");
+
+cleanup:
+	if (foo)
+		close(foo);
+
+	test_task_under_cgroup__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
index 22914a70db54..41b3ea231698 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
@@ -26,6 +26,7 @@ struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level) __ksym;
 struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
+int bpf_task_under_cgroup(struct cgroup *cgrp, struct task_struct *task) __ksym;
 
 static inline struct __cgrps_kfunc_map_value *cgrps_kfunc_map_value_lookup(struct cgroup *cgrp)
 {
diff --git a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
new file mode 100644
index 000000000000..e2740f9b029d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Bytedance */
+
+#include <vmlinux.h>
+#include <asm/unistd.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "cgrp_kfunc_common.h"
+
+const volatile int local_pid;
+const volatile long cgid;
+int remote_pid;
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(sysenter, struct pt_regs *regs, long id)
+{
+	struct cgroup *cgrp;
+
+	if (id != __NR_getuid)
+		return 0;
+
+	if (local_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	cgrp = bpf_cgroup_from_id(cgid);
+	if (!cgrp)
+		return 0;
+
+	if (!bpf_task_under_cgroup(cgrp, bpf_get_current_task_btf()))
+		goto out;
+
+	remote_pid = local_pid;
+
+out:
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.20.1

