Return-Path: <linux-kselftest+bounces-6366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD3387D396
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 19:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF4A1F218B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEBA44C77;
	Fri, 15 Mar 2024 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="D8K8IlPE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE74F8B2
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Mar 2024 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527339; cv=none; b=sXJ4UwtTcbGQYbwsEk4R97c9RO6qEdtcDWVZou9+uIYlAzFw8wcqYdpyUWmWB+bDDmA4+fIvKQbKTXemY2brquaIL+DO4fygbBtFErK6VSZiuT9mlMweijFW5bt/cn/z3Yir/f/Mz8SBOigXdVtbrRFwrHHnrwXI4fm8cgimFDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527339; c=relaxed/simple;
	bh=ttV9IS7mXHSV0ZtQpCibNPetdR35dyL3P7pVFnt1Rd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B5nPHEygJAKj43dkb1hnKv36Ajz5xFC/XyQ265F60eW/W7xcZAolOGb/EV4sdkqSDCbfkHnMzBSYpZvKI9xnj7dTJrmIIZdJxYCHmepgfWUDGozMjKjDyVWtlR5VVBxnU+24RI/0LoLd6JJDaDRY26xiqpx/h9Zll9wskegYH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=D8K8IlPE; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c8ae457b27so70691939f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Mar 2024 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710527334; x=1711132134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfZxqGfm794szzm6SQbZFvEP7H7WQ+NfmahR3rYMEb4=;
        b=D8K8IlPEXZOu25BFtPybWQ2xEAuj/EIu06ufGthSon+K2097ecUOUzfCT54KET6HPI
         6XmQblr8Ka3KZRTJtt0kk4Qz+I9+qzNu500tjNatmCefiE5BZKzs2lS0UAt2PMOCMxdo
         gsBHM2q0VEGN+D/I4vpTJh5TZ7pPhJfc+zfJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710527334; x=1711132134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfZxqGfm794szzm6SQbZFvEP7H7WQ+NfmahR3rYMEb4=;
        b=J+vNJfF6X7y1N4TzQiYmVLJN9n5kg5lk0fEvuJClZgPKqBkBlnMI9YHypt6WicZMrs
         2jj5kXoQGe1sas5bhxrKtMZ0xpaFsUlpWi22iMDcyeuTNAU2LANHNoIOdNEJgyDIf9xt
         O6BUiotuKB+yHSzkA8Skwf9gRO4a/7gJ1p9nM1sBtAEDlsGsNXslyS5dqMHJmspxXQ4+
         46gzsTaA4gjjaypb+9kPiKkd1Ruqj3v0l8jeR3WMtWr+vpfbmV5M0UVDjRC5KqCewz/L
         2uRme6KqybOWZxXV08fgl9Fz0X/UbX6w3FtBVgSeTZsUmaEQMBQ6mEI2qeXOOeWjr9Rd
         lWlA==
X-Forwarded-Encrypted: i=1; AJvYcCW4fpFazp4yrEcievXov+5AbNMfdSe/Zcl5L2YKilNnZcJdJPa2b0J9SFFciKWiG2LGg1Pt/dvxBdSGpxP+vqQn4E1GdJdS/LHIlj9c6Z7t
X-Gm-Message-State: AOJu0YyX8EYGmvXwDmYr/N4h5s1tdnMrr/hKWBIY2NqOsLnIeN/52UkO
	Pj7wb79WuW0UJEwy7DuQDkpoLFTor0FPR9QNNfCDYhAiaM+5GipJm4n/d7R6CPIKZyK41Vy999g
	rfrfYgINy
X-Google-Smtp-Source: AGHT+IHT56pFwD1DPWvseGf1YhKPgQoet77lNXaEyjmj1UMSb6H2RIBWlwfZ3LdWLPAnX9PdX7qxJA==
X-Received: by 2002:a05:6602:4914:b0:7cb:dd4a:428d with SMTP id ef20-20020a056602491400b007cbdd4a428dmr3749532iob.10.1710527334615;
        Fri, 15 Mar 2024 11:28:54 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20:c760:7c0b:344d:cd33])
        by smtp.gmail.com with UTF8SMTPSA id j1-20020a02a681000000b00476e0c80ec6sm864616jam.93.2024.03.15.11.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 11:28:54 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: add selftest for btf_task_get_cgroup_id
Date: Fri, 15 Mar 2024 12:28:04 -0600
Message-Id: <20240315182804.216081-2-josef@netflix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240315182804.216081-1-josef@netflix.com>
References: <20240315182804.216081-1-josef@netflix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a selftest for the `bpf_task_get_cgroup_id` kfunc. The
test focuses on the use case of obtaining the cgroup ID of the previous
task in a `sched_switch` tracepoint.

The selftest involves creating a test cgroup, attaching a BPF program
that utilizes the `bpf_task_get_cgroup_id` during a `sched_switch`
tracepoint, and validating that the obtained cgroup ID for the previous
task matches the expected cgroup ID.

task_get_cgroup_id:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Jose Fernandez <josef@netflix.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
---
 .../bpf/prog_tests/task_get_cgroup_id.c       | 58 +++++++++++++++++++
 .../bpf/progs/test_task_get_cgroup_id.c       | 30 ++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_get_cgroup_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_get_cgroup_id.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_get_cgroup_id.c b/tools/testing/selftests/bpf/prog_tests/task_get_cgroup_id.c
new file mode 100644
index 000000000000..b8c4551195d3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_get_cgroup_id.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2024 Netflix, Inc.
+
+#include <test_progs.h>
+#include <cgroup_helpers.h>
+#include "test_task_get_cgroup_id.skel.h"
+#include <unistd.h>
+
+#define TEST_CGROUP "/test-task-get-cgroup-id/"
+
+void test_task_get_cgroup_id(void)
+{
+	struct test_task_get_cgroup_id *skel;
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
+	skel = test_task_get_cgroup_id__open();
+	if (!ASSERT_OK_PTR(skel, "test_task_get_cgroup_id__open"))
+		goto cleanup;
+
+	err = test_task_get_cgroup_id__load(skel);
+	if (!ASSERT_OK(err, "test_task_get_cgroup_id__load"))
+		goto cleanup;
+
+	err = test_task_get_cgroup_id__attach(skel);
+	if (!ASSERT_OK(err, "test_task_get_cgroup_id__attach"))
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
+	test_task_get_cgroup_id__destroy(skel);
+	close(fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_task_get_cgroup_id.c b/tools/testing/selftests/bpf/progs/test_task_get_cgroup_id.c
new file mode 100644
index 000000000000..7e6bc008970f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_task_get_cgroup_id.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2024 Netflix, Inc.
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+u64 bpf_task_get_cgroup_id(struct task_struct *task) __ksym;
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
+	u32 pid = prev->pid;
+	u64 cgroup_id;
+
+	cgroup_id = bpf_task_get_cgroup_id(prev);
+	bpf_map_update_elem(&pid_to_cgid_map, &pid, &cgroup_id, BPF_ANY);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.40.1


