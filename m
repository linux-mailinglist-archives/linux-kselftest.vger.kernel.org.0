Return-Path: <linux-kselftest+bounces-15904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289E295A518
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADAB1C224BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1359916DEA3;
	Wed, 21 Aug 2024 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm7JtO8R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FEC79CD;
	Wed, 21 Aug 2024 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267409; cv=none; b=W6Nc0sWRkUU/IPDf35mNEBoYfPvNvW9WxA2JpFGGMeodM0vz5XRBn/c9oQK93XJWMeEaAXKOH5zdt4BrgwSvt+psp39nNJQA8FganpTOB0oGoqyZ6i11738wP4Zeb+ekqVpIdCUw16x0LR1r2S0uG+9OawWrfaB41O911s5KrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267409; c=relaxed/simple;
	bh=Aw6VMTVoBZ0Q+DG7u2u1GSm5zViy84yfHtm5l5M+56g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NivfbIhFFFYnA+EKIg61xS+U+i5CGVuJOmrPDL3umi1zerW6hgITrvKMfEdiY2CVtNJhRTycT3Lkyp+7GXJGP61lJ7uu5bjKynSqT4SB6D5afZV/ps5qjVjUkcFsqm5Pw9FRviDt+HAptq9FvQDFJ3maQGXDOZD8BcKtzwjhvt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm7JtO8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D03C32781;
	Wed, 21 Aug 2024 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724267408;
	bh=Aw6VMTVoBZ0Q+DG7u2u1GSm5zViy84yfHtm5l5M+56g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fm7JtO8RRFglBlXsS2GOgXoPB0w5wB5GMmIHeLkGG6PzQuIqjZcSC8bjh3/HIfQRC
	 DF2Grcd+SeDYDmRJD3OS0kncFhqKmHeSnc4XfeZJl4KjijvESXJYyCk00ikNLBfuOe
	 bow9VDfSnf9ZPEsgjZsVLXMcIZ3RCij6hL24mPAWIenNiOiuq5DVMbUzdPrDgxbbZn
	 EvbpLEY/vcqOJfL809/e/YG3i5X0HlEE4XzBuvntjPVHDWLWbrqBFDOE5+bNJCkRep
	 0KGK+3knJoajF2HRDs3PiZZNGaID2gznpqdUT0GPB5xHUk7tl4ShIkHOjSdGkcww0K
	 szE3RkdmpGYsg==
Date: Wed, 21 Aug 2024 20:10:04 +0100
From: Simon Horman <horms@kernel.org>
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] selftests/net: Provide test_snprintf()
 helper
Message-ID: <20240821191004.GF2164@kernel.org>
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
 <20240815-tcp-ao-selftests-upd-6-12-v3-2-7bd2e22bb81c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-tcp-ao-selftests-upd-6-12-v3-2-7bd2e22bb81c@gmail.com>

On Thu, Aug 15, 2024 at 10:32:27PM +0100, Dmitry Safonov via B4 Relay wrote:
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> Instead of pre-allocating a fixed-sized buffer of TEST_MSG_BUFFER_SIZE
> and printing into it, call vsnprintf() with str = NULL, which will
> return the needed size of the buffer. This hack is documented in
> man 3 vsnprintf.
> 
> Essentially, in C++ terms, it re-invents std::stringstream, which is
> going to be used to print different tracing paths and formatted strings.
> Use it straight away in __test_print() - which is thread-safe version of
> printing in selftests.
> 
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Hi Dmitry,

Some minor nits, as it looks like there will be a v4.

> ---
>  tools/testing/selftests/net/tcp_ao/lib/aolib.h | 59 ++++++++++++++++++++++----
>  1 file changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
> index fbc7f6111815..60a63419cabb 100644
> --- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
> +++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
> @@ -37,17 +37,58 @@ extern void __test_xfail(const char *buf);
>  extern void __test_error(const char *buf);
>  extern void __test_skip(const char *buf);
>  
> -__attribute__((__format__(__printf__, 2, 3)))
> -static inline void __test_print(void (*fn)(const char *), const char *fmt, ...)
> +static inline char *test_snprintf(const char *fmt, va_list vargs)
>  {
> -#define TEST_MSG_BUFFER_SIZE 4096
> -	char buf[TEST_MSG_BUFFER_SIZE];
> -	va_list arg;
> +	char *ret = NULL;
> +	size_t size = 0;
> +	va_list tmp;
> +	int n = 0;
>  
> -	va_start(arg, fmt);
> -	vsnprintf(buf, sizeof(buf), fmt, arg);
> -	va_end(arg);
> -	fn(buf);
> +	va_copy(tmp, vargs);
> +	n = vsnprintf(ret, size, fmt, tmp);
> +	if (n < 0)
> +		return NULL;
> +
> +	size = (size_t) n + 1;

nit: I'm not sure this cast is needed.
     But if it is, then the space after ')' should be dropped.

> +	ret = malloc(size);
> +	if (ret == NULL)

nit: if (!ret)

> +		return NULL;
> +
> +	n = vsnprintf(ret, size, fmt, vargs);
> +	if (n < 0 || n > size - 1) {
> +		free(ret);
> +		return NULL;
> +	}
> +	return ret;
> +}

...

