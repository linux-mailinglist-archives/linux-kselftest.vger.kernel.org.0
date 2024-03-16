Return-Path: <linux-kselftest+bounces-6374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114BC87DAC8
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Mar 2024 17:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348CB1C20D5D
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Mar 2024 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762231BDDC;
	Sat, 16 Mar 2024 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="IeQ/wunu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12D41BC37
	for <linux-kselftest@vger.kernel.org>; Sat, 16 Mar 2024 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710606186; cv=none; b=BGNwiepawS4KmqE6LFROq453MnwOIMQHvkXCB7UokweOTWoi/LuKB6vVy3X/x2Sq8QZulWw6bxb6jhTQLfXwiPiZwkBcEX2KcO6UTjaoez3AN43VwgTZyBOC0p9TqeQsfwLZ5abaol7MkOmFtKL+1aD/Hn8zYV8lcOlZvgNof7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710606186; c=relaxed/simple;
	bh=3T/N87s1TiFY5CTbl7PLYpRpVqYPbSLIXW4VbrW9Qr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BIrS3ucVVdQ36RtvElQrjVoB32DaR5wnlmnOavMLE/RzcSae7QJweMj5m7eysPW1iDHnIiJyg1/0VEIsK208baVDUguc6M+3z1KHOAjrg9jQ8LJNXAgvZPMA10lyxYbFn8S8gKT8PxHHhCkkfFWQvhX4KBkJDNb2muGBKE6mM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=IeQ/wunu; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36695f8029aso6940625ab.3
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Mar 2024 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710606184; x=1711210984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FR+HdfxLkkzGogNavG10On9pl0CTmo3qowHlz+D4lik=;
        b=IeQ/wunulIJh644LmVGaP4TsG2ufkdFJbSA92QJ9l3FCE3lD+75fMotwzn9EGVQa72
         caqIWJ7qwAphbbJzwB/QdCv6kDiOOeQhbt8apQ0tsPK7vG5WZLg8soqVkd2DyKYVL0bZ
         Z1z7sAXNdbIAaD4e/x8rriB6Ht4cMRBq5nocU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710606184; x=1711210984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FR+HdfxLkkzGogNavG10On9pl0CTmo3qowHlz+D4lik=;
        b=hwPNm7fZ66/qI+Wz7TCybqsdq4aNucb/aPLXcBw/COnMBHCwnruvCJuWSscPtfU0SJ
         +lP9QDK8Jsdrt4e02Kg/F5/5oQU73qF5ghPQ76pDz4WmuO0gI0Bn6tXZYtiGrSeikUQD
         f6TS4bihYLk56W3m7uA99smuqRKuTT0KaACFubXzq9l+kpAqPUwCAjh9FnRMCym4wq0F
         D9UgZ3YxCJfTqCMZcH9iVOVibKo7Q3MCdzQRm1OfB3bZozmmUzURMA7VFueZz/oqjcFK
         vap3ND54TWNQKL1vzIzt0+azfPGbF6z+2dk0TfLy5vLWjM3vLnEfNqMQ9UZPXhv9DnPu
         bHGg==
X-Forwarded-Encrypted: i=1; AJvYcCW6sUfukPue9pUq+CmIGuFJDT/a/r8nMsbiPMWzWFUl5hX7gXi/Tkz2k/i0iObDdmE3Dj7rzFAJ55r3iwhrPWOtTBks6fZfv4PWi1CM8gFe
X-Gm-Message-State: AOJu0YxpkfhQ3BEsUAAKfholkrtoOtiI1UQXjqgOSzKny8Su/xJCqrsr
	I+i7NVprCrIh8ZFovAXATbUkwI66QkMgN4g9f/lPqwL2P9/dxl9CXgmE0XQ2tgU=
X-Google-Smtp-Source: AGHT+IGcQ3XP+3qarC5wBmrvkYQ3EjpLmKBi8RlI1pDwXP/BaiR7qNci2pcjPRzQ5wA6UbIVH8QunQ==
X-Received: by 2002:a6b:7315:0:b0:7cb:f297:a94b with SMTP id e21-20020a6b7315000000b007cbf297a94bmr5599660ioh.15.1710606183865;
        Sat, 16 Mar 2024 09:23:03 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20:db82:ef0d:e122:37fc])
        by smtp.gmail.com with UTF8SMTPSA id o27-20020a02cc3b000000b00474f364aac9sm1362211jap.71.2024.03.16.09.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 09:23:03 -0700 (PDT)
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
Subject: [PATCH V2 bpf-next 2/2] selftests/bpf: add selftest for bpf_task_get_cgroup
Date: Sat, 16 Mar 2024 10:22:41 -0600
Message-Id: <20240316162241.628855-2-josef@netflix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240316162241.628855-1-josef@netflix.com>
References: <20240316162241.628855-1-josef@netflix.com>
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
V1 -> V2: Refactor test to work with a cgroup pointer instead of the ID

 .../bpf/prog_tests/task_get_cgroup.c          | 58 +++++++++++++++++++
 .../bpf/progs/test_task_get_cgroup.c          | 37 ++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_get_cgroup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c b/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
new file mode 100644
index 000000000000..67ed65d0c461
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
@@ -0,0 +1,58 @@
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
+	pid_t pid;
+	__u64 cgroup_id, expected_cgroup_id;
+	const struct timespec req = {
+		.tv_sec = 1,
+		.tv_nsec = 0,
+	};
+
+	fd = test__join_cgroup(TEST_CGROUP);
+	if (!ASSERT_OK(fd < 0, "test_join_cgroup_TEST_CGROUP"))
+		return;
+
+	skel = test_task_get_cgroup__open();
+	if (!ASSERT_OK_PTR(skel, "test_task_get_cgroup__open"))
+		goto cleanup;
+
+	err = test_task_get_cgroup__load(skel);
+	if (!ASSERT_OK(err, "test_task_get_cgroup__load"))
+		goto cleanup;
+
+	err = test_task_get_cgroup__attach(skel);
+	if (!ASSERT_OK(err, "test_task_get_cgroup__attach"))
+		goto cleanup;
+
+	pid = getpid();
+	expected_cgroup_id = get_cgroup_id(TEST_CGROUP);
+	if (!ASSERT_GT(expected_cgroup_id, 0, "get_cgroup_id"))
+		goto cleanup;
+
+	/* Trigger nanosleep to enter the sched_switch tracepoint */
+	/* The previous task should be this process */
+	syscall(__NR_nanosleep, &req, NULL);
+
+	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.pid_to_cgid_map), &pid,
+				  &cgroup_id);
+
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		goto cleanup;
+
+	ASSERT_EQ(cgroup_id, expected_cgroup_id, "cgroup_id");
+
+cleanup:
+	test_task_get_cgroup__destroy(skel);
+	close(fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
new file mode 100644
index 000000000000..580f8f0657d5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
@@ -0,0 +1,37 @@
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
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 4096);
+	__type(key, __u32);
+	__type(value, __u64);
+} pid_to_cgid_map SEC(".maps");
+
+SEC("tp_btf/sched_switch")
+int BPF_PROG(sched_switch, bool preempt, struct task_struct *prev,
+	     struct task_struct *next)
+{
+	struct cgroup *cgrp;
+	u64 cgroup_id;
+	u32 pid;
+
+	cgrp = bpf_task_get_cgroup(prev);
+	if (cgrp == NULL)
+		return 0;
+	cgroup_id = cgrp->kn->id;
+	pid = prev->pid;
+	bpf_map_update_elem(&pid_to_cgid_map, &pid, &cgroup_id, BPF_ANY);
+
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.40.1


