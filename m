Return-Path: <linux-kselftest+bounces-47243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8056ECABB94
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 02:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 402503007C78
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 01:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6CF21CC59;
	Mon,  8 Dec 2025 01:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="PcGAOgUa";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="tZITcM/8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98020C00A;
	Mon,  8 Dec 2025 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765157345; cv=none; b=bURen5ZLxc/rN2ZpUHKySR/jF55ajrtSyst/GLDr+HfBNJ6QK9aBhjhfl8zGsMxyTv5Rw3tQtTPCB7YNLQvWzO3schdSk5VmrhqoEoFz614+5v8v5iEtRPRJD/swYx/W8LLlrvKjht4dZuSf+XI9pjAnhg4N4epPE15BXu21Mmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765157345; c=relaxed/simple;
	bh=/vCeJPmwLRTPe+QTThJ+UHIm5tpmjt9KiVsy5jcRHOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=An28KizN9StikHB9t5OrCpdPArvt7WNX1zwd5qegE4/R0Ww66gAfMpeR07AR5KdVwYAK/f2dln6nChdnYSVmAgkqgPgOYw1Vf5SKkDH766zV8LcH7xSUZ7izougzrzGs9tNMznIJninKFaWCtn6DwIjZbQUSl5lDzYEf1mtKdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=PcGAOgUa; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=tZITcM/8; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1765157336; bh=9OzgqW7eCOiZnkL0fut6f21
	0Lss6sJuynW09nbHpU6A=; b=PcGAOgUaJnipx42FL+r6bA2M1m3aLZsTe4vIPKZlOjNLFA9PES
	yXNXsdic1DRsQ72yOBfW9Snss/XjQYOZtJy+OLTUSc6HiLjx6jNLUeZ2ettk8eoTOQrF2rIRLfl
	c/lXjokdBzSOIQyKo+g1hhPpnZdfUgIGrDN4NQu64+uHUZcfKBd9sDoCo+GIo/Cw/29Ec1rlu04
	VIUTnJXBrGmGBak/uDpf5bV+/natyuEmcM2ebSWTwd0gFnpPgZBXg2xBYCtYsXnvoc0YlDnEMo5
	RlgdVkSW4BG6iVl5jrWBs1I/0yo6wwmST9zjRoht1/8lbNJvAdiiJxM5tcVlofMthig==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1765157336; bh=9OzgqW7eCOiZnkL0fut6f21
	0Lss6sJuynW09nbHpU6A=; b=tZITcM/8rz1y+PEyLBWgfENlG7DpH2sq/2+YJASjVOL0OXcOdH
	qr3rf3w9+PhJKvlk0cYlEYLKssm6BvEnySBQ==;
Date: Sun, 7 Dec 2025 20:28:55 -0500
From: Daniel Hodges <daniel@danielhodges.dev>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Daniel Hodges <git@danielhodges.dev>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, vadim.fedorenko@linux.dev, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	shuah@kernel.org, bpf@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Add SHA hash kfunc for
 cryptographic hashing
Message-ID: <y3i7w7bi4hozfjj3yzhfuvzagj4tkhd2czkwlkcj3jlyfvgoi3@cjypa2yl4t2u>
References: <20251205173923.31740-1-git@danielhodges.dev>
 <20251205173923.31740-3-git@danielhodges.dev>
 <276ec0e0-2576-4595-a713-02a9223b6aa3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276ec0e0-2576-4595-a713-02a9223b6aa3@gmail.com>

