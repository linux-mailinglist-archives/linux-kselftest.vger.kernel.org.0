Return-Path: <linux-kselftest+bounces-6180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC4C877D00
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 10:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF5DB214DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587B1182CF;
	Mon, 11 Mar 2024 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PJ37o6q+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF403C097
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149717; cv=none; b=VcvxqO5lgtzikJyOdj4myylA1digp9b7M/N2DFLS3PU+jtKhk5Bxv8mAZfpQa9X0qLe3c7bh1cJd8342Bc4S9TLMrVjzAQBuwLND5v6EePs/lgjBhGz3Z40cHJWZqOOknHsGj2q/DbQPUChqXzRoSAo5uHILc9upuA8T1+Awv3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149717; c=relaxed/simple;
	bh=5yrNkXsmiVwG0cDbfE3tyiE7ULVW96PO0jWtPWePKH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X1goSKPSi99g79xiohRDLMZG6uMAhAPQh15oNFsanfTZuJ9q42AwrN6qRTkoGE4IcLdEEo1iwNN6+oeMOr7KFi/l+HzM4RGNUINEQGjVjx3KNG95SZfxWN8rIvHnOTQ+iR5SbapAG+//oi/01rx2qooly/KumrbVqcSFwtg4s+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PJ37o6q+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc49b00bdbso19974465ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710149714; x=1710754514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXY72K13/QWs+XYqq+1yre2I5i9spjZlqZiX5c3uWc8=;
        b=PJ37o6q+ts5vfjZv9xBt2UU5r8dmqXF0DMmVsVWfvlSMvHivUOeGyMxS3OoCy2OwPe
         KN5mpZilEOqN6S3akNnE0dVoY6bjke7s/vVU0ieNlMTe8mrxRPjtPAFD9GIQrekqY11O
         0eaj6k/hSjxHYx63BiofKluEVKgxIdncBEq6jR68yi/GjOctI4oLxYYw64niqVKCd8DP
         +3sL5YB9JhYdSq66y+WEJ6gw2LdJuwLFsKWnSjlHQ5XJBW4opAA0stmvzYTHA7uRsQSw
         6Kv5w1W4TX+Az18y2e/xUqZsYq9Jkm4YVJzkl950gwJkblv50tdnUgc1tcbCec6mtyE2
         eYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149714; x=1710754514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXY72K13/QWs+XYqq+1yre2I5i9spjZlqZiX5c3uWc8=;
        b=XGg/wzQS0zg4aYMLsEB5ee7fxr+yNI3ApmA9ujd4x95uGLw00MlMGQ2DG11PeTCOPL
         WrWcoy6X5n6yk9EreUT/24qPErvSyuEfxNNyJCS+fp2QwpYjf2/5XRCx595m2IrH63w1
         2AR4Tl33h9cCrHFCwjMJYfYuvhkY4SHeQaRjq8H8PAHAjydXn3LJU/70kfB3k7rQrGVU
         TFCP5xLWI0z29F2SF6e6h08TjfPeDdSqOZbD3dv3xMLIIq4d7TuCFtZwr9tP88HTTmDE
         EcAOTFGLvew8Cz6dNipCW7J+jmozw3PDrKlKQHZEf7z7XuyB0uJclypW0V+WJpB+3/Y5
         DUxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFqyZsHeJBOFTDwafawhK1fYtHUVfeXqmnxQ6AxZwq83JWLGlzVQkgWfOViyZz8F2QffmFahSVvJctle38b0fKqqSI+MGBKPnZg2bjUAg/
X-Gm-Message-State: AOJu0Yx+v2C5+fiwhqoCwLATmup8JXJcdhREeaEKdoSdiHAREL440tZM
	UkqPukxOBbWwjq3JWJL7Uqg0PeWxzn78VtfSgMbH4LmyfYvVI5cK0aWRhlapaCk=
X-Google-Smtp-Source: AGHT+IG1tHZkGA6ilF0C9eA74u4gWwk/Df5+HU+geMG3CnFVxYVwwj+wjdOVgVKG4WncqAPf+3Dvvw==
X-Received: by 2002:a17:902:e806:b0:1dd:88cf:205c with SMTP id u6-20020a170902e80600b001dd88cf205cmr4529480plg.28.1710149714274;
        Mon, 11 Mar 2024 02:35:14 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001dcad9cbf8bsm4253365plw.239.2024.03.11.02.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:35:14 -0700 (PDT)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	quentin@isovalent.com,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Menglong Dong <dongmenglong.8@bytedance.com>
