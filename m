Return-Path: <linux-kselftest+bounces-36423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5FAAF73CA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3720564A42
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 12:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B012EE967;
	Thu,  3 Jul 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrsA+ZpQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15362EE617;
	Thu,  3 Jul 2025 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545096; cv=none; b=sq+uzPVTfL8RHPo3ONNmoWmt4Pe0SgeBYGAU5x68gsYbTle2bOtWgWzFyFXn6518+eE2SOdrIH4cpyKx9vZVQCM/poJC4mERTCMXsENmPDe2q55whjglefAjNjulsPDMPywH3PsYkRkM7cKzU6SwRQggRaM1aWFGkzCOwkkuzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545096; c=relaxed/simple;
	bh=ggjMWjo9dzdHc8vGV+AFBOfAHkdf49rO8nWorVjPqbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DeBB7nS9ahtbO2xz9MgcCtLAXSoglexhKTqHpzZ1LaeCUFb/Ux6zZXD892adC4vrfcHKdcLQOmhcwerNyPL/XLrFPjpaNa1wCjgaImfPSAPi2LuHijyCQqtumAKa4FmDANxxYDBzEu6PEXixz2rmY/UkUPwoYOr6YQyTDqKlkJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrsA+ZpQ; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-748e63d4b05so3582407b3a.2;
        Thu, 03 Jul 2025 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545093; x=1752149893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81yxCIGAi+pZiTG+ZtQqhKBsE1y3xIl6UxS2rPadYt8=;
        b=QrsA+ZpQlH8yPkQm1et8ZLIQWxFtIpvj2S1r8nJ+6Hxz2BU4wbZgmNGYLt8XmnXvte
         IM+7Kesjlpv7tD4CdmCDlF970mrOfVWHK1yijAR0YpoZOGT35dNo46XjFO/Q9Y9Akz9M
         uqr9TRzBoqR7Jh52/FLWnDaU2FF+mqtw3re8JdPmQuy2+YJQ2kQ7Uq1uo1dKfEFSv0Cy
         yoWThtlQNvw88695D4LIQVm66du+qwFSt0L5olEiZHf+/mzmWqN14tVK8OxGHleeFYqc
         xKz2WiOqMze37m/mGM2YgQHvyaZ0t8pFamoypK/YmJfjBIjEsvPh62japOAm7jyzTrlG
         nlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545093; x=1752149893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81yxCIGAi+pZiTG+ZtQqhKBsE1y3xIl6UxS2rPadYt8=;
        b=vmxJUAb2FtqVWTUWqOLgUH/S1dH6f9jZmr3zwJlihgPA1GI4xNlAc6oiPF2OUc3ayx
         w9U2APLDCicX7iaRa6FXcoQVBmNNBeS+WI43YNBgO63IWzsk1TP0dFpu7AvmpmrOy+Vt
         NJQKFMVw9guLOqpoD1nF1Gu/McPmSJRTqPhI/YjlGjODqL6IDpmLIEpVLgxxzxPBLJrp
         IZbkOiSJEzEzVAPe2CcvI+soN4kRu4vFYhK28jd1P608cK1xdlA98bzj+jm7EY32mRwp
         N3Uu+pORkIQwpvt3NQQ7qxyD8XGaVnX9N905efDRnccvF857JAN9ZuaVqg20KDM+i4vv
         P76g==
X-Forwarded-Encrypted: i=1; AJvYcCW6hCP+P0+u8TZdiWXbQPospgzuechhAI16QylbghUgk8O8kcyiigVXUYf7bzrZAj5FWFepxCtBf8Rrh8Y=@vger.kernel.org, AJvYcCWgoSmf7+vnlNkDYRbB5AKg67CYEEAdTi8s2eJ2mhzK7rY6a2NMRcIbR7dVIymnE0iEKvG1aU7fEzzSCcIZPOW5@vger.kernel.org
X-Gm-Message-State: AOJu0YzESEH7gTvgllozQsJa+TY2scX948EAyC1kCFkpeQBmicf+nrWh
	NCmtXIDd9dbLjnAF8hgREzbL1F7JyzEVKoNqljDi3md0vGVlLM4KlbQ6
X-Gm-Gg: ASbGncuAV4OsAVod4Pf1YbugkkPeZFICRU1D9NFbJsgnndYH3LDefxL9MFmmilO3oIf
	a/F1ymrKSS7evPcxCM4AFmHRXlZeIfFrRxh6fPaQeuWXrvm/f+RqYEBj7YRKSXpNAUV6d1kJdZn
	3e86LFHBHQsrwj6JGTR77VfFZ325dArEeSrtzTsXUVsgTRDGFt06Fmm7engEmOizheimk7/uSgt
	oOChzOjDjZGSG0bkw6pz0DM+nmYXIekYflKa8kVriI5G8JYUJdpmD7g/GqqxOBVZ8aqnm3svHje
	4KkZ7eWGhkkrMiU6jZ1ubwlKZz591rbqvmti3nALWs8MNsMhgyZZT9C4E+woXFlCdelF5gPX8II
	LcXg=
