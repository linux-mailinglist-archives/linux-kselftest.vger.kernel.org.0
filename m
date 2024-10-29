Return-Path: <linux-kselftest+bounces-20880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C09B3F0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 01:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44791C224EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C93567D;
	Tue, 29 Oct 2024 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGkVoqLh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFEF79F5;
	Tue, 29 Oct 2024 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161348; cv=none; b=IxiTURwKGW9ZfHB7VxPX3LL9qQK3Us7RhFvI9exdv2tfVWRAezKSG/++y/vsKjotqS8MswQYS09/81z2J5PHmnVT+Ez5EoriWur9L+hwXU7tOgwA1CSerfkaosL9YWx/egkZT2+NBDBN4rzrp96V00chekVLxNxRMjzCbRiIg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161348; c=relaxed/simple;
	bh=AnN603qwCjTnmNjWuIvbxyyFo50ShPsvcy9hrZpo6xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U+d2tg7A45b5TMZX298SVWCrazjo8x9qaIYe7Yv5NKmuAfKYpAAZ94UVd9M32wkeW9qiBkVc78zo/4roEg6qmY/QmWmWwbRAnBLhbaugcNf+LFyBzpUAgLylFR38iq3YemSA5QxC2Na5706QIeQoEvmoBDMOA2Ol44KrBWshhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGkVoqLh; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso4127083a12.2;
        Mon, 28 Oct 2024 17:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730161344; x=1730766144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCwI8AAhOqVEsLEN4vixtT4a70Lj0Ci3f9ieyC7vrBo=;
        b=DGkVoqLhI7QFyWhrX/c2G14ePr+5sVbzNr3Jluv+2Pn22OFNR8xxafQrdcCE95I0xw
         LuQNN3Rh2yWwnLudDoGPHpN7zIl0BXdxS5PD8neZeP6FHbrkS630PO5slMiduLpflXtN
         y5C047uaSn6sjbO1E0MWlByPxSkiDNloSrsUiddkT+QPIGY417j52NOgXZ0N5hFV7kHX
         p0AsEUpYP2c/oWJgA7+Z4YXzli5s0h2Gdgusx/fmWuAwY3qB2BDUYCpAabwM7vjD5V3V
         sVkN3pThoMm/4czKN6deTMuePd8b80yJO9ApZFCzebBn/67ZT4le8otJMKi08K89K1UP
         TrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730161344; x=1730766144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCwI8AAhOqVEsLEN4vixtT4a70Lj0Ci3f9ieyC7vrBo=;
        b=JlrceXSMZS5A99S9ndgsDW9E4bHXCfXyG0TXTx3rrPVEchY1iYuMkfSRP5M1jNrFCf
         /QSwNjQ7SOV+KAI1p17yM4tuNTzthzn6r6jbwabrakEsRF+bxHvZgT/95eZ7q0eSyAVr
         RHoEXZwiQY40y+ugI4qVn92R7JRknNdGreChm2PJ+9dBwGi2nxy7BtW2VtG9VXAKHo+f
         Z5Wvi53Vxlybma67hWoqHuD8QjcSXqVzR1ezXWnaGGSLfSWbonkqqBVkF0cbqqHgCaSy
         z/mNzsfeDq/i1Dh/su6KLjXwuEIchPDNmS1i/ZnSFC77h4EFLeZ2HBJvpL4nxHhQiYvN
         qyJA==
X-Forwarded-Encrypted: i=1; AJvYcCUSCWnsxtbZpU6PCAY+WO7rZUu/mwcoCb18uQfnDNQD0OukGjNQDF76RNqHkgvnGB6XrJd5Sd5Wg21/6kCLaToqpWmQ@vger.kernel.org, AJvYcCUkOYnvznjriR2Gc6zc1TGLJCLX0R3cBJRUbA2TUKhvqWtGS0w4Ar1NqcmODQIIfvFQi9O4g4TIRwSkPcQU@vger.kernel.org, AJvYcCVRMy4aPbWpOCaHhJpcQSEmsIo/jBPfaAk3pBhs3BMsY7vF7W5lsusnHwlvQs1BXYaQ5mb0Lqr7+IgKXvzlEgHT@vger.kernel.org, AJvYcCX9nGpIBu6eN58A6bcOWHnTunvweqBuBOXnbm2Yr965/Jn38X+D53tYzMaBH+I3JNvEc2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEv12LfPktJ1CuVNXmjAWEIIqXXhRKdz8x07HCdjDwPvpHlnMM
	muLb/FQfOz1lg1rHt3TZWZBjWY0CU0CHVE6ewsMnrmR3zdEYQBlB5FfCb1/L