Subject: [PATCH bpf-next v2 6/9] bpf: tracing: add multi-link support
Date: Mon, 11 Mar 2024 17:35:23 +0800
Message-Id: <20240311093526.1010158-7-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we add the support to allow attaching a tracing BPF
program to multi hooks, which is similar to BPF_TRACE_KPROBE_MULTI.

The use case is obvious. For now, we have to create a BPF program for each
kernel function, for which we want to trace, even through all the program
have the same (or similar logic). This can consume extra memory, and make
the program loading slow if we have plenty of kernel function to trace.
The KPROBE_MULTI maybe a alternative, but it can't do what TRACING do. For
example, the kretprobe can't obtain the function args, but the FEXIT can.

For now, we support to create multi-link for fentry/fexit/modify_return
with the following new attach types that we introduce:

  BPF_TRACE_FENTRY_MULTI
  BPF_TRACE_FEXIT_MULTI
  BPF_MODIFY_RETURN_MULTI

We introduce the struct bpf_tracing_multi_link for this purpose, which
can hold all the kernel modules, target bpf program (for attaching to bpf
program) or target btf (for attaching to kernel function) that we
referenced. Meanwhiles, every trampoline for the function that we attach
to is also stored in "struct bpf_tramp_multi_link_entry *entries" in
struct bpf_tramp_multi_link.

During loading, the first target is used for verification by the verifer.
And during attaching, we check the consistency of all the targets with
the target that we loaded, which is the first target.

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 include/linux/bpf.h            |  11 +
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |  10 +
 kernel/bpf/btf.c               |   5 +
 kernel/bpf/syscall.c           | 379 +++++++++++++++++++++++++++++++++
 kernel/bpf/trampoline.c        |   7 +-
 kernel/bpf/verifier.c          |  16 +-
 net/core/bpf_sk_storage.c      |   2 +
 tools/include/uapi/linux/bpf.h |  10 +
 9 files changed, 438 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e8f17d9f022..28fac2d0964a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1635,6 +1635,17 @@ struct bpf_tracing_link {
 	struct bpf_prog *tgt_prog;
 };
 
+struct bpf_tracing_multi_link {
+	struct bpf_tramp_multi_link link;
+	enum bpf_attach_type attach_type;
+	u32 prog_cnt;
+	u32 btf_cnt;
+	struct bpf_prog **tgt_progs;
+	struct btf **tgt_btfs;
+	u32 mods_cnt;
+	struct module **mods;
+};
+
 struct bpf_link_primer {
 	struct bpf_link *link;
 	struct file *file;
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 94baced5a1ad..a93195bd825a 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -152,3 +152,4 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
 BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
 BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
 BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
+BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING_MULTI, tracing_multi)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 85ec7fc799d7..f01c4f463c0d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1114,6 +1114,9 @@ enum bpf_attach_type {
 	BPF_CGROUP_UNIX_GETSOCKNAME,
 	BPF_NETKIT_PRIMARY,
 	BPF_NETKIT_PEER,
+	BPF_TRACE_FENTRY_MULTI,
+	BPF_TRACE_FEXIT_MULTI,
+	BPF_MODIFY_RETURN_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1134,6 +1137,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_TCX = 11,
 	BPF_LINK_TYPE_UPROBE_MULTI = 12,
 	BPF_LINK_TYPE_NETKIT = 13,
+	BPF_LINK_TYPE_TRACING_MULTI = 14,
 	__MAX_BPF_LINK_TYPE,
 };
 
@@ -1726,6 +1730,12 @@ union bpf_attr {
 				 */
 				__u64		cookie;
 			} tracing;
