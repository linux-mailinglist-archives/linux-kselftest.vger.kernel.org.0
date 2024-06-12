Return-Path: <linux-kselftest+bounces-11776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 295169057F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F831C22C94
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45681186280;
	Wed, 12 Jun 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="heEPGeb1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R7g1Moal"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD21850AE;
	Wed, 12 Jun 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207973; cv=none; b=TXE9yGwsVxQ6lAJJhg0aiAQ/7BTlSDj4GFGwYtrAOnkq62jtWyIIlHhWvZT8MbU2Ua3xctO7V37LjuGAy46jvvdQWMv36s/Mpue9i4J16gdfIDfhM8JNt82ygnLf24SqM2VbwYCgbU/UTpFHIxRM0NwYE1CB9CKsh5MRvKFCXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207973; c=relaxed/simple;
	bh=C6rJhEn0gp83fGV2MC+OyP4IQ1MB6Tm2BOWMOOuJk0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bx5hhqigz8gY3zS9ZAKI9ksyloMdAPTDBtSxJhwrHE7V1i5/DpW9EyklPURZNdVStuJvld3rEEXwVvEjIuITbyA+t48Wy2M4eb/eBfA94XvoJhb+CnIYIXmFVwRXd/JMe/Eh+hjbcXRiYP2UVgRVER/7o4mq0beJy1EvMv4NSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=heEPGeb1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R7g1Moal; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id C8AD01800131;
	Wed, 12 Jun 2024 11:59:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 11:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718207966; x=
	1718294366; bh=mDNhcPjh4Zc+yh1vclSY0DSfRRUTbyFsMgy/R7mjUUc=; b=h
	eEPGeb17zFEABrUnKSfSjn3KKC3v1/qOZYMnu8/wJybzZ+DvuW473SLLzq2vKGCO
	7OL52FsOe63n5qfgh4PxRDIuj/SZIz0dSCfLhjdI2IBsPLIifARcXvgZt4lX5KkH
	U2xGFzNLhbOjGTBF+/lcgAMM6Xg02MbsmUBAbSNdLhdXmWZntIvsPh5DiAeAU2ys
	aaUHmIHQ8knGCLpIToXdPxpMnp3SfH2kIFqp9oo1jmCD2GeslqJIsNteLWDs27mr
	VlXloxFH8+fJuOUMR00h+w/okB20RCHn8LHEg3ce9knQ5rdRl7UOmGv6PqBLiiwj
	iyHRl1ciWUTGy+A1vAX3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718207966; x=
	1718294366; bh=mDNhcPjh4Zc+yh1vclSY0DSfRRUTbyFsMgy/R7mjUUc=; b=R
	7g1MoalzRceR+okc/68pFjl+2d22tx439MEh+5ryXbZ3IYs+bqodMjuR1bI5ClsO
	abvZyct9mEWL1uL5l/WTJroXUlCwk2S8I+2/YZ3oz1MW8kpBakIv02CgOfjdYoOI
	FtGFA6DfMcW99Fvzlxa3L4CRvoPuJ/JQInD+VYeV6XaMftLmHDJYr/2bSA0WCFal
	2qbgg9P6mXIF1c3DwiR1At2frmTUotc04DfF0F3ENolX7h0xazzp5s9PEIV7F27v
	ZjOiVqy30s2upliYr8oWcoGvAZY/jFZoaxB4nQgkZdKzdPr6Kkg1hlURsvaiVZ0F
	VrtHhAu+VY1UEo0JKAeSw==
X-ME-Sender: <xms:3sVpZpjVT7ImqZB4FjjQOVmYYMg6UlM64Kym3oWqMNvElcta5PeOWA>
    <xme:3sVpZuCd-qWAgJCS843Oc76-P_FR2wKrYDFn-r7bxrROiaSR7P6APvcup8zUO6AQ4
    rWllPzwFQCg7YFKtA>
