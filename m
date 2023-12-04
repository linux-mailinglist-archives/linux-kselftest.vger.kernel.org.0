Return-Path: <linux-kselftest+bounces-1082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8625803F18
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 21:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C00F28120D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 20:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BC533CEC;
	Mon,  4 Dec 2023 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="ebUgtJn2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED02182
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Dec 2023 12:14:32 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-58cecfb4412so3333562eaf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Dec 2023 12:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701720872; x=1702325672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/gPyzX5houMx56rDPPZ+T9jmCn/l6+TF2FXxv5O3eY=;
        b=ebUgtJn2mw/Y9s+WswbHYIcizhkZA/nFFfxXu7g+x1/eEW3OFqvN5/MPebGMDyivN6
         etV0F0c8jcMPMmME2inouU9l/X8+FBHykSMmDvlBA4fhJdlpNHUt7MOMqLwmii2Cwg28
         co5HZJ29s8tvqSrp4lGresPxowtehWSV6yXhWWdGXkzrgcWsxsO6xFROBnnWLtr5TvlX
         3HbhfbyQhqk6EUbYmexIydEKM2Oi0YlVuqz/7Hslx6PW58wnSDcOdSkGEbBebl/3EhLa
         ALJc+RHWRbtnRUsquuJW4NfUZ1A7lx2loFZ7lnv7AdjDOCzqX2ZCLer0gDr7pyp7jkXn
         m2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720872; x=1702325672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/gPyzX5houMx56rDPPZ+T9jmCn/l6+TF2FXxv5O3eY=;
        b=mJuv/JJlpkURdldfpyQd+Ga6HPFPWeON7zxNuZepIyb4XHkaJNRTaC0bTgdzCUQ1TT
         i8IxBgyM9nuenpYSvzdibso2ZKstdn+86WiJgxRxsPyDR8htKHanNkVzc7+5IxJKzVvS
         s/fV8Qcs+d0qAuiJvJ4ezFe5MAkzL1ZixsuUggEXaw00fQqatGA2rUCclLfMQ8dEvgjf
         vZZWIkcZ4Z2+towZiLybd58xl7CO3GpQpncvmud7JN+RsMZhFD/m4mus9iEHeYINHOrB
         eQdA5BfGjyCLjZ4unAFm149xgbVi+yhfLDoDqovo+1ugN19s4GUlbTWh7tYUEAniBpgm
         xqVw==
X-Gm-Message-State: AOJu0YyrNI/0XHwx/EhP+e1EKogFl1Xfy6/CApwEJ2xbFe02qJAcDEAe
	Cg3nVeAo9kWN05POu0Msms7Quw==
X-Google-Smtp-Source: AGHT+IGXBET6MNwMSbamC/KP8JNoP1KrkiOsbvmJXhEms8xEvu2+WjJ2XqRplClC0SuDj74KcW06qA==
X-Received: by 2002:a05:6359:5c2a:b0:170:17eb:377e with SMTP id pu42-20020a0563595c2a00b0017017eb377emr4548494rwb.38.1701720871846;
        Mon, 04 Dec 2023 12:14:31 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm7894060pgh.14.2023.12.04.12.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:14:31 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftest/bpf: Test returning zero from a perf bpf program suppresses SIGIO.
Date: Mon,  4 Dec 2023 12:14:06 -0800
Message-Id: <20231204201406.341074-3-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204201406.341074-1-khuey@kylehuey.com>
References: <20231204201406.341074-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test sets a hardware breakpoint and uses a bpf program to suppress the
I/O availability signal if the ip matches the expected value.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 .../selftests/bpf/prog_tests/perf_skip.c      | 95 +++++++++++++++++++
 .../selftests/bpf/progs/test_perf_skip.c      | 23 +++++
 2 files changed, 118 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_skip.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_skip.c

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
new file mode 100644
index 000000000000..b269a31669b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include "test_perf_skip.skel.h"
+#include <linux/hw_breakpoint.h>
+#include <sys/mman.h>
+
+#define BPF_OBJECT            "test_perf_skip.bpf.o"
+
+static void handle_sig(int)
+{
+	ASSERT_OK(1, "perf event not skipped");
+}
+
+static noinline int test_function(void)
+{
+	return 0;
+}
+
+void serial_test_perf_skip(void)
+{
+	sighandler_t previous;
+	int duration = 0;
+	struct test_perf_skip *skel = NULL;
+	int map_fd = -1;
+	long page_size = sysconf(_SC_PAGE_SIZE);
+	uintptr_t *ip = NULL;
+	int prog_fd = -1;
+	struct perf_event_attr attr = {0};
+	int perf_fd = -1;
+	struct f_owner_ex owner;
+	int err;
+
+	previous = signal(SIGIO, handle_sig);
+
+	skel = test_perf_skip__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.handler);
+	if (!ASSERT_OK(prog_fd < 0, "bpf_program__fd"))
+		goto cleanup;
+
+	map_fd = bpf_map__fd(skel->maps.ip);
+	if (!ASSERT_OK(map_fd < 0, "bpf_map__fd"))
+		goto cleanup;
+
+	ip = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
+	if (!ASSERT_OK_PTR(ip, "mmap bpf map"))
+		goto cleanup;
+
+	*ip = (uintptr_t)test_function;
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
+
+	perf_fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
+	if (CHECK(perf_fd < 0, "perf_event_open", "err %d\n", perf_fd))
+		goto cleanup;
+
+	err = fcntl(perf_fd, F_SETFL, O_ASYNC);
+	if (!ASSERT_OK(err, "fcntl(F_SETFL, O_ASYNC)"))
+		goto cleanup;
+
+	owner.type = F_OWNER_TID;
+	owner.pid = gettid();
+	err = fcntl(perf_fd, F_SETOWN_EX, &owner);
+	if (!ASSERT_OK(err, "fcntl(F_SETOWN_EX)"))
+		goto cleanup;
+
+	err = ioctl(perf_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
+	if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_SET_BPF)"))
+		goto cleanup;
+
+	test_function();
+
+cleanup:
+	if (perf_fd >= 0)
+		close(perf_fd);
+	if (ip)
+		munmap(ip, page_size);
+	if (skel)
+		test_perf_skip__destroy(skel);
+
+	signal(SIGIO, previous);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_perf_skip.c b/tools/testing/selftests/bpf/progs/test_perf_skip.c
new file mode 100644
index 000000000000..ef01a9161afe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_perf_skip.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__type(key, uint32_t);
+	__type(value, uintptr_t);
+} ip SEC(".maps");
+
+SEC("perf_event")
+int handler(struct bpf_perf_event_data *data)
+{
+	const uint32_t index = 0;
+	uintptr_t *v = bpf_map_lookup_elem(&ip, &index);
+
+	return !(v && *v == PT_REGS_IP(&data->regs));
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


