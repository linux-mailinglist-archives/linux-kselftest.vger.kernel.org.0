Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8031B195
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Feb 2021 18:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhBNRiB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 Feb 2021 12:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhBNRiA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 Feb 2021 12:38:00 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C90C061574
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Feb 2021 09:37:19 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id g5so4130683ejt.2
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Feb 2021 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pPHQ1LCPTg+mTyzn5WEvdyySp2zJp4JOhr48hj9MJec=;
        b=VZTeGm/JbU3K7F+P5+DDEMqI9Pxt9S/hlb9JTWe/MlrFyHxfAHLLxkjrfYtxkUxtEp
         i/nh1to0gtAYWKhirVTuKN/N7LAqeYDMS2XqskKxfN7NRY7rRMg2MGlWiShiHgHXLr6I
         ZzBJ+lXNA65XQSY/sdwEuw1qumWhWa8mMTzrdGRuYYKQkII23OgbwRev53t53XdUIezM
         RpH+MJ7DEtFQ5xpb0EHzkJM1BcBO6L18bINMBh2fNI/ndiEkgcVlrddEnDtebcI8CKnb
         ONP5RE5XbhAQyWjwfyQUK+tBHIji08gPRikxTHMnRMB3pMTuJa74bEynl7gToF6PKub7
         zSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pPHQ1LCPTg+mTyzn5WEvdyySp2zJp4JOhr48hj9MJec=;
        b=ErEsM1oqdBbI6lot8CQWCDXSiXLAoaXbRmvKlO+oo687/+8+HVu6Rxb2oobE25VHfO
         C2fORleyAnrEkZWQhEvpsdc0fN4DaDhYUbdBTrjZzWbM/g13qd3DuSvIWODvbALLagld
         TwwrW5WP+tV2gurQQRG5/zcNe8sS5Tr8wFvuEY+IflqjHHD7lTXvTjAT/PwHvDZXueXb
         LKs47tJq1jA4ZVGVo+746xshphIGWnGQrs8CIq++XZKEcZTqN9R6oICC7CLP/2jXgE6N
         saGxtr/4V1YT6b7L0Ly45uePNzfbqaPPBnDMDFRCibP/6lmMlfTtQUcAXeY0l6C8ECPQ
         8V8w==
X-Gm-Message-State: AOAM532Kc3wpxxwRQeao/OZmzk4ThFG29KKaygr3CWXau9dA5f4ZgfGq
        pTTI3Jiz1gjIui7yV7CNEh8=
X-Google-Smtp-Source: ABdhPJzBMo3rtqbEN15oFYMMw63BBPQod4I7m/lWdr4BqKojwVf+E3eCzY2uFZ6VSItF/YuWMPvfNw==
X-Received: by 2002:a17:906:24ca:: with SMTP id f10mr11932692ejb.96.1613324238281;
        Sun, 14 Feb 2021 09:37:18 -0800 (PST)
Received: from skbuf (5-12-227-87.residential.rdsnet.ro. [5.12.227.87])
        by smtp.gmail.com with ESMTPSA id x25sm8620240edv.65.2021.02.14.09.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 09:37:17 -0800 (PST)
Date:   Sun, 14 Feb 2021 19:37:16 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     shuah@kernel.org, richardcochran@gmail.com, davem@davemloft.net,
        vincent.cheng.xh@renesas.com, christian.riesch@omicron.at,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] testptp: Fix compile with musl libc
Message-ID: <20210214173716.hxzb2nk6f7cx262n@skbuf>
References: <20210214170940.32358-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214170940.32358-1-hauke@hauke-m.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Hauke,

On Sun, Feb 14, 2021 at 06:09:40PM +0100, Hauke Mehrtens wrote:
> Musl libc does not define the glibc specific macro __GLIBC_PREREQ(), but
> it has the clock_adjtime() function. Assume that a libc implementation
> which does not define __GLIBC_PREREQ at all still implements
> clock_adjtime().
> 
> This fixes a build problem with musl libc because the __GLIBC_PREREQ()
> macro is missing.
> 
> Fixes: 42e1358e103d ("ptp: In the testptp utility, use clock_adjtime from glibc when available")
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  tools/testing/selftests/ptp/testptp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
> index f7911aaeb007..ecffe2c78543 100644
> --- a/tools/testing/selftests/ptp/testptp.c
> +++ b/tools/testing/selftests/ptp/testptp.c
> @@ -38,6 +38,7 @@
>  #define NSEC_PER_SEC 1000000000LL
>  
>  /* clock_adjtime is not available in GLIBC < 2.14 */
> +#ifdef __GLIBC_PREREQ
>  #if !__GLIBC_PREREQ(2, 14)
>  #include <sys/syscall.h>
>  static int clock_adjtime(clockid_t id, struct timex *tx)
> @@ -45,6 +46,7 @@ static int clock_adjtime(clockid_t id, struct timex *tx)
>  	return syscall(__NR_clock_adjtime, id, tx);
>  }
>  #endif
> +#endif /* __GLIBC_PREREQ */

I guess this works, but as you say, there is still an assumption to be
made there, which is that all other C libraries provide the clock_adjtime
syscall definition. So it is likely that this set of #if's and #ifdef's
will be revisited again and again and ...

Maybe this is a matter of personal preference, but I wonder if it's not
actually preferable to do something like this?

#include <sys/syscall.h>

static int compat_clock_adjtime(clockid_t id, struct timex *tx)
{
	return syscall(__NR_clock_adjtime, id, tx);
}

#define clock_adjtime compat_clock_adjtime

This way, everybody uses the same definition of clock_adjtime, and we
bypass the definition provided by libc if there is one, and we provide
our own if there is none.
