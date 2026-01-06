Return-Path: <linux-kselftest+bounces-48320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8AFCF9829
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 18:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9C0D301B67A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 17:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B92533971D;
	Tue,  6 Jan 2026 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sFk0TiIQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32593396F0
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718841; cv=none; b=BL7rmjpTVgCiu9ELoSyDbAy7zULnHG0mH/bQV85tlxSudO3ogodM4W/NwtJYMaIf+nzpNmdycVJUr4QZkademkOSX03hfK02m4yvK6m5hZ4WF++ggqYp3hgQLtKYgO2tr6TtsGroXOZeEG+cu/EZ6mSTZdWAWrFErdh1eD8Jmws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718841; c=relaxed/simple;
	bh=Ftj/YzLelibUqHaEwRcMBZFhoEUuV8xe/0iLYvtKu9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o47ke2wTHPsiZpID6vjNxm9v4oNNvA6j72WdO9LFO+Iw65JvGbiAjceI61+Z38WtdiJ71XqptBzJWJD0nq75oXXLdO8KRoi01dlzv2rBZiCtTXJO7YBILz1ybZQYCx5ttkX0ll603uDQgOjEgWAMvQbupcmOy6mGa5VG2bwL9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sFk0TiIQ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767718837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EC0zW95wgB8/pMIwQU9ZWEcVV2VXSlvtnuFHgDLceqM=;
	b=sFk0TiIQH5jhQ9ifiJbWro82H63vmPXDvrwn2KbYlpaXfHPldznbQhiPfBYf7SrynEw4t+
	9EsJ3N++VTf08NSv7GxmW5yDBfvckqxNDbQ5cIjGq7pS/SHiKEAskZeeWJHkFgtHWGP2pS
	VU/E6i/M+PvNTBX2XYR2U2LYsdaJ+8Q=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Seth Forshee <sforshee@kernel.org>,
	Yuichiro Tsuji <yuichtsu@amazon.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 5/9] bpf: Refactor reporting btf_log_true_size for btf_load
Date: Wed,  7 Jan 2026 00:59:03 +0800
Message-ID: <20260106165907.53631-6-leon.hwang@linux.dev>
In-Reply-To: <20260106165907.53631-1-leon.hwang@linux.dev>
References: <20260106165907.53631-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the next commit, it will be able to report logs via extended common
attributes, which will report 'log_true_size' via the extended common
attributes meanwhile.

Therefore, refactor the way of 'btf_log_true_size' reporting in order to
report 'log_true_size' via the extended common attributes easily.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/btf.h  |  2 +-
 kernel/bpf/btf.c     | 25 +++++--------------------
 kernel/bpf/syscall.c | 19 ++++++++++++++++---
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 691f09784933..2b27fdd567f5 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -144,7 +144,7 @@ const char *btf_get_name(const struct btf *btf);
 void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
 const struct btf_header *btf_header(const struct btf *btf);
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
+int btf_new_fd(union bpf_attr *attr, bpfptr_t uattr);
 struct btf *btf_get_by_fd(int fd);
 int btf_get_info_by_fd(const struct btf *btf,
 		       const union bpf_attr *attr,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 539c9fdea41d..9efcbb489edb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5745,22 +5745,7 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
 	return 0;
 }
 
-static int finalize_log(struct bpf_verifier_log *log, bpfptr_t uattr, u32 uattr_size)
-{
-	u32 log_true_size;
-	int err;
-
-	err = bpf_vlog_finalize(log, &log_true_size);
-
-	if (uattr_size >= offsetofend(union bpf_attr, btf_log_true_size) &&
-	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, btf_log_true_size),
-				  &log_true_size, sizeof(log_true_size)))
-		err = -EFAULT;
-
-	return err;
-}
-
-static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+static struct btf *btf_parse(union bpf_attr *attr, bpfptr_t uattr)
 {
 	bpfptr_t btf_data = make_bpfptr(attr->btf, uattr.is_kernel);
 	char __user *log_ubuf = u64_to_user_ptr(attr->btf_log_buf);
@@ -5841,7 +5826,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		}
 	}
 
-	err = finalize_log(&env->log, uattr, uattr_size);
+	err = bpf_vlog_finalize(&env->log, &attr->btf_log_true_size);
 	if (err)
 		goto errout_free;
 
@@ -5853,7 +5838,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	btf_free_struct_meta_tab(btf);
 errout:
 	/* overwrite err with -ENOSPC or -EFAULT */
-	ret = finalize_log(&env->log, uattr, uattr_size);
+	ret = bpf_vlog_finalize(&env->log, &attr->btf_log_true_size);
 	if (ret)
 		err = ret;
 errout_free:
@@ -8017,12 +8002,12 @@ static int __btf_new_fd(struct btf *btf)
 	return anon_inode_getfd("btf", &btf_fops, btf, O_RDONLY | O_CLOEXEC);
 }
 
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+int btf_new_fd(union bpf_attr *attr, bpfptr_t uattr)
 {
 	struct btf *btf;
 	int ret;
 
-	btf = btf_parse(attr, uattr, uattr_size);
+	btf = btf_parse(attr, uattr);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ad565f569a4f..ce349a059d5d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5422,7 +5422,7 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 
 #define BPF_BTF_LOAD_LAST_FIELD btf_token_fd
 
-static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
+static int bpf_btf_load(union bpf_attr *attr, bpfptr_t uattr)
 {
 	struct bpf_token *token = NULL;
 
@@ -5449,7 +5449,7 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
 
 	bpf_token_put(token);
 
-	return btf_new_fd(attr, uattr, uattr_size);
+	return btf_new_fd(attr, uattr);
 }
 
 #define BPF_BTF_GET_FD_BY_ID_LAST_FIELD fd_by_id_token_fd
@@ -6211,6 +6211,16 @@ static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, un
 					      &attr->log_true_size);
 }
 
+static int copy_btf_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size)
+{
+	if (size >= offsetofend(union bpf_attr, btf_log_true_size) &&
+	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, btf_log_true_size),
+				  &attr->btf_log_true_size, sizeof(attr->btf_log_true_size)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		     bpfptr_t uattr_common, unsigned int size_common)
 {
@@ -6318,7 +6328,10 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_raw_tracepoint_open(&attr);
 		break;
 	case BPF_BTF_LOAD:
-		err = bpf_btf_load(&attr, uattr, size);
+		attr.btf_log_true_size = 0;
+		err = bpf_btf_load(&attr, uattr);
+		ret = copy_btf_load_log_true_size(&attr, uattr, size);
+		err = ret ? ret : err;
 		break;
 	case BPF_BTF_GET_FD_BY_ID:
 		err = bpf_btf_get_fd_by_id(&attr);
-- 
2.52.0