X-ME-Received: <xmr:3sVpZpHQbJeKvOjDQ8EdrVtWItaL4tLuGyqhK3dwMMV69qRIoyBzJ99DiOlTEGPIAxyeynfxAvHX_a1v_N9SyLALN9aPF5bLtdKpYZRO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:3sVpZuR_RoUUTmJK6z6uvCaeUskfTGlVp7MU9EpaZbPjnJAs9L7mHQ>
    <xmx:3sVpZmwQX_DoWZhExy0rBD-7I5qK3S-u-XH9HzMg_G8qbtNygX9ZiQ>
    <xmx:3sVpZk6isQ2kQTtli0Pd3WnbK-L0ryB_v_KorXdnhB9da4tduSfQAA>
    <xmx:3sVpZrzA-SKjYAEMGMb54c8hkxdkqL-Lsvme2FMuk3LRFXodS3Qygg>
    <xmx:3sVpZjSIVv9yuUdO7bHDbnvbOTEvAOJf14qIOpNedp6Q5ODMU_dath-0>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 11:59:24 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: kuba@kernel.org,
	tytso@mit.edu,
	andrii@kernel.org,
	ebiggers@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	mhiramat@kernel.org,
	martin.lau@linux.dev,
	vadim.fedorenko@linux.dev,
	hawk@kernel.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	edumazet@google.com,
	song@kernel.org,
	eddyz87@gmail.com,
	rostedt@goodmis.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mathieu.desnoyers@efficios.com,
	mykolal@fb.com,
	fsverity@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 09/12] bpf: treewide: Align kfunc signatures to prog point-of-view
Date: Wed, 12 Jun 2024 09:58:33 -0600
Message-ID: <b58346a63a0e66bc9b7504da751b526b0b189a67.1718207789.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718207789.git.dxu@dxuuu.xyz>
References: <cover.1718207789.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, kfunc declarations in bpf_kfuncs.h (and others) used "user
facing" types for kfuncs prototypes while the actual kfunc definitions
used "kernel facing" types. More specifically: bpf_dynptr vs
bpf_dynptr_kern, __sk_buff vs sk_buff, and xdp_md vs xdp_buff.

It wasn't an issue before, as the verifier allows aliased types.
However, since we are now generating kfunc prototypes in vmlinux.h (in
addition to keeping bpf_kfuncs.h around), this conflict creates
compilation errors.

Fix this conflict by using "user facing" types in kfunc definitions.
This results in more casts, but otherwise has no additional runtime
cost.

Note, similar to 5b268d1ebcdc ("bpf: Have bpf_rdonly_cast() take a const
pointer"), we also make kfuncs take const arguments where appropriate in
order to make the kfunc more permissive.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 fs/verity/measure.c                           |  5 ++-
 include/linux/bpf.h                           |  8 ++--
 kernel/bpf/crypto.c                           | 24 ++++++++----
 kernel/bpf/helpers.c                          | 39 +++++++++++++------
 kernel/bpf/verifier.c                         |  2 +-
 kernel/trace/bpf_trace.c                      | 15 ++++---
 net/core/filter.c                             | 32 +++++++++------
 .../selftests/bpf/progs/ip_check_defrag.c     | 10 ++---
 .../bpf/progs/verifier_netfilter_ctx.c        |  6 +--
 9 files changed, 88 insertions(+), 53 deletions(-)

diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index 3969d54158d1..175d2f1bc089 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -111,14 +111,15 @@ __bpf_kfunc_start_defs();
 /**
  * bpf_get_fsverity_digest: read fsverity digest of file
  * @file: file to get digest from
- * @digest_ptr: (out) dynptr for struct fsverity_digest
+ * @digest_p: (out) dynptr for struct fsverity_digest
  *
  * Read fsverity_digest of *file* into *digest_ptr*.
  *
  * Return: 0 on success, a negative value on error.
  */
-__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr_kern *digest_ptr)
+__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr *digest_p)
 {
+	struct bpf_dynptr_kern *digest_ptr = (struct bpf_dynptr_kern *)digest_p;
 	const struct inode *inode = file_inode(file);
 	u32 dynptr_sz = __bpf_dynptr_size(digest_ptr);
 	struct fsverity_digest *arg;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a834f4b761bc..f636b4998bf7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3265,8 +3265,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 				struct bpf_insn *insn_buf,
 				struct bpf_prog *prog,
 				u32 *target_size);
-int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
-			       struct bpf_dynptr_kern *ptr);
+int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
+			       struct bpf_dynptr *ptr);
 #else
 static inline bool bpf_sock_common_is_valid_access(int off, int size,
 						   enum bpf_access_type type,
@@ -3288,8 +3288,8 @@ static inline u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 {
 	return 0;
 }
-static inline int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
-					     struct bpf_dynptr_kern *ptr)
+static inline int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
+					     struct bpf_dynptr *ptr)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 2bee4af91e38..3c1de0e5c0bd 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -311,11 +311,15 @@ static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
  * Decrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
  */
 __bpf_kfunc int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx,
