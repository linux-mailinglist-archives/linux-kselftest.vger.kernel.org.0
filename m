Return-Path: <linux-kselftest+bounces-8150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 320028A6DB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE9F1B25583
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D46137929;
	Tue, 16 Apr 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEnSi6sE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D69712F5B7;
	Tue, 16 Apr 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276667; cv=none; b=b6CtMCfSoqxVc9hVkjkuYTP8tz7LwigzrI6UzN4Sh4CH2RBGXqpF7FRlnWzf1EJOWqBCYi0jlO60hWRxDuNnOY8m9YjyjaHefu5k257g35K+1vn6ryadOQgwVx33IonZ52PvEXrG0KTfi8MpLnXycS4dLFOu3hwZXH7IecVNqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276667; c=relaxed/simple;
	bh=gnbd2RQ+3wctyheUyU6clAJleG99mpq90RdQg9GTbNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NhcpVKHa3p76w8dc8cWL6v7UD1utHYb59uYVa0fzmTzlrVIOWaeWlX02y3YPvn5mdjP0K6RPqB8xx/L89du39EyLW8E/6G2eHVjzu4yJO2FUg2QCMqXG7r/bF6En18c6yts/aLD/YqBl5ksor9uSYl8ChaCgxkJdEseJxr77+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEnSi6sE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF52C4AF08;
	Tue, 16 Apr 2024 14:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276666;
	bh=gnbd2RQ+3wctyheUyU6clAJleG99mpq90RdQg9GTbNQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BEnSi6sEfEy4ETnuX2tyAlbFU3a2WhICTdSAAhJc6cCjoZRYho6M2iM4SyMD0JWx5
	 QDIj9dD9GSmaPzfHCOcY64foFkxrK3fgSys79boI6ku3nDRxelSuBKDG5j7/Y2Tpdw
	 Drg2xd/5jxoeOm/xQ40GkZQwZdd+0ExD0a4bJCIRkDCT0+Gt5DC9I7wtGTlBWeONfz
	 epxg69KPorBQJBigXSF7VwNJdMFomIQpedr/fCtoIBPfLJ6JK3JOB/SaQIqOfViqRP
	 cb7vjD9GI1pHp3NvkqECm3QQwY0b+kQAOC7mVFECeg9uazU268pcP9xa6/HI990T+S
	 aYPM0Ae6Ip5EQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 16 Apr 2024 16:08:31 +0200
Subject: [PATCH bpf-next 18/18] selftests/bpf: wq: add bpf_wq_start()
 checks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bpf_wq-v1-18-c9e66092f842@kernel.org>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
In-Reply-To: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=3923;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=gnbd2RQ+3wctyheUyU6clAJleG99mpq90RdQg9GTbNQ=;
 b=mzIPuuOm/lFkrF62NVNgi+3On2eJg7VFrdRf4n38fn++QOsGIWqJb9YU8tvgORWM3sVh/ni3y
 YhwFhuWpvFsCMCKYndxDhjdyGcYoMm0m90DEhYDSoSeKzREEXqbbpxO
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Allows to test if allocation/free works

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/bpf/bpf_experimental.h |  1 +
 tools/testing/selftests/bpf/prog_tests/wq.c    | 22 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/wq.c         | 22 +++++++++++++++++++---
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 272604f9c4a5..19dffa32fc08 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -471,6 +471,7 @@ extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __
 extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
 extern int bpf_wq_init(struct bpf_wq *wq, void *map, unsigned int flags) __weak __ksym;
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
index c0a094c84834..0cdb9d273e60 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -49,6 +49,11 @@ struct {
 	__type(value, struct elem);
 } lru SEC(".maps");
 
+#define CLOCK_MONOTONIC 1
+
+__u32 ok;
+__u32 ok_sleepable;
+
 static int test_elem_callback(void *map, int *key,
 		int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
 		u64 callback_flags)
@@ -56,6 +61,10 @@ static int test_elem_callback(void *map, int *key,
 	struct elem init = {}, *val;
 	struct bpf_wq *wq;
 
+	if ((ok & (1 << *key) ||
+	    (ok_sleepable & (1 << *key))))
+		return -22;
+
 	if (map == &lru &&
 	    bpf_map_update_elem(map, key, &init, 0))
 		return -1;
@@ -71,6 +80,9 @@ static int test_elem_callback(void *map, int *key,
 	if (bpf_wq_set_callback(wq, callback_fn, callback_flags))
 		return -4;
 
+	if (bpf_wq_start(wq, 0))
+		return -5;
+
 	return 0;
 }
 
@@ -81,6 +93,10 @@ static int test_hmap_elem_callback(void *map, int *key,
 	struct hmap_elem init = {}, *val;
 	struct bpf_wq *wq;
 
+	if ((ok & (1 << *key) ||
+	    (ok_sleepable & (1 << *key))))
+		return -22;
+
 	if (bpf_map_update_elem(map, key, &init, 0))
 		return -1;
 
@@ -95,12 +111,12 @@ static int test_hmap_elem_callback(void *map, int *key,
 	if (bpf_wq_set_callback(wq, callback_fn, callback_flags))
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


