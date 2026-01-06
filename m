Return-Path: <linux-kselftest+bounces-48350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 937BDCFB3D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 23:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6BBE300FE08
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 22:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F972C0261;
	Tue,  6 Jan 2026 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SmtqAfZF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5917736
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737862; cv=none; b=e8RSdbDlNvBpH+YhnjUO8ze/fmPONC+/2CvHvUz9hMukh6QPVnxBpTg7filfEHWDI/JOVcZjZcxRodVP9QziiMxTxuC+eqjfY4fK83k0SgYxnl8Gk/jFdU26bDrosOZVru4+nEzw31LLijj2z4WXfO6+M9eDn8pB3DQQvHVRwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737862; c=relaxed/simple;
	bh=BUASTSdPyD0oWDqx7KwKNTxV1Kf+xZgoCh2Xr0AXm/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOdovlYq2MP8yQByRYH7ckM0rSUBJdcWD40ZTeU2ByfANotlT/uwJbsY2fu0BocLP8Yc8ynU7k7+sf4MQ1I+3wCUna1CBuMNPh4RhRbLqVtJyv6QyjMSTODzPRzPT3OeEe6fJzkgQ32Zo4H2ZHaQacXZzi0wdTQFVtMjSbEYF48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SmtqAfZF; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <60ecd12b-3c57-4eb1-ac7a-143249d25b47@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767737857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJ+B+jcTT3jusQkzN4ksZuciBNuLYOh6F98kwVXH+C8=;
	b=SmtqAfZFOlbb6EZ26Q4k5kl6fGW59YhQUa4JkD57JYrv75DogX0yH2iogKEo/VT9Tuaoj7
	7RdMwVjxnt/nBEI2fQ2/K43vlbdVenBQH4MOHAKuovHaUrrEV+InJ/u8doyKiaOSWCLtbf
	hTnftV5qKU+wZYVWVcNHXEhEOiJ4CwM=
Date: Tue, 6 Jan 2026 22:17:34 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 5/6] bpf: Add ECDSA signature verification
 kfuncs
To: Daniel Hodges <git@danielhodges.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Mykyta Yatsenko <yatsenko@meta.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song
 <yonghong.song@linux.dev>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260105173755.22515-1-git@danielhodges.dev>
 <20260105173755.22515-6-git@danielhodges.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260105173755.22515-6-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/01/2026 17:37, Daniel Hodges wrote:
