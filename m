Return-Path: <linux-kselftest+bounces-47198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC834CA8F49
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 19:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 303343029F48
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D1B3656F2;
	Fri,  5 Dec 2025 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz8SbbSh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082513656E3
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960656; cv=none; b=F1vpA9QEmNOI6rsbanZKIWlN/K/xnF/yM9eKtXoGJEQzpu1egQR5DpjjGPUEU1wFyYu3RpAlJIXVpQp0VnLIJyv8wLF3BnUdtL4mdWzcjRf+QY6fh7pgvICEiLZ2Z8zCJl5IZ167GYu+LINct1fzwNmwqe6HmqFBj4Infstup88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960656; c=relaxed/simple;
	bh=UBKr0ISxy3/NRj2i2jOnTJqO6nRXBcHTm+VOrHhEolU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXbHsDPZbaNJXhAIRHbXDq5IX9Z7iW0i0mBrpZtsC4b8lWaowd6dHjea/lQbYggKU4ppmECb7DoWffV0yNCoqxwxjymjThfDmaMvFByOeHknBBJOir98SVcVs57tO1/Xu1ZIzFCrgIkuMwkA4fnyfLR0fb6BLbdGiXZHFR8qcto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mz8SbbSh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso31452015e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 10:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764960652; x=1765565452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kM/KDQdobCWd595EPWaLr5CulKCAszd3ydD+m6x7q7s=;
        b=mz8SbbShaoy21AnRg0h0fmmlwjSUVLmxByhuVcLXVHueQHHkrGiaXkOkA8G6wp555R
         8YvcEmDNyTr9FlJEFz4fJArbJlEfllJ+NEgo3kbXyb+/AE+NN8wqAL5Nu/SBHgoeiofu
         6qLcBcx0YEIGvY7BD6dH9ZkPNsxc+2qf4kmuNSJlptakqtxngltYoyGAXMmVwmnAiRbx
         Fpaqgbck/HM22Khy3zD3OP7WFUWmgMI59DCdrRan1qmwK0+wqkqBnNkFXTVQ6E7P0zNt
         sZBh2ggqKIihHh5WI8a3fvTVvutfzRMukEOrv0JztAwTTjeRwJ680byHHO/wTrMhiZzv
         UWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764960652; x=1765565452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kM/KDQdobCWd595EPWaLr5CulKCAszd3ydD+m6x7q7s=;
        b=C3+wsyruW7+exlM1LeURwIajEzckbV5Io0mhzQ3E7Cghu+agOsoZKYdKDlqI83JufJ
         jZ2rdJsRmGMQOB2Tn6+OQBDgY/K5tlyX4pUk+CJqmaz6txsKSMMypJuNmFNEXmyk/DMl
         F6DXvrN4MZ3eUOlCIxmhTlAx9GaPrdMaRrVI17XUrGMUQD1MKuHdLOsXLgXQrscM8hkD
         iuWPsUblL351vdREm7yopryAgveO7mW1Tzr8kiQJu5x0YL8lIlSdVrwl4DxbUZfofNaV
         xhTH9DAjZ4fhcSDkvphxU60yZgY6fqpewRcmfbCpnesusz1Gc8zgxakK8LIeXLMghTVZ
         7ZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0U0ONPuP75t8ujf5y+spdVSsDvwp8FsbNGkq5QYOj0bUCH1CkkQ6KXfa4OyFVD1aa0zQ4ZTjuq1SLJjMIdUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVRsEWMLxGNn9YXKgjxAsAWhKsKmjBUzdj6ZK11JYqBpQ+hiZi
	uSLd4+UQT2KXHRTc1jNnb5YcPe3dZIthn9Tri0QvdsY3RKNz0ISC6mhp
