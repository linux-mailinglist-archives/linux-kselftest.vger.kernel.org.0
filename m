Return-Path: <linux-kselftest+bounces-25857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A2DA296E0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 17:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C863F3A3596
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204E21DCB0E;
	Wed,  5 Feb 2025 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HN4gvm3Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7E1957E4
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Feb 2025 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774644; cv=none; b=EmhxJbF7KZAUyqhsfk3ZQ3qnyCY5yW4uT9oPaKUrXCi3UcL+yRiiZr8Ppd75XdOma3ISVPCU7OZjzL9YYrYK3yzbbCVQK0UvdME5Ugn49HoX9HLDbbzGZdzgvmI27capOJFf8k89PacajqYA1cgtEiu17JtpI+oX8EjD41t2zmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774644; c=relaxed/simple;
	bh=hTmYrUtvDtDUcNErOCnF5KMDz6KCUhHCVFlPA9Hjj2A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P3soc7IESAX5//hHw0lps9g4Nyz1ztAWc7JNKcat5rnPMmZ0Vu72PkPNgkc1nIgY2kSa+j3Zax2XpaLnehuuBj0Vh2dzVAORoLdKFBVT5rWbhjD03enYnxNnjrwQExFt2kflVoiBk+cHWOM98I1G/9iTtdBNqXZ0RUMGct+RGpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HN4gvm3Q; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467a3c85e11so91521cf.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Feb 2025 08:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738774641; x=1739379441; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MuxspxD9l1EL/wRembDX5nhsNE5eAeGboXj7wX/zvz0=;
        b=HN4gvm3QfHTDkNAm8N1aLHNmgFvsfTU3pijFpQe8Nbl/JDYFxwPBvoOjMRlrGdFZ+w
         vHJsB1imbxY0ykJzE4hlzPLBe4paSj/nGOdOSzZa6ugQQONJgQFFZm0wPC0pYOKM1W7a
         aw/9YHXv4V1Lnzi4si7gUzpaHh51bIUXXPqPdNMeS2bkydIJmkvxYHuUgnSkLA31inKm
         9UF965LeCiDccYQCpOaKRdpznAR5VULya6mjnGgY+vTLrmmUK4eqkGksb0PuES/wx6ld
         ryHKiAgw+hMCoUpW/ItvZybyUyxP9H8MKrRW+H8U9/RB8LUR6nbruKTX3q4mCkvHlNZz
         5WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738774641; x=1739379441;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuxspxD9l1EL/wRembDX5nhsNE5eAeGboXj7wX/zvz0=;
        b=LYL8wkyR03rm5u6zdw4qdJElkt4W5Mk5BOhbb9pG+yI4ER47rhA/8sOlFR0w7kCKxx
         wvgUy9TnT7HBNF5b1NP/P8tyOZLmaczqaxqTz2jE4/l8OfJzqmSYhvAWv+Xw4SsW542B
         768Aru7dz/k7X3LZZ1Aw4knN38D7CKYV1jL9kQ0FN8w43B+UmfRLSArlAJBUE4PUuoNl
         QcUO5icZ45Mdw4qPry2k5PKWTdFrewVaHzADcjNKXBlkQasOq6l8qhiU+JIT0lTwoeUu
         /OlK4oh3v2Ki8fsuxdUHrGcVDlH1xPecUwPEZyfIj7YHwOJYK/w0OSuY3X8EHx5S2Cig
         7VOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhvc35f+YBXn5CZge7rYGo/1J1d+WLxu/CAneeGFeNjLKhn78mT2QFZ0k9UyOlg4FvWGjj6L7ej7LHbBvK4Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRGVkMQsZ3MYSazmFMZPspdmYXFaztdHfGBUX+8pMkDd/juIOP
	vB28VmR7Xwi7yYVj0J6119Cw3xfbOj5RTRPRqPBbhqaj1/qQ9PvLaamuWKz9CPw=
X-Gm-Gg: ASbGncu3pfuBBAZZhyXkbK8HN5iau7RtB2pPjOjf2yWhzXihylNyw0eSpjtM2Af1zkM
	6h+YDcjS541+2LbhBUiLBo7kneDhpmgFimO+2UoTkmUqZ9lbeDgzfvAad/oxh7BLXb8T4M+lOz+
	SuxqGVXRnVSQWP1sxgqBylGl2hkx2+kpAiktg15SwDppi3OkdSASI4Aws6DvZit4S6Aid40X4PH
	BllP9s2lI+uLAOovwBBkxy5cUf5g4lp+1OvL+OOfAr8OCbzmNrMOGnpAzWpD3w6iore8ojebkYQ
	1hk=
