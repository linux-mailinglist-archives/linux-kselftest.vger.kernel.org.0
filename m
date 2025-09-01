Return-Path: <linux-kselftest+bounces-40388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C13CFB3D7D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 05:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE8D7ACA1D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 03:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEAD23D7C8;
	Mon,  1 Sep 2025 03:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1r6d+pJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10523D283;
	Mon,  1 Sep 2025 03:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698189; cv=none; b=lxt4qUnTDfVbbEUWR3ASfLqcNgZz0hHLHjmVjHOygI5Th9J41nTY+n+rv1K/4X2lvBGtR0CnMrvgsx/DfCneWMS1wp28tiomA5lNVixNhReEDR8cnAf4fn1MMxLdnfG2m80xpxtEwBcbExKBZWLcm8qdylnjdBBDuimgfQuh/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698189; c=relaxed/simple;
	bh=8YXNScb3WUslXUHAr9SqwO7i8ipX6HOGoQ0I+T5e9EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urzrgnJiRlbEQPdDgsJOpKiUPcx9xI+Toqd6TIkm/4v1kMKSuf1FezkRIY5frZ1z15bqZzhzUD6HYAptDJGoNK+qlbvTmB+L3lljaR5phvT/UlXrSS+pd7M9ySa8T/OHhrGfaEqR9nDDKmQ7Mt8VX5CjBW0TnzU0GCnOqd+jdDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1r6d+pJ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-24a95f9420aso10664475ad.0;
        Sun, 31 Aug 2025 20:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756698187; x=1757302987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JDYZDAUFLCV+pFRN5UCiynXeZxRPYp3mr9Scsq1QQw=;
        b=L1r6d+pJuAehVqbkFce/H5fhXvKFLAK4uDhJp0VScM7nzEqkXLmJOtpkHTSUENQbub
         H6pTyjA7OCRsBMmueqhUttA9hBn8b+n/JOkuN9EuMc3l3ovta1TVT2aThqZyp3W17vGp
         B6TSCyQQTSBqkY0reWCqWh8CFVd5jl7nF9R3q8lr2KFgLXmefJdXsKLCd6BWkNE3qDJ/
         JvEVuLCxK+7d7xIG33HgARxqOVYur71oC5NdrLchwVq+wJ1ju3CuAwUR8qCuQTOJrgRx
         RPNfVDqt1ZXaJc7xxHpC7PGVOsZlEayX76kgaN2UWHTzKrTl+D/na6vsDb1DJ4fLfN7u
         uAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756698187; x=1757302987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JDYZDAUFLCV+pFRN5UCiynXeZxRPYp3mr9Scsq1QQw=;
        b=peL2b/M45w2BwAiv/qx3rFa0vUMuVzxgigYHhtO2dhRs1D1+EZ7R6WZ5xmo1QDvYl+
         iGIe4wCutgd5Y3xoO7ySyDpj1z28oPqI/sPoc3WKrkwXSRf5ltx2G+R+nUzq4h12SBZi
         gAFwIK5cXxNXWR9ECWRzhAzJcpR02tNyRDDj+qj922eOtl9LUZEYelcWoi0q8p1d004r
         XMFhsOf2dpM0VVRGsGjNbWuVIN2wMat8UyIzkFP32Iv/oY/84gT+hc2dqEBVJNEVbni3
         032hCN5zliUk5Z5pIXgg4hJqa+erJsV+zF3DLBdHUIC4Widfck3D+ccwLnmIQ6FkFGS9
         HJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR4za1zhlI2ZbIthgPsvGGRUhl9QQpCToOli9I8mnTbo9WufIRJRqmNTB3Y9ji54xOVGvbLAPgL7wG+opW@vger.kernel.org, AJvYcCVCL3Vxg9xOizJjnC0pMajQ2X1a53k9m493oV7ekKrJmLMPxlXLmpki3uNhbGNducrbwQexJSRhMEi0/TIrTRhq@vger.kernel.org, AJvYcCVuUyZ2Csdwba6HITJJywzhp8mRaIM0I1/GjWtmUT5F3mGYYNkUZR0sgvcCGbGPNOuul5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZmyfaIsVAe9MgL/jGYxbisxcszgPowUZMaJeuJZaUkOCKAy7E
	OnaGnrxqPkxTNePxcwtViEEZc+w8LIIL126v7paO131scuLoTUS17nGE
