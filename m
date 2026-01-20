Return-Path: <linux-kselftest+bounces-49532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB/RF/qyb2nHMAAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49532-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:53:14 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4724800F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF601984FF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5204E478E5B;
	Tue, 20 Jan 2026 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cgaFzGjl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5B478E40
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922792; cv=none; b=PrwldD/Qj8erUFPnW8HRsZY7ceFXzwRte2dstfvibcYTW+VFX+UvNvGtByH5yyKXek1T2xPpR/x9mU7ROb41GqLMJJsMQVBZjW66EFcqNppsFdKKa/ZCsRAIJ5/McfHGxoS1TR9QyNKVcd8oi/29iHxxKsx7oLkkFET+U1ap+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922792; c=relaxed/simple;
	bh=lKBzSEvfKa+hbl6pPZPAl/T54HivVrqxlBupRf7OxtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UceI9qhfja3QUg0ipmBM7jq0vMA5AVEA6uoxioi1fb7lSf4ZiuQXgYNtI4RmBZUQ30qWRPR1otqSUllEs2bmNuR1Q+VRsE2gosNTXAq+0LsPTd4xglbcmbnnsaiSa47M1Q6QP/YXK7/bgP6PVxd5s8E7oynRSIGUQSqYC5Iple4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cgaFzGjl; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768922788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhSShlgFfOlt6UZSxrUlrroIW1ygFWUa+mZ6ZbxgiDU=;
	b=cgaFzGjl03hUz6tqXa3q87dzZc6GNiEU+JJ4NP8Q7I8Qhm0dI5TLy8qALNk6jWJ2YYJ6iK
	Z7G14NHTTZDpmUqehKKtS1n2Ev/mLIWnbCPKorZ9Ywvwf14YNMEZEyMH1kHU2/iAzZ/xLB
	uUXs2uenfJZYu4TE9jN3ml6rZp+ifXw=
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
Subject: [RESEND PATCH bpf-next v6 5/9] bpf: Refactor reporting btf_log_true_size for btf_load
Date: Tue, 20 Jan 2026 23:24:19 +0800
Message-ID: <20260120152424.40766-6-leon.hwang@linux.dev>
In-Reply-To: <20260120152424.40766-1-leon.hwang@linux.dev>
References: <20260120152424.40766-1-leon.hwang@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-49532-lists,linux-kselftest=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-kselftest@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-kselftest];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: EF4724800F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 78dc79810c7d..4adc6b11a0fd 100644
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
index 364dd84bfc5a..e9ae87ddd6d6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5856,25 +5856,11 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
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
@@ -5891,8 +5877,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	/* user could have requested verbose verifier output
 	 * and supplied buffer to store the verification trace
 	 */
-	err = bpf_vlog_init(&env->log, attr->btf_log_level,
-			    log_ubuf, attr->btf_log_size);
+	err = bpf_vlog_init(&env->log, log_attr->log_level,
+			    log_ubuf, log_attr->log_size);
 	if (err)
 		goto errout_free;
 
@@ -5953,7 +5939,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		}
 	}
 
-	err = finalize_log(&env->log, uattr, uattr_size);
+	err = bpf_log_attr_finalize(log_attr, &env->log);
 	if (err)
 		goto errout_free;
 
@@ -5965,7 +5951,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	btf_free_struct_meta_tab(btf);
 errout:
 	/* overwrite err with -ENOSPC or -EFAULT */
-	ret = finalize_log(&env->log, uattr, uattr_size);
+	ret = bpf_log_attr_finalize(log_attr, &env->log);
 	if (ret)
 		err = ret;
 errout_free:
@@ -8134,12 +8120,12 @@ static int __btf_new_fd(struct btf *btf)
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
index c0b816e84384..f1ed24157d71 100644
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
index ea59cd178dcf..8434d7937fb9 100644
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


