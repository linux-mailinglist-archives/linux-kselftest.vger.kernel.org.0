Return-Path: <linux-kselftest+bounces-6175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1B1877CE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 10:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88BBFB211B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9ED22064;
	Mon, 11 Mar 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dFkIyO3E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608722313
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149678; cv=none; b=cyUHJD0EYQMmJ8Ty06bKN09q5H7jMWZBC23iCWo7asnotLgcMm+t9e4LRTDLwXwAWiEUXA0vm/jntWqg4OEWOzrud2DskaPkZV6217GfhOa4s3bbtV2Z7jZBhzyaqyboVHisTISWx8030G+TauzBs4viqcOgMbrKnZ4LiyUF1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149678; c=relaxed/simple;
	bh=WgOYbNC4sr8/QJjarD13fdY4tgnDLuKkSWt1TfHHwEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dL3Qqj82GEAEKDZCp0awEZLhO3xHTv7Fm5c2DFQ7/uEsVlylci3BOOWRLjpOaXcKxPDoNpAJ4sYXIK3InnZbZPpQJbeZFZaswcO9/ELFREAcyebn0FaZeAWvWRafQ/wjpAXN2wORSnuCHcs1qBjjM1sSy3u4Rl2BmMGlZcsuI1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dFkIyO3E; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e55731af5cso1863066b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710149676; x=1710754476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DNwS3vzNHKnmJ9gtI+mTH5qdekBkGxgiUpqVAYV/P4=;
        b=dFkIyO3EN7lpbwxW3ZZEOXgk+Ww5qmsqT8ISo72AWUk1AUTIaQf5El2zk9phFvW/9m
         2VMAKkKscAh44i1wDLMRNVOlxOdok8njO3tqeug8vWqd5rxAgIL3vxKAM/z3Tz3lcLrc
         LyA0juduH/Npjg5AR5rV9zI+e/4agklyyGjTNuQmqsD2J1QhirmWOjscWqUOAynknYVn
         NoEe1FwRQ1K9/HQtAQOFDpghiDUot8NyBO95qC6OSu9dSQZS2yvePdwpcJECbevyVyEv
         7o6ghaHD6/MYbu3SopWHfTj35S038z4ldV9ajPrScM/HdxweUaXteW603e+SWOPyZf9E
         mSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149676; x=1710754476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DNwS3vzNHKnmJ9gtI+mTH5qdekBkGxgiUpqVAYV/P4=;
        b=cPM5JAdRlDZoZJdUyqjGcmkE0spzwU7brElIXyKEeXnavtpJTYwLKi6hTsc2qI8iOJ
         WR2EGfw+ZwsJzS4we8yirwfZpUMMS7Bmu05ERDcK4QFBe7+t1CuF5xcq8hqUQEhLwXdH
         dZKeunW8xx62SOIIxLLk796En6rIkQCvtzP8HY7REOCYJRDKqoc46Z5nlSlHaOONYvqk
         G8Tey8aYGIMzWzJwchIzZlFu3qIf7bVvSq0BcbPCHIJLkjy/qHCgb7zdOJgR4NiOqwNb
         fLU0yQUPhNaLsRU7RL3SZGWtX6i4mwJq2ibYEQ838yaCQRiZpIqPZF+LtoBJIb/dqcbL
         k7Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV/wwFQIWYgrLUcAFmzb9vEUYCrkwX7p40ZdDHxSZm0Rtlkgqd9fuYgmnirTFGyTeJdYa6LkSkLuIi7aEs9uzsIuKmzyTnSbGH5rQZ+A6gP
X-Gm-Message-State: AOJu0YxY8uSWZwLCe7z9dSd69e4ksMfgfwCW1aoOACWCKObCTxuzmyLv
	qUcJaKsQrKDYdBSYD9hG8BEQw6BqR8OfzrIEPszAMDsVNiFaMbJyHK2nW55383M=
X-Google-Smtp-Source: AGHT+IHp6WfuUeDSjQx2cauv1mQ/eMbX3s4chl5kJVOY3tZJvKu5JYf89lzfYO6yWTa1+IHjqNIpUg==
X-Received: by 2002:a05:6a21:7890:b0:1a1:6cf5:5bf1 with SMTP id bf16-20020a056a21789000b001a16cf55bf1mr3944233pzc.12.1710149676017;
        Mon, 11 Mar 2024 02:34:36 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001dcad9cbf8bsm4253365plw.239.2024.03.11.02.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:34:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/9] bpf: tracing: add support to record and check the accessed args
Date: Mon, 11 Mar 2024 17:35:18 +0800
Message-Id: <20240311093526.1010158-2-dongmenglong.8@bytedance.com>
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

In this commit, we add the 'accessed_args' field to struct bpf_prog_aux,
which is used to record the accessed index of the function args in
btf_ctx_access().

Meanwhile, we add the function btf_check_func_part_match() to compare the
accessed function args of two function prototype. This function will be
used in the following commit.

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 include/linux/bpf.h |   4 ++
 kernel/bpf/btf.c    | 108 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 95e07673cdc1..0f677fdcfcc7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1461,6 +1461,7 @@ struct bpf_prog_aux {
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
 	const char *attach_func_name;
+	u64 accessed_args;
 	struct bpf_prog **func;
 	void *jit_data; /* JIT specific data. arch dependent */
 	struct bpf_jit_poke_descriptor *poke_tab;
@@ -2565,6 +2566,9 @@ struct bpf_reg_state;
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog);
 int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *prog,
 			 struct btf *btf, const struct btf_type *t);
