Return-Path: <linux-kselftest+bounces-46441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F39DC859EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 16:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A4E24EC9A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEC8326D69;
	Tue, 25 Nov 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NL7+NlnC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30FB2727EB
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082793; cv=none; b=ZqG0nEzEqxeFviE0Vu4Y51haCVxYPhER7GKsAXWJ4ZyNYPa6ElBln51PMi3HFyvj9T1caZL1aTnnTloXVVsZU4NdkNWTY2UfGw1Fd/MsNr18s+sateMAHT5M39md/KxxugiaEbzjo3YZ8URCmA/a9OvbS2vxBtpdpq4bEcY0Pnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082793; c=relaxed/simple;
	bh=W/8lsMv5sUSzOJEHJ2dVfk6ti5mM4wE3LlQs/epbwHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpkSwAr+zdOYznhT+2c78707v/7Yl/gJt5Cu7f5jNu0zYD10B+oLSNBrsere1rP+GfqbEVVHaXxiPMrRiJtQXGvSH3/AaQ3VdvhS2dDuu8/4AmKft/GxUihRcaOHWWTnDv0aFov7J7jkSxV/7g305GJL9NQsOoSgtR9pZsGGaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NL7+NlnC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764082789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EQcb8DXtqocNDX66I0256aqYUvL4AFhD0aUjOs0Z0w=;
	b=NL7+NlnC2wL4dMuk3ooBGrGG7OasJgZEciC7NFbh44zGcZNqzySGNrOJ115qxHo9y3z7sq
	hCLr6ksd716tss6473HpSMmwT+hSkRQxpMc5PjVnA/I1+qcjz0Fd73jK76ymyKiOumgEO3
	3l2sk8YjUjp6nsXeG1o/bK16s2xjAYM=
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
Subject: [PATCH bpf-next v11 2/8] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags
Date: Tue, 25 Nov 2025 22:58:51 +0800
Message-ID: <20251125145857.98134-3-leon.hwang@linux.dev>
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

Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags and check them for
following APIs:

* 'map_lookup_elem()'
* 'map_update_elem()'
* 'generic_map_lookup_batch()'
* 'generic_map_update_batch()'

And, get the correct value size for these APIs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v10 -> v11:
 - Use '(BPF_F_ALL_CPUS << 1) - 1' as allowed_flags in map_update_elem().
 - Add BPF_EXIST to allowed_flags in generic_map_update_batch().
---
 include/linux/bpf.h            | 23 +++++++++++++++++++++-
 include/uapi/linux/bpf.h       |  2 ++
 kernel/bpf/syscall.c           | 36 ++++++++++++++++++++--------------
 tools/include/uapi/linux/bpf.h |  2 ++
 4 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6498be4c44f8..d84af3719b59 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3829,14 +3829,35 @@ bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 }
 #endif
 
+static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
+{
+	return false;
+}
+
 static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
 {
-	if (flags & ~allowed_flags)
+	u32 cpu;
+
+	if ((u32)flags & ~allowed_flags)
 		return -EINVAL;
 
 	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
 		return -EINVAL;
 
+	if (!(flags & BPF_F_CPU) && flags >> 32)
+		return -EINVAL;
+
+	if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
+		if (!bpf_map_supports_cpu_flags(map->map_type))
+			return -EINVAL;
+		if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CPUS))
+			return -EINVAL;
+
+		cpu = flags >> 32;
+		if ((flags & BPF_F_CPU) && cpu >= num_possible_cpus())
+			return -ERANGE;
+	}
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f5713f59ac10..8b6279ca6e66 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1373,6 +1373,8 @@ enum {
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
 	BPF_EXIST	= 2, /* update existing element */
 	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
+	BPF_F_CPU	= 8, /* cpu flag for percpu maps, upper 32-bit of flags is a cpu number */
+	BPF_F_ALL_CPUS	= 16, /* update value across all CPUs for percpu maps */
 };
 
 /* flags for BPF_MAP_CREATE command */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cef8963d69f9..3c3e3b4095b9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -133,12 +133,14 @@ bool bpf_map_write_active(const struct bpf_map *map)
 	return atomic64_read(&map->writecnt) != 0;
 }
 
-static u32 bpf_map_value_size(const struct bpf_map *map)
-{
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
+static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
+{
+	if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS))
+		return map->value_size;
+	else if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+		 map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		 map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+		 map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 		return round_up(map->value_size, 8) * num_possible_cpus();
 	else if (IS_FD_MAP(map))
 		return sizeof(u32);
@@ -1732,7 +1734,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
 		return -EPERM;
 
-	err = bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK);
+	err = bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK | BPF_F_CPU);
 	if (err)
 		return err;
 
@@ -1740,7 +1742,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
@@ -1781,6 +1783,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 	bpfptr_t uvalue = make_bpfptr(attr->value, uattr.is_kernel);
 	struct bpf_map *map;
 	void *key, *value;
+	u64 allowed_flags;
 	u32 value_size;
 	int err;
 
@@ -1797,7 +1800,8 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	err = bpf_map_check_op_flags(map, attr->flags, ~0);
+	allowed_flags = (BPF_F_ALL_CPUS << 1) - 1;
+	err = bpf_map_check_op_flags(map, attr->flags, allowed_flags);
 	if (err)
 		goto err_put;
 
@@ -1807,7 +1811,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 	value = kvmemdup_bpfptr(uvalue, value_size);
 	if (IS_ERR(value)) {
 		err = PTR_ERR(value);
@@ -2001,13 +2005,15 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
 	u32 value_size, cp, max_count;
 	void *key, *value;
+	u64 allowed_flags;
 	int err = 0;
 
-	err = bpf_map_check_op_flags(map, attr->batch.elem_flags, BPF_F_LOCK);
+	allowed_flags = BPF_EXIST | BPF_F_LOCK | BPF_F_CPU | BPF_F_ALL_CPUS;
+	err = bpf_map_check_op_flags(map, attr->batch.elem_flags, allowed_flags);
 	if (err)
 		return err;
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -2062,11 +2068,11 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	u32 value_size, cp, max_count;
 	int err;
 
-	err = bpf_map_check_op_flags(map, attr->batch.elem_flags, BPF_F_LOCK);
+	err = bpf_map_check_op_flags(map, attr->batch.elem_flags, BPF_F_LOCK | BPF_F_CPU);
 	if (err)
 		return err;
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -2188,7 +2194,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, 0);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f5713f59ac10..8b6279ca6e66 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1373,6 +1373,8 @@ enum {
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
 	BPF_EXIST	= 2, /* update existing element */
 	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
+	BPF_F_CPU	= 8, /* cpu flag for percpu maps, upper 32-bit of flags is a cpu number */
+	BPF_F_ALL_CPUS	= 16, /* update value across all CPUs for percpu maps */
 };
 
 /* flags for BPF_MAP_CREATE command */
-- 
2.51.2


