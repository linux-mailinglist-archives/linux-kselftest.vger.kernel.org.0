Return-Path: <linux-kselftest+bounces-15135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894EF94E402
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 02:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A07A282005
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 00:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D954A32;
	Mon, 12 Aug 2024 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtmK3vgV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4081E;
	Mon, 12 Aug 2024 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723423517; cv=none; b=o94PNVVgBZsjBEB9vUmzlLBAVJ7YLr9twFwUQmeISO/dSJ0U3MNEe/NpdYfc9RXS6C/3vPzYR6z7jc6Rw5zNrL72vAK/9kbyJcPz4ZYOeiSHok/UOZ95FI5JWvAEDavUHlSaeMxaMsSNGWVRX62isDeFPPijUCwXuXR7ApGazHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723423517; c=relaxed/simple;
	bh=hOCi75cY10pAzLAWbd465ChTXS3DWEWr+EI6mX6BB1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEFfIbjmzcJ5xupNpARtfIBzFZ0MVjGoEngRSs8KN56sq9ZDhs79wFbUgNduNp1CMxAZ2c0ag6JoKFFcWeK+neaajtqptk3Bi5TWPvN+/7zlUEAFevANJTFWB5oT+L0kDvcAzN81obVeXlV8bKJStvDEaS/0BIfLdGB5wQtX3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtmK3vgV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d162eef54so2668692b3a.3;
        Sun, 11 Aug 2024 17:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723423515; x=1724028315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbRmhbNDendOFf8nrjOw/0Fu21zJqvWxF1f2vW0roNA=;
        b=XtmK3vgVg3SW0uLf4eSMO5Sty/izXzh3pJ1xj2XbmLsu1htLbX41Zq6p0QOCwBpCy5
         ZUUJryt8LMFUgKX1TogSnhu4m21tWH/8cf2OFLTbyxXjps/bYIXgKB04VXJ0uKg+Y5fu
         RtKonmBSDe3gtGGmv0RVB3X5D6GU7iCrLXj3FcJqmgR6bsD3lYZynQl5NP4+9JZcyAtg
         xtSFkrGLDGoZ0aRD5A0mjtAFLrC7zfHKobPKABbkP1+QWYtxYX9fy/Wu76uYd5Ppxr68
         Xx2i7JuEV9jUGT+6GnbAaGYHPfzhs8RzTMSQh4qvp3n8y0ejW+LnwT9AVck6YTPpL+zb
         tqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723423515; x=1724028315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbRmhbNDendOFf8nrjOw/0Fu21zJqvWxF1f2vW0roNA=;
        b=oJEmxJy1A7/yn2cR13zBLKsApXYsX1Yj92cJDmRB0eEFNMzpGbJd548JldqIFKHO+Q
         Ypx1iM67A9e1YBdQNgOLHRtqQK+HlSS7QXz0GHmd1Uz/AnEGGZ9wjB6Hu3E5wwfUm1b3
         zPAO7mKWYW4HAyYZ81ssnhCrubHeLmeVux1KDf6XpXlG9No7cnDjsDYruSDUlTI7ZZcd
         7SfZNUI3VtKH3aarpqNhG8cIoljw++kxoRm2ARBGaFO7krf3ZVqNueu1F6auC3VAJZyv
         17zSHkuHocUJVwBthhjd/U2OjPqgRjXw2de+qpCuBwMz6E3TbINur8mjIlFOQjgRTEaV
         3+rg==
X-Forwarded-Encrypted: i=1; AJvYcCWZwUTxZXGABlFby+FqW+YlNoQjCmRN38I+VVwCWRl1gALwbv0KnffekYLWId4uUwD68G4CuraF5xWCrdLXz1jZx3EYSUxNjsCnLDZNc+xuUDMwfttmGaH7z+Ayvx93/d7iKwYZs+9+bZe4PnaB0zt/cX5AaVbtYzPX0UZi
X-Gm-Message-State: AOJu0YyARkAm6Ee47dslCn1qdi/ncXOPkf/gLuhnU5XR9xl+idGxxbZ7
	zRZMecx2Tfu11ZRvKhpl4qp8e8v5wLWTG1QCN7HVoMNfWHHhOvE=
