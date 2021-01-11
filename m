Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A073A2F100A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jan 2021 11:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbhAKK0Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jan 2021 05:26:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:35876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbhAKK0Y (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jan 2021 05:26:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610360737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4DEWnZcXkIbvzaDneWTbb9mFBih4uRTTfogr1ERRY+0=;
        b=t6aa4xR4C8R77SBeQhJyiGgNGeikmIltBcfbNLjWGt55W+Rl+9Z79DY8QlTgCkPneD9qNV
        IbCsYGiYVoivzMbq3VsRj427UffWdjnWJfABk2H8Sohm0D2a9FhiD9rwRIrwA3IAPry8c0
        1gapQckOdt8VaGsxHgZsgUYY0oYX1m0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6DF4AD19;
        Mon, 11 Jan 2021 10:25:37 +0000 (UTC)
Date:   Mon, 11 Jan 2021 11:25:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        shuah@kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 1/4] lib: vsprintf: scanf: Negative number must have
 field width > 1
Message-ID: <X/wnoJLEt0zQskDU@alley>
References: <20201217180057.23786-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217180057.23786-1-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sigh, I have just realized that Andy and Rasmus, the other
vsprintf maintainers and reviewers, were not in CC.
I am sorry for not noticing this earlier.

The patchset is ready for 5.12 from my POV.

Best Regards,
Petr

On Thu 2020-12-17 18:00:54, Richard Fitzgerald wrote:
> If a signed number field starts with a '-' the field width must be > 1,
> or unlimited, to allow at least one digit after the '-'.
> 
> This patch adds a check for this. If a signed field starts with '-'
> and field_width == 1 the scanf will quit.
> 
> It is ok for a signed number field to have a field width of 1 if it
> starts with a digit. In that case the single digit can be converted.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  lib/vsprintf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 14c9a6af1b23..8954ff94a53c 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -3433,8 +3433,12 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
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
