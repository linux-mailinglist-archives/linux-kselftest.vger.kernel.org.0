Return-Path: <linux-kselftest+bounces-20881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7159B3F12
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 01:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAA6283149
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A27B664;
	Tue, 29 Oct 2024 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7hgt42/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755838F5E;
	Tue, 29 Oct 2024 00:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161351; cv=none; b=kuTTdpyUOTkI5sk7Tb27+jbiMuNZca6I7AIqST/BMp8oV+wqSAm2OcK7rqbDJMnrE/HmndwQdbhaAykHAkfYXkVIRCv+wR02Ccojg/OCf1Bzpe9P10T4opkJGqBpYklWnIVlqPdk645trL55CCdFVK0kRJqwQxpqNTrKHHB1CRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161351; c=relaxed/simple;
	bh=fcC1iFJKxdZfE7f4KdQ33h051tuX1f6s3QXqbwjKvaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hkw0/iD28N789ZUQRKua7+5YdS4JyHDrxVD1msSmEUkHcFwymaRb/I7/yCP9DBXi4lqmPPki4mk3scJ4t3D3clrOlh5AoQ6tHb5nl7ekib+/0pNT34jqtjI9ZCgN1cCOq6/QLVj7xigzgfCWqbFKUb7P3lyE58Toq6B8IfYwyOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7hgt42/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c70abba48so38414265ad.0;
        Mon, 28 Oct 2024 17:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730161349; x=1730766149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Jdi+t099FdxC155FhQSAwxqJnHWS1BYqwkZvlhr0Dw=;
        b=G7hgt42/vs4m7ivnOJ6blQjKdJF6AZuA6QJNF8jAFSHplS0SdLxwH2PJb8gtjAjh3j
         Gt19M96z68d2V7c8XFhPs2mA/Bmx48AWl6Cm6ihwXQKDLkBxFslBbfIN60Do7vXTJ3aV
         cYAplVSq24h92z79sezxwXxgPBsrgOnrRpgV6JKjNHljagdxneTo9FCio0fJQ0ZXXqc8
         qca6JhdgMeHj3T6LKtwRnC7PaO0YbkTEmp92fUzH6ECdI4GKUOLvfQlWVjqU9FPDNVx/
         tAphfFq57iDcHxpiju6rYNHzk4gjh0vbA5CDvvG2Mxy1aCzQbUKaNO6DFMFPQgXMES3i
         tLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730161349; x=1730766149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Jdi+t099FdxC155FhQSAwxqJnHWS1BYqwkZvlhr0Dw=;
        b=bOwWEU+m/vD2k1zO050jrP7ntDMuH/6TznidfSRdtUWWnYaFIIHbp1UYKKWHPzTwo2
         sHKCSX3SB4Uvd1RSpYQF2KqVBNZvXJxiQAOqo8I24mVZwWyZCHHGxCvm5uzKsYEfyrLX
         JX7WWnxhT1Rypf7n/ah59Vx2SnMo2z2UpFEY4wwtnSHHVhQHzJoUrj9Tu0tGWCkvw/Cm
         9/8a3Jl2SdV2aoV6DcGioGobtYDP/3b6R8YI0soHPd0QlbvKlhnSG/4rWBDfYNtkxkOE
         zLn31ogThkI3jIRCPXDAcBwB1R1m93HWMks8wA5u2Gqy+PyJMdkQJnICa8F8i6kPlrhx
         Vi5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUef3EsLwN4eF/g4gJ4I+Ben6iDw+Zb8N9wKgawKUxhN2l/ebxF+KWBIHry6YXL7f5uGN5gx5RTU1t01mAZku+w@vger.kernel.org, AJvYcCVO+7CrLjDK1fUrBJoXwUFBkoqgCQzqsbTmX5lYbBkjKA3KtJsJKK02G0nUs/cQTGRcbBc=@vger.kernel.org, AJvYcCWCLoPp/EyspuuJqtbRjZAcCfEliHZ6PbWnups1WvNmKvWcYZrVWRVGHRyXvVkASm8uvObpiYZsX2ofju3NdChaWYNV@vger.kernel.org, AJvYcCXvm3NOdNC/awCJS5DnEwnCXjwpakk4OBz9bSTUzMYPvWtlwt9kwQ6Q0uds2HPCUYNrlcxG7ywGC+dDcRKl@vger.kernel.org
