Return-Path: <linux-kselftest+bounces-46440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5E6C859B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 16:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C423AF215
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6CF327BE6;
	Tue, 25 Nov 2025 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NW2ZuypA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADC03277A9
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082783; cv=none; b=p1je44la28MmAEPMvkSCP1QIHKzV646itdmm5cMS5bEPJywUXoKplR1rqyOSmYIMbL6WgWKAKm8JUBcYSoRyP73kBJMYlapVMaX0fPYkIxiPwO8tqoGuwUl6UrRYXaOS5Mwq8SKDCN3f0viISCmn1L69D3gUsyiBJxrTLvLKd/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082783; c=relaxed/simple;
	bh=MipVcJ1lWqTRx4wuG4zL8qH8vMWgIc+hWwMBaYOxkh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gpjz2lb8Z8yMX3BETzR/di7dX2naN53LVpL49vG/+KDuKH2/xFNLL6n3YDEl1KyatJ9BIB9ZBZX7ksoU624IiMuFqcp9gdFQSMCo3fRIKkz6jmwIlyA/u/q3uh7io4kTah2zdkSiJ2V8aOEV3ET7BaO2iDp8xEkso2AtMJPn6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NW2ZuypA; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764082778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXp+7pDoGS0WWr6S4WrUXUoCMmCmkevtKo8m5xnvZCM=;
	b=NW2ZuypACKBmarN/1MlqQmzFJAXxSYSRMc+UiRYYzgRtwW3PYSEc9b8ybhrq8qtoIk6xRq
	EXzwjgkrAR8Rwr0esu2KEkO4FWXXOZ6WZjGP+tOsPu7yTjbFoK1Qe3ArG8OKnWATncJ5Ax
	av0rloJKgZ5Hhtd67eTIEcefJiAqMkU=
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
Subject: [PATCH bpf-next v11 1/8] bpf: Introduce internal bpf_map_check_op_flags helper function
Date: Tue, 25 Nov 2025 22:58:50 +0800
Message-ID: <20251125145857.98134-2-leon.hwang@linux.dev>
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

It is to unify map flags checking for lookup_elem, update_elem,
lookup_batch and update_batch APIs.

Therefore, it will be convenient to check BPF_F_CPU and BPF_F_ALL_CPUS
flags in it for these APIs in next patch.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h  | 11 +++++++++++
 kernel/bpf/syscall.c | 34 +++++++++++-----------------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a9b788c7b4aa..6498be4c44f8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3829,4 +3829,15 @@ bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 }
 #endif
 
+static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
+{
+	if (flags & ~allowed_flags)
+		return -EINVAL;
+
+	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
+		return -EINVAL;
+
+	return 0;
+}
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 792623a7c90b..cef8963d69f9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1725,9 +1725,6 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
 		return -EINVAL;
 
-	if (attr->flags & ~BPF_F_LOCK)
-		return -EINVAL;
-
 	CLASS(fd, f)(attr->map_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
@@ -1735,9 +1732,9 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
 		return -EPERM;
 
-	if ((attr->flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
-		return -EINVAL;
+	err = bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK);
+	if (err)
+		return err;
 
 	key = __bpf_copy_key(ukey, map->key_size);
 	if (IS_ERR(key))
@@ -1800,11 +1797,9 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	if ((attr->flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
-		err = -EINVAL;
+	err = bpf_map_check_op_flags(map, attr->flags, ~0);
+	if (err)
 		goto err_put;
-	}
 
 	key = ___bpf_copy_key(ukey, map->key_size);
 	if (IS_ERR(key)) {
@@ -2008,13 +2003,9 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	void *key, *value;
 	int err = 0;
 
-	if (attr->batch.elem_flags & ~BPF_F_LOCK)
-		return -EINVAL;
-
-	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
-		return -EINVAL;
-	}
+	err = bpf_map_check_op_flags(map, attr->batch.elem_flags, BPF_F_LOCK);
+	if (err)
+		return err;
 
 	value_size = bpf_map_value_size(map);
 
@@ -2071,12 +2062,9 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	u32 value_size, cp, max_count;
 	int err;
 
-	if (attr->batch.elem_flags & ~BPF_F_LOCK)
-		return -EINVAL;
-
-	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
-		return -EINVAL;
+	err = bpf_map_check_op_flags(map, attr->batch.elem_flags, BPF_F_LOCK);
+	if (err)
+		return err;
 
 	value_size = bpf_map_value_size(map);
 
-- 
2.51.2