X-Google-Smtp-Source: AGHT+IEqlaXoElCx1zJ3MQqDnSsbTBClrZr708bGMsVogUMANojRfr6kfHilLm8MzhiOFZLn4Mi5rA==
X-Received: by 2002:a05:622a:12:b0:467:4f0a:1b5d with SMTP id d75a77b69052e-4702829d84bmr41958531cf.42.1738774641019;
        Wed, 05 Feb 2025 08:57:21 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:25a5::3c0:2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0c62d4sm72022631cf.17.2025.02.05.08.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 08:57:20 -0800 (PST)
Date: Wed, 5 Feb 2025 08:57:17 -0800
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yan Zhai <yan@cloudflare.com>, Brian Vazquez <brianvv@google.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com, Hou Tao <houtao@huaweicloud.com>
Subject: [PATCH bpf] bpf: skip non existing key in generic_map_lookup_batch
Message-ID: <Z6OYbS4WqQnmzi2z@debian.debian>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The generic_map_lookup_batch currently returns EINTR if it fails with
ENOENT and retries several times on bpf_map_copy_value. The next batch
would start from the same location, presuming it's a transient issue.
This is incorrect if a map can actually have "holes", i.e.
"get_next_key" can return a key that does not point to a valid value. At
least the array of maps type may contain such holes legitly. Right now
these holes show up, generic batch lookup cannot proceed any more. It
will always fail with EINTR errors.

Rather, do not retry in generic_map_lookup_batch. If it finds a non
existing element, skip to the next key.

Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
Closes: https://lore.kernel.org/bpf/Z6JXtA1M5jAZx8xD@debian.debian/
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 kernel/bpf/syscall.c                          | 16 ++----
 .../bpf/map_tests/map_in_map_batch_ops.c      | 54 ++++++++++++++-----
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c420edbfb7c8..5691fc0d370d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1979,7 +1979,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	void __user *values = u64_to_user_ptr(attr->batch.values);
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
 	void *buf, *buf_prevkey, *prev_key, *key, *value;
-	int err, retry = MAP_LOOKUP_RETRIES;
+	int err;
 	u32 value_size, cp, max_count;
 
 	if (attr->batch.elem_flags & ~BPF_F_LOCK)
@@ -2026,14 +2026,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		err = bpf_map_copy_value(map, key, value,
 					 attr->batch.elem_flags);
 
-		if (err == -ENOENT) {
-			if (retry) {
-				retry--;
-				continue;
-			}
-			err = -EINTR;
-			break;
-		}
+		if (err == -ENOENT)
+			goto next_key;
 
 		if (err)
 			goto free_buf;
@@ -2048,12 +2042,12 @@ int generic_map_lookup_batch(struct bpf_map *map,
 			goto free_buf;
 		}
 
+		cp++;
+next_key:
 		if (!prev_key)
 			prev_key = buf_prevkey;
 
 		swap(prev_key, key);
-		retry = MAP_LOOKUP_RETRIES;
-		cp++;
 		cond_resched();
 	}
 
