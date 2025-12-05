Return-Path: <linux-kselftest+bounces-47137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4273FCA8B2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C5D130E11FB
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F2C34D4C8;
	Fri,  5 Dec 2025 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="XcljczDz";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="BrHd3TD0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06822213254;
	Fri,  5 Dec 2025 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764956582; cv=none; b=mwhYoqNjLuhgKPIkPwKTlUKKm0HBvtCtszh5lXZwyGpvUO8Eb0SwKsbTYDgASU0HD6mlMavGnCZ4Td+5MkGGq/63NBPAdJkh3peEgaX8++N+/sdIqpN8yHucOiP+YK03IAdtMmuOJmgrLIqEKhfl9+BrUU6TDGT7VfxSDT2r/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764956582; c=relaxed/simple;
	bh=H6Qz8x1rSzpr6+849NT4w6mDG9ie4+0BXtUNgMHU0gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaiqxkTM/vujDPSC8nSZ2f3mQvr0qojhxwt0i4Gf8rQLw+rynDABLYisD+keT8ws4yIFhmWn17z1P34RVzhNyf8BVHae2h5QXCAL34DwHsAFQKX7EmMGGK8ppXF5RrzqfFxk7Zl/fbrCzjUYYDjj4f0MG6dIyNiI7AGfTMicVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=XcljczDz; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=BrHd3TD0; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1764956365; bh=se5LlHSBJ7lq7UVt+yUWy3C
	dL2n08J14Yo+VA/PYMoQ=; b=XcljczDzdHd4XxzKwi/djMpBwXZSQEACUYz78ZXXtxMR6/MYXm
	Z7xVDIaCqq+bNniGw2o69txb3m/FbSEL8mFnyleQXGBB/xRz0sTXTMuUJVnLVNjTs8v9piX+BSS
	+9zc4ZiAX4HBa+urlEYD/O0rJvIY6im5rL5kp/1wC29F4BCB3J7tskhz4rMs/ku0WyCd/qyj9p2
	GSwPX3fhAnJ4iSi3iWOKsEvKBajK7P3VgMmeHYgz+LhtFcob41ZKx/ANTN063E6/PGOXDDiK+/b
	LLVrWO2yFZLevl3bCrlvI1xcfilblm97SB4oaAJhxKm1Sp5KlchZ7FjyQ8bYJMr5gJQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1764956365; bh=se5LlHSBJ7lq7UVt+yUWy3C
	dL2n08J14Yo+VA/PYMoQ=; b=BrHd3TD01cUr7p8NQHAQvBzEaXVvXCFOqs3VY8Isurl7hKKGG1
	+TOo8gwc8ORC1I3iv3iMpTkeQ1eQLMWbPhCA==;
From: Daniel Hodges <git@danielhodges.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	vadim.fedorenko@linux.dev
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v2 4/5] bpf: Add ECDSA signature verification kfuncs
Date: Fri,  5 Dec 2025 12:39:22 -0500
Message-ID: <20251205173923.31740-5-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205173923.31740-1-git@danielhodges.dev>
References: <20251205173923.31740-1-git@danielhodges.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add context-based ECDSA signature verification kfuncs:
- bpf_ecdsa_ctx_create(): Creates reusable ECDSA context with public key
- bpf_ecdsa_verify(): Verifies signatures using the context
- bpf_ecdsa_ctx_acquire(): Increments context reference count
- bpf_ecdsa_ctx_release(): Releases context with RCU safety

The ECDSA implementation supports NIST curves (P-256, P-384, P-521) and
uses the kernel's crypto_sig API. Public keys must be in uncompressed
format (0x04 || x || y), and signatures are in r || s format.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 kernel/bpf/crypto.c | 230 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 95625c7ffb1a..3a3741cf657f 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -9,6 +9,7 @@
 #include <linux/scatterlist.h>
 #include <linux/skbuff.h>
 #include <crypto/skcipher.h>
