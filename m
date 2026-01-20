Return-Path: <linux-kselftest+bounces-49534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGFiDH+8b2kOMQAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49534-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 18:33:51 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E4E48A29
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 18:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 533279E0578
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0C747DFA6;
	Tue, 20 Jan 2026 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XPyKOodN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7EC47DD78
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922812; cv=none; b=pMkfdGx8ahRX8zUFQcljEgMINHmZEG+SsDADBLwvMdj0IPkaS0Zr+B8una8EZ1dmJjd/6lP+FRVW2ME5XNw4HulkJqtyi5UI9I6XNG52iRc6C9kjYMzdjn9dKQDJP1YkBaZGezOVn1q+4fnt3NZbLZIgAWlR3IAv8bVnGkv65To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922812; c=relaxed/simple;
	bh=SuOGG01DvWBhm1QpfI/wd86KJx/mMpxUCw20kbRi+uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpm1UveOxhJdk7M+U0qYYHgjl/00vDxR+W9ibvs0pB8I3KYyf6bxSj2r2PPqyAmDP08eXBN0Gsbns6uawRWaVMOhe+yZM5776hdE9w7YJX9CjJ8J8Xng/RsU45NprqpsHqapzVOUeqfFWeu7nafk0d/hAd5RlUeMnrVVokAk5tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XPyKOodN; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768922806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgUOK7v1Rf54AXDWPDT69hS8dsQROTzuvZi82nPKImc=;
	b=XPyKOodNgtWC4AVevq6E4k68Ro+5PaVa2CSVqFIZK5cPjH30UCbSXjQtaIr1JTthAl9HEK
	KMAjFz4osYAfAIeVR9GkL1Yt7fPmmOWFP5D+CQ23lXfOFkBUlzfEwmIaz72i8lKEOW+RdF
	ROoX+L6Jzk6xjwFs7o2mrRHOfOG+H8M=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>,
	Yuichiro Tsuji <yuichtsu@amazon.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Tao Chen <chen.dylane@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [RESEND PATCH bpf-next v6 7/9] bpf: Add syscall common attributes support for map_create
Date: Tue, 20 Jan 2026 23:24:21 +0800
Message-ID: <20260120152424.40766-8-leon.hwang@linux.dev>
In-Reply-To: <20260120152424.40766-1-leon.hwang@linux.dev>
References: <20260120152424.40766-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-49534-lists,linux-kselftest=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-kselftest@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-kselftest];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 93E4E48A29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, many BPF_MAP_CREATE failures return -EINVAL without providing
any explanation to userspace.

With extended BPF syscall support, detailed error messages can now be
reported via the log buffer, allowing users to understand the specific
reason for a failed map creation.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/log.c             | 30 +++++++++++++++++
 kernel/bpf/syscall.c         | 65 ++++++++++++++++++++++++++++++------
 3 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9022e4f515f9..280beca480ea 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -644,6 +644,8 @@ int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs
 				struct bpf_attrs *attrs_common);
 int bpf_btf_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
 			       struct bpf_attrs *attrs_common);
+struct bpf_verifier_log *bpf_log_attr_create_vlog(struct bpf_log_attr *log_attr,
+						  struct bpf_attrs *attrs_common);
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log);
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 3cccb0c5e482..d7933a412c36 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -912,6 +912,36 @@ int bpf_btf_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *
 				 attrs_common);
 }
 
