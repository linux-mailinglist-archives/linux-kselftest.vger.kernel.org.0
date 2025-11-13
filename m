Return-Path: <linux-kselftest+bounces-45536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6BDC573FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 12:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A174C4E4946
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 11:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951E833892C;
	Thu, 13 Nov 2025 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSsSfW5n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690CA2DAFB9;
	Thu, 13 Nov 2025 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034162; cv=none; b=bmLlF0mLgDDDKvBM4G6pF2nkPP3D0p4AHNbFJR18UunMeOODIAOpNMSGjq1FtM3quQsCoEvsCsJ8SVC9FPbKvm92r7KfoQwE1MAn0MnlVBGX7iXQ6oJUCv/SRFInj2mraawEJa/hUz6JRQdD+sOcS99CUd7QBCcvAIFw8iKzMhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034162; c=relaxed/simple;
	bh=oH5KU5/6HrAVYqg3IqBO/mqMxwAJncA9peHsf4tgYN8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rbNCuBfZ7ZVbmNcPYB6Rp7K6B3j0MCW7dumqZrBEHnP/9qzLlVfBwbP+C1YsXWKayh8Hs2trs6xJYqlUjxaLs/haUsnGHx46ictc/tWItBX0CnDZO30+ehp9CWWA7OJCIGDhekbeF6L0vUa6greVVBbftGxc2sSjGlPQ0yVIFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSsSfW5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493AFC19423;
	Thu, 13 Nov 2025 11:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763034161;
	bh=oH5KU5/6HrAVYqg3IqBO/mqMxwAJncA9peHsf4tgYN8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gSsSfW5nwmXMPLyuX1Qr2im6sYq9oPgwlLcF8ObWxDW5Vv8wDNcluBSVQ+9+ZxWYb
	 JhsKQEq3Y9ZLLtnAQvzSseQCPXuzr8If8/WFuOZeh4GassghQCrQItbxR/pn21WXTn
	 8yYEMrRx25fURyYlppoZJyTLEflm4UWgjCq3RXN8qRD5UGdiZy/hsrfzRdN8chzdtX
	 FRWhSPFTBktKI/GG/59M2vTAvDBu7pId3PvvjIE9tKadNEUu0lSSfKx/mk0Oy8herp
	 kOegFZWfheJA6+bdxy5MtM7jBdItTntTebunjW4cZdCNQyPNqb12xqIo4YG/+PHbbD
	 yZnCIYOSyjIsQ==
Content-Type: multipart/mixed; boundary="===============1700948574828837009=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a586dfbb76e489a4dadc1852769a24c3ef79ffcc4007df2084d047052bdde05@mail.kernel.org>
In-Reply-To: <d0458ec2290e85a8c885432359a33ba8596ba992.1763024337.git.paul.houssel@orange.com>
References: <d0458ec2290e85a8c885432359a33ba8596ba992.1763024337.git.paul.houssel@orange.com>
Subject: Re: [PATCH v3 1/2] libbpf: fix BTF dedup to support recursive typedef definitions
From: bot+bpf-ci@kernel.org
To: paulhoussel2@gmail.com,paulhoussel2@gmail.com,eddyz87@gmail.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: martin.horth@telecom-sudparis.eu,ouail.derghal@imt-atlantique.fr,guilhem.jazeron@inria.fr,ludovic.paillat@inria.fr,robin.theveniaut@irit.fr,tristan.daudibert@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,paul.houssel@orange.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Nov 2025 11:42:41 +0000 (UTC)

--===============1700948574828837009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 9f141395c..5c4035eb9 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> @@ -4844,14 +4865,31 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
>  	}
>  }
>
> +static inline long btf_hash_by_kind(struct btf_type *t, __u16 kind)
> +{
> +	if (kind == BTF_KIND_TYPEDEF)
> +		return btf_hash_typedef(t);
> +	else
> +		return btf_hash_struct(t);
> +}
> +
> +static inline bool btf_equal_by_kind(struct btf_type *t1, struct btf_type *t2, __u16 kind)
> +{
> +	if (kind == BTF_KIND_TYPEDEF)
> +		return btf_equal_typedef(t1, t2);
> +	else
> +		return btf_shallow_equal_struct(t1, t2);
> +}
> +
>  /*
> - * Deduplicate struct/union types.
> + * Deduplicate struct/union and typedef types.
>   *
>   * For each struct/union type its type signature hash is calculated, taking
>   * into account type's name, size, number, order and names of fields, but
>   * ignoring type ID's referenced from fields, because they might not be deduped
> - * completely until after reference types deduplication phase. This type hash
> - * is used to iterate over all potential canonical types, sharing same hash.
> + * completely until after reference types deduplication phase. For each typedef
> + * type, the hash is computed based on the type's name and size. This type hash
> + * is used to iterate over all potential canonical types, sharingsame hash.
                                                                   ^^^^^^^^^^

This isn't a bug, but there's a typo here - "sharingsame" should be
"sharing same" (two words).

>   * For each canonical candidate we check whether type graphs that they form
>   * (through referenced types in fields and so on) are equivalent using algorithm
>   * implemented in `btf_dedup_is_equiv`. If such equivalence is found and

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19329986070

--===============1700948574828837009==--

