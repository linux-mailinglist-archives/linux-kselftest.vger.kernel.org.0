Return-Path: <linux-kselftest+bounces-46442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B148AC85A0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 16:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDE254ECCCF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7921F32573D;
	Tue, 25 Nov 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VsAjQySs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE933271F7
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082806; cv=none; b=Ay+woFUIB9AeosZMiEljbgl8nfakhZWbOP1YpDZEkUJYsvAsqrJ2lg37TB84rn3Drg3ZlCvsu3ENR++YEXjAUTokVNkp2CmUKNSwuEtdGQV0YWwORAGjSByCZMz93Jx8r8LYyaK4a5BSo7a2BXfas0aJ+vUdSMK7ChIW+fbu5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082806; c=relaxed/simple;
	bh=fF418YuTimb8Z3Chx26glSIBcfmS24386R8cPNTAvFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKIP39ho6NERPJ4M+7Hi4mwbcruTHrTgPw1wG5VqxhpF3e1Tp34M6urC791WK2NQHiCTJPUoRcqdswBBPOmGSLSIv64vOivQGGWVV0u/S+jD6jfqk3JEAObTNSqM8dTDJBYFPigmiGPAkF1Cfz/F6GPUqu5d2bJHY3FfJk2HoFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VsAjQySs; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764082802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wc2IYbjQGe/4SO1+MUzWBNyXK12I22pfzhFjWaOiii0=;
	b=VsAjQySsOWg88YQfT/wn6aF4uyZS7ux30sQgBbxKfPrNTqo1mV0mPqS2bM4Pq3iQYNI1Ux
	J6i/OyBGsfugrfz9Uz4wYiE2RUvRJ9pKQPDOm0iuzGvGmXMWGQD4MFOQ+wW3DGI3OHI5jb
	zZu0gKKs9sd8Eh/PSkm38gQR9jNAnho=
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
Subject: [PATCH bpf-next v11 3/8] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps
Date: Tue, 25 Nov 2025 22:58:52 +0800
Message-ID: <20251125145857.98134-4-leon.hwang@linux.dev>
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

Introduce support for the BPF_F_ALL_CPUS flag in percpu_array maps to
allow updating values for all CPUs with a single value for both
update_elem and update_batch APIs.

Introduce support for the BPF_F_CPU flag in percpu_array maps to allow:

* update value for specified CPU for both update_elem and update_batch
APIs.
* lookup value for specified CPU for both lookup_elem and lookup_batch
APIs.

The BPF_F_CPU flag is passed via:

* map_flags of lookup_elem and update_elem APIs along with embedded cpu
info.
* elem_flags of lookup_batch and update_batch APIs along with embedded
cpu info.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v10 -> v11:
 - Drop buggy '(u32)map_flags > BPF_F_ALL_CPUS' check in bpf_percpu_array_update().
 - Update 'map_flags == BPF_NOEXIST' to 'map_flags & BPF_NOEXIST' in bpf_percpu_array_update().
---
 include/linux/bpf.h   |  9 +++++++--
 kernel/bpf/arraymap.c | 32 ++++++++++++++++++++++++--------
 kernel/bpf/syscall.c  |  2 +-
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d84af3719b59..01a99e3a3e51 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2762,7 +2762,7 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee);
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 			   u64 flags);
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
@@ -3831,7 +3831,12 @@ bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 
 static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 {
-	return false;
+	switch (map_type) {
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1eeb31c5b317..241f11d4d62a 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -307,7 +307,7 @@ static void *percpu_array_map_lookup_percpu_elem(struct bpf_map *map, void *key,
 	return per_cpu_ptr(array->pptrs[index & array->index_mask], cpu);
 }
 
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 map_flags)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
@@ -325,11 +325,18 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		copy_map_value(map, value, per_cpu_ptr(pptr, cpu));
+		check_and_init_map_value(map, value);
+		goto unlock;
+	}
 	for_each_possible_cpu(cpu) {
 		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
 		check_and_init_map_value(map, value + off);
 		off += size;
 	}
+unlock:
 	rcu_read_unlock();
 	return 0;
 }
@@ -398,18 +405,18 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
-	int cpu, off = 0;
+	void *ptr, *val;
 	u32 size;
+	int cpu;
 
-	if (unlikely(map_flags > BPF_EXIST))
-		/* unknown flags */
+	if (unlikely(map_flags & BPF_F_LOCK))
 		return -EINVAL;
 
 	if (unlikely(index >= array->map.max_entries))
 		/* all elements were pre-allocated, cannot insert a new one */
 		return -E2BIG;
 
-	if (unlikely(map_flags == BPF_NOEXIST))
+	if (unlikely(map_flags & BPF_NOEXIST))
 		/* all elements already exist */
 		return -EEXIST;
 
@@ -422,11 +429,20 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		ptr = per_cpu_ptr(pptr, cpu);
+		copy_map_value(map, ptr, value);
+		bpf_obj_free_fields(array->map.record, ptr);
+		goto unlock;
+	}
 	for_each_possible_cpu(cpu) {
-		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
-		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
-		off += size;
+		ptr = per_cpu_ptr(pptr, cpu);
+		val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
+		copy_map_value(map, ptr, val);
+		bpf_obj_free_fields(array->map.record, ptr);
 	}
+unlock:
 	rcu_read_unlock();
 	return 0;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3c3e3b4095b9..238238086b08 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -318,7 +318,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
 		err = bpf_percpu_hash_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		err = bpf_percpu_array_copy(map, key, value);
+		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
-- 
2.51.2