-				   const struct bpf_dynptr_kern *src,
-				   const struct bpf_dynptr_kern *dst,
-				   const struct bpf_dynptr_kern *siv)
+				   const struct bpf_dynptr *src,
+				   const struct bpf_dynptr *dst,
+				   const struct bpf_dynptr *siv)
 {
-	return bpf_crypto_crypt(ctx, src, dst, siv, true);
+	const struct bpf_dynptr_kern *src_kern = (struct bpf_dynptr_kern *)src;
+	const struct bpf_dynptr_kern *dst_kern = (struct bpf_dynptr_kern *)dst;
+	const struct bpf_dynptr_kern *siv_kern = (struct bpf_dynptr_kern *)siv;
+
+	return bpf_crypto_crypt(ctx, src_kern, dst_kern, siv_kern, true);
 }
 
 /**
@@ -328,11 +332,15 @@ __bpf_kfunc int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx,
  * Encrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
  */
 __bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
-				   const struct bpf_dynptr_kern *src,
-				   const struct bpf_dynptr_kern *dst,
-				   const struct bpf_dynptr_kern *siv)
+				   const struct bpf_dynptr *src,
+				   const struct bpf_dynptr *dst,
+				   const struct bpf_dynptr *siv)
 {
-	return bpf_crypto_crypt(ctx, src, dst, siv, false);
+	const struct bpf_dynptr_kern *src_kern = (struct bpf_dynptr_kern *)src;
+	const struct bpf_dynptr_kern *dst_kern = (struct bpf_dynptr_kern *)dst;
+	const struct bpf_dynptr_kern *siv_kern = (struct bpf_dynptr_kern *)siv;
+
+	return bpf_crypto_crypt(ctx, src_kern, dst_kern, siv_kern, false);
 }
 
 __bpf_kfunc_end_defs();
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6f1abcb4b084..3ac521c48bba 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2459,9 +2459,10 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
  * provided buffer, with its contents containing the data, if unable to obtain
  * direct pointer)
  */
-__bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
+__bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 				   void *buffer__opt, u32 buffer__szk)
 {
+	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 	enum bpf_dynptr_type type;
 	u32 len = buffer__szk;
 	int err;
@@ -2543,9 +2544,11 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
  * provided buffer, with its contents containing the data, if unable to obtain
  * direct pointer)
  */
-__bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
+__bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 offset,
 					void *buffer__opt, u32 buffer__szk)
 {
+	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+
 	if (!ptr->data || __bpf_dynptr_is_rdonly(ptr))
 		return NULL;
 
@@ -2571,11 +2574,12 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 o
 	 * will be copied out into the buffer and the user will need to call
 	 * bpf_dynptr_write() to commit changes.
 	 */
-	return bpf_dynptr_slice(ptr, offset, buffer__opt, buffer__szk);
+	return bpf_dynptr_slice(p, offset, buffer__opt, buffer__szk);
 }
 
-__bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end)
+__bpf_kfunc int bpf_dynptr_adjust(const struct bpf_dynptr *p, u32 start, u32 end)
 {
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 	u32 size;
 
 	if (!ptr->data || start > end)
@@ -2592,36 +2596,45 @@ __bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 en
 	return 0;
 }
 
-__bpf_kfunc bool bpf_dynptr_is_null(struct bpf_dynptr_kern *ptr)
+__bpf_kfunc bool bpf_dynptr_is_null(const struct bpf_dynptr *p)
 {
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+
 	return !ptr->data;
 }
 
-__bpf_kfunc bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
+__bpf_kfunc bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *p)
 {
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+
 	if (!ptr->data)
 		return false;
 
 	return __bpf_dynptr_is_rdonly(ptr);
 }
 
-__bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
+__bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr *p)
 {
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+
 	if (!ptr->data)
 		return -EINVAL;
 
 	return __bpf_dynptr_size(ptr);
 }
 
-__bpf_kfunc int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr,
-				 struct bpf_dynptr_kern *clone__uninit)
+__bpf_kfunc int bpf_dynptr_clone(const struct bpf_dynptr *p,
+				 struct bpf_dynptr *clone__uninit)
 {
+	struct bpf_dynptr_kern *clone = (struct bpf_dynptr_kern *)clone__uninit;
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+
 	if (!ptr->data) {
-		bpf_dynptr_set_null(clone__uninit);
+		bpf_dynptr_set_null(clone);
 		return -EINVAL;
 	}
 
-	*clone__uninit = *ptr;
+	*clone = *ptr;
 
 	return 0;
 }
