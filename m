Return-Path: <linux-kselftest+bounces-45539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0181C577A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 13:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C76B3B85E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 12:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6587A34EEF2;
	Thu, 13 Nov 2025 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnkuDPjD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324FC34E75C
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037628; cv=none; b=qimU4E47c2e2yuqLnbz5iJ4XsAs1z0R38SwbQ/ifnt2/UmbC4ZVaUSFJtF4jgUHnsFeI8lbZQfrL3BOIThOomDGV2RyRSrIXWQhDt2Ci5aZrI02j5UFlYmQTfvrhFNw0KIRq1A+UgEZS/cEuLPzezgBFfZ2g5NxXR+qTf95tdXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037628; c=relaxed/simple;
	bh=/SlaGJTkL18pJIV6OQWhS1Oi+1EN1eU1ZBzlHYzFk3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryE8l2ce0XSUYK/PerqpHuvf+ELAXewXyJGu/CeWYjXIWg6JvMPD65MxGnlvtwp87GzY92PJAQCgKZgrzbLsOGPVGnjfKrobbnx5LA+KKe7r20hen0j1Xo9di3JiV39KNKzSltnTlJm4oM3DZpK/lCMJsQHG/xQdlntNWUEA4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnkuDPjD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b32a3e78bso611744f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 04:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763037624; x=1763642424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+HnPpm5RhuiKrpmA4CkyikXxRc8yfLzzeS2SA5/Vpc=;
        b=TnkuDPjD34mR8kKj63VTP4UPs4+fI/xWx9wFMk2V8oX9Rp+4g/EdBjcZuc6qWGjdBk
         AVXLJB9IlSy5xQ8Sqyuk5sFiBYEWxT2mapK1FMP9gx2Vbr81njmngr0Ji3fXVmLBdkA8
         68TxkqMCYFFppaUgsAWA85hVSZ/uPdG4rHB4jGvKC9Zh/ZSKK+bKaHyLGqJi1dw4lUSc
         Ru92o+4hdf7FSjjcnUP9BqBD2EywP+B59I6QrW9IvzOZ22B5qI5FxHCC3NoPK+/44i4E
         +SRxqY/EneMh1zX5ZJ42ziLBcXOrBDqa5oLTYYiRtHIAPq2NDmUXzbsj6Q+hQqDi1JA0
         WiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763037624; x=1763642424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O+HnPpm5RhuiKrpmA4CkyikXxRc8yfLzzeS2SA5/Vpc=;
        b=PFW/YtEkJweAcWdcdbQw+CtQZpC3C6a0Dr3Ycn+Aa/YCARjoUDS/7euN8Ag6WFOHf6
         rYj/MnlFqqc95LH9ToRobK/Qi+Qr6IUQwY4NQj2KftWd9KD4+oW5lfk7afMvwKpTcAc3
         8bjaCPHV0nrHSJHrehiXIHOhYMwYQul5cVG+7Q/XjRBiTAZFNjxbOS2ZH39YPZXnrRIx
         usC8vwO1oFlle70qz16ccUiGoE+/9a8PEC9P/XcCKdAmnP4NU+JQ5dBxeCBAYGeaver8
         ElsxY+/QYtrUY42SjchCKIYmkq3MclztoW0YP64/GdCPoRE/DXHwYOAeLYQLrpoJHU7v
         BwsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVatIs/xGWQGYeOuQLL6m1jedonwu0Le9IWkuv08/fZAwNQC5/MqB1DeAWxzJAiBok/1f7lkILjnDl/EANIwhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsq0fZl22UJRtYvnIRM6/rj3Mx0hk0mwvgCk3O0mmKtU/o5aUk
	WHNn1poLQqUnjBAB2Cxv7GVsZQ/RloNm7B0CA9MMr2Y1n4PKL/b3igeu
X-Gm-Gg: ASbGncuerros8L+oomjdak7NpYdEtaC3GirwF1G7S+XaJVdtNYmgKCj9OCrdcDIIwJM
	EJiD3ipQx6ixZ0TzVatuThl8dhOKrNk+4ghVLub8YhvUhrDF07YVgN/0XpRgEXgAaRBBa9STPXZ
	pnW4+VmS1Z16OGZuR1BzIs0sFzc3SuxISmMMgFyeNIz+v8jrkw8Ss0M9XLO1+jmt3OtvK0xyGua
	cmk457IRDGpN+PTVFCRz2ySPDErqMZERNT8DheRrQZDTkDx+1OpELf76vjqM2UXpaJ7zy/ZnIlw
	lMAr7TRuVr7rJjrSYt41Gk3s0FieMNq7Rg+Ypqa8+su+KIl+OPNEUTWkNCs4L/Mv5X9daL1bHss
	X8dYT+1Ke1SDm6Q5RhEaJZAq5D6lo0KBV2CttbCKBJYUEmSGWRoH6o8gS/0oizEMctxuThoEjjt
	VWmUkBIMlDo2cP
