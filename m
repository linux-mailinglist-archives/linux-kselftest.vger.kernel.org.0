Return-Path: <linux-kselftest+bounces-48751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA73D13897
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 16:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 848AA307C5F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395142D8375;
	Mon, 12 Jan 2026 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UJciKCUS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8622BEC5A
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229916; cv=none; b=Uawuz0zbUbmki3r6Hv0hxS4nPholz2naFOPQuz3r9Mh0PZ3KMBwS+wKNfejafRE7u7hMJXpZkKrLr+ObjPfBU1BuSOugxaxcoLofe9wMw5vs56Rybid90mJjDad1GjEQpha4j6UZtDpUl5bBEuOG0zMSvm/QtJbjTh1E7Saq8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229916; c=relaxed/simple;
	bh=eBTpSjqKxPvQlAXR3b+Jv4T+8LrNMdkqP9R41j8bAjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVKyBbWM4NDDfG3PMdNpghTrMSMXtZcUMPlMdp+wjYDASadkJd0lJhgwV7Uq68tI1Ubz6sldkZ3YOQjH5ssD3ICe8ozga6HPMABeZiV1lNfsrunLAe1VokXn/c14nzAwUwPXBaCAZfjA2E7NBab/NhlBDAbfxS0Icgjom5SKx5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UJciKCUS; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768229911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWI4RyxS6L34QhvykOzFqGopdR720pTgxPjogyIyayc=;
	b=UJciKCUShF4tmdippFEjmCFvheNFJ/hWe9lN41kKTnBX8Enu8npiGoYRK9xi22Qzt76UnY
	MjV+O/xpHrZyVeUsLSZWTfkz6+vRMhpdkJ2qGMM7+O7S/Q6hw0oiBTAT3RbEezLhWiI3Wi
	pzP3S4O8V4ysZdPR8pi678IZK2JaoXU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>,
	Yuichiro Tsuji <yuichtsu@amazon.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Tao Chen <chen.dylane@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v5 1/9] bpf: Extend BPF syscall with common attributes support
Date: Mon, 12 Jan 2026 22:56:08 +0800
Message-ID: <20260112145616.44195-2-leon.hwang@linux.dev>
In-Reply-To: <20260112145616.44195-1-leon.hwang@linux.dev>
References: <20260112145616.44195-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extend the BPF syscall to support a set of common attributes shared
across all BPF commands:

1. 'log_buf': User-provided buffer for storing logs.
2. 'log_size': Size of the log buffer.
3. 'log_level': Log verbosity level.
4. 'log_true_size': The size of log reported by kernel.

These common attributes are passed as the 4th argument to the BPF
syscall, with the 5th argument specifying the size of this structure.

To indicate the use of these common attributes from userspace, a new flag
'BPF_COMMON_ATTRS' ('1 << 16') is introduced. This flag is OR-ed into the
'cmd' field of the syscall.

When 'cmd & BPF_COMMON_ATTRS' is set, the kernel will copy the common
attributes from userspace into kernel space for use.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/syscalls.h       |  3 ++-
 include/uapi/linux/bpf.h       |  8 ++++++++
 kernel/bpf/syscall.c           | 25 +++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h |  8 ++++++++
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index cf84d98964b2..729659202d77 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -937,7 +937,8 @@ asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
 asmlinkage long sys_getrandom(char __user *buf, size_t count,
 			      unsigned int flags);
 asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
-asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned int size);
+asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned int size,
+			struct bpf_common_attr __user *attr_common, unsigned int size_common);
 asmlinkage long sys_execveat(int dfd, const char __user *filename,
 			const char __user *const __user *argv,
 			const char __user *const __user *envp, int flags);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2a2ade4be60f..2f83eca0a357 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -986,6 +986,7 @@ enum bpf_cmd {
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
 	__MAX_BPF_CMD,
+	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying bpf_common_attr. */
 };
 
 enum bpf_map_type {
@@ -1491,6 +1492,13 @@ struct bpf_stack_build_id {
 	};
 };
 
+struct bpf_common_attr {
+	__u64 log_buf;
+	__u32 log_size;
+	__u32 log_level;
+	__u32 log_true_size;
+};
+
 #define BPF_OBJ_NAME_LEN 16U
 
 enum {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ecc0929ce462..af703f7ea58e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6163,8 +6163,10 @@ static int prog_assoc_struct_ops(union bpf_attr *attr)
 	return ret;
 }
 
-static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
+static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
+		     bpfptr_t uattr_common, unsigned int size_common)
 {
+	struct bpf_common_attr common_attr;
 	union bpf_attr attr;
 	int err;
 
@@ -6178,6 +6180,20 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	if (copy_from_bpfptr(&attr, uattr, size) != 0)
 		return -EFAULT;
 
+	memset(&common_attr, 0, sizeof(common_attr));
+	if (cmd & BPF_COMMON_ATTRS) {
+		err = bpf_check_uarg_tail_zero(uattr_common, sizeof(common_attr), size_common);
+		if (err)
+			return err;
+
+		cmd &= ~BPF_COMMON_ATTRS;
+		size_common = min_t(u32, size_common, sizeof(common_attr));
+		if (copy_from_bpfptr(&common_attr, uattr_common, size_common) != 0)
+			return -EFAULT;
+	} else {
+		size_common = 0;
+	}
+
 	err = security_bpf(cmd, &attr, size, uattr.is_kernel);
 	if (err < 0)
 		return err;
@@ -6313,9 +6329,10 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	return err;
 }
 
-SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
+SYSCALL_DEFINE5(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size,
+		struct bpf_common_attr __user *, uattr_common, unsigned int, size_common)
 {
-	return __sys_bpf(cmd, USER_BPFPTR(uattr), size);
+	return __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
 }
 
 static bool syscall_prog_is_valid_access(int off, int size,
@@ -6346,7 +6363,7 @@ BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, attr, u32, attr_size)
 	default:
 		return -EINVAL;
 	}
-	return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size);
+	return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size, KERNEL_BPFPTR(NULL), 0);
 }
 
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b816bc53d2e1..2b05c689d51a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -986,6 +986,7 @@ enum bpf_cmd {
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
 	__MAX_BPF_CMD,
+	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying bpf_common_attr. */
 };
 
 enum bpf_map_type {
@@ -1491,6 +1492,13 @@ struct bpf_stack_build_id {
 	};
 };
 
+struct bpf_common_attr {
+	__u64 log_buf;
+	__u32 log_size;
+	__u32 log_level;
+	__u32 log_true_size;
+};
+
 #define BPF_OBJ_NAME_LEN 16U
 
 enum {
-- 
2.52.0


