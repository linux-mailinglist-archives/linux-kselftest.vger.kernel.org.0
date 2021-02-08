Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7464B31375F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 16:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhBHPYW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 10:24:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:64338 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230402AbhBHPUW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 10:20:22 -0500
IronPort-SDR: kAavl0JAx/pJLKChi6WCPxcBg4neWlXpfjDChyK5HwpzN2dNvdsb5Bco2lOsdIwqFmRBXXoRxT
 x01txKp7hOcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="178217474"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="178217474"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:18:36 -0800
IronPort-SDR: D/CHhsIlZ3JfKGikaUhyGC7C8DgJARSGDw+auAnsM8Uxqs4yUwA2PtYlgNlOu8p9mY7WkwYGsO
 NBraEt4c48dw==
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="374524063"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:18:33 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l98J4-002yHF-3o; Mon, 08 Feb 2021 17:18:30 +0200
Date:   Mon, 8 Feb 2021 17:18:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v5 2/4] lib: vsprintf: Fix handling of number field
 widths in vsscanf
Message-ID: <YCFWRp8a0sw3mUSI@smile.fi.intel.com>
References: <20210208140154.10964-1-rf@opensource.cirrus.com>
 <20210208140154.10964-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208140154.10964-2-rf@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 08, 2021 at 02:01:52PM +0000, Richard Fitzgerald wrote:
> The existing code attempted to handle numbers by doing a strto[u]l(),
> ignoring the field width, and then repeatedly dividing to extract the
> field out of the full converted value. If the string contains a run of
> valid digits longer than will fit in a long or long long, this would
> overflow and no amount of dividing can recover the correct value.
> 
> This patch fixes vsscanf() to obey number field widths when parsing
> the number.
> 
> A new _parse_integer_limit() is added that takes a limit for the number
> of characters to parse. The number field conversion in vsscanf is changed
> to use this new function.
> 
> If a number starts with a radix prefix, the field width  must be long
> enough for at last one digit after the prefix. If not, it will be handled
> like this:
> 
>  sscanf("0x4", "%1i", &i): i=0, scanning continues with the 'x'
>  sscanf("0x4", "%2i", &i): i=0, scanning continues with the '4'
> 
> This is consistent with the observed behaviour of userland sscanf.
> 
> Note that this patch does NOT fix the problem of a single field value
> overflowing the target type. So for example:
> 
>   sscanf("123456789abcdef", "%x", &i);
> 
> Will not produce the correct result because the value obviously overflows
> INT_MAX. But sscanf will report a successful conversion.


I have a few nit-picks, but it's up to you and maintainers how to proceed.

...

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
>  
> +out:
>  	if (endp)
>  		*endp = (char *)cp;
>  
>  	return result;
>  }

A nit-pick: What if we rewrite above as

static unsigned long long simple_strntoull(const char *cp, size_t max_chars,
					   char **endp, unsigned int base)
{
	unsigned long long result = 0ULL;
	const char *startp = cp;
	unsigned int rv;
	size_t chars;

	cp = _parse_integer_fixup_radix(cp, &base);
	chars = cp - startp;
	if (chars >= max_chars) {
		/* We hit the limit */
		cp = startp + max_chars;
	} else {
		rv = _parse_integer_limit(cp, base, &result, max_chars - chars);
		/* FIXME */
		cp += (rv & ~KSTRTOX_OVERFLOW);
	}

	if (endp)
		*endp = (char *)cp;

	return result;
}

...

> +static long long simple_strntoll(const char *cp, size_t max_chars, char **endp,
> +				 unsigned int base)
> +{
> +	/*
> +	 * simple_strntoull safely handles receiving max_chars==0 in the
> +	 * case we start with max_chars==1 and find a '-' prefix.

A nit-pick: Spaces surrounding '=='? simple_strntoull -> simple_strntoull()?

> +	 */

Above misses to add something like:

"Otherwise we hit the '-' as an illegal number in the following
simple_strntoull() call."

> +	if (*cp == '-' && max_chars > 0)
> +		return -simple_strntoull(cp + 1, max_chars - 1, endp, base);
> +
> +	return simple_strntoull(cp, max_chars, endp, base);


> +}

...

> +			val.s = simple_strntoll(str,
> +						field_width > 0 ? field_width : SIZE_MAX,
> +						&next, base);

A nit-pick: Wouldn't be negative field_width "big enough" to just being used as
is? Also, is field_width == 0 should be treated as "parse to the MAX"?

...

> +			val.u = simple_strntoull(str,
> +						 field_width > 0 ? field_width : SIZE_MAX,
> +						 &next, base);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


