Return-Path: <linux-kselftest+bounces-3293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDAD835AFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 07:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9AE3B26D26
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 06:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0226139;
	Mon, 22 Jan 2024 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="azHSEMWX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA6DF70
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904784; cv=none; b=nD3dmOJQMrE5D/HzssbMlNExDPvBiS+vNiBtq0J64KDd1iM1Dn/Zb8ty6fEyjZkqP6m6WfcAOOMu7I+f5cnEp5ThIxVy+D06X2GU8fSZYDCwUf7wLwe1f9KpAUi0rVH0mT7dGBOodVVwwf1PTrM1tlF0NO0Avipj5sPhQBv4tH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904784; c=relaxed/simple;
	bh=nomzOqG8qtQlSxsBxKy5X1xMNj4S0dr5Ifd+oiSg+rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/xebZ/lA/+y721/Fkp5BIWsx1//0GU9cUZCvvpaPIiXU86Vpt4YddsuRRs3CxVN230tKzSm1H0HLyoJiMZN/T4iybYqUoZTpkajIlwPOLylF6C4EhKPS/4xC1Iei60/4x5qUBIyngRSqLDxoBDrYi1M+Baf3gNNUvacFEe0DdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=azHSEMWX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2049410a12.3
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Jan 2024 22:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1705904782; x=1706509582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjezFELGsG5yYdoO8o3jjgWXUKsZRmSJ3eM36KaKRP0=;
        b=azHSEMWXVXCyiT3KzyyLiDGu21a8ZywlvbfIN+iQ78xfouPHJ2gvFntL1d7k+s0C/w
         tsjVC0A+OqD9LaqnJIqSc1ptdo2VJY4m+AsbS8UfpIttA+gAX0Zt+7pgK7aDSivAXXY8
         v3lXHXYsnFJ5CFYAZyDe7zr+MzdT0rumHMjqNXEEHwbziR+wr+P1PUEgAlzpURfiybVu
         vmjFLXrr5n9C9TBmR5j9U72KBZ914xzeVZPw4beE7s68BnQ4BRYQCpZ5ETDAyNAaGCl5
         S3JPWR4Rhb5MHbRQssWQCoqCFozBTgEgr/65FabKYplFw5TFmNrOv3WYKMDZl+fil49U
         qeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705904782; x=1706509582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjezFELGsG5yYdoO8o3jjgWXUKsZRmSJ3eM36KaKRP0=;
        b=ZQtkZQECafC2af3Mvxa16ElXCSHbisCvRY/q4CxQmJQWy5n7dUZn0T35ahtci+AZmF
         d8aiEaAl6VEWLKnqkOYahN10OrjfYrbI1ttJvSIIn9Tv6XjZqCyPTuV28TyvnAiOKnkX
         bdfEjpVKCZPVPfTtBoa4QHMtVPl6kE+PHWHmPw6ow2cSa72E1qWwrkBDLehCXkVdltRS
         0+odOUr28VjQndvTn91gybzmjlwe5U4oo4468eAt49vYFnZvK5RZ/BbB+SBP30E+17tS
         z4clbc8ZVgNo3oTle+8n9pMkNAKY3Zr1J3/+Cw3X1VZGY7LOmCG9LPlB4oFBNSm/sDB2
         oaJA==
X-Gm-Message-State: AOJu0YxmqhazdG1Oy9EgSnpcliKrMfHR+aPtCtec3tplPzgr+kgFolwm
	LDdtdbDV/8R7iCqp2Gi+yT6ayIHt17bzJZkUPTtpBfeHJqAaGwvlg//koP18WA==
X-Google-Smtp-Source: AGHT+IFMW888K8jWC9UqxrFXPqdvN8EA+d82Vk2Kae5kOYRMvM5HyvYhydsHUbRAopyqCX5czH23dg==
X-Received: by 2002:a17:90a:d384:b0:28e:8210:ddbc with SMTP id q4-20020a17090ad38400b0028e8210ddbcmr1483228pju.20.1705904781945;
        Sun, 21 Jan 2024 22:26:21 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b001d7248fdc26sm4317771plz.69.2024.01.21.22.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 22:26:21 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Song Liu <song@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 4/4] selftest/bpf: Test a perf bpf program that suppresses side effects.
Date: Sun, 21 Jan 2024 22:25:35 -0800
Message-Id: <20240122062535.8265-5-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122062535.8265-1-khuey@kylehuey.com>
References: <20240122062535.8265-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test sets a hardware breakpoint and uses a bpf program to suppress the
side effects of a perf event sample, including I/O availability signals,
SIGTRAPs, and decrementing the event counter limit, if the ip matches the
expected value. Then the function with the breakpoint is executed multiple
times to test that all effects behave as expected.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/perf_skip.c      | 137 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_skip.c      |  15 ++
 2 files changed, 152 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
