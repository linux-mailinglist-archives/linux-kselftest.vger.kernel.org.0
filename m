Return-Path: <linux-kselftest+bounces-45530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701FDC57224
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 12:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8203B859D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 11:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3400E33B943;
	Thu, 13 Nov 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVZtwFuM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143AF33B6D2
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032512; cv=none; b=cMTOanq3t46tQACbsxWkU6XUNDn5s8dnuCBbJMHOlgybIaxwmV+GUKlMr1q+6Y3mLKGULCXuc88TTHhriBv3faQ5jFPBFZxb1JnH/RcXVlC2Jpk9CM68SOA7mqyt0MbNJI0tTucKBNVzwkFbu46pTREtzsU9sKBy2Hyo6zpjO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032512; c=relaxed/simple;
	bh=1XD6PWKm58Gt7LW0tKjW7rvVrHAdnRX2aZm40CNVExI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgKe+sbdG2USd2JyA2ZpDrVudr6QWZWsyzce3BBAEy3ATvLz4svJGUJ08zRgE1HuKQfnaTOyCL1uKgbBa13eT9W4GJPx/yda6nztNmLGYuZRhqY3qL8QC0bnqq834z7V0g/EBxLP2tWFQb7RQmdIzAKTLuR+ebnwGr7EH/rn9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVZtwFuM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso3679495e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 03:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763032508; x=1763637308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6Y6kzG2O6uwjBrHzCB632WRHU3Yg3b3hYi/wFvLK7M=;
        b=hVZtwFuMsxI/hY3Yhmm1dZz8CACg6Z1IqLL2AnPNEB7DXis1GYdP6CA1I39JXYI1My
         Soh7v5aetKxX1sPAFs3TbUFY0OcIEBfqhTbTDCO48VUcCXV003xjSh5uTjphO3APgcmP
         ClbBjZc8RXCSZG2QQ+rmzqJcD74zYj9L3iPauDaNIFXUxEpnuFwRsXJPeCsqgTqvRscW
         q1EA7JgCUQ8YK849r8afVXVpDpCOA6tuMFcXjDc2pQ86tqairWypGfDNgzI5APIYFyRp
         1armnuGGgzyrbsdbe3k9N03Cj/FAjUOvUchPVvzodyw80CbcrolcrVTzv9pwFmJPoj/3
         9tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763032508; x=1763637308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z6Y6kzG2O6uwjBrHzCB632WRHU3Yg3b3hYi/wFvLK7M=;
        b=XRR06CqCd+ih/r6IZluoRTp2twg6Bvh4zir2HItdUehNuRQPBp9jJzWpRDkS5EPjr6
         3HAgeI+df6rp8M7xXmJrq4SJ923/kH1gJtX6UC+2smsQmjLx76x4R+Yuo6sfEQ/nuSw2
         AvkTmxAUAWzbGI9hH7eaS1lIIV9Q9/VSVR0uoCAJ0F13reWlKY+QagxZs/ciXoItdVPL
         B5X5sLohqfvSevSUVsq+q/q722rY132RxO9EqwXG+sJrY3jj9Ln/IIxb0e5qBvoqylR+
         hEy8za/0DC1bS+j1VCDmqZEwjc1frf4Umninc/coTt4G1CKEdohS1VWP14RsKi5P729x
         AlXA==
X-Forwarded-Encrypted: i=1; AJvYcCWjU6OZhfFpB0b+0/4qopM1aD9v/sqEStx5Af0E/7KiH7pMkTkIY6kSKloYj17J0Kn1igC44yJlPAO74cCK/o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoy25Dxfmf4qoFP/CAj6YVj3dXzAf2CocgnlXNYEZbpHbLcpsf
	0U6gkbnhBgAkE8PsYdBe4BgdqwWrkJT6l5rsQxIAOeUM1OjPyxMymK9Q
X-Gm-Gg: ASbGnctTzwRYCkh1H64j98YPB2bg008u4ERGa8axz4LMcSijsPfZAa9fhd7sZNTyHAm
	ohxRXfcrVaiMRaIv4t+s10AjxzpeLemDeZDit76yOnSrGLyW4DTgJKsJWNQjecA44jYcEh9wTMI
	D65nGmjdkIYEY4Jk8O8/dyvYdD6sjPSUMw6GMfJHwzPYvIpR3LPQjYApvbROTcHA+JsFaD+YAtu
	A3lY4UHQwUEdSct8xcjeLf6vHEg5umJua5qVFwIegoLo5p491vbUF/avGkUNI7jAouEPIfkGBoJ
	ZwgW6S2zCQ8zBja4SbLB8FF7mVA6gyNfbdLJZV8tI7j09FkC3SZV+8kn1/VBUxJkJK3WKBU4BTh
	05+0giVWF37WwbSv0PEj4/3aSUydjuiifTQTeyEFQ21Hr8tX9KhTABQ3Ba1WJGGUxdqnHk8ran+
	SHMGtmXZDgFfah
X-Google-Smtp-Source: AGHT+IErKo2J91Ztft92gvrE6uO+NgsD0IyPPSDULKbUxxZU0C2orUCJe2QMzHZRp0g72BUUgExazA==
X-Received: by 2002:a05:600c:3b17:b0:475:de12:d3b2 with SMTP id 5b1f17b1804b1-477870cdce6mr55124405e9.36.1763032507984;
        Thu, 13 Nov 2025 03:15:07 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bcfa2e9sm17739825e9.12.2025.11.13.03.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:15:07 -0800 (PST)
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
Subject: [PATCH v3 1/2] libbpf: fix BTF dedup to support recursive typedef definitions
Date: Thu, 13 Nov 2025 12:14:05 +0100
Message-ID: <d0458ec2290e85a8c885432359a33ba8596ba992.1763024337.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763024337.git.paul.houssel@orange.com>
References: <cover.1763024337.git.paul.houssel@orange.com>
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
 tools/lib/bpf/btf.c | 73 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9f141395c074..5c4035eb9493 100644
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
@@ -4844,14 +4865,31 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
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
- * is used to iterate over all potential canonical types, sharing same hash.
+ * completely until after reference types deduplication phase. For each typedef
+ * type, the hash is computed based on the type’s name and size. This type hash
+ * is used to iterate over all potential canonical types, sharingsame hash.
  * For each canonical candidate we check whether type graphs that they form
  * (through referenced types in fields and so on) are equivalent using algorithm
  * implemented in `btf_dedup_is_equiv`. If such equivalence is found and
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


