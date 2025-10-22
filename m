Return-Path: <linux-kselftest+bounces-43747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CA5BFB62E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 12:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F13ED4F5193
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 10:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72B232549C;
	Wed, 22 Oct 2025 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1Dr+lJ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35E324B3A;
	Wed, 22 Oct 2025 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128561; cv=none; b=L/OSCOeavdWGMWDlEDibKtxQ6Wi0Y1ESyG0d1YSWFqB/YsM2yicPnsLngLCpeN8BD2N7JfMZkWtktV4YPcri0Zi1xF3HYpQTWV5m9Tv6hOw/gUMfphLGnzoGzCmH1w99iCxBDjr+IJp6bT8lbV6vl7xc+qYjChtKAo4jjXiM/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128561; c=relaxed/simple;
	bh=6AdCRUuNNCz6wSJ38vTty69zF0P+UjCkFsweE0IXYnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oafufY1ACxMvRH3m05YckwKdsvdThu2sb1X3TMAWCMXrh6xB5BE/NLP8O3K2hIGp7zNUcr07zkMgFoCxvnnI9Vy5e5+rrM8b+i5VNWWsCAaD4eSoL4RYrXIM9le0/Yr8jvxd2fQHgrWNFHvahtJs0f6Tmye+KbVDtLkmUUbrPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1Dr+lJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F379DC4CEF5;
	Wed, 22 Oct 2025 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761128561;
	bh=6AdCRUuNNCz6wSJ38vTty69zF0P+UjCkFsweE0IXYnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q1Dr+lJ7vBVYUS3XgbZreqF4ZRbVcHTpEQX9hPSuKZpvS7LwhYeZXf6vrTXLe1SMi
	 6Kx1vT6oK6UH/nrp39CW3QirffvrkhheptDffM61T9n8B4X0uARwv7BWBJ+s4F4d5+
	 8VZN6f7wvT27Q0kkHgg7OIhJjeRwe1dnaK+AM75YfMM/g32TZdxiJdHmpzGIIemtDt
	 Mj9oOzakKjuFWH8DopyDG/JcwmKyBHc1DNtSdJWG5yI/x3wW+Frll24pssh8xjV024
	 E9EiZAW/kYLpd4C7E1VPSK6gQqBhL7pNrn9xAQ3aFTHRhxJzaybPZFWRNRx9B7a4uU
	 TnrzvIsU8QuhA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org,
  jasonmiu@google.com,  dmatlack@google.com,  skhawaja@google.com
Subject: Re: [PATCH v3 1/3] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
In-Reply-To: <20251021000852.2924827-2-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Mon, 20 Oct 2025 20:08:50 -0400")
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
	<20251021000852.2924827-2-pasha.tatashin@soleen.com>
Date: Wed, 22 Oct 2025 12:22:37 +0200
Message-ID: <mafs0v7k7fd76.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20 2025, Pasha Tatashin wrote:

> It is invalid for KHO metadata or preserved memory regions to be located
> within the KHO scratch area, as this area is overwritten when the next
> kernel is loaded, and used early in boot by the next kernel. This can
> lead to memory corruption.
>
> Adds checks to kho_preserve_* and KHO's internal metadata allocators
> (xa_load_or_alloc, new_chunk) to verify that the physical address of the
> memory does not overlap with any defined scratch region. If an overlap
> is detected, the operation will fail and a WARN_ON is triggered. To
> avoid performance overhead in production kernels, these checks are
> enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[...]
> @@ -133,26 +135,26 @@ static struct kho_out kho_out = {
>  
>  static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
>  {
> -	void *elm, *res;
> +	void *res = xa_load(xa, index);
>  
> -	elm = xa_load(xa, index);
> -	if (elm)
> -		return elm;
> +	if (res)
> +		return res;
> +
> +	void *elm __free(kfree) = kzalloc(sz, GFP_KERNEL);
>  
> -	elm = kzalloc(sz, GFP_KERNEL);
>  	if (!elm)
>  		return ERR_PTR(-ENOMEM);
>  
> +	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
> +		return ERR_PTR(-EINVAL);
> +
>  	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
>  	if (xa_is_err(res))
> -		res = ERR_PTR(xa_err(res));
> -
> -	if (res) {
> -		kfree(elm);
> +		return ERR_PTR(xa_err(res));
> +	else if (res)
>  		return res;
> -	}
>  
> -	return elm;
> +	return no_free_ptr(elm);

Super small nit: there exists return_ptr(p) which is a tiny bit neater
IMO but certainly not worth doing a new revision over. So,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

