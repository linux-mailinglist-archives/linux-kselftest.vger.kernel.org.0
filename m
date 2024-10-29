Return-Path: <linux-kselftest+bounces-20882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F39B3F15
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 01:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E78283165
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC10B22338;
	Tue, 29 Oct 2024 00:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h656d6Ue"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325DD529;
	Tue, 29 Oct 2024 00:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161356; cv=none; b=cRXF3qwZ2a7GbOGcj+U1Vtlh4FxsDhB9oRD5qRIoyxA9w+JqUS1Ii6JKdBqjPriAtcmO4b+sx6jK/GKqd5YuGVa9r90GCitCSpIVI7qU1fn7lhk3zXyPob3vR7aS7V0WGoaElFhLlM0jClB4+hQMKjSd3pdlgw67t/XXTRSgnLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161356; c=relaxed/simple;
	bh=7snpNK2X7OssbINrb13dvlgAk1CmGzOUvCtAWtWASZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6KLXkouF3lAFZd6b2CEdNEkgkoh9N5Sqrpw7Oh3YPWMYZDsxyBidMKmjsgdwK+vuex5KtOmQm52hNatMIHyFHXuSNEjDgthgIVfpNNISFWme6LmOIFq8f5SB9hlmOGccZXhfydyYgozN1uxnQkA8/4A8NizfR6Nt3Hnwwo/09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h656d6Ue; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ce5e3b116so33234105ad.1;
        Mon, 28 Oct 2024 17:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730161354; x=1730766154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9yLdCYlpqPTX58B/EOpzxj/uwBLH6nW8WmtXaMecqk=;
        b=h656d6Ue6I+ZP7lZS0hRF8v+r7+stYfQFG6pJJhKcbtbxDnJ0FGyUnSC0su0B/z+q4
         tOqkecUwiIOgxJZ/sIsZw+UZDnTEBkAg1+vOMpR/Df9cMcXv2xl60yOmo5rBfN5k1Iuq
         Vwgqn6W6jK0iK9lV+z3Z2uYX8nXk9tTtgaulXgfTXU/b589kUZcouqK7KOc8tiU2SDC1
         G6VYPsW0gqQ41zHwAHIdjhzEWFFBT+MRg8wxhFU9AgvQy0MeXwFJO7QqZTbuPA9JQmxj
         0Yd1HU9WKCsBmN7xZQKQYKlO4Q1HUmfw6oycJe8oUqkVuuDMauKALPsVdKYoQxDi6uwk
         iv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730161354; x=1730766154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9yLdCYlpqPTX58B/EOpzxj/uwBLH6nW8WmtXaMecqk=;
        b=r2qs1y3/vbibfspFkQ7zRQFLQSc0sTVRmpXpxPZA1ADNsuagyQ1mFCEQE1FQSAjW5o
         /KB4WBrsD4VRNXLNhodzKOPTF0wDZ+yFxC5hHlrxiiOcTznIfui4PqFIH7ZcHSOrKnOt
         nZ5WxvxpMChQ72x1lOFNlVynX8kGSbB4Pfj7SSYDTwheOzFeRMvHrEegyymBRh7S818q
         I0Lx5lsAiW8heGg5ovzPxBZ37S0iZ3AtyUIxUFDKL2oLyP+/DPKoEGQidAlBTgWypBEw
         tcJr80X6JS2TfNcOLp+vCX+uPa/rHaBQTSkCJdV2mpeDwhrYKXtYRc3NHdb9clZkfFBk
         172Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIGGWXh49cAD4x5nY1uKDGBooWt2l0VxWWYAAUjUvVUKZvzDYoI9gGPwX+uRjqjTgWbLmNi/copb/XnFIf7/XaPiU9@vger.kernel.org, AJvYcCWY/hZ/IdWzYJhDd8YZaoO92Ds7HOE924VGL02B9fotF/KXkljHd3V+XfTrG54sIqUBdOcaDDtwp7EAxQyd@vger.kernel.org, AJvYcCWxq1cMKmmO2JwAmCZIuOoJL1Lh8D3KeqzmBDr7RVJ/0CwdrI38iG8pTmekIFniMnkQdsY=@vger.kernel.org, AJvYcCXkEEkdOfzqtWMUm0R+7PWPgsKpGqCwv3+cIPiSqH5h5wrZ8RwusFlV39rSQO9Nk7tqTJpsFid5gOi2JzQ9aowr@vger.kernel.org
