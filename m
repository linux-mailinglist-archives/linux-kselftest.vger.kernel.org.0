Return-Path: <linux-kselftest+bounces-48330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0315BCFA15B
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 19:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C71C31B4653
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 17:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D1634F497;
	Tue,  6 Jan 2026 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QdaEnI2+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926834F484
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720117; cv=none; b=iggTTOgPpbrDqnoMatvxwmODcn2uPofUYiUvO1AC3KruBxyQzPjKkWxa609jGYq96J2/W+SbHbgyYwCzSVtuQ5c8vRqHqneIiGGyhcM6XQ3NuxtTEX/HKtOdpG0JJQ0iCiPo4F7KKlITbUA2pgntTR7Jc0C9VJG8cDqrxvfIRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720117; c=relaxed/simple;
	bh=AETHN+3kFlVaYquHWZbaQLeMcf8iQflBHGOXp5wQCqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECqSZezUwZTWv6ciH9ZY/bbCEpP0M+R5DyxeWjCabeGHKwpoLznnVa+PPdlTtqEQTiaEIKHg5WtROYGukI5ZTYl8pIvKiI1ZP0To+3Qz4n3pt/j378d4JVK4UmwuhGAT2+PlSieOmTga4SlEbSA1EzF32vQK1vOJkZK3N6lYNFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QdaEnI2+; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767720113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mauyZYzayXq6OYND+1vFeaYe2URO7AKanu1AXWjwEU=;
	b=QdaEnI2+xAQi2FlSNHjuDzvhP21UVE0kcsOG6LIZgJtB0NyFGGIwfu/wlGmgEob5pxER7X
	Qwvf0K+jr/zXhghujm1c76640gyvD0EbejUYLp4HMGUQEa9qvhsXBl+b2jIsuX10bZ/LfM
	VSTZcUnOOcJTQ/eaxqp4aEEWLsao3n4=
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
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Seth Forshee <sforshee@kernel.org>,
	Yuichiro Tsuji <yuichtsu@amazon.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [RESEND PATCH bpf-next v4 7/9] bpf: Add common attr support for map_create
Date: Wed,  7 Jan 2026 01:20:16 +0800
Message-ID: <20260106172018.57757-8-leon.hwang@linux.dev>
In-Reply-To: <20260106172018.57757-1-leon.hwang@linux.dev>
References: <20260106172018.57757-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, many 'BPF_MAP_CREATE' failures return '-EINVAL' without
providing any explanation to user space.

With the extended BPF syscall support, detailed error messages can now be
reported. This allows users to understand the specific reason for a
failed map creation, rather than just receiving a generic '-EINVAL'.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 88 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 14fc5738f2b9..e64cc7504731 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1366,23 +1366,72 @@ static bool bpf_net_capable(void)
 	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
 }
 
+struct bpf_vlog_wrapper {
+	struct bpf_common_attr *attr;
+	struct bpf_verifier_log *log;
+};
+
+static void bpf_vlog_wrapper_destructor(struct bpf_vlog_wrapper *w)
+{
+	if (!w->log)
+		return;
+
+	(void) bpf_vlog_finalize(w->log, &w->attr->log_true_size);
+	kfree(w->log);
+}
+
+#define DEFINE_BPF_VLOG_WRAPPER(name, common_attrs)				\
+	struct bpf_vlog_wrapper name __cleanup(bpf_vlog_wrapper_destructor) = {	\
+		.attr = common_attrs,						\
+	}
+
+static int bpf_vlog_wrapper_init(struct bpf_vlog_wrapper *w)
+{
+	struct bpf_common_attr *attr = w->attr;
+	struct bpf_verifier_log *log;
+	int err;
+
+	if (!attr->log_buf)
+		return 0;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		return -ENOMEM;
+
+	err = bpf_vlog_init(log, attr->log_level, u64_to_user_ptr(attr->log_buf), attr->log_size);
+	if (err) {
+		kfree(log);
+		return err;
+	}
+
+	w->log = log;
+	return 0;
+}
+
 #define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash_size
 /* called via syscall */
