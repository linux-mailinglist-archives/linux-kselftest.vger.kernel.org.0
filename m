Return-Path: <linux-kselftest+bounces-48228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81798CF513F
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 18:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06F9C309567B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B59433EAE7;
	Mon,  5 Jan 2026 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="LWNGpZ1z";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="hia6ne2M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F32F3C0A;
	Mon,  5 Jan 2026 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635061; cv=none; b=SWuaDnie9WsK3an0pZBvgvDUSWNoxTIR6SR2OEZeNbP3ZN/jh4M/F7rk/9DvnrLlHFY/b9oITT+vNragb7CGhSexG87SP8EpOGozsW4E7Ybb+/nNPhEjR89CA9FKgjnsJM+m7f3t6AmErCO3xx3qEAhbv9hX2EODeLJfvWPQ92M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635061; c=relaxed/simple;
	bh=3OAcQVPjbA4HjgHSJgvd9krWCA+NhHdCh0atFvYZL3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hntDpnsGx/N6WiQjeUHEebTbdtMKdEEx+D0EmSmaiSizZ5KuLlMpfSmSkqRpKgOusUw/n7vYPfNHfaovPoRNUbyx/S4DiTxQkhIcMV/jxiA5BGaHYpiUXh1uTOctvDVlEsp3haAUaSeFGFbUGnEe4t92e60oCDp86GZqdilA4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=LWNGpZ1z; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=hia6ne2M; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767634677; bh=j0BJC2IDsdxfLZAhla89qAl
	kedAI2eotg/cturZSd50=; b=LWNGpZ1zIsjMNp+P+jT2w6N9zbU2gKX0+oXRGzw2p/7BXAhicC
	jqQk0ulLkjG53KfGkoe/SjCjQgDXfXac/SjD6HhBHiRgZPSP4meBsdRRIqwpNBO/uXnoH4U/GNJ
	LrrhQvWDkwTfvrhTYUUN2uztTimWNKMupysmqiVbFwRR+78cPNajcXVhq8MohxLTNiYhlO5OpvE
	xvGOmm+3PhM/acw2H5An7tjqF5ZZ/y7qUxTBAOZwO+C9dt+RRJVyJ38JQCHfRQ7lUma+h1rgQV5
	FigfIgn62fuKvn6ONYP3cdk5b0P0B4/3B9wJC64F6kLFcsm2mwSk1NOhmAhI3XRNRnQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767634677; bh=j0BJC2IDsdxfLZAhla89qAl
	kedAI2eotg/cturZSd50=; b=hia6ne2M7WykpmMpmBEcaktXOk29VvFpjjzsgjE2TBglMQI4rA
	xcnzxBpU9TrMNOzKoB08qRZyel0/KmBTQIDg==;
From: Daniel Hodges <git@danielhodges.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Song Liu <song@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v4 5/6] bpf: Add ECDSA signature verification kfuncs
Date: Mon,  5 Jan 2026 12:37:54 -0500
Message-ID: <20260105173755.22515-6-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105173755.22515-1-git@danielhodges.dev>
References: <20260105173755.22515-1-git@danielhodges.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ECDSA signature verification in BPF programs through
the unified bpf_crypto_ctx API.

Changes:
- Add enum bpf_crypto_type_id for efficient type checking
- Update all crypto type modules to set type_id field
- Implement bpf_ecdsa_verify() for signature verification
- Add bpf_ecdsa_keysize(), bpf_ecdsa_digestsize(), bpf_ecdsa_maxsize()
  helper functions for querying context properties
- Add type_id checks in all ECDSA kfuncs for type safety
- Register ECDSA kfuncs for SCHED_CLS and XDP program types

ECDSA contexts are created using bpf_crypto_ctx_create() with
type="sig" and appropriate algorithm (e.g., "p1363(ecdsa-nist-p256)").
The public key is passed via the key/key_len fields in bpf_crypto_params.

This enables BPF programs to perform cryptographic signature verification
for use cases such as packet authentication and content validation.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 crypto/bpf_crypto_shash.c    |   1 +
 crypto/bpf_crypto_sig.c      |   1 +
 crypto/bpf_crypto_skcipher.c |   1 +
 include/linux/bpf_crypto.h   |   7 +++
 kernel/bpf/crypto.c          | 115 +++++++++++++++++++++++++++++++++++
 5 files changed, 125 insertions(+)

