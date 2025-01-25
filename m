Return-Path: <linux-kselftest+bounces-25167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DDBA1C235
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 09:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A5E167C53
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 08:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED82207E12;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpipAMv8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE9207665;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737793828; cv=none; b=unGG2kLZxl3myS0DQQ64m7qz42JZlFpuYKokdRoTYb3Lz1JckCv2loEXwlmc6jV1OvcSHsqItEhN3HZLPm1Llqq+O7sWwqCsqQJOhyxQCHP38HpvCUQKX8Aey9ifHRzRCyIP1P2yoRZAbP8yuYISzREudy86Dp70MSQcTIGFG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737793828; c=relaxed/simple;
	bh=uVIhYSX/ojtZXVYzOH86j+THkc3nC0l4nRGJm4xvBxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yj0u1Xe4uM4z372ryX95CGKQH8qW3zEoJtxykoUtsWEPWqiVMMrhapkR3SbPh7JVZmM3PLnprf6X3vxUt0Gyny2zzgTHQyas4jbM8DC1IzRTh8HIPpIMb6Hr0h7ZOchFbaIz8oZYNnvgbfY+UsIiohJRFkb79+aKKxxehjb/lgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpipAMv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1096FC4CEE8;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737793828;
	bh=uVIhYSX/ojtZXVYzOH86j+THkc3nC0l4nRGJm4xvBxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qpipAMv8P+TEEuRKrnzeO7oIT84H0CE65/4PGujbKgk5Yk08fVXPKDsnOwNZi7nGM
	 ck5xf8pgLI8D67zObXfwuzngG1oZ3OapEGBg1mrvD4T8gZDC+9cSVnm+RcKmB55AGk
	 av1nRy1lRAgq5S8Vmy3G8Sre3GsoMudNZf8Q4D8410Z/iXmVrrZuc2Y+qxHxg/5hPt
	 XkwQ2jtD2XNX4BsGXqjn/i4dI1CuUcpZyJqE70be78DvVnf4j+A9ZfAjk8Pcse8oom
	 ahbOuwzIvavnMYUI7k8ujrcupU7iYXiUoYhV5zkRV5PlEEt3+ksc/kKX1azucij08z
	 RLypf9otBiFsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E66C0218C;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Sat, 25 Jan 2025 16:29:49 +0800
Subject: [PATCH bpf-next v2 2/7] bpf: Implement bpf_probe_read_user_dynptr
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-bpf_dynptr_probe-v2-2-c42c87f97afe@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6307;
 i=rsworktech@outlook.com; h=from:subject:message-id;
 bh=FYHnq6c7uuywFLvG8HAAKztCiF4RpinK4T4T/ey1n7A=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBnlKEbKfdh050oR+U5evUh4HhBuo56XWFUjuxJN
 ymCJMkFBoqJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZ5ShGwAKCRBvO5jUL8bJ
 2A1sEAC1otgG8OUem9SzSh08jElKCXOBpvUV4ESS3PK+TA9yxDsHVte7EhHxeEzmUbtuZOTU/mA
 h2MEO5aHphgSApxuOzFJinUfHnnvYfU9600M8me9jgYkEcq11N1DeCp8yFTX75v0/2UQpAx8gtB
 gIIM67NdH2+NdyOPDGyxjYmRxrKu0YdKUaAYDtAVaMoTo+PrlvUnQ0zjl4WUwEeviBXgb7REcI/
 BCjdm4tI81hyUmVGA3jeFziqAuDlE8OPfjUyMKvHDU8e/BTj2O8CtD0d5ALsz+dhPmiYILLP/et
 CQ7Ot/HPzxp9iDMeKK7uW9W5xCaA6qyf0fzAzSF14qzG7QwPGQf+E2IXf5ocIv1u/4KBM52UCKH
 LBaC2/9lzcXfTrliP7Yv+Phna37Tte6VL3NpcvfFXCfMYZBy8s9ZWWQ+dbkat4k4hWOMoirSPsZ
 xe851lFe0EzrAqYzJ4/8M8z5qCWglT22ECQ8aTqXKDrJtWxgHeKojFPk1Y+YO90FiAKGw71wZjV
 AYG8uECQE/wZmcCIIu/cyWJ5zbtGeaiVCWgK/VoxiNt+37w/dlxYp0m0HTVaZ8qnYOsW9oLDusb
 9Xl822TPmG3x5yRlCu1KANaA/TIDxBNvRYEV7mo9SV7f3QwO1sX/T8sFAp+2H6lb+W2e8Wy7ERQ
 mAHbMTCDpb/8+0A==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/default with
 auth_id=219
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

From: Levi Zim <rsworktech@outlook.com>

This patch add a helper function bpf_probe_read_user_dynptr:

long bpf_probe_read_user_dynptr(const struct bpf_dynptr *dst,
	u32 offset, u32 size, const void *unsafe_ptr, u64 flags);