X-Google-Smtp-Source: AGHT+IGrghwk8ZTMecTIAkc+zfJCwdZGd4y4/jP7qk9XhljNu1+PNtNUQJ+bAW1fcaUSV6nQ8GYJ+g==
X-Received: by 2002:a05:6000:4008:b0:429:d6dc:ae1a with SMTP id ffacd0b85a97d-42b4bd9bca6mr7014159f8f.30.1763037624173;
        Thu, 13 Nov 2025 04:40:24 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b62dsm3697140f8f.24.2025.11.13.04.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:40:23 -0800 (PST)
From: Paul Houssel <paulhoussel2@gmail.com>
X-Google-Original-From: Paul Houssel <paul.houssel@orange.com>
To: Paul Houssel <paulhoussel2@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>,
	Ouail Derghal <ouail.derghal@imt-atlantique.fr>,
	Guilhem Jazeron <guilhem.jazeron@inria.fr>,
	Ludovic Paillat <ludovic.paillat@inria.fr>,
	Robin Theveniaut <robin.theveniaut@irit.fr>,
	Tristan d'Audibert <tristan.daudibert@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Houssel <paul.houssel@orange.com>
Subject: [PATCH v4 1/2] libbpf: fix BTF dedup to support recursive typedef definitions
Date: Thu, 13 Nov 2025 13:39:50 +0100
Message-ID: <bf00857b1e06f282aac12f6834de7396a7547ba6.1763037045.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763037045.git.paul.houssel@orange.com>
References: <cover.1763037045.git.paul.houssel@orange.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Handle recursive typedefs in BTF deduplication

Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
Podman) due to recursive type definitions that create reference loops
not representable in C. These recursive typedefs trigger a failure in
the BTF deduplication algorithm.

This patch extends btf_dedup_ref_type() to properly handle potential
recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
handled for BTF_KIND_STRUCT. This allows pahole to successfully
generate BTF for Go binaries using recursive types without impacting
existing C-based workflows.

Co-developed-by: Martin Horth <martin.horth@telecom-sudparis.eu>
Signed-off-by: Martin Horth <martin.horth@telecom-sudparis.eu>
Co-developed-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
Signed-off-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
Co-developed-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
Signed-off-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
Co-developed-by: Ludovic Paillat <ludovic.paillat@inria.fr>
Signed-off-by: Ludovic Paillat <ludovic.paillat@inria.fr>
Co-developed-by: Robin Theveniaut <robin.theveniaut@irit.fr>
Signed-off-by: Robin Theveniaut <robin.theveniaut@irit.fr>
Suggested-by: Tristan d'Audibert <tristan.daudibert@gmail.com>
Signed-off-by: Paul Houssel <paul.houssel@orange.com>

---

The issue was originally observed when attempting to encode BTF for
Kubernetes binaries (kubectl, kubeadm):

$ git clone --depth 1 https://github.com/kubernetes/kubernetes
$ cd ./kubernetes
$ make kubeadm DBG=1
$ pahole --btf_encode_detached=kubeadm.btf _output/bin/kubeadm
btf_encoder__encode: btf__dedup failed!
Failed to encode BTF

The root cause lies in recursive type definitions that cannot exist
in C but are valid in Go.

program.go:

"package main

type Foo func() Foo

func main() {
        bar()
}

func bar() Foo {
        return nil
}"

Building and encoding this program with pahole triggers the same
deduplication failure:

$ go build -gcflags "all=-N -l" ./program.go
$ pahole --btf_encode_detached=program.btf program
btf_encoder__encode: btf__dedup failed!
Failed to encode BTF

As noted in the comment of btf_dedup_ref_type(), the deduplication
logic previously assumed recursion only occurs through structs or
unions:

"[...] there is no danger of encountering cycles because in C type
system the only way to form type cycle is through struct/union, so
any chain of reference types, even those taking part in a type
cycle, will inevitably reach struct/union at some point."

However, Go allows such recursion through typedef-like constructs
(function types, aliases), requiring a special case for
BTF_KIND_TYPEDEF.

This patch introduces that special handling, ensuring pahole can
handle Go-generated BTFs while maintaining compatibility with
existing C workflows.
---
 tools/lib/bpf/btf.c | 71 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9f141395c074..84a4b0abc8be 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3901,6 +3901,20 @@ static int btf_dedup_strings(struct btf_dedup *d)
 	return err;
 }
 
+/*
+ * Calculate type signature hash of TYPEDEF, ignoring referenced type IDs,
+ * as referenced type IDs equivalence is established separately during type
+ * graph equivalence check algorithm.
+ */
+static long btf_hash_typedef(struct btf_type *t)
+{
+	long h;
+
+	h = hash_combine(0, t->name_off);
+	h = hash_combine(h, t->info);
+	return h;
+}
+
 static long btf_hash_common(struct btf_type *t)
 {
 	long h;
@@ -3918,6 +3932,13 @@ static bool btf_equal_common(struct btf_type *t1, struct btf_type *t2)
 	       t1->size == t2->size;
 }
 