X-Google-Smtp-Source: AGHT+IG7Meak8bLIY6YQCzhkJ9XHo97omfuOU8GMl7S1qgl7P7GBtQxOGWDEay8y0y5kFIDFrGVuNA==
X-Received: by 2002:a17:90a:e10a:b0:2e5:8392:afe7 with SMTP id 98e67ed59e1d1-2e8f0d65883mr11910717a91.0.1730161343916;
        Mon, 28 Oct 2024 17:22:23 -0700 (PDT)
Received: from pengdl-ub.localdomain ([106.37.77.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48e4a2sm10175507a91.2.2024.10.28.17.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 17:22:22 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com
Cc: ast@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH v4 1/3] libbpf: Sort btf_types in ascending order by name
Date: Tue, 29 Oct 2024 08:22:06 +0800
Message-Id: <20241029002208.1947947-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029002208.1947947-1-dolinux.peng@gmail.com>
References: <20241029002208.1947947-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To enhance the searching performance of btf_find_by_name_kind, we
can sort the btf_types in ascending order based on their names.
This allows us to implement a binary search method.

Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
v4:
 - Divide the patch into two parts: kernel and libbpf
 - Use Eduard's code to sort btf_types in the btf__dedup function
 - Correct some btf testcases due to modifications of the order of btf_types.
---
 tools/lib/bpf/btf.c                           | 115 +++++--
 tools/testing/selftests/bpf/prog_tests/btf.c  | 296 +++++++++---------
 .../bpf/prog_tests/btf_dedup_split.c          |  64 ++--
 3 files changed, 268 insertions(+), 207 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3c131039c523..5290e9d59997 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (c) 2018 Facebook */
 
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <byteswap.h>
 #include <endian.h>
 #include <stdio.h>
@@ -4902,6 +4905,49 @@ static int btf_dedup_resolve_fwds(struct btf_dedup *d)
 	return err;
 }
 
