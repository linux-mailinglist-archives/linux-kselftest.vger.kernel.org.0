Return-Path: <linux-kselftest+bounces-48372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DFBCFBBCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 03:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F1A1311F8E9
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 02:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDBF253950;
	Wed,  7 Jan 2026 02:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nb7H5lRU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5821E246BC7
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752792; cv=none; b=NDORoEL9efjAdwln8SPb/ZbMbcwW+gxWzQlKGfhE8D5gIuqxNs4FaxFfDj1KjO7har1wWuF/rxWBo8tKQMaqt+mb1G3IAvLOx6QHj89qSxa95f1j+PliZo8jjdu3eCJ/UvS/jvGYD1z4ZRAB96/XSYnHrkQzXWAbnD7iRAHMuNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752792; c=relaxed/simple;
	bh=pSpX9BDHndA8BkwLbnT8yUfgALM3o7O6L9FBFQxFFrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O45fD0rwtsasluN5Ze88lsW41ibCABC4yoQnfcCc/cxzeNUxU4ovx5w1EUiSnw/9D8BlZwmiRESUDaPpjwbw+blb8SHVPrG8H3+lbFr1Ul6B0DYlp6sB3H9uj5+Z6ik/aTAodnRVhSM1PwBikxfggzVWxZNRvsEwEJswR0dTV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nb7H5lRU; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767752788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBJD/n9/2fLTfY2pW96rS4FJpOq5ZjubJAJBt8Nb/PA=;
	b=Nb7H5lRUXUI7csIUNoa0zXX3SQZFWEhFaZE4BETXgEt3iYs7vSnDrSfTW1h0nunt8JMVRP
	62WdtLoiOdGmGVi4DAxEmFrBZ+Tbz40udM5Zv65nvtAjlanT3c8FaoC8hQMKaSVCFDlCQL
	ZUbkfSlucHWTu/JbnGF8u9/XOlU66as=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Tao Chen <chen.dylane@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Tobias Klauser <tklauser@distanz.ch>,
	Rong Tao <rongtao@cestc.cn>,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v13 7/7] selftests/bpf: Add cases to test BPF_F_CPU and BPF_F_ALL_CPUS flags
Date: Wed,  7 Jan 2026 10:20:22 +0800
Message-ID: <20260107022022.12843-8-leon.hwang@linux.dev>
In-Reply-To: <20260107022022.12843-1-leon.hwang@linux.dev>
References: <20260107022022.12843-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add test coverage for the new BPF_F_CPU and BPF_F_ALL_CPUS flags support
in percpu maps. The following APIs are exercised:

* bpf_map_update_batch()
* bpf_map_lookup_batch()
* bpf_map_update_elem()
* bpf_map__update_elem()
* bpf_map_lookup_elem_flags()
* bpf_map__lookup_elem()

For lru_percpu_hash map, set max_entries to
'libbpf_num_possible_cpus() + 1' and only use the first
'libbpf_num_possible_cpus()' entries. This ensures a spare entry is always
available in the LRU free list, avoiding eviction.

When updating an existing key in lru_percpu_hash map:

1. l_new = prealloc_lru_pop();  /* Borrow from free list */
2. l_old = lookup_elem_raw();   /* Found, key exists */
3. pcpu_copy_value();           /* In-place update */
4. bpf_lru_push_free();         /* Return l_new to free list */

Also add negative tests to verify that non-percpu array and hash maps
reject the BPF_F_CPU and BPF_F_ALL_CPUS flags.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 328 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_alloc_array.c  |  32 ++
 2 files changed, 360 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 343da65864d6..c1d0949f093f 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "cgroup_helpers.h"
 #include "percpu_alloc_array.skel.h"
 #include "percpu_alloc_cgrp_local_storage.skel.h"
 #include "percpu_alloc_fail.skel.h"
@@ -115,6 +116,321 @@ static void test_failure(void) {
 	RUN_TESTS(percpu_alloc_fail);
 }
 
