Return-Path: <linux-kselftest+bounces-48371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D31CFBBC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 03:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A106530F4358
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 02:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E393523E342;
	Wed,  7 Jan 2026 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U20G06Iq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA4723D7FF
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752782; cv=none; b=pTirNbakiLo91iZ5uFTW8SdEqSx7lPCLV3tKKFnAgVu6EiH7DeoBe6MEioQEb/JufmGYyS/SiewDaoUQwhFlD1wiaqOgatL76rmgHcXzHh38rBqqaSnQLc9WtR5Jd8UV3ADSjcZbVOTPNTGLkbKd3vTDP9YGiHeZHPC816pBPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752782; c=relaxed/simple;
	bh=UpcZKkRvzqwNjTLzkLP6lM5piXgZoKeN4woVPisXk1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhq/0cfAdkOauGqvlK/9Dzhf+xXUNiI08j0eV3/RVdim58+o24nt9ra8dgeUqAiUTwNmqngoG/bRcviBmHAjFdrRoKopG39uJ/F5FQ2Lov4OcRvzx0j0vNQIclJzqgOOFBXFpm31p/JmcO0kflaEfCaQD1mNGw0QCtfLt6cQGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U20G06Iq; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767752779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNMm/4sluIfJ/OrbS9dw5ssAz0dLo5qttAvkqyfnn/s=;
	b=U20G06IqlZWRlyFQz61w8LZ4OD0LOrGxQN5s2hFG4xsghcG29/z/CvbIbKFHAexqIytJTJ
	d+ennc6DKzlJBxs0CTr5i+14sr5/0Muj0WEvyRJINpWRQMoi7jZo/gE0CxIksduW+Ce5lv
	xp9P6uNLWdxYUd7Sp6ASf6Y2E8nehUQ=
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
Subject: [PATCH bpf-next v13 6/7] libbpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu maps
Date: Wed,  7 Jan 2026 10:20:21 +0800
Message-ID: <20260107022022.12843-7-leon.hwang@linux.dev>
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

Add libbpf support for the BPF_F_CPU flag for percpu maps by embedding the
cpu info into the high 32 bits of:

1. **flags**: bpf_map_lookup_elem_flags(), bpf_map__lookup_elem(),
   bpf_map_update_elem() and bpf_map__update_elem()
2. **opts->elem_flags**: bpf_map_lookup_batch() and
   bpf_map_update_batch()

And the flag can be BPF_F_ALL_CPUS, but cannot be
'BPF_F_CPU | BPF_F_ALL_CPUS'.

Behavior:

* If the flag is BPF_F_ALL_CPUS, the update is applied across all CPUs.
* If the flag is BPF_F_CPU, it updates value only to the specified CPU.
* If the flag is BPF_F_CPU, lookup value only from the specified CPU.
* lookup does not support BPF_F_ALL_CPUS.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.h    |  8 ++++++++
 tools/lib/bpf/libbpf.c | 26 ++++++++++++++++++++------
 tools/lib/bpf/libbpf.h | 21 ++++++++-------------
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 1f9c28d27795..2c8e88ddb674 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -289,6 +289,14 @@ LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
  *    Update spin_lock-ed map elements. This must be
  *    specified if the map value contains a spinlock.
  *