diff --git a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
index 66191ae9863c..b38be71f06be 100644
--- a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
@@ -120,11 +120,12 @@ static void validate_fetch_results(int outer_map_fd,
 
 static void fetch_and_validate(int outer_map_fd,
 			       struct bpf_map_batch_opts *opts,
-			       __u32 batch_size, bool delete_entries)
+			       __u32 batch_size, bool delete_entries,
+			       bool has_holes)
 {
+	int err, max_entries = OUTER_MAP_ENTRIES - !!has_holes;
 	__u32 *fetched_keys, *fetched_values, total_fetched = 0;
 	__u32 batch_key = 0, fetch_count, step_size;
-	int err, max_entries = OUTER_MAP_ENTRIES;
 	__u32 value_size = sizeof(__u32);
 
 	/* Total entries needs to be fetched */
@@ -135,9 +136,9 @@ static void fetch_and_validate(int outer_map_fd,
 	      "error=%s\n", strerror(errno));
 
 	for (step_size = batch_size;
-	     step_size <= max_entries;
+	     step_size < max_entries + batch_size; /* allow read partial */
 	     step_size += batch_size) {
-		fetch_count = step_size;
+		fetch_count = batch_size;
 		err = delete_entries
 		      ? bpf_map_lookup_and_delete_batch(outer_map_fd,
 				      total_fetched ? &batch_key : NULL,
@@ -184,18 +185,19 @@ static void fetch_and_validate(int outer_map_fd,
 }
 
 static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
-				  enum bpf_map_type inner_map_type)
+				  enum bpf_map_type inner_map_type,
+				  bool has_holes)
 {
+	__u32 max_entries = OUTER_MAP_ENTRIES - !!has_holes;
 	__u32 *outer_map_keys, *inner_map_fds;
-	__u32 max_entries = OUTER_MAP_ENTRIES;
 	LIBBPF_OPTS(bpf_map_batch_opts, opts);
 	__u32 value_size = sizeof(__u32);
 	int batch_size[2] = {5, 10};
 	__u32 map_index, op_index;
 	int outer_map_fd, ret;
 
-	outer_map_keys = calloc(max_entries, value_size);
-	inner_map_fds = calloc(max_entries, value_size);
+	outer_map_keys = calloc(OUTER_MAP_ENTRIES, value_size);
+	inner_map_fds = calloc(OUTER_MAP_ENTRIES, value_size);
 	CHECK((!outer_map_keys || !inner_map_fds),
 	      "Memory allocation failed for outer_map_keys or inner_map_fds",
 	      "error=%s\n", strerror(errno));
@@ -209,6 +211,24 @@ static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
 			((outer_map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
 			 ? 9 : 1000) - map_index;
 
+	/* This condition is only meaningful for array of maps.
+	 *
+	 * max_entries == OUTER_MAP_ENTRIES - 1 if it is true. Say
+	 * max_entries is short for n, then outer_map_keys looks like:
+	 *
+	 *   [n, n-1, ... 2, 1]
+	 *
+	 * We change it to
+	 *
+	 *   [n, n-1, ... 2, 0]
+	 *
+	 * So it will leave key 1 as a hole. It will serve to test the
+	 * correctness when batch on an array: a "non-exist" key might be
+	 * actually allocated and returned from key iteration.
+	 */
+	if (has_holes)
+		outer_map_keys[max_entries - 1]--;
+
 	/* batch operation - map_update */
 	ret = bpf_map_update_batch(outer_map_fd, outer_map_keys,
 				   inner_map_fds, &max_entries, &opts);
@@ -219,12 +239,14 @@ static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
 	/* batch operation - map_lookup */
 	for (op_index = 0; op_index < 2; ++op_index)
 		fetch_and_validate(outer_map_fd, &opts,
-				   batch_size[op_index], false);
+				   batch_size[op_index], false,
+				   has_holes);
 
 	/* batch operation - map_lookup_delete */
 	if (outer_map_type == BPF_MAP_TYPE_HASH_OF_MAPS)
 		fetch_and_validate(outer_map_fd, &opts,
-				   max_entries, true /*delete*/);
+				   max_entries, true /*delete*/,
+				   has_holes);
 
 	/* close all map fds */
 	for (map_index = 0; map_index < max_entries; map_index++)
@@ -237,16 +259,20 @@ static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
 
 void test_map_in_map_batch_ops_array(void)
 {
-	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_ARRAY);
+	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_ARRAY, false);
 	printf("%s:PASS with inner ARRAY map\n", __func__);
-	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_HASH);
+	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_HASH, false);
 	printf("%s:PASS with inner HASH map\n", __func__);
+	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_ARRAY, true);
+	printf("%s:PASS with inner ARRAY map with holes\n", __func__);
+	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_HASH, true);
+	printf("%s:PASS with inner HASH map with holes\n", __func__);
 }
 
 void test_map_in_map_batch_ops_hash(void)
 {
-	_map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_ARRAY);
+	_map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_ARRAY, false);
 	printf("%s:PASS with inner ARRAY map\n", __func__);
-	_map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_HASH);
+	_map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_HASH, false);
 	printf("%s:PASS with inner HASH map\n", __func__);
 }
-- 
2.30.2