+int btf_check_func_part_match(struct btf *btf1, const struct btf_type *t1,
+			      struct btf *btf2, const struct btf_type *t2,
+			      u64 func_args);
 const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type *pt,
 				    int comp_idx, const char *tag_key);
 int btf_find_next_decl_tag(const struct btf *btf, const struct btf_type *pt,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 170d017e8e4a..c2a0299d4358 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6125,19 +6125,24 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 }
 
 static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
-			   int off)
+			   int off, int *aligned_idx)
 {
 	const struct btf_param *args;
 	const struct btf_type *t;
 	u32 offset = 0, nr_args;
 	int i;
 
+	if (aligned_idx)
+		*aligned_idx = -ENOENT;
+
 	if (!func_proto)
 		return off / 8;
 
 	nr_args = btf_type_vlen(func_proto);
 	args = (const struct btf_param *)(func_proto + 1);
 	for (i = 0; i < nr_args; i++) {
+		if (aligned_idx && offset == off)
+			*aligned_idx = i;
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 		offset += btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
 		if (off < offset)
@@ -6207,7 +6212,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			tname, off);
 		return false;
 	}
-	arg = get_ctx_arg_idx(btf, t, off);
+	arg = get_ctx_arg_idx(btf, t, off, NULL);
 	args = (const struct btf_param *)(t + 1);
 	/* if (t == NULL) Fall back to default BPF prog with
 	 * MAX_BPF_FUNC_REG_ARGS u64 arguments.
@@ -6217,6 +6222,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		/* skip first 'void *__data' argument in btf_trace_##name typedef */
 		args++;
 		nr_args--;
+		prog->aux->accessed_args |= (1 << (arg + 1));
+	} else {
+		prog->aux->accessed_args |= (1 << arg);
 	}
 
 	if (arg > nr_args) {
@@ -7024,6 +7032,102 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
 	return btf_check_func_type_match(log, btf1, t1, btf2, t2);
 }
 
+static u32 get_ctx_arg_total_size(struct btf *btf, const struct btf_type *t)
+{
+	const struct btf_param *args;
+	u32 size = 0, nr_args;
+	int i;
+
+	nr_args = btf_type_vlen(t);
+	args = (const struct btf_param *)(t + 1);
+	for (i = 0; i < nr_args; i++) {
+		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
+		size += btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
+	}
+
+	return size;
+}
+
+/* This function is similar to btf_check_func_type_match(), except that it
+ * only compare some function args of the function prototype t1 and t2.
+ */
+int btf_check_func_part_match(struct btf *btf1, const struct btf_type *func1,
+			      struct btf *btf2, const struct btf_type *func2,
+			      u64 func_args)
+{
+	const struct btf_param *args1, *args2;
+	u32 nargs1, i, offset = 0;
+	const char *s1, *s2;
+
+	if (!btf_type_is_func_proto(func1) || !btf_type_is_func_proto(func2))
+		return -EINVAL;
+
+	args1 = (const struct btf_param *)(func1 + 1);
+	args2 = (const struct btf_param *)(func2 + 1);
+	nargs1 = btf_type_vlen(func1);
+
+	for (i = 0; i <= nargs1; i++) {
+		const struct btf_type *t1, *t2;
+
+		if (!(func_args & (1 << i)))
+			goto next;
+
+		if (i < nargs1) {
+			int t2_index;
+
+			/* get the index of the arg corresponding to args1[i]
+			 * by the offset.
+			 */
+			get_ctx_arg_idx(btf2, func2, offset, &t2_index);
+			if (t2_index < 0)
+				return -EINVAL;
+
+			t1 = btf_type_skip_modifiers(btf1, args1[i].type, NULL);
+			t2 = btf_type_skip_modifiers(btf2, args2[t2_index].type,
+						     NULL);
+		} else {
+			/* i == nargs1, this is the index of return value of t1 */
+			if (get_ctx_arg_total_size(btf1, func1) !=
+			    get_ctx_arg_total_size(btf2, func2))
+				return -EINVAL;
+
+			/* check the return type of t1 and t2 */
+			t1 = btf_type_skip_modifiers(btf1, func1->type, NULL);
+			t2 = btf_type_skip_modifiers(btf2, func2->type, NULL);
+		}
+
+		if (t1->info != t2->info ||
+		    (btf_type_has_size(t1) && t1->size != t2->size))
+			return -EINVAL;
+		if (btf_type_is_int(t1) || btf_is_any_enum(t1))
+			goto next;
+
+		if (btf_type_is_struct(t1))
+			goto on_struct;
+
+		if (!btf_type_is_ptr(t1))
+			return -EINVAL;
+
+		t1 = btf_type_skip_modifiers(btf1, t1->type, NULL);
+		t2 = btf_type_skip_modifiers(btf2, t2->type, NULL);
+		if (!btf_type_is_struct(t1) || !btf_type_is_struct(t2))
+			return -EINVAL;
+
+on_struct:
+		s1 = btf_name_by_offset(btf1, t1->name_off);
+		s2 = btf_name_by_offset(btf2, t2->name_off);
+		if (strcmp(s1, s2))
+			return -EINVAL;
+next:
+		if (i < nargs1) {
+			t1 = btf_type_skip_modifiers(btf1, args1[i].type, NULL);
+			offset += btf_type_is_ptr(t1) ? 8 : roundup(t1->size, 8);
+		}
+	}
+
+	return 0;
+}
+
 static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_type *t)
 {
 	const char *name;
-- 
2.39.2


