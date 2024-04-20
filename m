Return-Path: <linux-kselftest+bounces-8538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7368F8ABA7C
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8B11F21EAB
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A6417589;
	Sat, 20 Apr 2024 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jctd/8Vs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCD383AE;
	Sat, 20 Apr 2024 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604182; cv=none; b=mMZw8aNRkdotu2tTQ0IFVzFN/03JGw9mf3187HCDzHNJ8wOgaiqJ80WBpd0YNRUrB6wrUN7a5j8OP2apW8grRc+15lppzLFj/xPwo1Q5BKA/nevkFaZUkhFKSQFpAfncwsehCXB22rMXl5x7hgA1TsI4b7ZQCtKBpHFkNDl2H5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604182; c=relaxed/simple;
	bh=TykgoeQW4o5glV/JPDkSHeUsblRfjnePfjKqulwdk8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CkaiidDzZ9nbVwEjSqF+/XdM1O05we8vGduMp9o7+UGT43t+IlArDljUCasnxy5E8RHUYJTlesjRXvBMwFzoG/5/aTKSGBlRIdy236RN76l+6WrTZFD594BKHmv9DBQzF/UTgG+YXOdGf8pBRX9eUPTDV9KOLQIU5IL8ZdD/k3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jctd/8Vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB77C072AA;
	Sat, 20 Apr 2024 09:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604182;
	bh=TykgoeQW4o5glV/JPDkSHeUsblRfjnePfjKqulwdk8o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jctd/8Vs33Biw5Mj2XhsrXA+V0MQFYOn21VwaJnD4vw/cDU8/loqe1xhEy1j4NrrB
	 LpF0RdsVQ4w6KsvORCd5HRmVdyKmjW9Hwxl5bpDl9JOe+brKQu5eKgySd2zKH30dRq
	 quqm+iL2fSmvFSkHCxP8wYncCw5f5yd+FIpDywd5Tnc+cW5oes1lB3hkfIUYyZnJCx
	 LTzXeRG6BSfd+XWFhtdyQQgdZ41wDiiohfl/zdI2DZkLcdtE5AQjqSDdjsrEjMoftX
	 1Ww+EQvcSkM4rwTGHGSkzyTFc2wCw5gW9RvyWCANOBGJB2OvfGcoXb+Y0h6cNgoLzQ
	 JhuEZCH0GC48A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:05 +0200
