Return-Path: <linux-kselftest+bounces-25166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCBEA1C236
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 09:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7AA7A14D9
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE76207E10;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9PlLrUp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC86206F21;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737793828; cv=none; b=C71S1W3oEKWlssVxgjlNd7DRzUiUqhDJO+tKFdkUChpjCUur5SkFVCDOiMgy88cHZfIKjWqm0ZknxKjETv/KWPOQvVRqszEk9qvAruEE9rVunDbGzfiXwzAjtmZKNYgLvsd2hlul334tKtkR+II5r+ohyFCOY5wRbou1sjPmZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737793828; c=relaxed/simple;
	bh=PyRhaQiSnZLjeNlZTzgwUCTGU9Zv+fo1gZ0pY6cwY5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQ4AeGC4mt40v0KmGe/Zjlk4R/vxrzLO+s+DoDalgA/GOFMZ2TZ5y0NEH0KRJrIboz0Av3dxm2ZTmU/AA99zT7qEGxd9witxHWl3vs6Lp4xXXDkYJnDKXI6RO4zupa0Ls0H2OkrPT0zpNNMtEuxKf6U+Xo0dap1PjJYMKjHrWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9PlLrUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28110C4CEEB;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737793828;
	bh=PyRhaQiSnZLjeNlZTzgwUCTGU9Zv+fo1gZ0pY6cwY5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E9PlLrUpOgzuaiemYFGgsHCq71K44WdedOABpmUvE0T2oaXJjYZQ7kqs3Hqeoo91Y
	 egXzmza/s0NjuoBNGzwqjtZf8hVTYqz+b0+1K7iCCcU/uG7gIbwN2slNIAqc07oNo0
	 eJGauI24yOucx8H9hAm1dOhuLRfipKqyWHaHZP5QwmXlJ5yPyX7hz8RxQ3fEdjkz4P
	 6sR16xicHtVcv1r398AV2o1xpFMx0+deacOxH++tcVCWFSVVJ7N2PG8zVJwUVTUZgU
	 5Eme/f5GLTY8nvnRbi74Pv9/q+mtRUtBVutviCZn41BxMq6F9YYsO4IxGxl0hib9w8
	 SUkiDeKbzGxRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA73C0218D;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Sat, 25 Jan 2025 16:29:50 +0800
Subject: [PATCH bpf-next v2 3/7] bpf: Implement bpf_copy_from_user_dynptr
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-bpf_dynptr_probe-v2-3-c42c87f97afe@outlook.com>
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
In-Reply-To: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4919;
 i=rsworktech@outlook.com; h=from:subject:message-id;
 bh=PbsS7Vpr6USg1jk+KBsoBiOuzmKNN5IGam682v3+Quo=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBnlKEcWhxtdmFMeS8e/j2IAS0TMUqjsi0v1GWCl
 kfWJnx3yfKJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZ5ShHAAKCRBvO5jUL8bJ
 2NIOEACF2vYKdtugfPkki7eYCvJ3omVjfA4rb1wl39Hq/qNTHLWNz+/Gvhm2ZrdyAaLaDrMWbFw
 1Yhz9cbOPBTTCnaouVLGUHY6rFse1euFPZWduj1RCzNsdvsXHOyfGH0J6BMeXEMUeWNYPx3ttEP
 VpVe+XlWkhR3VHfLZvafAdgpjs/4NWstbC5AfFrrVxddA3e7zzlYqWX3nSx7Pz0aj5I+FVyYGL7
 AH+/k4kScAiW0Zg3ztHF4KT9Zs4+j5kOuEGVh5PbWKMtWAucK7OPy+Ex37P7xZYBRBT3KbOGVsx
 zJMsn13Hz1DMZRaoZYs058VWLUm03dXkQe1SyrjFmRlURNdmSWiEl8CiYF5iUUK2Q0viniy1+0E
 AENGF5oWU+MXGtXZrZrJJmqZIOyvxsD7yeuVRoraqzkzNEFTFUVd/YUXBOYha+pNmDnpQQmvTJW
 WrYfhYiZvMlbb5r4hVCPcpcC/9UDqEg04O1pHgDCqqdgTNwheZ37i8NdNMeo+5fAtX5Zsz5bSN2
 kXq49mID7+PqiJNGMGD5JKj3vn/NVEl0oRAwx/DVx+WUD85bbbn0nYBo6bABdRJHjwvDf60/iNY
 sCxSUOlPs398GNnM+ztvdA8dtpasLLWmiGJXczA1njfLrozvjSNG65Ioi5jexf+mPPggBi60hVj
 aDVlGDi7FYxYZpw==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/default with
 auth_id=219
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