+struct bpf_verifier_log *bpf_log_attr_create_vlog(struct bpf_log_attr *log_attr,
+						  struct bpf_attrs *attrs_common)
+{
+	const struct bpf_common_attr *common = attrs_common->attr;
+	struct bpf_verifier_log *log;
+	int err;
+
+	memset(log_attr, 0, sizeof(*log_attr));
+	log_attr->log_buf = common->log_buf;
+	log_attr->log_size = common->log_size;
+	log_attr->log_level = common->log_level;
+	log_attr->attrs_common = attrs_common;
+
+	if (!log_attr->log_buf)
+		return NULL;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		return ERR_PTR(-ENOMEM);
+
+	err = bpf_vlog_init(log, log_attr->log_level, u64_to_user_ptr(log_attr->log_buf),
+			    log_attr->log_size);
+	if (err) {
+		kfree(log);
+		return ERR_PTR(err);
+	}
+
+	return log;
+}
+
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log)
 {
 	u32 log_true_size, off;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d4a93c008c92..7cc33a48b2bf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1370,7 +1370,7 @@ static bool bpf_net_capable(void)
 
 #define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash_size
 /* called via syscall */
-static int map_create(union bpf_attr *attr, bpfptr_t uattr)
+static int __map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_verifier_log *log)
 {
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
@@ -1382,8 +1382,10 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	int err;
 
 	err = CHECK_ATTR(BPF_MAP_CREATE);
-	if (err)
+	if (err) {
+		bpf_log(log, "Invalid attr.\n");
 		return -EINVAL;
+	}
 
 	/* check BPF_F_TOKEN_FD flag, remember if it's set, and then clear it
 	 * to avoid per-map type checks tripping on unknown flag
@@ -1392,17 +1394,25 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
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
@@ -1410,13 +1420,17 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
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
@@ -1434,8 +1448,10 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 	if (token_flag) {
 		token = bpf_token_get_from_fd(attr->map_token_fd);
-		if (IS_ERR(token))
+		if (IS_ERR(token)) {
+			bpf_log(log, "Invalid map_token_fd.\n");
 			return PTR_ERR(token);
+		}
 
 		/* if current token doesn't grant map creation permissions,
 		 * then we can't use this token, so ignore it and rely on
@@ -1518,8 +1534,10 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 	err = bpf_obj_name_cpy(map->name, attr->map_name,
 			       sizeof(attr->map_name));
-	if (err < 0)
+	if (err < 0) {
+		bpf_log(log, "Invalid map_name.\n");
 		goto free_map;
+	}
 
 	preempt_disable();
 	map->cookie = gen_cookie_next(&bpf_map_cookie);
@@ -1542,6 +1560,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 		btf = btf_get_by_fd(attr->btf_fd);
 		if (IS_ERR(btf)) {
+			bpf_log(log, "Invalid btf_fd.\n");
 			err = PTR_ERR(btf);
 			goto free_map;
 		}
@@ -1569,6 +1588,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 		bpfptr_t uprog_hash = make_bpfptr(attr->excl_prog_hash, uattr.is_kernel);
 
 		if (attr->excl_prog_hash_size != SHA256_DIGEST_SIZE) {
+			bpf_log(log, "Invalid excl_prog_hash_size.\n");
 			err = -EINVAL;
 			goto free_map;
 		}
@@ -1584,6 +1604,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 			goto free_map;
 		}
 	} else if (attr->excl_prog_hash_size) {
+		bpf_log(log, "Invalid excl_prog_hash_size.\n");
 		err = -EINVAL;
 		goto free_map;
 	}
@@ -1622,6 +1643,29 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	return err;
 }
 
+static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_attrs *attrs_common)
+{
+	struct bpf_verifier_log *log;
+	struct bpf_log_attr log_attr;
+	int err, ret;
+
+	log = bpf_log_attr_create_vlog(&log_attr, attrs_common);
+	if (IS_ERR(log))
+		return PTR_ERR(log);
+
+	err = __map_create(attr, uattr, log);
+	if (err >= 0)
+		goto free;
+
+	ret = bpf_log_attr_finalize(&log_attr, log);
+	if (ret)
+		err = ret;
+
+free:
+	kfree(log);
+	return err;
+}
+
 void bpf_map_inc(struct bpf_map *map)
 {
 	atomic64_inc(&map->refcnt);
@@ -6218,7 +6262,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		err = map_create(&attr, uattr);
+		bpf_attrs_init(&attrs_common, &attr_common, uattr_common, size_common);
+		err = map_create(&attr, uattr, &attrs_common);
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
 		err = map_lookup_elem(&attr);
-- 
2.52.0


