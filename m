Return-Path: <linux-kselftest+bounces-5001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E5E85B1B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 04:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B851F21983
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 03:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7920652F68;
	Tue, 20 Feb 2024 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kIuiB9lI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4F5822C
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401098; cv=none; b=cwSRm049PRT2cJuiKyN5z+XQ04Cu1A4Ovpx39k9q0QjcUBp5GxmFG6bxLjSwQmp0Gdr1nRCydiJwFfnlSU4QLNPDXsQMv6HY/nByrHomqQUkuA+R8g7fdVifTf0qOChMOPBWZUN+2Qw/FLofbimuaVHeqi+lI/B3+NsYegRchss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401098; c=relaxed/simple;
	bh=C3elKZgirtX7W4quQAT+pcAU39WJO4TotIfoaieEyx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKr1kqQpWVbQXzAT4NL2WdX0LnIa/06xBiusTM/qBOQcLzq60ro4VZonP3EJGOQdW8+Bi2fhIAMhdIn/eP3gpbEpzQxfi6GDABWa1GMZeS+aX+hIiiH92UhO3Rk+N32o4JmwyOATLaERfDLZNx0XuCyMHvi2EVdg4aj1GqShWLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kIuiB9lI; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bba50cd318so3870486b6e.0
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 19:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708401096; x=1709005896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIatRLdxp59gkCuXn1TM1+7Ffjtt7PxZsUax3x716A4=;
        b=kIuiB9lIdHcAmrh7dG0Vq56nvrYZrneaKgR4OHzLsAQPDFu3vxmqzAxcnPso9PebQz
         n/CzyF6z2BalvIVT/7AWV48xhbKfvu9t3pCRnXEaet61okgalvSpI2ORv/FGVHiRzeLz
         +P0zujx+U6xiWpDy3w7WV8dAccKJ6UDcTWA28AVokRLkqrWuyQrvMC0a0tTKXjkKZCPB
         KPSnVeQmN6DoLSIkeRQQ13v08S1W+TTujUK0b9O2jD7RXJ4Lj8ulpD60JI24uQ1FCikU
         Xwbv3WsoPFD47cAgraO6uB90i7nk/FmEyKIO3UsY8an/awj9QzVOgq1nfneA077E2/4F
         QqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708401096; x=1709005896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIatRLdxp59gkCuXn1TM1+7Ffjtt7PxZsUax3x716A4=;
        b=hlBLRoO5Wjx10Yr8AcO5jCW+JLbvslwQe2YfDz3TD/4BQnJr+7qpVMkdzQ0JSTfxP5
         M0/OlRyKdXsyNYj88xTKoHHZQyU3BGVwoZa38PFSAbqntr7Xg5pHM2XtzFIa3jT+buXX
         ioj54BhbYWwa+p8EVQ3i9l8T130cX2If3diUn5EsjKIIqK+DUuGVw3RojNsp93Rk6J+2
         wXGCOE1qolXmFg7axvLARIXxVU88M+/p4SvHABxyZNu3o0JlpHANh9bpczBXND68w55a
         wTsY1mJths6O2zYmqpZ5INN+sGeG7MCif2H6OfTUVkr0MllPH4Yih/FE7spok+nt/+yY
         BdkA==
X-Forwarded-Encrypted: i=1; AJvYcCU036WfIlm4ta6mAmh79up0a593IlwtQ7P2fEcVK9L8Zg2XUrBRS+8/j/bCfyDNWaxnn0A38jseBm0OzQlVogJpqfJnR3TEfu/jNkg4jFL8
X-Gm-Message-State: AOJu0YxesdHFmuRihT3qt1s4ChTNzH03OfV8c+RpLUeEngTBhBsJnnzE
	eBSGSJDdTZUXavTLQbmVD9YT13i/p6dWZMcIj9dW9iESr3F7XYE1rQNNnkdZpug=
X-Google-Smtp-Source: AGHT+IGR3ZiUXeeQYK4PiqThY08Xd9MG8AmFv61MNQVpDP2MDd+C2I7YVN1xqhHQa/R/QyD8+ZbFGQ==
X-Received: by 2002:a05:6808:1646:b0:3c1:3427:fef3 with SMTP id az6-20020a056808164600b003c13427fef3mr18759661oib.48.1708401095822;
        Mon, 19 Feb 2024 19:51:35 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id jz7-20020a170903430700b001d94678a76csm5131723plb.117.2024.02.19.19.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 19:51:35 -0800 (PST)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thinker.li@gmail.com,
	dongmenglong.8@bytedance.com,
	zhoufeng.zf@bytedance.com,
	davemarchevsky@fb.com,
	dxu@dxuuu.xyz,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 5/5] selftests/bpf: add test cases for multiple attach of tracing program
