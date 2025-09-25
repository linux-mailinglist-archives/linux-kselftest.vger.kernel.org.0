Return-Path: <linux-kselftest+bounces-42361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9E0BA096A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 18:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70391899CB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A43306D37;
	Thu, 25 Sep 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="j2Di+Id6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F23054F6;
	Thu, 25 Sep 2025 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817460; cv=none; b=JlE/kF/CJA/DkWWR/udROmsQbmAQfgYsrQfyEHs2BPKCbHOrVWENHfX1zR+5vpNC4xCv946QgJwBpZOmdNQLK0RzaH2exdeOJ0O5ur4CFkuG2vX6OOFPXx+9zPmAS4gLrYTE7dBF6RPxl9OJSyv8MFbAUd6f96sNyqufFiqZeUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817460; c=relaxed/simple;
	bh=ZseXcKJOoFZwJc+bmSlC9mOKhka3TjWkK31x0E+BHRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpo9hjc8Bz0uSdkU3VthowgWzFeukqgu6CulWdsM8qdlegMNO8r4hXTZ/LLkkehXlrIEzrLkfkOG5zpLktxts0Yi9h0HGw6v8ZZSQLJ/Ojd0xOtNwsPLP8zY/F6NFW1JqrpJlVPH9tEqvmVFq3DSq+70EaIayxkdCy7fOk9cv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=j2Di+Id6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758817454;
	bh=ZseXcKJOoFZwJc+bmSlC9mOKhka3TjWkK31x0E+BHRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j2Di+Id6LYcdiJsOkoU4u8V2kFwnn3m3bUt2gNI+v2W7wHw8taZU6GPWSuaJe/fPr
	 0/TQQVrgaiLyk55MmajgsiXsnx2nujbfLQwt/x6AHg1WnGZitAca6X0Vyh0VfSnxgg
	 g/gDT3CbinJR+AXQwv9pfagU+rVJI+YQ4yX+ehWM=
Date: Thu, 25 Sep 2025 18:24:02 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v3 05/12] tools/nolibc: implement %m if errno is not
 defined
Message-ID: <a8e4b65c-8d1d-49ac-8f33-00a46a8b9f11@t-8ch.de>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
 <20250924142059.527768-6-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924142059.527768-6-benjamin@sipsolutions.net>

On 2025-09-24 16:20:52+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> For improved compatibility, print %m as "unknown error" when nolibc is
> compiled using NOLIBC_IGNORE_ERRNO.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Thanks for taking care of this.

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/include/nolibc/stdio.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> index 724d05ce6962..1f16dab2ac88 100644
> --- a/tools/include/nolibc/stdio.h
> +++ b/tools/include/nolibc/stdio.h
> @@ -321,11 +321,13 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
>  				if (!outstr)
>  					outstr="(null)";
>  			}
> -#ifndef NOLIBC_IGNORE_ERRNO
>  			else if (c == 'm') {
> +#ifdef NOLIBC_IGNORE_ERRNO
> +				outstr = "unknown error";
> +#else
>  				outstr = strerror(errno);
> -			}
>  #endif /* NOLIBC_IGNORE_ERRNO */
> +			}
>  			else if (c == '%') {
>  				/* queue it verbatim */
>  				continue;
> -- 
> 2.51.0
> 

