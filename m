Return-Path: <linux-kselftest+bounces-47622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C360DCC57F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 00:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 715223048D60
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 23:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BD833FE34;
	Tue, 16 Dec 2025 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="E5vMgAtn";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="BkHFwpuX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB930E0F8;
	Tue, 16 Dec 2025 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765928152; cv=none; b=tUzp9Shj48xYGRvvc3eTLdrGPUl+Au3ADXmicHTEdUmrvUYtmDte8RN03CaWnsjkrkgsXye1SXC6Udkb6ogQOmt4FAwtTyKArQyX8bbbSDuKB5XMSWSsw9O7LnNgbL1yojxyaW5WvOSSOBUDh74fp1s5b6gdPSCjIiWuxIiNG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765928152; c=relaxed/simple;
	bh=15wLJHnfbeUJt9X4joo3frUNmfXd/QzyzUjSvL3EWUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBRQ0OWViuTWsuHy3Xi80sHkFYv7AmVhPLOcXgI5uPn0UFj6ddjgLy05d/sZzBcHOcDFcV0At85otdzeRCYrGJyO0IbFuhLRSp//Ja/XpJnztfwx4MvX49hqv9FpUpZX1JHKbBJHshXVmIHFWc7Wh3kKF4s/4+kYarbHUGW9AOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=E5vMgAtn; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=BkHFwpuX; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1765928110; bh=bOzMRdn4WQw7wke3e++qrlb
	5NebIvanL9Qa8EKe+Y+E=; b=E5vMgAtnXGp/sNPdI/xWr/oO8dGW58UpWXTYHOFaApwKlZKTL0
	QjEJvfAPzhGzHKSEIYbgFvdHUXw4xhv34InVM/LzhPgbFIapBcs7PXKHyC1shPAWRRRh0pvXF+b
	OJj49cRzJsj14UgDAdvHWfhgj4kt8He6gFbH5Z++Mae13Nc33qqSgjE6c1E3RE28kZJkf6ct9rS
	6JBXQ508IhDml7TQtYxOflNU7tNqUxRXX7YIUMiR3HUJy+8pl6BsH9jK7JxAuvmtQQRa2fSanwb
	j5hwC/EgkEgPQ+khqITavSKDJuBbJvfMS/2SuZp2S0O5AKo50OXY1eJpxFiQEbwScPA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1765928110; bh=bOzMRdn4WQw7wke3e++qrlb
	5NebIvanL9Qa8EKe+Y+E=; b=BkHFwpuXnmRhCx2XTTcy+eIx0Bwyl4eF8vcmPLf7sZB7EyqBbT
	jtpwPhxcfsfWdBm6IpJ9JAsiKWZFQ5rjk0Bw==;
Date: Tue, 16 Dec 2025 18:35:09 -0500
From: Daniel Hodges <daniel@danielhodges.dev>
To: Song Liu <song@kernel.org>
Cc: Daniel Hodges <git@danielhodges.dev>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	vadim.fedorenko@linux.dev, yatsenko@meta.com, martin.lau@linux.dev, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, yonghong.song@linux.dev, herbert@gondor.apana.org.au, 
	davem@davemloft.net, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/6] crypto: Add BPF hash algorithm type
 registration module
Message-ID: <fodxwl5yluc62ezyyrj2af4bv5rindnqrueaei4gvmoogqq2fq@5jti3sqfqsi7>
References: <20251208030117.18892-1-git@danielhodges.dev>
 <20251208030117.18892-3-git@danielhodges.dev>
 <CAPhsuW7c7cPatiRzwvZ=d_43m5XwPqfmphvNyyUu52G6rgbsQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7c7cPatiRzwvZ=d_43m5XwPqfmphvNyyUu52G6rgbsQA@mail.gmail.com>

On Wed, Dec 17, 2025 at 06:45:14AM +0900, Song Liu wrote:
> On Sun, Dec 7, 2025 at 7:01 PM Daniel Hodges <git@danielhodges.dev> wrote:
> >
> > Add bpf_crypto_shash module that registers a hash type with the BPF
> > crypto infrastructure, enabling BPF programs to access kernel hash
> > algorithms through a unified interface.
> >
> > Update the bpf_crypto_type interface with hash-specific callbacks:
> >    - alloc_tfm: Allocates crypto_shash context with proper descriptor size
> >    - free_tfm: Releases hash transform and context memory
> >    - has_algo: Checks algorithm availability via crypto_has_shash()
> >    - hash: Performs single-shot hashing via crypto_shash_digest()
> >    - digestsize: Returns the output size for the hash algorithm
> >    - get_flags: Exposes transform flags to BPF programs
> >
> > Update bpf_shash_ctx to contain crypto_shash transform and shash_desc
> > descriptor to accommodate algorithm-specific descriptor requirements.
> >
> > Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> > ---
> >  crypto/Makefile           |  3 ++
> >  crypto/bpf_crypto_shash.c | 95 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 98 insertions(+)
> >  create mode 100644 crypto/bpf_crypto_shash.c
> >
> > diff --git a/crypto/Makefile b/crypto/Makefile
> > index 16a35649dd91..853dff375906 100644
> > --- a/crypto/Makefile
> > +++ b/crypto/Makefile
> > @@ -30,6 +30,9 @@ obj-$(CONFIG_CRYPTO_ECHAINIV) += echainiv.o
> >  crypto_hash-y += ahash.o
> >  crypto_hash-y += shash.o
> >  obj-$(CONFIG_CRYPTO_HASH2) += crypto_hash.o
> > +ifeq ($(CONFIG_BPF_SYSCALL),y)
> > +obj-$(CONFIG_CRYPTO_HASH2) += bpf_crypto_shash.o
> > +endif
> >
> >  obj-$(CONFIG_CRYPTO_AKCIPHER2) += akcipher.o
> >  obj-$(CONFIG_CRYPTO_SIG2) += sig.o
> > diff --git a/crypto/bpf_crypto_shash.c b/crypto/bpf_crypto_shash.c
> > new file mode 100644
> > index 000000000000..95c178ec0ce8
> > --- /dev/null
> > +++ b/crypto/bpf_crypto_shash.c
> > @@ -0,0 +1,95 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> > +#include <linux/types.h>
> > +#include <linux/module.h>
> > +#include <linux/bpf_crypto.h>
> > +#include <crypto/hash.h>
> > +
> > +struct bpf_shash_ctx {
> > +       struct crypto_shash *tfm;
> > +       struct shash_desc desc;
> > +};
> > +
> > +static void *bpf_crypto_shash_alloc_tfm(const char *algo)
> > +{
> > +       struct bpf_shash_ctx *ctx;
> > +       struct crypto_shash *tfm;
> > +
> > +       tfm = crypto_alloc_shash(algo, 0, 0);
> > +       if (IS_ERR(tfm))
> > +               return tfm;
> > +
> > +       ctx = kzalloc(sizeof(*ctx) + crypto_shash_descsize(tfm), GFP_KERNEL);
> > +       if (!ctx) {
> > +               crypto_free_shash(tfm);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +
> > +       ctx->tfm = tfm;
> > +       ctx->desc.tfm = tfm;
> > +
> > +       return ctx;
> > +}
> 
> What if we let bpf_crypto_shash_alloc_tfm() return a "struct shash_desc"?
> shash_desc->tfm is already struct crypto_shash. This way, we don't need
> bpf_shash_ctx any more. Would this work?
> 
> Thanks,
> Song
Yeah, that's much cleaner than the void * return.

-Daniel

