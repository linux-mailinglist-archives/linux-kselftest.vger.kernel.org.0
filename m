Return-Path: <linux-kselftest+bounces-25165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19F3A1C234
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 09:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999A91888AD7
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E69207E04;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URANgktB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC131B412B;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737793828; cv=none; b=bFFisuAqMogvkMa6aq4SdhPAn5kCwJavXVE839gNvmgc9qd+H+mQO34KEd3F9CdsohTfk09jjspPqhjTGU/Awxmy8KNEI/0Ah6OstOC1KCqyLpzCnEvbEgOZ/h70EjKBJa2CRxRQTJXSgsr0Hwy+zAkcKvnWboQWeMv+S0hcufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737793828; c=relaxed/simple;
	bh=ZtcDKBYvpGO+GJwMItu+xm+YQJmprDGI/QwBss5wxAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPI6hByDefiS+hVQgylRLMy8joYRfMWZ7ixPcUTUvNl4fXmeDlsZMmgPvv4o+I08SoVvjTmz0AfjJkqdU90DQWJDsfSx6GRWbKwZSuv5cnIGAHXT0TJymcB0m196xe7qF3La/yACyctMs7aryIlwryNW5NasXTu0NnLP8LFHm/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URANgktB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC8B4C4CEE0;
	Sat, 25 Jan 2025 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737793828;
	bh=ZtcDKBYvpGO+GJwMItu+xm+YQJmprDGI/QwBss5wxAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=URANgktB1oVQ+aNEyysZu0+3FHDV26ajhREpZxBpD9UNGnWUrdOxkvrz+YQAYlLr+
	 /o++9NeN9jLq/evMvEf0W4kNHE5nQnsC2cRXEUcGMD51Lr8ycveNHXn/Ju4fkUwaJX
	 sOcso6P8bIAm3meHs7Azo/YyGESKcQeZv9RgSxplWWXQmjWQwR5vbJx8ObmgIBcNgY
	 lyejB7WCLQJcAmbPkamqCkH1lgwIUZGt3tFTmcl8qaS0Pi8OF3FlWJ5JJtWZlTm5pt
	 S/hzCTNr3BBSlhprwGzrOkeA6NyNs6HDgZqCOe8HCl65ZiXt0ZYs+Cidl3kaBZBpln
	 PtOmVMJZx/zDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D824FC0218E;
	Sat, 25 Jan 2025 08:30:27 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Sat, 25 Jan 2025 16:29:48 +0800
Subject: [PATCH bpf-next v2 1/7] bpf: Implement
 bpf_probe_read_kernel_dynptr helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-bpf_dynptr_probe-v2-1-c42c87f97afe@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6356;
 i=rsworktech@outlook.com; h=from:subject:message-id;
 bh=A7uHiAoA3YZYbVOxcHt/y8HP3bfI8O7Zg6oKJ3y0uAs=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBnlKEazmLRxSxN+99+LUcfUAXeS2U/PVRZTjaYH
 b1xE1uWQeuJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZ5ShGgAKCRBvO5jUL8bJ
 2GW1EADFpjQlYxCyffskjdPxEJPfxhVA2uuid/BwoPyzoda7V25wj9O8JWKtaXbNZeE/i/v7nHd
 KvaU/n/9Li/xuWc5AsHxIZGOEb1QaoOMcn4BpejONG/kEpuy7E/+RRzjtV5LKadnSDt2sZO3qcn
 jb5yrGCcS3trVG1Hf9IkAC9vsCno8nrMt5o2OvkTszCBwOqWETmlMDwERuaD4g80sQT5oaNpJra
 NSKdyJUgozDwO1osWYeG183iCKo6Tw3YsGX5Rsjqb/GQ//H6SDyMpzRILDR1HC70w9TPYmtsmt3
 WdkIWhbc/zd8Dj8y2AsTF1/nq/N/Aa1Izux8JkuxbPlHeR9OboIOPPxg74Nm9RiJ9pjuiIlgtT/
 TeM16kYewqImFrlO8OO1ZhBCKm06S3ArOeZuNQHZcrxIxvctNgvG/sTna4CWAxUE9+/YllCqhZb
 IRWt/4tkMJXD5d2x5llMSLr4OmJbchDqWgAHWsUUDfcEKNGhOzGI6UrTMyUztV7qRk4rZLvzhkf
 AY9oQhnH0MQIcNLieFep2rU++GJ1TgvdZ2DGIvAnC+n59VgVMZ0vg/xeF6DW4vufP4jrPyw2v7i
 WevCUalflNsSDaObLDFDOwvrKLPrUOsF5Wx9KyE+bMiOdkmjgMUASyeTJpI1FQVjyljGui0vO6U
 ADBAMjwi0ICIt8A==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/default with
 auth_id=219
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

