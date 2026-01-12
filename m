Return-Path: <linux-kselftest+bounces-48754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A58CD13873
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 16:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6A373153161
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7837F2E1730;
	Mon, 12 Jan 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UnjiVaFF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0B2E0904
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229946; cv=none; b=W00RbOPLbMWyzq+ufk9v1T7yM0eOz6KSRpiKhAmLLSVhY2OSheVCMQ4Nt93nfdTo93z9kwpob06aqOAYyUuhZ8xBN1B2zwtnO0Qacsk27sCf+GxrCMBiTr12kLVTf+tv+7vbJGd6WIvtruQ1X/03fGfrKqu47zKoHymhPv8ocew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229946; c=relaxed/simple;
	bh=Sd6kjmcaCXlBqUaLAjclh0f3QiFQsnwhx468YsBIWmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgEEh6w54YZ3jRpRTuP5lTsq85yP9g3jdKG9oi/IUF1TBuVIxqFk/4NTYcNeO6LGXC3Ml2RDp8xq8BvsX5xmWCD4SKhxGLV5Dyh7XS2ZTcKBzq4eXm2IGekPLupwDTP2U81So6plCqbOeX8rlYb8GQxieYimYntU+Spi6djLq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UnjiVaFF; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768229939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDMsVM7/q+LG7mOV7x4BV2sDHWDr164LMBflINOkD7E=;
	b=UnjiVaFFOn09LuIKaDbn7dZo93lz0NAPEI/TfDPjmieEyQ/V3xPtS7vFi9tLuh/ON9Cbw+
	VSvZc4JqTc8cD5hcspSp9TjPGYnWfVbV/6s1h9nEuZLNGkOjQZ1Ugtuhq5KQ4ogYcucJYj
	shurTFX7QTIQ4dnY3ObY82qPxg2sE7I=
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
Subject: [PATCH bpf-next v5 4/9] bpf: Add syscall common attributes support for prog_load
Date: Mon, 12 Jan 2026 22:56:11 +0800
Message-ID: <20260112145616.44195-5-leon.hwang@linux.dev>
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

The log buffer of common attributes would be confusing with the one in
'union bpf_attr' for BPF_PROG_LOAD.

In order to clarify the usage of these two log buffers, they both can be
used for logging if:

* They are same, including 'log_buf', 'log_level' and 'log_size'.
* One of them is missing, then another one will be used for logging.

If they both have 'log_buf' but they are not same totally, return -EUSERS.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h |  4 +++-
 kernel/bpf/log.c             | 29 ++++++++++++++++++++++++++---
 kernel/bpf/syscall.c         |  9 ++++++---
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4c9632c40059..da2d37ca60e7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -637,9 +637,11 @@ struct bpf_log_attr {
 	u32 log_level;
 	struct bpf_attrs *attrs;
 	u32 offsetof_log_true_size;
+	struct bpf_attrs *attrs_common;
 };
 
-int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs);
+int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
+				struct bpf_attrs *attrs_common);
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log);
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 457b724c4176..eba60a13e244 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -865,23 +865,41 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
 }
 
 static int bpf_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs, u64 log_buf,
-			     u32 log_size, u32 log_level, int offsetof_log_true_size)
+			     u32 log_size, u32 log_level, int offsetof_log_true_size,
+			     struct bpf_attrs *attrs_common)
 {
+	const struct bpf_common_attr *common_attr = attrs_common ? attrs_common->attr : NULL;
+
 	memset(log_attr, 0, sizeof(*log_attr));
 	log_attr->log_buf = log_buf;
 	log_attr->log_size = log_size;
 	log_attr->log_level = log_level;
 	log_attr->attrs = attrs;
 	log_attr->offsetof_log_true_size = offsetof_log_true_size;
+	log_attr->attrs_common = attrs_common;
+
+	if (log_buf && common_attr && common_attr->log_buf &&
+		(log_buf != common_attr->log_buf ||
+		 log_size != common_attr->log_size ||
+		 log_level != common_attr->log_level))
+		return -EUSERS;
+
+	if (!log_buf && common_attr && common_attr->log_buf) {
+		log_attr->log_buf = common_attr->log_buf;
+		log_attr->log_size = common_attr->log_size;
+		log_attr->log_level = common_attr->log_level;
+	}
+
 	return 0;
 }
 
-int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs)
+int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
+				struct bpf_attrs *attrs_common)
 {
 	const union bpf_attr *attr = attrs->attr;
 
 	return bpf_log_attr_init(log_attr, attrs, attr->log_buf, attr->log_size, attr->log_level,
-				 offsetof(union bpf_attr, log_true_size));
+				 offsetof(union bpf_attr, log_true_size), attrs_common);
 }
 
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log)
@@ -901,5 +919,10 @@ int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log
 	    copy_to_bpfptr_offset(log_attr->attrs->uattr, off, &log_true_size, size))
 		err = -EFAULT;
 
+	off = offsetof(struct bpf_common_attr, log_true_size);
+	if (log_attr->attrs_common && log_attr->attrs_common->size >= off + size &&
+	    copy_to_bpfptr_offset(log_attr->attrs_common->uattr, off, &log_true_size, size))
+		err = -EFAULT;
+
 	return err;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0b389bc6add8..f369b9ec9d60 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2865,7 +2865,8 @@ static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD keyring_id
 
-static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
+static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size,
+			 struct bpf_attrs *common_attrs)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
@@ -3085,7 +3086,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		goto free_prog_sec;
 
 	bpf_attrs_init(&attrs, attr, uattr, uattr_size);
-	err = bpf_prog_load_log_attr_init(&log_attr, &attrs);
+	err = bpf_prog_load_log_attr_init(&log_attr, &attrs, common_attrs);
 	if (err < 0)
 		goto free_used_maps;
 
@@ -6174,6 +6175,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		     bpfptr_t uattr_common, unsigned int size_common)
 {
 	struct bpf_common_attr common_attr;
+	struct bpf_attrs common_attrs;
 	union bpf_attr attr;
 	int err;
 
@@ -6225,7 +6227,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = map_freeze(&attr);
 		break;
 	case BPF_PROG_LOAD:
-		err = bpf_prog_load(&attr, uattr, size);
+		bpf_attrs_init(&common_attrs, &common_attr, uattr_common, size_common);
+		err = bpf_prog_load(&attr, uattr, size, &common_attrs);
 		break;
 	case BPF_OBJ_PIN:
 		err = bpf_obj_pin(&attr);
-- 
2.52.0