+/* compare btf types by name, consider named < anonymous */
+static int btf_compare_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	struct btf_type *ta = btf_type_by_id(btf, *(__u32 *)a);
+	struct btf_type *tb = btf_type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+
+	/* ta w/o name is greater than tb */
+	if (!ta->name_off && tb->name_off)
+		return 1;
+	/* tb w/o name is smaller than ta */
+	if (ta->name_off && !tb->name_off)
+		return -1;
+
+	na = btf__str_by_offset(btf, ta->name_off);
+	nb = btf__str_by_offset(btf, tb->name_off);
+	return strcmp(na, nb);
+}
+
+static __u32 *get_sorted_canon_types(struct btf_dedup *d, __u32 *cnt)
+{
+	int i, j, id, types_cnt = 0;
+	__u32 *sorted_ids;
+
+	for (i = 0, id = d->btf->start_id; i < d->btf->nr_types; i++, id++)
+		if (d->map[id] == id)
+			++types_cnt;
+
+	sorted_ids = calloc(types_cnt, sizeof(*sorted_ids));
+	if (!sorted_ids)
+		return NULL;
+
+	for (j = 0, i = 0, id = d->btf->start_id; i < d->btf->nr_types; i++, id++)
+		if (d->map[id] == id)
+			sorted_ids[j++] = id;
+	qsort_r(sorted_ids, types_cnt, sizeof(*sorted_ids),
+		btf_compare_type_names, d->btf);
+	*cnt = types_cnt;
+
+	return sorted_ids;
+}
+
 /*
  * Compact types.
  *
@@ -4915,11 +4961,11 @@ static int btf_dedup_resolve_fwds(struct btf_dedup *d)
  */
 static int btf_dedup_compact_types(struct btf_dedup *d)
 {
-	__u32 *new_offs;
-	__u32 next_type_id = d->btf->start_id;
+	__u32 canon_types_cnt = 0, canon_types_len = 0;
+	__u32 *new_offs = NULL, *canon_types = NULL;
 	const struct btf_type *t;
-	void *p;
-	int i, id, len;
+	void *p, *new_types = NULL;
+	int i, id, len, err;
 
 	/* we are going to reuse hypot_map to store compaction remapping */
 	d->hypot_map[0] = 0;
@@ -4929,36 +4975,61 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
 	for (i = 0, id = d->btf->start_id; i < d->btf->nr_types; i++, id++)
 		d->hypot_map[id] = BTF_UNPROCESSED_ID;
 
-	p = d->btf->types_data;
-
-	for (i = 0, id = d->btf->start_id; i < d->btf->nr_types; i++, id++) {
-		if (d->map[id] != id)
-			continue;
+	canon_types = get_sorted_canon_types(d, &canon_types_cnt);
+	if (!canon_types) {
+		err = -ENOMEM;
+		goto out_err;
+	}
 
+	for (i = 0; i < canon_types_cnt; i++) {
+		id = canon_types[i];
 		t = btf__type_by_id(d->btf, id);
 		len = btf_type_size(t);
-		if (len < 0)
-			return len;
+		if (len < 0) {
+			err = len;
+			goto out_err;
+		}
+		canon_types_len += len;
+	}
+
+	new_offs = calloc(canon_types_cnt, sizeof(*new_offs));
+	new_types = calloc(canon_types_len, 1);
+	if (!new_types || !new_offs) {
+		err = -ENOMEM;
+		goto out_err;
+	}
 
-		memmove(p, t, len);
-		d->hypot_map[id] = next_type_id;
-		d->btf->type_offs[next_type_id - d->btf->start_id] = p - d->btf->types_data;
+	p = new_types;
+
+	for (i = 0; i < canon_types_cnt; i++) {
+		id = canon_types[i];
+		t = btf__type_by_id(d->btf, id);
+		len = btf_type_size(t);
+		memcpy(p, t, len);
+		d->hypot_map[id] = d->btf->start_id + i;
+		new_offs[i] = p - new_types;
 		p += len;
-		next_type_id++;
 	}
 
 	/* shrink struct btf's internal types index and update btf_header */
-	d->btf->nr_types = next_type_id - d->btf->start_id;
-	d->btf->type_offs_cap = d->btf->nr_types;
-	d->btf->hdr->type_len = p - d->btf->types_data;
-	new_offs = libbpf_reallocarray(d->btf->type_offs, d->btf->type_offs_cap,
-				       sizeof(*new_offs));
-	if (d->btf->type_offs_cap && !new_offs)
-		return -ENOMEM;
+	free(d->btf->types_data);
+	free(d->btf->type_offs);
+	d->btf->types_data = new_types;
 	d->btf->type_offs = new_offs;
+	d->btf->types_data_cap = canon_types_len;
+	d->btf->type_offs_cap = canon_types_cnt;
+	d->btf->nr_types = canon_types_cnt;
+	d->btf->hdr->type_len = canon_types_len;
 	d->btf->hdr->str_off = d->btf->hdr->type_len;
 	d->btf->raw_size = d->btf->hdr->hdr_len + d->btf->hdr->type_len + d->btf->hdr->str_len;
+	free(canon_types);
 	return 0;
+
+out_err:
+	free(canon_types);
+	free(new_types);
+	free(new_offs);
+	return err;
 }
 
 /*
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index e63d74ce046f..4dc1e2bfacbb 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7025,26 +7025,26 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),				/* [1] */
 			/* int */
-			BTF_TYPE_INT_ENC(NAME_NTH(5), BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
-			/* int[16] */
-			BTF_TYPE_ARRAY_ENC(1, 1, 16),					/* [2] */
+			BTF_TYPE_INT_ENC(NAME_NTH(5), BTF_INT_SIGNED, 0, 32, 4),	/* [2] */
 			/* struct s { */
 			BTF_STRUCT_ENC(NAME_NTH(8), 5, 88),				/* [3] */
-				BTF_MEMBER_ENC(NAME_NTH(7), 4, 0),	/* struct s *next;	*/
-				BTF_MEMBER_ENC(NAME_NTH(1), 5, 64),	/* const int *a;	*/
-				BTF_MEMBER_ENC(NAME_NTH(2), 2, 128),	/* int b[16];		*/
-				BTF_MEMBER_ENC(NAME_NTH(3), 1, 640),	/* int c;		*/
-				BTF_MEMBER_ENC(NAME_NTH(4), 9, 672),	/* float d;		*/
+				BTF_MEMBER_ENC(NAME_NTH(7), 7, 0),	/* struct s *next;	*/
+				BTF_MEMBER_ENC(NAME_NTH(1), 8, 64),	/* const int *a;	*/
+				BTF_MEMBER_ENC(NAME_NTH(2), 6, 128),	/* int b[16];		*/
+				BTF_MEMBER_ENC(NAME_NTH(3), 2, 640),	/* int c;		*/
+				BTF_MEMBER_ENC(NAME_NTH(4), 1, 672),	/* float d;		*/
+			BTF_DECL_TAG_ENC(NAME_NTH(2), 3, -1),				/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(2), 3, 1),				/* [5] */
+			/* int[16] */
+			BTF_TYPE_ARRAY_ENC(1, 2, 16),					/* [6] */
 			/* ptr -> [3] struct s */
-			BTF_PTR_ENC(3),							/* [4] */
+			BTF_PTR_ENC(3),							/* [7] */
 			/* ptr -> [6] const int */
-			BTF_PTR_ENC(6),							/* [5] */
+			BTF_PTR_ENC(9),							/* [8] */
 			/* const -> [1] int */
-			BTF_CONST_ENC(1),						/* [6] */
-			BTF_DECL_TAG_ENC(NAME_NTH(2), 3, -1),				/* [7] */
-			BTF_DECL_TAG_ENC(NAME_NTH(2), 3, 1),				/* [8] */
-			BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),				/* [9] */
+			BTF_CONST_ENC(2),						/* [9] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0a\0b\0c\0d\0int\0float\0next\0s"),
@@ -7082,10 +7082,10 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
-			BTF_PTR_ENC(3),					/* [1] ptr -> [3] */
-			BTF_STRUCT_ENC(NAME_TBD, 1, 8),			/* [2] struct s   */
-				BTF_MEMBER_ENC(NAME_TBD, 1, 0),
-			BTF_STRUCT_ENC(NAME_NTH(2), 0, 0),		/* [3] struct x   */
+			BTF_STRUCT_ENC(NAME_TBD, 1, 8),			/* [1] struct s   */
+				BTF_MEMBER_ENC(NAME_TBD, 3, 0),
+			BTF_STRUCT_ENC(NAME_NTH(2), 0, 0),		/* [2] struct x   */
+			BTF_PTR_ENC(2),					/* [3] ptr -> [3] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0s\0x"),
@@ -7123,15 +7123,13 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
-			/* CU 1 */
-			BTF_STRUCT_ENC(0, 0, 1),				/* [1] struct {}  */
-			BTF_PTR_ENC(1),						/* [2] ptr -> [1] */
-			BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),			/* [3] struct s   */
-				BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
-			/* CU 2 */
-			BTF_PTR_ENC(0),						/* [4] ptr -> void */
-			BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),			/* [5] struct s   */
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),			/* [1] struct s   */
 				BTF_MEMBER_ENC(NAME_NTH(2), 4, 0),
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),			/* [2] struct s   */
+				BTF_MEMBER_ENC(NAME_NTH(2), 5, 0),
+			BTF_STRUCT_ENC(0, 0, 1),				/* [3] struct {}  */
+			BTF_PTR_ENC(3),						/* [5] ptr -> [1] */
+			BTF_PTR_ENC(0),						/* [4] ptr -> void */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0s\0x"),
@@ -7182,28 +7180,28 @@ static struct btf_dedup_test dedup_tests[] = {
 				BTF_ENUM_ENC(NAME_TBD, 0),
 				BTF_ENUM_ENC(NAME_TBD, 1),
 			BTF_FWD_ENC(NAME_TBD, 1 /* union kind_flag */),			/* [3] fwd */
-			BTF_TYPE_ARRAY_ENC(2, 1, 7),					/* [4] array */
-			BTF_STRUCT_ENC(NAME_TBD, 1, 4),					/* [5] struct */
+			BTF_STRUCT_ENC(NAME_TBD, 1, 4),					/* [4] struct */
 				BTF_MEMBER_ENC(NAME_TBD, 1, 0),
-			BTF_UNION_ENC(NAME_TBD, 1, 4),					/* [6] union */
+			BTF_UNION_ENC(NAME_TBD, 1, 4),					/* [5] union */
 				BTF_MEMBER_ENC(NAME_TBD, 1, 0),
-			BTF_TYPEDEF_ENC(NAME_TBD, 1),					/* [7] typedef */
-			BTF_PTR_ENC(0),							/* [8] ptr */
-			BTF_CONST_ENC(8),						/* [9] const */
-			BTF_VOLATILE_ENC(8),						/* [10] volatile */
-			BTF_RESTRICT_ENC(8),						/* [11] restrict */
-			BTF_FUNC_PROTO_ENC(1, 2),					/* [12] func_proto */
-				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
-				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 18),
-			BTF_FUNC_ENC(NAME_TBD, 12),					/* [13] func */
-			BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),				/* [14] float */
-			BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),				/* [15] decl_tag */
-			BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),				/* [16] decl_tag */
-			BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),				/* [17] decl_tag */
-			BTF_TYPE_TAG_ENC(NAME_TBD, 8),					/* [18] type_tag */
-			BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 2), 8),	/* [19] enum64 */
+			BTF_TYPEDEF_ENC(NAME_TBD, 1),					/* [6] typedef */
+			BTF_FUNC_ENC(NAME_TBD, 19),					/* [7] func */
+			BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),				/* [8] float */
+			BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),				/* [9] decl_tag */
+			BTF_DECL_TAG_ENC(NAME_TBD, 7, 1),				/* [10] decl_tag */
+			BTF_DECL_TAG_ENC(NAME_TBD, 6, -1),				/* [11] decl_tag */
+			BTF_TYPE_TAG_ENC(NAME_TBD, 15),					/* [12] type_tag */
+			BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 2), 8),	/* [13] enum64 */
 				BTF_ENUM64_ENC(NAME_TBD, 0, 0),
 				BTF_ENUM64_ENC(NAME_TBD, 1, 1),
