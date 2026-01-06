Return-Path: <linux-kselftest+bounces-48331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD35CFA6A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 20:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A90DE32C1704
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 18:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DD93502BA;
	Tue,  6 Jan 2026 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A3x0HJVr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A13502AA
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720127; cv=none; b=AoPVCjW3AtnnDwNL9r9olzgflEsIQ5l2sOKEfMTMsYSxvM0iOnWqDBn2W7rJh3bosKZ7PoSef2WcIx+GkJaVY5ePs4OBbnEdBLVz5nIpUcu3uyumZBmp1AE2zsJvBLAXMdkAKxER7P3rbSyCbNLDXWXywgVnNSNmGOjtiGGZLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720127; c=relaxed/simple;
	bh=HxI4+nzQuzg70aSRlSj9KKaRq21uALuyDmmimZAfIfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+2VRaODYNanfnqK/++QhzKgx+KOW3YLLiEmegGYcPIywVMDX387JGXpGBVEapUPVSoLSJhY899Hc8zJOmSafuK7RHuaXpFy+/pEOInsb3Of5kV2Km7ws75gLUpAVKCteRrGsB51up4Tw/rLpCqvU61yS+3PYBQ4M3fawrQHmUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A3x0HJVr; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767720123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSPAXTe59AXqGHWDQ1uMbUsQxBwsOMvl1BeG421F/78=;
	b=A3x0HJVrxScEAlTcSIG2ScmXBWFPoL8hCdG9KeFsqmeMKN4ms+ZAsaB9T5hSD/DJfMS2/P
	+ElCGOriVYdSUPvMfdh2oPLuohKcw8t7dN47czjtJA3obQovjwklGy8PsyCg6f/HjpydsI
	LLAT0bxLCCpF8rhkx2rLuSLMmkFUaWg=
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
Subject: [RESEND PATCH bpf-next v4 8/9] libbpf: Add common attr support for map_create
Date: Wed,  7 Jan 2026 01:20:17 +0800
Message-ID: <20260106172018.57757-9-leon.hwang@linux.dev>
In-Reply-To: <20260106172018.57757-1-leon.hwang@linux.dev>
References: <20260106172018.57757-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

With the previous commit adding common attribute support for
BPF_MAP_CREATE, it is now possible to retrieve detailed error messages
when map creation fails by using the 'log_buf' field from the common
attributes.

Introduce a new struct bpf_syscall_common_attr_opts, which wraps these
new fields, 'log_buf', 'log_size', 'log_level', and 'log_true_size'.

Extend 'bpf_map_create_opts' with a new field, 'cattr_opts', allowing
users to capture and inspect those log messages.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c | 15 ++++++++++++++-
 tools/lib/bpf/bpf.h | 17 ++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 689ade4a822b..4a1ba4951785 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -207,6 +207,9 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   const struct bpf_map_create_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
+	const size_t common_attrs_sz = sizeof(struct bpf_common_attr);
+	struct bpf_syscall_common_attr_opts *cattr_opts;
+	struct bpf_common_attr common_attrs;
 	union bpf_attr attr;
 	int fd;
 
@@ -240,7 +243,17 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.excl_prog_hash = ptr_to_u64(OPTS_GET(opts, excl_prog_hash, NULL));
 	attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
 
-	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
+	cattr_opts = OPTS_GET(opts, cattr_opts, NULL);
+	if (cattr_opts && feat_supported(NULL, FEAT_EXTENDED_SYSCALL)) {
+		memset(&common_attrs, 0, common_attrs_sz);
+		common_attrs.log_buf = ptr_to_u64(OPTS_GET(cattr_opts, log_buf, NULL));
+		common_attrs.log_size = OPTS_GET(cattr_opts, log_size, 0);
+		common_attrs.log_level = OPTS_GET(cattr_opts, log_level, 0);
+		fd = sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &common_attrs, common_attrs_sz);
+		OPTS_SET(cattr_opts, log_true_size, common_attrs.log_true_size);
+	} else {
+		fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
+	}
 	return libbpf_err_errno(fd);
 }
 
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 1f9c28d27795..6f544c205b89 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -37,6 +37,18 @@ extern "C" {
 
 LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
 
+struct bpf_syscall_common_attr_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+
+	const char *log_buf;
+	__u32 log_size;
+	__u32 log_level;
+	__u32 log_true_size;
+
+	size_t :0;
+};
+#define bpf_syscall_common_attr_opts__last_field log_true_size
+
 struct bpf_map_create_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 
@@ -57,9 +69,12 @@ struct bpf_map_create_opts {
 
 	const void *excl_prog_hash;
 	__u32 excl_prog_hash_size;
+
+	struct bpf_syscall_common_attr_opts *cattr_opts;
+
 	size_t :0;
 };
-#define bpf_map_create_opts__last_field excl_prog_hash_size
+#define bpf_map_create_opts__last_field cattr_opts
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
-- 
2.52.0