X-Google-Smtp-Source: AGHT+IGWK30a56PuFgw7Kk7S1d8hP89balINAIevhENKCLnwV8gOVxn8CMRIiz0ADzp8Z+6DXLiYug==
X-Received: by 2002:a05:6a00:10d0:b0:70d:3777:da8b with SMTP id d2e1a72fcca58-710dc9a32a2mr5653887b3a.25.1723423514779;
        Sun, 11 Aug 2024 17:45:14 -0700 (PDT)
Received: from vagrant.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58ade4fsm2891966b3a.51.2024.08.11.17.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:45:14 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Yipeng Zou <zouyipeng@huawei.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [bpf-next 1/3] selftests/bpf: migrate tracepoint overhead test to prog_tests
Date: Mon, 12 Aug 2024 00:45:01 +0000
Message-ID: <20240812004503.43206-2-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812004503.43206-1-danieltimlee@gmail.com>
References: <20240812004503.43206-1-danieltimlee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the cleanup of outdated test cases in sample/bpf, this
commit migrates test for tracepoint overhead to selftest prog_tests.

The test_overhead in selftest/bpf focus on the 'raw_tracepoint' only,
and do not cover tracepoint-specific tests. To support this, this
commit utilize 'vmlinux.h', and additional test program for tracepoint
has been added.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 .../selftests/bpf/prog_tests/test_overhead.c       | 14 +++++++++++++-
 tools/testing/selftests/bpf/progs/test_overhead.c  | 11 +++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_overhead.c b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
index f27013e38d03..06153602a859 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_overhead.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
@@ -61,9 +61,10 @@ void test_test_overhead(void)
 	const char *raw_tp_name = "prog3";
 	const char *fentry_name = "prog4";
 	const char *fexit_name = "prog5";
+	const char *tp_name = "prog6";
 	const char *kprobe_func = "__set_task_comm";
 	struct bpf_program *kprobe_prog, *kretprobe_prog, *raw_tp_prog;
-	struct bpf_program *fentry_prog, *fexit_prog;
+	struct bpf_program *fentry_prog, *fexit_prog, *tp_prog;
 	struct bpf_object *obj;
 	struct bpf_link *link;
 	int err, duration = 0;
@@ -96,6 +97,10 @@ void test_test_overhead(void)
 	if (CHECK(!fexit_prog, "find_probe",
 		  "prog '%s' not found\n", fexit_name))
 		goto cleanup;
+	tp_prog = bpf_object__find_program_by_name(obj, tp_name);
+	if (CHECK(!tp_prog, "find_probe",
+		  "prog '%s' not found\n", tp_name))
+		goto cleanup;
 	err = bpf_object__load(obj);
 	if (CHECK(err, "obj_load", "err %d\n", err))
 		goto cleanup;
@@ -142,6 +147,13 @@ void test_test_overhead(void)
 	test_run("fexit");
 	bpf_link__destroy(link);
 
+	/* attach tp */
+	link = bpf_program__attach_tracepoint(tp_prog, "task", "task_rename");
+	if (!ASSERT_OK_PTR(link, "attach_tp"))
+		goto cleanup;
+	test_run("tp");
+	bpf_link__destroy(link);
+
 cleanup:
 	prctl(PR_SET_NAME, comm, 0L, 0L, 0L);
 	bpf_object__close(obj);
diff --git a/tools/testing/selftests/bpf/progs/test_overhead.c b/tools/testing/selftests/bpf/progs/test_overhead.c
index abb7344b531f..6dc1f68180e0 100644
--- a/tools/testing/selftests/bpf/progs/test_overhead.c
+++ b/tools/testing/selftests/bpf/progs/test_overhead.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
-#include <stdbool.h>
-#include <stddef.h>
-#include <linux/bpf.h>
-#include <linux/ptrace.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
@@ -39,4 +36,10 @@ int BPF_PROG(prog5, struct task_struct *tsk, const char *buf, bool exec)
 	return 0;
 }
 
+SEC("tracepoint/task/task_rename")
+int prog6(struct trace_event_raw_task_rename *ctx)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