+			BTF_TYPE_ARRAY_ENC(2, 2, 7),					/* [14] array */
+			BTF_PTR_ENC(0),							/* [15] ptr */
+			BTF_CONST_ENC(15),						/* [16] const */
+			BTF_VOLATILE_ENC(15),						/* [17] volatile */
+			BTF_RESTRICT_ENC(15),						/* [18] restrict */
+			BTF_FUNC_PROTO_ENC(1, 2),					/* [19] func_proto */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 12),
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q\0R\0S\0T\0U"),
@@ -7237,9 +7235,14 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
+			/* all allowed sizes */
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 2),
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 4),
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 8),
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 12),
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 16),
+
 			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 8),
-			/* different name */
-			BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, 32, 8),
 			/* different encoding */
 			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_CHAR, 0, 32, 8),
 			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_BOOL, 0, 32, 8),
@@ -7249,12 +7252,8 @@ static struct btf_dedup_test dedup_tests[] = {
 			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 27, 8),
 			/* different byte size */
 			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),
-			/* all allowed sizes */
-			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 2),
-			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 4),
-			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 8),
-			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 12),
-			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 16),
+			/* different name */
+			BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, 32, 8),
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0int\0some other int\0float"),
@@ -7323,18 +7322,18 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
-			/* int */
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
-			/* static int t */
-			BTF_VAR_ENC(NAME_NTH(2), 1, 0),			/* [2] */
-			/* .bss section */				/* [3] */
+			/* .bss section */				/* [1] */
 			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
