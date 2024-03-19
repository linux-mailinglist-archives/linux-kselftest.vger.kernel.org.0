Return-Path: <linux-kselftest+bounces-6414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE9787F685
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 06:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B76A1F222F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 05:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEA14085B;
	Tue, 19 Mar 2024 05:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="SCC4OIgN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551340852
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Mar 2024 05:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710824685; cv=none; b=h88vMk8uZhTdnNCXaPxOxdusgCI3XohXhhuqaHv8JWGxEHzQPK41Pt1I5YLGcUveGu0dVB4hFMi5W7RTzwQreLAZnL8jjLxJ4haRNe9/5omFV+VPE/EBtBHRbw3KkQhiIPL0Fe2ypkNan3vp8Qig6XcAmOdEMpRumrF2WGqxbkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710824685; c=relaxed/simple;
	bh=o66rBTTTN9Bz/2JCsO8MOAFQm7PEkrdPPz3CiJGnfAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fxj4xq/kQINca23sdVyyFKZQ46xBgF+l29Lp8ClB7FrO21y5YlLKxY1QM7phql/Do5UExMfXs1c5NpPVGYv0zFSlkSt9Us2ZOOqAjCvaKNkp0gbNRj+EwZLJyEbgCebI7/6sMuiSW5Ik5YgVh4GQfzMamnMXj+dFfHPYSAz+ovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=SCC4OIgN; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60a0579a955so60854247b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Mar 2024 22:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710824682; x=1711429482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNBNaRHZ6AfjwYMq1bFzdzJMJiPnkD5V98EDpDv4hWA=;
        b=SCC4OIgNjdzwhsm7MxjAGgVH/THmjIQ4RiL3DZsbnenpw1c30+uz+rAHeXEp1eDfwE
         hIF8k95Jzj2N3JCynE43EnRJSjQr25a6W39KfDzz0g2xYD/axXltnU5dh7vW+vpw2Ms0
         9Zyzs9+GVKoBOBMqhsKbqTaVjju9xOEjR2sOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710824682; x=1711429482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNBNaRHZ6AfjwYMq1bFzdzJMJiPnkD5V98EDpDv4hWA=;
        b=kjKa7BkebRCtzSKWD4EpKA/P56Tb4RPZCckWMef7l7yogPwgYepo8Yx4yVcVgMHqEM
         LVLX+2Z4i4JtvlwWQ7U3avD4K/e4qr2ysHsv0XA/RiEQ61mNqCORzoJ48ECihshwDrqa
         Jbx4cAWoALeeJRMQlMbP7FsjS0eb7OFyofqs1KRblkgeE6+50EJ1+WNStqiOrq34iyCe
         wr/iGrRDyRF8YPbcKhx1fm9b88jNkjuINHzqFcGMAP2jl6o3y9OcJdESHx7HnAzUoKhr
         KeA7bFeAbu3+oUVBU/d3ImPl6XG5WJrSXdl2fuDM7swJwGju+XjSR0P0GrRY6uCcffOD
         0WOA==
X-Forwarded-Encrypted: i=1; AJvYcCXGa4O3gTvXzNS4msLBf4zkxasSEDhbOLrM04K85QZjshMsaqY4/1SfUrKbqvZbRy7aKbpiVQueSxDR6r5MpU7Gg9v09xYbsgBcPvmhFAcT
X-Gm-Message-State: AOJu0YzGMyNvsmz+rcEbtgwhaP4s8zvH8BV3yLqWeanRBMd8K7bkNpOV
	9ikAvVHq3Qh+T0hrkL+SNQSqfSflx7xu1b6wf0C1/yOETH9oreavyaMrGAfb2Vo=
X-Google-Smtp-Source: AGHT+IGUcPg4y8TA8iAfSq3V63mc8bIMbNH87magc9JoKtuTwKmArOL4jXrrqj2sJVI43B2iEtlmoA==
X-Received: by 2002:a0d:db87:0:b0:609:18e2:91b2 with SMTP id d129-20020a0ddb87000000b0060918e291b2mr1836326ywe.32.1710824682582;
        Mon, 18 Mar 2024 22:04:42 -0700 (PDT)
