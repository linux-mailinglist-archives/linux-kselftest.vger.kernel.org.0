Return-Path: <linux-kselftest+bounces-48325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCCBCF9D0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 18:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4964F30139AE
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344B534DB7A;
	Tue,  6 Jan 2026 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t9Ap5Gi9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2993134DB59
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720070; cv=none; b=JWaClIegTh5jLPjX/oKZT4NPQMd1OWHW7YYK/W0rf2fYATfzrfhkwloNynbMarje8GTf4bcT5GoxFwP9BTY4Y7nlOG8RzbIi+yhae532ggmKuDhjo/IrpNGDdoC+Sj9QFAh/fp9P/lW9dKZviDEwa9hsC1d8XQ+TOkmk7363UJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720070; c=relaxed/simple;
	bh=qdZdan8Bg/3zMmLeA4fE/+22k8U9TKV55zGuSzKMjWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPKH0wIt2YLLlLUFbBTGDESD1TiBycjmgWjbHpWGcTWwRjsFruHrF+rJBZ4zt+Mfj5m0V23HuqesMNAkwR0z+LLhWpoNy63BlzfaE5XPkrz2rc4RtijqVJVGPU4C53m6pqYGlOvYSSI0mi908fwM4JSmXeJv+0A0m/+0dR04yls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t9Ap5Gi9; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767720065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=el+zFEiv5MlCth3d6SGPMrwMvtewF+0XV0F7CsdC9cM=;
	b=t9Ap5Gi9xp+auW0Bk3FclI8wYWxDTul6sjO24BmGqXJzJVxJuhAIddY9hDLV6YoNVJWu1Q
	i1Ee+p2HseJFBRIA5e0LT2JLW4uuGPTyIgYxs4/w7aieStTDrnsyRj6/5k/BNinD1tpM5R
	PvTvU9SZ+kYBOiPddh9bLE5Ap7IHoMI=
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
Subject: [RESEND PATCH bpf-next v4 2/9] libbpf: Add support for extended bpf syscall
Date: Wed,  7 Jan 2026 01:20:11 +0800
Message-ID: <20260106172018.57757-3-leon.hwang@linux.dev>
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

To support the extended BPF syscall introduced in the previous commit,
introduce the following internal APIs:

* 'sys_bpf_ext()'
* 'sys_bpf_ext_fd()'
  They wrap the raw 'syscall()' interface to support passing extended
  attributes.
* 'probe_sys_bpf_ext()'
  Check whether current kernel supports the extended attributes.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c             | 34 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/features.c        |  8 ++++++++
 tools/lib/bpf/libbpf_internal.h |  3 +++
 3 files changed, 45 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 21b57a629916..689ade4a822b 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -69,6 +69,40 @@ static inline __u64 ptr_to_u64(const void *ptr)
 	return (__u64) (unsigned long) ptr;
 }
 
+static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
+			      unsigned int size,
+			      struct bpf_common_attr *common_attrs,
+			      unsigned int size_common)
+{
+	cmd = common_attrs ? (cmd | BPF_COMMON_ATTRS) : (cmd & ~BPF_COMMON_ATTRS);
+	return syscall(__NR_bpf, cmd, attr, size, common_attrs, size_common);
+}
+
+static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *attr,
+				 unsigned int size,
+				 struct bpf_common_attr *common_attrs,
+				 unsigned int size_common)
+{
+	int fd;
+
+	fd = sys_bpf_ext(cmd, attr, size, common_attrs, size_common);
+	return ensure_good_fd(fd);
+}
+
+int probe_sys_bpf_ext(void)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
+	union bpf_attr attr;
+	int fd;
+
+	memset(&attr, 0, attr_sz);
+	fd = syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &attr, attr_sz, NULL,
+		     sizeof(struct bpf_common_attr));
+	if (fd >= 0)
+		close(fd);
+	return errno == EFAULT;
+}
+
 static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
 			  unsigned int size)
 {
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b842b83e2480..d786a815f1ae 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -506,6 +506,11 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 	return probe_fd(prog_fd);
 }
 
+static int probe_kern_extended_syscall(int token_fd)
+{
+	return probe_sys_bpf_ext();
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -581,6 +586,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_QMARK_DATASEC] = {
 		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
 	},
+	[FEAT_EXTENDED_SYSCALL] = {
+		"Kernel supports extended syscall", probe_kern_extended_syscall,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fc59b21b51b5..e2a6ef4b45ae 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -392,6 +392,8 @@ enum kern_feature_id {
 	FEAT_ARG_CTX_TAG,
 	/* Kernel supports '?' at the front of datasec names */
 	FEAT_BTF_QMARK_DATASEC,
+	/* Kernel supports extended syscall */
+	FEAT_EXTENDED_SYSCALL,
 	__FEAT_CNT,
 };
 
@@ -757,4 +759,5 @@ int probe_fd(int fd);
 #define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
 
 void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH]);
+int probe_sys_bpf_ext(void);
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.52.0