-			BTF_VAR_SECINFO_ENC(2, 0, 4),
-			/* another static int t */
-			BTF_VAR_ENC(NAME_NTH(2), 1, 0),			/* [4] */
-			/* another .bss section */			/* [5] */
+			BTF_VAR_SECINFO_ENC(3, 0, 4),
+			/* another .bss section */			/* [2] */
 			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
 			BTF_VAR_SECINFO_ENC(4, 0, 4),
+			/* static int t */
+			BTF_VAR_ENC(NAME_NTH(2), 5, 0),			/* [3] */
+			/* another static int t */
+			BTF_VAR_ENC(NAME_NTH(2), 5, 0),			/* [4] */
+			/* int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [5] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0.bss\0t"),
@@ -7371,15 +7370,15 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
-			BTF_VAR_ENC(NAME_NTH(1), 1, 0),			/* [2] */
-			BTF_FUNC_PROTO_ENC(0, 2),			/* [3] */
-				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
-				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 1),
-			BTF_FUNC_ENC(NAME_NTH(4), 3),			/* [4] */
-			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
-			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, -1),		/* [6] */
-			BTF_DECL_TAG_ENC(NAME_NTH(5), 4, 1),		/* [7] */
+			BTF_FUNC_ENC(NAME_NTH(4), 7),			/* [1] */
+			BTF_VAR_ENC(NAME_NTH(1), 6, 0),			/* [2] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [3] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 1, -1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 1, 1),		/* [5] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [6] */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [7] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 6),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 6),
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0t\0a1\0a2\0f\0tag"),
@@ -7419,17 +7418,17 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
-			BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
-				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 1),
-				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
-			BTF_FUNC_ENC(NAME_NTH(3), 2),			/* [3] */
-			BTF_DECL_TAG_ENC(NAME_NTH(4), 3, -1),		/* [4] */
-			BTF_DECL_TAG_ENC(NAME_NTH(5), 3, -1),		/* [5] */
-			BTF_DECL_TAG_ENC(NAME_NTH(6), 3, -1),		/* [6] */
-			BTF_DECL_TAG_ENC(NAME_NTH(4), 3, 1),		/* [7] */
-			BTF_DECL_TAG_ENC(NAME_NTH(5), 3, 1),		/* [8] */
-			BTF_DECL_TAG_ENC(NAME_NTH(6), 3, 1),		/* [9] */
+			BTF_FUNC_ENC(NAME_NTH(3), 9),			/* [1] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 1, -1),		/* [2] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 1, 1),		/* [3] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 1, -1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 1, 1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 1, -1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 1, 1),		/* [7] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [8] */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [9] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 8),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 8),
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0a1\0a2\0f\0tag1\0tag2\0tag3"),
@@ -7465,16 +7464,16 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
-			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),		/* [2] */
-				BTF_MEMBER_ENC(NAME_NTH(2), 1, 0),
-				BTF_MEMBER_ENC(NAME_NTH(3), 1, 32),
-			BTF_DECL_TAG_ENC(NAME_NTH(4), 2, -1),		/* [3] */
-			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),		/* [4] */
-			BTF_DECL_TAG_ENC(NAME_NTH(6), 2, -1),		/* [5] */
-			BTF_DECL_TAG_ENC(NAME_NTH(4), 2, 1),		/* [6] */
-			BTF_DECL_TAG_ENC(NAME_NTH(5), 2, 1),		/* [7] */
-			BTF_DECL_TAG_ENC(NAME_NTH(6), 2, 1),		/* [8] */
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),		/* [1] */
+				BTF_MEMBER_ENC(NAME_NTH(2), 8, 0),
+				BTF_MEMBER_ENC(NAME_NTH(3), 8, 32),
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 1, -1),		/* [2] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 1, 1),		/* [3] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 1, -1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(5), 1, 1),		/* [5] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 1, -1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(6), 1, 1),		/* [7] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [8] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
@@ -7500,11 +7499,11 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
-			BTF_TYPEDEF_ENC(NAME_NTH(1), 1),		/* [2] */
-			BTF_DECL_TAG_ENC(NAME_NTH(2), 2, -1),		/* [3] */
-			BTF_DECL_TAG_ENC(NAME_NTH(3), 2, -1),		/* [4] */
-			BTF_DECL_TAG_ENC(NAME_NTH(4), 2, -1),		/* [5] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 5),		/* [1] */
+			BTF_DECL_TAG_ENC(NAME_NTH(2), 1, -1),		/* [2] */
+			BTF_DECL_TAG_ENC(NAME_NTH(3), 1, -1),		/* [3] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 1, -1),		/* [4] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [5] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0t\0tag1\0tag2\0tag3"),
@@ -7533,12 +7532,12 @@ static struct btf_dedup_test dedup_tests[] = {
 	.expect = {
 		.raw_types = {
 			/* ptr -> tag2 -> tag1 -> int */
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
-			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
-			BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),		/* [3] */
-			BTF_PTR_ENC(3),					/* [4] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 3),		/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),		/* [2] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [3] */
+			BTF_PTR_ENC(2),					/* [4] */
 			/* ptr -> tag1 -> int */
