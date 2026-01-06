Return-Path: <linux-kselftest+bounces-48348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FD1CFB388
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 23:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72D683003FE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 22:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B322F1FED;
	Tue,  6 Jan 2026 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CgTvNe1l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D42EC095
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737545; cv=none; b=bNwUvis96U7CzKuJTzzPKfSusmYuXqPtK9/u3isuWbtk6C3xaGQrP5TjVJpHZD2MvmZENfXIShniq9rQn8DebETloN6k4i8aqwut6hRti3CzmcKRywkUA4U690zaTaHArSDDm5PUDYTS/8i5c81l/vhAroKYqv5g58eVONxJR8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737545; c=relaxed/simple;
	bh=udzO7jzqWyR1EVEo78AX3W184D1928dk9ftVb7kARmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2mooYIcCgsHT4MG9nyGINk3k6T3xOke/AukNMfpLF//qq3Q0bkSbNQTsVBTDNVGzMt/RXqk2hO54rcV0GsGS+vSWIJwMaqEVSaDq6k0BhQabNCHeUx11aXLfJ56NLux8xbiCZOEctv/ttEZ53BIzW84Qlj5eDsOSXiwsDqetGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CgTvNe1l; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <afb45da9-5731-4f7b-afc1-cd4dc26a0166@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767737541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1d6rGS30zhJFKH3xp2dbt9eqhgPyFglX2SCUjcGokIs=;
	b=CgTvNe1lnErk5ZJZhdX2lbw7/ZI86ijQymlwpxnuM9tjc26bM4zLZUCGZVCGoJvrmCiXoL
	RDLdjK3Eduz3/2OElkHZ+5BupxXzwz7uTzNd4EGzzEH5BTWtxe355tmbO4Czkglyc3elT3
	KLIqB9txoK/3cEvVtZ2nuOUXY3u3VQY=
Date: Tue, 6 Jan 2026 22:12:19 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/6] bpf: Add hash kfunc for cryptographic
 hashing
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
 <20260105173755.22515-4-git@danielhodges.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260105173755.22515-4-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/01/2026 17:37, Daniel Hodges wrote:
> Extend bpf_crypto_type structure with hash operations:
>   - hash(): Performs hashing operation
>   - digestsize(): Returns hash output size

well, as I've already mentioned, none of them are actually introduced in
the patchset.

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
>   kernel/bpf/crypto.c | 78 ++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 70 insertions(+), 8 deletions(-)
> 