Date: Tue, 20 Feb 2024 11:51:05 +0800
Message-Id: <20240220035105.34626-6-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we add the testcases for multiple attaching of tracing,
include FENTRY, FEXIT, MODIFY_RETURN.

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  49 ++++++
 .../bpf/prog_tests/tracing_multi_attach.c     | 155 ++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_test.c  |  72 ++++++++
 3 files changed, 276 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_test.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 66787e99ba1b..237eeb7daa07 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -98,12 +98,61 @@ bpf_testmod_test_struct_arg_8(u64 a, void *b, short c, int d, void *e,
 	return bpf_testmod_test_struct_arg_result;
 }
 
+noinline int
+bpf_testmod_test_struct_arg_9(struct bpf_testmod_struct_arg_2 a,
+			      struct bpf_testmod_struct_arg_1 b) {
+	bpf_testmod_test_struct_arg_result = a.a + a.b  + b.a;
+	return bpf_testmod_test_struct_arg_result;
+}
+
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
 noinline int
 bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmod_struct_arg_1 *a) {
 	bpf_testmod_test_struct_arg_result = a->a;
 	return bpf_testmod_test_struct_arg_result;
 }
 
+noinline int
+bpf_testmod_test_arg_ptr_1(struct bpf_testmod_struct_arg_1 *a) {
+	bpf_testmod_test_struct_arg_result = a->a;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_test_arg_ptr_2(struct bpf_testmod_struct_arg_2 *a) {
+	bpf_testmod_test_struct_arg_result = a->a + a->b;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_test_arg_ptr_3(int a, struct bpf_testmod_struct_arg_2 *b) {
+	bpf_testmod_test_struct_arg_result = a + b->a + b->b;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_test_arg_ptr_4(struct bpf_testmod_struct_arg_2 *a, int b) {
+	bpf_testmod_test_struct_arg_result = a->a + a->b + b;
+	return bpf_testmod_test_struct_arg_result;
+}
+
 __bpf_kfunc void
 bpf_testmod_test_mod_kfunc(int i)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi_attach.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi_attach.c
new file mode 100644
index 000000000000..6162d41cca9e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi_attach.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Bytedance. */
+
+#include <test_progs.h>
+#include "tracing_multi_test.skel.h"
+
+struct test_item {
+	char *prog;
+	char *target;
+	int attach_type;
+	bool success;
+	int link_fd;
+};
+
+static struct test_item test_items[] = {
+	{
+		.prog = "fentry_test1", .target = "bpf_testmod_test_struct_arg_9",
+		.attach_type = BPF_TRACE_FENTRY, .success = true,
+	},
+	{
+		.prog = "fentry_test1", .target = "bpf_testmod_test_struct_arg_1",
+		.attach_type = BPF_TRACE_FENTRY, .success = false,
+	},
+	{
+		.prog = "fentry_test1", .target = "bpf_testmod_test_struct_arg_2",
+		.attach_type = BPF_TRACE_FENTRY, .success = false,
+	},
+	{
+		.prog = "fentry_test1", .target = "bpf_testmod_test_arg_ptr_2",
+		.attach_type = BPF_TRACE_FENTRY, .success = false,
+	},
+	{
+		.prog = "fentry_test2", .target = "bpf_testmod_test_struct_arg_2",
+		.attach_type = BPF_TRACE_FENTRY, .success = false,
+	},
+	{
+		.prog = "fentry_test2", .target = "bpf_testmod_test_struct_arg_10",
+		.attach_type = BPF_TRACE_FENTRY, .success = true,
+	},
+	{
+		.prog = "fentry_test2", .target = "bpf_testmod_test_struct_arg_9",
+		.attach_type = BPF_TRACE_FENTRY, .success = false,
+	},
+	{
+		.prog = "fentry_test2", .target = "bpf_testmod_test_arg_ptr_3",
+		.attach_type = BPF_TRACE_FENTRY, .success = false,
+	},
+	{
+		.prog = "fentry_test3", .target = "bpf_testmod_test_arg_ptr_3",
+		.attach_type = BPF_TRACE_FENTRY, .success = false,
+	},
+	{
+		.prog = "fentry_test3", .target = "bpf_testmod_test_arg_ptr_4",
+		.attach_type = BPF_TRACE_FENTRY, .success = true,
+	},
+	{
+		.prog = "fentry_test4", .target = "bpf_testmod_test_struct_arg_4",
+		.attach_type = BPF_TRACE_FENTRY, .success = true,
+	},
+	{
+		.prog = "fentry_test4", .target = "bpf_testmod_test_struct_arg_2",
+		.attach_type = BPF_TRACE_FENTRY, .success = true,
+	},
+	{
+		.prog = "fentry_test4", .target = "bpf_testmod_test_struct_arg_12",
+		.attach_type = BPF_TRACE_FENTRY, .success = false,
+	},
+	{
+		.prog = "fexit_test1", .target = "bpf_testmod_test_struct_arg_2",
+		.attach_type = BPF_TRACE_FEXIT, .success = true,
+	},
+	{
+		.prog = "fexit_test1", .target = "bpf_testmod_test_struct_arg_3",
+		.attach_type = BPF_TRACE_FEXIT, .success = true,
+	},
+	{
+		.prog = "fexit_test1", .target = "bpf_testmod_test_struct_arg_4",
+		.attach_type = BPF_TRACE_FEXIT, .success = false,
+	},
+	{
+		.prog = "fexit_test2", .target = "bpf_testmod_test_struct_arg_10",
+		.attach_type = BPF_TRACE_FEXIT, .success = false,
+	},
+	{
+		.prog = "fexit_test2", .target = "bpf_testmod_test_struct_arg_11",
+		.attach_type = BPF_TRACE_FEXIT, .success = false,
+	},
+	{
+		.prog = "fexit_test2", .target = "bpf_testmod_test_struct_arg_12",
+		.attach_type = BPF_TRACE_FEXIT, .success = true,
+	},
+	{
+		.prog = "fmod_ret_test1", .target = "bpf_modify_return_test2",
+		.attach_type = BPF_MODIFY_RETURN, .success = true,
+	},
+};
+
+static int do_test_item(struct tracing_multi_test *skel, struct test_item *item)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+	struct bpf_program *prog;
+	int err, btf_fd = 0, btf_type_id;
+
+	err = libbpf_find_kernel_btf_id(item->target, item->attach_type,
+					&btf_fd, &btf_type_id);
+	if (!ASSERT_OK(err, "find_vmlinux_btf_id"))
+		return -1;
+
+	link_opts.target_btf_id = btf_type_id;
+	prog = bpf_object__find_program_by_name(skel->obj, item->prog);
+	if (!ASSERT_OK_PTR(prog, "find_program_by_name"))
+		return -1;
+
+	err = bpf_link_create(bpf_program__fd(prog), btf_fd, item->attach_type,
+			      &link_opts);
+	item->link_fd = err;
+	if (item->success) {
+		if (!ASSERT_GE(err, 0, "link_create"))
+			return -1;
+	} else {
+		if (!ASSERT_LT(err, 0, "link_create"))
+			return -1;
+	}
+
+	return 0;
+}
+
+void test_tracing_multi_attach(void)
+{
+	struct tracing_multi_test *skel;
+	int i = 0, err, fd;
+
+	skel = tracing_multi_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_test__open_and_load"))
+		return;
+
+	err = tracing_multi_test__attach(skel);
+	if (!ASSERT_OK(err, "tracing_multi_test__attach"))
+		goto destroy_skel;
+
+	for (; i < ARRAY_SIZE(test_items); i++) {
+		if (do_test_item(skel, &test_items[i]))
+			break;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(test_items); i++) {
+		fd = test_items[i].link_fd;
+		if (fd >= 0)
+			close(fd);
+	}
+
+	tracing_multi_test__detach(skel);
+destroy_skel:
+	tracing_multi_test__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_test.c b/tools/testing/selftests/bpf/progs/tracing_multi_test.c
new file mode 100644
index 000000000000..f1ca8b64ed16
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_test.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 ByteDance */
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
+__u64 fentry_test1_result = 0;
+SEC("fentry/bpf_testmod_test_struct_arg_1")
+int BPF_PROG2(fentry_test1, struct bpf_testmod_struct_arg_2, a)
+{
+	fentry_test1_result = a.a + a.b;
+	return 0;
+}
+
+__u64 fentry_test2_result = 0;
+SEC("fentry/bpf_testmod_test_struct_arg_2")
+int BPF_PROG2(fentry_test2, int, a, struct bpf_testmod_struct_arg_2, b)
+{
+	fentry_test2_result = a + b.a + b.b;
+	return 0;
+}
+
+__u64 fentry_test3_result = 0;
+SEC("fentry/bpf_testmod_test_arg_ptr_2")
+int BPF_PROG(fentry_test3, struct bpf_testmod_struct_arg_2 *a)
+{
+	fentry_test3_result = a->a + a->b;
+	return 0;
+}
+
+__u64 fentry_test4_result = 0;
+SEC("fentry/bpf_testmod_test_struct_arg_1")
+int BPF_PROG2(fentry_test4, struct bpf_testmod_struct_arg_2, a, int, b,
+	      int, c)
+{
+	fentry_test3_result = c;
+	return 0;
+}
+
+__u64 fexit_test1_result = 0;
+SEC("fexit/bpf_testmod_test_struct_arg_1")
+int BPF_PROG2(fexit_test1, struct bpf_testmod_struct_arg_2, a, int, b,
+	      int, c, int, retval)
+{
+	fexit_test1_result = retval;
+	return 0;
+}
+
+__u64 fexit_test2_result = 0;
+SEC("fexit/bpf_testmod_test_struct_arg_2")
+int BPF_PROG2(fexit_test2, int, a, struct bpf_testmod_struct_arg_2, b,
+	      int, c, int, retval)
+{
+	fexit_test2_result = a + b.a + b.b + retval;
+	return 0;
+}
+
+SEC("fmod_ret/bpf_modify_return_test")
+int BPF_PROG(fmod_ret_test1, int a, int *b)
+{
+	return 0;
+}
-- 
2.39.2


