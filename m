Return-Path: <linux-kselftest+bounces-8549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A77E8ABA9E
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA5B1C2134B
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D615FDB3;
	Sat, 20 Apr 2024 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUvkWc2c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CCB168DD;
	Sat, 20 Apr 2024 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604224; cv=none; b=WB+F+22KGpsEmkzTfJphwPfkjIT8jJ/3SccAcpzU0ELbymLE/+3JRgFydgy0U0u1yOnqGUua4EfYoJXI83dkYfcRQyNjTfZTRWm4qc6liyb4lTMGfCDULoHTevT0vXg91OEMgsy2oGVEm9odRmmigQrHL/tiKwm0X452PtW6z5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604224; c=relaxed/simple;
	bh=qGZjFddvFTEJDUjSRhXsPI6GLpgSUvVfxQ3f8hxbt/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yr1DcGJOJGtO20luBIJdAixCJISOc58QI9TbHXq69jRMc8oyB9bAe3GOxBpj1R1gH1ayT4ZU8xcRxwkB93cPy/SSXRBBAt/t8iAkfQKwOndq7FJEKzUU5TG5VcrQNDssPpGOsl2L7DUp8PTdRWHyV9xqDOB/kuFo0GgsNC8F6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUvkWc2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AECC32781;
	Sat, 20 Apr 2024 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604223;
	bh=qGZjFddvFTEJDUjSRhXsPI6GLpgSUvVfxQ3f8hxbt/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QUvkWc2cQ5FEOPmue8gma/1Eh59rVt6IybUfRL5P+Z8VJj7EJUKsrPXTtHvfTTJ6O
	 uSRWfAsHo7/Ww2p8EDQiBKL++FsojyNJGxH0cS2S/iuXW7ilH3BTyIT8FPB2ibAEXq
	 U6Vwa/CU/YlGJchD+9SzzLjGKx6m2vrwc3Z2//K5N5Id/Oe2C0ZpO3g8bm+xasa90W
	 LTwzIy+Pp7c9CnotC696wh0elKugjISiOi+Vj/alCdQvxV/mojA2yLIjdxh42YYokq
	 mR4QaFNi3OYzgAr10pL8FNAO662Fobr6vwq3LxgEvOGHVW7YPA2CJriNvx/MAkJjkL
	 CIEnptCslDcUA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:16 +0200
Subject: [PATCH bpf-next v2 16/16] selftests/bpf: wq: add bpf_wq_start()
 checks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-16-6c986a5a741f@kernel.org>
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=3847;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=qGZjFddvFTEJDUjSRhXsPI6GLpgSUvVfxQ3f8hxbt/A=;
 b=2Wcej7WSXsHkSAUb8lqxEWFpYb5RUVi3uXOjQdo6sST1koy4R1cfkISOEH0g+Iwzv3kP0Yq4B
 Blah5GRUWv8AL4oLIzaHAffmTPL2VLj6v5yvDN+MkHQJu5rRHdEU0IJ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Allows to test if allocation/free works

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- remove #define CLOCK_MONOTONIC 1 leftover
---
 tools/testing/selftests/bpf/bpf_experimental.h |  1 +
 tools/testing/selftests/bpf/prog_tests/wq.c    | 22 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/wq.c         | 20 +++++++++++++++++---
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index b80b39f76034..93c5a6c446b3 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -471,6 +471,7 @@ extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __
 extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
+extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 		int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
 		unsigned int flags__k, void *aux__ign) __ksym;
diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 26ab69796103..8a4a91d944cc 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -6,9 +6,31 @@
 
 void serial_test_wq(void)
 {
+	struct wq *wq_skel = NULL;
+	int err, prog_fd;
+
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 
 	RUN_TESTS(wq);
+
+	/* re-run the success test to check if the timer was actually executed */
+
+	wq_skel = wq__open_and_load();
+	if (!ASSERT_OK_PTR(wq_skel, "wq_skel_load"))
+		return;
+
+	err = wq__attach(wq_skel);
+	if (!ASSERT_OK(err, "wq_attach"))
+		return;
+
+	prog_fd = bpf_program__fd(wq_skel->progs.test_syscall_array_sleepable);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	usleep(50); /* 10 usecs should be enough, but give it extra */
+
+	ASSERT_EQ(wq_skel->bss->ok_sleepable, (1 << 1), "ok_sleepable");
 }
 
 void serial_test_failures_wq(void)
diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
index f746296d32b1..8011a27a2fbd 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -49,12 +49,19 @@ struct {
 	__type(value, struct elem);
 } lru SEC(".maps");
 
+__u32 ok;
+__u32 ok_sleepable;
+
 static int test_elem_callback(void *map, int *key,
 		int (callback_fn)(void *map, int *key, struct bpf_wq *wq))
 {
 	struct elem init = {}, *val;
 	struct bpf_wq *wq;
 
+	if ((ok & (1 << *key) ||
+	    (ok_sleepable & (1 << *key))))
+		return -22;
+
 	if (map == &lru &&
 	    bpf_map_update_elem(map, key, &init, 0))
 		return -1;
@@ -70,6 +77,9 @@ static int test_elem_callback(void *map, int *key,
 	if (bpf_wq_set_callback(wq, callback_fn, 0))
 		return -4;
 
+	if (bpf_wq_start(wq, 0))
+		return -5;
+
 	return 0;
 }
 
@@ -79,6 +89,10 @@ static int test_hmap_elem_callback(void *map, int *key,
 	struct hmap_elem init = {}, *val;
 	struct bpf_wq *wq;
 
+	if ((ok & (1 << *key) ||
+	    (ok_sleepable & (1 << *key))))
+		return -22;
+
 	if (bpf_map_update_elem(map, key, &init, 0))
 		return -1;
 
@@ -93,12 +107,12 @@ static int test_hmap_elem_callback(void *map, int *key,
 	if (bpf_wq_set_callback(wq, callback_fn, 0))
 		return -4;
 
+	if (bpf_wq_start(wq, 0))
+		return -5;
+
 	return 0;
 }
 
-__u32 ok;
-__u32 ok_sleepable;
-
 /* callback for non sleepable workqueue */
 static int wq_callback(void *map, int *key, struct bpf_wq *work)
 {

-- 
2.44.0


