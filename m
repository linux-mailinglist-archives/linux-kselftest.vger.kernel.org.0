Return-Path: <linux-kselftest+bounces-47138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC0CA8B91
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 19:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FBF83001DD0
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C600E2E7BD3;
	Fri,  5 Dec 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAKYosXg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97169398FAD;
	Fri,  5 Dec 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957944; cv=none; b=qtSiDzQTP8jPs7ekxATmTjzgv/jeszOxWvzSZBUGi6nnIcnPfyl9tFtj4+BXdAfTHEfKRCJbYJzFFXLNuT8aGAuM3Kv5vxxpeuorgFsYbfObZLWAWaIZSEmf54NYycxEWyk8eGqKb5sYiSPqA3SVldVAj0USplAWq05zt98SpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957944; c=relaxed/simple;
	bh=UNhCNLL7mq4/RAE42NKIKJyq+26EOkdq0AmQ7BclY5s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CAHIvT42rZteAYZwcD3K3ph16QplI7kiZbU+GHdtUhJRpNm1/8YdCvCHwubwWBzDKaqOzdCir8CTGHmd20Z4o2V2cUGWAWrjcQkRf1HyDyf8Z0yBUSFB3BhTEQi22QeOtHLqzUJaOdzKMRyUgNiSmd4ew2mN94gHEjGU8sFalyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAKYosXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033B0C4CEF1;
	Fri,  5 Dec 2025 18:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764957944;
	bh=UNhCNLL7mq4/RAE42NKIKJyq+26EOkdq0AmQ7BclY5s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=WAKYosXgl2P0FGJ3GW2i3+va2YWP2M5mhwSux8bM7UA08KAM4WKGXTh3mDJREG05T
	 qrXHHIzem28LhfQwezM5cZq9vqyTwqFnov1/e3vJmOwAgVdXe9VnhbSJDq9zuYnZj+
	 OxaqOqKQmlOjl9PY2osMZsKaECgQ8FgUIiDUaa0a3+Fid7pFARGohxsFnCQrrRLR2U
	 KmHDvOhx7KQJz/3ZtJrYrWyjEthld+nToe+7rYWgaaYygKIRZP7CxrjEohfORs0kTH
	 V+qmmkouwAVQHHaADV1k9nEvDhrUPjcgIADjuypgantzQU9nuhyQWt2vmLpk3JLjD0
	 H5pmM8+qbbMDw==
Content-Type: multipart/mixed; boundary="===============6378540900929256769=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <969faf338b31962ef7b624f47a6fa887c04ab65c49e8470dc267658ecedcb07a@mail.kernel.org>
In-Reply-To: <20251205173923.31740-2-git@danielhodges.dev>
References: <20251205173923.31740-2-git@danielhodges.dev>
Subject: Re: [PATCH bpf-next v2 1/5] crypto: Add BPF hash algorithm type registration module
From: bot+bpf-ci@kernel.org
To: git@danielhodges.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,vadim.fedorenko@linux.dev
Cc: martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,herbert@gondor.apana.org.au,davem@davemloft.net,shuah@kernel.org,bpf@vger.kernel.org,linux-crypto@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,git@danielhodges.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Dec 2025 18:05:41 +0000 (UTC)

--===============6378540900929256769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/crypto/Makefile b/crypto/Makefile
> index 16a35649dd91..853dff375906 100644
> --- a/crypto/Makefile
> +++ b/crypto/Makefile

[ ... ]

> diff --git a/crypto/bpf_crypto_shash.c b/crypto/bpf_crypto_shash.c
> new file mode 100644
> index 000000000000..39032e7dd602
> --- /dev/null
> +++ b/crypto/bpf_crypto_shash.c

[ ... ]

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

Does this code compile? The struct bpf_crypto_type definition in
include/linux/bpf_crypto.h doesn't have .hash or .digestsize fields at
this commit. The commit message says "Update the bpf_crypto_type
interface with hash-specific callbacks" but the interface wasn't
actually updated in this commit.

Looking forward in the git history, commit 51e5f5be27dc adds these
fields to the interface. Should that commit come before this one for
bisectability?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19971392632

--===============6378540900929256769==--

