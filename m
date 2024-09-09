Return-Path: <linux-kselftest+bounces-17524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BBD971B3C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 15:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615AA1C23128
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEB41B9B5B;
	Mon,  9 Sep 2024 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNqEHDzr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D51B81C7;
	Mon,  9 Sep 2024 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889158; cv=none; b=HQi5S74qNlhDlpjl95n8m8hlAANx9RF5J7gDkk23R5uO5g03C5F70W5Szy4CK3SaRFI54o4DgNUc747/rAU7PKuGQypRfert6SjBdGvhnmxA07OrXrz4VFJpBnFJdi5aHtXhOF6SRRfUYYIV+9YUiS9llZsdadwm6Gz69lEwdug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889158; c=relaxed/simple;
	bh=P+txpUs+etwM7T1Fu5+oQtVqHtHb6MUAtCqODZcuq0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kPFRuIEtIGloUKFbwtR9ZM6Zdn4+XS7XCYwy9kKENQcaDePaeGYAWb66dQ8Itcl+cixeZFoVqFYk0vfvrCqp410inBbroXI5xD/anWhDo8f9HFe7Yb6vAS06jcyjIsHSn7lytJgicayi6T4+r/G2BbX0F/i535x998dkmdDpu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNqEHDzr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so359845166b.2;
        Mon, 09 Sep 2024 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725889155; x=1726493955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bUR1CdDBpg41gmQu5vompAiQxqeBHLu70Tv+AY+j3eo=;
        b=cNqEHDzrmBRGAaXclLfgeVjILSmeQJxQ2YpM73dWIArZJqK6Pe4MEyElRTSmSZszf/
         DLMlVMfz8M+XpCgIis9RuFm6dPVmzpRF3EYT3hUOzJPp3r8P9x6lmGk9FJMQHjAiRyHc
         il1agYXxoawjopdoKUOUh5c+bAuSaWS8D3sOyXYpdnV6fYhG7Os2NmlbUEk/80RkCkJj
         JMQfn38GiH+UG8GYSwwGjSRYkoMm/38ZpvpbUJzxDTy2eEng53TRLiJ7Ld4LO1ZbgC+6
         rEF4j1Gm8x/EN9bU/NVLibeEPaunOaoJUNR83EMTza0ZG2QJO6mdzmZRAnUt2WH9/5by
         ODWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889155; x=1726493955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUR1CdDBpg41gmQu5vompAiQxqeBHLu70Tv+AY+j3eo=;
        b=PZwpCtAzZfybnkh4JAXNC4Sv23LNKIpNyHkTWuURVUGJYm8P1Rm6FgIQPSRB2xC2/A
         0R+NlIYmEiXIr02HGCikslhq35WKcjvHA3KfTfZMkxBYG63W+WrGzdBQxb4eub5UmGbw
         2MqyxzaDNhbn/uIV/p0NxOO+UBxaoQbgmUrZATEZUOZ5SBdCQdNZmgLwkIU78E6mXS5q
         PhCKFIxYQPLh5LolHerbKfM2bleQs3DI+uDhxXz2ttru+jflZZh4bGC0dGkyiNUA1Vzl
         ZM7oireKOVtR26ASo9hjPGUjGzFrhg7vUFFdTuZjVZ/1ScJe1e0sCBWBppdphftq2G7i
         WDEg==
X-Forwarded-Encrypted: i=1; AJvYcCW4td0t/ZJFXP4mDxkvSc0xzMejNc96uvS++XCOI3LMFnE7pzTGBTvuuqrnQRikLVS4ghYc+/hjfO1QsWU9LMc+@vger.kernel.org, AJvYcCWL46Ft9qD23cfyYUNiCpKdEpPJlVWpbLs8ZXYWO8KP9SDkyllr7z1Cgs2c+ojiqqaRecs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3hON8oM19rSXrCJYgname/r+mOfga56Yld3soqd3c467WDts0
	lZYGmPxx5iEkt8xIQgTBjEHkKPA5Hu6F8wBBCXLVuNOrU6VGQJ3r
X-Google-Smtp-Source: AGHT+IGTigvRhr57x5xBTWV0MZ/j6Z6060Vjm/787QJdKy1RuP5wEWW5FuN/+riZL8NG6gWKlOy0zQ==
X-Received: by 2002:a17:907:706:b0:a72:69e8:f039 with SMTP id a640c23a62f3a-a8a885bfd71mr1146385866b.12.1725889154347;
        Mon, 09 Sep 2024 06:39:14 -0700 (PDT)
Received: from localhost (19.tor-exit.nothingtohide.nl. [192.42.116.216])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2595119bsm343955766b.61.2024.09.09.06.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:39:14 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxim Mikityanskiy <maxim@isovalent.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrei Matei <andreimatei1@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf] bpf: Fix error message on kfunc arg type mismatch
Date: Mon,  9 Sep 2024 16:39:09 +0300
Message-ID: <20240909133909.1315460-1-maxim@isovalent.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "arg#%d expected pointer to ctx, but got %s" error is printed, both
template parts actually point to the type of the argument, therefore, it
will also say "but got PTR", regardless of what was the actual register
type.

Fix the message to print the register type in the second part of the
template, change the existing test to adapt to the new format, and add a
new test to test the case when arg is a pointer to context, but reg is a
scalar.

Fixes: 00b85860feb8 ("bpf: Rewrite kfunc argument handling")
Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 kernel/bpf/verifier.c                               | 3 ++-
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c | 1 +
 tools/testing/selftests/bpf/progs/kfunc_call_fail.c | 7 +++++++
 tools/testing/selftests/bpf/verifier/calls.c        | 2 +-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d8520095ca03..8b9f0a2981d4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11948,7 +11948,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		switch (kf_arg_type) {
 		case KF_ARG_PTR_TO_CTX:
 			if (reg->type != PTR_TO_CTX) {
-				verbose(env, "arg#%d expected pointer to ctx, but got %s\n", i, btf_type_str(t));
+				verbose(env, "arg#%d expected pointer to ctx, but got %s\n",
+					i, reg_type_str(env, reg->type));
 				return -EINVAL;
 			}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index 5b743212292f..f79c8e53cb3e 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -68,6 +68,7 @@ static struct kfunc_test_params kfunc_tests[] = {
 	TC_FAIL(kfunc_call_test_get_mem_fail_oob, 0, "min value is outside of the allowed memory range"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_not_const, 0, "is not a const"),
 	TC_FAIL(kfunc_call_test_mem_acquire_fail, 0, "acquire kernel function does not return PTR_TO_BTF_ID"),
+	TC_FAIL(kfunc_call_test_pointer_arg_type_mismatch, 0, "arg#0 expected pointer to ctx, but got scalar"),
 
 	/* success cases */
 	TC_TEST(kfunc_call_test1, 12),
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
index 4b0b7b79cdfb..08fae306539c 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
@@ -150,4 +150,11 @@ int kfunc_call_test_mem_acquire_fail(struct __sk_buff *skb)
 	return ret;
 }
 
+SEC("?tc")
+int kfunc_call_test_pointer_arg_type_mismatch(struct __sk_buff *skb)
+{
+	bpf_kfunc_call_test_pass_ctx((void *)10);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index d0cdd156cd55..7afc2619ab14 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -76,7 +76,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "arg#0 expected pointer to ctx, but got PTR",
+	.errstr = "arg#0 expected pointer to ctx, but got fp",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_pass_ctx", 2 },
 	},
-- 
2.46.0