Received: from localhost ([12.220.158.163])
        by smtp.gmail.com with UTF8SMTPSA id eq4-20020a05690c2d0400b00609f4170662sm2181268ywb.54.2024.03.18.22.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 22:04:42 -0700 (PDT)
From: Jose Fernandez <josef@netflix.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jose Fernandez <josef@netflix.com>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH V3 bpf-next 2/2] selftests/bpf: add selftest for bpf_task_get_cgroup
Date: Mon, 18 Mar 2024 23:03:02 -0600
Message-Id: <20240319050302.1085006-2-josef@netflix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240319050302.1085006-1-josef@netflix.com>
References: <20240319050302.1085006-1-josef@netflix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a selftest for the `bpf_task_get_cgroup` kfunc. The test
focuses on the use case of obtaining the cgroup ID of the previous task
in a `sched_switch` tracepoint.

The selftest involves creating a test cgroup, attaching a BPF program
that utilizes the `bpf_task_get_cgroup` during a `sched_switch`
tracepoint, and validating that the obtained cgroup ID for the previous
task matches the expected cgroup ID.

Signed-off-by: Jose Fernandez <josef@netflix.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
---
V2 -> v3: Use _open_and_load(), usleep helper, and drop map usage
V1 -> V2: Refactor test to work with a cgroup pointer instead of the ID

 .../bpf/prog_tests/task_get_cgroup.c          | 43 +++++++++++++++++++
 .../bpf/progs/test_task_get_cgroup.c          | 32 ++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_get_cgroup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c b/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
new file mode 100644
index 000000000000..031623067e7e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2024 Netflix, Inc.
+
+#include <test_progs.h>
+#include <cgroup_helpers.h>
+#include "test_task_get_cgroup.skel.h"
+#include <unistd.h>
+
+#define TEST_CGROUP "/test-task-get-cgroup/"
+
+void test_task_get_cgroup(void)
+{
+	struct test_task_get_cgroup *skel;
+	int err, fd;
+	__u64 expected_cgroup_id;
+
+	fd = test__join_cgroup(TEST_CGROUP);
+	if (!ASSERT_OK(fd < 0, "test_join_cgroup_TEST_CGROUP"))
+		return;
+
+	skel = test_task_get_cgroup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_task_get_cgroup__open_and_load"))
+		goto cleanup;
+
+	err = test_task_get_cgroup__attach(skel);
+	if (!ASSERT_OK(err, "test_task_get_cgroup__attach"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+	expected_cgroup_id = get_cgroup_id(TEST_CGROUP);
+	if (!ASSERT_GT(expected_cgroup_id, 0, "get_cgroup_id"))
+		goto cleanup;
+
+	/* Trigger nanosleep to enter the sched_switch tracepoint */
+	/* The previous task should be this process */
+	usleep(100);
+
+	ASSERT_EQ(skel->bss->cgroup_id, expected_cgroup_id, "cgroup_id");
+
+cleanup:
+	test_task_get_cgroup__destroy(skel);
+	close(fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
new file mode 100644
index 000000000000..30d4499c6bc5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2024 Netflix, Inc.
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct cgroup *bpf_task_get_cgroup(struct task_struct *task) __ksym;
+void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
+
+int pid = 0;
+u64 cgroup_id = 0;
+
+SEC("tp_btf/sched_switch")
+int BPF_PROG(sched_switch, bool preempt, struct task_struct *prev,
+	     struct task_struct *next)
+{
+	struct cgroup *cgrp;
+
+	if (prev->pid != pid)
+		return 0;
+
+	cgrp = bpf_task_get_cgroup(prev);
+	if (cgrp == NULL)
+		return 0;
+	cgroup_id = cgrp->kn->id;
+
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.40.1