+#include <crypto/sig.h>
 
 struct bpf_crypto_type_list {
 	const struct bpf_crypto_type *type;
@@ -57,6 +58,21 @@ struct bpf_crypto_ctx {
 	refcount_t usage;
 };
 
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+/**
+ * struct bpf_ecdsa_ctx - refcounted BPF ECDSA context structure
+ * @tfm:	The crypto_sig transform for ECDSA operations
+ * @rcu:	The RCU head used to free the context with RCU safety
+ * @usage:	Object reference counter. When the refcount goes to 0, the
+ *		memory is released with RCU safety.
+ */
+struct bpf_ecdsa_ctx {
+	struct crypto_sig *tfm;
+	struct rcu_head rcu;
+	refcount_t usage;
+};
+#endif
+
 int bpf_crypto_register_type(const struct bpf_crypto_type *type)
 {
 	struct bpf_crypto_type_list *node;
@@ -399,12 +415,206 @@ __bpf_kfunc int bpf_crypto_hash(struct bpf_crypto_ctx *ctx,
 }
 #endif /* CONFIG_CRYPTO_HASH2 */
 
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+/**
+ * bpf_ecdsa_ctx_create() - Create a BPF ECDSA verification context
+ * @algo_name: bpf_dynptr to the algorithm name (e.g., "p1363(ecdsa-nist-p256)")
+ * @public_key: bpf_dynptr to the public key in uncompressed format (0x04 || x || y)
+ *              Must be 65 bytes for P-256, 97 for P-384, 133 for P-521
+ * @err: Pointer to store error code on failure
+ *
+ * Creates an ECDSA verification context that can be reused for multiple
+ * signature verifications. This function uses GFP_KERNEL allocation and
+ * can only be called from sleepable BPF programs. Uses bpf_dynptr to ensure
+ * safe memory access without risk of page faults.
+ */
+__bpf_kfunc struct bpf_ecdsa_ctx *
+bpf_ecdsa_ctx_create(const struct bpf_dynptr *algo_name,
+		     const struct bpf_dynptr *public_key, int *err)
+{
+	const struct bpf_dynptr_kern *algo_kern = (struct bpf_dynptr_kern *)algo_name;
+	const struct bpf_dynptr_kern *key_kern = (struct bpf_dynptr_kern *)public_key;
+	struct bpf_ecdsa_ctx *ctx;
+	const char *algo_ptr;
+	const u8 *key_ptr;
+	u32 algo_len, key_len;
+	char algo[64];
+	int ret;
+
+	if (!err)
+		return NULL;
+
+	algo_len = __bpf_dynptr_size(algo_kern);
+	key_len = __bpf_dynptr_size(key_kern);
+
+	if (algo_len == 0 || algo_len >= sizeof(algo)) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	if (key_len < 65) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	algo_ptr = __bpf_dynptr_data(algo_kern, algo_len);
+	if (!algo_ptr) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	key_ptr = __bpf_dynptr_data(key_kern, key_len);
+	if (!key_ptr) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	if (key_ptr[0] != 0x04) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	memcpy(algo, algo_ptr, algo_len);
+	algo[algo_len] = '\0';
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	ctx->tfm = crypto_alloc_sig(algo, 0, 0);
+	if (IS_ERR(ctx->tfm)) {
+		*err = PTR_ERR(ctx->tfm);
+		kfree(ctx);
+		return NULL;
+	}
+
+	ret = crypto_sig_set_pubkey(ctx->tfm, key_ptr, key_len);
+	if (ret) {
+		*err = ret;
+		crypto_free_sig(ctx->tfm);
+		kfree(ctx);
+		return NULL;
+	}
+
+	refcount_set(&ctx->usage, 1);
+	*err = 0;
+	return ctx;
+}
+
+/**
+ * bpf_ecdsa_verify() - Verify ECDSA signature using pre-allocated context
+ * @ctx: ECDSA context created by bpf_ecdsa_ctx_create()
+ * @message: bpf_dynptr to the message hash to verify. Must be a trusted pointer.
+ * @signature: bpf_dynptr to the ECDSA signature in r || s format. Must be a trusted pointer.
+ *             Must be 64 bytes for P-256, 96 for P-384, 132 for P-521
+ *
+ * Verifies an ECDSA signature using a pre-allocated context. This function
+ * does not allocate memory and can be used in non-sleepable BPF programs.
+ * Uses bpf_dynptr to ensure safe memory access without risk of page faults.
+ */
+__bpf_kfunc int bpf_ecdsa_verify(struct bpf_ecdsa_ctx *ctx,
+				 const struct bpf_dynptr *message,
+				 const struct bpf_dynptr *signature)
+{
+	const struct bpf_dynptr_kern *msg_kern = (struct bpf_dynptr_kern *)message;
+	const struct bpf_dynptr_kern *sig_kern = (struct bpf_dynptr_kern *)signature;
+	const u8 *msg_ptr, *sig_ptr;
+	u32 msg_len, sig_len;
+
+	if (!ctx)
+		return -EINVAL;
+
+	msg_len = __bpf_dynptr_size(msg_kern);
+	sig_len = __bpf_dynptr_size(sig_kern);
+
+	if (msg_len == 0 || sig_len == 0)
+		return -EINVAL;
+
+	msg_ptr = __bpf_dynptr_data(msg_kern, msg_len);
+	if (!msg_ptr)
+		return -EINVAL;
+
+	sig_ptr = __bpf_dynptr_data(sig_kern, sig_len);
+	if (!sig_ptr)
+		return -EINVAL;
+
+	return crypto_sig_verify(ctx->tfm, sig_ptr, sig_len, msg_ptr, msg_len);
+}
+
+__bpf_kfunc struct bpf_ecdsa_ctx *
+bpf_ecdsa_ctx_acquire(struct bpf_ecdsa_ctx *ctx)
+{
+	if (!refcount_inc_not_zero(&ctx->usage))
+		return NULL;
+	return ctx;
+}
+
+static void ecdsa_free_cb(struct rcu_head *head)
+{
+	struct bpf_ecdsa_ctx *ctx = container_of(head, struct bpf_ecdsa_ctx, rcu);
+
+	crypto_free_sig(ctx->tfm);
+	kfree(ctx);
+}
+
+__bpf_kfunc void bpf_ecdsa_ctx_release(struct bpf_ecdsa_ctx *ctx)
+{
+	if (refcount_dec_and_test(&ctx->usage))
+		call_rcu(&ctx->rcu, ecdsa_free_cb);
+}
+
+/**
+ * bpf_ecdsa_keysize() - Get the key size for ECDSA context
+ * @ctx: ECDSA context
+ *
+ * Returns: Key size in bits, or negative error code on failure
+ */
+__bpf_kfunc int bpf_ecdsa_keysize(struct bpf_ecdsa_ctx *ctx)
+{
+	if (!ctx)
+		return -EINVAL;
+
+	return crypto_sig_keysize(ctx->tfm);
+}
+
+/**
+ * bpf_ecdsa_digestsize() - Get the maximum digest size for ECDSA context
+ * @ctx: ECDSA context
+ */
+__bpf_kfunc int bpf_ecdsa_digestsize(struct bpf_ecdsa_ctx *ctx)
+{
+	if (!ctx)
+		return -EINVAL;
+
+	return crypto_sig_digestsize(ctx->tfm);
+}
+
+/**
+ * bpf_ecdsa_maxsize() - Get the maximum signature size for ECDSA context
+ * @ctx: ECDSA context
+ */
+__bpf_kfunc int bpf_ecdsa_maxsize(struct bpf_ecdsa_ctx *ctx)
+{
+	if (!ctx)
+		return -EINVAL;
+
+	return crypto_sig_maxsize(ctx->tfm);
+}
+#endif /* CONFIG_CRYPTO_ECDSA */
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(crypt_init_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_crypto_ctx_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_crypto_ctx_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_crypto_ctx_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+BTF_ID_FLAGS(func, bpf_ecdsa_ctx_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ecdsa_ctx_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_ecdsa_ctx_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+#endif
 BTF_KFUNCS_END(crypt_init_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set crypt_init_kfunc_set = {
@@ -418,6 +628,12 @@ BTF_ID_FLAGS(func, bpf_crypto_encrypt, KF_RCU)
 #if IS_ENABLED(CONFIG_CRYPTO_HASH2)
 BTF_ID_FLAGS(func, bpf_crypto_hash, KF_RCU)
 #endif
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+BTF_ID_FLAGS(func, bpf_ecdsa_verify, 0)
+BTF_ID_FLAGS(func, bpf_ecdsa_keysize, 0)
+BTF_ID_FLAGS(func, bpf_ecdsa_digestsize, 0)
+BTF_ID_FLAGS(func, bpf_ecdsa_maxsize, 0)
+#endif
 BTF_KFUNCS_END(crypt_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set crypt_kfunc_set = {
@@ -428,6 +644,10 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
 BTF_ID_LIST(bpf_crypto_dtor_ids)
 BTF_ID(struct, bpf_crypto_ctx)
 BTF_ID(func, bpf_crypto_ctx_release)
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+BTF_ID(struct, bpf_ecdsa_ctx)
+BTF_ID(func, bpf_ecdsa_ctx_release)
+#endif
 
 static int __init crypto_kfunc_init(void)
 {
@@ -437,6 +657,12 @@ static int __init crypto_kfunc_init(void)
 			.btf_id	      = bpf_crypto_dtor_ids[0],
 			.kfunc_btf_id = bpf_crypto_dtor_ids[1]
 		},
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+		{
+			.btf_id       = bpf_crypto_dtor_ids[2],
+			.kfunc_btf_id = bpf_crypto_dtor_ids[3]
+		},
+#endif
 	};
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &crypt_kfunc_set);
@@ -445,6 +671,10 @@ static int __init crypto_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &crypt_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
 					       &crypt_init_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
+					       &crypt_init_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					       &crypt_init_kfunc_set);
 	return  ret ?: register_btf_id_dtor_kfuncs(bpf_crypto_dtors,
 						   ARRAY_SIZE(bpf_crypto_dtors),
 						   THIS_MODULE);
-- 
2.51.0


