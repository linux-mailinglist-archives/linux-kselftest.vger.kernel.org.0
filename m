Return-Path: <linux-kselftest+bounces-46445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDA2C859EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 16:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABC93B50A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521F7326D76;
	Tue, 25 Nov 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mLvyypKE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621E326D4A
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082842; cv=none; b=YbkvnUTkNE2FI0eHhEpFiT3J0xMJ6MywSrwaw8lKAoyI4G/XHu0ifVClj2XIm8M5nuOd2vlBIK/lb/D+oRb9H9ag5ipSs3IaJSkLNUlFI28x8eP+ZpR2Px71GWFxnu1nHEQ1y6lEAMdcmnFQ2WLa/+eLhySV620mkyDvsB7yM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082842; c=relaxed/simple;
	bh=ghgsY45RF5TkR9lKrPWdNbTeA1WJdKJkm9atuq4v5K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eV3SlRhCA+R2B7d6cqDsbjpvMI2dw7waiTy3KLdjgLUpSBB2EnZ+Hf+EfYqaofix+UxTfR4MfyeRI7Rc9wLnHCDvjaaiLqVGihlUme7HVgUF9cYUBUXaC8z/ocK/fL6E0RvJDshMPgpCWlFVCPyZY19oWKjwuRvYoVDgEEd8Xs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mLvyypKE; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764082837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p81YWnqve83/ohG8fCF50rW1gpi+KzxyiVHkrFHkBUY=;
	b=mLvyypKEVqlix/AHMUJktiXy8/QGxKeN03rJ8o2jktzfTjb6QRaKIhH7Thnh+nPuqc9uk6
	ZLe4cVYhqHj6cUeOwFxZOEP5NuZEinxGVxj/P/UQO4XNv9kEDppGkj+4uN2FQbELe+6Pf9
	v38bTtHifVRCd3phUX6lmOCMzOlpHts=
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
Subject: [PATCH bpf-next v11 6/8] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_cgroup_storage maps
Date: Tue, 25 Nov 2025 22:58:55 +0800
Message-ID: <20251125145857.98134-7-leon.hwang@linux.dev>
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

Introduce BPF_F_ALL_CPUS flag support for percpu_cgroup_storage maps to
allow updating values for all CPUs with a single value for update_elem
API.

Introduce BPF_F_CPU flag support for percpu_cgroup_storage maps to
allow:

* update value for specified CPU for update_elem API.
* lookup value for specified CPU for lookup_elem API.

The BPF_F_CPU flag is passed via map_flags along with embedded cpu info.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf-cgroup.h |  4 ++--
 include/linux/bpf.h        |  1 +
 kernel/bpf/local_storage.c | 23 ++++++++++++++++++-----
 kernel/bpf/syscall.c       |  2 +-
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index aedf573bdb42..013f4db9903f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -172,7 +172,7 @@ void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
 void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
 int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *map);
 
-int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
 				     void *value, u64 flags);
 
@@ -467,7 +467,7 @@ static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
 static inline void bpf_cgroup_storage_free(
 	struct bpf_cgroup_storage *storage) {}
 static inline int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key,
-						 void *value) {
+						 void *value, u64 flags) {
 	return 0;
 }
 static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f79d2ae27335..9e756db5e132 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3835,6 +3835,7 @@ static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_HASH:
 	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		return true;
 	default:
 		return false;
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 2ab4b60ffe61..1ccbf28b2ad9 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -180,7 +180,7 @@ static long cgroup_storage_update_elem(struct bpf_map *map, void *key,
 }
 
 int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
-				   void *value)
+				   void *value, u64 map_flags)
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 	struct bpf_cgroup_storage *storage;
@@ -198,11 +198,17 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
 	 * access 'value_size' of them, so copying rounded areas
 	 * will not leak any kernel data
 	 */
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		copy_map_value(_map, value, per_cpu_ptr(storage->percpu_buf, cpu));
+		goto unlock;
+	}
 	size = round_up(_map->value_size, 8);
 	for_each_possible_cpu(cpu) {
 		copy_map_value_long(_map, value + off, per_cpu_ptr(storage->percpu_buf, cpu));
 		off += size;
 	}
+unlock:
 	rcu_read_unlock();
 	return 0;
 }
@@ -212,10 +218,11 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 	struct bpf_cgroup_storage *storage;
-	int cpu, off = 0;
+	void *val;
 	u32 size;
+	int cpu;
 
-	if (map_flags != BPF_ANY && map_flags != BPF_EXIST)
+	if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F_ALL_CPUS))
 		return -EINVAL;
 
 	rcu_read_lock();
@@ -231,11 +238,17 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 	 * returned or zeros which were zero-filled by percpu_alloc,
 	 * so no kernel data leaks possible
 	 */
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		copy_map_value(_map, per_cpu_ptr(storage->percpu_buf, cpu), value);
+		goto unlock;
+	}
 	size = round_up(_map->value_size, 8);
 	for_each_possible_cpu(cpu) {
-		copy_map_value_long(_map, per_cpu_ptr(storage->percpu_buf, cpu), value + off);
-		off += size;
+		val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
+		copy_map_value(_map, per_cpu_ptr(storage->percpu_buf, cpu), val);
 	}
+unlock:
 	rcu_read_unlock();
 	return 0;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7e6cca641026..d64567c6ef50 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -320,7 +320,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
-		err = bpf_percpu_cgroup_storage_copy(map, key, value);
+		err = bpf_percpu_cgroup_storage_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
 		err = bpf_stackmap_extract(map, key, value, false);
 	} else if (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map)) {
-- 
2.51.2