Subject: [PATCH bpf-next v2 05/16] bpf: add support for bpf_wq user type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-5-6c986a5a741f@kernel.org>
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=7256;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=TykgoeQW4o5glV/JPDkSHeUsblRfjnePfjKqulwdk8o=;
 b=32UQJVMCNon4qshqEeslR3rvtSgHEk5dW5HFl+sPXmlSY0H74XCxrX0BwVw3Nya785/WkwFUF
 mJg6QmYu8LkAcrptibVyiffECdbNuvPeOpf24UxksXCMv6XjwUk/96V
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Mostly a copy/paste from the bpf_timer API, without the initialization
and free, as they will be done in a separate patch.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 include/linux/bpf.h      | 11 ++++++++++-
 include/uapi/linux/bpf.h |  4 ++++
 kernel/bpf/btf.c         | 17 +++++++++++++++++
 kernel/bpf/syscall.c     |  6 +++++-
 kernel/bpf/verifier.c    |  9 +++++++++
 5 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5034c1b4ded7..c7dcfd395555 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -185,7 +185,7 @@ struct bpf_map_ops {
 
 enum {
 	/* Support at most 10 fields in a BTF type */
-	BTF_FIELDS_MAX	   = 10,
+	BTF_FIELDS_MAX	   = 11,
 };
 
 enum btf_field_type {
@@ -202,6 +202,7 @@ enum btf_field_type {
 	BPF_GRAPH_NODE = BPF_RB_NODE | BPF_LIST_NODE,
 	BPF_GRAPH_ROOT = BPF_RB_ROOT | BPF_LIST_HEAD,
 	BPF_REFCOUNT   = (1 << 9),
+	BPF_WORKQUEUE  = (1 << 10),
 };
 
 typedef void (*btf_dtor_kfunc_t)(void *);
@@ -238,6 +239,7 @@ struct btf_record {
 	u32 field_mask;
 	int spin_lock_off;
 	int timer_off;
+	int wq_off;
 	int refcount_off;
 	struct btf_field fields[];
 };
@@ -312,6 +314,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "bpf_spin_lock";
 	case BPF_TIMER:
 		return "bpf_timer";
+	case BPF_WORKQUEUE:
+		return "bpf_wq";
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 		return "kptr";
@@ -340,6 +344,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 		return sizeof(struct bpf_spin_lock);
 	case BPF_TIMER:
 		return sizeof(struct bpf_timer);
+	case BPF_WORKQUEUE:
+		return sizeof(struct bpf_wq);
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
@@ -367,6 +373,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 		return __alignof__(struct bpf_spin_lock);
 	case BPF_TIMER:
 		return __alignof__(struct bpf_timer);
+	case BPF_WORKQUEUE:
+		return __alignof__(struct bpf_wq);
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
@@ -406,6 +414,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 		/* RB_ROOT_CACHED 0-inits, no need to do anything after memset */
 	case BPF_SPIN_LOCK:
 	case BPF_TIMER:
+	case BPF_WORKQUEUE:
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index cee0a7915c08..e4ae83550fb3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7306,6 +7306,10 @@ struct bpf_timer {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
 
+struct bpf_wq {
+	__u64 __opaque[2];
+} __attribute__((aligned(8)));
+
 struct bpf_dynptr {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 90c4a32d89ff..a9b5b28a2630 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3464,6 +3464,15 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 			goto end;
 		}
 	}
+	if (field_mask & BPF_WORKQUEUE) {
+		if (!strcmp(name, "bpf_wq")) {
+			if (*seen_mask & BPF_WORKQUEUE)
+				return -E2BIG;
+			*seen_mask |= BPF_WORKQUEUE;
+			type = BPF_WORKQUEUE;
+			goto end;
+		}
+	}
 	field_mask_test_name(BPF_LIST_HEAD, "bpf_list_head");
 	field_mask_test_name(BPF_LIST_NODE, "bpf_list_node");
 	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
@@ -3515,6 +3524,7 @@ static int btf_find_struct_field(const struct btf *btf,
 		switch (field_type) {
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
+		case BPF_WORKQUEUE:
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
 		case BPF_REFCOUNT:
@@ -3582,6 +3592,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		switch (field_type) {
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
+		case BPF_WORKQUEUE:
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
 		case BPF_REFCOUNT:
@@ -3816,6 +3827,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 
 	rec->spin_lock_off = -EINVAL;
 	rec->timer_off = -EINVAL;
+	rec->wq_off = -EINVAL;
 	rec->refcount_off = -EINVAL;
 	for (i = 0; i < cnt; i++) {
 		field_type_size = btf_field_type_size(info_arr[i].type);
@@ -3846,6 +3858,11 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			/* Cache offset for faster lookup at runtime */
 			rec->timer_off = rec->fields[i].offset;
 			break;
+		case BPF_WORKQUEUE:
+			WARN_ON_ONCE(rec->wq_off >= 0);
+			/* Cache offset for faster lookup at runtime */
+			rec->wq_off = rec->fields[i].offset;
+			break;
 		case BPF_REFCOUNT:
 			WARN_ON_ONCE(rec->refcount_off >= 0);
 			/* Cache offset for faster lookup at runtime */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7d392ec83655..0848e4141b00 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -559,6 +559,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
+		case BPF_WORKQUEUE:
 			/* Nothing to release */
 			break;
 		default:
@@ -608,6 +609,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
+		case BPF_WORKQUEUE:
 			/* Nothing to acquire */
 			break;
 		default:
@@ -679,6 +681,8 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 		case BPF_TIMER:
 			bpf_timer_cancel_and_free(field_ptr);
 			break;
+		case BPF_WORKQUEUE:
+			break;
 		case BPF_KPTR_UNREF:
 			WRITE_ONCE(*(u64 *)field_ptr, 0);
 			break;
@@ -1085,7 +1089,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 
 	map->record = btf_parse_fields(btf, value_type,
 				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
-				       BPF_RB_ROOT | BPF_REFCOUNT,
+				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE,
 				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2aad6d90550f..deaf2e1ab690 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1838,6 +1838,8 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 			 */
 			if (btf_record_has_field(map->inner_map_meta->record, BPF_TIMER))
 				reg->map_uid = reg->id;
+			if (btf_record_has_field(map->inner_map_meta->record, BPF_WORKQUEUE))
+				reg->map_uid = reg->id;
 		} else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
 			reg->type = PTR_TO_XDP_SOCK;
 		} else if (map->map_type == BPF_MAP_TYPE_SOCKMAP ||
@@ -18155,6 +18157,13 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		}
 	}
 
+	if (btf_record_has_field(map->record, BPF_WORKQUEUE)) {
+		if (is_tracing_prog_type(prog_type)) {
+			verbose(env, "tracing progs cannot use bpf_wq yet\n");
+			return -EINVAL;
+		}
+	}
+
 	if ((bpf_prog_is_offloaded(prog->aux) || bpf_map_is_offloaded(map)) &&
 	    !bpf_offload_prog_map_match(prog, map)) {
 		verbose(env, "offload device mismatch between prog and map\n");

-- 
2.44.0