-			BTF_PTR_ENC(2),					/* [5] */
+			BTF_PTR_ENC(1),					/* [5] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0tag1\0tag2"),
@@ -7563,13 +7562,13 @@ static struct btf_dedup_test dedup_tests[] = {
 	.expect = {
 		.raw_types = {
 			/* ptr -> tag2 -> tag1 -> int */
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
-			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
-			BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),		/* [3] */
-			BTF_PTR_ENC(3),					/* [4] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 4),		/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),		/* [2] */
 			/* ptr -> tag2 -> int */
-			BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),		/* [5] */
-			BTF_PTR_ENC(5),					/* [6] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 4),		/* [3] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [4] */
+			BTF_PTR_ENC(2),					/* [5] */
+			BTF_PTR_ENC(3),					/* [6] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0tag1\0tag2"),
@@ -7594,15 +7593,13 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
-			/* ptr -> tag2 -> tag1 -> int */
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
-			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
-			BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),		/* [3] */
-			BTF_PTR_ENC(3),					/* [4] */
-			/* ptr -> tag1 -> tag2 -> int */
-			BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),		/* [5] */
-			BTF_TYPE_TAG_ENC(NAME_NTH(1), 5),		/* [6] */
-			BTF_PTR_ENC(6),					/* [7] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 5),		/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 4),		/* [2] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),		/* [3] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 5),		/* [4] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [5] */
+			BTF_PTR_ENC(3),					/* [6] */
+			BTF_PTR_ENC(2),					/* [7] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0tag1\0tag2"),
@@ -7626,14 +7623,12 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
-			/* ptr -> tag1 -> int */
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
-			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
-			BTF_PTR_ENC(2),					/* [3] */
-			/* ptr -> tag1 -> long */
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8),	/* [4] */
-			BTF_TYPE_TAG_ENC(NAME_NTH(1), 4),		/* [5] */
-			BTF_PTR_ENC(5),					/* [6] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 3),		/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 5),		/* [2] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [3] */
+			BTF_PTR_ENC(1),					/* [4] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8),	/* [5] */
+			BTF_PTR_ENC(2),					/* [6] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0tag1"),
@@ -7656,10 +7651,10 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),				/* [1] */
-			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),					/* [2] */
-			BTF_TYPE_ENC(NAME_NTH(2), BTF_INFO_ENC(BTF_KIND_STRUCT, 1, 1), 4),	/* [3] */
+			BTF_TYPE_ENC(NAME_NTH(2), BTF_INFO_ENC(BTF_KIND_STRUCT, 1, 1), 4),	/* [1] */
 			BTF_MEMBER_ENC(NAME_NTH(3), 2, BTF_MEMBER_OFFSET(0, 0)),
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 3),					/* [2] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),				/* [3] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0tag1\0t\0m"),
@@ -7861,10 +7856,10 @@ static struct btf_dedup_test dedup_tests[] = {
 	.expect = {
 		.raw_types = {
 			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
-			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
-			BTF_PTR_ENC(1),                                /* [3] */
-			BTF_TYPEDEF_ENC(NAME_NTH(3), 3),               /* [4] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 3, 0),
+			BTF_TYPEDEF_ENC(NAME_NTH(3), 4),               /* [2] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [3] */
+			BTF_PTR_ENC(1),                                /* [4] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0foo\0x\0foo_ptr"),
@@ -7901,10 +7896,10 @@ static struct btf_dedup_test dedup_tests[] = {
 	.expect = {
 		.raw_types = {
 			BTF_UNION_ENC(NAME_NTH(1), 1, 4),              /* [1] */
