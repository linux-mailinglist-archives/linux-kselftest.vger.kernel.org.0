Return-Path: <linux-kselftest+bounces-47253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8261CABF54
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 04:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BDE23009AA3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 03:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FA726B971;
	Mon,  8 Dec 2025 03:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAznC93n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CCB243954;
	Mon,  8 Dec 2025 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765164317; cv=none; b=Ge9c82oxVMArWUtd9B+Vi8GfZx0G5fIQ56kz98uJuEBeoYfxWVVSmIWtOi3ek9IMEv8I29q32uCrLC9QkOqdMVAxn8UA+1Br/Bqjipcw3TeOi2CSobxC9skWt/evCq54lz8+3/CDpPsWLR+BMNnV/o6LoTkd5K9khhP/XS5IsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765164317; c=relaxed/simple;
	bh=Vq7i7B29h2fqjR1umiBSo715h0HUytMRKH9Hte+65Cc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eCTBj5derpoaIwOrdwb6cremb1JFK9aKCd9/FDNx4myMmKmXd5Fa8grW84xSN3RVrDYIWS3j4ylFPleQev9sTm97WnP371k3Bd9tXN57c8zXMOGORYgCQ/EKxsnAM7JPfJdJZ7te0GBai8+VVIMCKV2VtrpZzUwXmEWSUfKV5bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAznC93n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A07FC4CEFB;
	Mon,  8 Dec 2025 03:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765164316;
	bh=Vq7i7B29h2fqjR1umiBSo715h0HUytMRKH9Hte+65Cc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hAznC93nEn6Au+T/cUOsz4mGRFMeziQbD1srfPVVyuS5/0aDuFBxKgH3qSEHFYGu/
	 1zcP4QsxJFpehMrYaoPFTSguevY/hxUnPar2oePJNQCBcNsQQYo3HGPjkDSbjvApN3
	 h/YakyERkF+Goh7cXjT8rlsxBKEtbxTDh52qPeTLlmKHAWMhbv0becF6UtQpf0LIc5
	 K0Vyspypqto2GF0ee5wN1rYTFda2/W8hNL7hdTjmVv1yj+HCFuZFkeG5rDdrFPYk16
	 kWxuF5iVBguGrLpOU8rzInmgy2sPtcXn9totqLnhHCX3qHVlC8bKO3aPXpPTI4ZM5D
	 qNHGDkhfSEq/g==
Content-Type: multipart/mixed; boundary="===============3683707251524056621=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <28c5b46387e15838028ba57a9d548a5ab066084a8eb7838a2bdeb32677dec11d@mail.kernel.org>
In-Reply-To: <20251208030117.18892-3-git@danielhodges.dev>
References: <20251208030117.18892-3-git@danielhodges.dev>
Subject: Re: [PATCH bpf-next v3 2/6] crypto: Add BPF hash algorithm type registration module
From: bot+bpf-ci@kernel.org
To: git@danielhodges.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,vadim.fedorenko@linux.dev,song@kernel.org,yatsenko@meta.com,martin.lau@linux.dev,eddyz87@gmail.com,haoluo@google.com,jolsa@kernel.org,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,yonghong.song@linux.dev,herbert@gondor.apana.org.au,davem@davemloft.net,linux-crypto@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,git@danielhodges.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Dec 2025 03:25:14 +0000 (UTC)

--===============3683707251524056621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/crypto/bpf_crypto_shash.c b/crypto/bpf_crypto_shash.c
> new file mode 100644
> index 000000000000..95c178ec0ce8
> --- /dev/null
> +++ b/crypto/bpf_crypto_shash.c
> @@ -0,0 +1,95 @@
[ ... ]
> +
> +static const struct bpf_crypto_type bpf_crypto_shash_type = {
> +	.alloc_tfm	= bpf_crypto_shash_alloc_tfm,
> +	.free_tfm	= bpf_crypto_shash_free_tfm,
> +	.has_algo	= bpf_crypto_shash_has_algo,
> +	.hash		= bpf_crypto_shash_hash,
> +	.digestsize	= bpf_crypto_shash_digestsize,
> +	.get_flags	= bpf_crypto_shash_get_flags,
> +	.owner		= THIS_MODULE,
> +	.name		= "hash",
> +};

The bpf_crypto_type implementation leaves several function pointers as
NULL (setkey, setauthsize, encrypt, decrypt, ivsize, statesize), which is
appropriate for plain hash algorithms. However, this creates an interface
contract mismatch with bpf_crypto_ctx_create() in kernel/bpf/crypto.c.

Looking at the caller bpf_crypto_ctx_create():

  Line 174-177:
    if (!params->key_len || params->key_len > sizeof(params->key)) {
        *err = -EINVAL;
        goto err_module_put;
    }

Can hash contexts be created? This check requires key_len to be non-zero,
but plain hash algorithms like SHA256 don't use keys. This prevents
creating hash contexts entirely.

  Line 186-189:
    ctx->tfm = type->alloc_tfm(params->algo);
    if (IS_ERR(ctx->tfm)) {
        *err = PTR_ERR(ctx->tfm);
        goto err_free_tfm;

Can bpf_crypto_shash_free_tfm handle ERR_PTR? When alloc_tfm fails and
returns ERR_PTR, the code stores it in ctx->tfm then jumps to err_free_tfm
which calls type->free_tfm(ctx->tfm). In bpf_crypto_shash_free_tfm(), the
code dereferences ctx->tfm without checking for ERR_PTR, which will crash:

    static void bpf_crypto_shash_free_tfm(void *tfm)
    {
        struct bpf_shash_ctx *ctx = tfm;
        crypto_free_shash(ctx->tfm);  /* dereferences ctx */
        kfree(ctx);
    }

  Line 198:
    *err = type->setkey(ctx->tfm, params->key, params->key_len);

Does this dereference NULL? The hash implementation doesn't provide setkey
(it's NULL in bpf_crypto_shash_type), but this line calls it
unconditionally.

  Line 207:
    ctx->siv_len = type->ivsize(ctx->tfm) + type->statesize(ctx->tfm);

Do these dereference NULL? The hash implementation doesn't provide ivsize
or statesize (both NULL), but this line calls them unconditionally.

Note: These issues are fixed in commit 14cc32f873e0 ("bpf: Add SHA hash
kfunc for cryptographic hashing") which makes the setkey, ivsize, and
statesize calls conditional, and fixes the ERR_PTR handling by changing
the error path from "goto err_free_tfm" to "goto err_free_ctx".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20015426139

--===============3683707251524056621==--

