Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FD930E386
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Feb 2021 20:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhBCTrq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 14:47:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:18261 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhBCTrp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 14:47:45 -0500
IronPort-SDR: P6sBy8oVp7lJxv2SfAbickprf4PC2+uscnmncNlkJBAcmGBdusj84Y9sMk0iq2F83PTcp165IR
 7NyQA1Adxs8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="177598988"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="177598988"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:46:00 -0800
IronPort-SDR: 52iZM3s5rqgq2q8OLsrcAFLChzcxau/Kc78SOcYDoaRtcA2xFR6v0I+Yl6o7qK5x0SHVfNJz+y
 FgRyqPFbRwSA==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="480467147"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:45:58 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l7O67-001iOT-2g; Wed, 03 Feb 2021 21:45:55 +0200
Date:   Wed, 3 Feb 2021 21:45:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v4 2/4] lib: vsprintf: Fix handling of number field
 widths in vsscanf
Message-ID: <YBr9c44Dvq1ZNrEa@smile.fi.intel.com>
References: <20210203165009.6299-1-rf@opensource.cirrus.com>
 <20210203165009.6299-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203165009.6299-2-rf@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 03, 2021 at 04:50:07PM +0000, Richard Fitzgerald wrote:
> The existing code attempted to handle numbers by doing a strto[u]l(),
> ignoring the field width, and then repeatedly dividing to extract the
> field out of the full converted value. If the string contains a run of
> valid digits longer than will fit in a long or long long, this would
> overflow and no amount of dividing can recover the correct value.
> 
> This patch fixes vsscanf to obey number field widths when parsing

vsscanf()

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

...

> +	for (; max_chars > 0; max_chars--) {

Less fragile is to write

	while (max_chars--)

This allows max_char to be an unsigned type.

Moreover...

> +	return _parse_integer_limit(s, base, p, INT_MAX);

You have inconsistency with INT_MAX vs, size_t above.

...

> +unsigned int _parse_integer_limit(const char *s, unsigned int base,
> +				  unsigned long long *res, size_t max_chars);

Also, can you leave res on previous line, so it will be easier to see what's
the difference with the original one?

>  unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *res);

...

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

It's redundant if I'm not mistaken.

> +	cp = _parse_integer_fixup_radix(startp, &base);
> +	if ((cp - startp) >= max_chars) {
> +		cp = startp + max_chars;
> +		goto out;
> +	}

This will be exactly the same, no?

Moreover you will have while (max_chars--) in the _limit() variant which is
also a no-op.

...

> -

Unrelated change.

> +out:
>  	if (endp)
>  		*endp = (char *)cp;

-- 
With Best Regards,
Andy Shevchenko


