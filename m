Return-Path: <linux-kselftest+bounces-25163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C927A1C223
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 09:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C707A4815
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 08:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343B52080C6;
	Sat, 25 Jan 2025 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oopEPD05"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE36207DF4;
	Sat, 25 Jan 2025 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737793457; cv=none; b=m004eCUx4gAzMCzf6IfRMWP+ge0v6T2BCxfKSY/aSCl25WGKaWpRUjbitIu5NeYNZGe9Ym1Rk67KG5PD/dIXUXwTqZBzZ6gmL9BGPo0YvbUlOyovdIgrrYcQf7J/2KRMLsx2Os7FIRdidoWKCWhDACLPYm/dzw2MOwQF6vDXke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737793457; c=relaxed/simple;
	bh=dmQ9GUwd3bRLMUoNF6xVMku1hiH2jSDQcoM3zSlQido=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PerM9q+C2U9ZAQASNIqrM8pGl20UUVo+P1mSES2vh5luYUbCdfQmHoeM8wi8z87s1NSyV7FxyAEuLF4TKAlVMoXAIUGvAYZ0jnEiQWkKk2xORpPyFKBcm5XRkZT7mr802ncwN6AtpoZ3RwH1t0W4CFUizi6ZQ1bDpIKRFdJCEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oopEPD05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39424C4AF0D;
	Sat, 25 Jan 2025 08:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737793456;
	bh=dmQ9GUwd3bRLMUoNF6xVMku1hiH2jSDQcoM3zSlQido=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oopEPD05r7nZebLInODX5SfpX58EFZHl15d74o9Gdy2WiiUIprcOUY9hs/MHsSAVO
	 CbKb1UM96GWrA7I4pJNJY5fZKrXceGlGQgouzFxNiaOdToyduqHg5qCoWPgCWoWQI1
	 axVizmXTN+ZbAM7MYvoLFFdABurSycnbl7+zDrOr9vdGZ67FSsgfg7uodFZHCc4oq9
	 aN/O1mMdWEZacYqQzYXd+aQuNDkqOpAjDCK0gQ8tFrqxcW1JxZC/fEUuaiu21k/j48
	 gqnag4uWUCWws0WkPW13mFUHZ9etqaFjQKf5d+XBOPDBuXWz/29vKcT+JH17Lk+tOP
	 WHVZCN68DLwLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA0BC0218C;
	Sat, 25 Jan 2025 08:24:16 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Sat, 25 Jan 2025 16:23:40 +0800
Subject: [PATCH 5/7] selftests/bpf: probe_read_kernel_dynptr test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-bpf_dynptr_probe-v1-5-c3cb121f6951@outlook.com>
References: <20250125-bpf_dynptr_probe-v1-0-c3cb121f6951@outlook.com>
In-Reply-To: <20250125-bpf_dynptr_probe-v1-0-c3cb121f6951@outlook.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4155;
 i=rsworktech@outlook.com; h=from:subject:message-id;
 bh=jMKGNsysp1i//CbcuLXLYuHvxw7b8AHz8NxNTWOsSWc=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBnlJ+qgj9hODG8k3+YiUeWSVCBC4TKYd83e1M8M
 dbcbKlDO9yJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZ5SfqgAKCRBvO5jUL8bJ
 2FE6D/94fST0WN5qmhZL/BhsuIBonemuglhhMxyAP8256Q2fVDmyZTVZXEjREalt+KKiq0ewSGO
 y4x+IwymH3P9nK3mupjParc0/wjEN1vvoSl8OatMjCHYGWvZv+HDBmZVK5fhyBIubTFWJwulzQk
 CzfKNp7yHMMvISgWol3SANl11LvDMrCQ7+U1vKK/9rfAwZL4e2wvMb/EY+tLSsl+TWJ84EA2qjh
 jOzwFTfdh9eNGNM3NPIdJqNmwYAGQlgn7xqp7JLWgG2xpuyqV0YX5vmqkzKSBgeE2RWqk/GYsHc
 vb9uS/tcwBPvQHRvckXNasgR5ox7E8hZp7SpA89e0LHAHKSwaZcAnNCE57i9RrXp6X/x/itUvBV
 bWExbzSLAr0wqFePJZ84h8/8CKlYa4pFEGv8Y/MFfpO+qv7piLE2uchLQlIOqzXiJ4ChD/Imi/X
 8hjusTIbdRQ77/TNftfMw6RBQVbi5fRigM6FhobUx3aUocCOU2FrPQ2Wd1JXK/MgQNa0WXoMzxQ
 pbIj73tMNU7u6vKVehtbG5YA7GhAXgjLi+gUxg3Z780pjKPeedOcwgAtrKBu+RBAuycfRoaaG/x
 Mg611fo0jEXm65JIo6jsT7oyU+LWAQCdWcgXFeDJt1bPuuEyVE3C3VzuRC+NOEQjFS4FnxiE47M
 YuyiDV2TNF705Sw==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/default with
 auth_id=219
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

