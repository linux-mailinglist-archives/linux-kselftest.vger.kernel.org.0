Return-Path: <linux-kselftest+bounces-46447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B291C85A1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 16:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7923B599C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9D1326D5C;
	Tue, 25 Nov 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cz/hkvnX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055432549B
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082865; cv=none; b=P9ovF/Zts8Z2Ut3orRYKCrmJSoyUc7Rb8v3x1AJo8GeX5udSB2aih0C4k4Zxnxv7pZZaQzWdIZeadBIW4iq0Fs/sJrEtS/a2g73z1a67/waCxFvrpQQEH7rJzpQwz1lCDhU6SwJEifqHQp9b61EILigrbKyro7feHb816H18sZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082865; c=relaxed/simple;
	bh=cBe2KXtHyR0PT74TZ23ZnTf7fEywItibmG7jTJ82y8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sC4ywjAZ8GlNNAYBABCep2ZpDyjELTRRB0N9e42qqjCN1J1OdjDJBNAQhvpQ4EUfcz3g0hD4540IGW9I6GNJKAKG7MeCHDNwGMaUf/qDgalu3yWLiD/CCIAxpUtFeCwsHK84EVZ73UY07s2llqrfzi37O3iT3/I6ANGorXpnNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cz/hkvnX; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764082861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNm/oiHjXtZXQxDXHUMrktvrMjAL0D6u7psU6Ujt1O8=;
	b=Cz/hkvnXnKGoYewJ0sYcIjrVf1ED34J22GYuw3j/MlAhOdYNq+QfEpWGpB9+ow+H9Q6Cvm
	euJrASxOYb2tm9B5Xw2/iNe0UCc3aOs0L+voWWJgivQ0EK1iW9oLxt3d0HV6rcakg6SOTO
	OpqFpcEg/O94LQuhrCHNII+5mrv6TzQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	jolsa@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	shuah@kernel.org,
	kerneljasonxing@gmail.com,
	chen.dylane@linux.dev,
	willemb@google.com,
	paul.chaignon@gmail.com,
	a.s.protopopov@gmail.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	tklauser@distanz.ch,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v11 8/8] selftests/bpf: Add cases to test BPF_F_CPU and BPF_F_ALL_CPUS flags
Date: Tue, 25 Nov 2025 22:58:57 +0800
Message-ID: <20251125145857.98134-9-leon.hwang@linux.dev>
In-Reply-To: <20251125145857.98134-1-leon.hwang@linux.dev>
References: <20251125145857.98134-1-leon.hwang@linux.dev>
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

Add tests to verify that array and hash maps do not support BPF_F_CPU
and BPF_F_ALL_CPUS flags.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v10 -> v11:
 - Use libbpf_num_possible_cpus() as max_entries for lru_percpu_hash map.
 - Add BPF_EXIST to flags when update_elem() and update_batch().
---
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 335 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_alloc_array.c  |  32 ++
 2 files changed, 367 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 343da65864d6..ff31107434d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "cgroup_helpers.h"
 #include "percpu_alloc_array.skel.h"
 #include "percpu_alloc_cgrp_local_storage.skel.h"
 #include "percpu_alloc_fail.skel.h"
@@ -115,6 +116,328 @@ static void test_failure(void) {
 	RUN_TESTS(percpu_alloc_fail);
 }
 
