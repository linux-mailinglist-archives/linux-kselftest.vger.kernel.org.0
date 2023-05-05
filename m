Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6E6F7CC9
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 May 2023 08:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjEEGJO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 02:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjEEGJO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 02:09:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632DC15EE4
        for <linux-kselftest@vger.kernel.org>; Thu,  4 May 2023 23:08:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115e652eeso17481548b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 May 2023 23:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683266926; x=1685858926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=to2GelvfQOYiPdEg5VbR1Ww7puasvELAAcMjuLN9bQo=;
        b=giSZniElR4IwMglaX8J4DvYJVEoN9PIDwI+g5ofE55e+BQbq+0IL+eL5pOqhO0ciCb
         eJNGrAiKfCddux7ahLTbRwM22glGy/6T95p55GKxSVI3oihQN7P5y5y/xb/2vbAgkuZn
         XYtRaOP5bocO/I0ZqTOK6We5w8c65E27MA9ZqSdH3x1I+fWh2kso0l+aTFFARHQT3KgD
         oYmXnp91OADgI8ooJ/SJz0MYyIh/ViFJ//WkzwqPD3cTbul+r6TpcWY7r46Rl7fJu5Ac
         CM1UGkDc+CqmkWafJYZw22L+tggPFMse3cMoobg85Opm4sT182vrPghkkei6nDwAGI0p
         i/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683266926; x=1685858926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=to2GelvfQOYiPdEg5VbR1Ww7puasvELAAcMjuLN9bQo=;
        b=ScF3MnFg9zRockcdrV4jvFPEEQEZzx1vFC2s3jiaISHZllZm7Dh90O3lP1oBMjr1r9
         lHdiPuQwYq7zDQt+4KtV/3RCpRud7tx0yh4fAR+JkCFdAwML7mtMjsiV/gTvsXGMBWw/
         FFRKZpmDo6NluOnzn1WHWndPrrfdSXWqJMVoY6HeQK/axjO4fUVG2mZE4xnJ2cnIghXn
         G5ipsuxhxU3BazDlJA0+sTOf/pE1MI5B4xlu1kpMYJa36KahoiMQQiCnF+Nt00iP3kkP
         yZBj2YOrzrybP6/YBhM4cqmyLq7Pa4APOs/coUtD/gIoNSTuWnYq/28/DKPEweOr8NWH
         43pw==
X-Gm-Message-State: AC+VfDzdB4xWGt8aynnMBQSmj8qLEfubjatY1FEG6MQneIEiABJTdgCW
        ZsLVVpL4hNFSN1b0nMiK1E8nNQ==
X-Google-Smtp-Source: ACHHUZ6ivCxc1L9sOJcav8doABE8zYv32BcS+mhDa+KDZSJ0e905pj0HzXHx6WVlNQvHjJ4Rx53wmg==
X-Received: by 2002:a05:6a00:13a8:b0:63d:6744:8cae with SMTP id t40-20020a056a0013a800b0063d67448caemr833671pfg.2.1683266925850;
        Thu, 04 May 2023 23:08:45 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id a15-20020aa780cf000000b0063799398eb9sm762160pfn.58.2023.05.04.23.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 23:08:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 2/2] selftests/bpf: Add testcase for bpf_task_under_cgroup
Date:   Fri,  5 May 2023 14:08:18 +0800
Message-Id: <20230505060818.60037-3-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230505060818.60037-1-zhoufeng.zf@bytedance.com>
References: <20230505060818.60037-1-zhoufeng.zf@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

test_progs:
Tests new kfunc bpf_task_under_cgroup().

The bpf program saves the new task's pid within a given cgroup to
the remote_pid, which is convenient for the user-mode program to
verify the test correctness.

The user-mode program creates its own mount namespace, and mounts the
cgroupsv2 hierarchy in there, call the fork syscall, then check if
remote_pid and local_pid are unequal.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../bpf/prog_tests/task_under_cgroup.c        | 53 +++++++++++++++++++
 .../bpf/progs/test_task_under_cgroup.c        | 51 ++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_under_cgroup.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index c7463f3ec3c0..5061d9e24c16 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -26,3 +26,4 @@ user_ringbuf                             # failed to find kernel BTF type ID of
 verif_stats                              # trace_vprintk__open_and_load unexpected error: -9                           (?)
 xdp_bonding                              # failed to auto-attach program 'trace_on_entry': -524                        (trampoline)
 xdp_metadata                             # JIT does not support calling kernel function                                (kfunc)
+test_task_under_cgroup                   # JIT does not support calling kernel function                                (kfunc)
diff --git a/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
new file mode 100644
index 000000000000..4224727fb364
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Bytedance */
+
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include <cgroup_helpers.h>
+#include "test_task_under_cgroup.skel.h"
+
+#define FOO	"/foo"
+
+void test_task_under_cgroup(void)
+{
+	struct test_task_under_cgroup *skel;
+	int ret, foo;
+	pid_t pid;
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
+	skel->bss->remote_pid = getpid();
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
+	pid = fork();
+	if (pid == 0)
+		exit(0);
+
+	ret = (pid == -1);
+	if (ASSERT_OK(ret, "fork process"))
+		wait(NULL);
+
+	test_task_under_cgroup__detach(skel);
+
+	ASSERT_NEQ(skel->bss->remote_pid, skel->rodata->local_pid,
+		   "test task_under_cgroup");
+
+cleanup:
+	test_task_under_cgroup__destroy(skel);
+	close(foo);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
new file mode 100644
index 000000000000..56cdc0a553f0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Bytedance */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+long bpf_task_under_cgroup(struct task_struct *task, struct cgroup *ancestor) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+const volatile int local_pid;
+const volatile __u64 cgid;
+int remote_pid;
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(handle__task_newtask, struct task_struct *task, u64 clone_flags)
+{
+	struct cgroup *cgrp = NULL;
+	struct task_struct *acquired;
+
+	if (local_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	acquired = bpf_task_acquire(task);
+	if (!acquired)
+		return 0;
+
+	if (local_pid == acquired->tgid)
+		goto out;
+
+	cgrp = bpf_cgroup_from_id(cgid);
+	if (!cgrp)
+		goto out;
+
+	if (bpf_task_under_cgroup(acquired, cgrp))
+		remote_pid = acquired->tgid;
+
+out:
+	if (cgrp)
+		bpf_cgroup_release(cgrp);
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.20.1

