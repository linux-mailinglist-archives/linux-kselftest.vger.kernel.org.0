Return-Path: <linux-kselftest+bounces-49521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMxcJ6DNb2mgMQAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49521-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 19:46:56 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC8C49C0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 19:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0B2F5E3A52
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33BA3002BA;
	Tue, 20 Jan 2026 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v8K48JaK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FC2FFDF7
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922322; cv=none; b=QzkNnlsAerk0PyP7kt0UFsw92BJ4RjTRq/PpBIVVZys8xBc+gZwAUXbnaLwrNY2729IZoBN97meIr55teAr6imMlf8w9z3cPXc17vcr4y/iIZEJDXHVWhffb0fvCNnMUl7t/HWLe+P8UXoAZZHgR6QJHSnkhceq9UZf9Y62130k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922322; c=relaxed/simple;
	bh=8ozzNJgyqK43aAMDbi+isaR9zJ6IWS3IDCGEK9uyR50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2vN2XbDjSia/bWiTYNvZsh56ce1fkvClMosbO/w4HRNPbKQjbEgeVhq7qI0WIW48VghnuL4+Ip+dlKQiWw3ce73GODMIG+5HQNnRJ7XSLS4BxLHcwDw0K2auiOq0iiKJAFCNCA1or+mHXiNtZEdy8TBITlNVPm3er0VJzGrzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v8K48JaK; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768922318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kEiXNfLi6uoWFn9MWxuUVEjTcz/eymK3cqMhcQByFw=;
	b=v8K48JaKz/VhycMcYbzQlEtnCgAuITR9sBBhS9Dyw8FfSQCDgkAycM7jzAx8s19XWrjKkt
	VgcNXNVfZCCFvJnxnb42AGW6Q8S8iMb1c1DqBSNn5AYvo5Mzuae72UwXeJaqSUN1iYC15t
	qp6d2ZEGZWY7mNn08FPv32iQ1UeJDVY=
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
Subject: [PATCH bpf-next v6 1/9] bpf: Extend BPF syscall with common attributes support
Date: Tue, 20 Jan 2026 23:15:08 +0800
Message-ID: <20260120151516.39607-2-leon.hwang@linux.dev>
In-Reply-To: <20260120151516.39607-1-leon.hwang@linux.dev>
References: <20260120151516.39607-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-49521-lists,linux-kselftest=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-kselftest@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-kselftest];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 0FC8C49C0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 2a2ade4be60f..814bd2debd5b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -986,6 +986,7 @@ enum bpf_cmd {
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
 	__MAX_BPF_CMD,
+	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying syscall common attrs. */
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
index ecc0929ce462..27fc73a29b0f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6163,8 +6163,10 @@ static int prog_assoc_struct_ops(union bpf_attr *attr)
 	return ret;
 }
 
-static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
+static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
+		     bpfptr_t uattr_common, unsigned int size_common)
 {
+	struct bpf_common_attr attr_common;
 	union bpf_attr attr;
 	int err;
 
@@ -6178,6 +6180,20 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	if (copy_from_bpfptr(&attr, uattr, size) != 0)
 		return -EFAULT;
 
+	memset(&attr_common, 0, sizeof(attr_common));
+	if (cmd & BPF_COMMON_ATTRS) {
+		err = bpf_check_uarg_tail_zero(uattr_common, sizeof(attr_common), size_common);
+		if (err)
+			return err;
+
+		cmd &= ~BPF_COMMON_ATTRS;
+		size_common = min_t(u32, size_common, sizeof(attr_common));
+		if (copy_from_bpfptr(&attr_common, uattr_common, size_common) != 0)
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
index b816bc53d2e1..c14f9c6a275c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -986,6 +986,7 @@ enum bpf_cmd {
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
 	__MAX_BPF_CMD,
+	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying syscall common attrs. */
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


