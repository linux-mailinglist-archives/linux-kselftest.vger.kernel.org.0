Return-Path: <linux-kselftest+bounces-47244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B664FCABBA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 02:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DF893002A44
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 01:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E653D226863;
	Mon,  8 Dec 2025 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="qn1OFVam";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="o2k6oTbQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB28287E;
	Mon,  8 Dec 2025 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765157381; cv=none; b=VeTvlGwupufnmii/DJiVnn+LjMYhpNZptQIys6AYpyw7rUwBcJbp64xUGHVlgsT198ngjeRtHFyJf35oMF9bmYqBGIpHdNSp2UBLyh2PLe4mSfMzKU7gnvFcvohXKoYk3QrdBJeDalAJw57pTEliiLBKz6DvTypbeQB2Oj+q3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765157381; c=relaxed/simple;
	bh=pdwt3zeWN0oorVBYrbaOvLGiyiDYGh6DHDUsh1oevMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Er1GM4Q8AnQlV5DtDphNl5QdTfttpk3Q1VfeuX6J18nXmnNlK7tZ9IRL0LAoIeeXdhxRqKA2kz7YTZD9jPA05V12a897Gy6kPNDusqhzss4kb8R0rBhfnkdShPAPn0ZT2y6Usznk7PoBJATNHxVY1mtf2UFfD4D592XmRL414rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=qn1OFVam; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=o2k6oTbQ; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1765157377; bh=zzbRZmNvCzusI15d8qtxHkz
	yqQMcQps05SAxhl45XBw=; b=qn1OFVammxHLlOeuciAU1mO8Q6gVNMZLx/e9K8oYD03XL/LqV4
	czfLeMEiDulfGHZNkJ/nbwFNPCTKqeUmf8VqEGDwob8KzyUq8SAo7jyki3o9kVAbA8XZJg8Un34
	kRCpbGM5zBL1NRRFY+3qt4DRGGMZhtjg0s3tPPXWx4MCk6tUeWbgGLrITWW1pGmjMOvqvbLMsVl
	+y8pWV3yUPUcFXrXVMYljY6M1c/bXXIjyLMyscokwoaOrwM65tgJJRjykroMBMehKJUFsH+8QhR
	epHsqjjWiEhDURn9Njaa9pVbRqRdUsIgMVtQLrlnpGr3TiY8m2H1Z1WeVCI5K7cTh/w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1765157377; bh=zzbRZmNvCzusI15d8qtxHkz
	yqQMcQps05SAxhl45XBw=; b=o2k6oTbQ2tz8/I/wT6H7cVtFsOlNUacqsddLjTfp9VduhvNwxl
	phItyKVlV8ptFMO37/4yF96h7YGe4OJZxRAA==;
Date: Sun, 7 Dec 2025 20:29:37 -0500
From: Daniel Hodges <daniel@danielhodges.dev>
To: Song Liu <song@kernel.org>
Cc: Daniel Hodges <git@danielhodges.dev>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, vadim.fedorenko@linux.dev, 
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	shuah@kernel.org, bpf@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] crypto: Add BPF hash algorithm type
 registration module
Message-ID: <xn3on5azk5ip4x365mz52ejoxlfls63ykhhz4nautyeafd3fo3@ei5v476jxuyz>
References: <20251205173923.31740-1-git@danielhodges.dev>
 <20251205173923.31740-2-git@danielhodges.dev>
 <CAPhsuW4VJCsVKFeyH78XcHudk2RCPWp3EgAUGNEZsUXzdhHHxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4VJCsVKFeyH78XcHudk2RCPWp3EgAUGNEZsUXzdhHHxQ@mail.gmail.com>

On Fri, Dec 05, 2025 at 05:00:47PM -0800, Song Liu wrote:
> On Fri, Dec 5, 2025 at 9:40 AM Daniel Hodges <git@danielhodges.dev> wrote:
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
> >  crypto/bpf_crypto_shash.c | 94 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 97 insertions(+)
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
> > index 000000000000..39032e7dd602
> > --- /dev/null
> > +++ b/crypto/bpf_crypto_shash.c
> > @@ -0,0 +1,94 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/types.h>
> > +#include <linux/module.h>
> > +#include <linux/bpf_crypto.h>
> > +#include <crypto/hash.h>
> > +
> > +struct bpf_shash_ctx {
> > +       struct crypto_shash *tfm;
> > +       struct shash_desc desc;
> > +};
> 
> Instead of adding bpf_shash_ctx and bpf_ecdsa_ctx, can we extend
> bpf_crypto_ctx to cover all hash and ECDSA? bpf_crypto_ctx has a
> const pointer to bpf_crypto_type, so this should be possible?
> 
> Thanks,
> Song


Sounds good!