+ * **BPF_F_CPU**
+ *    As for percpu maps, update value on the specified CPU. And the cpu
+ *    info is embedded into the high 32 bits of **opts->elem_flags**.
+ *
+ * **BPF_F_ALL_CPUS**
+ *    As for percpu maps, update value across all CPUs. This flag cannot
+ *    be used with BPF_F_CPU at the same time.
+ *
  * @param fd BPF map file descriptor
  * @param keys pointer to an array of *count* keys
  * @param values pointer to an array of *count* values
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1a52d818a76c..6ea81701e274 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10919,7 +10919,7 @@ bpf_object__find_map_fd_by_name(const struct bpf_object *obj, const char *name)
 }
 
 static int validate_map_op(const struct bpf_map *map, size_t key_sz,
-			   size_t value_sz, bool check_value_sz)
+			   size_t value_sz, bool check_value_sz, __u64 flags)
 {
 	if (!map_is_created(map)) /* map is not yet created */
 		return -ENOENT;
@@ -10946,6 +10946,20 @@ static int validate_map_op(const struct bpf_map *map, size_t key_sz,
 		int num_cpu = libbpf_num_possible_cpus();
 		size_t elem_sz = roundup(map->def.value_size, 8);
 
+		if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
+			if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CPUS)) {
+				pr_warn("map '%s': BPF_F_CPU and BPF_F_ALL_CPUS are mutually exclusive\n",
+					map->name);
+				return -EINVAL;
+			}
+			if (map->def.value_size != value_sz) {
+				pr_warn("map '%s': unexpected value size %zu provided for either BPF_F_CPU or BPF_F_ALL_CPUS, expected %u\n",
+					map->name, value_sz, map->def.value_size);
+				return -EINVAL;
+			}
+			break;
+		}
+
 		if (value_sz != num_cpu * elem_sz) {
 			pr_warn("map '%s': unexpected value size %zu provided for per-CPU map, expected %d * %zu = %zd\n",
 				map->name, value_sz, num_cpu, elem_sz, num_cpu * elem_sz);
@@ -10970,7 +10984,7 @@ int bpf_map__lookup_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, value_sz, true);
+	err = validate_map_op(map, key_sz, value_sz, true, flags);
 	if (err)
 		return libbpf_err(err);
 
@@ -10983,7 +10997,7 @@ int bpf_map__update_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, value_sz, true);
+	err = validate_map_op(map, key_sz, value_sz, true, flags);
 	if (err)
 		return libbpf_err(err);
 
@@ -10995,7 +11009,7 @@ int bpf_map__delete_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */);
+	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */, flags);
 	if (err)
 		return libbpf_err(err);
 
@@ -11008,7 +11022,7 @@ int bpf_map__lookup_and_delete_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, value_sz, true);
+	err = validate_map_op(map, key_sz, value_sz, true, flags);
 	if (err)
 		return libbpf_err(err);
 
@@ -11020,7 +11034,7 @@ int bpf_map__get_next_key(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */);
+	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */, 0);
 	if (err)
 		return libbpf_err(err);
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e14d9e349f9c..dfc37a615578 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1216,12 +1216,13 @@ LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
  * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
  * @param value pointer to memory in which looked up value will be stored
  * @param value_sz size in byte of value data memory; it has to match BPF map
- * definition's **value_size**. For per-CPU BPF maps value size has to be
- * a product of BPF map value size and number of possible CPUs in the system
- * (could be fetched with **libbpf_num_possible_cpus()**). Note also that for
- * per-CPU values value size has to be aligned up to closest 8 bytes for
- * alignment reasons, so expected size is: `round_up(value_size, 8)
- * * libbpf_num_possible_cpus()`.
+ * definition's **value_size**. For per-CPU BPF maps, value size can be
+ * `value_size` if either **BPF_F_CPU** or **BPF_F_ALL_CPUS** is specified
+ * in **flags**, otherwise a product of BPF map value size and number of
+ * possible CPUs in the system (could be fetched with
+ * **libbpf_num_possible_cpus()**). Note also that for per-CPU values value
+ * size has to be aligned up to closest 8 bytes, so expected size is:
+ * `round_up(value_size, 8) * libbpf_num_possible_cpus()`.
  * @param flags extra flags passed to kernel for this operation
  * @return 0, on success; negative error, otherwise
  *
@@ -1239,13 +1240,7 @@ LIBBPF_API int bpf_map__lookup_elem(const struct bpf_map *map,
  * @param key pointer to memory containing bytes of the key
  * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
  * @param value pointer to memory containing bytes of the value
- * @param value_sz size in byte of value data memory; it has to match BPF map
- * definition's **value_size**. For per-CPU BPF maps value size has to be
- * a product of BPF map value size and number of possible CPUs in the system
- * (could be fetched with **libbpf_num_possible_cpus()**). Note also that for
- * per-CPU values value size has to be aligned up to closest 8 bytes for
- * alignment reasons, so expected size is: `round_up(value_size, 8)
- * * libbpf_num_possible_cpus()`.
+ * @param value_sz refer to **bpf_map__lookup_elem**'s description.'
  * @param flags extra flags passed to kernel for this operation
  * @return 0, on success; negative error, otherwise
  *
-- 
2.52.0


