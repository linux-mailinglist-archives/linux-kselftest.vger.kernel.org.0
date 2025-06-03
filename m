Return-Path: <linux-kselftest+bounces-34246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12A5ACCE48
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 22:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FB618891F6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810C8223DE5;
	Tue,  3 Jun 2025 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4boJJ0sO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4F223301
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983031; cv=none; b=j+bsvO/Nx9cIDESK1/HOpkGnVbL9RkwGg1ucac8DNWSXOYpFc8M6bPWp7KY8YVkvS6OSvJvE2fgPY0GwavIAOSXNqAJoDDA6jv3+Dam8ZoQWDA8+X77x+yGSvTWjFqXKkJJU9Ieq5SefpfxLtoGbWTItn3r2iGhFXPrZ1D6PNkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983031; c=relaxed/simple;
	bh=gqSJGxI77ova7wU9IMyEeHN+g1roA4YnQitS9pfMhjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hYXo9YkZSQsMi1ElXtxNpktSUmj01Z4RplP2VIOJEZeMLZy3vQAZvH1+tw08jXvluR0K4m6flc0/g+M0UhrWHbaM8SjPPY68l8o4MAcuBXaO0XsLh86KCNcrLA7u+pE1LRxFvhSmKjpQaBa9EVCaoIonudFqOc3A0+/Fcsko68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4boJJ0sO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b0f807421c9so3781435a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748983029; x=1749587829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9CErTHxr78ea0SPK/YFJebxnqtvqxlB3jDGvOS7Th0c=;
        b=4boJJ0sOVqRYwqB4QOXe9Z0hrtHijUZxDqeidlO6Az5oXVB6+QKTWwiTX8zMlBNc67
         uGo103i+7uXrkPzYoiAwktc8dRZgQXH5PXi3CpLkpeTKqK5aDFYbj1m0gmoI0HXgIPg4
         8JcsxEQAk731NWjfb7811tNgGjmYnWJvgPGgxa7EeEsblglgp1UpYBNSb16FVp9QVdc+
         frhLx4eFhTM5P5bVi4CDsJkGQgJZHpQB3qrHyKeOmqlptIpmpPRtJpWW0oaVWw5X5/Kk
         Q5KQSbhWT3GE/Tr0ugyt0gGrLmw/c4W7F/+eY0OUU/3gDpQ7fZAD61mCPtGOdmKysL5P
         tj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983029; x=1749587829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CErTHxr78ea0SPK/YFJebxnqtvqxlB3jDGvOS7Th0c=;
        b=a8GE2A4nOZIVLjXRLxN12fbd0H6CZY+xPSUsjCIDnawLq5nD9fX+QefYTJdCQdK2b1
         +StgNbIXN1VqTMMbCqA4owgZQGWOaebcvM8NRu0kGnb7e0MyoUgNDQn/wnQB3anKPD7b
         EgH5qjvOCpXs04swYgFFPf2As6xdxsXt1O4peDUX+QnJab6hdGxG0oS8QS+UtP971GoF
         FjsY5svE0bZDYzSgdOyob/pGGZ7PkR7a7GADMyXYTmSMaXqtX6cRVXgoxuJ9m9Z4R2Hx
         8gXT+ahJU5+GJrnlcSn5Dy9xR1pPget2lt/hh8G9E7NDZSN5z+Foy8oeIZ58cEpTvj2P
         dU0w==
X-Forwarded-Encrypted: i=1; AJvYcCU7uUXnAJfGv8Qkr93/LQ47v9/OfVPytZRxNsBkoGH5lIMHUWanh6qp3cIUMbQNT5X1gzWsgnHj0MnAJ8Oz9SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO1jq7SYFn+oO/lN8LLoulfz7tTkPfWzOSI6XFjR2PpN1D5Rj7
	jDEKpxcM14RH7h5+bteLAbjM8ztpDf9ALIAi4xJu77bD1rp6BJWO2DE2Upuhi2fd5p0lHOGbw3n
	2XGjAPy6rPlCHS4GZnnPUew==
X-Google-Smtp-Source: AGHT+IHr9HxQ/k8ZqblCIZvmJnegYT+R4B5ll7Jl1wsb6v5KQTF03QA9q0We0QuRqUYtpS1qSTmmjc9Fn4szQ8Br
X-Received: from pjbnw10.prod.google.com ([2002:a17:90b:254a:b0:311:ff32:a85d])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2641:b0:311:9c1f:8522 with SMTP id 98e67ed59e1d1-3130ccbf5a0mr764462a91.10.1748983029161;
 Tue, 03 Jun 2025 13:37:09 -0700 (PDT)
Date: Tue,  3 Jun 2025 13:37:01 -0700
In-Reply-To: <20250603203701.520541-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250603203701.520541-1-blakejones@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250603203701.520541-2-blakejones@google.com>
Subject: [PATCH v3 2/2] Tests for the ".emit_strings" functionality in the BTF dumper.
From: Blake Jones <blakejones@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

When this mode is turned on, "emit_zeroes" and "compact" have no effect,
and embedded NUL characters always terminate printing of an array.

Signed-off-by: Blake Jones <blakejones@google.com>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index c0a776feec23..82903585c870 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -879,6 +879,122 @@ static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
 			  "static int bpf_cgrp_storage_busy = (int)2", 2);
 }
 