@@ -2986,7 +2999,9 @@ late_initcall(kfunc_init);
  */
 const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len)
 {
-	return bpf_dynptr_slice(ptr, 0, NULL, len);
+	const struct bpf_dynptr *p = (struct bpf_dynptr *)ptr;
+
+	return bpf_dynptr_slice(p, 0, NULL, len);
 }
 
 /* Get a pointer to dynptr data up to len bytes for read write access. If
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dcac6119d810..acc9dd830807 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10914,7 +10914,7 @@ enum {
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
-BTF_ID(struct, bpf_dynptr_kern)
+BTF_ID(struct, bpf_dynptr)
 BTF_ID(struct, bpf_list_head)
 BTF_ID(struct, bpf_list_node)
 BTF_ID(struct, bpf_rb_root)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bc16e21a2a44..4b3fda456299 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1369,8 +1369,8 @@ __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
 /**
  * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
- * @data_ptr: data to verify
- * @sig_ptr: signature of the data
+ * @data_p: data to verify
+ * @sig_p: signature of the data
  * @trusted_keyring: keyring with keys trusted for signature verification
  *
  * Verify the PKCS#7 signature *sig_ptr* against the supplied *data_ptr*
@@ -1378,10 +1378,12 @@ __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
  *
  * Return: 0 on success, a negative value on error.
  */
-__bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
-			       struct bpf_dynptr_kern *sig_ptr,
+__bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
+			       struct bpf_dynptr *sig_p,
 			       struct bpf_key *trusted_keyring)
 {
+	struct bpf_dynptr_kern *data_ptr = (struct bpf_dynptr_kern *)data_p;
+	struct bpf_dynptr_kern *sig_ptr = (struct bpf_dynptr_kern *)sig_p;
 	const void *data, *sig;
 	u32 data_len, sig_len;
 	int ret;
@@ -1444,7 +1446,7 @@ __bpf_kfunc_start_defs();
  * bpf_get_file_xattr - get xattr of a file
  * @file: file to get xattr from
  * @name__str: name of the xattr
- * @value_ptr: output buffer of the xattr value
+ * @value_p: output buffer of the xattr value
  *
  * Get xattr *name__str* of *file* and store the output in *value_ptr*.
  *
@@ -1453,8 +1455,9 @@ __bpf_kfunc_start_defs();
  * Return: 0 on success, a negative value on error.
  */
 __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
-				   struct bpf_dynptr_kern *value_ptr)
+				   struct bpf_dynptr *value_p)
 {
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
 	struct dentry *dentry;
 	u32 value_len;
 	void *value;
diff --git a/net/core/filter.c b/net/core/filter.c
index 7c46ecba3b01..73722790cee3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11859,28 +11859,34 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 }
 
 __bpf_kfunc_start_defs();
-__bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
-				    struct bpf_dynptr_kern *ptr__uninit)
+__bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
+				    struct bpf_dynptr *ptr__uninit)
 {
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr__uninit;
+	struct sk_buff *skb = (struct sk_buff *)s;
+
 	if (flags) {
-		bpf_dynptr_set_null(ptr__uninit);
+		bpf_dynptr_set_null(ptr);
 		return -EINVAL;
 	}
 
-	bpf_dynptr_init(ptr__uninit, skb, BPF_DYNPTR_TYPE_SKB, 0, skb->len);
+	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB, 0, skb->len);
 
 	return 0;
 }
 
-__bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
-				    struct bpf_dynptr_kern *ptr__uninit)
+__bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_md *x, u64 flags,
+				    struct bpf_dynptr *ptr__uninit)
 {
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr__uninit;
+	struct xdp_buff *xdp = (struct xdp_buff *)x;
+
 	if (flags) {
-		bpf_dynptr_set_null(ptr__uninit);
+		bpf_dynptr_set_null(ptr);
 		return -EINVAL;
 	}
 
-	bpf_dynptr_init(ptr__uninit, xdp, BPF_DYNPTR_TYPE_XDP, 0, xdp_get_buff_len(xdp));
+	bpf_dynptr_init(ptr, xdp, BPF_DYNPTR_TYPE_XDP, 0, xdp_get_buff_len(xdp));
 
 	return 0;
 }
