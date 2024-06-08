Return-Path: <linux-kselftest+bounces-11501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF13D901399
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 23:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D308A1C20A19
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 21:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC216BFA5;
	Sat,  8 Jun 2024 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="m1aKuC3N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XeLNhmfy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7163D3BD;
	Sat,  8 Jun 2024 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881421; cv=none; b=ldURqJQrisJ+/UU79sgLnDB9m4HfdXvKEws/oUMIYUwwZI1dIXctgPLuerPCTgUWemw+yZrKzaUvftq5A2j9F6Y/I+90lpUpcTBqJywWBAVe1XQFn1YaF1H+cNKRbGsnODlk/N9DLBfvlVODQIxGg7MZGS5HQifbGpqRe/l/0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881421; c=relaxed/simple;
	bh=F1BdnD+473JFwFhnq5XquJEj+Nd5pud67dbTihqeaTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=th0TsLh7zfOLJy/iz5Ro8U8z2ztn+EHeEgIP2dUVc6Td2gSNyk0xx2TMDbn61Zwnz9oWA06iSHWdYmSYpnl4QwccnDud5xDzzXu6xjX1gNSd9wOs+z4idnwXeD70ukzDJsbtZkd01Y1yYjK7l4BL7CfiPSp90bZKdPUDzR8B/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=m1aKuC3N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XeLNhmfy; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2FF291800081;
	Sat,  8 Jun 2024 17:16:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 08 Jun 2024 17:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717881414; x=
	1717967814; bh=ZS5H7eVLU+ArNK60GvnBi/5Y+KsAu6XxJQNxDlD3NCE=; b=m
	1aKuC3NoafRCBMbmVuv2qBZrjxOhsfrUc0aT21yCIWbYWiCFnRO3ZtxtDa770e8I
	mXauu3wYqRddkH/vL9WFLYjGPisrZzOxBrCGrrI/O8MtmLGBS5eduH1HOFJyfKk8
	pUcus07+HCT/FzEZ1dS+xK0y7gimOj6tmGQDFvV9fVXc10wqpF+Cb21zlRdHeh1h
	j6DjExiAaa1lerBBYEOoRnXOd2YdzvFB1fnZzrkMsbWRbRJ9QtfH3jGt1q4liNo0
	NeVIOejPj60x5HtEGgQpHZvf5iW8ybyLWx00UprjzX/tgakfNpARQH9KYsPPr0PX
	qL7+CXKsukyZVabxo8eoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717881414; x=
	1717967814; bh=ZS5H7eVLU+ArNK60GvnBi/5Y+KsAu6XxJQNxDlD3NCE=; b=X
	eLNhmfyg00DDj3u0LwTeIzSyLLFkLHiL6QsvsZ9Ya6WqNG6qXwdi3vMqos8x44nW
	K9/JGr1aT+LCkNuu/Kiy+sojQgToy9zf9z88LzYPCIh3rCss/ba85jj92PnKcd/Z
	9BVvPltPWZeYukcahopOMwXH0TFIWAQyQh81BgBUf6oRK7c0IFqU4ivBLQ7+eTGg
	YxLdQyvwdtRCi786SiqkTQzl8aqZHn3Cy4VDshgVwZbPlV+4+MHTMYQWVHt+Epkm
	VjnReaNmEoX/37+BtVSQXFBAISuCQDCRrfGXs2B2KvG/p5DEWKb2tSP9ulzVaQ1C
	gSqkQzTRAqUEGu9tRlb3g==
X-ME-Sender: <xms:RspkZnPODC5c-jTwAS7E282NZA40LgCXcVJ2pGEp_wGso7A0NfGTRA>
    <xme:RspkZh9V6XBSQv4bOvGk-6mEn7j7dGpEpVCIOqoZu7o0kzEpTstf4z3s3mLs0Xwg0
    9ScAyjg6XOFLmc2wA>
X-ME-Received: <xmr:RspkZmRwxwfnHqW12yb9yNAzf4HSs35ZTscO2fJDJs9ZwveL2cnPi7rYKj7KFNiRdhg-OsciHXuvVBQsdPIbYVC1GZDPFy8NeHoqLHfu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:RspkZrse-Bez3IZHYUzxoeVixxxmhn6iRP2KIolfOEhsqvuTyD43Lg>
    <xmx:RspkZvfb6Nq9_vUyXGr1zLC7jkJGUqPTqcEKVdqXFDdKYmKPvexv5g>
    <xmx:RspkZn0uYOVIPkNS1Imicp9lFj3wE3RL5Hrwsf6Jojc3_JWBA_FnHA>
    <xmx:RspkZr-qkccDrPzLexAXsA2ACjb7U-rXtXtWlRjnchyK_MiGfeVx9w>
    <xmx:RspkZhf98BO1tgPsJXRrolHY3h8HJaQKWFhdDz-EYWk9s8kJMjjY98Y3>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:16:51 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: rostedt@goodmis.org,
	martin.lau@linux.dev,
	shuah@kernel.org,
	song@kernel.org,
	mhiramat@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	pabeni@redhat.com,
	ebiggers@kernel.org,
	tytso@mit.edu,
	vadim.fedorenko@linux.dev,
	eddyz87@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	daniel@iogearbox.net,
	hawk@kernel.org,
	kuba@kernel.org,
	john.fastabend@gmail.com,
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
Subject: [PATCH bpf-next v4 09/12] bpf: treewide: Align kfunc signatures to prog point-of-view
Date: Sat,  8 Jun 2024 15:16:05 -0600
Message-ID: <677377439845fcb9135151d1dac1102ed3d6c924.1717881178.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717881178.git.dxu@dxuuu.xyz>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
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
 fs/verity/measure.c                           |  3 +-
 include/linux/bpf.h                           |  8 ++--
 kernel/bpf/crypto.c                           | 24 ++++++++----
 kernel/bpf/helpers.c                          | 39 +++++++++++++------
 kernel/bpf/verifier.c                         |  2 +-
 kernel/trace/bpf_trace.c                      |  9 +++--
 net/core/filter.c                             | 32 +++++++++------
 .../selftests/bpf/progs/ip_check_defrag.c     | 10 ++---
 .../bpf/progs/verifier_netfilter_ctx.c        |  6 +--
 9 files changed, 84 insertions(+), 49 deletions(-)

diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index 3969d54158d1..7af0f7f8a6f3 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -117,8 +117,9 @@ __bpf_kfunc_start_defs();
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
index 0808beca3837..05491b6de213 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10910,7 +10910,7 @@ enum {
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
-BTF_ID(struct, bpf_dynptr_kern)
+BTF_ID(struct, bpf_dynptr)
 BTF_ID(struct, bpf_list_head)
 BTF_ID(struct, bpf_list_node)
 BTF_ID(struct, bpf_rb_root)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f5154c051d2c..58ae34b730df 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
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


