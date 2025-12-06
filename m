Return-Path: <linux-kselftest+bounces-47219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B45CCA9CBE
	for <lists+linux-kselftest@lfdr.de>; Sat, 06 Dec 2025 02:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF845316A022
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Dec 2025 01:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D53212566;
	Sat,  6 Dec 2025 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qnzulgv+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F92D1F17E8
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Dec 2025 01:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764982860; cv=none; b=U3O66Xgf4JuATxaqHZLJC0A5C5u6vAiZiYAxAJrDmARVCvr3TNUjlBbf7Hks1Yn+7z/nEZ2VgtPleLhdn9+TuuPRkv7pWE8LC9zz6RNzotzXhDvt0pF2d3539wd4rWowur0TVpM9oGHo+vcPFBxGbzK5EZA35W8xiXN1+X6Izfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764982860; c=relaxed/simple;
	bh=J+fhDaXwYCVeolnHJqphArpPI9eh8evErlD9axz1MAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZuttAMRm5dcqVNkFZdeWktjMqG8bQFcn7fCiasKSlB5k5558Y2Ej+QPYxGgWI6WXY0Vd9pPFpcIkiu3Na2kd7pVHwCiLvB/Di8HyH4cO8nexWxBVdlK71xdkC8c7JYhMlFGZ+OATjRhqpMCMywfox3eMOdhj/ESNfw+QD4qTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qnzulgv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2590C19423
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Dec 2025 01:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764982859;
	bh=J+fhDaXwYCVeolnHJqphArpPI9eh8evErlD9axz1MAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qnzulgv+tx1SX+gb3y7ZAkb/WuMLbtEGT3HPvy9ftP9wrCUPKCyiVbF9bEuXSKx7l
	 B9QUHtEKZuHbYDRWGb7ALnLK/5L5ggWPQaMsc7GdZ+3tdnx5S4IQCdGCDaoDZog7n5
	 tH3I2q7UPnKqeFPHl6vqP5ClsCXmCfZTqhLjeoEb0KT+2Rbo/9TDjK9Qt/WtwlFmVJ
	 CFfp2y8C/9rHTM3RG4RT25rSRFhBd8dfT4ad3fFSDDceleOQkWiHrOYy7GwLstrVkC
	 Ci1iHNn4yi5mJ5G38s8jB3erYnayOkqV3yNiUz1EVBt4Ly3VFr8NDpRGyfnGu4clet
	 pfL13MDrGKrvQ==
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso24887811cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 17:00:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXqwG97x5NZmyXCKblALk7cbp3wku3JyqoVe9lR5ItM/kG7nL3yq1Xqztw+mMPmyjHv4elEO47vDWJypqVt3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Xwj/ljm9niJvUKA8heoO3C1XcZQOMDNFJ104A361IHskiHDP
	FKgWXss1/afiFRfvpGqW77C4+GfUMKYEaBjSuCKTZa9J/6Zd2nvzeK41IEqpX50evSZpr7bId2P
	be49/w81HaieCF6yc2fJvR6P89r/NHgI=
X-Google-Smtp-Source: AGHT+IGn2O6tFzSRWYNTMScR/52ZmXcrwxYz1GxPPNjvV5SR/F37LjxKdbUrGm55UrwcWcNQj1E2ievJ16SKdJy2FS0=
X-Received: by 2002:ac8:5d07:0:b0:4ed:af7b:69cf with SMTP id
 d75a77b69052e-4f03fe35945mr17379821cf.37.1764982858626; Fri, 05 Dec 2025
 17:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205173923.31740-1-git@danielhodges.dev> <20251205173923.31740-2-git@danielhodges.dev>
In-Reply-To: <20251205173923.31740-2-git@danielhodges.dev>
From: Song Liu <song@kernel.org>
Date: Fri, 5 Dec 2025 17:00:47 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4VJCsVKFeyH78XcHudk2RCPWp3EgAUGNEZsUXzdhHHxQ@mail.gmail.com>
X-Gm-Features: AWmQ_blGuzTaHdY2NfSViIYZKRdY3NEPQG8pgPpjCooOxctA71waN5ucdvC4R00
Message-ID: <CAPhsuW4VJCsVKFeyH78XcHudk2RCPWp3EgAUGNEZsUXzdhHHxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] crypto: Add BPF hash algorithm type
 registration module
To: Daniel Hodges <git@danielhodges.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	vadim.fedorenko@linux.dev, martin.lau@linux.dev, eddyz87@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, shuah@kernel.org, 
	bpf@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 9:40=E2=80=AFAM Daniel Hodges <git@danielhodges.dev>=
 wrote:
>
> Add bpf_crypto_shash module that registers a hash type with the BPF
> crypto infrastructure, enabling BPF programs to access kernel hash
> algorithms through a unified interface.
>
> Update the bpf_crypto_type interface with hash-specific callbacks:
>    - alloc_tfm: Allocates crypto_shash context with proper descriptor siz=
e
>    - free_tfm: Releases hash transform and context memory
>    - has_algo: Checks algorithm availability via crypto_has_shash()
>    - hash: Performs single-shot hashing via crypto_shash_digest()
>    - digestsize: Returns the output size for the hash algorithm
>    - get_flags: Exposes transform flags to BPF programs
>
> Update bpf_shash_ctx to contain crypto_shash transform and shash_desc
> descriptor to accommodate algorithm-specific descriptor requirements.
>
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>  crypto/Makefile           |  3 ++
>  crypto/bpf_crypto_shash.c | 94 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100644 crypto/bpf_crypto_shash.c
>
> diff --git a/crypto/Makefile b/crypto/Makefile
> index 16a35649dd91..853dff375906 100644
> --- a/crypto/Makefile
> +++ b/crypto/Makefile
> @@ -30,6 +30,9 @@ obj-$(CONFIG_CRYPTO_ECHAINIV) +=3D echainiv.o
>  crypto_hash-y +=3D ahash.o
>  crypto_hash-y +=3D shash.o
>  obj-$(CONFIG_CRYPTO_HASH2) +=3D crypto_hash.o
> +ifeq ($(CONFIG_BPF_SYSCALL),y)
> +obj-$(CONFIG_CRYPTO_HASH2) +=3D bpf_crypto_shash.o
> +endif
>
>  obj-$(CONFIG_CRYPTO_AKCIPHER2) +=3D akcipher.o
>  obj-$(CONFIG_CRYPTO_SIG2) +=3D sig.o
> diff --git a/crypto/bpf_crypto_shash.c b/crypto/bpf_crypto_shash.c
> new file mode 100644
> index 000000000000..39032e7dd602
> --- /dev/null
> +++ b/crypto/bpf_crypto_shash.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/bpf_crypto.h>
> +#include <crypto/hash.h>
> +
> +struct bpf_shash_ctx {
> +       struct crypto_shash *tfm;
> +       struct shash_desc desc;
> +};

Instead of adding bpf_shash_ctx and bpf_ecdsa_ctx, can we extend
bpf_crypto_ctx to cover all hash and ECDSA? bpf_crypto_ctx has a
const pointer to bpf_crypto_type, so this should be possible?

Thanks,
Song