+			struct {
+				__u32		cnt;
+				__aligned_u64	tgt_fds;
+				__aligned_u64	btf_ids;
+				__aligned_u64	cookies;
+			} tracing_multi;
 			struct {
 				__u32		pf;
 				__u32		hooknum;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c2a0299d4358..2d6e9e680091 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5879,6 +5879,9 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
+		case BPF_MODIFY_RETURN_MULTI:
 			/* allow u64* as ctx */
 			if (btf_is_int(t) && t->size == 8)
 				return 0;
@@ -6238,6 +6241,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		case BPF_LSM_CGROUP:
 		case BPF_LSM_MAC:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FEXIT_MULTI:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
 			 * int LSM hooks, they use MODIFY_RETURN trampolines.
@@ -6256,6 +6260,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			t = btf_type_by_id(btf, t->type);
 			break;
 		case BPF_MODIFY_RETURN:
+		case BPF_MODIFY_RETURN_MULTI:
 			/* For now the BPF_MODIFY_RETURN can only be attached to
 			 * functions that return an int.
 			 */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6128c3131141..3e45584e4898 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3273,6 +3273,34 @@ static const struct bpf_link_ops bpf_tracing_link_lops = {
 	.fill_link_info = bpf_tracing_link_fill_link_info,
 };
 
+static int bpf_tracing_check_multi(struct bpf_prog *prog,
+				   struct bpf_prog *tgt_prog,
+				   struct btf *btf2,
+				   const struct btf_type *t2)
+{
+	const struct btf_type *t1;
+	struct btf *btf1;
+
+	/* this case is already valided in bpf_check_attach_target() */
+	if (prog->type == BPF_PROG_TYPE_EXT)
+		return 0;
+
+	btf1 = prog->aux->dst_prog ? prog->aux->dst_prog->aux->btf :
+				     prog->aux->attach_btf;
+	if (!btf1)
+		return -EOPNOTSUPP;
+
+	btf2 = btf2 ?: tgt_prog->aux->btf;
+	t1 = prog->aux->attach_func_proto;
+
+	/* the target is the same as the origin one, this is a re-attach */
+	if (t1 == t2)
+		return 0;
+
+	return btf_check_func_part_match(btf1, t1, btf2, t2,
+					 prog->aux->accessed_args);
+}
+
 static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 				   int tgt_prog_fd,
 				   u32 btf_id,
@@ -3473,6 +3501,350 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	return err;
 }
 
