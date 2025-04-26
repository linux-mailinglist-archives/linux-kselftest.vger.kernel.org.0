Return-Path: <linux-kselftest+bounces-31712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B40A9DC05
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 18:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D14C7B551A
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EB425CC54;
	Sat, 26 Apr 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4Itz2zH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5501991CF;
	Sat, 26 Apr 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745683252; cv=none; b=QwuHJutmTiJCabh74CBDkdcbiUs1+sZN61a7bHKNRwohH5WbkElrMOpZpByUkiSNBXdWTDcmvUiM7RFowxQwwP+HTcNY/AwmkVx/QrRPFnnQMS8M3aTM8KkC40fEeDn8lflt6rsqSd+WD4InPh2mk2tUneYf2U2Ng75N2qX1K8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745683252; c=relaxed/simple;
	bh=6wtlZ3cVz3h8HN3xXJXOFuW6FUMXN4oKtvQE5SotFwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Amf18ar87A3sVBWCb8P9nn4OyGiR7+YPm7RRF9z8HSPMqqt4PSLU4zNv32Nd4mfncKjqNnEOtLHCtuSbgSBfwNUDlqFDFPMtuomSbRXSiL9Kf4voscqgtIA1BUhWn9YFv0IKltgnVWtuXt3laG/JAqaGLh4b3L3IJhh4BcfBWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4Itz2zH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso3188813b3a.2;
        Sat, 26 Apr 2025 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745683250; x=1746288050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/detW5q78fUeVymgHMz6DHf9alatBjaEk8q4ObEsdg=;
        b=V4Itz2zH88qMv5KkTnbYjQjrUT36jr7NOp0xDpWTZusPZpNz19qGGtegt4+94o4w8O
         nDnBGg6wCD+bcPQ0xykw790VZKI92ux1IKLFmUMwA1OXAhy2P7pWG/f9LbnYgzxnhFr7
         bXwYUsGS96lBe8FQ+DewVXvgxAcpT5uuHlwHwBGRQJvJ1WFzAV2VBx48B1d6OR7iUewo
         AIG1fpIxnjiQiz9kYAKLQCy88R+1nZpiUYCm59p7Ymq9vmyMWL7E9rEWUhxgNkVOprSH
         89z9THIyf/7WhSeW/PmAz0GUICFtPx2DyvI87F+08L8wrFLbSHcLVoOax0w7fF9quWgA
         gIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745683250; x=1746288050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/detW5q78fUeVymgHMz6DHf9alatBjaEk8q4ObEsdg=;
        b=vclpWBK/5S221NBYrE/3P035Iq0noGlXQAE29G+98gtjUGbGulN9d7NZruY9Rc2REF
         9hkLXc7UuPhNA7/uxgX99K5T1EgjlCGYsUn100NoGc5OtuVxYgy5rKgBNS7tgNWbbtOo
         ekA1ps6wNKoSO7Hi/57TIFc/zOa99cBSVqRS+81k8vKACL9zGvwL6xZA0czAgBCjL2Li
         p6IESLzU+zbGc0YkRIjGwaVBJIkLGtQ3k/eV0OdrefOWYhrJjcj41WZVNKcH4SBZAW+j
         k7dLoe3fVxNtTXhfzXOU5uCz3XhNva5VKnk3YTpnEGdyuMSh+wzRM1ahx6F9D9h4wf1l
         FehQ==
X-Forwarded-Encrypted: i=1; AJvYcCVecIfy6mrKIOGrvORsIKXhpLGmHCoxywrfG1g5GEpTGliCntCVQfoUchon7HuTaVWwLEI=@vger.kernel.org, AJvYcCWczK482uOlxeEk6J6pSKMIsVyAWwCP+yTsrrytzj26cqVej4cJqzo06Dp7UXtksGol/Bwwcc5U@vger.kernel.org, AJvYcCWjPWXSXjpoB0i7ekaMzGBFtcxWF8z3/eqJe4ks3gniMj46RFdXkYmi2Kla7etYpVB6HhCv/VygXn/VIAi2uxBoCooN@vger.kernel.org, AJvYcCX/U/CnqDBBsnH6+E7gRZFIu4pOWqo67qe7S82t+Ld45LH+ernRUTY9df65C97tkr3Ol+UDx+hYDgeCMxjALrfx@vger.kernel.org
X-Gm-Message-State: AOJu0YyXaChIX2/vTT7EaaIVq/fMrJVsMW0BKRVal1AcRTPUrQJ387xx
	f1tHXF8iDHXDRDMKqkGMboI3pIEZfg4i0T8QIHkBJwv1UNjl95j3
X-Gm-Gg: ASbGncvxLC9vGpmRb+Vnk0ZbpMPCvp6xxDvnUU7JNjEcpI1i0zPsk2oUXehXxrvnYB9
	M6ST2UAuUHs8TYgavE+Rk2t6LHdPKKnpf2YxirYbG92cYg4ymyH/McNciVhzZ31XQa5YIOCrDQp
	zoFbDs+Xre6OpjgT5tRSPibjkV+1BkwT/2GbA4IPsIZ4HjRIKCq+pByQz8vjPxtKjJFEbj42NhA
	VXp7xlhWvlt7dLM6sh9shtjogBRyymDhyXhWo2YIx4dgDpyDYWqEoGtvfPaw1U8meS5Ib/2Vbls
	iT5KnTxP67NvaI3uUxqe8dtCY84J6VD+QE7X5H9biLA=