X-Gm-Gg: ASbGncuAaAJIYUCnRLklEX7lOVJ42NSMTUST5EXoYCk1s9QNFSOwMnr1RxaeMBHhZHY
	oHAg2XN+dJHXdJufYyqPUsWMmKBWqoLHoiItY9GCf7TtoMH8inLpamVOpNeibZh/rmpeig3NuiR
	gSFGmkMJNF8Db4NfbIHP0KOBi9TMsiY+qPPCZ6I/bbsWcC+m+5FrLTXWE8Q+BJOkNM8HvVLXdM+
	ktoicMW1mBF/3KCya4OcnGD7I84/6INh6MJ9ZrqnpVFlq+hegjHGxtfyhfxpu7bFIqeMwbRmFTS
	74o9ySdbSyXOIArv9hLyhB2ZZc4cDLliwxDOQgZgx6lBczK2W/xJn6hMZh/daa7SAJ38gi3of4l
	39zkC4YHULw96Au5+HgNcaRU=
X-Google-Smtp-Source: AGHT+IH9bbmZXoZCL3DdXqjKm0pHPxa2Mu4Suew3URwFdHcvaOIJITPqY7cQkl0Y29TNYCkLYn6fng==
X-Received: by 2002:a17:903:ac8:b0:246:ea6a:6ed5 with SMTP id d9443c01a7336-24944b0dd22mr76931095ad.34.1756698186845;
        Sun, 31 Aug 2025 20:43:06 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067de9f1sm88398265ad.151.2025.08.31.20.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 20:43:06 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org,
	olsajiri@gmail.com
Cc: eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	yikai.lin@vivo.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/3] selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
Date: Mon,  1 Sep 2025 11:42:50 +0800
Message-ID: <20250901034252.26121-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901034252.26121-1-dongml2@chinatelecom.cn>
References: <20250901034252.26121-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to get all the kernel function that can be traced sometimes, so we
move the get_syms() and get_addrs() in kprobe_multi_test.c to
trace_helpers.c and rename it to bpf_get_ksyms() and bpf_get_addrs().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 220 +-----------------
 tools/testing/selftests/bpf/trace_helpers.c   | 214 +++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   3 +
 3 files changed, 220 insertions(+), 217 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index e19ef509ebf8..171706e78da8 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -422,220 +422,6 @@ static void test_unique_match(void)
 	kprobe_multi__destroy(skel);
 }
 