-			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
-			BTF_PTR_ENC(1),                                /* [3] */
-			BTF_TYPEDEF_ENC(NAME_NTH(3), 3),               /* [4] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 3, 0),
+			BTF_TYPEDEF_ENC(NAME_NTH(3), 4),               /* [2] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [3] */
+			BTF_PTR_ENC(1),                                /* [4] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0foo\0x\0foo_ptr"),
@@ -7940,14 +7935,12 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
-			/* CU 1 */
 			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
-			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
-			/* CU 2 */
-			BTF_FWD_ENC(NAME_NTH(3), 1),                   /* [3] */
-			BTF_PTR_ENC(3),                                /* [4] */
-			BTF_TYPEDEF_ENC(NAME_NTH(3), 4),               /* [5] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 4, 0),
+			BTF_FWD_ENC(NAME_NTH(3), 1),                   /* [2] */
+			BTF_TYPEDEF_ENC(NAME_NTH(3), 5),               /* [3] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [4] */
+			BTF_PTR_ENC(2),                                /* [5] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0foo\0x\0foo_ptr"),
@@ -7990,18 +7983,15 @@ static struct btf_dedup_test dedup_tests[] = {
 	},
 	.expect = {
 		.raw_types = {
-			/* CU 1 */
 			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
-			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
-			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
-			/* CU 2 */
-			BTF_FWD_ENC(NAME_NTH(1), 0),                   /* [3] */
-			BTF_PTR_ENC(3),                                /* [4] */
-			BTF_TYPEDEF_ENC(NAME_NTH(4), 4),               /* [5] */
-			/* CU 3 */
-			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             /* [6] */
-			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
-			BTF_MEMBER_ENC(NAME_NTH(3), 2, 0),
+			BTF_MEMBER_ENC(NAME_NTH(2), 5, 0),
+			BTF_FWD_ENC(NAME_NTH(1), 0),                   /* [2] */
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             /* [3] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 5, 0),
+			BTF_MEMBER_ENC(NAME_NTH(3), 5, 0),
+			BTF_TYPEDEF_ENC(NAME_NTH(4), 6),               /* [4] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [5] */
+			BTF_PTR_ENC(2),                                /* [6] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0foo\0x\0y\0foo_ptr"),
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
index d9024c7a892a..e50c290b2d8c 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -311,18 +311,18 @@ static void test_split_struct_duped() {
 		"[5] STRUCT 's1' size=16 vlen=2\n"
 		"\t'f1' type_id=2 bits_offset=0\n"
 		"\t'f2' type_id=4 bits_offset=64",
-		"[6] PTR '(anon)' type_id=8",
-		"[7] PTR '(anon)' type_id=9",
-		"[8] STRUCT 's1' size=16 vlen=2\n"
-		"\t'f1' type_id=6 bits_offset=0\n"
-		"\t'f2' type_id=7 bits_offset=64",
-		"[9] STRUCT 's2' size=40 vlen=4\n"
-		"\t'f1' type_id=6 bits_offset=0\n"
-		"\t'f2' type_id=7 bits_offset=64\n"
+		"[6] STRUCT 's1' size=16 vlen=2\n"
+		"\t'f1' type_id=9 bits_offset=0\n"
+		"\t'f2' type_id=10 bits_offset=64",
+		"[7] STRUCT 's2' size=40 vlen=4\n"
+		"\t'f1' type_id=9 bits_offset=0\n"
+		"\t'f2' type_id=10 bits_offset=64\n"
 		"\t'f3' type_id=1 bits_offset=128\n"
-		"\t'f4' type_id=8 bits_offset=192",
-		"[10] STRUCT 's3' size=8 vlen=1\n"
-		"\t'f1' type_id=7 bits_offset=0");
+		"\t'f4' type_id=6 bits_offset=192",
+		"[8] STRUCT 's3' size=8 vlen=1\n"
+		"\t'f1' type_id=10 bits_offset=0",
+		"[9] PTR '(anon)' type_id=6",
+		"[10] PTR '(anon)' type_id=7");
 
 cleanup:
 	btf__free(btf2);
@@ -385,13 +385,13 @@ static void test_split_dup_struct_in_cu()
 
 	VALIDATE_RAW_BTF(
 			btf1,
-			"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
-			"[2] STRUCT 's' size=8 vlen=2\n"
-			"\t'a' type_id=3 bits_offset=0\n"
-			"\t'b' type_id=3 bits_offset=0",
-			"[3] STRUCT '(anon)' size=8 vlen=2\n"
-			"\t'f1' type_id=1 bits_offset=0\n"
-			"\t'f2' type_id=1 bits_offset=32");
+			"[1] STRUCT '(anon)' size=8 vlen=2\n"
+			"\t'f1' type_id=2 bits_offset=0\n"
+			"\t'f2' type_id=2 bits_offset=32",
+			"[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+			"[3] STRUCT 's' size=8 vlen=2\n"
+			"\t'a' type_id=1 bits_offset=0\n"
+			"\t'b' type_id=1 bits_offset=0");
 
 	/* and add the same data on top of it */
 	btf2 = btf__new_empty_split(btf1);
