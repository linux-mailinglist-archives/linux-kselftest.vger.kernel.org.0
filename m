Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D4F2D3061
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 17:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgLHQ7u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 11:59:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:47994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730227AbgLHQ7u (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 11:59:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6FA8AC94;
        Tue,  8 Dec 2020 16:59:07 +0000 (UTC)
From:   pmladek@suse.cz
Date:   Tue, 8 Dec 2020 17:59:07 +0100
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        shuah@kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] lib: vsprintf: Fix handling of number field
 widths in vsscanf
Message-ID: <X8+w2yCU+wUwLQKt@alley>
References: <20201130145800.19960-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130145800.19960-1-rf@opensource.cirrus.com>
gyFrom: Petr Mladek <pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 2020-11-30 14:57:57, Richard Fitzgerald wrote:
> The existing code attempted to handle numbers by doing a strto[u]l(),
> ignoring the field width, and then bitshifting the field out of the
> converted value. If the string contains a run of valid digits longer
> than will fit in a long or long long, this would overflow and no amount
> of bitshifting can recover the correct value.
> 
> This patch fixes vsscanf to obey number field widths when parsing
> the number.
> 
> A new _parse_integer_limit() is added that takes a limit for the number
> of characters to parse. The number field conversion in vsscanf is changed
> to use this new function.
> 
> The cases of a base prefix or leading '-' that is >= the maximum
> field

I have troubles to parse this sentence. It might be because I am
not a native speaker.


> width is handled such that the result of a sccanf is consistent with the
> observed behaviour of userland sscanf.

Anyway, it would be great to explain this on few examples that describe
the corner cases. See also below.


> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -39,20 +39,22 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
>  
>  /*
>   * Convert non-negative integer string representation in explicitly given radix
> - * to an integer.
> + * to an integer. A maximum of max_chars characters will be converted.
> + *
>   * Return number of characters consumed maybe or-ed with overflow bit.
>   * If overflow occurs, result integer (incorrect) is still returned.
>   *
>   * Don't you dare use this function.
>   */
> -unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
> +unsigned int _parse_integer_limit(const char *s, unsigned int base,
> +				  unsigned long long *p, size_t max_chars)
>  {
>  	unsigned long long res;
>  	unsigned int rv;
>  
>  	res = 0;
>  	rv = 0;
> -	while (1) {
> +	for (; max_chars > 0; max_chars--) {
>  		unsigned int c = *s;
>  		unsigned int lc = c | 0x20; /* don't tolower() this line */
>  		unsigned int val;
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 14c9a6af1b23..21145da468e0 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -53,29 +53,47 @@
>  #include <linux/string_helpers.h>
>  #include "kstrtox.h"
>  
> -/**
> - * simple_strtoull - convert a string to an unsigned long long
> - * @cp: The start of the string
> - * @endp: A pointer to the end of the parsed string will be placed here
> - * @base: The number base to use
> - *
> - * This function has caveats. Please use kstrtoull instead.
> - */
> -unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
> +static unsigned long long simple_strntoull(const char *startp, size_t max_chars,
> +					   char **endp, unsigned int base)
>  {
> -	unsigned long long result;
> +	const char *cp;
> +	unsigned long long result = 0ULL;
>  	unsigned int rv;
>  
> -	cp = _parse_integer_fixup_radix(cp, &base);
> -	rv = _parse_integer(cp, base, &result);
> +	if (max_chars == 0) {
> +		cp = startp;
> +		goto out;
> +	}
> +
> +	cp = _parse_integer_fixup_radix(startp, &base);
> +	if ((cp - startp) >= max_chars) {
> +		cp = startp + max_chars;
> +		goto out;
> +	}
> +
> +	max_chars -= (cp - startp);
> +	rv = _parse_integer_limit(cp, base, &result, max_chars);
>  	/* FIXME */
>  	cp += (rv & ~KSTRTOX_OVERFLOW);
> -
> +out:
>  	if (endp)
>  		*endp = (char *)cp;
>  
>  	return result;
>  }
> +
> +/**
> + * simple_strtoull - convert a string to an unsigned long long
> + * @cp: The start of the string
> + * @endp: A pointer to the end of the parsed string will be placed here
> + * @base: The number base to use
> + *
> + * This function has caveats. Please use kstrtoull instead.
> + */
> +unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
> +{
> +	return simple_strntoull(cp, UINT_MAX, endp, base);

Please, use INT_MAX everywhere. It is an arbitrary big-enough number.
And INT_MAX is already used in vscnprintf().

> +}
>  EXPORT_SYMBOL(simple_strtoull);
>  
>  /**
> @@ -88,7 +106,7 @@ EXPORT_SYMBOL(simple_strtoull);
>   */
>  unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base)
>  {
> -	return simple_strtoull(cp, endp, base);
> +	return simple_strntoull(cp, UINT_MAX, endp, base);

Same here.

>  }
>  EXPORT_SYMBOL(simple_strtoul);
>  
> @@ -109,6 +127,19 @@ long simple_strtol(const char *cp, char **endp, unsigned int base)
>  }
>  EXPORT_SYMBOL(simple_strtol);
>  
> +static long long simple_strntoll(const char *cp, size_t max_chars, char **endp,
> +				 unsigned int base)
> +{
> +	/*
> +	 * simple_strntoull safely handles receiving max_chars==0 in the
> +	 * case we start with max_chars==1 and find a '-' prefix.
> +	 */
> +	if (*cp == '-' && max_chars > 0)
> +		return -simple_strntoull(cp + 1, max_chars - 1, endp, base);
> +
> +	return simple_strntoull(cp, max_chars, endp, base);
> +}
> +
>  /**
>   * simple_strtoll - convert a string to a signed long long
>   * @cp: The start of the string
> @@ -119,10 +150,7 @@ EXPORT_SYMBOL(simple_strtol);
>   */
>  long long simple_strtoll(const char *cp, char **endp, unsigned int base)
>  {
> -	if (*cp == '-')
> -		return -simple_strtoull(cp + 1, endp, base);
> -
> -	return simple_strtoull(cp, endp, base);
> +	return simple_strntoll(cp, UINT_MAX, endp, base);

And here.


>  }
>  EXPORT_SYMBOL(simple_strtoll);
>  
> @@ -3433,8 +3461,11 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>  		str = skip_spaces(str);
>  
>  		digit = *str;
> -		if (is_sign && digit == '-')
> +		if (is_sign && digit == '-') {
> +			if (field_width == 1)
> +				break;

This should be handled in a separate patch. It is a subtle change that
is hidden deep inside a big diff.

1. It is quite hard to notice because the above simple_strntoll() was
   implemented to return 0 in this case.

2. The commit message describes the situation when all read numbers
   overflow unsigned long long. And this is another corner that
   was not clearly mentioned.

>  			digit = *(str + 1);
> +		}
>  
>  		if (!digit
>  		    || (base == 16 && !isxdigit(digit))

Otherwise, I really like patch. Thanks a lot for the effort.

I am sorry that it took me so long to look at it. I was pretty busy
last week. I am going to look at the huge 2nd patch tomorrow.

Best Regards,
Petr
