Return-Path: <linux-kselftest+bounces-47620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7D2CC57C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 00:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A338B303C2A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 23:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C669733B943;
	Tue, 16 Dec 2025 23:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="C+O60v99";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="qDXXFE+i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F92494FE;
	Tue, 16 Dec 2025 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765928005; cv=none; b=slDkcHCeRwS+hR5oabncu0NrckkzKiEIyjBErDGKb3JCbsV+Fv75+as8fzWvx82uxTX+SN6rLL1wmWgwNb3dGLqegucY5Pp/JC0iVO5079dia+9iIMv6bKe0qOK0N4sAoAE+IRdKvlQ2JYRbd1WoSb8swHZd5q5vMkdqZ09VKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765928005; c=relaxed/simple;
	bh=QN9cKz43l56M77DQoU/gvQLJM/pRxx1iKuv1GfCqPMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4x/BL2k/otUZdP9bjGDS63PKAHW5ep+T1zPwM8TnMMngf2rOUnU5gC4RNNwt+RJ9NUzfk+EOyMdgbdSmFGAWVyaOoCPSEMzWbRYDoW5fBbiDfeYsXQEZgafD2dKKD450+/EhpQr253EAng/s41jfxpnPo0fbcD1h7dKdMnph1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=C+O60v99; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=qDXXFE+i; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1765927975; bh=g/xEp/DuAaJ9H5+LX06IBik
	XdRAbaKmHryWr83qTlWM=; b=C+O60v99N9mNfhGgOx+EKDged79OLsPxeWQuPkT9IaA5uiDFzD
	ztfNBsANb18aCKeJ0asTo1yLZn/HNXPsGUpB+K/n1PNcA1a2rjYLLwifvpcVDzBneH0i+dYktxY
	QdofXfjzCqqFqWvPcZGRnUKtlebFfy+bVx/1w8WWKPoqGe4J5H0HCe6GTKCddd+fNLn0vuUpd4N
	BZqOkGqtK/rUxc0nJnAEPNZt/nVqLSIikaKtR7BfaxjepooJO1w9pxjHWHybcKttSpoeb1WfFDT
	9rbCuNpoNmkMZpjzgFfDk/XhZoy73AEfa7iFCmaQzF6dHhder8PxMxFP3d76jM/TcOg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1765927975; bh=g/xEp/DuAaJ9H5+LX06IBik
	XdRAbaKmHryWr83qTlWM=; b=qDXXFE+iWjdNT+H/r8F8atD7onD70kz4IjW8aDB7CVZi8WXlwz
	t9cN50TSru36CqLhzkTc3r4s3r+JnMccxPCQ==;
Date: Tue, 16 Dec 2025 18:32:55 -0500
From: Daniel Hodges <daniel@danielhodges.dev>
To: Song Liu <song@kernel.org>
Cc: Daniel Hodges <git@danielhodges.dev>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	vadim.fedorenko@linux.dev, yatsenko@meta.com, martin.lau@linux.dev, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, yonghong.song@linux.dev, herbert@gondor.apana.org.au, 
	davem@davemloft.net, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 5/6] bpf: Add ECDSA signature verification
 kfuncs
Message-ID: <fysaambybt637trarwnupfearv4bv763tb5a2ohi7v2n4bkrzy@fca5hwea5g4w>
References: <20251208030117.18892-1-git@danielhodges.dev>
 <20251208030117.18892-6-git@danielhodges.dev>
 <CAPhsuW5OKja2U5x-X_N_F7DN7D_RAZYf9ryoMb4RBHtKKSidhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5OKja2U5x-X_N_F7DN7D_RAZYf9ryoMb4RBHtKKSidhw@mail.gmail.com>

On Wed, Dec 17, 2025 at 07:35:22AM +0900, Song Liu wrote:
> On Mon, Dec 8, 2025 at 5:43 PM Daniel Hodges <git@danielhodges.dev> wrote:
> >
> > Add context-based ECDSA signature verification kfuncs:
> > - bpf_ecdsa_ctx_create(): Creates reusable ECDSA context with public key
> > - bpf_ecdsa_verify(): Verifies signatures using the context
> > - bpf_ecdsa_ctx_acquire(): Increments context reference count
> > - bpf_ecdsa_ctx_release(): Releases context with RCU safety
> >
> > The ECDSA implementation supports NIST curves (P-256, P-384, P-521) and
> > uses the kernel's crypto_sig API. Public keys must be in uncompressed
> > format (0x04 || x || y), and signatures are in r || s format.
> >
> > Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> > ---
> >  kernel/bpf/crypto.c | 230 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 230 insertions(+)
> >
> > diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> > index 47e6a43a46d4..138abe58e87e 100644
> > --- a/kernel/bpf/crypto.c
> > +++ b/kernel/bpf/crypto.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/scatterlist.h>
> >  #include <linux/skbuff.h>
> >  #include <crypto/skcipher.h>
> > +#include <crypto/sig.h>
> >
> >  struct bpf_crypto_type_list {
> >         const struct bpf_crypto_type *type;
> > @@ -57,6 +58,21 @@ struct bpf_crypto_ctx {
> >         refcount_t usage;
> >  };
> >
> > +#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
> > +/**
> > + * struct bpf_ecdsa_ctx - refcounted BPF ECDSA context structure
> > + * @tfm:       The crypto_sig transform for ECDSA operations
> > + * @rcu:       The RCU head used to free the context with RCU safety
> > + * @usage:     Object reference counter. When the refcount goes to 0, the
> > + *             memory is released with RCU safety.
> > + */
> > +struct bpf_ecdsa_ctx {
> > +       struct crypto_sig *tfm;
> > +       struct rcu_head rcu;
> > +       refcount_t usage;
> > +};
> > +#endif
> 
> Can we use bpf_crypto_ctx for ECDSA?
> 
> Thanks,
> Song
Sure thing!

-Daniel