+static void test_percpu_map_op_cpu_flag(struct bpf_map *map, void *keys, size_t key_sz,
+					u32 max_entries, bool test_batch)
+{
+	size_t value_sz = sizeof(u32), value_sz_total;
+	u32 *values = NULL, *values_percpu = NULL;
+	int i, j, cpu, map_fd, nr_cpus, err;
+	const u32 value = 0xDEADC0DE;
+	u64 batch = 0, flags;
+	void *values_row;
+	u32 count, v;
+	LIBBPF_OPTS(bpf_map_batch_opts, batch_opts);
+
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	values = calloc(max_entries, value_sz * nr_cpus);
+	if (!ASSERT_OK_PTR(values, "calloc values"))
+		return;
+
+	values_percpu = calloc(max_entries, roundup(value_sz, 8) * nr_cpus);
+	if (!ASSERT_OK_PTR(values_percpu, "calloc values_percpu")) {
+		free(values);
+		return;
+	}
+	memset(values_percpu, 0, roundup(value_sz, 8) * nr_cpus * max_entries);
+
+	value_sz_total = value_sz * nr_cpus * max_entries;
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
+
+	flags = BPF_ANY;
+	for (i = 0; i < max_entries; i++) {
+		err = bpf_map__update_elem(map, keys + i * key_sz, key_sz, values_percpu,
+					   roundup(value_sz, 8) * nr_cpus, flags);
+		if (!ASSERT_OK(err, "bpf_map__update_elem init"))
+			goto out;
+	}
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		/* clear value on all cpus */
+		values[0] = 0;
+		flags = BPF_F_ALL_CPUS | BPF_EXIST;
+		for (i = 0; i < max_entries; i++) {
+			err = bpf_map__update_elem(map, keys + i * key_sz, key_sz, values,
+						   value_sz, flags);
+			if (!ASSERT_OK(err, "bpf_map__update_elem all_cpus"))
+				goto out;
+		}
+
+		/* update value on specified cpu */
+		for (i = 0; i < max_entries; i++) {
+			values[0] = value;
+			flags = (u64)cpu << 32 | BPF_F_CPU | BPF_EXIST;
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
+	count = max_entries;
+	batch_opts.elem_flags = (u64)nr_cpus << 32 | BPF_F_CPU;
+	err = bpf_map_update_batch(map_fd, keys, values, &count, &batch_opts);
+	if (!ASSERT_EQ(err, -ERANGE, "bpf_map_update_batch -ERANGE"))
+		goto out;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		memset(values, 0, value_sz_total);
+
+		/* clear values across all CPUs */
+		count = max_entries;
+		batch_opts.elem_flags = BPF_F_ALL_CPUS | BPF_EXIST;
+		err = bpf_map_update_batch(map_fd, keys, values, &count, &batch_opts);
+		if (!ASSERT_OK(err, "bpf_map_update_batch all_cpus"))
+			goto out;
+
+		/* update values on specified CPU */
+		for (i = 0; i < max_entries; i++)
+			values[i] = value;
+
+		count = max_entries;
+		batch_opts.elem_flags = (u64)cpu << 32 | BPF_F_CPU | BPF_EXIST;
+		err = bpf_map_update_batch(map_fd, keys, values, &count, &batch_opts);
+		if (!ASSERT_OK(err, "bpf_map_update_batch specified cpu"))
+			goto out;
+
+		/* lookup values on specified CPU */
+		count = max_entries;
+		memset(values, 0, max_entries * value_sz);
+		batch_opts.elem_flags = (u64)cpu << 32 | BPF_F_CPU;
+		err = bpf_map_lookup_batch(map_fd, NULL, &batch, keys, values, &count, &batch_opts);
+		if (!ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_lookup_batch specified cpu"))
+			goto out;
+
+		for (i = 0; i < max_entries; i++)
+			if (!ASSERT_EQ(values[i], value,
+				       "bpf_map_lookup_batch value on specified cpu"))
+				goto out;
+
+		/* lookup values from all CPUs */
+		batch = 0;
+		count = max_entries;
+		batch_opts.elem_flags = 0;
+		memset(values_percpu, 0, roundup(value_sz, 8) * nr_cpus * max_entries);
+		err = bpf_map_lookup_batch(map_fd, NULL, &batch, keys, values_percpu, &count,
+					   &batch_opts);
+		if (!ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_lookup_batch all_cpus"))
+			goto out;
+
+		for (i = 0; i < max_entries; i++) {
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
+static void test_percpu_map_cpu_flag(enum bpf_map_type map_type, u32 max_entries)
+{
+	struct percpu_alloc_array *skel;
+	size_t key_sz = sizeof(int);
+	struct bpf_map *map;
+	int *keys, i, err;
+
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
+	test_percpu_map_op_cpu_flag(map, keys, key_sz, max_entries, true);
+out:
+	percpu_alloc_array__destroy(skel);
+	free(keys);
+}
+
+static void test_percpu_array_cpu_flag(void)
+{
+	test_percpu_map_cpu_flag(BPF_MAP_TYPE_PERCPU_ARRAY, 2);
+}
+
+static void test_percpu_hash_cpu_flag(void)
+{
+	test_percpu_map_cpu_flag(BPF_MAP_TYPE_PERCPU_HASH, 2);
+}
+
+static void test_lru_percpu_hash_cpu_flag(void)
+{
+	int nr_cpus = libbpf_num_possible_cpus();
+
+	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	test_percpu_map_cpu_flag(BPF_MAP_TYPE_LRU_PERCPU_HASH, nr_cpus);
+}
+
+static void test_percpu_cgroup_storage_cpu_flag(void)
+{
+	struct percpu_alloc_array *skel = NULL;
+	struct bpf_cgroup_storage_key key;
+	int cgroup, prog_fd, err;
+	struct bpf_map *map;
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
+	test_percpu_map_op_cpu_flag(map, &key, sizeof(key), 1, false);
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
@@ -125,4 +448,16 @@ void test_percpu_alloc(void)
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
2.51.2


