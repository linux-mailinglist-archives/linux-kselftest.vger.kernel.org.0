Return-Path: <linux-kselftest+bounces-31193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 809FBA94282
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 11:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4699A1897192
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B2D19B5B8;
	Sat, 19 Apr 2025 09:06:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F2D288CC;
	Sat, 19 Apr 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745053608; cv=none; b=ErkqWTRoJ4w6xBr5Eo1bBWFiKfrLCFq67tUueveYbquuMzz/p9q7RM+MD+yFO9SN/A8OJ39RwvSpu93h0W7jcJgoR9UrrBfBxlnZprr3V9br9Uece4js+Rbc7GCLBXkfPQRQLnkaqmHKEyhF0CnoUjXHublEW9IhiZX6n8mIdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745053608; c=relaxed/simple;
	bh=JO4nI6509DAVavai5pLevTpGNK9zOusprZDRtRVv3+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUbfLy+D9I3LyOGXrFL6zAu8qWpX8P1VfLbCSgF2TacpZeF6jlYPNjLweRLIdoqhAMfQWNDYCbkkB0ebM+6K3TcBh0a7T9lwzeRdRilkMwUR5gSoGDuQvEq/PJzWdze9WGPeFSVTv0eQl2gXkC72joWHRBnt7whcPHXg7OxSgu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 53J96VFw031969;
	Sat, 19 Apr 2025 11:06:31 +0200
Date: Sat, 19 Apr 2025 11:06:31 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/6] tools/nolibc: disable function sanitizer for
 _start_c()
Message-ID: <20250419090631.GB31874@1wt.eu>
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
 <20250416-nolibc-ubsan-v1-2-c4704bb23da7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416-nolibc-ubsan-v1-2-c4704bb23da7@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 16, 2025 at 08:40:17PM +0200, Thomas Weiﬂschuh wrote:
> Both constructors and main() may be executed with different function
> signatures than they are actually using.
> This is intentional but trips up UBSAN.
> 
> Disable the function sanitizer of UBSAN in _start_c().
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/crt.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> index c4b10103bbec50f1a3a0a4562e34fdbd1b43ce6f..961cfe777c3564e705dfdd581de828b374d05b0b 100644
> --- a/tools/include/nolibc/crt.h
> +++ b/tools/include/nolibc/crt.h
> @@ -7,6 +7,8 @@
>  #ifndef _NOLIBC_CRT_H
>  #define _NOLIBC_CRT_H
>  
> +#include "compiler.h"
> +
>  char **environ __attribute__((weak));
>  const unsigned long *_auxv __attribute__((weak));
>  
> @@ -25,6 +27,9 @@ extern void (*const __fini_array_end[])(void) __attribute__((weak));
>  
>  void _start_c(long *sp);
>  __attribute__((weak,used))
> +#if __nolibc_has_feature(undefined_behavior_sanitizer)
> +	__attribute__((no_sanitize("function")))
> +#endif

I'm wondering if it wouldn't be more reliable with:

  #if __nolibc_has_attribute(no_sanitize)
	__attribute__((no_sanitize("function")))
  #endif

Because in the end, what you want is to always place that attribute
whenever it's supported, no ?

>  void _start_c(long *sp)
>  {
>  	long argc;

Willy

