Return-Path: <linux-kselftest+bounces-47621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9D6CC57DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 00:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCF2E304C2BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 23:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58584340280;
	Tue, 16 Dec 2025 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="iC1pwE9x";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="vxdeZVVq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ADF340298;
	Tue, 16 Dec 2025 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765928119; cv=none; b=OkdCpSKL7sFXisl2sBGdN/1NzDbO+KR0JEstj1T3enCWMYQua+863HysDE/6QffJckeksMgAes1PINdwzL+uxksqd8HhlFBkHGMzB3VbdGt5nqrgCORf+0LB3DlMmDFJZqYgJg0USTMeDOCQRyUUsYlu4chuZH+HXxm0QldFIxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765928119; c=relaxed/simple;
	bh=hElMxZN6madVOLZUpVWQnR5ezR9Pb3h6YGBFX8iptjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFCbzCGUztcVTyXJ+bKCG6/UGZy5WxQCA8y8h04nbLZGIsykv40AUjddCEhrnSPF1Vp7rwSCqZLWXtqlbjNU8fGbPhiZ9oaRNuF5qAMfJQXKCcg8xeaqH0I4/Lps3vwBq5IjpzyW6QmYF7gRIg+GHsZq5IyN9GnXt0IzMqOsV2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=iC1pwE9x; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=vxdeZVVq; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1765927913; bh=5ZvrxNYmFb5iZ4LBGKZ9dfO
	gxcUrSIPIEo34R1M81w0=; b=iC1pwE9xG0gfv+/SDglrAM+gkoNn9QDGdXTWJKcOQohHKubEAV
	iWYTb+M0jLf2vqOaTjSkUwPbB45Ie9/eCICL76IrzP7T01dWZaE3S+0+MBPrd9C2CKg+f1hxgQV
	5VBvrchTP1g1z4t83Bjt1NF9fvCGAAxS+bDW2kNY4sHy4GHJDcm0dwIoffJGqXwpkYjF8e70qci
	P8oW6IR7lQ1drmWwfBpKMAuFbB2Cb/zf3uF+XdU8fbHYLMA00SgDBE/P1Jm+RlccFIpYYykEF1A
	LP6ACDsyaZ/pTzexkEgMIJ9FFlB7HfyTR2OUnfjBN9XdPx4nLo3ATqnvxdTtccoSIRA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1765927913; bh=5ZvrxNYmFb5iZ4LBGKZ9dfO
	gxcUrSIPIEo34R1M81w0=; b=vxdeZVVqU7fZxRkmo0se1f9i3Y2AudOhxz0FhRhcuncEufUX0T
	t3ITnfLZiWsRfn0yPw4cgzAYQpvZWnobmCCg==;
Date: Tue, 16 Dec 2025 18:31:53 -0500
From: Daniel Hodges <daniel@danielhodges.dev>
To: Song Liu <song@kernel.org>
Cc: Daniel Hodges <git@danielhodges.dev>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	vadim.fedorenko@linux.dev, yatsenko@meta.com, martin.lau@linux.dev, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, yonghong.song@linux.dev, herbert@gondor.apana.org.au, 
	davem@davemloft.net, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add SHA hash kfunc for
 cryptographic hashing
Message-ID: <mgkjpyvhv5lnk5qwsj5q7f7e5zcxkmucefoik5n5c4c5otjrhi@5xjigugmoith>
References: <20251208030117.18892-1-git@danielhodges.dev>
 <20251208030117.18892-4-git@danielhodges.dev>
 <CAPhsuW7n2aZQ6ORA60xQd91rieXtbLbheBzKAhfLiwkRCHBzqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7n2aZQ6ORA60xQd91rieXtbLbheBzKAhfLiwkRCHBzqA@mail.gmail.com>

On Wed, Dec 17, 2025 at 06:58:43AM +0900, Song Liu wrote:
> On Sun, Dec 7, 2025 at 7:01 PM Daniel Hodges <git@danielhodges.dev> wrote:
> [...]
> > +
> > +       if (!ctx->type->hash)
> > +               return -EOPNOTSUPP;
> > +
> > +       data_len = __bpf_dynptr_size(data_kern);
> > +       out_len = __bpf_dynptr_size(out_kern);
> > +
> > +       if (data_len == 0)
> > +               return -EINVAL;
> > +
> > +       if (!ctx->type->digestsize)
> > +               return -EOPNOTSUPP;
> > +
> > +       unsigned int digestsize = ctx->type->digestsize(ctx->tfm);
> 
> ./scripts/checkpatch.pl will complain about this:
> 
> WARNING: Missing a blank line after declarations
> #109: FILE: kernel/bpf/crypto.c:387:
> +       unsigned int digestsize = ctx->type->digestsize(ctx->tfm);
> +       if (out_len < digestsize)
> 
> Please run ./scripts/checkpatch.pl on all the patches. It also highlights
> some other issues, such as we need to update the MAINTAINERS file.
> 
> Also, we don't want variable declaration in the middle of a code
> block.
> 
> > +       if (out_len < digestsize)
> > +               return -EINVAL;
> > +
> [...]
> >  static const struct btf_kfunc_id_set crypt_kfunc_set = {
> > @@ -383,6 +442,7 @@ static int __init crypto_kfunc_init(void)
> >         ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &crypt_kfunc_set);
> >         ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &crypt_kfunc_set);
> >         ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &crypt_kfunc_set);
> > +       ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &crypt_kfunc_set);
> 
> This enables all kfuncs in crypt_kfunc_set for BPF_PROG_TYPE_SYSCALL.
> We need a clear explanation why this is needed.
> 
> Thanks,
> Song
Sounds good! It might take me a day or so for the next set as I'm
traveling.