+static void test_percpu_map_op_cpu_flag(struct bpf_map *map, void *keys, size_t key_sz, u32 entries,
+					int nr_cpus, bool test_batch)
+{
+	size_t value_sz = sizeof(u32), value_sz_cpus, value_sz_total;
+	u32 *values = NULL, *values_percpu = NULL;
+	const u32 value = 0xDEADC0DE;
+	int i, j, cpu, map_fd, err;
+	u64 batch = 0, flags;
+	void *values_row;
+	u32 count, v;
+	LIBBPF_OPTS(bpf_map_batch_opts, batch_opts);
+
+	value_sz_cpus = value_sz * nr_cpus;
+	values = calloc(entries, value_sz_cpus);
+	if (!ASSERT_OK_PTR(values, "calloc values"))
+		return;
+
+	values_percpu = calloc(entries, roundup(value_sz, 8) * nr_cpus);
+	if (!ASSERT_OK_PTR(values_percpu, "calloc values_percpu")) {
+		free(values);
+		return;
+	}
+
+	value_sz_total = value_sz_cpus * entries;
+	memset(values, 0, value_sz_total);
+
+	map_fd = bpf_map__fd(map);
+	flags = BPF_F_CPU | BPF_F_ALL_CPUS;
+	err = bpf_map_lookup_elem_flags(map_fd, keys, values, flags);
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem_flags cpu|all_cpus"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, keys, values, flags);
+	if (!ASSERT_ERR(err, "bpf_map_update_elem cpu|all_cpus"))
+		goto out;
+
+	flags = BPF_F_ALL_CPUS;
+	err = bpf_map_lookup_elem_flags(map_fd, keys, values, flags);
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem_flags all_cpus"))
+		goto out;
+
+	flags = BPF_F_LOCK | BPF_F_CPU;
+	err = bpf_map_lookup_elem_flags(map_fd, keys, values, flags);
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem_flags BPF_F_LOCK"))
+		goto out;
+
+	flags = BPF_F_LOCK | BPF_F_ALL_CPUS;
+	err = bpf_map_update_elem(map_fd, keys, values, flags);
+	if (!ASSERT_ERR(err, "bpf_map_update_elem BPF_F_LOCK"))
+		goto out;
+
+	flags = (u64)nr_cpus << 32 | BPF_F_CPU;
+	err = bpf_map_update_elem(map_fd, keys, values, flags);
+	if (!ASSERT_EQ(err, -ERANGE, "bpf_map_update_elem -ERANGE"))
+		goto out;
+
+	err = bpf_map__update_elem(map, keys, key_sz, values, value_sz, flags);
+	if (!ASSERT_EQ(err, -ERANGE, "bpf_map__update_elem -ERANGE"))
+		goto out;
+
+	err = bpf_map_lookup_elem_flags(map_fd, keys, values, flags);
+	if (!ASSERT_EQ(err, -ERANGE, "bpf_map_lookup_elem_flags -ERANGE"))
+		goto out;
+
+	err = bpf_map__lookup_elem(map, keys, key_sz, values, value_sz, flags);
+	if (!ASSERT_EQ(err, -ERANGE, "bpf_map__lookup_elem -ERANGE"))
+		goto out;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		/* clear value on all cpus */
+		values[0] = 0;
+		flags = BPF_F_ALL_CPUS;
+		for (i = 0; i < entries; i++) {
+			err = bpf_map__update_elem(map, keys + i * key_sz, key_sz, values,
+						   value_sz, flags);
+			if (!ASSERT_OK(err, "bpf_map__update_elem all_cpus"))
+				goto out;
+		}
+
+		/* update value on specified cpu */
+		for (i = 0; i < entries; i++) {
+			values[0] = value;
+			flags = (u64)cpu << 32 | BPF_F_CPU;
+			err = bpf_map__update_elem(map, keys + i * key_sz, key_sz, values,
+						   value_sz, flags);
+			if (!ASSERT_OK(err, "bpf_map__update_elem specified cpu"))
+				goto out;
+
+			/* lookup then check value on CPUs */
+			for (j = 0; j < nr_cpus; j++) {
+				flags = (u64)j << 32 | BPF_F_CPU;
+				err = bpf_map__lookup_elem(map, keys + i * key_sz, key_sz, values,
+							   value_sz, flags);
+				if (!ASSERT_OK(err, "bpf_map__lookup_elem specified cpu"))
+					goto out;
+				if (!ASSERT_EQ(values[0], j != cpu ? 0 : value,
+					       "bpf_map__lookup_elem value on specified cpu"))
+					goto out;
+			}
+		}
+	}
+
+	if (!test_batch)
+		goto out;
+
+	count = entries;
+	batch_opts.elem_flags = (u64)nr_cpus << 32 | BPF_F_CPU;
+	err = bpf_map_update_batch(map_fd, keys, values, &count, &batch_opts);
+	if (!ASSERT_EQ(err, -ERANGE, "bpf_map_update_batch -ERANGE"))
+		goto out;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		memset(values, 0, value_sz_total);
+
+		/* clear values across all CPUs */
+		count = entries;
+		batch_opts.elem_flags = BPF_F_ALL_CPUS;
+		err = bpf_map_update_batch(map_fd, keys, values, &count, &batch_opts);
+		if (!ASSERT_OK(err, "bpf_map_update_batch all_cpus"))
+			goto out;
+
+		/* update values on specified CPU */
+		for (i = 0; i < entries; i++)
+			values[i] = value;
+
+		count = entries;
+		batch_opts.elem_flags = (u64)cpu << 32 | BPF_F_CPU;
+		err = bpf_map_update_batch(map_fd, keys, values, &count, &batch_opts);
+		if (!ASSERT_OK(err, "bpf_map_update_batch specified cpu"))
+			goto out;
+
+		/* lookup values on specified CPU */
+		batch = 0;
+		count = entries;
+		memset(values, 0, entries * value_sz);
+		err = bpf_map_lookup_batch(map_fd, NULL, &batch, keys, values, &count, &batch_opts);
+		if (!ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_lookup_batch specified cpu"))
+			goto out;
+
+		for (i = 0; i < entries; i++)
+			if (!ASSERT_EQ(values[i], value,
+				       "bpf_map_lookup_batch value on specified cpu"))
+				goto out;
+
+		/* lookup values from all CPUs */
+		batch = 0;
+		count = entries;
+		batch_opts.elem_flags = 0;
+		memset(values_percpu, 0, roundup(value_sz, 8) * nr_cpus * entries);
+		err = bpf_map_lookup_batch(map_fd, NULL, &batch, keys, values_percpu, &count,
+					   &batch_opts);
+		if (!ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_lookup_batch all_cpus"))
+			goto out;
+
+		for (i = 0; i < entries; i++) {
+			values_row = (void *) values_percpu +
+				     roundup(value_sz, 8) * i * nr_cpus;
+			for (j = 0; j < nr_cpus; j++) {
+				v = *(u32 *) (values_row + roundup(value_sz, 8) * j);
+				if (!ASSERT_EQ(v, j != cpu ? 0 : value,
+					       "bpf_map_lookup_batch value all_cpus"))
+					goto out;
+			}
+		}
+	}
+
+out:
+	free(values_percpu);
+	free(values);
+}
+
+
+static void test_percpu_map_cpu_flag(enum bpf_map_type map_type)
+{
+	struct percpu_alloc_array *skel;
+	size_t key_sz = sizeof(int);
+	int *keys, nr_cpus, i, err;
+	struct bpf_map *map;
+	u32 max_entries;
+
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	max_entries = nr_cpus + 1;
+	keys = calloc(max_entries, key_sz);
+	if (!ASSERT_OK_PTR(keys, "calloc keys"))
+		return;
+
+	for (i = 0; i < max_entries; i++)
+		keys[i] = i;
+
+	skel = percpu_alloc_array__open();
+	if (!ASSERT_OK_PTR(skel, "percpu_alloc_array__open")) {
+		free(keys);
+		return;
+	}
+
+	map = skel->maps.percpu;
+	bpf_map__set_type(map, map_type);
+	bpf_map__set_max_entries(map, max_entries);
+
+	err = percpu_alloc_array__load(skel);
+	if (!ASSERT_OK(err, "test_percpu_alloc__load"))
+		goto out;
+
+	test_percpu_map_op_cpu_flag(map, keys, key_sz, max_entries - 1, nr_cpus, true);
+out:
+	percpu_alloc_array__destroy(skel);
+	free(keys);
+}
+
+static void test_percpu_array_cpu_flag(void)
+{
+	test_percpu_map_cpu_flag(BPF_MAP_TYPE_PERCPU_ARRAY);
+}
+
+static void test_percpu_hash_cpu_flag(void)
+{
+	test_percpu_map_cpu_flag(BPF_MAP_TYPE_PERCPU_HASH);
+}
+
+static void test_lru_percpu_hash_cpu_flag(void)
+{
+	test_percpu_map_cpu_flag(BPF_MAP_TYPE_LRU_PERCPU_HASH);
+}
+
+static void test_percpu_cgroup_storage_cpu_flag(void)
+{
+	struct percpu_alloc_array *skel = NULL;
+	struct bpf_cgroup_storage_key key;
+	int cgroup, prog_fd, nr_cpus, err;
+	struct bpf_map *map;
+
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		return;
+
+	cgroup = create_and_get_cgroup("/cg_percpu");
+	if (!ASSERT_GE(cgroup, 0, "create_and_get_cgroup")) {
+		cleanup_cgroup_environment();
+		return;
+	}
+
+	err = join_cgroup("/cg_percpu");
+	if (!ASSERT_OK(err, "join_cgroup"))
+		goto out;
+
+	skel = percpu_alloc_array__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "percpu_alloc_array__open_and_load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.cgroup_egress);
+	err = bpf_prog_attach(prog_fd, cgroup, BPF_CGROUP_INET_EGRESS, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	map = skel->maps.percpu_cgroup_storage;
+	err = bpf_map_get_next_key(bpf_map__fd(map), NULL, &key);
+	if (!ASSERT_OK(err, "bpf_map_get_next_key"))
+		goto out;
+
+	test_percpu_map_op_cpu_flag(map, &key, sizeof(key), 1, nr_cpus, false);
+out:
+	bpf_prog_detach2(-1, cgroup, BPF_CGROUP_INET_EGRESS);
+	close(cgroup);
+	cleanup_cgroup_environment();
+	percpu_alloc_array__destroy(skel);
+}
+
+static void test_map_op_cpu_flag(enum bpf_map_type map_type)
+{
+	u32 max_entries = 1, count = max_entries;
+	u64 flags, batch = 0, val = 0;
+	int err, map_fd, key = 0;
+	LIBBPF_OPTS(bpf_map_batch_opts, batch_opts);
+
+	map_fd = bpf_map_create(map_type, "test_cpu_flag", sizeof(int), sizeof(u64), max_entries,
+				NULL);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
+		return;
+
+	flags = BPF_F_ALL_CPUS;
+	err = bpf_map_update_elem(map_fd, &key, &val, flags);
+	ASSERT_ERR(err, "bpf_map_update_elem all_cpus");
+
+	batch_opts.elem_flags = BPF_F_ALL_CPUS;
+	err = bpf_map_update_batch(map_fd, &key, &val, &count, &batch_opts);
+	ASSERT_ERR(err, "bpf_map_update_batch all_cpus");
+
+	flags = BPF_F_CPU;
+	err = bpf_map_lookup_elem_flags(map_fd, &key, &val, flags);
+	ASSERT_ERR(err, "bpf_map_lookup_elem_flags cpu");
+
+	batch_opts.elem_flags = BPF_F_CPU;
+	err = bpf_map_lookup_batch(map_fd, NULL, &batch, &key, &val, &count, &batch_opts);
+	ASSERT_ERR(err, "bpf_map_lookup_batch cpu");
+
+	close(map_fd);
+}
+
+static void test_array_cpu_flag(void)
+{
+	test_map_op_cpu_flag(BPF_MAP_TYPE_ARRAY);
+}
+
+static void test_hash_cpu_flag(void)
+{
+	test_map_op_cpu_flag(BPF_MAP_TYPE_HASH);
+}
+
 void test_percpu_alloc(void)
 {
 	if (test__start_subtest("array"))
@@ -125,4 +441,16 @@ void test_percpu_alloc(void)
 		test_cgrp_local_storage();
 	if (test__start_subtest("failure_tests"))
 		test_failure();
+	if (test__start_subtest("cpu_flag_percpu_array"))
+		test_percpu_array_cpu_flag();
+	if (test__start_subtest("cpu_flag_percpu_hash"))
+		test_percpu_hash_cpu_flag();
+	if (test__start_subtest("cpu_flag_lru_percpu_hash"))
+		test_lru_percpu_hash_cpu_flag();
+	if (test__start_subtest("cpu_flag_percpu_cgroup_storage"))
+		test_percpu_cgroup_storage_cpu_flag();
+	if (test__start_subtest("cpu_flag_array"))
+		test_array_cpu_flag();
+	if (test__start_subtest("cpu_flag_hash"))
+		test_hash_cpu_flag();
 }
diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_array.c b/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
index 37c2d2608ec0..ed6a2a93d5a5 100644
--- a/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
@@ -187,4 +187,36 @@ int BPF_PROG(test_array_map_10)
 	return 0;
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, u32);
+} percpu SEC(".maps");
+
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(test_percpu_array, int x)
+{
+	u64 value = 0xDEADC0DE;
+	int key = 0;
+
+	bpf_map_update_elem(&percpu, &key, &value, BPF_ANY);
+	return 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, u32);
+} percpu_cgroup_storage SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int cgroup_egress(struct __sk_buff *skb)
+{
+	u32 *val = bpf_get_local_storage(&percpu_cgroup_storage, 0);
+
+	*val = 1;
+	return 1;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0


