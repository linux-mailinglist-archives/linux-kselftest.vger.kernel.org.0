Return-Path: <linux-kselftest+bounces-47818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F658CD535A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 09:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C5CA3009FAB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8472C30DD11;
	Mon, 22 Dec 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="wQG5Fq9X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E930BF6B;
	Mon, 22 Dec 2025 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393594; cv=none; b=BsirjdZPuMBokebCwCDEYjCS/hpy23s3Un1KGKrqdcR9EOC5xpRDucqXYnhRoeRBdwzFzHMznPoIgZ6WtP3e2RKY/gn0sObNdGcV1ANQojKvgntKUe2pWKM0JyhFgHwp1fWRu8epVVvxBvhBvL+dDuc2lMsjkyA1YhfC1GdaYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393594; c=relaxed/simple;
	bh=89rV/d9HTM8F++SIaL8vkNj/EOQ/SMjOwQmmNxCvXCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P10KCdQMgmXqZLAaHAUeXoTOBK59QhZfcnURYNwrUReVom6iQdbnRAUNBMcjD9uuUGPWspVW8CzgvztBCsSycYDSktQpLR7QlJt+lB4Mhw8T8/9uhLYfj3eGbK0IOYIMXkG+Shzggq45euT+8zqRKcyigbEX7iU3F+3cBpACgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=wQG5Fq9X; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1766393258; bh=ZdjQnB8juh9ZSt71aUthPTCVfgw3jxBwj1eEQkkIWGw=;
	h=From:Message-ID:From;
	b=wQG5Fq9XoCVFejE9gCWIUYcljhcJZG8Q8H0IoTcBm/HXEilEYR924zj1Q+pXvfRo1
	 +fxUbuxgfEFKDACepmfF9erADBkrEiRXOiJWy0CsrDNLTQU9dMeDCPru0fXiq06uvI
	 y6nOyT38d0uDJoCoc3qVuiADATEJoxRA7lDbHujY=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 25AB1C06AE;
	Mon, 22 Dec 2025 09:47:38 +0100 (CET)
Date: Mon, 22 Dec 2025 09:47:37 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 13/14] tools/nolibc: add __nolibc_static_assert()
Message-ID: <aUkFqYpKAiiC33iU@1wt.eu>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
 <20251220-nolibc-uapi-types-v3-13-c662992f75d7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251220-nolibc-uapi-types-v3-13-c662992f75d7@weissschuh.net>

Hi Thomas,

On Sat, Dec 20, 2025 at 02:55:57PM +0100, Thomas Weiﬂschuh wrote:
> Add a wrapper for _Static_assert() to use within nolibc.
> While _Static_assert() itself was only standardized in C11,
> in GCC and clang dialects it is also available in older standards.
> 
> Link: https://lore.kernel.org/lkml/20251203192330.GA12995@1wt.eu/
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/compiler.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
> index c9ffd0496dae..a8c7619dcdde 100644
> --- a/tools/include/nolibc/compiler.h
> +++ b/tools/include/nolibc/compiler.h
> @@ -63,4 +63,12 @@
>  #  define __nolibc_clang_version 0
>  #endif /* __clang__ */
>  
> +#if __STDC_VERSION__ >= 201112L || \
> +	__nolibc_gnuc_version >= __nolibc_version(4, 6, 0) || \
> +	__nolibc_clang_version >= __nolibc_version(3, 0, 0)
> +#  define __nolibc_static_assert(_t) _Static_assert(_t, "")
> +#else
> +#  define __nolibc_static_assert(_t)
> +#endif
> +

Yeah, that's clean this way, I like it!

Acked-by: Willy Tarreau <w@1wt.eu>

