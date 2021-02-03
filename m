Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459FD30E392
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Feb 2021 20:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhBCTuh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 14:50:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:18472 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhBCTug (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 14:50:36 -0500
IronPort-SDR: J81d4/ydSLxW8i/XOtHTD2ByVoi7PRI/dsGyjMVhiUQC5crnAED+iMLzZo8NWLGE8cq0adw48M
 x7C20D3u7IhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="177599414"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="177599414"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:48:50 -0800
IronPort-SDR: zoQlnCm1j/rfJDOAxmNGo3J5o4IUedYmnNWebnncsF5l+E3uZQw2kq+WDPXpvsa3srEGUmLxyF
 9tQ9+ZtofrNA==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="356138144"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:48:47 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l7O8r-001iQl-0m; Wed, 03 Feb 2021 21:48:45 +0200
Date:   Wed, 3 Feb 2021 21:48:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v4 1/4] lib: vsprintf: scanf: Negative number must have
 field width > 1
Message-ID: <YBr+HW+uqEJmypGS@smile.fi.intel.com>
References: <20210203165009.6299-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203165009.6299-1-rf@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 03, 2021 at 04:50:06PM +0000, Richard Fitzgerald wrote:
> If a signed number field starts with a '-' the field width must be > 1,
> or unlimited, to allow at least one digit after the '-'.
> 
> This patch adds a check for this. If a signed field starts with '-'
> and field_width == 1 the scanf will quit.
> 
> It is ok for a signed number field to have a field width of 1 if it
> starts with a digit. In that case the single digit can be converted.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  lib/vsprintf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b53c73580c5..28bb26cd1f67 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -3434,8 +3434,12 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>  		str = skip_spaces(str);
>  
>  		digit = *str;
> -		if (is_sign && digit == '-')
> +		if (is_sign && digit == '-') {
> +			if (field_width == 1)
> +				break;
> +
>  			digit = *(str + 1);
> +		}
>  
>  		if (!digit
>  		    || (base == 16 && !isxdigit(digit))
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


