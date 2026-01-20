Return-Path: <linux-kselftest+bounces-49535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM6gMALQb2mgMQAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49535-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 19:57:06 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F35649E3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 19:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 980677E884E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A647ECE4;
	Tue, 20 Jan 2026 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bFnEwaKJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB5C47ECCF
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922819; cv=none; b=SgJr+HLDthcWQGVRjhe0qyhTMLJJ2Fqf/3tY/9PGo06FKQaLwJo/c3Rv9VirfyK48gnDUWUBFGEirhAoAFLfI80Lxs+cbgK7hqPJGCaO0CwVz6mHYglAAnYVOuSXA/UA2ZcTLk2yEo55q4dQDLXv7gteH3rzMhgaxpK7SZQ2w68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922819; c=relaxed/simple;
	bh=2q2SEkkfrxkH3OZkUi9Nz55CcoTXPVq3gqGKPdlVM9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfihI8i+SWiAISwxp+a58qgkg2FU66AqxdyYTBwhRCciHA6e2UpXC+4EiN85W9ehwynMnlDT/2Y34p9RnwxpVXz2z307mBfk9g0iCruu4DsywgL3sQOMMpQ1jIosQgTKUk85f7hCqQcAQk4gT3D/DVPTfv7ujoSnKmL+iqX4NI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bFnEwaKJ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768922814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19zbvy4Zt6i873U2WoxF/NVlbngLiax1elyyFBOZ7cI=;
	b=bFnEwaKJ2ZRXxg90Hv2moNqFsQYYFlg/hzHy7BlLc3Hk6NWTgsQ997hX2E7ynoXHc+vsJL
	lUCH5OfURRucX840hvTjCnOryzp8I4dfaWPNqU5NyqfZloVzqcxJwAxFNNNV4xIIHE1mZ3
	oTLG5/Uh57N7JhkXLORhIhW8MMm6Tn0=
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
Subject: [RESEND PATCH bpf-next v6 8/9] libbpf: Add common attr support for map_create
Date: Tue, 20 Jan 2026 23:24:22 +0800
Message-ID: <20260120152424.40766-9-leon.hwang@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-49535-lists,linux-kselftest=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-kselftest@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-kselftest];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6F35649E3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With the previous commit adding common attribute support for
BPF_MAP_CREATE, users can now retrieve detailed error messages when map
creation fails via the log_buf field.

Introduce struct bpf_log_opts with the following fields:
log_buf, log_size, log_level, and log_true_size.

Extend bpf_map_create_opts with a new field log_opts, allowing users to
capture and inspect log messages on map creation failures.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c | 16 +++++++++++++++-
 tools/lib/bpf/bpf.h | 17 ++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ed9c6eaeb656..ac634d5ad4e6 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -205,6 +205,9 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   const struct bpf_map_create_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
+	const size_t attr_common_sz = sizeof(struct bpf_common_attr);
+	struct bpf_common_attr attr_common;
+	struct bpf_log_opts *log_opts;
 	union bpf_attr attr;
 	int fd;
 
@@ -238,7 +241,18 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.excl_prog_hash = ptr_to_u64(OPTS_GET(opts, excl_prog_hash, NULL));
 	attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
 
-	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
+	log_opts = OPTS_GET(opts, log_opts, NULL);
+	if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {
+		memset(&attr_common, 0, attr_common_sz);
+		attr_common.log_buf = ptr_to_u64(OPTS_GET(log_opts, log_buf, NULL));
+		attr_common.log_size = OPTS_GET(log_opts, log_size, 0);
+		attr_common.log_level = OPTS_GET(log_opts, log_level, 0);
+		fd = sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &attr_common, attr_common_sz);
+		OPTS_SET(log_opts, log_true_size, attr_common.log_true_size);
+	} else {
+		fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
+		OPTS_SET(log_opts, log_true_size, 0);
+	}
 	return libbpf_err_errno(fd);
 }
 
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 2c8e88ddb674..59673f094f86 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -37,6 +37,18 @@ extern "C" {
 
 LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
 
+struct bpf_log_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+
+	char *log_buf;
+	__u32 log_size;
+	__u32 log_level;
+	__u32 log_true_size;
+
+	size_t :0;
+};
+#define bpf_log_opts__last_field log_true_size
+
 struct bpf_map_create_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 
@@ -57,9 +69,12 @@ struct bpf_map_create_opts {
 
 	const void *excl_prog_hash;
 	__u32 excl_prog_hash_size;
+
+	struct bpf_log_opts *log_opts;
+
 	size_t :0;
 };
-#define bpf_map_create_opts__last_field excl_prog_hash_size
+#define bpf_map_create_opts__last_field log_opts
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
-- 
2.52.0