X-Gm-Message-State: AOJu0YxA5f2L7ristGF6Z/UEqi0eFqWW1WNRTf40f6wNSYG11RXo7Mm1
	udgsFH3JmGp4LG/LqOELmWtQnAEorZJdnO+WaVt86bsPl6J8hy6GRcqqiG9U
X-Google-Smtp-Source: AGHT+IGB30CXe1oQBemeYR93KMMMhpUXeFg9EpzOhIsD5obt8Oeze7ecpx1bRZmToLJjfi0Nl3d8gA==
X-Received: by 2002:a17:90a:6fe3:b0:2e2:e6c8:36a7 with SMTP id 98e67ed59e1d1-2e8f10a75bdmr12849246a91.31.1730161348713;
        Mon, 28 Oct 2024 17:22:28 -0700 (PDT)
Received: from pengdl-ub.localdomain ([106.37.77.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48e4a2sm10175507a91.2.2024.10.28.17.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 17:22:27 -0700 (PDT)
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
Subject: [PATCH v4 2/3] bpf: Using binary search to improve the performance of btf_find_by_name_kind
Date: Tue, 29 Oct 2024 08:22:07 +0800
Message-Id: <20241029002208.1947947-3-dolinux.peng@gmail.com>
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
which has a time complexity of O(log(n)). This idea was inspired by the
following patch:

60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_name()").

At present, this improvement is only for searching in vmlinux's and
module's BTFs.

Another change is the search direction, where we search the BTF first and
then its base, the type id of the first matched btf_type will be returned.

Here is a time-consuming result that finding 87590 type ids by their names in
vmlinux's BTF.

Before: 158426 ms
After:     114 ms

The average lookup performance has improved more than 1000x in the above scenario.

Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
v4:
 - move the modification of libbpf to another patch

v3:
 - Link: https://lore.kernel.org/all/20240608140835.965949-1-dolinux.peng@gmail.com/
 - Sort btf_types during build process other than during boot, to reduce the
   overhead of memory and boot time.

v2:
 - Link: https://lore.kernel.org/all/20230909091646.420163-1-pengdonglin@sangfor.com.cn
---
 include/linux/btf.h |   1 +
 kernel/bpf/btf.c    | 157 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 147 insertions(+), 11 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index b8a583194c4a..64c35aaa22fa 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -216,6 +216,7 @@ bool btf_is_module(const struct btf *btf);
 bool btf_is_vmlinux(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
+u32 btf_type_cnt(const struct btf *btf);
 struct btf *btf_base_btf(const struct btf *btf);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5cd1c7a23848..6d0d58989640 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -262,6 +262,7 @@ struct btf {
 	u32 data_size;
 	refcount_t refcnt;
 	u32 id;
+	u32 nr_types_sorted;
 	struct rcu_head rcu;
 	struct btf_kfunc_set_tab *kfunc_set_tab;
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
@@ -548,23 +549,102 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
-s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
+u32 btf_type_cnt(const struct btf *btf)
+{
+	return btf->start_id + btf->nr_types;
+}
+
+static s32 btf_find_by_name_bsearch(const struct btf *btf, const char *name,
+				    int *start, int *end)
 {
 	const struct btf_type *t;
-	const char *tname;
-	u32 i, total;
+	const char *name_buf;
+	int low, low_start, mid, high, high_end;
+	int ret, start_id;
+
+	start_id = btf->base_btf ? btf->start_id : 1;
+	low_start = low = start_id;
+	high_end = high = start_id + btf->nr_types_sorted - 1;
+
+	while (low <= high) {
+		mid = low + (high - low) / 2;
+		t = btf_type_by_id(btf, mid);
+		name_buf = btf_name_by_offset(btf, t->name_off);
+		ret = strcmp(name, name_buf);
+		if (ret > 0)
+			low = mid + 1;
+		else if (ret < 0)
+			high = mid - 1;
+		else
+			break;
+	}
 
-	total = btf_nr_types(btf);
-	for (i = 1; i < total; i++) {
-		t = btf_type_by_id(btf, i);
-		if (BTF_INFO_KIND(t->info) != kind)
-			continue;
+	if (low > high)
+		return -ESRCH;
 
-		tname = btf_name_by_offset(btf, t->name_off);
-		if (!strcmp(tname, name))
-			return i;
+	if (start) {
+		low = mid;
+		while (low > low_start) {
+			t = btf_type_by_id(btf, low-1);
+			name_buf = btf_name_by_offset(btf, t->name_off);
+			if (strcmp(name, name_buf))
+				break;
+			low--;
+		}
+		*start = low;
+	}
+
+	if (end) {
+		high = mid;
+		while (high < high_end) {
+			t = btf_type_by_id(btf, high+1);
+			name_buf = btf_name_by_offset(btf, t->name_off);
+			if (strcmp(name, name_buf))
+				break;
+			high++;
+		}
+		*end = high;
 	}
 
+	return mid;
+}
+
+s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
+{
+	const struct btf_type *t;
+	const char *tname;
+	int start, end;
+	s32 id, total;
+
+	do {
+		if (btf->nr_types_sorted) {
+			/* binary search */
+			id = btf_find_by_name_bsearch(btf, name, &start, &end);
+			if (id > 0) {
+				while (start <= end) {
+					t = btf_type_by_id(btf, start);
+					if (BTF_INFO_KIND(t->info) == kind)
+						return start;
+					start++;
+				}
+			}
+		} else {
+			/* linear search */
+			total = btf_type_cnt(btf);
+			for (id = btf->base_btf ? btf->start_id : 1;
+				id < total; id++) {
+				t = btf_type_by_id(btf, id);
+				if (BTF_INFO_KIND(t->info) != kind)
+					continue;
+
+				tname = btf_name_by_offset(btf, t->name_off);
+				if (!strcmp(tname, name))
+					return id;
+			}
+		}
+		btf = btf->base_btf;
+	} while (btf);
+
 	return -ENOENT;
 }
 
@@ -6141,6 +6221,53 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 	return kctx_type_id;
 }
 
+static int btf_check_sort(struct btf *btf, int start_id)
+{
+	int i, n, nr_names = 0;
+
+	n = btf_nr_types(btf);
+	for (i = start_id; i < n; i++) {
+		const struct btf_type *t;
+		const char *name;
+
+		t = btf_type_by_id(btf, i);
+		if (!t)
+			return -EINVAL;
+
+		name = btf_str_by_offset(btf, t->name_off);
+		if (!str_is_empty(name))
+			nr_names++;
+	}
+
+	for (i = 0; i < nr_names - 1; i++) {
+		const struct btf_type *t1, *t2;
+		const char *s1, *s2;
+
+		t1 = btf_type_by_id(btf, start_id + i);
+		if (!t1)
+			return -EINVAL;
+
+		s1 = btf_str_by_offset(btf, t1->name_off);
+		if (str_is_empty(s1))
+			goto out;
+
+		t2 = btf_type_by_id(btf, start_id + i + 1);
+		if (!t2)
+			return -EINVAL;
+
+		s2 = btf_str_by_offset(btf, t2->name_off);
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
 BTF_ID_LIST(bpf_ctx_convert_btf_id)
 BTF_ID(struct, bpf_ctx_convert)
 
@@ -6212,6 +6339,10 @@ struct btf *btf_parse_vmlinux(void)
 	if (IS_ERR(btf))
 		goto err_out;
 
+	err = btf_check_sort(btf, 1);
+	if (err)
+		goto err_out;
+
 	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
 	err = btf_alloc_id(btf);
@@ -6315,6 +6446,10 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 		base_btf = vmlinux_btf;
 	}
 
+	err = btf_check_sort(btf, btf_nr_types(base_btf));
+	if (err)
+		goto errout;
+
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
-- 
2.34.1