+/* Check structural compatibility of two TYPEDEF. */
+static bool btf_equal_typedef(struct btf_type *t1, struct btf_type *t2)
+{
+	return t1->name_off == t2->name_off &&
+	       t1->info == t2->info;
+}
+
 /* Calculate type signature hash of INT or TAG. */
 static long btf_hash_int_decl_tag(struct btf_type *t)
 {
@@ -4844,13 +4865,30 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
 	}
 }
 
+static inline long btf_hash_by_kind(struct btf_type *t, __u16 kind)
+{
+	if (kind == BTF_KIND_TYPEDEF)
+		return btf_hash_typedef(t);
+	else
+		return btf_hash_struct(t);
+}
+
+static inline bool btf_equal_by_kind(struct btf_type *t1, struct btf_type *t2, __u16 kind)
+{
+	if (kind == BTF_KIND_TYPEDEF)
+		return btf_equal_typedef(t1, t2);
+	else
+		return btf_shallow_equal_struct(t1, t2);
+}
+
 /*
- * Deduplicate struct/union types.
+ * Deduplicate struct/union and typedef types.
  *
  * For each struct/union type its type signature hash is calculated, taking
  * into account type's name, size, number, order and names of fields, but
  * ignoring type ID's referenced from fields, because they might not be deduped
- * completely until after reference types deduplication phase. This type hash
+ * completely until after reference types deduplication phase. For each typedef
+ * type, the hash is computed based on the type’s name and size. This type hash
  * is used to iterate over all potential canonical types, sharing same hash.
  * For each canonical candidate we check whether type graphs that they form
  * (through referenced types in fields and so on) are equivalent using algorithm
@@ -4882,18 +4920,20 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
 	t = btf_type_by_id(d->btf, type_id);
 	kind = btf_kind(t);
 
-	if (kind != BTF_KIND_STRUCT && kind != BTF_KIND_UNION)
+	if (kind != BTF_KIND_STRUCT &&
+		kind != BTF_KIND_UNION &&
+		kind != BTF_KIND_TYPEDEF)
 		return 0;
 
-	h = btf_hash_struct(t);
+	h = btf_hash_by_kind(t, kind);
 	for_each_dedup_cand(d, hash_entry, h) {
 		__u32 cand_id = hash_entry->value;
 		int eq;
 
 		/*
 		 * Even though btf_dedup_is_equiv() checks for
-		 * btf_shallow_equal_struct() internally when checking two
-		 * structs (unions) for equivalence, we need to guard here
+		 * btf_equal_by_kind() internally when checking two
+		 * structs (unions) or typedefs for equivalence, we need to guard here
 		 * from picking matching FWD type as a dedup candidate.
 		 * This can happen due to hash collision. In such case just
 		 * relying on btf_dedup_is_equiv() would lead to potentially
@@ -4901,7 +4941,7 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
 		 * FWD and compatible STRUCT/UNION are considered equivalent.
 		 */
 		cand_type = btf_type_by_id(d->btf, cand_id);
-		if (!btf_shallow_equal_struct(t, cand_type))
+		if (!btf_equal_by_kind(t, cand_type, kind))
 			continue;
 
 		btf_dedup_clear_hypot_map(d);
@@ -4939,18 +4979,18 @@ static int btf_dedup_struct_types(struct btf_dedup *d)
 /*
  * Deduplicate reference type.
  *
- * Once all primitive and struct/union types got deduplicated, we can easily
+ * Once all primitive, struct/union and typedef types got deduplicated, we can easily
  * deduplicate all other (reference) BTF types. This is done in two steps:
  *
  * 1. Resolve all referenced type IDs into their canonical type IDs. This
- * resolution can be done either immediately for primitive or struct/union types
- * (because they were deduped in previous two phases) or recursively for
+ * resolution can be done either immediately for primitive, struct/union, and typedef
+ * types (because they were deduped in previous two phases) or recursively for
  * reference types. Recursion will always terminate at either primitive or
- * struct/union type, at which point we can "unwind" chain of reference types
- * one by one. There is no danger of encountering cycles because in C type
- * system the only way to form type cycle is through struct/union, so any chain
- * of reference types, even those taking part in a type cycle, will inevitably
- * reach struct/union at some point.
+ * struct/union and typedef types, at which point we can "unwind" chain of reference
+ * types one by one. There is no danger of encountering cycles in C, as the only way to
+ * form a type cycle is through struct or union types. Go can form such cycles through
+ * typedef. Thus, any chain of reference types, even those taking part in a type cycle,
+ * will inevitably reach a struct/union or typedef type at some point.
  *
  * 2. Once all referenced type IDs are resolved into canonical ones, BTF type
  * becomes "stable", in the sense that no further deduplication will cause
@@ -4982,7 +5022,6 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_RESTRICT:
 	case BTF_KIND_PTR:
-	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_TYPE_TAG:
 		ref_type_id = btf_dedup_ref_type(d, t->type);
-- 
2.51.0


