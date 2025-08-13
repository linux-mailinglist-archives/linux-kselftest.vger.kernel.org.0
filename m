Return-Path: <linux-kselftest+bounces-38855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B88B24B31
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3043616A4B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 13:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFE2EB5DC;
	Wed, 13 Aug 2025 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1jN/zVu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0AE18FC80;
	Wed, 13 Aug 2025 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093027; cv=none; b=PoOZXmpOgHvVH9WzDsZfLTzt6NHOajp2lRRrHGPfpkrC599ipjoZauT4Rt+ZF8LLCuVoeGctAFjWpEHkwyLlp8+cXkYYwcA+vAChj40rFoLXMRA39HOeHdU9+rVQGJ7I10GXR2n3dGMrd9+cidUnlItmdLl1jEyZuNASpHUnVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093027; c=relaxed/simple;
	bh=kgmkNi4FyNWpSQEulVVTL5fLq/GrDqNglBvivi4oPyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uxvn1NUzwy/sD3RSbLEmEEgwkCzGLoJFlBeTnf3UAFUMTNI/WH6OpyZWzGPb0FnJHmfaTvRieFhxDyaCpCuX3Y3SRw8GJXSFsumrozxJqzIj99j1bZylXmQb6izDxyE+u5j1p3OArGrbJleXn50hkgR5ht+4LRTf02ccTrw0i0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1jN/zVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55C5C4CEEB;
	Wed, 13 Aug 2025 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755093027;
	bh=kgmkNi4FyNWpSQEulVVTL5fLq/GrDqNglBvivi4oPyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q1jN/zVuEQN2ad0P6Qcr4DZUk0jFORaWGUNrolSM5KKUqK63TaPvDhJVtIVYe0D1w
	 qCq8wEOB4s/uDY+53Pfn1RZrIx6V9QRLiidfV5Px7squI22fCWtmzueIZq2oUVcrOC
	 tsFHaGFK//++3BHNyUpKyw11Q6V7kGH4aywuYJ+2Ytw70Dn7Jbb99ItrBO5uRekayL
	 J7WqRF5gUpjt0Fq2NaoTWwLEFETn46ES66Gv39ippaXcz04SyOd4+YyAaFGjlIz/xk
	 MBthNFb0RZcrhkNGJOHtCF40JG5hew93XfGeXYK58xszMcQaefiEgTpiYUqc5Vsa2d
	 RijdHjK4FLGuA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Shuah Khan <shuah@kernel.org>,
  Thomas Weischuh <linux@weissschuh.net>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 2/3] lib/test_kho: fixes for error handling
In-Reply-To: <20250811082510.4154080-3-rppt@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
	<20250811082510.4154080-3-rppt@kernel.org>
Date: Wed, 13 Aug 2025 15:50:24 +0200
Message-ID: <mafs0y0rnuy8v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 11 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> * Update kho_test_save() so that folios array won't be freed when
>   returning from the function and the fdt will be freed on error
> * Reset state->nr_folios to 0 in  kho_test_generate_data() on error
> * Simplify allocation of folios info in fdt.
>
> Reported-by: Pratyush Yadav <pratyush@kernel.org>
> Closes: https://lore.kernel.org/all/mafs0zfcjcepf.fsf@kernel.org
> Fixes: b753522bed0b ("kho: add test for kexec handover")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