@@ -402,13 +402,13 @@ static void test_split_dup_struct_in_cu()
 
 	VALIDATE_RAW_BTF(
 			btf2,
-			"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
-			"[2] STRUCT 's' size=8 vlen=2\n"
-			"\t'a' type_id=3 bits_offset=0\n"
-			"\t'b' type_id=3 bits_offset=0",
-			"[3] STRUCT '(anon)' size=8 vlen=2\n"
-			"\t'f1' type_id=1 bits_offset=0\n"
-			"\t'f2' type_id=1 bits_offset=32",
+			"[1] STRUCT '(anon)' size=8 vlen=2\n"
+			"\t'f1' type_id=2 bits_offset=0\n"
+			"\t'f2' type_id=2 bits_offset=32",
+			"[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+			"[3] STRUCT 's' size=8 vlen=2\n"
+			"\t'a' type_id=1 bits_offset=0\n"
+			"\t'b' type_id=1 bits_offset=0",
 			"[4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
 			"[5] STRUCT 's' size=8 vlen=2\n"
 			"\t'a' type_id=6 bits_offset=0\n"
@@ -427,13 +427,13 @@ static void test_split_dup_struct_in_cu()
 	/* after dedup it should match the original data */
 	VALIDATE_RAW_BTF(
 			btf2,
-			"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
-			"[2] STRUCT 's' size=8 vlen=2\n"
-			"\t'a' type_id=3 bits_offset=0\n"
-			"\t'b' type_id=3 bits_offset=0",
-			"[3] STRUCT '(anon)' size=8 vlen=2\n"
-			"\t'f1' type_id=1 bits_offset=0\n"
-			"\t'f2' type_id=1 bits_offset=32");
+			"[1] STRUCT '(anon)' size=8 vlen=2\n"
+			"\t'f1' type_id=2 bits_offset=0\n"
+			"\t'f2' type_id=2 bits_offset=32",
+			"[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+			"[3] STRUCT 's' size=8 vlen=2\n"
+			"\t'a' type_id=1 bits_offset=0\n"
+			"\t'b' type_id=1 bits_offset=0");
 
 cleanup:
 	btf__free(btf2);
-- 
2.34.1


