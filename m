Return-Path: <linux-kselftest+bounces-7740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B328A2370
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 03:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBB4287800
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 01:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066DFC0C;
	Fri, 12 Apr 2024 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="BBumYXRF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4702574D
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886668; cv=none; b=biz4aDoLc+JFFYxezmtNtrlVikL2wGVEZtB3jfitZDWnn900CEHpN79retC6oiHBUosDfRKnwoy+OztT9nIOacCQCeusqFF1F8jgFv1/A365SiZIBTXEptEmi/QfpdOYVSdhCS6YU7zzaAzlNjHtkcTOFScGAVxxORZbpowo50o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886668; c=relaxed/simple;
	bh=EfTqzolUvIxbeV77szfL3e0e1IBqxiKk0wQkbdth9Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AiMxmHi+zsZ1pOtqIUpb9ksJw/EB53gNmbtKdb3Vahus0O9I9qnLeECMf9oIE/TdV3pj9SBarcfPtuo3ueLUWK93UTKS8zDKHHGXITMupE7hCimt2CPacwiTYI1oCJmTjFm+Y9oIogMU2XbjX9IVg1+FklhGdgHWFQRyw1iKPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=BBumYXRF; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61428e80f0cso3280637b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 18:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1712886665; x=1713491465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLsAtO8E8WEI0YPLnWc4zGD4gPrub60dCUyhat+mc0A=;
        b=BBumYXRFyY4oAk5wBat/ahkj0vo4ZnGDizw9oe7uiI4of7VQSdzqMqicfgz6Iqva3+
         TWB3iYBSoKCwGzfyBadYhTJblNxUidbYGWt29yAxB5uG5AVFqqKSDB9JIUZvJIq3h5un
         AqcdhEOTYPdqqEB4RwLqMoOsWiVbiB2K6Ecn3dTiLeWaFd5ZlStzsB5463mCQOB7hSHP
         EamyeE7eoRo/SMtDLC1565o/z8czbepN5SJj7jsJXvH6TKSiN6tBk8KfyjROBuQ25zXo
         YliCS1PX3q8xNQUWIf+bDWLpFXKq81+s1iRIV0vtGBpRQ4V73mrheJV4nWzRPm6DOH2i
         aitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886665; x=1713491465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLsAtO8E8WEI0YPLnWc4zGD4gPrub60dCUyhat+mc0A=;
        b=UOSbrmQ1fQfCceA1sj90x3lCMzudzeFhtZ9PlFzD1rIkn8ctL1colRUfQ0BINomRg/
         lWRl+VEbuAjjYViw96ViE3je0gtdxA3UNwum3kErgkuQ1D8nvxDAzjADdQIe1zD+Mvia
         KR6wF5Y52xzz7dNwrUTj/IFsglMobpHpxB/CaOal71SQqD2g6TTf6/uCz7Mgc6PXBI2D
         EKO4Qw2SemHeUX+ogvUrzpQaljuIh938SaPkbqYuiAdeaIX34N/aCDpoJKdosU1zJe5M
         oUQN/2EMoLf7o1J6xo/ElleQ0hG57Yp9UZCaMP2RNFoY1a46lKWAH3F9bGu+w6byKA79
         Lnbw==
X-Forwarded-Encrypted: i=1; AJvYcCWTo9KtCw3JCGEKurvPkm2iS6uzTKpXYBrLNfz8pqA7E5M/znxOUU0aAHmpvkQ68trPyoj61XzWNjcN2ceqJ/6MAF/hKJ9ozvFcHpo0tM2Y
X-Gm-Message-State: AOJu0YyeGKHvun3eyAqwiamuhe+bODkEJq+ltroScKeJECSK3urm95gm
	DLsIBzCIoxsre4/B+laz7nKstwoOE/KVUn3+ENpOcYUoUDag+0gJvwYONVE9hQ==
X-Google-Smtp-Source: AGHT+IF6KWE2O+uOj1W7BUPtfwmixy3UO/O70mlonobqoOzGHLL5MXKtYfA1MJKuTWaSz4KGSxyRhQ==
X-Received: by 2002:a81:4ec7:0:b0:615:21e7:6bf6 with SMTP id c190-20020a814ec7000000b0061521e76bf6mr1172665ywb.14.1712886664785;
        Thu, 11 Apr 2024 18:51:04 -0700 (PDT)
Received: from ip-172-31-44-15.us-east-2.compute.internal (ec2-52-15-100-147.us-east-2.compute.amazonaws.com. [52.15.100.147])
        by smtp.googlemail.com with ESMTPSA id f10-20020a05620a15aa00b0078d76c1178esm1756677qkk.119.2024.04.11.18.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 18:51:04 -0700 (PDT)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	bpf@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 7/7] selftest/bpf: Test a perf bpf program that suppresses side effects.
Date: Thu, 11 Apr 2024 18:50:19 -0700
Message-Id: <20240412015019.7060-8-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412015019.7060-1-khuey@kylehuey.com>
References: <20240412015019.7060-1-khuey@kylehuey.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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


