Return-Path: <linux-kselftest+bounces-34197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823A3ACBF53
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 06:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625833A4D5B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 04:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B941F5823;
	Tue,  3 Jun 2025 04:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkj9PHgZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673141F3BBB
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 04:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748926110; cv=none; b=JaPFgvBCA9UBDpVopDEnNFFLtaznL7loVuDv6OmatVTn4BiMbaEZIB+wzMFQv/hYcfE6+donLZpV7MCEQVTkPI2HT2f5nKEoAuQKsKGxnuct+4G0BZN9j2aX2i172fPu+cXbP8NztP75i4nLRg/AO9darBWJR6nlT5b10BjPWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748926110; c=relaxed/simple;
	bh=BPfcwo6iM0YLjsbV/CSz7wlSKTfOmMZdS9BbV7QcgMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rBE/RMO4FtBxvU9CH2YTwKu3SsJa7D9e4yGTeww/qneDnZEPQsXs+Jtly8b9IEb9TXThcokM2nixpFZq4FNUHhb0BFXxd+FPEZg6R1laa1W61+5VwUdVvZWNBt8q8bbD18BHIGz15++A4Tm6JF45OAixZAuyFdBfcqMcr3k1y5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkj9PHgZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-312eaf676b3so330231a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 21:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748926107; x=1749530907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLw45I9yrMKnI+FxaPXVhq/2W0gzoUGdgmBYoc41yS8=;
        b=wkj9PHgZWfeNpn9Bz1kPrSEBGUppDD/ISjfbkIpbn3N7KC81T8sYaODsZNjoVz7yBc
         afz/7bWLyljMqPcMkCAXEoVPJEeNUrfTMVMeuISKsn/6KsjTcKWMWdo1xEGUrhhL6oHE
         xZ3QDvF6opJ17BtimD8MxyPDMAeXjOnrBrxJ/GJ7+UwPhLVun25sSQWy6rbAcCVIBgQ/
         HqcSd7RMgUjuYzVj0d25Aw7UHyLw0LUxRVaDJX7mqfI1A2c66ugI5ZYqG05zfMQzoZnl
         OGDd5BCPmNq1RVFphroKBBb+fWw08Bs1+dEJMYZBUywRw3faRJ5cLaS47VspkJCyu7FI
         UFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748926107; x=1749530907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLw45I9yrMKnI+FxaPXVhq/2W0gzoUGdgmBYoc41yS8=;
        b=ct4zLoINQ/c4Cf/26lvbxUwg0YA7GlckTKxVsLAlsShVKarqWXTwFeE9zcH7zs+/DD
         kUZjUxJx5y5ULNqaMVLnsE+6rvz1Fvs8Bk1bTqcaELMdaE1bPybH54nkimd/JT2fFHGQ
         9At+6yIy1JbdyGlKtTxzt2n6TZP79QZfgXSBmFmhfk/S/KDQaJnahhMwM5Cotw3hIB5d
         QDjh3LJac07Yf/magW9Ym1FIeVsFm0f8td+ulbcYzZz2KSwklm+l3xl7aqDq1QYPvG/r
         PNTFqfi+TdXmLh6zYsZg6Gi/+w2YrVBx8eloXvhq+uXwiRGfuDdbGiXQH0zomhF/4EEY
         BMOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZbnyJ3zufFcL0MZg3pQuzvLUnEd7HMMLNW0oyfsfNOABe5tMoDWF9yQay6mByOBWYOUHS7pnoipoj+GhbF7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLpLlWiMSFofdx/JbpWLgoVTh63+4r3NIB12Z1tLPg5qKRte+
	nc7lwCtICJxI7QXxSPKUQbWgAcNtDDwdcBTA6FKM3bmCaSZfmnfmwbzOFsDjWwqNuS22F/gqsNL
	KTMHKkQu8Vt5S2E7JGPhggQ==
X-Google-Smtp-Source: AGHT+IFnfGAUx2D0cf7iKTQVmpBlHYmaqb7e7oimRJuGD2RACVW8VRe6L81j78ZHzX+NQycr9MMOUvMu8P4vJOQI
X-Received: from pjbss4.prod.google.com ([2002:a17:90b:2ec4:b0:311:2058:21e7])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a8d:b0:311:f05b:869a with SMTP id 98e67ed59e1d1-312503580eemr20217276a91.8.1748926106683;
 Mon, 02 Jun 2025 21:48:26 -0700 (PDT)
Date: Mon,  2 Jun 2025 21:48:13 -0700
In-Reply-To: <20250603044813.88265-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250603044813.88265-1-blakejones@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250603044813.88265-2-blakejones@google.com>
Subject: [PATCH v2 2/2] Tests for the ".emit_strings" functionality in the BTF dumper.
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
 .../selftests/bpf/prog_tests/btf_dump.c       | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index c0a776feec23..2fde118d04c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -879,6 +879,110 @@ static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
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
+	} else {
+		if (!ASSERT_EQ(ret, -E2BIG, "failed to return -E2BIG"))
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
+	/* Should get printed properly even though there's no NUL. */
+	char food[4] = { 'f', 'o', 'o', 'd' };
+
+	btf_dump_one_string(ctx, food, 4, "\"food\"");
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
@@ -970,6 +1074,8 @@ void test_btf_dump() {
 		test_btf_dump_struct_data(btf, d, str);
 	if (test__start_subtest("btf_dump: var_data"))
 		test_btf_dump_var_data(btf, d, str);
+	if (test__start_subtest("btf_dump: string_data"))
+		test_btf_dump_string_data();
 	btf_dump__free(d);
 	btf__free(btf);
 
-- 
2.49.0.1204.g71687c7c1d-goog