X-Google-Smtp-Source: AGHT+IFsBkXoaPfJogYRS6DLJQLaIJ0SeexlKs+HGVduqWYpjSAZjFAgxsW3BQmfCzS1QUqe8Ims2A==
X-Received: by 2002:a05:6a00:2445:b0:73e:1566:5960 with SMTP id d2e1a72fcca58-73ff7377393mr4741493b3a.19.1745683249690;
        Sat, 26 Apr 2025 09:00:49 -0700 (PDT)
Received: from ubuntu2404.. ([122.231.145.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25941cc1sm5174760b3a.60.2025.04.26.09.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 09:00:49 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev,
	mannkafai@gmail.com
Subject: [PATCH bpf-next 1/4] bpf: Allow get_func_[arg|arg_cnt] helpers in raw tracepoint programs
Date: Sun, 27 Apr 2025 00:00:24 +0800
Message-ID: <20250426160027.177173-2-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250426160027.177173-1-mannkafai@gmail.com>
References: <20250426160027.177173-1-mannkafai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to use get_func_[arg|arg_cnt] helpers in raw_tp/tp_btf
programs.

We can use get_func_[arg|ret|arg_cnt] helpers in fentry/fexit/fmod_ret
programs currently. If we try to use get_func_[arg|arg_cnt] helpers in
raw_tp/tp_btf programs, verifier will fail to load the program with:

; __u64 cnt = bpf_get_func_arg_cnt(ctx);
3: (85) call bpf_get_func_arg_cnt#185
unknown func bpf_get_func_arg_cnt#185

Adding get_func_[arg|arg_cnt] helpers in raw_tp_prog_func_proto and
tracing_prog_func_proto for raw tracepoint.

Adding 1 arg on ctx of raw tracepoint program and make it stores number of
arguments on ctx-8, so it's easy to verify argument index and find
argument's position.

Signed-off-by: KaFai Wan <mannkafai@gmail.com>
---
 kernel/trace/bpf_trace.c | 17 ++++++++++++++---
 net/bpf/test_run.c       | 13 +++++--------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 52c432a44aeb..eb4c56013493 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1892,6 +1892,10 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_stackid_proto_raw_tp;
 	case BPF_FUNC_get_stack:
 		return &bpf_get_stack_proto_raw_tp;
+	case BPF_FUNC_get_func_arg:
+		return &bpf_get_func_arg_proto;
+	case BPF_FUNC_get_func_arg_cnt:
+		return &bpf_get_func_arg_cnt_proto;
 	case BPF_FUNC_get_attach_cookie:
 		return &bpf_get_attach_cookie_proto_tracing;
 	default:
@@ -1950,10 +1954,16 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_d_path:
 		return &bpf_d_path_proto;
 	case BPF_FUNC_get_func_arg:
+		if (prog->type == BPF_PROG_TYPE_TRACING &&
+		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
+			return &bpf_get_func_arg_proto;
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
 	case BPF_FUNC_get_func_ret:
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
 	case BPF_FUNC_get_func_arg_cnt:
+		if (prog->type == BPF_PROG_TYPE_TRACING &&
+		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
+			return &bpf_get_func_arg_cnt_proto;
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
 	case BPF_FUNC_get_attach_cookie:
 		if (prog->type == BPF_PROG_TYPE_TRACING &&
@@ -2312,7 +2322,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 #define REPEAT(X, FN, DL, ...)		REPEAT_##X(FN, DL, __VA_ARGS__)
 
 #define SARG(X)		u64 arg##X
-#define COPY(X)		args[X] = arg##X
+#define COPY(X)		args[X + 1] = arg##X
 
 #define __DL_COM	(,)
 #define __DL_SEM	(;)
@@ -2323,9 +2333,10 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	void bpf_trace_run##x(struct bpf_raw_tp_link *link,		\
 			      REPEAT(x, SARG, __DL_COM, __SEQ_0_11))	\
 	{								\
-		u64 args[x];						\
+		u64 args[x + 1];					\
+		args[0] = x;						\
 		REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);			\
-		__bpf_trace_run(link, args);				\
+		__bpf_trace_run(link, args + 1);			\
 	}								\
 	EXPORT_SYMBOL_GPL(bpf_trace_run##x)
 BPF_TRACE_DEFN_x(1);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index aaf13a7d58ed..8cb285187270 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -760,6 +760,7 @@ int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
 	void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
 	__u32 ctx_size_in = kattr->test.ctx_size_in;
 	struct bpf_raw_tp_test_run_info info;
+	u64 args[MAX_BPF_FUNC_ARGS + 1] = {};
 	int cpu = kattr->test.cpu, err = 0;
 	int current_cpu;
 
@@ -776,14 +777,11 @@ int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
 	if ((kattr->test.flags & BPF_F_TEST_RUN_ON_CPU) == 0 && cpu != 0)
 		return -EINVAL;
 
-	if (ctx_size_in) {
-		info.ctx = memdup_user(ctx_in, ctx_size_in);
-		if (IS_ERR(info.ctx))
-			return PTR_ERR(info.ctx);
-	} else {
-		info.ctx = NULL;
-	}
+	if (ctx_size_in && copy_from_user(args + 1, ctx_in, ctx_size_in))
+		return -EFAULT;
 
+	args[0] = ctx_size_in / sizeof(u64);
+	info.ctx = args + 1;
 	info.prog = prog;
 
 	current_cpu = get_cpu();
@@ -807,7 +805,6 @@ int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
 	    copy_to_user(&uattr->test.retval, &info.retval, sizeof(u32)))
 		err = -EFAULT;
 
-	kfree(info.ctx);
 	return err;
 }
 
-- 
2.43.0


