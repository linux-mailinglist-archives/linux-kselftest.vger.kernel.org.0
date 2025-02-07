Return-Path: <linux-kselftest+bounces-25964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48EA2BAD2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 06:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A1167006
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 05:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4CC2343C5;
	Fri,  7 Feb 2025 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UHEPg4YV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DA9233D8F
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738907126; cv=none; b=Ewf2hxNT6dNgq5wPCejL7+UkQS4rKT9t32xAqDCPCe6Rfqp9gA37pUDKp58ZYjEB/s3g6BoGoYtdMp3/ypTcxhl4d/K3v4i2t8/kFxrUVB80ZP8E8Uf0lQL345BeR/YZP6NKuPfKaWYICnlL6aJDK/tOpQ0cM1qN0cWgTNIsVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738907126; c=relaxed/simple;
	bh=TSqw6WTzkGxJ2g7v2P63DZ+KseEhuRtpFe8QcAD65c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkrULn+zYDYyVF0HtXzzy1R5UqZdlM4FxxBB2O9T7qm2PtOin6YWFYooBBR8eKmsHEg6aQJZlz8Py+IisjdG2e5kgJ6uBy5K4gfSX26EYw/InkceVNcM4czbCXqi11EWHbROvbG8+b1X6gxV8WiVS9gBszVDRV2KPRfg9Wb0uPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UHEPg4YV; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6e8814842so190158985a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 21:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738907123; x=1739511923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BiL88Vl7FssHFuR4sgsTuWpUW3EZbuNKD07jWPDb1JA=;
        b=UHEPg4YVibcpTJ1mxaJRGLdhZvlvZ2EM/Z4sqsMsVLTNFTaB2r8peb7JBdIex/qYnw
         lK5vLlkMdjY+tqFSXvVOw2WSelcQ+KUb51Ho0dWExP4NnKMCFRdOAP7F+qX1hyyW4wD5
         RIVDkAPbgqdMWSgeaDWSWU+IbwuFVEDj38tiSDNlZ5WuD1dC43q3doQNvVCaophJgEDN
         M7a9eyQma7FA72ofTx5y/50H6w0wtKVKm7p1pqzCXLnoMeddfD/uFzKnyPjSeklPNtgs
         eySYagC2xNcvtlDc6Vyk6pIUVuFpXtVHmsnM1iGYa5a2GZLgVGAhMRMThPKIqVqAJmvy
         jfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738907123; x=1739511923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiL88Vl7FssHFuR4sgsTuWpUW3EZbuNKD07jWPDb1JA=;
        b=IWudib2A/nrZEmCCuLs330t18Nh1QrKYbQvGfuK9Wv/fvwbLphcMmzK66azmiOzg1Z
         2HbQGXNdgu9EaZbGNk5sZvXCUbZfQZa+s0htl2mbwXj3QAtTHubzVlNMUQrdjRMfKu2v
         Ydyh5hUH6qOYnEDn1IkmrHpn1uxpObrUbKArvf9EukQlLNsrrodqgoUZMNbdsyc2VmAN
         xdp8qIO/REq0ps9Iexjz43XCstdILgBfITvu8Ibk8aUXt51UE5ip7VVzb7JsdRMMETcv
         t69ZjMqEBmKnGVKLFodX4yyzRzGf8cvsmIHDQaBL8r73Sl34E2ADw1bbrbDbY9o+gB+I
         L7Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWPktZOzvASPDhhSbQcdXkojFa/kyVwTYYagyXzHOm6MCZXu44BP408L1sjFSmT56hqsK43hMqidWTA4AgdVf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8ZpBNHO0wfD57B514Aqp6zaXPUSrn/y13AYlBYxbhJwmD/Sj
	8JqhYr4StskGP+4U73uyeClDfZzvoQQFK2VKbPGjKVcbdy8iRiNUlh/MD2znRpU=