X-Gm-Message-State: AOJu0YznwjJfiKdX0rmZRcBPjOJpNIeF94LGVbQLd/e7/B7iHAAMU8S7
	RW9itQ/zEWjZF3e35Tx81PqQRiHA8BqABhakBQ5jf0uvbTTODGRm
X-Google-Smtp-Source: AGHT+IGzmc7vrVmYh/WKbUFbUoX2HPcYORnMsySleT7RDYFhCjZkMJNnf2EpiDFCC7NKHLJWgV6tuA==
X-Received: by 2002:a17:90a:1347:b0:2e2:e91b:f0d3 with SMTP id 98e67ed59e1d1-2e8f11ac8d0mr10794538a91.29.1730161353523;
        Mon, 28 Oct 2024 17:22:33 -0700 (PDT)
Received: from pengdl-ub.localdomain ([106.37.77.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48e4a2sm10175507a91.2.2024.10.28.17.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 17:22:32 -0700 (PDT)
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
Subject: [PATCH v4 3/3] libbpf: Using binary search to improve the performance of btf__find_by_name_kind
Date: Tue, 29 Oct 2024 08:22:08 +0800
Message-Id: <20241029002208.1947947-4-dolinux.peng@gmail.com>
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

Currently, we are only using the linear search method to find the type id
by the name, which has a time complexity of O(n). This change involves
sorting the names of btf types in ascending order and using binary search,
which has a time complexity of O(log(n)).

Another change is the search direction, where we search the BTF first and
then its base.

Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/lib/bpf/btf.c | 159 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 140 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 5290e9d59997..cbf88a6b92e5 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -94,6 +94,10 @@ struct btf {
 	 *   - for split BTF counts number of types added on top of base BTF.
 	 */
 	__u32 nr_types;
+	/* number of types in this BTF instance which are sorted by name:
+	 *   - doesn't include special [0] void type;
+	 */
+	__u32 nr_types_sorted;
 	/* if not NULL, points to the base BTF on top of which the current
 	 * split BTF is based
 	 */
@@ -896,46 +900,111 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
-__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
+static __s32 btf__find_by_name_bsearch(const struct btf *btf, const char *name,
+				    int *start, int *end)
 {
-	__u32 i, nr_types = btf__type_cnt(btf);
+	const struct btf_type *t;
+	const char *name_buf;
+	int low, low_start, mid, high, high_end;
+	int ret;
+
+	low_start = low = btf->start_id;
+	high_end = high = btf->start_id + btf->nr_types_sorted - 1;
+
+	while (low <= high) {
+		mid = low + (high - low) / 2;
+		t = btf__type_by_id(btf, mid);
+		name_buf = btf__name_by_offset(btf, t->name_off);
+		ret = strcmp(name, name_buf);
+		if (ret > 0)
+			low = mid + 1;
+		else if (ret < 0)
+			high = mid - 1;
+		else
+			break;
+	}
 
-	if (!strcmp(type_name, "void"))
-		return 0;
+	if (low > high)
+		return -ESRCH;
 
-	for (i = 1; i < nr_types; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name = btf__name_by_offset(btf, t->name_off);
+	if (start) {
+		low = mid;
+		while (low > low_start) {
+			t = btf__type_by_id(btf, low-1);
+			name_buf = btf__name_by_offset(btf, t->name_off);
+			if (strcmp(name, name_buf))
+				break;
+			low--;
+		}
+		*start = low;
+	}
 
-		if (name && !strcmp(type_name, name))
-			return i;
+	if (end) {
+		high = mid;
+		while (high < high_end) {
+			t = btf__type_by_id(btf, high+1);
+			name_buf = btf__name_by_offset(btf, t->name_off);
+			if (strcmp(name, name_buf))
+				break;
+			high++;
+		}
+		*end = high;
 	}
 
-	return libbpf_err(-ENOENT);
+	return mid;
 }
 
 static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
 				   const char *type_name, __u32 kind)
 {
-	__u32 i, nr_types = btf__type_cnt(btf);
+	const struct btf_type *t;
+	const char *tname;
+	int start, end, id;
+	__u32 nr_types;
 
 	if (kind == BTF_KIND_UNKN || !strcmp(type_name, "void"))
 		return 0;
 
-	for (i = start_id; i < nr_types; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
-		const char *name;
-
-		if (btf_kind(t) != kind)
+	while (btf) {
+		if (btf->start_id < start_id) {
+			btf = btf->base_btf;
 			continue;
-		name = btf__name_by_offset(btf, t->name_off);
-		if (name && !strcmp(type_name, name))
-			return i;
+		}
+
+		if (btf->nr_types_sorted) {
+			id = btf__find_by_name_bsearch(btf, type_name, &start, &end);
+			if (id > 0) {
+				while (start <= end) {
+					t = btf__type_by_id(btf, start);
+					if (kind == BTF_KIND_MAX ||
+						btf_kind(t) == kind)
+						return start;
+					start++;
+				}
+			}
+		} else {
+			nr_types = btf__type_cnt(btf);
+			for (id = btf->start_id; id < nr_types; id++) {
+				t = btf__type_by_id(btf, id);
+				if (kind != BTF_KIND_MAX && btf_kind(t) != kind)
+					continue;
+
+				tname = btf__name_by_offset(btf, t->name_off);
+				if (tname && !strcmp(tname, type_name))
+					return id;
+			}
+		}
+		btf = btf__base_btf(btf);
 	}
 
 	return libbpf_err(-ENOENT);
 }
 
+__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
+{
+	return btf_find_by_name_kind(btf, 1, type_name, BTF_KIND_MAX);
+}
+
 __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
 				 __u32 kind)
 {
@@ -989,6 +1058,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 		return ERR_PTR(-ENOMEM);
 
 	btf->nr_types = 0;
+	btf->nr_types_sorted = 0;
 	btf->start_id = 1;
 	btf->start_str_off = 0;
 	btf->fd = -1;
@@ -1032,6 +1102,53 @@ struct btf *btf__new_empty_split(struct btf *base_btf)
 	return libbpf_ptr(btf_new_empty(base_btf));
 }
 
+static int btf_check_sort(struct btf *btf, __u32 start_id)
+{
+	__u32 i, n, nr_names = 0;
+
+	n = btf__type_cnt(btf);
+	for (i = start_id; i < n; i++) {
+		const struct btf_type *t;
+		const char *name;
+
+		t = btf__type_by_id(btf, i);
+		if (!t)
+			return libbpf_err(-EINVAL);
+
+		name = btf__str_by_offset(btf, t->name_off);
+		if (!str_is_empty(name))
+			nr_names++;
+	}
+
+	for (i = 0; i < nr_names - 1; i++) {
+		const struct btf_type *t1, *t2;
+		const char *s1, *s2;
+
+		t1 = btf__type_by_id(btf, start_id + i);
+		if (!t1)
+			return libbpf_err(-EINVAL);
+
+		s1 = btf__str_by_offset(btf, t1->name_off);
+		if (str_is_empty(s1))
+			goto out;
+
+		t2 = btf__type_by_id(btf, start_id + i + 1);
+		if (!t2)
+			return libbpf_err(-EINVAL);
+
+		s2 = btf__str_by_offset(btf, t2->name_off);
+		if (str_is_empty(s2))
+			goto out;
+
+		if (strcmp(s1, s2) > 0)
+			goto out;
+	}
+
+	btf->nr_types_sorted = nr_names;
+out:
+	return 0;
+}
+
 static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 {
 	struct btf *btf;
@@ -1042,6 +1159,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 		return ERR_PTR(-ENOMEM);
 
 	btf->nr_types = 0;
+	btf->nr_types_sorted = 0;
 	btf->start_id = 1;
 	btf->start_str_off = 0;
 	btf->fd = -1;
@@ -1071,6 +1189,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 	err = btf_parse_str_sec(btf);
 	err = err ?: btf_parse_type_sec(btf);
 	err = err ?: btf_sanity_check(btf);
+	err = err ?: btf_check_sort(btf, btf->start_id);
 	if (err)
 		goto done;
 
@@ -1690,6 +1809,8 @@ static int btf_ensure_modifiable(struct btf *btf)
 	btf->types_data_cap = btf->hdr->type_len;
 	btf->strs_data = NULL;
 	btf->strs_set = set;
+	/* clear when splitting */
+	btf->nr_types_sorted = 0;
 	/* if BTF was created from scratch, all strings are guaranteed to be
 	 * unique and deduplicated
 	 */
-- 
2.34.1


