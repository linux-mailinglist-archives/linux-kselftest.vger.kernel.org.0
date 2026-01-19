Return-Path: <linux-kselftest+bounces-49363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5BAD3AA71
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 337843000B7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E70369992;
	Mon, 19 Jan 2026 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NB/qkgIJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF0364026
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768829776; cv=none; b=oJWNTvvqotSEBkngYpX9jm0F34OaxCqgiUSFkWfBoaemybtEZZTHzvNIFm4qJvlml5EyqqsQ9pvRoQ5UbWz6tvFuHJrqnVE2N6ZlJuMeYn4enABose34SXJbN4ahgNlV2tRzb8EPW8tCl7uBLFpTJtj/gb1WlYbFq/FCqArjIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768829776; c=relaxed/simple;
	bh=14Vd7Eb+vbfdhXwTURvxrRMSxlumxUeohOFOyp/oUBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ga9fCDYL73RAAA/v9MgUt7ln/EsaAtn/lMGDA/KZFxOMY/ugQ1/FyYJqcWjqD1aMNn5YbFRKLjOwvnHmXEnK8fWFIIWimUdPIgYmhKrUjJEG0jcOaVurDXmJr8WZ0lf7UpWmq5o6lIL/Y+PGWrdMeSDQCLXznEwZjem/hUJn12I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NB/qkgIJ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768829771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XpANsYYHLT0HCyr9qsBCOggQneOZulxMASqjwlqQmbA=;
	b=NB/qkgIJhf7S2uwiiMbpx3aFojvsWGBoHUVw+qxhLp13fyY4lAtB9fKAyWYcVphrkg8ofF
	kRdr33RWcPAvycPggbj8ck8KELeCErx+bue8N8t9KkI/aho6wns6Q1dVr3XfzN4Kotjrpj
	78pX8BK2OCUyBYoFBJ+wlYJht5V6asA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next] selftests/bpf: Harden cpu flags test for lru_percpu_hash map
Date: Mon, 19 Jan 2026 21:34:17 +0800
Message-ID: <20260119133417.19739-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

CI occasionally reports failures in the
percpu_alloc/cpu_flag_lru_percpu_hash selftest, for example:

 First test_progs failure (test_progs_no_alu32-x86_64-llvm-21):
 #264/15 percpu_alloc/cpu_flag_lru_percpu_hash
 ...
 test_percpu_map_op_cpu_flag:FAIL:bpf_map_lookup_batch value on specified cpu unexpected bpf_map_lookup_batch value on specified cpu: actual 0 != expected 3735929054

The unexpected value indicates that an element was removed from the map.
However, the test never calls delete_elem(), so the only possible cause
is LRU eviction.

This can happen when the current task migrates to another CPU: an
update_elem() triggers eviction because there is no available LRU node
on local freelist and global freelist.

Harden the test against this behavior by provisioning sufficient spare
elements. Set max_entries to 'nr_cpus * 2' and restrict the test to using
the first nr_cpus entries, ensuring that updates do not spuriously trigger
LRU eviction.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/percpu_alloc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
index c1d0949f093f..a72ae0b29f6e 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -236,6 +236,8 @@ static void test_percpu_map_op_cpu_flag(struct bpf_map *map, void *keys, size_t
 		err = bpf_map_update_batch(map_fd, keys, values, &count, &batch_opts);
 		if (!ASSERT_OK(err, "bpf_map_update_batch all_cpus"))
 			goto out;
+		if (!ASSERT_EQ(count, entries, "bpf_map_update_batch count"))
+			goto out;
 
 		/* update values on specified CPU */
 		for (i = 0; i < entries; i++)
@@ -246,6 +248,8 @@ static void test_percpu_map_op_cpu_flag(struct bpf_map *map, void *keys, size_t
 		err = bpf_map_update_batch(map_fd, keys, values, &count, &batch_opts);
 		if (!ASSERT_OK(err, "bpf_map_update_batch specified cpu"))
 			goto out;
+		if (!ASSERT_EQ(count, entries, "bpf_map_update_batch count"))
+			goto out;
 
 		/* lookup values on specified CPU */
 		batch = 0;
@@ -254,6 +258,8 @@ static void test_percpu_map_op_cpu_flag(struct bpf_map *map, void *keys, size_t
 		err = bpf_map_lookup_batch(map_fd, NULL, &batch, keys, values, &count, &batch_opts);
 		if (!ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_lookup_batch specified cpu"))
 			goto out;
+		if (!ASSERT_EQ(count, entries, "bpf_map_lookup_batch count"))
+			goto out;
 
 		for (i = 0; i < entries; i++)
 			if (!ASSERT_EQ(values[i], value,
@@ -269,6 +275,8 @@ static void test_percpu_map_op_cpu_flag(struct bpf_map *map, void *keys, size_t
 					   &batch_opts);
 		if (!ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_lookup_batch all_cpus"))
 			goto out;
+		if (!ASSERT_EQ(count, entries, "bpf_map_lookup_batch count"))
+			goto out;
 
 		for (i = 0; i < entries; i++) {
 			values_row = (void *) values_percpu +
@@ -287,7 +295,6 @@ static void test_percpu_map_op_cpu_flag(struct bpf_map *map, void *keys, size_t
 	free(values);
 }
 
-
 static void test_percpu_map_cpu_flag(enum bpf_map_type map_type)
 {
 	struct percpu_alloc_array *skel;
@@ -300,7 +307,7 @@ static void test_percpu_map_cpu_flag(enum bpf_map_type map_type)
 	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
 		return;
 
-	max_entries = nr_cpus + 1;
+	max_entries = nr_cpus * 2;
 	keys = calloc(max_entries, key_sz);
 	if (!ASSERT_OK_PTR(keys, "calloc keys"))
 		return;
@@ -322,7 +329,7 @@ static void test_percpu_map_cpu_flag(enum bpf_map_type map_type)
 	if (!ASSERT_OK(err, "test_percpu_alloc__load"))
 		goto out;
 
-	test_percpu_map_op_cpu_flag(map, keys, key_sz, max_entries - 1, nr_cpus, true);
+	test_percpu_map_op_cpu_flag(map, keys, key_sz, nr_cpus, nr_cpus, true);
 out:
 	percpu_alloc_array__destroy(skel);
 	free(keys);
-- 
2.52.0


