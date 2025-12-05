Return-Path: <linux-kselftest+bounces-47136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F364FCA8AD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31A7F3024193
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77226349B05;
	Fri,  5 Dec 2025 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="hG48cjpo";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="nnyCdoBJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD52345CDF;
	Fri,  5 Dec 2025 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764956430; cv=none; b=k5fCS/grVSmoIM+b2pod+ywjHMLTzBFLPXqH3PfPLZDH8obZPkROLf5yRXgIlARau23IJVJ3R1jolAFnXs7LZi+98Z9Vnw4VvSNX1k30sbvaXLM/1EMdqK97mC+idEMW5SORs18CjBznWtl8bww6Y/S1zdiOy6k2mQEAZsoxIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764956430; c=relaxed/simple;
	bh=/ecTewoC+na5TyqVbXJsTJuPZZqVOpgPRpDbP3a6RA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBsG9/gpYq0Em1P+fMwSVoYAVWPy8OzgecFPHSTqP/dzTcrnq7ZT2cmE2w7gWAX2IpLqa5X1LPGYXL+KYFE74EGSXsddX3PIQ1kPqAhGf9nXhPifqSu8o+p5fbOD3AkdSv9pTFebk4KgyLfZN1aXT/4uLrf1zgxe09s2ktIEis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=hG48cjpo; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=nnyCdoBJ; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1764956364; bh=vhPxvsDTkWEQFfp+gdD4WQ3
	DcWtcVZZEzU1K1zMttmw=; b=hG48cjpojvlldQnDSECoYOEqqK6VM0ehhrtTEJX770XwgIS6sp
	qAsORO/KACypeMFNzMPc8u7s7s7qjtJBQ/2gdngVBj8WZq8XFBPMdAEADwcQdiiM9QCf4K6q2Mo
	odI+fS5QJ/DtrL/H6V+mPZENBVzAHO87EuAVryJxzEbM01Cz57UY2eM3FiguI61RHX6Ir9UlQCN
	XxfKJOR3iJn4J0o0Xucuuqex/a4twRSo0AuKyPVKZ/xNqMzHsSQtI0iA3GgywOpVHWU8BX+REWk
	UczvAy01uWVrMJ5KjOyEmOfmxLKZLvWFgshw7VJ7g2rdI26Z9Um6bKQGeCgBG5W+BPA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1764956364; bh=vhPxvsDTkWEQFfp+gdD4WQ3
	DcWtcVZZEzU1K1zMttmw=; b=nnyCdoBJmDdiwQLbSWMQUmeJhZM/e63X3DrP9nViHEdPC7vaNV
	dsSfADFw73EZBCQBuNNpR+kwoHoMVbF0hwAQ==;
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
Subject: [PATCH bpf-next v2 2/5] bpf: Add SHA hash kfunc for cryptographic hashing
Date: Fri,  5 Dec 2025 12:39:20 -0500
Message-ID: <20251205173923.31740-3-git@danielhodges.dev>
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

Extend bpf_crypto_type structure with hash operations:
 - hash(): Performs hashing operation
 - digestsize(): Returns hash output size

Update bpf_crypto_ctx_create() to support keyless operations:
 - Hash algorithms don't require keys, unlike ciphers
 - Only validates key presence if type->setkey is defined
 - Conditionally sets IV/state length for cipher operations only

Add bpf_crypto_hash() kfunc that works with any hash algorithm
registered in the kernel's crypto API through the BPF crypto type
system. This enables BPF programs to compute cryptographic hashes for
use cases such as content verification, integrity checking, and data
authentication.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 include/linux/bpf_crypto.h |  2 +
 kernel/bpf/crypto.c        | 76 ++++++++++++++++++++++++++++++++++----
 2 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
