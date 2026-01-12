Return-Path: <linux-kselftest+bounces-48755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E291D13810
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 16:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4FA9316FF6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75BB2DC763;
	Mon, 12 Jan 2026 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mt+qrUmj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140F2E091E
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229955; cv=none; b=Nj700BJwhGHjwLFDft94ThJksFQIrQlF1iUj44CFUuZ6NlrwJpUynu5j7OnZpEENQmhO4jM3QGihopY9kU0E/qYDW2LJfXlXbsoucU1zBrFyYb6aBhx+o/YIRqdt1iHCbTI6z9RcAUpbnqgmbp8i6AfBooV88r5SjeizmIaR6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229955; c=relaxed/simple;
	bh=7KXRc2CPo5R7WqqLbsYR32686LIhOaGHHI4dXdHHvIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGW9gz4exb3nGVje172KK1wc5cKn5100Z3qzvyVOZIcFOwRMzyyE921jHOgw8vVt66mpnOQ5kKwfFHX5ppgVXpLWGNgmWjceWYALU8BxF5HODOidZx+NrlJQSlOGYQfsKYoED354kOcRKzNonBUoKCV4IlCR6V9zoh5UIGoHd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mt+qrUmj; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768229950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9bAE5VHgJac+9iB52cOfOcxuqsa3+EmmJ4s1s/9YAw=;
	b=Mt+qrUmjkOTzVkso4xQQ98zYX2L0DAu/HoLA4bdDEGbazHs11hv7uu3xTkRpt1dqWMlbAR
	zehdLvIOBveKk3IJG8ltX8ZRMsNOFrJhCQtHt+aoQGwtvZkrOl5gMZKI94aOQlyWclecyl
	lM6jeEvYJ94K2A7QlTXP4OO80bHhntg=
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
Subject: [PATCH bpf-next v5 5/9] bpf: Refactor reporting btf_log_true_size for btf_load
Date: Mon, 12 Jan 2026 22:56:12 +0800
Message-ID: <20260112145616.44195-6-leon.hwang@linux.dev>
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

In the next commit, it will be able to report logs via extended common
attributes, which will report 'log_true_size' via the extended common
attributes meanwhile.

Therefore, refactor the way of 'btf_log_true_size' reporting in order to
report 'log_true_size' via the extended common attributes easily.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h |  1 +
 include/linux/btf.h          |  3 ++-
 kernel/bpf/btf.c             | 32 +++++++++-----------------------
 kernel/bpf/log.c             |  9 +++++++++
 kernel/bpf/syscall.c         | 10 +++++++++-
 5 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index da2d37ca60e7..44dd60de1966 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -642,6 +642,7 @@ struct bpf_log_attr {
 
 int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
 				struct bpf_attrs *attrs_common);
+int bpf_btf_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs);
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log);
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 691f09784933..df04843a4635 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -144,7 +144,8 @@ const char *btf_get_name(const struct btf *btf);
 void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
 const struct btf_header *btf_header(const struct btf *btf);
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
+struct bpf_log_attr;
+int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_attr *log_attr);
 struct btf *btf_get_by_fd(int fd);
 int btf_get_info_by_fd(const struct btf *btf,
 		       const union bpf_attr *attr,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 539c9fdea41d..f9973f12a482 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5745,25 +5745,11 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
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
+static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr,
+			     struct bpf_log_attr *log_attr)
 {
 	bpfptr_t btf_data = make_bpfptr(attr->btf, uattr.is_kernel);
-	char __user *log_ubuf = u64_to_user_ptr(attr->btf_log_buf);
+	char __user *log_ubuf = u64_to_user_ptr(log_attr->log_buf);
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_verifier_env *env = NULL;
 	struct btf *btf = NULL;
@@ -5780,8 +5766,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
 	 */
-	err = bpf_vlog_init(&env->log, attr->btf_log_level,
-			    log_ubuf, attr->btf_log_size);
+	err = bpf_vlog_init(&env->log, log_attr->log_level,
+			    log_ubuf, log_attr->log_size);
 	if (err)
 		goto errout_free;
 
@@ -5841,7 +5827,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		}
 	}
 
-	err = finalize_log(&env->log, uattr, uattr_size);
+	err = bpf_log_attr_finalize(log_attr, &env->log);
 	if (err)
 		goto errout_free;
 
@@ -5853,7 +5839,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	btf_free_struct_meta_tab(btf);
 errout:
 	/* overwrite err with -ENOSPC or -EFAULT */
-	ret = finalize_log(&env->log, uattr, uattr_size);
+	ret = bpf_log_attr_finalize(log_attr, &env->log);
 	if (ret)
 		err = ret;
 errout_free:
@@ -8017,12 +8003,12 @@ static int __btf_new_fd(struct btf *btf)
 	return anon_inode_getfd("btf", &btf_fops, btf, O_RDONLY | O_CLOEXEC);
 }
 
-int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_attr *log_attr)
 {
 	struct btf *btf;
 	int ret;
 
-	btf = btf_parse(attr, uattr, uattr_size);
+	btf = btf_parse(attr, uattr, log_attr);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
 
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index eba60a13e244..96df089a2c89 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -902,6 +902,15 @@ int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs
 				 offsetof(union bpf_attr, log_true_size), attrs_common);
 }
 
+int bpf_btf_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs)
+{
+	const union bpf_attr *attr = attrs->attr;
+
+	return bpf_log_attr_init(log_attr, attrs, attr->btf_log_buf, attr->btf_log_size,
+				 attr->btf_log_level, offsetof(union bpf_attr, btf_log_true_size),
+				 NULL);
+}
+
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log)
 {
 	u32 log_true_size, off;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f369b9ec9d60..8382fafc8d17 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5436,6 +5436,9 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	struct bpf_token *token = NULL;
+	struct bpf_log_attr log_attr;
+	struct bpf_attrs attrs;
+	int err;
 
 	if (CHECK_ATTR(BPF_BTF_LOAD))
 		return -EINVAL;
@@ -5443,6 +5446,11 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
 	if (attr->btf_flags & ~BPF_F_TOKEN_FD)
 		return -EINVAL;
 
+	bpf_attrs_init(&attrs, attr, uattr, uattr_size);
+	err = bpf_btf_load_log_attr_init(&log_attr, &attrs);
+	if (err)
+		return err;
+
 	if (attr->btf_flags & BPF_F_TOKEN_FD) {
 		token = bpf_token_get_from_fd(attr->btf_token_fd);
 		if (IS_ERR(token))
@@ -5460,7 +5468,7 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
 
 	bpf_token_put(token);
 
-	return btf_new_fd(attr, uattr, uattr_size);
+	return btf_new_fd(attr, uattr, &log_attr);
 }
 
 #define BPF_BTF_GET_FD_BY_ID_LAST_FIELD fd_by_id_token_fd
-- 
2.52.0


