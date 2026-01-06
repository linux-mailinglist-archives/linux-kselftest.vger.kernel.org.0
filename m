Return-Path: <linux-kselftest+bounces-48347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A4CFB34A
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 23:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79E663004879
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 22:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3404C287503;
	Tue,  6 Jan 2026 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="njmTilVw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632CA27586E
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737304; cv=none; b=FMmKQ5Ee+xPEqR0W76fipLfwuxk8/jOOLrrnqbSEKEq+pU1ah1MPIUMLYkOwobzyyiSreOxA0sBlaMW0ZkmymgIBGL+pyLkphMrXVrT2e4CHb0bGO/pali6/NdrqwSUvtKXns4SEBct79d3hXnQCsBqgpeNJ8HWFKGHuOkXDkbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737304; c=relaxed/simple;
	bh=bU8ogkEbaGHhNlVPkDcepHcBU2SD511/GXcJgtgYpa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6y/q3p6HNrT0tNnBdVDRLrRC/MZf6wA8qVAHJqpJbJQynkQ3ZguQFDrjC3rzNULeTY+I3q3TVX6AJuUxDOUxwB0qCQXwWbqD/+E5/bPeeEfwTIyHKI9hFbcMOQ1hniXDdpW201e9Q07hT4DjFrApxUGTyhrqndYfH6rdfOjtfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=njmTilVw; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ede58147-3bde-4408-9f69-d2d717b4ee40@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767737290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSzAwhWmuZ11Qa58R83OSA0oTMM8Un3L3Ne+d4r8jec=;
	b=njmTilVwW1iTQR/hfzm4MXcfzCifDvyC4qfnNuZ5hdrJyP/wpIIebo/TL1l8YdIzeIqiYi
	e+Y3SvyJp7cpk1Z5d/5OZyPvt9QRTsv4rdaOQH6z2oX3DCK1fc5/2xcpCbp5gZFA4cFITv
	uzcSIjM+ZWYx3e+MO6WCwCYbryMOgWo=
Date: Tue, 6 Jan 2026 22:08:06 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/6] crypto: Add BPF signature algorithm type
 registration module
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
 <20260105173755.22515-3-git@danielhodges.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260105173755.22515-3-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/01/2026 17:37, Daniel Hodges wrote:
> Add a new bpf_crypto_sig module that registers signature verification
> algorithms with the BPF crypto type system. This enables signature
> operations (like ECDSA) to use the unified bpf_crypto_ctx structure
> instead of requiring separate context types.
> 
> The module provides:
> - alloc_tfm/free_tfm for crypto_sig transform lifecycle
> - has_algo to check algorithm availability
> - get_flags for crypto API flags
> 
> This allows ECDSA and other signature verification operations to
> integrate with the existing BPF crypto infrastructure.
> 
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>

[...]

> +static int bpf_crypto_sig_setkey(void *tfm, const u8 *key, unsigned int keylen)
> +{
> +	return crypto_sig_set_pubkey(tfm, key, keylen);
> +}

That effectively means that signature verification only is provided for
BPF programs? Do we plan to extend API to sign a buffer?

> +
> +static const struct bpf_crypto_type bpf_crypto_sig_type = {
> +	.alloc_tfm	= bpf_crypto_sig_alloc_tfm,
> +	.free_tfm	= bpf_crypto_sig_free_tfm,
> +	.has_algo	= bpf_crypto_sig_has_algo,
> +	.get_flags	= bpf_crypto_sig_get_flags,
> +	.setkey		= bpf_crypto_sig_setkey,
> +	.owner		= THIS_MODULE,
> +	.name		= "sig",
> +};

I think we have to introduce verify() callback here.