diff --git a/crypto/bpf_crypto_shash.c b/crypto/bpf_crypto_shash.c
index 95c178ec0ce8..6e9b0d757ec9 100644
--- a/crypto/bpf_crypto_shash.c
+++ b/crypto/bpf_crypto_shash.c
@@ -74,6 +74,7 @@ static const struct bpf_crypto_type bpf_crypto_shash_type = {
 	.digestsize	= bpf_crypto_shash_digestsize,
 	.get_flags	= bpf_crypto_shash_get_flags,
 	.owner		= THIS_MODULE,
+	.type_id	= BPF_CRYPTO_TYPE_HASH,
 	.name		= "hash",
 };
 
diff --git a/crypto/bpf_crypto_sig.c b/crypto/bpf_crypto_sig.c
index ad0d3810df8e..c6e67338cd40 100644
--- a/crypto/bpf_crypto_sig.c
+++ b/crypto/bpf_crypto_sig.c
@@ -38,6 +38,7 @@ static const struct bpf_crypto_type bpf_crypto_sig_type = {
 	.get_flags	= bpf_crypto_sig_get_flags,
 	.setkey		= bpf_crypto_sig_setkey,
 	.owner		= THIS_MODULE,
+	.type_id	= BPF_CRYPTO_TYPE_SIG,
 	.name		= "sig",
 };
 
diff --git a/crypto/bpf_crypto_skcipher.c b/crypto/bpf_crypto_skcipher.c
index a88798d3e8c8..79d310fbcc48 100644
--- a/crypto/bpf_crypto_skcipher.c
+++ b/crypto/bpf_crypto_skcipher.c
@@ -63,6 +63,7 @@ static const struct bpf_crypto_type bpf_crypto_lskcipher_type = {
 	.statesize	= bpf_crypto_lskcipher_statesize,
 	.get_flags	= bpf_crypto_lskcipher_get_flags,
 	.owner		= THIS_MODULE,
+	.type_id	= BPF_CRYPTO_TYPE_SKCIPHER,
 	.name		= "skcipher",
 };
 
diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
index c84371cc4e47..cf2c66f9782b 100644
--- a/include/linux/bpf_crypto.h
+++ b/include/linux/bpf_crypto.h
@@ -3,6 +3,12 @@
 #ifndef _BPF_CRYPTO_H
 #define _BPF_CRYPTO_H
 
