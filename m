Return-Path: <linux-kselftest+bounces-47250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FC1CABE9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 04:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04CD13013EB0
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 03:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EED92E765E;
	Mon,  8 Dec 2025 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="pEeqIsqf";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="YqfWEdp4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A6288C24;
	Mon,  8 Dec 2025 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765163049; cv=none; b=DAHl6BYhbrRiABX/aCQGn0VfHWMRR6XL93ri3Bs3+GCd1jUySdG8zN5tic/Q8QPQtzTR4i+dZOydwRzz6Oo2vAMBg8c+kmbKR6rKkccUZ/qBVejOTmX2xnk2Jq+DCiFlFnzznIDxUFqwCTdXUYppwnYCywvQguIu6JwwNReCL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765163049; c=relaxed/simple;
	bh=gQSrJ6sLZR0UgasAXOI6aGw7bjQJLmMSnSI/FV6E+24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWx3OMgi40G91aUjOG1cRZU64qP21BtQfxHdjzyZoM4U9bMe8hklrDmLTeIH9hJi5Cl2whOaLG2YyAOgNg1p0+j+ai9PQub8hbbH44ZB8teCTD5LI7ZySdxKrUSLaRKU91VYnMsNLM0N13UxqDfqExUamJCKRKPIcRNLi/69GhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=pEeqIsqf; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=YqfWEdp4; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1765162878; bh=lhHuv3JHJ5ECsH2LZI0gvI2
	/2V1KyyLs/oMt1+jySa4=; b=pEeqIsqfCJxF73WuXHU4EQCRtKb4Fqo2A7uKR8gu+pjxDfdWcf
	Ab9hLS3cTcYmrBnv6V9S3AbwQduskOs7bkZ2XonykUEpCuI4qdk7WLEM5tZrKvUH4ezXih/mDz0
	xyM+yrE1UykswLuAL2/zxZouqSEmGcs0/+JR4BavQBjriJJztICUcwWeaRp7T5f+/8WsBKFQ/aa
	+2+rk6IedhhLBdRrmvtOpbyz8IHSfpMbpHR0yWt1j75OH4lu+3w5BlfguuI83muDuhWRES00BkJ
	6OEYCK+UuLfsaxDO/DXCTpgIdUZo374e0a6sxsNs0zPfudsRQID9REKYJRzIKWn+m5g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1765162878; bh=lhHuv3JHJ5ECsH2LZI0gvI2
	/2V1KyyLs/oMt1+jySa4=; b=YqfWEdp4f/mMP756r/IuzD489o8vUEUD7HEq9FE4bUNv7pzVQv
	ZXMzEaazMdiaTSOZhAv9/Y1Z+fbdjVKJ1ZAA==;
From: Daniel Hodges <git@danielhodges.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	vadim.fedorenko@linux.dev,
	song@kernel.org,
	yatsenko@meta.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	yonghong.song@linux.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v3 3/6] bpf: Add SHA hash kfunc for cryptographic hashing
Date: Sun,  7 Dec 2025 22:01:14 -0500
Message-ID: <20251208030117.18892-4-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208030117.18892-1-git@danielhodges.dev>
References: <20251208030117.18892-1-git@danielhodges.dev>
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
 kernel/bpf/crypto.c | 76 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 83c4d9943084..47e6a43a46d4 100644
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
+	u64 data_len, out_len;
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


