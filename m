Return-Path: <linux-kselftest+bounces-40722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D98DB42F5F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 04:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8718C7B182D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 02:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87B11F0995;
	Thu,  4 Sep 2025 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg1Iy90o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC08B1DC9B3;
	Thu,  4 Sep 2025 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951829; cv=none; b=FkaYJcGGTd0aEBXBO00FJKGb+1cny/meW9C7XhhIPLALc2DeQKKZ0gutVV1NYuvniNv7zWdYSd3moAVd3EaeiZgUhSdPSotwBhXhKODYo/AnIVSQJUG9MGZlDIK05biDMgZVcCTdb7NUKTbGhPs3BsE6qrqQv7iKANK5UwWk3d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951829; c=relaxed/simple;
	bh=pAODhT+ecJC9cibKZmRv6cU8nfIomZaYnIh6M4jNvQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5AGcAuC5/8CWmFHS+IJMT9M6lmdMBcMBJF83by8/iH584T52/3r+FvN9kPwlPNgB6PpZuMQ2feFRKV5pXdnnMemeyvRjcEhDRBMJWA8N/mi5+TxEwpomDErjV/p0jecMmNYy/8WuCnFX+Klp8e8I8/68lVFl2D0HTjEdpMjxNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg1Iy90o; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so579809a91.2;
        Wed, 03 Sep 2025 19:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756951827; x=1757556627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOykknP1D54GaW0E6s7VCBa0oHwJ3M5XoPoV84Se0Gc=;
        b=Tg1Iy90oBqDQEeV0olgmNgd3Q+lOtRBeBYiKLdsDqs3eAyfIYaLwS2AE8RUsx4B3wB
         BGWZxc+MM51IYn3jVTIeLg0sCVNz1W17RF3u0GZkh1YzvSchCU7YATdHc8klg0EgRHcs
         Jsd/Ga7gbXn8cRc0LruxLIDBguq8fiDhE7ZncRAd90iq01HxLOSjz/5O+QkxkHM1JBbF
         WL+jQmGCDXA/hAqWEXn5o0jJeAZxrsqu641yhO3hy/NtV7WEj5BtdawVOFGo5kWoGZjd
         fE88X786eg5yz+nrU7KHJuzgQalgzv7FNZoyvHOS868u3jZ7TS5SajN5zmRFlP14Sb59
         Wr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756951827; x=1757556627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOykknP1D54GaW0E6s7VCBa0oHwJ3M5XoPoV84Se0Gc=;
        b=EWNUQDLVDCgTwre6dd98QscQNP1Xf14oCogTpJRga716Z0MaH3c07/AubGhyHh4tcn
         Z5xeSinXXgMvJY5VPBxEtW6MC427rN9x/G3yfDyODNVaTu+TPHfLhFJt5k00loBJGyRy
         Ocf26jkGJdPVhzaHngFdQFNlgUtJAoUIG90sCZ2bnVFTDbdAycuQ68EtQmLBIAgSsSnR
         NrCVPhWW5P3Aojx5iQJNt9ntdIopiq8t+TatEwDHE2D6XJO8YRU+Ew/L89oLeefORZXp
         X2BatuVbAJAe8XAR4j8fLTgywjwFE/jSzsH95XHHWo/6YmiA6BrgKttOm8hx+E6e0dPh
         fyMw==
X-Forwarded-Encrypted: i=1; AJvYcCUACQKxBi5vT/b2hMbTtLp0PpVtjOR2EtvyY5k33LqADTRlMl0kXJe5quueS4OJlawcwJU=@vger.kernel.org, AJvYcCX6Z8d+rhR6n7k6HEmQ0JHdo3FjgZajc+xX7AunOwU8qHylS2kj3NbhHSdvJaoT57cvHLpSciVzRHaL9jc8QF7q@vger.kernel.org, AJvYcCXJSP0xe/XtgHp34+lTxDr0UOpbdgYu1B2TSja+/DcPe3WQBojBFdbHdMQdhEm1wZNWl+Tf802NRgq1/tG1@vger.kernel.org
X-Gm-Message-State: AOJu0YxgHVVKEHl5EKg60NKSZDjtIS99mik6W4XGytUVrs0nELX9LgLi
	LDQaRyaaodl1JSXFN0T7kGt9/xh8RSMBCSKRzi6lNQll4UT/2/M9CdTk
X-Gm-Gg: ASbGncsoFvM5x9GtLInY/PZZFzbLFAgnuOw/j0WFsbLPMNUy5XToKyHtwpXwDfa+Mlq
	IASMsR/cpgdvcNJ+M2kz81YgiNuOf2mGPimHFrAUST/SeUZ+ENbPxtV6S5CtxnR1++MWUf2MPeF
	sB5PdKLZvlOi83xdFaVvzlDaMY8StCFTDqqtP/MOssYMEpmsiZDbB1f0bG02IFzsZiwExlfEdfY
	wymFeq7I4XUO3bdPQZwM6DlI8wYZXn/jyqRdWHA48cqwGup955YFQLsBMycEME0s8jHDyud9kSd
	P919Pjol/WpvjbIqhsTn2DRM8iyQ+fkEq/yJPEk3S8ii9StFaWNzwBBe/hzBiVco7A9i2MF9S87
	7hWysd+zzex2vE9uvEBZOt2GIbFwdUaGr3w==
X-Google-Smtp-Source: AGHT+IHRwae27gUkEvOvxN2/yIb4/zL498F4KnHSNIKpE5gAsKH7y93ACRjPwlEPzVunzfquCruBRg==
X-Received: by 2002:a17:90b:384d:b0:327:50b2:8007 with SMTP id 98e67ed59e1d1-328156f75f6mr21540280a91.32.1756951826660;
        Wed, 03 Sep 2025 19:10:26 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727822817asm5143014b3a.98.2025.09.03.19.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:10:26 -0700 (PDT)
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
Subject: [PATCH RESEND bpf-next v3 1/3] selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
Date: Thu,  4 Sep 2025 10:10:09 +0800
Message-ID: <20250904021011.14069-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904021011.14069-1-dongml2@chinatelecom.cn>
References: <20250904021011.14069-1-dongml2@chinatelecom.cn>
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
index f377bea0b82d..171706e78da8 100644
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
-/* Do comparison by ignoring '.llvm.<hash>' suffixes. */
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