new file mode 100644
index 000000000000..37d8618800e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <test_progs.h>
+#include "test_perf_skip.skel.h"
+#include <linux/compiler.h>
+#include <linux/hw_breakpoint.h>
+#include <sys/mman.h>
+
+#ifndef TRAP_PERF
+#define TRAP_PERF 6
+#endif
+
+int sigio_count, sigtrap_count;
+
+static void handle_sigio(int sig __always_unused)
+{
+	++sigio_count;
+}
+
+static void handle_sigtrap(int signum __always_unused,
+			   siginfo_t *info,
+			   void *ucontext __always_unused)
+{
+	ASSERT_EQ(info->si_code, TRAP_PERF, "si_code");
+	++sigtrap_count;
+}
+
+static noinline int test_function(void)
+{
+	asm volatile ("");
+	return 0;
+}
+
+void serial_test_perf_skip(void)
+{
+	struct sigaction action = {};
+	struct sigaction previous_sigtrap;
+	sighandler_t previous_sigio = SIG_ERR;
+	struct test_perf_skip *skel = NULL;
+	struct perf_event_attr attr = {};
+	int perf_fd = -1;
+	int err;
+	struct f_owner_ex owner;
+	struct bpf_link *prog_link = NULL;
+
+	action.sa_flags = SA_SIGINFO | SA_NODEFER;
+	action.sa_sigaction = handle_sigtrap;
+	sigemptyset(&action.sa_mask);
+	if (!ASSERT_OK(sigaction(SIGTRAP, &action, &previous_sigtrap), "sigaction"))
+		return;
+
+	previous_sigio = signal(SIGIO, handle_sigio);
+	if (!ASSERT_NEQ(previous_sigio, SIG_ERR, "signal"))
+		goto cleanup;
+
+	skel = test_perf_skip__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	attr.type = PERF_TYPE_BREAKPOINT;
+	attr.size = sizeof(attr);
+	attr.bp_type = HW_BREAKPOINT_X;
+	attr.bp_addr = (uintptr_t)test_function;
+	attr.bp_len = sizeof(long);
+	attr.sample_period = 1;
+	attr.sample_type = PERF_SAMPLE_IP;
+	attr.pinned = 1;
+	attr.exclude_kernel = 1;
+	attr.exclude_hv = 1;
+	attr.precise_ip = 3;
+	attr.sigtrap = 1;
+	attr.remove_on_exec = 1;
+
+	perf_fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
+	if (perf_fd < 0 && (errno == ENOENT || errno == EOPNOTSUPP)) {
+		printf("SKIP:no PERF_TYPE_BREAKPOINT/HW_BREAKPOINT_X\n");
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_OK(perf_fd < 0, "perf_event_open"))
+		goto cleanup;
+
+	/* Configure the perf event to signal on sample. */
+	err = fcntl(perf_fd, F_SETFL, O_ASYNC);
+	if (!ASSERT_OK(err, "fcntl(F_SETFL, O_ASYNC)"))
+		goto cleanup;
+
+	owner.type = F_OWNER_TID;
+	owner.pid = syscall(__NR_gettid);
+	err = fcntl(perf_fd, F_SETOWN_EX, &owner);
+	if (!ASSERT_OK(err, "fcntl(F_SETOWN_EX)"))
+		goto cleanup;
+
+	/* Allow at most one sample. A sample rejected by bpf should
+	 * not count against this.
+	 */
+	err = ioctl(perf_fd, PERF_EVENT_IOC_REFRESH, 1);
+	if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_REFRESH)"))
+		goto cleanup;
+
+	prog_link = bpf_program__attach_perf_event(skel->progs.handler, perf_fd);
+	if (!ASSERT_OK_PTR(prog_link, "bpf_program__attach_perf_event"))
+		goto cleanup;
+
+	/* Configure the bpf program to suppress the sample. */
+	skel->bss->ip = (uintptr_t)test_function;
+	test_function();
+
+	ASSERT_EQ(sigio_count, 0, "sigio_count");
+	ASSERT_EQ(sigtrap_count, 0, "sigtrap_count");
+
+	/* Configure the bpf program to allow the sample. */
+	skel->bss->ip = 0;
+	test_function();
+
+	ASSERT_EQ(sigio_count, 1, "sigio_count");
+	ASSERT_EQ(sigtrap_count, 1, "sigtrap_count");
+
+	/* Test that the sample above is the only one allowed (by perf, not
+	 * by bpf)
+	 */
+	test_function();
+
+	ASSERT_EQ(sigio_count, 1, "sigio_count");
+	ASSERT_EQ(sigtrap_count, 1, "sigtrap_count");
+
+cleanup:
+	bpf_link__destroy(prog_link);
+	if (perf_fd >= 0)
+		close(perf_fd);
+	test_perf_skip__destroy(skel);
+
+	if (previous_sigio != SIG_ERR)
+		signal(SIGIO, previous_sigio);
+	sigaction(SIGTRAP, &previous_sigtrap, NULL);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_perf_skip.c b/tools/testing/selftests/bpf/progs/test_perf_skip.c
new file mode 100644
index 000000000000..7eb8b6de7a57
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_perf_skip.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+uintptr_t ip;
+
+SEC("perf_event")
+int handler(struct bpf_perf_event_data *data)
+{
+	/* Skip events that have the correct ip. */
+	return ip != PT_REGS_IP(&data->regs);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


