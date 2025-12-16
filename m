Return-Path: <linux-kselftest+bounces-47618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DF1CC55DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 23:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 064413030DAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 22:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D5033F382;
	Tue, 16 Dec 2025 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKl/8QNt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BC832E13C
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765924535; cv=none; b=AiS6qStUvYSGLQKz0PdCRUj859mT7tFK3oCuRr2mQGAeJtZOI3Qj6D34uaG4TgJ9PGyKLXKEtSWwOU7y+DZnwZO4Xbw9LRw63qDGBnPjZqNWfS3a9P96ibwpZcrIDSiUfjXrrMCPbrIj8llC4PflH4m9q9caup05oig+V84LgFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765924535; c=relaxed/simple;
	bh=czyYHRS63XCenO0w0GUKXH28DzdMgrammOLJASI/vGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNE1GnePILKJHhODMkQV9t9AvHeQ3q/0rrVgKdrEteuL7eSWq5hNFsRtW3pMm12N//naTNgE7QT09iAeZIouSUpkA3zVKDB2BWsrdyZOoS8cwc6+CHmIsO+8xhmuI0Tmv9jMLMcUwma/wq43cSDW+Rp+nV16wo9KG5KZQvTIx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKl/8QNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2BAC2BCAF
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 22:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765924535;
	bh=czyYHRS63XCenO0w0GUKXH28DzdMgrammOLJASI/vGo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RKl/8QNtPcyroMjYJBWHMeeUdN+gUTJgu1o0FfOuHD7c7/WRyPy71xjvEd+mKQNwh
	 g1MgjhHnHu74oHjyONO/1fM5DzTEEan+crk5ILnqsF1NRYbVl1R6fOEpyz2DOSV/qg
	 EOorPj45VoogdDcLI2TQQ+rvyDf71FmOmD4tyotfTS1M7tfYxnSBIXUjRFKwE/EtQr
	 e8SZomf8FLwX46CJyn5NBBra+11nZmZT1+YDaLUXhEBzJeUvuyPvnOGXCwWDd1W+vj
	 AGeM6j2kZ//xFwKHZPVzkkbe7+Z29MOyQCxL7sWJhTaXWKbSyPrBcjwYFRpkdarbmc
	 H+vPheeBLnZGg==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88a367a1db0so41256936d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 14:35:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUc3o1a3+WJCPInSR1iiMFsDR4AKLCxI3TGfGOav5eLvPCs/O+aoGeOYkEzkiXgao5iv5Kkl2ZK6ODDtNXwY7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGSZkJJmshWP5Q3V5yF4GEng0X1l7xQEWR3zdvFCZeCiPjRdu+
	Zt3JgXhl9y6ubGcC00SUV/JfcakhLCUbv3Jsh6D1xqN2s4X56VR/rNpNQmyk25PayXYTLmCNmRb
	IROwF5tWV88Dk2xMRzslFuE+Ju+1YB10=
X-Google-Smtp-Source: AGHT+IFz5ZjeW33eep+I2TgddDjdwVyMg5n9B2cfhADNZvODCb2I/BAuA+yW3Xv7A3GiqJ4+10phrkX9Tnum/+suErk=
X-Received: by 2002:a05:6214:5c03:b0:880:3e03:3939 with SMTP id
 6a1803df08f44-8887e16e24fmr247957316d6.64.1765924534387; Tue, 16 Dec 2025
 14:35:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208030117.18892-1-git@danielhodges.dev> <20251208030117.18892-6-git@danielhodges.dev>
In-Reply-To: <20251208030117.18892-6-git@danielhodges.dev>
From: Song Liu <song@kernel.org>
Date: Wed, 17 Dec 2025 07:35:22 +0900
X-Gmail-Original-Message-ID: <CAPhsuW5OKja2U5x-X_N_F7DN7D_RAZYf9ryoMb4RBHtKKSidhw@mail.gmail.com>
X-Gm-Features: AQt7F2pQgGvpbiEFuf2dY0FESexCpC01QqhZkEXtdKJIyoLAtx09Eo6pMKaNpPI
Message-ID: <CAPhsuW5OKja2U5x-X_N_F7DN7D_RAZYf9ryoMb4RBHtKKSidhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/6] bpf: Add ECDSA signature verification kfuncs
To: Daniel Hodges <git@danielhodges.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, vadim.fedorenko@linux.dev, yatsenko@meta.com, 
	martin.lau@linux.dev, eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	yonghong.song@linux.dev, herbert@gondor.apana.org.au, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 5:43=E2=80=AFPM Daniel Hodges <git@danielhodges.dev>=
 wrote:
>
> Add context-based ECDSA signature verification kfuncs:
> - bpf_ecdsa_ctx_create(): Creates reusable ECDSA context with public key
> - bpf_ecdsa_verify(): Verifies signatures using the context
> - bpf_ecdsa_ctx_acquire(): Increments context reference count
> - bpf_ecdsa_ctx_release(): Releases context with RCU safety
>
> The ECDSA implementation supports NIST curves (P-256, P-384, P-521) and
> uses the kernel's crypto_sig API. Public keys must be in uncompressed
> format (0x04 || x || y), and signatures are in r || s format.
>
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>  kernel/bpf/crypto.c | 230 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 230 insertions(+)
>
> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> index 47e6a43a46d4..138abe58e87e 100644
> --- a/kernel/bpf/crypto.c
> +++ b/kernel/bpf/crypto.c
> @@ -9,6 +9,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/skbuff.h>
>  #include <crypto/skcipher.h>
> +#include <crypto/sig.h>
>
>  struct bpf_crypto_type_list {
>         const struct bpf_crypto_type *type;
> @@ -57,6 +58,21 @@ struct bpf_crypto_ctx {
>         refcount_t usage;
>  };
>
> +#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
> +/**
> + * struct bpf_ecdsa_ctx - refcounted BPF ECDSA context structure
> + * @tfm:       The crypto_sig transform for ECDSA operations
> + * @rcu:       The RCU head used to free the context with RCU safety
> + * @usage:     Object reference counter. When the refcount goes to 0, th=
e
> + *             memory is released with RCU safety.
> + */
> +struct bpf_ecdsa_ctx {
> +       struct crypto_sig *tfm;
> +       struct rcu_head rcu;
> +       refcount_t usage;
> +};
> +#endif

Can we use bpf_crypto_ctx for ECDSA?

Thanks,
Song

