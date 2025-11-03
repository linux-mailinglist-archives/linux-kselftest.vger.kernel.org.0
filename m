Return-Path: <linux-kselftest+bounces-44674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5162AC2D947
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 19:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D8F18990DD
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 18:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436A271451;
	Mon,  3 Nov 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0Q6iZmJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB3719ABDE;
	Mon,  3 Nov 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193153; cv=none; b=YGRjNe3iKY8ZUBBoiPUJe7F/CeBWkD24tFWloTYJXxdC4pYzo/Sx7PNzuSpxucM1aT8JT+Otyk36hNQp5qwVS7ulrxnXyuEuXSY/jV46RfYtWCP7KRK9legk9aKodUMotI3pYUwfrg3Er5JluaD4eGaMBjnYMM1plApdcX7xmts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193153; c=relaxed/simple;
	bh=+64iKrvV3aelQ+MDxd4Vv/MtBZ3N2qzpU9GTaRPio/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a9GdSf8OgvKX/d9gEBcAczchGMtTnl6qQW6d0QtQ+N7j8NX2jyzw7L2DlarwfeQrD53FZqYC8P94GlgJnkPjH5zTKB032z2DPdCoG9jfGHlREFA3GxVuEcePkkf7z1oi/G9umx6TBwuqVm1tOb3PVZ9Ni9CHr2Bp2RmWzQX/tGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0Q6iZmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB36C4CEE7;
	Mon,  3 Nov 2025 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762193153;
	bh=+64iKrvV3aelQ+MDxd4Vv/MtBZ3N2qzpU9GTaRPio/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=P0Q6iZmJK/NA+gbfeQInwBVD+j/Mn4E1i/RYRGFSSkO9j48VXUBSt4qX7JDbU9/sh
	 oQaUywp3A+5CnhS2iXAStJ0jiuKL+Iz79AezYdKAOdkZHlIlnXylhHGjX+X6iqj+IF
	 n6QlkUu4/grO0RvSCHPixVuKjT1yJPWqvv9s+/q1qzlfKkH/iNA1Tqe55xboZrNhm1
	 LKekEXOUMr07Yqs22nUM1noYOwUY6u3H1N1Zz1ZLfekCtPCeFvHjyRJJ3G2jxZ6raM
	 Gsh6bOPS3mkh2oaFKdjmn7dcQlkMDUwbWf+FxdzN1FWZHRr4dNx82XokKVxrHSed4T
	 0zF60vTlv8V8g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org,
  yanjun.zhu@linux.dev
Subject: Re: [PATCH v9 3/9] kho: add interfaces to unpreserve folios, page
 ranges, and vmalloc
In-Reply-To: <20251101142325.1326536-4-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 1 Nov 2025 10:23:19 -0400")
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
	<20251101142325.1326536-4-pasha.tatashin@soleen.com>
Date: Mon, 03 Nov 2025 19:05:49 +0100
Message-ID: <mafs08qgnc7pe.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Pasha,

On Sat, Nov 01 2025, Pasha Tatashin wrote:

> Allow users of KHO to cancel the previous preservation by adding the
> necessary interfaces to unpreserve folio, pages, and vmallocs.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
[...]
> +/**
> + * kho_unpreserve_vmalloc - unpreserve memory allocated with vmalloc()
> + * @preservation: preservation metadata returned by kho_preserve_vmalloc()
> + *
> + * Instructs KHO to unpreserve the area in vmalloc address space that was
> + * previously preserved with kho_preserve_vmalloc().
> + *
> + * Return: 0 on success, error code on failure
> + */
> +int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
> +{
> +	if (kho_out.finalized)
> +		return -EBUSY;
> +
> +	kho_vmalloc_free_chunks(preservation);

When reviewing this patch, I spotted that kho_vmalloc_free_chunks() is
broken. Well it happens to work if all pages are 0-order, but breaks on
higher-order allocations.

I have sent a separate patch [0] to fix this on top of mm-stable. It
doesn't have a conflict with this patch so it shouldn't cause trouble.
And I **don't** think it should block this patch either. This is mostly
a heads up.

[0] https://lore.kernel.org/linux-mm/20251103180235.71409-2-pratyush@kernel.org/T/#u

-- 
Regards,
Pratyush Yadav

