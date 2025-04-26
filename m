Return-Path: <linux-kselftest+bounces-31715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0C5A9DC0E
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 18:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41391467DBD
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 16:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC9F25D8F3;
	Sat, 26 Apr 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBHgvRBS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1425D21D;
	Sat, 26 Apr 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745683282; cv=none; b=VVMoqBxj47BmG3C7XQv8uE2J+z1OpRRxtJWdygUMHjww4BgtRd9zwmfP0CJrbnY8tpB6nD2cVG0wQY0k6bWFAsbZKGb8euMYZYPHEDbUbGyR4ytxjygPV9hg6ltYmakB6N3A1WqtTOs3udWC7g0QmvGqK10K6ilKW0TxJLnbTeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745683282; c=relaxed/simple;
	bh=j1ZwpePxHf17oaNy4C817iuNGsFMNMA27KCXp3StqC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmlJ20lUoWbeO0HZvg/9xVDcl1l51zdT4EWaolaf5KlbF8cj7FW39tOdugDPSjAiDRU0SIauineAmUI2CdSi/PFslf7JUEefxj2IkgymMirk1GoGzODEau2JQguFMYAz9ebWpGT45jcAwrVw+3Y+iB+6I6KKc/+bxQc+eQiO9IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBHgvRBS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7376e311086so4556845b3a.3;
        Sat, 26 Apr 2025 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745683280; x=1746288080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pni2FZRTPtb8qRjCx0Q87tyTFJ+GCQIncwnprr7wWgE=;
        b=QBHgvRBSLbVc/Sx08gPXKGClsKwiUguwzNKatGdXcQtOn1XfEciPuNWVpqqvjCET18
         /c+tSvT4TnF7f6TLM/tRySp0b3V7EkWMwHerYr4ApcAHI+YOAYjczK/JmjvNf/UULNHf
         04XygGsuxZZi1Wp9RiGxMZv9vviIjtouAUQ9gKaidlF8LH1GSc0OglWQfb5LXTfIf28B
         1TeuZo7XHGwwIh+pqpyDm0svCBBHdIfH2YOvmoCezlHOmTgayonjlOdVy+iwTAZomKaL
         te9TjO3e9FlW/iiRwk9bC2vKIz76uReWvS6HLlelLE69/QQNdYxnQSHktwUMvDTqiZbs
         jZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745683280; x=1746288080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pni2FZRTPtb8qRjCx0Q87tyTFJ+GCQIncwnprr7wWgE=;
        b=S1O4/W5I3m467tLVPD24LPbCCMWg75fzEnvXWcxb5/Ea9fV9YEQuNW/xu7bQX+ytoO
         jk1Ez4qJoV4PxDeHWvQ0ocwadgfX2ozT83fK3LCJQMZrWRNurDsaRap2VTJ0sMJGtcaE
         SGHWhpPKT/Y7r4fu62xjkZBvz3CB6sV1lAg8zGEWGKwizfYPlqIk3DDX71E5Z1h4noDt
         l+MFrsRA2LmPySsdtiraMJUJFRPTLaIPDKzknA65ScXDdH9nqW1An7f2+qAx+uLnABIq
         AlFVeat1+43TYI81ET/yhbvdgPQCJYX0SO45C5Xp/kUDLKjcbABEMCB8F6hLVtnNbIHF
         +hrw==
X-Forwarded-Encrypted: i=1; AJvYcCV8RFjMHN2EDFF9PX3+lonodys4l/Zkqc8wPyNrGsEcJ4/w+A9Jp0tcuvwx9ervDhibVkPImT+3jpNt8hXChJOq@vger.kernel.org, AJvYcCVXjBApDXqnsZIZsAdEa3wWvcjCZRDGzeegBty/fCQ777Txy1vzC0hT2DTjdVLQ3D+eNphkeCBT@vger.kernel.org, AJvYcCWLXcPyq86GVZRPSBGPXzbXZvbVHisRRhZ8Ed5oUM/TYYCalmnImkbCFaES6R3E73APqv8=@vger.kernel.org, AJvYcCXr8geTaygwN8QLkRKTsLz7U9JVCh8OO1W0rgPinLButL4I1Wmt/riCyMS3IiEF649Lpyfnp2sKzM/nXM4nx6JYlL8e@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAPmdqDfAKZLwlt4igQZ5xTLkry7wGM0DdGOAVuPA+R1O7Rj9
	fnSZGe/TC693VvkdOOdw+J0dTyUZF2ObezRkJsxMxnLLr7xwZVj0
X-Gm-Gg: ASbGncuvNfVCIB2ufQTmYZ8LyQqIUsCXeNnw5M7y5RUM9NLCjoi2cfchyW85rSJJG2w
	UuA82BIN25/wUrksvGmyfznU1qVyHMBwhfo9f58tRfnlXvuDX65cWPm+mb0JS5EAGN+DzKy8BZf
	ONR2VhIt9NEg4rPQVwm53SH4AjcnyzUK1gg9UgUOSWHhMyDWQNuYimjxeKMOGNijc9WyLXGd+ha
	5aaHzNpPzpavsqFjk9AjkGdmaCbLQf7D5CPnYutQCpRl+0cMZHLarmNRB+DY4KmvlJ79w9hAVt9
	C+wCSOWDf0m0hL2jvk6L5UkkiMY9CfQTizHZF7VMpdg=