X-Google-Smtp-Source: AGHT+IEeULaBlyscxQYttwhGr76vxRO967SQxsaj9KakTVjPulR/8ZvydQtW7zfOnBO+trZkmhwoHQ==
X-Received: by 2002:a05:6a00:1823:b0:749:8c3:873e with SMTP id d2e1a72fcca58-74b513efdebmr8967270b3a.24.1751545092970;
        Thu, 03 Jul 2025 05:18:12 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:18:12 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Mykola Lysenko <mykolal@fb.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next v2 17/18] selftests/bpf: add basic testcases for tracing_multi
Date: Thu,  3 Jul 2025 20:15:20 +0800
Message-Id: <20250703121521.1874196-18-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we add some testcases for the following attach types:

BPF_TRACE_FENTRY_MULTI
BPF_TRACE_FEXIT_MULTI
BPF_MODIFY_RETURN_MULTI

We reuse the testings in fentry_test.c, fexit_test.c and modify_return.c
by attach the tracing bpf prog as tracing_multi.

We add some functions to skip for tracing progs to bpf_get_ksyms(). The
functions that in the "btf_id_deny" should be skipped. What's more, the
kernel can't find the right function address according to the btf type id
when duplicated function name exist. So we skip such functions that we
meet. The list is not whole, so we still can fail during attaching the
FENTRY_MULTI to all the kernel functions. This is something that we need
to fix in the feature.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  22 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |  79 +++++--
 .../selftests/bpf/prog_tests/fexit_test.c     |  79 +++++--
 .../selftests/bpf/prog_tests/modify_return.c  |  60 +++++
 .../bpf/prog_tests/tracing_multi_link.c       | 210 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_multi_empty.c  |  13 ++
 .../selftests/bpf/progs/tracing_multi_test.c  | 181 +++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  24 ++
 tools/testing/selftests/bpf/test_progs.c      |  50 +++++
 tools/testing/selftests/bpf/test_progs.h      |   3 +
 tools/testing/selftests/bpf/trace_helpers.c   |  69 ++++++
 12 files changed, 744 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi_link.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_multi_empty.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_test.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4863106034df..1fa0da096262 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -496,7 +496,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
 		test_usdt.skel.h
 
-LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
+LSKELS := fexit_sleep.c atomics.c 		\
 	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
 	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
index 130f5b82d2e6..84cc8b669684 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
@@ -1,32 +1,32 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
-#include "fentry_test.lskel.h"
-#include "fexit_test.lskel.h"
+#include "fentry_test.skel.h"
+#include "fexit_test.skel.h"
 
 void test_fentry_fexit(void)
 {
-	struct fentry_test_lskel *fentry_skel = NULL;
-	struct fexit_test_lskel *fexit_skel = NULL;
+	struct fentry_test *fentry_skel = NULL;
+	struct fexit_test *fexit_skel = NULL;
 	__u64 *fentry_res, *fexit_res;
 	int err, prog_fd, i;
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 
-	fentry_skel = fentry_test_lskel__open_and_load();
+	fentry_skel = fentry_test__open_and_load();
 	if (!ASSERT_OK_PTR(fentry_skel, "fentry_skel_load"))
 		goto close_prog;
-	fexit_skel = fexit_test_lskel__open_and_load();
+	fexit_skel = fexit_test__open_and_load();
 	if (!ASSERT_OK_PTR(fexit_skel, "fexit_skel_load"))
 		goto close_prog;
 
-	err = fentry_test_lskel__attach(fentry_skel);
+	err = fentry_test__attach(fentry_skel);
 	if (!ASSERT_OK(err, "fentry_attach"))
 		goto close_prog;
-	err = fexit_test_lskel__attach(fexit_skel);
+	err = fexit_test__attach(fexit_skel);
 	if (!ASSERT_OK(err, "fexit_attach"))
 		goto close_prog;
 
-	prog_fd = fexit_skel->progs.test1.prog_fd;
+	prog_fd = bpf_program__fd(fexit_skel->progs.test1);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "ipv6 test_run");
 	ASSERT_OK(topts.retval, "ipv6 test retval");
@@ -40,6 +40,6 @@ void test_fentry_fexit(void)
 	}
 
 close_prog:
-	fentry_test_lskel__destroy(fentry_skel);
-	fexit_test_lskel__destroy(fexit_skel);
+	fentry_test__destroy(fentry_skel);
+	fexit_test__destroy(fexit_skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_test.c b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
index aee1bc77a17f..9edd383feabd 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
@@ -1,26 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
-#include "fentry_test.lskel.h"
+#include "fentry_test.skel.h"
 #include "fentry_many_args.skel.h"
 
-static int fentry_test_common(struct fentry_test_lskel *fentry_skel)
+static int fentry_test_check(struct fentry_test *fentry_skel)
 {
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	int err, prog_fd, i;
-	int link_fd;
 	__u64 *result;
-	LIBBPF_OPTS(bpf_test_run_opts, topts);
-
-	err = fentry_test_lskel__attach(fentry_skel);
-	if (!ASSERT_OK(err, "fentry_attach"))
-		return err;
 
-	/* Check that already linked program can't be attached again. */
-	link_fd = fentry_test_lskel__test1__attach(fentry_skel);
-	if (!ASSERT_LT(link_fd, 0, "fentry_attach_link"))
-		return -1;
-
-	prog_fd = fentry_skel->progs.test1.prog_fd;
+	prog_fd = bpf_program__fd(fentry_skel->progs.test1);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(topts.retval, 0, "test_run");
@@ -31,7 +21,28 @@ static int fentry_test_common(struct fentry_test_lskel *fentry_skel)
 			return -1;
 	}
 
-	fentry_test_lskel__detach(fentry_skel);
+	return 0;
+}
+
+static int fentry_test_common(struct fentry_test *fentry_skel)
+{
+	struct bpf_link *link;
+	int err;
+
+	err = fentry_test__attach(fentry_skel);
+	if (!ASSERT_OK(err, "fentry_attach"))
+		return err;
+
+	/* Check that already linked program can't be attached again. */
+	link = bpf_program__attach(fentry_skel->progs.test1);
+	if (!ASSERT_ERR_PTR(link, "fentry_attach_link"))
+		return -1;
+
+	err = fentry_test_check(fentry_skel);
+	if (!ASSERT_OK(err, "fentry_test_check"))
+		return err;
+
+	fentry_test__detach(fentry_skel);
 
 	/* zero results for re-attach test */
 	memset(fentry_skel->bss, 0, sizeof(*fentry_skel->bss));
@@ -40,10 +51,10 @@ static int fentry_test_common(struct fentry_test_lskel *fentry_skel)
 
 static void fentry_test(void)
 {
-	struct fentry_test_lskel *fentry_skel = NULL;
+	struct fentry_test *fentry_skel = NULL;
 	int err;
 
-	fentry_skel = fentry_test_lskel__open_and_load();
+	fentry_skel = fentry_test__open_and_load();
 	if (!ASSERT_OK_PTR(fentry_skel, "fentry_skel_load"))
 		goto cleanup;
 
@@ -55,7 +66,7 @@ static void fentry_test(void)
 	ASSERT_OK(err, "fentry_second_attach");
 
 cleanup:
-	fentry_test_lskel__destroy(fentry_skel);
+	fentry_test__destroy(fentry_skel);
 }
 
 static void fentry_many_args(void)
@@ -84,10 +95,42 @@ static void fentry_many_args(void)
 	fentry_many_args__destroy(fentry_skel);
 }
 
+static void fentry_multi_test(void)
+{
+	struct fentry_test *fentry_skel = NULL;
+	int err, prog_cnt;
+
+	fentry_skel = fentry_test__open();
+	if (!ASSERT_OK_PTR(fentry_skel, "fentry_skel_open"))
+		goto cleanup;
+
+	prog_cnt = sizeof(fentry_skel->progs) / sizeof(long);
+	err = bpf_to_tracing_multi((void *)&fentry_skel->progs, prog_cnt);
+	if (!ASSERT_OK(err, "fentry_to_multi"))
+		goto cleanup;
+
+	err = fentry_test__load(fentry_skel);
+	if (!ASSERT_OK(err, "fentry_skel_load"))
+		goto cleanup;
+
+	err = bpf_attach_as_tracing_multi((void *)&fentry_skel->progs,
+					  prog_cnt,
+					  (void *)&fentry_skel->links);
+	if (!ASSERT_OK(err, "fentry_attach_multi"))
+		goto cleanup;
+
+	err = fentry_test_check(fentry_skel);
+	ASSERT_OK(err, "fentry_first_attach");
+cleanup:
+	fentry_test__destroy(fentry_skel);
+}
+
 void test_fentry_test(void)
 {
 	if (test__start_subtest("fentry"))
 		fentry_test();
+	if (test__start_subtest("fentry_multi"))
+		fentry_multi_test();
 	if (test__start_subtest("fentry_many_args"))
 		fentry_many_args();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_test.c b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
index 1c13007e37dd..5652d02b3ad9 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
@@ -1,26 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
-#include "fexit_test.lskel.h"
+#include "fexit_test.skel.h"
 #include "fexit_many_args.skel.h"
 
-static int fexit_test_common(struct fexit_test_lskel *fexit_skel)
+static int fexit_test_check(struct fexit_test *fexit_skel)
 {
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	int err, prog_fd, i;
-	int link_fd;
 	__u64 *result;
-	LIBBPF_OPTS(bpf_test_run_opts, topts);
-
-	err = fexit_test_lskel__attach(fexit_skel);
-	if (!ASSERT_OK(err, "fexit_attach"))
-		return err;
 
-	/* Check that already linked program can't be attached again. */
-	link_fd = fexit_test_lskel__test1__attach(fexit_skel);
-	if (!ASSERT_LT(link_fd, 0, "fexit_attach_link"))
-		return -1;
-
-	prog_fd = fexit_skel->progs.test1.prog_fd;
+	prog_fd = bpf_program__fd(fexit_skel->progs.test1);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(topts.retval, 0, "test_run");
@@ -31,7 +21,28 @@ static int fexit_test_common(struct fexit_test_lskel *fexit_skel)
 			return -1;
 	}
 
-	fexit_test_lskel__detach(fexit_skel);
+	return 0;
+}
+
+static int fexit_test_common(struct fexit_test *fexit_skel)
+{
+	struct bpf_link *link;
+	int err;
+
+	err = fexit_test__attach(fexit_skel);
+	if (!ASSERT_OK(err, "fexit_attach"))
+		return err;
+
+	/* Check that already linked program can't be attached again. */
+	link = bpf_program__attach(fexit_skel->progs.test1);
+	if (!ASSERT_ERR_PTR(link, "fexit_attach_link"))
+		return -1;
+
+	err = fexit_test_check(fexit_skel);
+	if (!ASSERT_OK(err, "fexit_test_check"))
+		return err;
+
+	fexit_test__detach(fexit_skel);
 
 	/* zero results for re-attach test */
 	memset(fexit_skel->bss, 0, sizeof(*fexit_skel->bss));
@@ -40,10 +51,10 @@ static int fexit_test_common(struct fexit_test_lskel *fexit_skel)
 
 static void fexit_test(void)
 {
-	struct fexit_test_lskel *fexit_skel = NULL;
+	struct fexit_test *fexit_skel = NULL;
 	int err;
 
-	fexit_skel = fexit_test_lskel__open_and_load();
+	fexit_skel = fexit_test__open_and_load();
 	if (!ASSERT_OK_PTR(fexit_skel, "fexit_skel_load"))
 		goto cleanup;
 
@@ -55,7 +66,7 @@ static void fexit_test(void)
 	ASSERT_OK(err, "fexit_second_attach");
 
 cleanup:
-	fexit_test_lskel__destroy(fexit_skel);
+	fexit_test__destroy(fexit_skel);
 }
 
 static void fexit_many_args(void)
@@ -84,10 +95,42 @@ static void fexit_many_args(void)
 	fexit_many_args__destroy(fexit_skel);
 }
 
