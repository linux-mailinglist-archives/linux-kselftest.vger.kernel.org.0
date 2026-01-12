Return-Path: <linux-kselftest+bounces-48756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C8ED13885
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 16:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D071030D0A46
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995F12EB5A9;
	Mon, 12 Jan 2026 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fJCR4OAN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E02E8B78
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229963; cv=none; b=TedR21CoiYdKvpxFOlHQvNlYoiJ4Rj9zqZTJwTuNiTknw7eiZoZ0HII0u2KhWBv/W/GBe5zHXwgkIQAcjWv5HQYjasQKKRQt8TpGwo8P3LnDtVymfJ6lJD+eoIbAOX05ZGWPNQSAWf+SP8YN13GnGF0Q7RS9TjDwrmGBh6gqMkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229963; c=relaxed/simple;
	bh=RJ69CubqkwnPTdvwSZSH7PUSpEI4aL47uicaffDDgFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJhAufmI9BOwIn7hDL12ORZLLWciCTEkOmWa17IyydnjyALcv2SSGNbjLolJCvNhUAtMbQdZ++CAlwFTl1///LGxbaxIY2xEpHSvNctXi2ifeA7ZZ/ZNhhUJ3pZtyU0x49FsX9Mz9krJk9p7GR8/5W7lyWdP13oiZEIknIjDH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fJCR4OAN; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768229959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iR0SDBhL9jfzL+OidPPa2eVFyYTGzNy0iLhy6VQkwpw=;
	b=fJCR4OANpTBHpZV1r34K+34wgVjHVQ1jYXdt6X76Y+l7h6cn0/HonZKbZkBGXQKcpq2H63
	FeaWmCL5uYq5lJrStPa9Zjl/i05REi2Ocsqc1vvdNWaHX34Lfq3f2B/TLdhSHofjWsrkgB
	mxZrZ4CwR8rsvr0J4fGzBsKtcbB45Wg=
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
Subject: [PATCH bpf-next v5 6/9] bpf: Add syscall common attributes support for btf_load
Date: Mon, 12 Jan 2026 22:56:13 +0800
Message-ID: <20260112145616.44195-7-leon.hwang@linux.dev>
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

Since bpf_log_attr_init() now supports struct bpf_common_attr, pass the
common attributes to it to enable syscall common attributes support for
BPF_BTF_LOAD.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h | 3 ++-
 kernel/bpf/log.c             | 5 +++--
 kernel/bpf/syscall.c         | 8 +++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 44dd60de1966..9022e4f515f9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -642,7 +642,8 @@ struct bpf_log_attr {
 
 int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
 				struct bpf_attrs *attrs_common);
-int bpf_btf_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs);
+int bpf_btf_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
+			       struct bpf_attrs *attrs_common);
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log);
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 96df089a2c89..0dba014ca055 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -902,13 +902,14 @@ int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs
 				 offsetof(union bpf_attr, log_true_size), attrs_common);
 }
 
-int bpf_btf_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs)
+int bpf_btf_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
+			       struct bpf_attrs *attrs_common)
 {
 	const union bpf_attr *attr = attrs->attr;
 
 	return bpf_log_attr_init(log_attr, attrs, attr->btf_log_buf, attr->btf_log_size,
 				 attr->btf_log_level, offsetof(union bpf_attr, btf_log_true_size),
-				 NULL);
+				 attrs_common);
 }
 
 int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8382fafc8d17..d0440e640e40 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5433,7 +5433,8 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 
 #define BPF_BTF_LOAD_LAST_FIELD btf_token_fd
 
-static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
+static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size,
+			struct bpf_attrs *common_attrs)
 {
 	struct bpf_token *token = NULL;
 	struct bpf_log_attr log_attr;
@@ -5447,7 +5448,7 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
 		return -EINVAL;
 
 	bpf_attrs_init(&attrs, attr, uattr, uattr_size);
-	err = bpf_btf_load_log_attr_init(&log_attr, &attrs);
+	err = bpf_btf_load_log_attr_init(&log_attr, &attrs, common_attrs);
 	if (err)
 		return err;
 
@@ -6281,7 +6282,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_raw_tracepoint_open(&attr);
 		break;
 	case BPF_BTF_LOAD:
-		err = bpf_btf_load(&attr, uattr, size);
+		bpf_attrs_init(&common_attrs, &common_attr, uattr_common, size_common);
+		err = bpf_btf_load(&attr, uattr, size, &common_attrs);
 		break;
 	case BPF_BTF_GET_FD_BY_ID:
 		err = bpf_btf_get_fd_by_id(&attr);
-- 
2.52.0