-static int map_create(union bpf_attr *attr, bpfptr_t uattr)
+static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *common_attrs)
 {
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
 	int numa_node = bpf_map_attr_numa_node(attr);
 	u32 map_type = attr->map_type;
+	struct bpf_verifier_log *log;
 	struct bpf_map *map;
 	bool token_flag;
 	int f_flags;
 	int err;
+	DEFINE_BPF_VLOG_WRAPPER(log_wrapper, common_attrs);
 
 	err = CHECK_ATTR(BPF_MAP_CREATE);
 	if (err)
 		return -EINVAL;
 
+	err = bpf_vlog_wrapper_init(&log_wrapper);
+	if (err)
+		return err;
+	log = log_wrapper.log;
+
 	/* check BPF_F_TOKEN_FD flag, remember if it's set, and then clear it
 	 * to avoid per-map type checks tripping on unknown flag
 	 */
@@ -1390,17 +1439,25 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	attr->map_flags &= ~BPF_F_TOKEN_FD;
 
 	if (attr->btf_vmlinux_value_type_id) {
-		if (attr->map_type != BPF_MAP_TYPE_STRUCT_OPS ||
-		    attr->btf_key_type_id || attr->btf_value_type_id)
+		if (attr->map_type != BPF_MAP_TYPE_STRUCT_OPS) {
+			bpf_log(log, "btf_vmlinux_value_type_id can only be used with struct_ops maps.\n");
 			return -EINVAL;
+		}
+		if (attr->btf_key_type_id || attr->btf_value_type_id) {
+			bpf_log(log, "btf_vmlinux_value_type_id is mutually exclusive with btf_key_type_id and btf_value_type_id.\n");
+			return -EINVAL;
+		}
 	} else if (attr->btf_key_type_id && !attr->btf_value_type_id) {
+		bpf_log(log, "Invalid btf_value_type_id.\n");
 		return -EINVAL;
 	}
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
 	    attr->map_type != BPF_MAP_TYPE_ARENA &&
-	    attr->map_extra != 0)
+	    attr->map_extra != 0) {
+		bpf_log(log, "Invalid map_extra.\n");
 		return -EINVAL;
+	}
 
 	f_flags = bpf_get_file_flag(attr->map_flags);
 	if (f_flags < 0)
@@ -1408,13 +1465,17 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 	if (numa_node != NUMA_NO_NODE &&
 	    ((unsigned int)numa_node >= nr_node_ids ||
-	     !node_online(numa_node)))
+	     !node_online(numa_node))) {
+		bpf_log(log, "Invalid numa_node.\n");
 		return -EINVAL;
+	}
 
 	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
 	map_type = attr->map_type;
-	if (map_type >= ARRAY_SIZE(bpf_map_types))
+	if (map_type >= ARRAY_SIZE(bpf_map_types)) {
+		bpf_log(log, "Invalid map_type.\n");
 		return -EINVAL;
+	}
 	map_type = array_index_nospec(map_type, ARRAY_SIZE(bpf_map_types));
 	ops = bpf_map_types[map_type];
 	if (!ops)
@@ -1432,8 +1493,10 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 	if (token_flag) {
 		token = bpf_token_get_from_fd(attr->map_token_fd);
-		if (IS_ERR(token))
+		if (IS_ERR(token)) {
+			bpf_log(log, "Invalid map_token_fd.\n");
 			return PTR_ERR(token);
+		}
 
 		/* if current token doesn't grant map creation permissions,
 		 * then we can't use this token, so ignore it and rely on
@@ -1516,8 +1579,10 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 	err = bpf_obj_name_cpy(map->name, attr->map_name,
 			       sizeof(attr->map_name));
-	if (err < 0)
+	if (err < 0) {
+		bpf_log(log, "Invalid map_name.\n");
 		goto free_map;
+	}
 
 	preempt_disable();
 	map->cookie = gen_cookie_next(&bpf_map_cookie);
@@ -1540,6 +1605,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 		btf = btf_get_by_fd(attr->btf_fd);
 		if (IS_ERR(btf)) {
+			bpf_log(log, "Invalid btf_fd.\n");
 			err = PTR_ERR(btf);
 			goto free_map;
 		}
@@ -6279,7 +6345,11 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		err = map_create(&attr, uattr);
+		common_attrs.log_true_size = 0;
+		err = map_create(&attr, uattr, &common_attrs);
+		ret = copy_common_attr_log_true_size(uattr_common, size_common,
+						     &common_attrs.log_true_size);
+		err = ret ? ret : err;
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
 		err = map_lookup_elem(&attr);
-- 
2.52.0