index a41e71d4e2d9..c84371cc4e47 100644
--- a/include/linux/bpf_crypto.h
+++ b/include/linux/bpf_crypto.h
@@ -11,8 +11,10 @@ struct bpf_crypto_type {
 	int (*setauthsize)(void *tfm, unsigned int authsize);
 	int (*encrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
 	int (*decrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
+	int (*hash)(void *tfm, const u8 *data, u8 *out, unsigned int len);
 	unsigned int (*ivsize)(void *tfm);
 	unsigned int (*statesize)(void *tfm);
+	unsigned int (*digestsize)(void *tfm);
 	u32 (*get_flags)(void *tfm);
 	struct module *owner;
 	char name[14];
diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 83c4d9943084..95625c7ffb1a 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -171,7 +171,12 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
 		goto err_module_put;
 	}
 
-	if (!params->key_len || params->key_len > sizeof(params->key)) {
+	/* Hash operations don't require a key, but cipher operations do */
+	if (params->key_len > sizeof(params->key)) {
+		*err = -EINVAL;
+		goto err_module_put;
+	}
+	if (!params->key_len && type->setkey) {
 		*err = -EINVAL;
 		goto err_module_put;
 	}
@@ -195,16 +200,19 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
 			goto err_free_tfm;
 	}
 
-	*err = type->setkey(ctx->tfm, params->key, params->key_len);
-	if (*err)
-		goto err_free_tfm;
+	if (params->key_len) {
+		*err = type->setkey(ctx->tfm, params->key, params->key_len);
+		if (*err)
+			goto err_free_tfm;
 
-	if (type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY) {
-		*err = -EINVAL;
-		goto err_free_tfm;
+		if (type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY) {
+			*err = -EINVAL;
+			goto err_free_tfm;
+		}
 	}
 
-	ctx->siv_len = type->ivsize(ctx->tfm) + type->statesize(ctx->tfm);
+	if (type->ivsize && type->statesize)
+		ctx->siv_len = type->ivsize(ctx->tfm) + type->statesize(ctx->tfm);
 
 	refcount_set(&ctx->usage, 1);
 
@@ -343,6 +351,54 @@ __bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
 	return bpf_crypto_crypt(ctx, src_kern, dst_kern, siv_kern, false);
 }
 
+#if IS_ENABLED(CONFIG_CRYPTO_HASH2)
+/**
+ * bpf_crypto_hash() - Compute hash using configured context
+ * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
+ * @data:	bpf_dynptr to the input data to hash. Must be a trusted pointer.
+ * @out:	bpf_dynptr to the output buffer. Must be a trusted pointer.
+ *
+ * Computes hash of the input data using the crypto context. The output buffer
+ * must be at least as large as the digest size of the hash algorithm.
+ */
+__bpf_kfunc int bpf_crypto_hash(struct bpf_crypto_ctx *ctx,
+				const struct bpf_dynptr *data,
+				const struct bpf_dynptr *out)
+{
+	const struct bpf_dynptr_kern *data_kern = (struct bpf_dynptr_kern *)data;
+	const struct bpf_dynptr_kern *out_kern = (struct bpf_dynptr_kern *)out;
+	u32 data_len, out_len;
+	const u8 *data_ptr;
+	u8 *out_ptr;
+
+	if (!ctx->type->hash)
+		return -EOPNOTSUPP;
+
+	data_len = __bpf_dynptr_size(data_kern);
+	out_len = __bpf_dynptr_size(out_kern);
+
+	if (data_len == 0)
+		return -EINVAL;
+
+	if (!ctx->type->digestsize)
+		return -EOPNOTSUPP;
+
+	unsigned int digestsize = ctx->type->digestsize(ctx->tfm);
+	if (out_len < digestsize)
+		return -EINVAL;
+
+	data_ptr = __bpf_dynptr_data(data_kern, data_len);
+	if (!data_ptr)
+		return -EINVAL;
+
+	out_ptr = __bpf_dynptr_data_rw(out_kern, out_len);
+	if (!out_ptr)
+		return -EINVAL;
+
+	return ctx->type->hash(ctx->tfm, data_ptr, out_ptr, data_len);
+}
+#endif /* CONFIG_CRYPTO_HASH2 */
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(crypt_init_kfunc_btf_ids)
@@ -359,6 +415,9 @@ static const struct btf_kfunc_id_set crypt_init_kfunc_set = {
 BTF_KFUNCS_START(crypt_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_crypto_decrypt, KF_RCU)
 BTF_ID_FLAGS(func, bpf_crypto_encrypt, KF_RCU)
+#if IS_ENABLED(CONFIG_CRYPTO_HASH2)
+BTF_ID_FLAGS(func, bpf_crypto_hash, KF_RCU)
+#endif
 BTF_KFUNCS_END(crypt_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set crypt_kfunc_set = {
@@ -383,6 +442,7 @@ static int __init crypto_kfunc_init(void)
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &crypt_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &crypt_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &crypt_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &crypt_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
 					       &crypt_init_kfunc_set);
 	return  ret ?: register_btf_id_dtor_kfuncs(bpf_crypto_dtors,
-- 
2.51.0