@@ -11906,10 +11912,11 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 	return 0;
 }
 
-__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
+__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 					struct bpf_tcp_req_attrs *attrs, int attrs__sz)
 {
 #if IS_ENABLED(CONFIG_SYN_COOKIES)
+	struct sk_buff *skb = (struct sk_buff *)s;
 	const struct request_sock_ops *ops;
 	struct inet_request_sock *ireq;
 	struct tcp_request_sock *treq;
@@ -12004,16 +12011,17 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
 
 __bpf_kfunc_end_defs();
 
-int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
-			       struct bpf_dynptr_kern *ptr__uninit)
+int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
+			       struct bpf_dynptr *ptr__uninit)
 {
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr__uninit;
 	int err;
 
 	err = bpf_dynptr_from_skb(skb, flags, ptr__uninit);
 	if (err)
 		return err;
 
-	bpf_dynptr_set_rdonly(ptr__uninit);
+	bpf_dynptr_set_rdonly(ptr);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/ip_check_defrag.c b/tools/testing/selftests/bpf/progs/ip_check_defrag.c
index 1c2b6c1616b0..645b2c9f7867 100644
--- a/tools/testing/selftests/bpf/progs/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/progs/ip_check_defrag.c
@@ -12,7 +12,7 @@
 #define IP_OFFSET		0x1FFF
 #define NEXTHDR_FRAGMENT	44
 
-extern int bpf_dynptr_from_skb(struct sk_buff *skb, __u64 flags,
+extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
 			      struct bpf_dynptr *ptr__uninit) __ksym;
 extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, uint32_t offset,
 			      void *buffer, uint32_t buffer__sz) __ksym;
@@ -42,7 +42,7 @@ static bool is_frag_v6(struct ipv6hdr *ip6h)
 	return ip6h->nexthdr == NEXTHDR_FRAGMENT;
 }
 
-static int handle_v4(struct sk_buff *skb)
+static int handle_v4(struct __sk_buff *skb)
 {
 	struct bpf_dynptr ptr;
 	u8 iph_buf[20] = {};
@@ -64,7 +64,7 @@ static int handle_v4(struct sk_buff *skb)
 	return NF_ACCEPT;
 }
 
-static int handle_v6(struct sk_buff *skb)
+static int handle_v6(struct __sk_buff *skb)
 {
 	struct bpf_dynptr ptr;
 	struct ipv6hdr *ip6h;
@@ -89,9 +89,9 @@ static int handle_v6(struct sk_buff *skb)
 SEC("netfilter")
 int defrag(struct bpf_nf_ctx *ctx)
 {
-	struct sk_buff *skb = ctx->skb;
+	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
 
-	switch (bpf_ntohs(skb->protocol)) {
+	switch (bpf_ntohs(ctx->skb->protocol)) {
 	case ETH_P_IP:
 		return handle_v4(skb);
 	case ETH_P_IPV6:
diff --git a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
index 65bba330e7e5..ab9f9f2620ed 100644
--- a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
@@ -79,7 +79,7 @@ int with_invalid_ctx_access_test5(struct bpf_nf_ctx *ctx)
 	return NF_ACCEPT;
 }
 
-extern int bpf_dynptr_from_skb(struct sk_buff *skb, __u64 flags,
+extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
                                struct bpf_dynptr *ptr__uninit) __ksym;
 extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, uint32_t offset,
                                    void *buffer, uint32_t buffer__sz) __ksym;
@@ -90,8 +90,8 @@ __success __failure_unpriv
 __retval(0)
 int with_valid_ctx_access_test6(struct bpf_nf_ctx *ctx)
 {
+	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
 	const struct nf_hook_state *state = ctx->state;
-	struct sk_buff *skb = ctx->skb;
 	const struct iphdr *iph;
 	const struct tcphdr *th;
 	u8 buffer_iph[20] = {};
@@ -99,7 +99,7 @@ int with_valid_ctx_access_test6(struct bpf_nf_ctx *ctx)
 	struct bpf_dynptr ptr;
 	uint8_t ihl;
 
-	if (skb->len <= 20 || bpf_dynptr_from_skb(skb, 0, &ptr))
+	if (ctx->skb->len <= 20 || bpf_dynptr_from_skb(skb, 0, &ptr))
 		return NF_ACCEPT;
 
 	iph = bpf_dynptr_slice(&ptr, 0, buffer_iph, sizeof(buffer_iph));
-- 
2.44.0