+enum bpf_crypto_type_id {
+	BPF_CRYPTO_TYPE_SKCIPHER = 1,
+	BPF_CRYPTO_TYPE_HASH,
+	BPF_CRYPTO_TYPE_SIG,
+};
+
 struct bpf_crypto_type {
 	void *(*alloc_tfm)(const char *algo);
 	void (*free_tfm)(void *tfm);
@@ -17,6 +23,7 @@ struct bpf_crypto_type {
 	unsigned int (*digestsize)(void *tfm);
 	u32 (*get_flags)(void *tfm);
 	struct module *owner;
+	enum bpf_crypto_type_id type_id;
 	char name[14];
 };
 
diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index f593e7910d3d..3c57a8c31ea2 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -9,6 +9,7 @@
 #include <linux/scatterlist.h>
 #include <linux/skbuff.h>
 #include <crypto/skcipher.h>
+#include <crypto/sig.h>
 
 struct bpf_crypto_type_list {
 	const struct bpf_crypto_type *type;
@@ -57,6 +58,7 @@ struct bpf_crypto_ctx {
 	refcount_t usage;
 };
 
+
 int bpf_crypto_register_type(const struct bpf_crypto_type *type)
 {
 	struct bpf_crypto_type_list *node;
@@ -400,6 +402,109 @@ __bpf_kfunc int bpf_crypto_hash(struct bpf_crypto_ctx *ctx,
 }
 #endif /* CONFIG_CRYPTO_HASH2 */
 
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+/**
+ * bpf_ecdsa_verify() - Verify ECDSA signature using pre-allocated context
+ * @ctx: ECDSA context created by bpf_crypto_ctx_create() with type "sig"
+ * @message: bpf_dynptr to the message hash to verify. Must be a trusted pointer.
+ * @signature: bpf_dynptr to the ECDSA signature in r || s format. Must be a trusted pointer.
+ *             Must be 64 bytes for P-256, 96 for P-384, 132 for P-521
+ *
+ * Verifies an ECDSA signature using a pre-allocated context. This function
+ * does not allocate memory and can be used in non-sleepable BPF programs.
+ * Uses bpf_dynptr to ensure safe memory access without risk of page faults.
+ */
+__bpf_kfunc int bpf_ecdsa_verify(struct bpf_crypto_ctx *ctx,
+				 const struct bpf_dynptr *message,
+				 const struct bpf_dynptr *signature)
+{
+	const struct bpf_dynptr_kern *msg_kern = (struct bpf_dynptr_kern *)message;
+	const struct bpf_dynptr_kern *sig_kern = (struct bpf_dynptr_kern *)signature;
+	struct crypto_sig *sig_tfm;
+	const u8 *msg_ptr, *sig_ptr;
+	u32 msg_len, sig_len;
+
+	if (!ctx)
+		return -EINVAL;
+
+	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SIG)
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
+	sig_tfm = (struct crypto_sig *)ctx->tfm;
+	return crypto_sig_verify(sig_tfm, sig_ptr, sig_len, msg_ptr, msg_len);
+}
+
+/**
+ * bpf_ecdsa_keysize() - Get the key size for ECDSA context
+ * @ctx: ECDSA context
+ *
+ * Returns: Key size in bits, or negative error code on failure
+ */
+__bpf_kfunc int bpf_ecdsa_keysize(struct bpf_crypto_ctx *ctx)
+{
+	struct crypto_sig *sig_tfm;
+
+	if (!ctx)
+		return -EINVAL;
+
+	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SIG)
+		return -EINVAL;
+
+	sig_tfm = (struct crypto_sig *)ctx->tfm;
+	return crypto_sig_keysize(sig_tfm);
+}
+
+/**
+ * bpf_ecdsa_digestsize() - Get the maximum digest size for ECDSA context
+ * @ctx: ECDSA context
+ */
+__bpf_kfunc int bpf_ecdsa_digestsize(struct bpf_crypto_ctx *ctx)
+{
+	struct crypto_sig *sig_tfm;
+
+	if (!ctx)
+		return -EINVAL;
+
+	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SIG)
+		return -EINVAL;
+
+	sig_tfm = (struct crypto_sig *)ctx->tfm;
+	return crypto_sig_digestsize(sig_tfm);
+}
+
+/**
+ * bpf_ecdsa_maxsize() - Get the maximum signature size for ECDSA context
+ * @ctx: ECDSA context
+ */
+__bpf_kfunc int bpf_ecdsa_maxsize(struct bpf_crypto_ctx *ctx)
+{
+	struct crypto_sig *sig_tfm;
+
+	if (!ctx)
+		return -EINVAL;
+
+	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SIG)
+		return -EINVAL;
+
+	sig_tfm = (struct crypto_sig *)ctx->tfm;
+	return crypto_sig_maxsize(sig_tfm);
+}
+#endif /* CONFIG_CRYPTO_ECDSA */
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(crypt_init_kfunc_btf_ids)
@@ -419,6 +524,12 @@ BTF_ID_FLAGS(func, bpf_crypto_encrypt, KF_RCU)
 #if IS_ENABLED(CONFIG_CRYPTO_HASH2)
 BTF_ID_FLAGS(func, bpf_crypto_hash, KF_RCU)
 #endif
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+BTF_ID_FLAGS(func, bpf_ecdsa_verify, KF_RCU)
+BTF_ID_FLAGS(func, bpf_ecdsa_keysize, 0)
+BTF_ID_FLAGS(func, bpf_ecdsa_digestsize, 0)
+BTF_ID_FLAGS(func, bpf_ecdsa_maxsize, 0)
+#endif
 BTF_KFUNCS_END(crypt_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set crypt_kfunc_set = {
@@ -447,6 +558,10 @@ static int __init crypto_kfunc_init(void)
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