On Fri, Dec 05, 2025 at 06:50:48PM +0000, Mykyta Yatsenko wrote:
> On 12/5/25 17:39, Daniel Hodges wrote:
> > Extend bpf_crypto_type structure with hash operations:
> >   - hash(): Performs hashing operation
> >   - digestsize(): Returns hash output size
> > 
> > Update bpf_crypto_ctx_create() to support keyless operations:
> >   - Hash algorithms don't require keys, unlike ciphers
> >   - Only validates key presence if type->setkey is defined
> >   - Conditionally sets IV/state length for cipher operations only
> > 
> > Add bpf_crypto_hash() kfunc that works with any hash algorithm
> > registered in the kernel's crypto API through the BPF crypto type
> > system. This enables BPF programs to compute cryptographic hashes for
> > use cases such as content verification, integrity checking, and data
> > authentication.
> > 
> > Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> > ---
> >   include/linux/bpf_crypto.h |  2 +
> >   kernel/bpf/crypto.c        | 76 ++++++++++++++++++++++++++++++++++----
> >   2 files changed, 70 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
> > index a41e71d4e2d9..c84371cc4e47 100644
> > --- a/include/linux/bpf_crypto.h
> > +++ b/include/linux/bpf_crypto.h
> > @@ -11,8 +11,10 @@ struct bpf_crypto_type {
> >   	int (*setauthsize)(void *tfm, unsigned int authsize);
> >   	int (*encrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
> >   	int (*decrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
> > +	int (*hash)(void *tfm, const u8 *data, u8 *out, unsigned int len);
> >   	unsigned int (*ivsize)(void *tfm);
> >   	unsigned int (*statesize)(void *tfm);
> > +	unsigned int (*digestsize)(void *tfm);
> >   	u32 (*get_flags)(void *tfm);
> >   	struct module *owner;
> >   	char name[14];
> > diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> > index 83c4d9943084..95625c7ffb1a 100644
> > --- a/kernel/bpf/crypto.c
> > +++ b/kernel/bpf/crypto.c
> > @@ -171,7 +171,12 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
> >   		goto err_module_put;
> >   	}
> > -	if (!params->key_len || params->key_len > sizeof(params->key)) {
> > +	/* Hash operations don't require a key, but cipher operations do */
> > +	if (params->key_len > sizeof(params->key)) {
> > +		*err = -EINVAL;
> > +		goto err_module_put;
> > +	}
> > +	if (!params->key_len && type->setkey) {
> >   		*err = -EINVAL;
> >   		goto err_module_put;
> >   	}
> > @@ -195,16 +200,19 @@ bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
> >   			goto err_free_tfm;
> >   	}
> > -	*err = type->setkey(ctx->tfm, params->key, params->key_len);
> > -	if (*err)
> > -		goto err_free_tfm;
> > +	if (params->key_len) {
> > +		*err = type->setkey(ctx->tfm, params->key, params->key_len);
> > +		if (*err)
> > +			goto err_free_tfm;
> > -	if (type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY) {
> > -		*err = -EINVAL;
> > -		goto err_free_tfm;
> > +		if (type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY) {
> > +			*err = -EINVAL;
> > +			goto err_free_tfm;
> > +		}
> >   	}
> > -	ctx->siv_len = type->ivsize(ctx->tfm) + type->statesize(ctx->tfm);
> > +	if (type->ivsize && type->statesize)
> > +		ctx->siv_len = type->ivsize(ctx->tfm) + type->statesize(ctx->tfm);
> >   	refcount_set(&ctx->usage, 1);
> > @@ -343,6 +351,54 @@ __bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
> >   	return bpf_crypto_crypt(ctx, src_kern, dst_kern, siv_kern, false);
> >   }
> > +#if IS_ENABLED(CONFIG_CRYPTO_HASH2)
> > +/**
> > + * bpf_crypto_hash() - Compute hash using configured context
> > + * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
> > + * @data:	bpf_dynptr to the input data to hash. Must be a trusted pointer.
> > + * @out:	bpf_dynptr to the output buffer. Must be a trusted pointer.
> > + *
> > + * Computes hash of the input data using the crypto context. The output buffer
> > + * must be at least as large as the digest size of the hash algorithm.
> > + */
> > +__bpf_kfunc int bpf_crypto_hash(struct bpf_crypto_ctx *ctx,
> > +				const struct bpf_dynptr *data,
> > +				const struct bpf_dynptr *out)
> > +{
> > +	const struct bpf_dynptr_kern *data_kern = (struct bpf_dynptr_kern *)data;
> > +	const struct bpf_dynptr_kern *out_kern = (struct bpf_dynptr_kern *)out;
> > +	u32 data_len, out_len;
> > +	const u8 *data_ptr;
> > +	u8 *out_ptr;
> > +
> > +	if (!ctx->type->hash)
> > +		return -EOPNOTSUPP;
> > +
> > +	data_len = __bpf_dynptr_size(data_kern);
> > +	out_len = __bpf_dynptr_size(out_kern);
> __bpf_dynptr_size() returns u64, as well as __bpf_dynptr_data_rw()
> takes u64 as length parameter, it may be worth using that type for
> data_len and out_len.


Yeah, that makes sense, will queue that up.