X-Gm-Gg: ASbGncuqVi3Snm48OWZipzS1pidxYwCbYJ3OJxEbStJRg/c2juULIafAfGB19xXqw9q
	Y5TucysRJ2kddLy+pxFCnKvcgV3CnNjcJMB6VhMaO9gnUkGl2+S35Y1YzTbuMKyvdhb3W/khEH4
	tori3h8LhTGe7j0pA/a1zJF8Lk2aGVmENxv75ZrECTBdgh/PdOWJk9JLV9tk4gTENMSOH27NbQi
	4vlMwyPPNHIvWnZyn/Pm/N6enDR+22kEtvGmcOwavEHvWjImg0NcMiXSIfx2QBmjNXh9y6ChKhP
	iqZjKXapRkfc/x3mmo90g7JDd9KdkHey/x63lepBU0pr2Bn23pmfIemm908zqtLWrKe2Rxlnnlc
	AHBygLHC/s/T7TqUqZXpqsxWhzsOhfzfDYYidKoi/rmlkF1zYYbSsfGWkUmVATjjFbIN14P7aXh
	XOscE1Jc+SIXvGA8MbiLBjKATXunR9gfqUTcHVJbybmRi5hAcuejpj7ZSdbQU=
X-Google-Smtp-Source: AGHT+IEc4nhDNGEwmygKmuduA5tFJljAPV4Ij44UAFfjrsvy/czwfc50slZqky4wZIf6baHYa01TMQ==
X-Received: by 2002:a05:600c:8284:b0:477:5aaa:57a3 with SMTP id 5b1f17b1804b1-47939df534amr3964615e9.2.1764960652262;
        Fri, 05 Dec 2025 10:50:52 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:8efb:4626:6bd3:398c? ([2620:10d:c092:500::6:567e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47933aef61fsm61077185e9.7.2025.12.05.10.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 10:50:51 -0800 (PST)
Message-ID: <276ec0e0-2576-4595-a713-02a9223b6aa3@gmail.com>
Date: Fri, 5 Dec 2025 18:50:48 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Add SHA hash kfunc for cryptographic
 hashing
To: Daniel Hodges <git@danielhodges.dev>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, vadim.fedorenko@linux.dev
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 herbert@gondor.apana.org.au, davem@davemloft.net, shuah@kernel.org,
 bpf@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251205173923.31740-1-git@danielhodges.dev>
 <20251205173923.31740-3-git@danielhodges.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251205173923.31740-3-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/25 17:39, Daniel Hodges wrote:
> Extend bpf_crypto_type structure with hash operations:
>   - hash(): Performs hashing operation
>   - digestsize(): Returns hash output size
>
> Update bpf_crypto_ctx_create() to support keyless operations:
>   - Hash algorithms don't require keys, unlike ciphers
>   - Only validates key presence if type->setkey is defined
>   - Conditionally sets IV/state length for cipher operations only
>
> Add bpf_crypto_hash() kfunc that works with any hash algorithm
> registered in the kernel's crypto API through the BPF crypto type
> system. This enables BPF programs to compute cryptographic hashes for
> use cases such as content verification, integrity checking, and data
> authentication.
>
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>   include/linux/bpf_crypto.h |  2 +
>   kernel/bpf/crypto.c        | 76 ++++++++++++++++++++++++++++++++++----
>   2 files changed, 70 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
> index a41e71d4e2d9..c84371cc4e47 100644
> --- a/include/linux/bpf_crypto.h
> +++ b/include/linux/bpf_crypto.h
> @@ -11,8 +11,10 @@ struct bpf_crypto_type {
>   	int (*setauthsize)(void *tfm, unsigned int authsize);
>   	int (*encrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
>   	int (*decrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
> +	int (*hash)(void *tfm, const u8 *data, u8 *out, unsigned int len);
>   	unsigned int (*ivsize)(void *tfm);
>   	unsigned int (*statesize)(void *tfm);
> +	unsigned int (*digestsize)(void *tfm);
>   	u32 (*get_flags)(void *tfm);
>   	struct module *owner;
>   	char name[14];
> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> index 83c4d9943084..95625c7ffb1a 100644
> --- a/kernel/bpf/crypto.c
> +++ b/kernel/bpf/crypto.c
> @@ -171,7 +171,12 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
>   		goto err_module_put;
>   	}
>   
> -	if (!params->key_len || params->key_len > sizeof(params->key)) {
> +	/* Hash operations don't require a key, but cipher operations do */
> +	if (params->key_len > sizeof(params->key)) {
> +		*err = -EINVAL;
> +		goto err_module_put;
> +	}
> +	if (!params->key_len && type->setkey) {
>   		*err = -EINVAL;
>   		goto err_module_put;
>   	}
> @@ -195,16 +200,19 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
>   			goto err_free_tfm;
>   	}
>   
> -	*err = type->setkey(ctx->tfm, params->key, params->key_len);
> -	if (*err)
> -		goto err_free_tfm;
> +	if (params->key_len) {
> +		*err = type->setkey(ctx->tfm, params->key, params->key_len);
> +		if (*err)
> +			goto err_free_tfm;
>   
> -	if (type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY) {
> -		*err = -EINVAL;
> -		goto err_free_tfm;
> +		if (type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY) {
> +			*err = -EINVAL;
> +			goto err_free_tfm;
> +		}
>   	}
>   
> -	ctx->siv_len = type->ivsize(ctx->tfm) + type->statesize(ctx->tfm);
> +	if (type->ivsize && type->statesize)
> +		ctx->siv_len = type->ivsize(ctx->tfm) + type->statesize(ctx->tfm);
>   
>   	refcount_set(&ctx->usage, 1);
>   
> @@ -343,6 +351,54 @@ __bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
>   	return bpf_crypto_crypt(ctx, src_kern, dst_kern, siv_kern, false);
>   }
>   
> +#if IS_ENABLED(CONFIG_CRYPTO_HASH2)
> +/**
> + * bpf_crypto_hash() - Compute hash using configured context
> + * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
> + * @data:	bpf_dynptr to the input data to hash. Must be a trusted pointer.
> + * @out:	bpf_dynptr to the output buffer. Must be a trusted pointer.
> + *
> + * Computes hash of the input data using the crypto context. The output buffer
> + * must be at least as large as the digest size of the hash algorithm.
> + */
> +__bpf_kfunc int bpf_crypto_hash(struct bpf_crypto_ctx *ctx,
> +				const struct bpf_dynptr *data,
> +				const struct bpf_dynptr *out)
> +{
> +	const struct bpf_dynptr_kern *data_kern = (struct bpf_dynptr_kern *)data;
> +	const struct bpf_dynptr_kern *out_kern = (struct bpf_dynptr_kern *)out;
> +	u32 data_len, out_len;
> +	const u8 *data_ptr;
> +	u8 *out_ptr;
> +
> +	if (!ctx->type->hash)
> +		return -EOPNOTSUPP;
> +
> +	data_len = __bpf_dynptr_size(data_kern);
> +	out_len = __bpf_dynptr_size(out_kern);
__bpf_dynptr_size() returns u64, as well as __bpf_dynptr_data_rw()
takes u64 as length parameter, it may be worth using that type for
data_len and out_len.
> +
> +	if (data_len == 0)
> +		return -EINVAL;
> +
> +	if (!ctx->type->digestsize)
> +		return -EOPNOTSUPP;
> +
> +	unsigned int digestsize = ctx->type->digestsize(ctx->tfm);
> +	if (out_len < digestsize)
> +		return -EINVAL;
> +
> +	data_ptr = __bpf_dynptr_data(data_kern, data_len);
> +	if (!data_ptr)
> +		return -EINVAL;
> +
> +	out_ptr = __bpf_dynptr_data_rw(out_kern, out_len);
> +	if (!out_ptr)
> +		return -EINVAL;
> +
> +	return ctx->type->hash(ctx->tfm, data_ptr, out_ptr, data_len);
> +}
> +#endif /* CONFIG_CRYPTO_HASH2 */
> +
>   __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(crypt_init_kfunc_btf_ids)
> @@ -359,6 +415,9 @@ static const struct btf_kfunc_id_set crypt_init_kfunc_set = {
>   BTF_KFUNCS_START(crypt_kfunc_btf_ids)
>   BTF_ID_FLAGS(func, bpf_crypto_decrypt, KF_RCU)
>   BTF_ID_FLAGS(func, bpf_crypto_encrypt, KF_RCU)
> +#if IS_ENABLED(CONFIG_CRYPTO_HASH2)
> +BTF_ID_FLAGS(func, bpf_crypto_hash, KF_RCU)
> +#endif
>   BTF_KFUNCS_END(crypt_kfunc_btf_ids)
>   
>   static const struct btf_kfunc_id_set crypt_kfunc_set = {
> @@ -383,6 +442,7 @@ static int __init crypto_kfunc_init(void)
>   	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &crypt_kfunc_set);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &crypt_kfunc_set);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &crypt_kfunc_set);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &crypt_kfunc_set);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
>   					       &crypt_init_kfunc_set);
>   	return  ret ?: register_btf_id_dtor_kfuncs(bpf_crypto_dtors,