+struct btf_dump_string_ctx {
+	struct btf *btf;
+	struct btf_dump *d;
+	char *str;
+	struct btf_dump_type_data_opts *opts;
+	int array_id;
+};
+
+static int btf_dump_one_string(struct btf_dump_string_ctx *ctx,
+			       char *ptr, size_t ptr_sz,
+			       const char *expected_val)
+{
+	size_t type_sz;
+	int ret;
+
+	ctx->str[0] = '\0';
+	type_sz = btf__resolve_size(ctx->btf, ctx->array_id);
+	ret = btf_dump__dump_type_data(ctx->d, ctx->array_id, ptr, ptr_sz, ctx->opts);
+	if (type_sz <= ptr_sz) {
+		if (!ASSERT_EQ(ret, type_sz, "failed/unexpected type_sz"))
+			return -EINVAL;
+	}
+	if (!ASSERT_STREQ(ctx->str, expected_val, "ensure expected/actual match"))
+		return -EFAULT;
+	return 0;
+}
+
+static void btf_dump_strings(struct btf_dump_string_ctx *ctx)
+{
+	struct btf_dump_type_data_opts *opts = ctx->opts;
+
+	opts->emit_strings = true;
+
+	opts->compact = true;
+	opts->emit_zeroes = false;
+
+	opts->skip_names = false;
+	btf_dump_one_string(ctx, "foo", 4, "(char[4])\"foo\"");
+
+	opts->skip_names = true;
+	btf_dump_one_string(ctx, "foo", 4, "\"foo\"");
+
+	/* This should have no effect. */
+	opts->emit_zeroes = false;
+	btf_dump_one_string(ctx, "foo", 4, "\"foo\"");
+
+	/* This should have no effect. */
+	opts->compact = false;
+	btf_dump_one_string(ctx, "foo", 4, "\"foo\"");
+
+	/* Non-printable characters come out as hex. */
+	btf_dump_one_string(ctx, "fo\xff", 4, "\"fo\\xff\"");
+	btf_dump_one_string(ctx, "fo\x7", 4, "\"fo\\x07\"");
+
+	/*
+	 * Strings that are too long for the specified type ("char[4]")
+	 * should fall back to the current behavior.
+	 */
+	opts->compact = true;
+	btf_dump_one_string(ctx, "abcde", 6, "['a','b','c','d',]");
+
+	/*
+	 * Strings that are too short for the specified type ("char[4]")
+	 * should work normally.
+	 */
+	btf_dump_one_string(ctx, "ab", 3, "\"ab\"");
+
+	/* Non-NUL-terminated arrays don't get printed as strings. */
+	char food[4] = { 'f', 'o', 'o', 'd' };
+	char bye[3] = { 'b', 'y', 'e' };
+
+	btf_dump_one_string(ctx, food, 4, "['f','o','o','d',]");
+	btf_dump_one_string(ctx, bye, 3, "['b','y','e',]");
+
+	/* The embedded NUL should terminate the string. */
+	char embed[4] = { 'f', 'o', '\0', 'd' };
+
+	btf_dump_one_string(ctx, embed, 4, "\"fo\"");
+}
+
+static void test_btf_dump_string_data(void)
+{
+	struct test_ctx t = {};
+	char str[STRSIZE];
+	struct btf_dump *d;
+	DECLARE_LIBBPF_OPTS(btf_dump_type_data_opts, opts);
+	struct btf_dump_string_ctx ctx;
+	int char_id, int_id, array_id;
+
+	if (test_ctx__init(&t))
+		return;
+
+	d = btf_dump__new(t.btf, btf_dump_snprintf, str, NULL);
+	if (!ASSERT_OK_PTR(d, "could not create BTF dump"))
+		return;
+
+	/* Generate BTF for a four-element char array. */
+	char_id = btf__add_int(t.btf, "char", 1, BTF_INT_CHAR);
+	ASSERT_EQ(char_id, 1, "char_id");
+	int_id = btf__add_int(t.btf, "int", 4, BTF_INT_SIGNED);
+	ASSERT_EQ(int_id, 2, "int_id");
+	array_id = btf__add_array(t.btf, int_id, char_id, 4);
+	ASSERT_EQ(array_id, 3, "array_id");
+
+	ctx.btf = t.btf;
+	ctx.d = d;
+	ctx.str = str;
+	ctx.opts = &opts;
+	ctx.array_id = array_id;
+
+	btf_dump_strings(&ctx);
+
+	btf_dump__free(d);
+	test_ctx__free(&t);
+}
+
 static void test_btf_datasec(struct btf *btf, struct btf_dump *d, char *str,
 			     const char *name, const char *expected_val,
 			     void *data, size_t data_sz)
@@ -970,6 +1086,8 @@ void test_btf_dump() {
 		test_btf_dump_struct_data(btf, d, str);
 	if (test__start_subtest("btf_dump: var_data"))
 		test_btf_dump_var_data(btf, d, str);
+	if (test__start_subtest("btf_dump: string_data"))
+		test_btf_dump_string_data();
 	btf_dump__free(d);
 	btf__free(btf);
 
-- 
2.49.0.1204.g71687c7c1d-goog