X-Gm-Gg: ASbGnctqKpo/hiGRxhW+oEyZkgVrhMbL8eAy8Vha0+lcSh24pNXHxgett2Q12vDmtfi
	O4trX4GlTynjOK/OeuPp2M3VVsCPIgq+NESDmGVwOaFOLqNih94rkrQxsrdQgEW3DIoQZG7EhpI
	dctYtOZL7lM/KhbKS94/CEFy8pCZDWG6KJjzy0QeNJ3IScr1YUl/5ssTxFVdweguCKCXRoTIchb
	A7Hy7FuV1A9rZ0oFI27n+05uYZDoGq2jtAllV/qeX3APFDzYCuEdGTZpo7HAQC3ExfxCvQIVH3L
	C7I=
X-Google-Smtp-Source: AGHT+IGZ3e/LBC9oFo92G9gFvFYL6g4CWsC0kkEIeD2dmJfNrUDCabnMPaFC52kKEkSHxzG2IanhUQ==
X-Received: by 2002:a05:620a:258b:b0:7b6:e9be:97dc with SMTP id af79cd13be357-7c047ba498bmr301516785a.8.1738907123361;
        Thu, 06 Feb 2025 21:45:23 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:25a5::3c0:2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041eb7f94sm147517385a.96.2025.02.06.21.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 21:45:22 -0800 (PST)
Date: Thu, 6 Feb 2025 21:45:20 -0800
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
Subject: [PATCH v2 bpf 2/2] selftests: bpf: test batch lookup on array of
 maps with holes
Message-ID: <6e710c8034800cb14e7db2d77b2081222bcb247e.1738905497.git.yan@cloudflare.com>
References: <cover.1738905497.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1738905497.git.yan@cloudflare.com>

Iterating through array of maps may encounter non existing keys. The
batch operation should not fail on when this happens.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 .../bpf/map_tests/map_in_map_batch_ops.c      | 62 +++++++++++++------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
index 66191ae9863c..79c3ccadb962 100644
--- a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
@@ -120,11 +120,12 @@ static void validate_fetch_results(int outer_map_fd,
 
 static void fetch_and_validate(int outer_map_fd,
 			       struct bpf_map_batch_opts *opts,
-			       __u32 batch_size, bool delete_entries)
+			       __u32 batch_size, bool delete_entries,
+			       bool has_holes)
 {
-	__u32 *fetched_keys, *fetched_values, total_fetched = 0;
-	__u32 batch_key = 0, fetch_count, step_size;
-	int err, max_entries = OUTER_MAP_ENTRIES;
+	int err, max_entries = OUTER_MAP_ENTRIES - !!has_holes;
+	__u32 *fetched_keys, *fetched_values, total_fetched = 0, i;
+	__u32 batch_key = 0, fetch_count, step_size = batch_size;
 	__u32 value_size = sizeof(__u32);
 
 	/* Total entries needs to be fetched */
@@ -134,9 +135,8 @@ static void fetch_and_validate(int outer_map_fd,
 	      "Memory allocation failed for fetched_keys or fetched_values",
 	      "error=%s\n", strerror(errno));
 
-	for (step_size = batch_size;
-	     step_size <= max_entries;
-	     step_size += batch_size) {
+	/* hash map may not always return full batch */
+	for (i = 0; i < OUTER_MAP_ENTRIES; i++) {
 		fetch_count = step_size;
 		err = delete_entries
 		      ? bpf_map_lookup_and_delete_batch(outer_map_fd,
@@ -155,6 +155,7 @@ static void fetch_and_validate(int outer_map_fd,
 		if (err && errno == ENOSPC) {
 			/* Fetch again with higher batch size */
 			total_fetched = 0;
+			step_size += batch_size;
 			continue;
 		}
 
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
@@ -219,15 +239,17 @@ static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
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
-	for (map_index = 0; map_index < max_entries; map_index++)
+	for (map_index = 0; map_index < OUTER_MAP_ENTRIES; map_index++)
 		close(inner_map_fds[map_index]);
 	close(outer_map_fd);
 
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
2.39.5