From: Levi Zim <rsworktech@outlook.com>

This patch adds a test for probe_read_kernel_dynptr helper,
which tests reading variable length of kernel memory into a ringbuf
backed dynptr.

Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
 tools/testing/selftests/bpf/prog_tests/dynptr.c    | 40 +++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/dynptr_success.c | 38 ++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index b614a5272dfd6486e287181270a0bcf63f638344..d9a25c2873b6ed4219e063845b1caf978a7016fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -10,6 +10,7 @@ enum test_setup_type {
 	SETUP_SYSCALL_SLEEP,
 	SETUP_SKB_PROG,
 	SETUP_SKB_PROG_TP,
+	SETUP_RINGBUF,
 };
 
 static struct {
@@ -30,20 +31,37 @@ static struct {
 	{"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
 	{"test_dynptr_skb_strcmp", SETUP_SKB_PROG},
 	{"test_dynptr_skb_tp_btf", SETUP_SKB_PROG_TP},
+	{"test_probe_read_kernel_dynptr", SETUP_RINGBUF},
 };
 
+static int ringbuf_cb(void *ctx, void *data, size_t len)
+{
+	struct dynptr_success *skel = ctx;
+	const char *buf = data;
+
+	if (!ASSERT_EQ(len, skel->data->test_buf.length, "length"))
+		return -E2BIG;
+
+	if (!ASSERT_MEMEQ(buf, skel->data->test_buf.buf, len, "ringbuf_cb"))
+		return -EINVAL;
+
+	return 0;
+}
+
 static void verify_success(const char *prog_name, enum test_setup_type setup_type)
 {
+	struct ring_buffer *rb = NULL;
 	struct dynptr_success *skel;
 	struct bpf_program *prog;
 	struct bpf_link *link;
-	int err;
+	int err, ret;
 
 	skel = dynptr_success__open();
 	if (!ASSERT_OK_PTR(skel, "dynptr_success__open"))
 		return;
 
 	skel->bss->pid = getpid();
+	skel->data->test_buf.length = 8;
 
 	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
 	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
@@ -63,6 +81,24 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 
 		usleep(1);
 
+		bpf_link__destroy(link);
+		break;
+	case SETUP_RINGBUF:
+		link = bpf_program__attach(prog);
+		if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+			goto cleanup;
+
+		rb = ring_buffer__new(bpf_map__fd(skel->maps.ringbuf), ringbuf_cb, skel, NULL);
+		if (!ASSERT_OK_PTR(rb, "ring_buffer__new"))
+			goto cleanup;
+
+		usleep(1);
+
+		ret = ring_buffer__poll(rb, 5000);
+
+		if (!ASSERT_EQ(ret, 1, "ring_buffer__poll"))
+			goto cleanup;
+
 		bpf_link__destroy(link);
 		break;
 	case SETUP_SKB_PROG:
@@ -125,6 +161,8 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 	ASSERT_EQ(skel->bss->err, 0, "err");
 
 cleanup:
+	if (rb != NULL)
+		ring_buffer__free(rb);
 	dynptr_success__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index bfcc85686cf046361b451f97f4cd310a6ccdb1ed..64c698f83a37bfe924db93d36982a0a1c8defe62 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -567,3 +567,41 @@ int BPF_PROG(test_dynptr_skb_tp_btf, void *skb, void *location)
 
 	return 1;
 }
+
+#define MAX_BUFFER_LEN 20
+
+struct {
+	__u32 length;
+	char buf[MAX_BUFFER_LEN];
+} test_buf = {
+	.length = 0,
+	.buf = "0123456789abcdef",
+};
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int test_probe_read_kernel_dynptr(void *ctx)
+{
+	int copy_len = test_buf.length;
+	struct bpf_dynptr ptr;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	if (test_buf.length > MAX_BUFFER_LEN)
+		copy_len = MAX_BUFFER_LEN;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, copy_len, 0, &ptr);
+
+	if (-E2BIG != bpf_probe_read_kernel_dynptr(&ptr, 0, MAX_BUFFER_LEN + 1,
+		test_buf.buf, 0)) {
+		err = 1;
+		goto cleanup;
+	}
+
+	err = bpf_probe_read_kernel_dynptr(&ptr, 0, copy_len,
+		test_buf.buf, 0);
+
+cleanup:
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+	return 0;
+}

-- 
2.48.1