+static void fexit_test_multi(void)
+{
+	struct fexit_test *fexit_skel = NULL;
+	int err, prog_cnt;
+
+	fexit_skel = fexit_test__open();
+	if (!ASSERT_OK_PTR(fexit_skel, "fexit_skel_open"))
+		goto cleanup;
+
+	prog_cnt = sizeof(fexit_skel->progs) / sizeof(long);
+	err = bpf_to_tracing_multi((void *)&fexit_skel->progs, prog_cnt);
+	if (!ASSERT_OK(err, "fexit_to_multi"))
+		goto cleanup;
+
+	err = fexit_test__load(fexit_skel);
+	if (!ASSERT_OK(err, "fexit_skel_load"))
+		goto cleanup;
+
+	err = bpf_attach_as_tracing_multi((void *)&fexit_skel->progs,
+					  prog_cnt,
+					  (void *)&fexit_skel->links);
+	if (!ASSERT_OK(err, "fexit_attach_multi"))
+		goto cleanup;
+
+	err = fexit_test_check(fexit_skel);
+	ASSERT_OK(err, "fexit_first_attach");
+cleanup:
+	fexit_test__destroy(fexit_skel);
+}
+
 void test_fexit_test(void)
 {
 	if (test__start_subtest("fexit"))
 		fexit_test();
+	if (test__start_subtest("fexit_multi"))
+		fexit_test_multi();
 	if (test__start_subtest("fexit_many_args"))
 		fexit_many_args();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
index a70c99c2f8c8..3ca454379e90 100644
--- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -49,6 +49,56 @@ static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
 	modify_return__destroy(skel);
 }
 
+static void run_multi_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
+{
+	struct modify_return *skel = NULL;
+	int err, prog_fd, prog_cnt;
+	__u16 side_effect;
+	__s16 ret;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = modify_return__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	/* stack function args is not supported by tracing multi-link yet,
+	 * so we only enable the bpf progs without stack function args.
+	 */
+	bpf_program__set_expected_attach_type(skel->progs.fentry_test,
+					      BPF_TRACE_FENTRY_MULTI);
+	bpf_program__set_expected_attach_type(skel->progs.fexit_test,
+					      BPF_TRACE_FEXIT_MULTI);
+	bpf_program__set_expected_attach_type(skel->progs.fmod_ret_test,
+					      BPF_MODIFY_RETURN_MULTI);
+
+	err = modify_return__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	prog_cnt = sizeof(skel->progs) / sizeof(long);
+	err = bpf_attach_as_tracing_multi((void *)&skel->progs,
+					  prog_cnt,
+					  (void *)&skel->links);
+	if (!ASSERT_OK(err, "modify_return__attach failed"))
+		goto cleanup;
+
+	skel->bss->input_retval = input_retval;
+	prog_fd = bpf_program__fd(skel->progs.fmod_ret_test);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	side_effect = UPPER(topts.retval);
+	ret = LOWER(topts.retval);
+
+	ASSERT_EQ(ret, want_ret, "test_run ret");
+	ASSERT_EQ(side_effect, want_side_effect, "modify_return side_effect");
+	ASSERT_EQ(skel->bss->fentry_result, 1, "modify_return fentry_result");
+	ASSERT_EQ(skel->bss->fexit_result, 1, "modify_return fexit_result");
+	ASSERT_EQ(skel->bss->fmod_ret_result, 1, "modify_return fmod_ret_result");
+cleanup:
+	modify_return__destroy(skel);
+}
+
 /* TODO: conflict with get_func_ip_test */
 void serial_test_modify_return(void)
 {
@@ -59,3 +109,13 @@ void serial_test_modify_return(void)
 		 0 /* want_side_effect */,
 		 -EINVAL * 2 /* want_ret */);
 }