From: Levi Zim <rsworktech@outlook.com>

This patch add a helper function bpf_copy_from_user_dynptr:

bpf_copy_from_user_dynptr(const struct bpf_dynptr *dst, u32 offset,
	u32 size, const void *user_ptr, u64 flags)

It is useful for reading variable-length data from kernel memory into
dynptr.

Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
 include/linux/bpf.h      |  1 +
 include/uapi/linux/bpf.h | 17 +++++++++++++++++
 kernel/bpf/helpers.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c |  2 ++
 4 files changed, 62 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9d5ae8b4b7d82c4523bf0ab041d4b76bf134a106..d0412eaf63d69c0e437575c77008548edc692335 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3357,6 +3357,7 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
 extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
+extern const struct bpf_func_proto bpf_copy_from_user_dynptr_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d7d7a9ddd5dca07ba89d81ba77101a704af3163b..f92cf809b50bc393d54eb0e8de2e1ce2a39e95d0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5835,6 +5835,22 @@ union bpf_attr {
  *		support this helper, or if *flags* is not 0.
  *
  *		Or other negative errors on failure reading user space memory.
+ *
+ * long bpf_copy_from_user_dynptr(const struct bpf_dynptr *dst, u32 offset, u32 size, const void *user_ptr, u64 flags)
+ *	Description
+ *		Read *size* bytes from user space address *user_ptr* and store
+ *		the data in *dst* starting from *offset*.
+ *		This is a wrapper of **copy_from_user**\ ().
+ *		*flags* is currently unused.
+ *	Return
+ *		0 on success.
+ *
+ *		**-E2BIG** if *offset* + *len* exceeds the length of *src*'s data
+ *
+ *		**-EINVAL** if *src* is an invalid dynptr or doesn't support this
+ *		support this helper, or if *flags* is not 0.
+ *
+ *		Or other negative errors on failure reading user space memory.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6051,6 +6067,7 @@ union bpf_attr {
 	FN(cgrp_storage_delete, 211, ##ctx)		\
 	FN(probe_read_kernel_dynptr, 212, ##ctx)		\
 	FN(probe_read_user_dynptr, 213, ##ctx)		\
+	FN(copy_from_user_dynptr, 214, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index ac563d09082e7c721999d7de035aabc000206a29..d756c80596315bd07fe6e71885b61efc8cb2ef4f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -676,6 +676,48 @@ const struct bpf_func_proto bpf_copy_from_user_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_5(bpf_copy_from_user_dynptr, const struct bpf_dynptr_kern *, dst,
+	u32, offset, u32, size, const void __user *, user_ptr, u32, flags)
+{
+	enum bpf_dynptr_type type;
+	int err;
+
+	if (!dst->data || __bpf_dynptr_is_rdonly(dst))
+		return -EINVAL;
+
+	err = bpf_dynptr_check_off_len(dst, offset, size);
+	if (err)
+		return err;
+
+	type = bpf_dynptr_get_type(dst);
+
+	switch (type) {
+	case BPF_DYNPTR_TYPE_LOCAL:
+	case BPF_DYNPTR_TYPE_RINGBUF:
+		if (flags)
+			return -EINVAL;
+		return ____bpf_copy_from_user(dst->data + dst->offset + offset, size, user_ptr);
+	case BPF_DYNPTR_TYPE_SKB:
+	case BPF_DYNPTR_TYPE_XDP:
+		return -EINVAL;
+	default:
+		WARN_ONCE(true, "%s: unknown dynptr type %d\n", __func__, type);
+		return -EFAULT;
+	}
+}
+
+const struct bpf_func_proto bpf_copy_from_user_dynptr_proto = {
+	.func		= bpf_copy_from_user_dynptr,
+	.gpl_only	= false,
+	.might_sleep	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_DYNPTR | MEM_RDONLY,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
 BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32, size,
 	   const void __user *, user_ptr, struct task_struct *, tsk, u64, flags)
 {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d9f704c1342773c74b2414be4adfc8271d6d364d..424931925fe3b02db083bc19cc64e19918b40c5a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1598,6 +1598,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_copy_from_user_proto;
 	case BPF_FUNC_copy_from_user_task:
 		return &bpf_copy_from_user_task_proto;
+	case BPF_FUNC_copy_from_user_dynptr:
+		return &bpf_copy_from_user_dynptr_proto;
 	case BPF_FUNC_snprintf_btf:
 		return &bpf_snprintf_btf_proto;
 	case BPF_FUNC_per_cpu_ptr:

-- 
2.48.1