> Add support for ECDSA signature verification in BPF programs through
> the unified bpf_crypto_ctx API.
> 
> Changes:
> - Add enum bpf_crypto_type_id for efficient type checking
> - Update all crypto type modules to set type_id field
> - Implement bpf_ecdsa_verify() for signature verification
> - Add bpf_ecdsa_keysize(), bpf_ecdsa_digestsize(), bpf_ecdsa_maxsize()
>    helper functions for querying context properties
> - Add type_id checks in all ECDSA kfuncs for type safety
> - Register ECDSA kfuncs for SCHED_CLS and XDP program types
> 
> ECDSA contexts are created using bpf_crypto_ctx_create() with
> type="sig" and appropriate algorithm (e.g., "p1363(ecdsa-nist-p256)").
> The public key is passed via the key/key_len fields in bpf_crypto_params.
> 
> This enables BPF programs to perform cryptographic signature verification
> for use cases such as packet authentication and content validation.
> 
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>   crypto/bpf_crypto_shash.c    |   1 +
>   crypto/bpf_crypto_sig.c      |   1 +
>   crypto/bpf_crypto_skcipher.c |   1 +
>   include/linux/bpf_crypto.h   |   7 +++
>   kernel/bpf/crypto.c          | 115 +++++++++++++++++++++++++++++++++++
>   5 files changed, 125 insertions(+)
> 
> diff --git a/crypto/bpf_crypto_shash.c b/crypto/bpf_crypto_shash.c
> index 95c178ec0ce8..6e9b0d757ec9 100644
> --- a/crypto/bpf_crypto_shash.c
> +++ b/crypto/bpf_crypto_shash.c
> @@ -74,6 +74,7 @@ static const struct bpf_crypto_type bpf_crypto_shash_type = {
>   	.digestsize	= bpf_crypto_shash_digestsize,
>   	.get_flags	= bpf_crypto_shash_get_flags,
>   	.owner		= THIS_MODULE,
> +	.type_id	= BPF_CRYPTO_TYPE_HASH,
>   	.name		= "hash",
>   };
>   
> diff --git a/crypto/bpf_crypto_sig.c b/crypto/bpf_crypto_sig.c
> index ad0d3810df8e..c6e67338cd40 100644
> --- a/crypto/bpf_crypto_sig.c
> +++ b/crypto/bpf_crypto_sig.c
> @@ -38,6 +38,7 @@ static const struct bpf_crypto_type bpf_crypto_sig_type = {
>   	.get_flags	= bpf_crypto_sig_get_flags,
>   	.setkey		= bpf_crypto_sig_setkey,
>   	.owner		= THIS_MODULE,
> +	.type_id	= BPF_CRYPTO_TYPE_SIG,
>   	.name		= "sig",
>   };
>   
> diff --git a/crypto/bpf_crypto_skcipher.c b/crypto/bpf_crypto_skcipher.c
> index a88798d3e8c8..79d310fbcc48 100644
> --- a/crypto/bpf_crypto_skcipher.c
> +++ b/crypto/bpf_crypto_skcipher.c
> @@ -63,6 +63,7 @@ static const struct bpf_crypto_type bpf_crypto_lskcipher_type = {
>   	.statesize	= bpf_crypto_lskcipher_statesize,
>   	.get_flags	= bpf_crypto_lskcipher_get_flags,
>   	.owner		= THIS_MODULE,
> +	.type_id	= BPF_CRYPTO_TYPE_SKCIPHER,
>   	.name		= "skcipher",
>   };
>   
> diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
> index c84371cc4e47..cf2c66f9782b 100644
> --- a/include/linux/bpf_crypto.h
> +++ b/include/linux/bpf_crypto.h
> @@ -3,6 +3,12 @@
>   #ifndef _BPF_CRYPTO_H
>   #define _BPF_CRYPTO_H
>   
> +enum bpf_crypto_type_id {
> +	BPF_CRYPTO_TYPE_SKCIPHER = 1,
> +	BPF_CRYPTO_TYPE_HASH,
> +	BPF_CRYPTO_TYPE_SIG,
> +};
> +
>   struct bpf_crypto_type {
>   	void *(*alloc_tfm)(const char *algo);
>   	void (*free_tfm)(void *tfm);
> @@ -17,6 +23,7 @@ struct bpf_crypto_type {
>   	unsigned int (*digestsize)(void *tfm);
>   	u32 (*get_flags)(void *tfm);
>   	struct module *owner;
> +	enum bpf_crypto_type_id type_id;
>   	char name[14];
>   };
>   
> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> index f593e7910d3d..3c57a8c31ea2 100644
> --- a/kernel/bpf/crypto.c
> +++ b/kernel/bpf/crypto.c
> @@ -9,6 +9,7 @@
>   #include <linux/scatterlist.h>
>   #include <linux/skbuff.h>
>   #include <crypto/skcipher.h>
> +#include <crypto/sig.h>
>   
>   struct bpf_crypto_type_list {
>   	const struct bpf_crypto_type *type;
> @@ -57,6 +58,7 @@ struct bpf_crypto_ctx {
>   	refcount_t usage;
>   };
>   
> +
>   int bpf_crypto_register_type(const struct bpf_crypto_type *type)
>   {
>   	struct bpf_crypto_type_list *node;
> @@ -400,6 +402,109 @@ __bpf_kfunc int bpf_crypto_hash(struct bpf_crypto_ctx *ctx,
>   }
>   #endif /* CONFIG_CRYPTO_HASH2 */
>   
> +#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
> +/**
> + * bpf_ecdsa_verify() - Verify ECDSA signature using pre-allocated context
> + * @ctx: ECDSA context created by bpf_crypto_ctx_create() with type "sig"
> + * @message: bpf_dynptr to the message hash to verify. Must be a trusted pointer.
> + * @signature: bpf_dynptr to the ECDSA signature in r || s format. Must be a trusted pointer.
> + *             Must be 64 bytes for P-256, 96 for P-384, 132 for P-521
> + *
> + * Verifies an ECDSA signature using a pre-allocated context. This function
> + * does not allocate memory and can be used in non-sleepable BPF programs.
> + * Uses bpf_dynptr to ensure safe memory access without risk of page faults.
> + */
> +__bpf_kfunc int bpf_ecdsa_verify(struct bpf_crypto_ctx *ctx,
> +				 const struct bpf_dynptr *message,
> +				 const struct bpf_dynptr *signature)
> +{
> +	const struct bpf_dynptr_kern *msg_kern = (struct bpf_dynptr_kern *)message;
> +	const struct bpf_dynptr_kern *sig_kern = (struct bpf_dynptr_kern *)signature;
> +	struct crypto_sig *sig_tfm;
> +	const u8 *msg_ptr, *sig_ptr;
> +	u32 msg_len, sig_len;
> +
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SIG)
> +		return -EINVAL;
> +
> +	msg_len = __bpf_dynptr_size(msg_kern);
> +	sig_len = __bpf_dynptr_size(sig_kern);
> +
> +	if (msg_len == 0 || sig_len == 0)
> +		return -EINVAL;
> +
> +	msg_ptr = __bpf_dynptr_data(msg_kern, msg_len);
> +	if (!msg_ptr)
> +		return -EINVAL;
> +
> +	sig_ptr = __bpf_dynptr_data(sig_kern, sig_len);
> +	if (!sig_ptr)
> +		return -EINVAL;
> +
> +	sig_tfm = (struct crypto_sig *)ctx->tfm;
> +	return crypto_sig_verify(sig_tfm, sig_ptr, sig_len, msg_ptr, msg_len);
> +}
> +
> +/**
> + * bpf_ecdsa_keysize() - Get the key size for ECDSA context
> + * @ctx: ECDSA context
> + *
> + * Returns: Key size in bits, or negative error code on failure
> + */
> +__bpf_kfunc int bpf_ecdsa_keysize(struct bpf_crypto_ctx *ctx)
> +{
> +	struct crypto_sig *sig_tfm;
> +
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SIG)
> +		return -EINVAL;
> +
> +	sig_tfm = (struct crypto_sig *)ctx->tfm;
> +	return crypto_sig_keysize(sig_tfm);
> +}
> +
> +/**
> + * bpf_ecdsa_digestsize() - Get the maximum digest size for ECDSA context
> + * @ctx: ECDSA context
> + */
> +__bpf_kfunc int bpf_ecdsa_digestsize(struct bpf_crypto_ctx *ctx)
> +{
> +	struct crypto_sig *sig_tfm;
> +
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SIG)
> +		return -EINVAL;
> +
> +	sig_tfm = (struct crypto_sig *)ctx->tfm;
> +	return crypto_sig_digestsize(sig_tfm);
> +}
> +
> +/**
> + * bpf_ecdsa_maxsize() - Get the maximum signature size for ECDSA context
> + * @ctx: ECDSA context
> + */
> +__bpf_kfunc int bpf_ecdsa_maxsize(struct bpf_crypto_ctx *ctx)
> +{
> +	struct crypto_sig *sig_tfm;
> +
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	if (ctx->type->type_id != BPF_CRYPTO_TYPE_SIG)
> +		return -EINVAL;
> +
> +	sig_tfm = (struct crypto_sig *)ctx->tfm;
> +	return crypto_sig_maxsize(sig_tfm);
> +}
> +#endif /* CONFIG_CRYPTO_ECDSA */
> +
>   __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(crypt_init_kfunc_btf_ids)
> @@ -419,6 +524,12 @@ BTF_ID_FLAGS(func, bpf_crypto_encrypt, KF_RCU)
>   #if IS_ENABLED(CONFIG_CRYPTO_HASH2)
>   BTF_ID_FLAGS(func, bpf_crypto_hash, KF_RCU)
>   #endif
> +#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
> +BTF_ID_FLAGS(func, bpf_ecdsa_verify, KF_RCU)
> +BTF_ID_FLAGS(func, bpf_ecdsa_keysize, 0)
> +BTF_ID_FLAGS(func, bpf_ecdsa_digestsize, 0)
> +BTF_ID_FLAGS(func, bpf_ecdsa_maxsize, 0)

Why keysize/digestsize/maxsize are introduced as kfuncs? My
understanding is that only bpf_sig_verify() has to be introduced. And no
ECDSA in the name as it's one of the types of signature algos.

> +#endif
>   BTF_KFUNCS_END(crypt_kfunc_btf_ids)
>   
>   static const struct btf_kfunc_id_set crypt_kfunc_set = {
> @@ -447,6 +558,10 @@ static int __init crypto_kfunc_init(void)
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &crypt_kfunc_set);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
>   					       &crypt_init_kfunc_set);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
> +					       &crypt_init_kfunc_set);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> +					       &crypt_init_kfunc_set);

I'm pretty sure it will fail because init functions have sleepable
*alloc() calls in the implementation and cannot be called in XDP/SCHED
context.

>   	return  ret ?: register_btf_id_dtor_kfuncs(bpf_crypto_dtors,
>   						   ARRAY_SIZE(bpf_crypto_dtors),
>   						   THIS_MODULE);