+
+void serial_test_modify_return_multi(void)
+{
+	run_multi_test(0 /* input_retval */,
+		       2 /* want_side_effect */,
+		       33 /* want_ret */);
+	run_multi_test(-EINVAL /* input_retval */,
+		       1 /* want_side_effect */,
+		       -EINVAL + 29 /* want_ret */);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi_link.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi_link.c
new file mode 100644
index 000000000000..1cbe6089472f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi_link.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+
+#include <test_progs.h>
+
+#include "tracing_multi_test.skel.h"
+#include "fentry_multi_empty.skel.h"
+
+static void test_run(struct tracing_multi_test *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	skel->bss->pid = getpid();
+	prog_fd = bpf_program__fd(skel->progs.fentry_cookie_test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	ASSERT_EQ(skel->bss->fentry_test1_result, 1, "fentry_test1_result");
+	ASSERT_EQ(skel->bss->fentry_test2_result, 1, "fentry_test2_result");
+	ASSERT_EQ(skel->bss->fentry_test3_result, 1, "fentry_test3_result");
+	ASSERT_EQ(skel->bss->fentry_test4_result, 1, "fentry_test4_result");
+	ASSERT_EQ(skel->bss->fentry_test5_result, 1, "fentry_test5_result");
+	ASSERT_EQ(skel->bss->fentry_test6_result, 1, "fentry_test6_result");
+	ASSERT_EQ(skel->bss->fentry_test7_result, 1, "fentry_test7_result");
+	ASSERT_EQ(skel->bss->fentry_test8_result, 1, "fentry_test8_result");
+}
+
+static void test_skel_auto_api(void)
+{
+	struct tracing_multi_test *skel;
+	int err;
+
+	skel = tracing_multi_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_test__open_and_load"))
+		return;
+
+	/* disable all programs that should fail */
+	bpf_program__set_autoattach(skel->progs.fentry_fail_test1, false);
+	bpf_program__set_autoattach(skel->progs.fentry_fail_test2, false);
+	bpf_program__set_autoattach(skel->progs.fentry_fail_test3, false);
+	bpf_program__set_autoattach(skel->progs.fentry_fail_test4, false);
+	bpf_program__set_autoattach(skel->progs.fentry_fail_test5, false);
+	bpf_program__set_autoattach(skel->progs.fentry_fail_test6, false);
+
+	bpf_program__set_autoattach(skel->progs.fexit_fail_test1, false);
+	bpf_program__set_autoattach(skel->progs.fexit_fail_test2, false);
+	bpf_program__set_autoattach(skel->progs.fexit_fail_test3, false);
+
+	err = tracing_multi_test__attach(skel);
+	if (!ASSERT_OK(err, "tracing_multi_test__attach"))
+		goto cleanup;
+
+	test_run(skel);
+
+cleanup:
+	tracing_multi_test__destroy(skel);
+}
+
+static int attach_bpf(struct bpf_program *prog, struct bpf_link **link_ptr,
+		       bool success)
+{
+	struct bpf_link *link;
+	int err;
+
+	link = bpf_program__attach(prog);
+	err = libbpf_get_error(link);
+	if (!ASSERT_OK(success ? err : !err, "attach_bpf"))
+		return err;
+	*link_ptr = link;
+
+	return 0;
+}
+
+#define attach_skel_bpf(name, success) \
+	attach_bpf(skel->progs.name, &skel->links.name, success)
+
+static void test_skel_manual_api(void)
+{
+	struct tracing_multi_test *skel;
+
+	skel = tracing_multi_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_test__open_and_load"))
+		return;
+
+	if (attach_skel_bpf(fentry_success_test1, true) ||
+	    attach_skel_bpf(fentry_success_test2, true) ||
+	    attach_skel_bpf(fentry_success_test3, true) ||
+	    attach_skel_bpf(fentry_success_test4, true) ||
+	    attach_skel_bpf(fexit_success_test1, true) ||
+	    attach_skel_bpf(fexit_success_test2, true) ||
+	    attach_skel_bpf(fentry_fail_test1, false) ||
+	    attach_skel_bpf(fentry_fail_test2, false) ||
+	    attach_skel_bpf(fentry_fail_test3, false) ||
+	    attach_skel_bpf(fentry_fail_test4, false) ||
+	    attach_skel_bpf(fentry_fail_test5, false) ||
+	    attach_skel_bpf(fentry_fail_test6, false) ||
+	    attach_skel_bpf(fexit_fail_test1, false) ||
+	    attach_skel_bpf(fexit_fail_test2, false) ||
+	    attach_skel_bpf(fexit_fail_test3, false) ||
+	    attach_skel_bpf(fentry_cookie_test1, true))
+		goto cleanup;
+
+	test_run(skel);
+
+cleanup:
+	tracing_multi_test__destroy(skel);
+}
+
+static void test_attach_api(void)
+{
+	LIBBPF_OPTS(bpf_trace_multi_opts, opts);
+	struct tracing_multi_test *skel;
+	struct bpf_link *link;
+	const char *syms[8] = {
+		"bpf_fentry_test1",
+		"bpf_fentry_test2",
+		"bpf_fentry_test3",
+		"bpf_fentry_test4",
+		"bpf_fentry_test5",
+		"bpf_fentry_test6",
+		"bpf_fentry_test7",
+		"bpf_fentry_test8",
+	};
+	__u64 cookies[] = {1, 7, 2, 3, 4, 5, 6, 8};
+
+	skel = tracing_multi_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_test__open_and_load"))
+		return;
+
+	opts.syms = syms;
+	opts.cookies = cookies;
+	opts.cnt = ARRAY_SIZE(syms);
+	link = bpf_program__attach_trace_multi_opts(skel->progs.fentry_cookie_test1,
+						    &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_trace_multi_opts"))
+		goto cleanup;
+	skel->links.fentry_cookie_test1 = link;
+
+	skel->bss->test_cookie = true;
+	test_run(skel);
+cleanup:
+	tracing_multi_test__destroy(skel);
+}
+
+static void test_attach_bench(bool kernel)
+{
+	LIBBPF_OPTS(bpf_trace_multi_opts, opts);
+	struct fentry_multi_empty *skel;
+	long attach_start_ns, attach_end_ns;
+	long detach_start_ns, detach_end_ns;
+	double attach_delta, detach_delta;
+	struct bpf_link *link = NULL;
+	char **syms = NULL;
+	size_t cnt = 0;
+
+	if (!ASSERT_OK(bpf_get_ksyms(&syms, &cnt, kernel), "get_syms"))
+		return;
+
+	skel = fentry_multi_empty__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_multi_empty__open_and_load"))
+		goto cleanup;
+
+	opts.syms = (const char **) syms;
+	opts.cnt = cnt;
+	opts.skip_invalid = true;
+
+	attach_start_ns = get_time_ns();
+	link = bpf_program__attach_trace_multi_opts(skel->progs.fentry_multi_empty,
+						    &opts);
+	attach_end_ns = get_time_ns();
+
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_trace_multi_opts"))
+		return;
+
+	detach_start_ns = get_time_ns();
+	bpf_link__destroy(link);
+	detach_end_ns = get_time_ns();
+
+	attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
+	detach_delta = (detach_end_ns - detach_start_ns) / 1000000000.0;
+
+	printf("%s: found %lu functions\n", __func__, opts.cnt);
+	printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
+	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
+
+cleanup:
+	fentry_multi_empty__destroy(skel);
+	if (syms)
+		free(syms);
+}
+
+void serial_test_tracing_multi_attach_bench(void)
+{
+	if (test__start_subtest("kernel"))
+		test_attach_bench(true);
+	if (test__start_subtest("modules"))
+		test_attach_bench(false);
+}
+
+void test_tracing_multi_attach_test(void)
+{
+	if (test__start_subtest("skel_auto_api"))
+		test_skel_auto_api();
+	if (test__start_subtest("skel_manual_api"))
+		test_skel_manual_api();
+	if (test__start_subtest("attach_api"))
+		test_attach_api();
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_multi_empty.c b/tools/testing/selftests/bpf/progs/fentry_multi_empty.c
new file mode 100644
index 000000000000..a09ba216dff8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_multi_empty.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fentry.multi/bpf_fentry_test1")
+int BPF_PROG(fentry_multi_empty)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_test.c b/tools/testing/selftests/bpf/progs/tracing_multi_test.c
new file mode 100644
index 000000000000..fa27851896b9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_test.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct bpf_testmod_struct_arg_1 {
+	int a;
+};
+struct bpf_testmod_struct_arg_2 {
+	long a;
+	long b;
+};
+
+__u64 test_result = 0;
+
+int pid = 0;
+int test_cookie = 0;
+
+__u64 fentry_test1_result = 0;
+__u64 fentry_test2_result = 0;
+__u64 fentry_test3_result = 0;
+__u64 fentry_test4_result = 0;
+__u64 fentry_test5_result = 0;
+__u64 fentry_test6_result = 0;
+__u64 fentry_test7_result = 0;
+__u64 fentry_test8_result = 0;
+
+extern const void bpf_fentry_test1 __ksym;
+extern const void bpf_fentry_test2 __ksym;
+extern const void bpf_fentry_test3 __ksym;
+extern const void bpf_fentry_test4 __ksym;
+extern const void bpf_fentry_test5 __ksym;
+extern const void bpf_fentry_test6 __ksym;
+extern const void bpf_fentry_test7 __ksym;
+extern const void bpf_fentry_test8 __ksym;
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_13")
+int BPF_PROG2(fentry_success_test1, struct bpf_testmod_struct_arg_2, a)
+{
+	test_result = a.a + a.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_10")
+int BPF_PROG2(fentry_success_test2, int, a, struct bpf_testmod_struct_arg_2, b)
+{
+	test_result = a + b.a + b.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_4")
+int BPF_PROG2(fentry_success_test3, struct bpf_testmod_struct_arg_2, a, int, b,
+	      int, c)
+{
+	test_result = c;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_2")
+int BPF_PROG2(fentry_success_test4, struct bpf_testmod_struct_arg_2, a, int, b,
+	      int, c)
+{
+	test_result = c;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_1")
+int BPF_PROG2(fentry_fail_test1, struct bpf_testmod_struct_arg_2, a)
+{
+	test_result = a.a + a.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_2")
+int BPF_PROG2(fentry_fail_test2, struct bpf_testmod_struct_arg_2, a)
+{
+	test_result = a.a + a.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_4")
+int BPF_PROG2(fentry_fail_test3, struct bpf_testmod_struct_arg_2, a)
+{
+	test_result = a.a + a.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_2")
+int BPF_PROG2(fentry_fail_test4, int, a, struct bpf_testmod_struct_arg_2, b)
+{
+	test_result = a + b.a + b.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_13")
+int BPF_PROG2(fentry_fail_test5, int, a, struct bpf_testmod_struct_arg_2, b)
+{
+	test_result = a + b.a + b.b;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_12")
+int BPF_PROG2(fentry_fail_test6, struct bpf_testmod_struct_arg_2, a, int, b,
+	      int, c)
+{
+	test_result = c;
+	return 0;
+}
+
+SEC("fexit.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_3")
+int BPF_PROG2(fexit_success_test1, struct bpf_testmod_struct_arg_2, a, int, b,
+	      int, c, int, retval)
+{
+	test_result = retval;
+	return 0;
+}
+
+SEC("fexit.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_12")
+int BPF_PROG2(fexit_success_test2, int, a, struct bpf_testmod_struct_arg_2, b,
+	      int, c, int, retval)
+{
+	test_result = a + b.a + b.b + retval;
+	return 0;
+}
+
+SEC("fexit.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_4")
+int BPF_PROG2(fexit_fail_test1, struct bpf_testmod_struct_arg_2, a, int, b,
+	      int, c, int, retval)
+{
+	test_result = retval;
+	return 0;
+}
+
+SEC("fexit.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_10")
+int BPF_PROG2(fexit_fail_test2, int, a, struct bpf_testmod_struct_arg_2, b,
+	      int, c, int, retval)
+{
+	test_result = a + b.a + b.b + retval;
+	return 0;
+}
+
+SEC("fexit.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_11")
+int BPF_PROG2(fexit_fail_test3, int, a, struct bpf_testmod_struct_arg_2, b,
+	      int, c, int, retval)
+{
+	test_result = a + b.a + b.b + retval;
+	return 0;
+}
+
+static void tracing_multi_check_cookie(unsigned long long *ctx)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return;
+
+	__u64 cookie = test_cookie ? bpf_get_attach_cookie(ctx) : 0;
+	__u64 addr = bpf_get_func_ip(ctx);
+
+#define SET(__var, __addr, __cookie) ({			\
+	if (((const void *) addr == __addr) &&		\
+	     (!test_cookie || (cookie == __cookie)))	\
+		__var = 1;				\
+})
+	SET(fentry_test1_result, &bpf_fentry_test1, 1);
+	SET(fentry_test2_result, &bpf_fentry_test2, 7);
+	SET(fentry_test3_result, &bpf_fentry_test3, 2);
+	SET(fentry_test4_result, &bpf_fentry_test4, 3);
+	SET(fentry_test5_result, &bpf_fentry_test5, 4);
+	SET(fentry_test6_result, &bpf_fentry_test6, 5);
+	SET(fentry_test7_result, &bpf_fentry_test7, 6);
+	SET(fentry_test8_result, &bpf_fentry_test8, 8);
+}
+
+SEC("fentry.multi/bpf_fentry_test1,bpf_fentry_test2,bpf_fentry_test3,bpf_fentry_test4,bpf_fentry_test5,bpf_fentry_test6,bpf_fentry_test7,bpf_fentry_test8")
+int BPF_PROG(fentry_cookie_test1)
+{
+	tracing_multi_check_cookie(ctx);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e9e918cdf31f..07ea1d5d3795 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -128,6 +128,30 @@ bpf_testmod_test_struct_arg_9(u64 a, void *b, short c, int d, void *e, char f,
 	return bpf_testmod_test_struct_arg_result;
 }
 
+noinline int
+bpf_testmod_test_struct_arg_10(int a, struct bpf_testmod_struct_arg_2 b) {
+	bpf_testmod_test_struct_arg_result = a + b.a + b.b;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline struct bpf_testmod_struct_arg_2 *
+bpf_testmod_test_struct_arg_11(int a, struct bpf_testmod_struct_arg_2 b, int c) {
+	bpf_testmod_test_struct_arg_result = a + b.a + b.b + c;
+	return (void *)bpf_testmod_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_test_struct_arg_12(int a, struct bpf_testmod_struct_arg_2 b, int *c) {
+	bpf_testmod_test_struct_arg_result = a + b.a + b.b + *c;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_test_struct_arg_13(struct bpf_testmod_struct_arg_2 b) {
+	bpf_testmod_test_struct_arg_result = b.a + b.b;
+	return bpf_testmod_test_struct_arg_result;
+}
+
 noinline int
 bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmod_struct_arg_1 *a) {
 	bpf_testmod_test_struct_arg_result = a->a;
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 309d9d4a8ace..533b714f1ca6 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -667,6 +667,56 @@ int bpf_find_map(const char *test, struct bpf_object *obj, const char *name)
 	return bpf_map__fd(map);
 }
 
+int bpf_to_tracing_multi(struct bpf_program **progs, int prog_cnt)
+{
+	enum bpf_attach_type type;
+	int i, err;
+
+	for (i = 0; i < prog_cnt; i++) {
+		type = bpf_program__get_expected_attach_type(progs[i]);
+		if (type == BPF_TRACE_FENTRY)
+			type = BPF_TRACE_FENTRY_MULTI;
+		else if (type == BPF_TRACE_FEXIT)
+			type = BPF_TRACE_FEXIT_MULTI;
+		else if (type == BPF_MODIFY_RETURN)
+			type = BPF_MODIFY_RETURN_MULTI;
+		else
+			continue;
+		err = bpf_program__set_expected_attach_type(progs[i], type);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+int bpf_attach_as_tracing_multi(struct bpf_program **progs, int prog_cnt,
+				struct bpf_link **link)
+{
+	struct bpf_link *__link;
+	int err, type;
+
+	for (int i = 0; i < prog_cnt; i++) {
+		LIBBPF_OPTS(bpf_trace_multi_opts, opts);
+
+		type = bpf_program__get_expected_attach_type(progs[i]);
+		if (type != BPF_TRACE_FENTRY_MULTI &&
+		    type != BPF_TRACE_FEXIT_MULTI &&
+		    type != BPF_MODIFY_RETURN_MULTI)
+			continue;
+
+		opts.attach_tracing = true;
+		__link = bpf_program__attach_trace_multi_opts(progs[i], &opts);
+		err = libbpf_get_error(link);
+		if (err)
+			return err;
+
+		link[i] = __link;
+	}
+
+	return 0;
+}
+
 int compare_map_keys(int map1_fd, int map2_fd)
 {
 	__u32 key, next_key;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index df2222a1806f..7e30c6dbf35c 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -496,6 +496,9 @@ int trigger_module_test_write(int write_sz);
 int write_sysctl(const char *sysctl, const char *value);
 int get_bpf_max_tramp_links_from(struct btf *btf);
 int get_bpf_max_tramp_links(void);
+int bpf_to_tracing_multi(struct bpf_program **progs, int prog_cnt);
+int bpf_attach_as_tracing_multi(struct bpf_program **progs, int prog_cnt,
+				struct bpf_link **link);
 
 struct netns_obj;
 struct netns_obj *netns_new(const char *name, bool open);
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index d24baf244d1f..a9e9dd3be226 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -559,6 +559,75 @@ static bool skip_entry(char *name)
 	if (!strncmp(name, "__ftrace_invalid_address__",
 		     sizeof("__ftrace_invalid_address__") - 1))
 		return true;
+
+	/* skip functions in "btf_id_deny" */
+	if (!strcmp(name, "migrate_disable"))
+		return true;
+	if (!strcmp(name, "migrate_enable"))
+		return true;
+	if (!strcmp(name, "rcu_read_unlock_strict"))
+		return true;
+	if (!strcmp(name, "preempt_count_add"))
+		return true;
+	if (!strcmp(name, "preempt_count_sub"))
+		return true;
+	if (!strcmp(name, "__rcu_read_lock"))
+		return true;
+	if (!strcmp(name, "__rcu_read_unlock"))
+		return true;
+
+	/* Following symbols have multi definition in kallsyms, take
+	 * "t_next" for example:
+	 *
+	 *     ffffffff813c10d0 t t_next
+	 *     ffffffff813d31b0 t t_next
+	 *     ffffffff813e06b0 t t_next
+	 *     ffffffff813eb360 t t_next
+	 *     ffffffff81613360 t t_next
+	 *
+	 * but only one of them have corresponding mrecord:
+	 *     ffffffff81613364 t_next
+	 *
+	 * The kernel search the target function address by the symbol
+	 * name "t_next" with kallsyms_lookup_name() during attaching
+	 * and the function "0xffffffff813c10d0" can be matched, which
+	 * doesn't have a corresponding mrecord. And this will make
+	 * the attach failing. Skip the functions like this.
+	 *
+	 * The list maybe not whole, so we still can fail......We need a
+	 * way to make the whole things right. Yes, we need fix it :/
+	 */
+	if (!strcmp(name, "kill_pid_usb_asyncio"))
+		return true;
+	if (!strcmp(name, "t_next"))
+		return true;
+	if (!strcmp(name, "t_stop"))
+		return true;
+	if (!strcmp(name, "t_start"))
+		return true;
+	if (!strcmp(name, "p_next"))
+		return true;
+	if (!strcmp(name, "p_stop"))
+		return true;
+	if (!strcmp(name, "p_start"))
+		return true;
+	if (!strcmp(name, "mem32_serial_out"))
+		return true;
+	if (!strcmp(name, "mem32_serial_in"))
+		return true;
+	if (!strcmp(name, "io_serial_in"))
+		return true;
+	if (!strcmp(name, "io_serial_out"))
+		return true;
+	if (!strcmp(name, "event_callback"))
+		return true;
+	if (!strcmp(name, "amd_pmu_init"))
+		return true;
+	if (!strcmp(name, "sync_regs"))
+		return true;
+	if (!strcmp(name, "empty"))
+		return true;
+
 	return false;
 }
 
-- 
2.39.5