It is useful for reading variable-length data from user memory into
dynptr.

Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
 include/uapi/linux/bpf.h | 16 ++++++++++
 kernel/bpf/helpers.c     |  3 ++
 kernel/trace/bpf_trace.c | 76 +++++++++++++++++++++++++++++++++---------------
 3 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2e08a59527ecf56732ea14ac34446b5eb25b5690..d7d7a9ddd5dca07ba89d81ba77101a704af3163b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5820,6 +5820,21 @@ union bpf_attr {
  *		support this helper, or if *flags* is not 0.
  *
  *		Or other negative errors on failure reading kernel memory.
+ *
+ * long bpf_probe_read_user_dynptr(const struct bpf_dynptr *dst, u32 offset, u32 size, const void *unsafe_ptr, u64 flags)
+ *	Description
+ *		Safely attempt to read *size* bytes from user space address
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
+ *		Or other negative errors on failure reading user space memory.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6035,6 +6050,7 @@ union bpf_attr {
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
 	FN(probe_read_kernel_dynptr, 212, ##ctx)		\
+	FN(probe_read_user_dynptr, 213, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a736dc9e7be98571103ba404420be0da4dac4fbe..ac563d09082e7c721999d7de035aabc000206a29 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1898,6 +1898,7 @@ const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_str_proto __weak;
+const struct bpf_func_proto bpf_probe_read_user_dynptr_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_str_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_dynptr_proto __weak;
@@ -2029,6 +2030,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_task_btf_proto;
 	case BPF_FUNC_probe_read_user:
 		return &bpf_probe_read_user_proto;
+	case BPF_FUNC_probe_read_user_dynptr:
+		return &bpf_probe_read_user_dynptr_proto;
 	case BPF_FUNC_probe_read_kernel:
 		return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0 ?
 		       NULL : &bpf_probe_read_kernel_proto;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 75c9d1e8d04c3b8930ae81345f5586756ce8b5ec..d9f704c1342773c74b2414be4adfc8271d6d364d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -181,6 +181,36 @@ bpf_probe_read_user_common(void *dst, u32 size, const void __user *unsafe_ptr)
 	return ret;
 }
 
+static int bpf_probe_read_check_dynptr(const struct bpf_dynptr_kern *dst,
+	u32 offset, u32 size, u64 flags)
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
+		return 0;
+	case BPF_DYNPTR_TYPE_SKB:
+	case BPF_DYNPTR_TYPE_XDP:
+		return -EINVAL;
+	default:
+		WARN_ONCE(true, "%s: unknown dynptr type %d\n", __func__, type);
+		return -EFAULT;
+	}
+}
+
 BPF_CALL_3(bpf_probe_read_user, void *, dst, u32, size,
 	   const void __user *, unsafe_ptr)
 {
@@ -196,6 +226,26 @@ const struct bpf_func_proto bpf_probe_read_user_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_5(bpf_probe_read_user_dynptr, const struct bpf_dynptr_kern *, dst,
+	u32, offset, u32, size, void *, unsafe_ptr, u64, flags)
+{
+	int ret = bpf_probe_read_check_dynptr(dst, offset, size, flags);
+
+	return ret ?: bpf_probe_read_user_common(dst->data + dst->offset + offset,
+				size, unsafe_ptr);
+}
+
+const struct bpf_func_proto bpf_probe_read_user_dynptr_proto = {
+	.func		= bpf_probe_read_user_dynptr,
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
 bpf_probe_read_user_str_common(void *dst, u32 size,
 			       const void __user *unsafe_ptr)
@@ -251,32 +301,10 @@ const struct bpf_func_proto bpf_probe_read_kernel_proto = {
 BPF_CALL_5(bpf_probe_read_kernel_dynptr, const struct bpf_dynptr_kern *, dst,
 	u32, offset, u32, size, void *, unsafe_ptr, u64, flags)
 {
-	enum bpf_dynptr_type type;
-	int err;
-
-	if (!dst->data || __bpf_dynptr_is_rdonly(dst))
-		return -EINVAL;
+	int ret = bpf_probe_read_check_dynptr(dst, offset, size, flags);
 
-	err = bpf_dynptr_check_off_len(dst, offset, size);
-	if (err)
-		return err;
-
-	type = bpf_dynptr_get_type(dst);
-
-	switch (type) {
-	case BPF_DYNPTR_TYPE_LOCAL:
-	case BPF_DYNPTR_TYPE_RINGBUF:
-		if (flags)
-			return -EINVAL;
-		return bpf_probe_read_kernel_common(dst->data + dst->offset + offset,
+	return ret ?: bpf_probe_read_kernel_common(dst->data + dst->offset + offset,
 				size, unsafe_ptr);
-	case BPF_DYNPTR_TYPE_SKB:
-	case BPF_DYNPTR_TYPE_XDP:
-		return -EINVAL;
-	default:
-		WARN_ONCE(true, "%s: unknown dynptr type %d\n", __func__, type);
-		return -EFAULT;
-	}
 }
 
 const struct bpf_func_proto bpf_probe_read_kernel_dynptr_proto = {

-- 
2.48.1