+static void __bpf_tracing_multi_link_release(struct bpf_tracing_multi_link *link)
+{
+	int i;
+
+	if (link->mods_cnt) {
+		for (i = 0; i < link->mods_cnt; i++)
+			module_put(link->mods[i]);
+		kfree(link->mods);
+	}
+
+	if (link->prog_cnt) {
+		for (i = 0; i < link->prog_cnt; i++)
+			bpf_prog_put(link->tgt_progs[i]);
+		kfree(link->tgt_progs);
+	}
+
+	if (link->btf_cnt) {
+		for (i = 0; i < link->btf_cnt; i++)
+			btf_put(link->tgt_btfs[i]);
+		kfree(link->tgt_btfs);
+	}
+
+	if (link->link.cnt) {
+		for (i = 0; i < link->link.cnt; i++)
+			bpf_trampoline_put(link->link.entries[i].trampoline);
+		kfree(link->link.entries);
+	}
+}
+
+static void bpf_tracing_multi_link_release(struct bpf_link *link)
+{
+	struct bpf_tracing_multi_link *multi_link =
+		container_of(link, struct bpf_tracing_multi_link, link.link);
+
+	bpf_trampoline_multi_unlink_prog(&multi_link->link);
+	__bpf_tracing_multi_link_release(multi_link);
+}
+
+static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link.link);
+
+	kfree(tr_link);
+}
+
+static void bpf_tracing_multi_link_show_fdinfo(const struct bpf_link *link,
+					 struct seq_file *seq)
+{
+	struct bpf_tracing_multi_link *tr_link =
+		container_of(link, struct bpf_tracing_multi_link, link.link);
+	u32 target_btf_id, target_obj_id;
+	int i;
+
+	for (i = 0; i < tr_link->link.cnt; i++) {
+		bpf_trampoline_unpack_key(tr_link->link.entries[i].trampoline->key,
+					  &target_obj_id, &target_btf_id);
+		seq_printf(seq,
+			   "attach_type:\t%d\n"
+			   "target_obj_id:\t%u\n"
+			   "target_btf_id:\t%u\n",
+			   tr_link->attach_type,
+			   target_obj_id,
+			   target_btf_id);
+	}
+}
+
+static const struct bpf_link_ops bpf_tracing_multi_link_lops = {
+	.release = bpf_tracing_multi_link_release,
+	.dealloc = bpf_tracing_multi_link_dealloc,
+	.show_fdinfo = bpf_tracing_multi_link_show_fdinfo,
+};
+
+#define MAX_TRACING_MULTI_CNT	1024
+
+static int bpf_tracing_get_target(u32 fd, struct bpf_prog **tgt_prog,
+				  struct btf **tgt_btf)
+{
+	struct bpf_prog *prog = NULL;
+	struct btf *btf = NULL;
+	int err = 0;
+
+	if (fd) {
+		prog = bpf_prog_get(fd);
+		if (!IS_ERR(prog))
+			goto found;
+
+		prog = NULL;
+		/* "fd" is the fd of the kernel module BTF */
+		btf = btf_get_by_fd(fd);
+		if (IS_ERR(btf)) {
+			err = PTR_ERR(btf);
+			goto err;
+		}
+		if (!btf_is_kernel(btf)) {
+			btf_put(btf);
+			err = -EOPNOTSUPP;
+			goto err;
+		}
+	} else {
+		btf = bpf_get_btf_vmlinux();
+		if (IS_ERR(btf)) {
+			err = PTR_ERR(btf);
+			goto err;
+		}
+		if (!btf) {
+			err = -EINVAL;
+			goto err;
+		}
+		btf_get(btf);
+	}
+found:
+	*tgt_prog = prog;
+	*tgt_btf = btf;
+	return 0;
+err:
+	*tgt_prog = NULL;
+	*tgt_btf = NULL;
+	return err;
+}
+
+static int bpf_tracing_multi_link_check(const union bpf_attr *attr, u32 **btf_ids,
+					u32 **tgt_fds, u64 **cookies,
+					u32 cnt)
+{
+	void __user *ubtf_ids;
+	void __user *utgt_fds;
+	void __user *ucookies;
+	void *tmp;
+	int i;
+
+	if (!cnt)
+		return -EINVAL;
+
+	if (cnt > MAX_TRACING_MULTI_CNT)
+		return -E2BIG;
+
+	ucookies = u64_to_user_ptr(attr->link_create.tracing_multi.cookies);
+	if (ucookies) {
+		tmp = kvmalloc_array(cnt, sizeof(**cookies), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+
+		*cookies = tmp;
+		if (copy_from_user(tmp, ucookies, cnt * sizeof(**cookies)))
+			return -EFAULT;
+	}
+
+	utgt_fds = u64_to_user_ptr(attr->link_create.tracing_multi.tgt_fds);
+	if (utgt_fds) {
+		tmp = kvmalloc_array(cnt, sizeof(**tgt_fds), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+
+		*tgt_fds = tmp;
+		if (copy_from_user(tmp, utgt_fds, cnt * sizeof(**tgt_fds)))
+			return -EFAULT;
+	}
+
+	ubtf_ids = u64_to_user_ptr(attr->link_create.tracing_multi.btf_ids);
+	if (!ubtf_ids)
+		return -EINVAL;
+
+	tmp = kvmalloc_array(cnt, sizeof(**btf_ids), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	*btf_ids = tmp;
+	if (copy_from_user(tmp, ubtf_ids, cnt * sizeof(**btf_ids)))
+		return -EFAULT;
+
+	for (i = 0; i < cnt; i++) {
+		if (!(*btf_ids)[i])
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void bpf_tracing_multi_link_ptr_fill(struct bpf_tracing_multi_link *link,
+					    struct ptr_array *progs,
+					    struct ptr_array *mods,
+					    struct ptr_array *btfs)
+{
+	link->mods = (struct module **) mods->ptrs;
+	link->mods_cnt = mods->cnt;
+	link->tgt_btfs = (struct btf **) btfs->ptrs;
+	link->btf_cnt = btfs->cnt;
+	link->tgt_progs = (struct bpf_prog **) progs->ptrs;
+	link->prog_cnt = progs->cnt;
+}
+
+static int bpf_tracing_prog_attach_multi(const union bpf_attr *attr,
+					 struct bpf_prog *prog)
+{
+	struct bpf_tracing_multi_link *link = NULL;
+	u32 cnt, *btf_ids = NULL, *tgt_fds = NULL;
+	struct bpf_link_primer link_primer;
+	struct ptr_array prog_array = { };
+	struct ptr_array btf_array = { };
+	struct ptr_array mod_array = { };
+	u64 *cookies = NULL;
+	int err = 0, i;
+
+	if ((prog->expected_attach_type != BPF_TRACE_FENTRY_MULTI &&
+	     prog->expected_attach_type != BPF_TRACE_FEXIT_MULTI &&
+	     prog->expected_attach_type != BPF_MODIFY_RETURN_MULTI) ||
+	    prog->type != BPF_PROG_TYPE_TRACING)
+		return -EINVAL;
+
+	cnt = attr->link_create.tracing_multi.cnt;
+	err = bpf_tracing_multi_link_check(attr, &btf_ids, &tgt_fds, &cookies,
+					   cnt);
+	if (err)
+		goto err_out;
+
+	link = kzalloc(sizeof(*link), GFP_USER);
+	if (!link) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	link->link.entries = kzalloc(sizeof(*link->link.entries) * cnt,
+				     GFP_USER);
+	if (!link->link.entries) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING_MULTI,
+		      &bpf_tracing_multi_link_lops, prog);
+	link->attach_type = prog->expected_attach_type;
+
+	mutex_lock(&prog->aux->dst_mutex);
+
+	/* program is already attached, re-attach is not supported here yet */
+	if (!prog->aux->dst_trampoline) {
+		err = -EEXIST;
+		goto err_out_unlock;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		struct bpf_attach_target_info tgt_info = {};
+		struct bpf_tramp_multi_link_entry *entry;
+		struct bpf_prog *tgt_prog = NULL;
+		struct bpf_trampoline *tr = NULL;
+		u32 tgt_fd, btf_id = btf_ids[i];
+		struct btf *tgt_btf = NULL;
+		struct module *mod = NULL;
+		u64 key = 0;
+
+		entry = &link->link.entries[i];
+		tgt_fd = tgt_fds ? tgt_fds[i] : 0;
+		err = bpf_tracing_get_target(tgt_fd, &tgt_prog, &tgt_btf);
+		if (err)
+			goto err_out_unlock;
+
+		if (tgt_prog) {
+			err = bpf_try_add_ptr(&prog_array, tgt_prog);
+			if (err) {
+				bpf_prog_put(tgt_prog);
+				if (err != -EEXIST)
+					goto err_out_unlock;
+			}
+		}
+
+		if (tgt_btf) {
+			err = bpf_try_add_ptr(&btf_array, tgt_btf);
+			if (err) {
+				btf_put(tgt_btf);
+				if (err != -EEXIST)
+					goto err_out_unlock;
+			}
+		}
+
+		prog->aux->attach_tracing_prog = tgt_prog &&
+			tgt_prog->type == BPF_PROG_TYPE_TRACING &&
+			prog->type == BPF_PROG_TYPE_TRACING;
+
+		err = bpf_check_attach_target(NULL, prog, tgt_prog, tgt_btf,
+					      btf_id, &tgt_info);
+		if (err)
+			goto err_out_unlock;
+
+		mod = tgt_info.tgt_mod;
+		if (mod) {
+			err = bpf_try_add_ptr(&mod_array, mod);
+			if (err) {
+				module_put(mod);
+				if (err != -EEXIST)
+					goto err_out_unlock;
+			}
+		}
+
+		err = bpf_tracing_check_multi(prog, tgt_prog, tgt_btf,
+					      tgt_info.tgt_type);
+		if (err)
+			goto err_out_unlock;
+
+		key = bpf_trampoline_compute_key(tgt_prog, tgt_btf, btf_id);
+		tr = bpf_trampoline_get(key, &tgt_info);
+		if (!tr) {
+			err = -ENOMEM;
+			goto err_out_unlock;
+		}
+
+		entry->conn.cookie = cookies ? cookies[i] : 0;
+		entry->conn.link = &link->link.link;
+		entry->trampoline = tr;
+		link->link.cnt++;
+	}
+
+	err = bpf_trampoline_multi_link_prog(&link->link);
+	if (err)
+		goto err_out_unlock;
+
+	err = bpf_link_prime(&link->link.link, &link_primer);
+	if (err) {
+		bpf_trampoline_multi_unlink_prog(&link->link);
+		goto err_out_unlock;
+	}
+
+	bpf_tracing_multi_link_ptr_fill(link, &prog_array, &mod_array,
+					&btf_array);
+	bpf_trampoline_put(prog->aux->dst_trampoline);
+	prog->aux->dst_trampoline = NULL;
+	mutex_unlock(&prog->aux->dst_mutex);
+
+	kfree(btf_ids);
+	kfree(tgt_fds);
+	kfree(cookies);
+	return bpf_link_settle(&link_primer);
+err_out_unlock:
+	bpf_tracing_multi_link_ptr_fill(link, &prog_array, &mod_array,
+					&btf_array);
+	__bpf_tracing_multi_link_release(link);
+	mutex_unlock(&prog->aux->dst_mutex);
+err_out:
+	kfree(btf_ids);
+	kfree(tgt_fds);
+	kfree(cookies);
+	kfree(link);
+	return err;
+}
+
 struct bpf_raw_tp_link {
 	struct bpf_link link;
 	struct bpf_raw_event_map *btp;
@@ -3924,6 +4296,9 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
+	case BPF_MODIFY_RETURN_MULTI:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
 		return BPF_PROG_TYPE_LSM;
@@ -5201,6 +5576,10 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = bpf_iter_link_attach(attr, uattr, prog);
 		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
 			ret = cgroup_bpf_link_attach(attr, prog);
+		else if (prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
+			 prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
+			 prog->expected_attach_type == BPF_MODIFY_RETURN_MULTI)
+			ret = bpf_tracing_prog_attach_multi(attr, prog);
 		else
 			ret = bpf_tracing_prog_attach(prog,
 						      attr->link_create.target_fd,
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index b00d53af8fcb..6d249303a96e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -111,7 +111,9 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 
 	return (ptype == BPF_PROG_TYPE_TRACING &&
 		(eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
-		 eatype == BPF_MODIFY_RETURN)) ||
+		 eatype == BPF_MODIFY_RETURN ||
+		 eatype == BPF_TRACE_FENTRY_MULTI || eatype == BPF_TRACE_FEXIT_MULTI ||
+		 eatype == BPF_MODIFY_RETURN_MULTI)) ||
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
 
@@ -503,10 +505,13 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 {
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FENTRY_MULTI:
 		return BPF_TRAMP_FENTRY;
 	case BPF_MODIFY_RETURN:
+	case BPF_MODIFY_RETURN_MULTI:
 		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FEXIT_MULTI:
 		return BPF_TRAMP_FEXIT;
 	case BPF_LSM_MAC:
 		if (!prog->aux->attach_func_proto->type)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4493ecc23597..f878edfcf987 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15405,10 +15405,13 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		switch (env->prog->expected_attach_type) {
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
 			range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
 		case BPF_MODIFY_RETURN:
+		case BPF_MODIFY_RETURN_MULTI:
 			return 0;
 		case BPF_TRACE_ITER:
 			break;
@@ -20709,7 +20712,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog_extension &&
 		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -20784,6 +20789,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_MODIFY_RETURN_MULTI:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -20869,7 +20877,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				bpf_log(log, "%s is not sleepable\n", tname);
 				return ret;
 			}
-		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
+		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN ||
+			   prog->expected_attach_type == BPF_MODIFY_RETURN_MULTI) {
 			if (tgt_prog) {
 				module_put(mod);
 				bpf_log(log, "can't modify return codes of BPF programs\n");
@@ -20922,6 +20931,9 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
+		case BPF_TRACE_FENTRY_MULTI:
+		case BPF_TRACE_FEXIT_MULTI:
+		case BPF_MODIFY_RETURN_MULTI:
 			return true;
 		default:
 			return false;
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 6c4d90b24d46..712ae31593e5 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -371,6 +371,8 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 		return true;
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
 		btf_vmlinux = bpf_get_btf_vmlinux();
 		if (IS_ERR_OR_NULL(btf_vmlinux))
 			return false;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 85ec7fc799d7..f01c4f463c0d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1114,6 +1114,9 @@ enum bpf_attach_type {
 	BPF_CGROUP_UNIX_GETSOCKNAME,
 	BPF_NETKIT_PRIMARY,
 	BPF_NETKIT_PEER,
+	BPF_TRACE_FENTRY_MULTI,
+	BPF_TRACE_FEXIT_MULTI,
+	BPF_MODIFY_RETURN_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1134,6 +1137,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_TCX = 11,
 	BPF_LINK_TYPE_UPROBE_MULTI = 12,
 	BPF_LINK_TYPE_NETKIT = 13,
+	BPF_LINK_TYPE_TRACING_MULTI = 14,
 	__MAX_BPF_LINK_TYPE,
 };
 
@@ -1726,6 +1730,12 @@ union bpf_attr {
 				 */
 				__u64		cookie;
 			} tracing;
+			struct {
+				__u32		cnt;
+				__aligned_u64	tgt_fds;
+				__aligned_u64	btf_ids;
+				__aligned_u64	cookies;
+			} tracing_multi;
 			struct {
 				__u32		pf;
 				__u32		hooknum;
-- 
2.39.2