X-Google-Smtp-Source: AGHT+IFr3Hq2i69IJFF1tw0S+2vvtpcd7Ijsa0JxUv/8phzlJOtKXrwfW+IUvTV1XqCfbuHcuHWW0Q==
X-Received: by 2002:a05:6a00:2410:b0:736:4b85:ee05 with SMTP id d2e1a72fcca58-73fd74c1cc4mr7970090b3a.11.1745683280597;
        Sat, 26 Apr 2025 09:01:20 -0700 (PDT)
Received: from ubuntu2404.. ([122.231.145.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25941cc1sm5174760b3a.60.2025.04.26.09.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 09:01:20 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev,
	mannkafai@gmail.com
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add tests for get_func_[arg|arg_cnt] helpers in raw tracepoint programs
Date: Sun, 27 Apr 2025 00:00:27 +0800
Message-ID: <20250426160027.177173-5-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250426160027.177173-1-mannkafai@gmail.com>
References: <20250426160027.177173-1-mannkafai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tests for get_func_[arg|arg_cnt] helpers in raw tracepoint programs.
Using these helpers in raw_tp/tp_btf programs.

Signed-off-by: KaFai Wan <mannkafai@gmail.com>
---
 .../bpf/prog_tests/raw_tp_get_func_args.c     | 48 +++++++++++++++++++
 .../bpf/progs/test_raw_tp_get_func_args.c     | 47 ++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_get_func_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_raw_tp_get_func_args.c

diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_get_func_args.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_get_func_args.c
new file mode 100644
index 000000000000..cbe9b441d8d9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_get_func_args.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <linux/bpf.h>
+#include "bpf/libbpf_internal.h"
+#include "test_raw_tp_get_func_args.skel.h"
+
+static void test_raw_tp_args(bool is_tp_btf)
+{
+	__u64 args[2] = {0x1234ULL, 0x5678ULL};
+	int expected_retval = 0x1234 + 0x5678;
+	struct test_raw_tp_get_func_args *skel;
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.ctx_in = args,
+		.ctx_size_in = sizeof(args),
+	);
+	int err, prog_fd;
+
+	skel = test_raw_tp_get_func_args__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	bpf_program__set_autoattach(skel->progs.tp_btf_test, is_tp_btf);
+	bpf_program__set_autoattach(skel->progs.raw_tp_test, !is_tp_btf);
+
+	err = test_raw_tp_get_func_args__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	if (is_tp_btf)
+		prog_fd = bpf_program__fd(skel->progs.tp_btf_test);
+	else
+		prog_fd = bpf_program__fd(skel->progs.raw_tp_test);
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(opts.retval, expected_retval, "check_retval");
+	ASSERT_EQ(skel->bss->test_result, 1, "test_result");
+
+cleanup:
+	test_raw_tp_get_func_args__destroy(skel);
+}
+
+void test_raw_tp_get_func_args(void)
+{
+	if (test__start_subtest("raw_tp"))
+		test_raw_tp_args(false);
+	if (test__start_subtest("tp_btf"))
+		test_raw_tp_args(true);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_raw_tp_get_func_args.c b/tools/testing/selftests/bpf/progs/test_raw_tp_get_func_args.c
new file mode 100644
index 000000000000..5069bbd15283
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_raw_tp_get_func_args.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+
+__u64 test_result = 0;
+
+static __always_inline int check_args(void *ctx, struct task_struct *task,
+				      char *comm)
+{
+	__u64 cnt = bpf_get_func_arg_cnt(ctx);
+	__u64 a = 0, b = 0, z = 0;
+	__s64 err;
+
+	if ((__u64)task != 0x1234ULL || (__u64)comm != 0x5678ULL)
+		return 0;
+
+	test_result = cnt == 2;
+
+	/* valid arguments */
+	err = bpf_get_func_arg(ctx, 0, &a);
+	test_result &= err == 0 && a == 0x1234ULL;
+
+	err = bpf_get_func_arg(ctx, 1, &b);
+	test_result &= err == 0 && b == 0x5678ULL;
+
+	/* not valid argument */
+	err = bpf_get_func_arg(ctx, 2, &z);
+	test_result &= err == -EINVAL;
+
+	return a + b;
+}
+
+SEC("raw_tp/task_rename")
+int BPF_PROG(raw_tp_test, struct task_struct *task, char *comm)
+{
+	return check_args(ctx, task, comm);
+}
+
+SEC("tp_btf/task_rename")
+int BPF_PROG(tp_btf_test, struct task_struct *task, char *comm)
+{
+	return check_args(ctx, task, comm);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