From: Levi Zim <rsworktech@outlook.com>

This patch add a helper function bpf_probe_read_kernel_dynptr:

long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst,
	u32 offset, u32 size, const void *unsafe_ptr, u64 flags);

It is useful for reading variable-length data from kernel memory into
dynptr.

Link: https://lore.kernel.org/bpf/MEYP282MB2312CFCE5F7712FDE313215AC64D2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM/
Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
 include/linux/bpf.h      |  2 ++
 include/uapi/linux/bpf.h | 16 ++++++++++++++++
 kernel/bpf/helpers.c     |  8 ++++++--
 kernel/trace/bpf_trace.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f3f50e29d63929acaf12c81f8356173f1f5e154b..9d5ae8b4b7d82c4523bf0ab041d4b76bf134a106 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1323,6 +1323,8 @@ u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
 const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
 void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
 bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
+int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len);
+enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr);
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2acf9b33637174bd16b1d12ccc6410c5f55a7ea9..2e08a59527ecf56732ea14ac34446b5eb25b5690 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5805,6 +5805,21 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst, u32 offset, u32 size, const void *unsafe_ptr, u64 flags)
+ *	Description
+ *		Safely attempt to read *size* bytes from kernel space address
+ *		*unsafe_ptr* and store the data in *dst* starting from *offset*.
+ *		*flags* is currently unused.
+ *	Return
+ *		0 on success.
+ *
+ *		**-E2BIG** if *offset* + *len* exceeds the length of *src*'s data
+ *
+ *		**-EINVAL** if *src* is an invalid dynptr or doesn't support this
+ *		support this helper, or if *flags* is not 0.
+ *
+ *		Or other negative errors on failure reading kernel memory.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6019,6 +6034,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(probe_read_kernel_dynptr, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f27ce162427ab4040d2e2d2eb84a883fe57de59e..a736dc9e7be98571103ba404420be0da4dac4fbe 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1678,7 +1678,7 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
 	ptr->size |= type << DYNPTR_TYPE_SHIFT;
 }
 
-static enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr)
+enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr)
 {
 	return (ptr->size & ~(DYNPTR_RDONLY_BIT)) >> DYNPTR_TYPE_SHIFT;
 }
@@ -1714,7 +1714,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 	memset(ptr, 0, sizeof(*ptr));
 }
 
-static int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
+int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
 {
 	u32 size = __bpf_dynptr_size(ptr);
 
@@ -1900,6 +1900,7 @@ const struct bpf_func_proto bpf_probe_read_user_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_str_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_str_proto __weak;
+const struct bpf_func_proto bpf_probe_read_kernel_dynptr_proto __weak;
 const struct bpf_func_proto bpf_task_pt_regs_proto __weak;
 
 const struct bpf_func_proto *
@@ -2031,6 +2032,9 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_probe_read_kernel:
 		return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0 ?
 		       NULL : &bpf_probe_read_kernel_proto;
+	case BPF_FUNC_probe_read_kernel_dynptr:
+		return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0 ?
+		       NULL : &bpf_probe_read_kernel_dynptr_proto;
 	case BPF_FUNC_probe_read_user_str:
 		return &bpf_probe_read_user_str_proto;
 	case BPF_FUNC_probe_read_kernel_str:
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index adc947587eb8132ebbd54778d2db937b3b8861de..75c9d1e8d04c3b8930ae81345f5586756ce8b5ec 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -248,6 +248,48 @@ const struct bpf_func_proto bpf_probe_read_kernel_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_5(bpf_probe_read_kernel_dynptr, const struct bpf_dynptr_kern *, dst,
+	u32, offset, u32, size, void *, unsafe_ptr, u64, flags)
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
+		return bpf_probe_read_kernel_common(dst->data + dst->offset + offset,
+				size, unsafe_ptr);
+	case BPF_DYNPTR_TYPE_SKB:
+	case BPF_DYNPTR_TYPE_XDP:
+		return -EINVAL;
+	default:
+		WARN_ONCE(true, "%s: unknown dynptr type %d\n", __func__, type);
+		return -EFAULT;
+	}
+}
+
+const struct bpf_func_proto bpf_probe_read_kernel_dynptr_proto = {
+	.func		= bpf_probe_read_kernel_dynptr,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_DYNPTR | MEM_RDONLY,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
 static __always_inline int
 bpf_probe_read_kernel_str_common(void *dst, u32 size, const void *unsafe_ptr)
 {

-- 
2.48.1



