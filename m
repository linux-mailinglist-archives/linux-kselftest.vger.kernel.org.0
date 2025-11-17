Return-Path: <linux-kselftest+bounces-45766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F04FC65246
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 17:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA4614F2D8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18622C3254;
	Mon, 17 Nov 2025 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pcauAFIW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950152BE7BB
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396520; cv=none; b=IK9Zl4fhc0ceCNgwtP67zP1vI+4e1d7OuhdD9Ixe4Z6Ln0wfDDdYHf2QMczjX+iMLdktCYmWEjbjBeFYBMm0AI//Kuw+ZPnZjiedgAgNw+uXCwXV8zCPhpVEUp0UN1pBDnwBxLPJi2qI3iyvO4MfZ7Xhl8BNkSkZK7zDHcV9buc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396520; c=relaxed/simple;
	bh=+TvyQ5m3nwqFeuOZjRRIyTskGQ5/rsqaBjt3HmI/ARQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/tEpkT6dxG6B0640QFgdImPwxbA1qXOo17j0OhSu82NcI6jKKFybVRqnCU4O3ZiQEj/JYQhgNvgtUfNmkWezqYYRU+u6a4l4DWKptHcn4DRGy75T7wBaDW8Tc8Yyz/x9aosqQvlXgjrHzFu2onM+V8mDGxKCwsQGWnoojt1z1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pcauAFIW; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763396516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zvg92b42OFhnOUh/6Q22itovVwfvakyr46Hx8+9Naz4=;
	b=pcauAFIWDa/r/2Sc/4WIIXdgdUDWpOddP82dk8fd8TVEEtPN0NAfSSkiiuWtFucvSo4Sw8
	M8fh6lEq3ZtDUQDcfLR+koI9iF2OwrrHnCYCj9DrXHepmPWSzU/d6iemYn+LOPNiOKRjnO
	qjAK+/mAbVakdQRqlK+UW+89xVq9dCg=
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
Subject: [PATCH bpf-next v10 6/8] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_cgroup_storage maps
Date: Tue, 18 Nov 2025 00:20:31 +0800
Message-ID: <20251117162033.6296-7-leon.hwang@linux.dev>
In-Reply-To: <20251117162033.6296-1-leon.hwang@linux.dev>
References: <20251117162033.6296-1-leon.hwang@linux.dev>
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
index aedf573bdb426..013f4db9903fd 100644
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
index 1fc0afb7f547f..e87779d3c5927 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3819,6 +3819,7 @@ static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_HASH:
 	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		return true;
 	default:
 		return false;
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 2ab4b60ffe61f..1ccbf28b2ad9f 100644
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
index 3cff19a4be527..643e589c10231 100644
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


