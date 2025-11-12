Return-Path: <linux-kselftest+bounces-45410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 759B1C52B82
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 15:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E005A4215B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 14:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A643127F4CE;
	Wed, 12 Nov 2025 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtML36v6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59127B50C
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956760; cv=none; b=qVe011LrdeNvxbNU1RrQhilaRoP3ei4a13OWdeySPAmgTr6lEM6SfSImShBh6x8k8Ceqiv9HphEQM+7OHafFftL+5cQDkkMjZuDNoibfIAjbvC1EBT4lBMeW4fyDtIZNSftpBlO+tjMMnCkgwUlfbC0JtlNvcWjLekO7N3jiESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956760; c=relaxed/simple;
	bh=SGkn2MfpFy3VCfieLbHx4DUS0yTNXZsrYgUgHGZnHfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJfOoPXZSARkMolUsfLI0pK5EX7FvlhVa8rafpqTgBdrXR1pHGJMW/k0T5vNsjBp469OKrTPtTyQNjxWVEwcVdLP3eYIjxokRsZ07CCrqXBsddbpg5jt7vlaXQj9YcPFBUZnKRsK7YbnreqlzQDoitmLy6RdUY8KcHr/qwGguCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtML36v6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477563e28a3so5352895e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 06:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762956757; x=1763561557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bm8jjKEufBDMJusIwnH1y3gkH233WkUBO977RuHJoy8=;
        b=GtML36v6fw+dyHKygKzabvA74ezx1lwHaRQ+anmdesflFFdlEnXeygiK8Qf8jFZYaE
         ulZ5QCXpcZfhi4+XkvySjzaS/NCxcbuSsrNTnhouQKVi2csqbtFbshxKIY0cG/ojHVxd
         3SV07IycREGCq3jPgLtAgBB5/ZnaYoWg7PufTGTzbS0SoirkB1WvykvYy0tZvENSL3vq
         XtOpyZRFAmxQ3sU3TkE+Sq+/c/eYk2QaG6ZueJ7YM2WT7U34oeaotbap1qZw7kOM2O6t
         izYo2GqUWaKK3WNXNQi2hg4FhqT2XHFx2jopF6bFQNtISL40uWQY+PHMm3TN+gL2zRZK
         DYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956757; x=1763561557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bm8jjKEufBDMJusIwnH1y3gkH233WkUBO977RuHJoy8=;
        b=MrfH6DcHFppqlFfUeg44MPJD+y7rfWWVytKMN5Mn+Y+0NG8XyUwwOEli2Q4AvRvu5p
         1XD0PzPlEtUGxhX7SX4qx9qX+OuB/l/C/XMNih7J6o2RD6T5M2v0JjWbfFoWmUije/Pm
         O6jj9ZXIGH51LrcZUSVk9FY2W2tS+4wQqth4gXHto516rVdV4ZWewdzq7/MPdp8BIvPH
         Pg+Pq+o1AD1RYYVH1gcKeVmjdWj+gFoHg1S5540yMVJ8Uka3tDDgIdOTst5n9PsSgWfQ
         aT1p+3UtBCGNghJbxquIX8NdydvrSQPLQ1RCXJ3s9xfwjP6801j7ozCGMkOgemSCz5Xw
         relQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr0EsO7/a6vyoO6LH0SGEzFo/W3UT7uoZ6VVp8JHy2wJB398ez+OWZJH+t3dF34VBjLQ4W1kCV79V2yW/x6Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweLjwdbsue3j4OyJi8WRcc7RdN32eptufJieafvSAzDmZUtuaS
	r0vqWzWphFnRXVHaz4l9UseBox/KqUDhF89FsBHLwBWEHztucgwUSlbG
X-Gm-Gg: ASbGncvuL0Va3D2007qiTQGwnz7y/miB6FbSe6Cm7wZQ+KJqx+yqUjYfWi/MURmFQj3
	qbZRHB0TkquRRlk6ZLQdVRBkIHVBx8rgdjXxduMNGv/PA1ddDy/ptMoisoheTWs0xH6xaxHIp/l
	ljvOdEoWo0ATsKTT8mHhJrEqg7GsyEJwWND8TVFrVvFv6ifinJPiZEDG8tVmz7z7EtoACGf5PHD
	q20QJ2pwrWy/KyvZ6Q3TArvulces02lfNW+8wc3oJ4S6nYI/M7qpwHvFKVVPc1kWF0lyOE3Tgfk
	HWVMm1E2FXmAKdmAkW368P0dtv41m1iWma9nhymMQS+c8qV7Y2QBKcbF6mOiX3Jio1rS7i+5YlF
	bPAfF979uPRn3GKqD0rNaBBYNON2dpnekXD1jcJoGjg65lZ9PxE9px6W0c5S6Zsm4fYyB/KAw6T
	dG53RPEyZGrTjR
X-Google-Smtp-Source: AGHT+IGbS39zZrPEcpZxv9DmwS0T4es4ixXV73jziRjH2BspkatVpgGyDoy9lEVSFhR+zmF+vqB6Jw==
X-Received: by 2002:a05:600c:1f91:b0:477:25c0:798c with SMTP id 5b1f17b1804b1-4778735a127mr27992615e9.20.1762956756359;
        Wed, 12 Nov 2025 06:12:36 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2b08a91esm28303603f8f.2.2025.11.12.06.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:12:35 -0800 (PST)
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
Subject: [PATCH v2 1/2] libbpf: fix BTF dedup to support recursive typedef definitions
Date: Wed, 12 Nov 2025 15:11:33 +0100
Message-ID: <c1b79b23c2a20964792961f23348970ebaee14b8.1762956565.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762956564.git.paul.houssel@orange.com>
References: <cover.1762956564.git.paul.houssel@orange.com>
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
 tools/lib/bpf/btf.c | 59 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9f141395c074..5e7c2cae7b27 100644
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
@@ -4939,7 +4979,7 @@ static int btf_dedup_struct_types(struct btf_dedup *d)
 /*
  * Deduplicate reference type.
  *
- * Once all primitive and struct/union types got deduplicated, we can easily
+ * Once all primitive, struct/union and typedef types got deduplicated, we can easily
  * deduplicate all other (reference) BTF types. This is done in two steps:
  *
  * 1. Resolve all referenced type IDs into their canonical type IDs. This
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


