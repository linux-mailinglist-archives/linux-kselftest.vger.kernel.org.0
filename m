Return-Path: <linux-kselftest+bounces-48758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B25D5D137D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 16:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA4131943B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 15:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238CD2EC541;
	Mon, 12 Jan 2026 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iBxjoDSA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2352DE70C
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229981; cv=none; b=gIPBAScMc1WpluOvri3dQc1sPrjUGkPoi+h3T845xev3R0z46FRGUcC8Oo3ObsnyLV/uSEOZZnJ0JpZsYxyuqJ4fpJyVrATAHBfFV3fE0M1ArOerzBdDvMcRpVzOCqHbmz9FMQWucyb8aJCCOFs5yuH270L04wCO+zmCd/O1ftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229981; c=relaxed/simple;
	bh=fw3T6G9VgD08D+eTmDQTDZhpWeH/Grb134iPYg3VsZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpnXzUIR/xuEDM3UxTUYO2Y0FKCs5AO3x6d7wzO8sm0xhcOMEkZkJe7VVoWnJdVQJiU4vn1BtCRkrhBS4p6qEAyTijTLKAyxYUYdeHB1Ne9RLWirPTLrXxVFHUVf2LotPu2K8/kKTqMS/dzQ6qwCAj5r0gv62QizTb0OdR8rKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iBxjoDSA; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768229977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmcUogJQ7fcHKXe6kkOKsVPYN+oinZgv3uN1gDoQI10=;
	b=iBxjoDSAW+btQN4SHES8oKHE5Z18P/+D/U2gR7cJ+McdPMB7qH6DUH1CFGMAb+wSm5+HPk
	75bcI9Y22UdbFwBQ+oWAGvofo6vRuwDUeVEDp50+reLs9bELcUWGSnVpvWvHit2o0Uzufz
	GqOQc+9VBB94kGhCm5OA2Pql/dJ5dxg=
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
Subject: [PATCH bpf-next v5 8/9] libbpf: Add common attr support for map_create
Date: Mon, 12 Jan 2026 22:56:15 +0800
Message-ID: <20260112145616.44195-9-leon.hwang@linux.dev>
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

With the previous commit adding common attribute support for
BPF_MAP_CREATE, users can now retrieve detailed error messages when map
creation fails via the log_buf field.

Introduce struct bpf_syscall_common_attr_opts with the following fields:
log_buf, log_size, log_level, and log_true_size.

Extend bpf_map_create_opts with a new field common_attr_opts, allowing
users to capture and inspect log messages on map creation failures.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c | 15 ++++++++++++++-
 tools/lib/bpf/bpf.h | 17 ++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index d44e667aaf02..d65df1b7b2be 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -207,6 +207,9 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   const struct bpf_map_create_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
+	const size_t common_attr_sz = sizeof(struct bpf_common_attr);
+	struct bpf_syscall_common_attr_opts *common_attr_opts;
+	struct bpf_common_attr common_attr;
 	union bpf_attr attr;
 	int fd;
 
@@ -240,7 +243,17 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.excl_prog_hash = ptr_to_u64(OPTS_GET(opts, excl_prog_hash, NULL));
 	attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
 
-	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
+	common_attr_opts = OPTS_GET(opts, common_attr_opts, NULL);
+	if (common_attr_opts && feat_supported(NULL, FEAT_EXTENDED_SYSCALL)) {
+		memset(&common_attr, 0, common_attr_sz);
+		common_attr.log_buf = ptr_to_u64(OPTS_GET(common_attr_opts, log_buf, NULL));
+		common_attr.log_size = OPTS_GET(common_attr_opts, log_size, 0);
+		common_attr.log_level = OPTS_GET(common_attr_opts, log_level, 0);
+		fd = sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &common_attr, common_attr_sz);
+		OPTS_SET(common_attr_opts, log_true_size, common_attr.log_true_size);
+	} else {
+		fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
+	}
 	return libbpf_err_errno(fd);
 }
 
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 2c8e88ddb674..c4a26e6b71ea 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -37,6 +37,18 @@ extern "C" {
 
 LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
 
+struct bpf_syscall_common_attr_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+
+	char *log_buf;
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
+	struct bpf_syscall_common_attr_opts *common_attr_opts;
+
 	size_t :0;
 };
-#define bpf_map_create_opts__last_field excl_prog_hash_size
+#define bpf_map_create_opts__last_field common_attr_opts
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
-- 
2.52.0