-static size_t symbol_hash(long key, void *ctx __maybe_unused)
-{
-	return str_hash((const char *) key);
-}
-
-static bool symbol_equal(long key1, long key2, void *ctx __maybe_unused)
-{
-	return strcmp((const char *) key1, (const char *) key2) == 0;
-}
-
-static bool is_invalid_entry(char *buf, bool kernel)
-{
-	if (kernel && strchr(buf, '['))
-		return true;
-	if (!kernel && !strchr(buf, '['))
-		return true;
-	return false;
-}
-
-static bool skip_entry(char *name)
-{
-	/*
-	 * We attach to almost all kernel functions and some of them
-	 * will cause 'suspicious RCU usage' when fprobe is attached
-	 * to them. Filter out the current culprits - arch_cpu_idle
-	 * default_idle and rcu_* functions.
-	 */
-	if (!strcmp(name, "arch_cpu_idle"))
-		return true;
-	if (!strcmp(name, "default_idle"))
-		return true;
-	if (!strncmp(name, "rcu_", 4))
-		return true;
-	if (!strcmp(name, "bpf_dispatcher_xdp_func"))
-		return true;
-	if (!strncmp(name, "__ftrace_invalid_address__",
-		     sizeof("__ftrace_invalid_address__") - 1))
-		return true;
-	return false;
-}
-
-/* Do comparision by ignoring '.llvm.<hash>' suffixes. */
-static int compare_name(const char *name1, const char *name2)
-{
-	const char *res1, *res2;
-	int len1, len2;
-
-	res1 = strstr(name1, ".llvm.");
-	res2 = strstr(name2, ".llvm.");
-	len1 = res1 ? res1 - name1 : strlen(name1);
-	len2 = res2 ? res2 - name2 : strlen(name2);
-
-	if (len1 == len2)
-		return strncmp(name1, name2, len1);
-	if (len1 < len2)
-		return strncmp(name1, name2, len1) <= 0 ? -1 : 1;
-	return strncmp(name1, name2, len2) >= 0 ? 1 : -1;
-}
-
-static int load_kallsyms_compare(const void *p1, const void *p2)
-{
-	return compare_name(((const struct ksym *)p1)->name, ((const struct ksym *)p2)->name);
-}
-
-static int search_kallsyms_compare(const void *p1, const struct ksym *p2)
-{
-	return compare_name(p1, p2->name);
-}
-
-static int get_syms(char ***symsp, size_t *cntp, bool kernel)
-{
-	size_t cap = 0, cnt = 0;
-	char *name = NULL, *ksym_name, **syms = NULL;
-	struct hashmap *map;
-	struct ksyms *ksyms;
-	struct ksym *ks;
-	char buf[256];
-	FILE *f;
-	int err = 0;
-
-	ksyms = load_kallsyms_custom_local(load_kallsyms_compare);
-	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_custom_local"))
-		return -EINVAL;
-
-	/*
-	 * The available_filter_functions contains many duplicates,
-	 * but other than that all symbols are usable in kprobe multi
-	 * interface.
-	 * Filtering out duplicates by using hashmap__add, which won't
-	 * add existing entry.
-	 */
-
-	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
-		f = fopen("/sys/kernel/tracing/available_filter_functions", "r");
-	else
-		f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
-
-	if (!f)
-		return -EINVAL;
-
-	map = hashmap__new(symbol_hash, symbol_equal, NULL);
-	if (IS_ERR(map)) {
-		err = libbpf_get_error(map);
-		goto error;
-	}
-
-	while (fgets(buf, sizeof(buf), f)) {
-		if (is_invalid_entry(buf, kernel))
-			continue;
-
-		free(name);
-		if (sscanf(buf, "%ms$*[^\n]\n", &name) != 1)
-			continue;
-		if (skip_entry(name))
-			continue;
-
-		ks = search_kallsyms_custom_local(ksyms, name, search_kallsyms_compare);
-		if (!ks) {
-			err = -EINVAL;
-			goto error;
-		}
-
-		ksym_name = ks->name;
-		err = hashmap__add(map, ksym_name, 0);
-		if (err == -EEXIST) {
-			err = 0;
-			continue;
-		}
-		if (err)
-			goto error;
-
-		err = libbpf_ensure_mem((void **) &syms, &cap,
-					sizeof(*syms), cnt + 1);
-		if (err)
-			goto error;
-
-		syms[cnt++] = ksym_name;
-	}
-
-	*symsp = syms;
-	*cntp = cnt;
-
-error:
-	free(name);
-	fclose(f);
-	hashmap__free(map);
-	if (err)
-		free(syms);
-	return err;
-}
-
-static int get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel)
-{
-	unsigned long *addr, *addrs, *tmp_addrs;
-	int err = 0, max_cnt, inc_cnt;
-	char *name = NULL;
-	size_t cnt = 0;
-	char buf[256];
-	FILE *f;
-
-	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
-		f = fopen("/sys/kernel/tracing/available_filter_functions_addrs", "r");
-	else
-		f = fopen("/sys/kernel/debug/tracing/available_filter_functions_addrs", "r");
-
-	if (!f)
-		return -ENOENT;
-
-	/* In my local setup, the number of entries is 50k+ so Let us initially
-	 * allocate space to hold 64k entries. If 64k is not enough, incrementally
-	 * increase 1k each time.
-	 */
-	max_cnt = 65536;
-	inc_cnt = 1024;
-	addrs = malloc(max_cnt * sizeof(long));
-	if (addrs == NULL) {
-		err = -ENOMEM;
-		goto error;
-	}
-
-	while (fgets(buf, sizeof(buf), f)) {
-		if (is_invalid_entry(buf, kernel))
-			continue;
-
-		free(name);
-		if (sscanf(buf, "%p %ms$*[^\n]\n", &addr, &name) != 2)
-			continue;
-		if (skip_entry(name))
-			continue;
-
-		if (cnt == max_cnt) {
-			max_cnt += inc_cnt;
-			tmp_addrs = realloc(addrs, max_cnt);
-			if (!tmp_addrs) {
-				err = -ENOMEM;
-				goto error;
-			}
-			addrs = tmp_addrs;
-		}
-
-		addrs[cnt++] = (unsigned long)addr;
-	}
-
-	*addrsp = addrs;
-	*cntp = cnt;
-
-error:
-	free(name);
-	fclose(f);
-	if (err)
-		free(addrs);
-	return err;
-}
-
 static void do_bench_test(struct kprobe_multi_empty *skel, struct bpf_kprobe_multi_opts *opts)
 {
 	long attach_start_ns, attach_end_ns;
@@ -670,7 +456,7 @@ static void test_kprobe_multi_bench_attach(bool kernel)
 	char **syms = NULL;
 	size_t cnt = 0;
 
-	if (!ASSERT_OK(get_syms(&syms, &cnt, kernel), "get_syms"))
+	if (!ASSERT_OK(bpf_get_ksyms(&syms, &cnt, kernel), "bpf_get_ksyms"))
 		return;
 
 	skel = kprobe_multi_empty__open_and_load();
@@ -696,13 +482,13 @@ static void test_kprobe_multi_bench_attach_addr(bool kernel)
 	size_t cnt = 0;
 	int err;
 
-	err = get_addrs(&addrs, &cnt, kernel);
+	err = bpf_get_addrs(&addrs, &cnt, kernel);
 	if (err == -ENOENT) {
 		test__skip();
 		return;
 	}
 
-	if (!ASSERT_OK(err, "get_addrs"))
+	if (!ASSERT_OK(err, "bpf_get_addrs"))
 		return;
 
 	skel = kprobe_multi_empty__open_and_load();
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 81943c6254e6..d24baf244d1f 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -17,6 +17,7 @@
 #include <linux/limits.h>
 #include <libelf.h>
 #include <gelf.h>
+#include "bpf/hashmap.h"
 #include "bpf/libbpf_internal.h"
 
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
@@ -519,3 +520,216 @@ void read_trace_pipe(void)
 {
 	read_trace_pipe_iter(trace_pipe_cb, NULL, 0);
 }
+
+static size_t symbol_hash(long key, void *ctx __maybe_unused)
+{
+	return str_hash((const char *) key);
+}
+
+static bool symbol_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return strcmp((const char *) key1, (const char *) key2) == 0;
+}
+
+static bool is_invalid_entry(char *buf, bool kernel)
+{
+	if (kernel && strchr(buf, '['))
+		return true;
+	if (!kernel && !strchr(buf, '['))
+		return true;
+	return false;
+}
+
+static bool skip_entry(char *name)
+{
+	/*
+	 * We attach to almost all kernel functions and some of them
+	 * will cause 'suspicious RCU usage' when fprobe is attached
+	 * to them. Filter out the current culprits - arch_cpu_idle
+	 * default_idle and rcu_* functions.
+	 */
+	if (!strcmp(name, "arch_cpu_idle"))
+		return true;
+	if (!strcmp(name, "default_idle"))
+		return true;
+	if (!strncmp(name, "rcu_", 4))
+		return true;
+	if (!strcmp(name, "bpf_dispatcher_xdp_func"))
+		return true;
+	if (!strncmp(name, "__ftrace_invalid_address__",
+		     sizeof("__ftrace_invalid_address__") - 1))
+		return true;
+	return false;
+}
+
+/* Do comparison by ignoring '.llvm.<hash>' suffixes. */
+static int compare_name(const char *name1, const char *name2)
+{
+	const char *res1, *res2;
+	int len1, len2;
+
+	res1 = strstr(name1, ".llvm.");
+	res2 = strstr(name2, ".llvm.");
+	len1 = res1 ? res1 - name1 : strlen(name1);
+	len2 = res2 ? res2 - name2 : strlen(name2);
+
+	if (len1 == len2)
+		return strncmp(name1, name2, len1);
+	if (len1 < len2)
+		return strncmp(name1, name2, len1) <= 0 ? -1 : 1;
+	return strncmp(name1, name2, len2) >= 0 ? 1 : -1;
+}
+
+static int load_kallsyms_compare(const void *p1, const void *p2)
+{
+	return compare_name(((const struct ksym *)p1)->name, ((const struct ksym *)p2)->name);
+}
+
+static int search_kallsyms_compare(const void *p1, const struct ksym *p2)
+{
+	return compare_name(p1, p2->name);
+}
+
+int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
+{
+	size_t cap = 0, cnt = 0;
+	char *name = NULL, *ksym_name, **syms = NULL;
+	struct hashmap *map;
+	struct ksyms *ksyms;
+	struct ksym *ks;
+	char buf[256];
+	FILE *f;
+	int err = 0;
+
+	ksyms = load_kallsyms_custom_local(load_kallsyms_compare);
+	if (!ksyms)
+		return -EINVAL;
+
+	/*
+	 * The available_filter_functions contains many duplicates,
+	 * but other than that all symbols are usable to trace.
+	 * Filtering out duplicates by using hashmap__add, which won't
+	 * add existing entry.
+	 */
+
+	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
+		f = fopen("/sys/kernel/tracing/available_filter_functions", "r");
+	else
+		f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
+
+	if (!f)
+		return -EINVAL;
+
+	map = hashmap__new(symbol_hash, symbol_equal, NULL);
+	if (IS_ERR(map)) {
+		err = libbpf_get_error(map);
+		goto error;
+	}
+
+	while (fgets(buf, sizeof(buf), f)) {
+		if (is_invalid_entry(buf, kernel))
+			continue;
+
+		free(name);
+		if (sscanf(buf, "%ms$*[^\n]\n", &name) != 1)
+			continue;
+		if (skip_entry(name))
+			continue;
+
+		ks = search_kallsyms_custom_local(ksyms, name, search_kallsyms_compare);
+		if (!ks) {
+			err = -EINVAL;
+			goto error;
+		}
+
+		ksym_name = ks->name;
+		err = hashmap__add(map, ksym_name, 0);
+		if (err == -EEXIST) {
+			err = 0;
+			continue;
+		}
+		if (err)
+			goto error;
+
+		err = libbpf_ensure_mem((void **) &syms, &cap,
+					sizeof(*syms), cnt + 1);
+		if (err)
+			goto error;
+
+		syms[cnt++] = ksym_name;
+	}
+
+	*symsp = syms;
+	*cntp = cnt;
+
+error:
+	free(name);
+	fclose(f);
+	hashmap__free(map);
+	if (err)
+		free(syms);
+	return err;
+}
+
+int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel)
+{
+	unsigned long *addr, *addrs, *tmp_addrs;
+	int err = 0, max_cnt, inc_cnt;
+	char *name = NULL;
+	size_t cnt = 0;
+	char buf[256];
+	FILE *f;
+
+	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
+		f = fopen("/sys/kernel/tracing/available_filter_functions_addrs", "r");
+	else
+		f = fopen("/sys/kernel/debug/tracing/available_filter_functions_addrs", "r");
+
+	if (!f)
+		return -ENOENT;
+
+	/* In my local setup, the number of entries is 50k+ so Let us initially
+	 * allocate space to hold 64k entries. If 64k is not enough, incrementally
+	 * increase 1k each time.
+	 */
+	max_cnt = 65536;
+	inc_cnt = 1024;
+	addrs = malloc(max_cnt * sizeof(long));
+	if (addrs == NULL) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	while (fgets(buf, sizeof(buf), f)) {
+		if (is_invalid_entry(buf, kernel))
+			continue;
+
+		free(name);
+		if (sscanf(buf, "%p %ms$*[^\n]\n", &addr, &name) != 2)
+			continue;
+		if (skip_entry(name))
+			continue;
+
+		if (cnt == max_cnt) {
+			max_cnt += inc_cnt;
+			tmp_addrs = realloc(addrs, max_cnt);
+			if (!tmp_addrs) {
+				err = -ENOMEM;
+				goto error;
+			}
+			addrs = tmp_addrs;
+		}
+
+		addrs[cnt++] = (unsigned long)addr;
+	}
+
+	*addrsp = addrs;
+	*cntp = cnt;
+
+error:
+	free(name);
+	fclose(f);
+	if (err)
+		free(addrs);
+	return err;
+}
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 2ce873c9f9aa..9437bdd4afa5 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -41,4 +41,7 @@ ssize_t get_rel_offset(uintptr_t addr);
 
 int read_build_id(const char *path, char *build_id, size_t size);
 
+int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel);
+int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel);
+
 #endif
-- 
2.51.0


