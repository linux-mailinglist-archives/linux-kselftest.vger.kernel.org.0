Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B7E2ECAD7
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Jan 2021 08:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhAGHPt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Jan 2021 02:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGHPt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Jan 2021 02:15:49 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FEAC0612F4
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jan 2021 23:15:08 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id f14so955182pju.4
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jan 2021 23:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zGfxtzWtp5jL4kGOSDAy63NUi3Brsv5kYjVPeNYcQDk=;
        b=FmUTz8nDGXq3UyFOZDP0+X4SYrvpgsXrNkUD/KgWXSqmulGc8t0LQQMDvqmiBljb40
         xxc68Xoy16an5gIpyDsI88BgbLpEdFIQ7fmPu5Wu99Ua4vA3u8a3L+9teXylupFfxInd
         2bAxBPEVNnmBSspF26RfBHkLltvkNoJp/OmpeeMEo/9AgWvuMJxS1OSfvRN5onMLHROG
         7g8j8utJJcglK7O1uNVgFMZlB45oR4bVfV8fHW7cQobetAaraYMKF2gfFNSGQlOPWIFO
         MGnSc5TyU6ZHv+tlUJSXN4IhXaYQnPyOGTttELDrGW7Zujv4bj1GwW82JfN+CIcX1Yso
         wihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zGfxtzWtp5jL4kGOSDAy63NUi3Brsv5kYjVPeNYcQDk=;
        b=ZYSxGF/1gMs0LSQ8DGvIwweM4a28AcmpZbUMSpu9S+iiWQawdUuXZkF4PSHdNKTE+B
         do/uwK4CvfbBQ4F/GUCNd+o1kZnyWS3qAGaO32hEa/ZUPVdoBWsxYsb2YxdFt2ScjBSI
         cAv546E7X0hfjhfkdsp9Lt2SzxnAkE0aP1HotNNJ8NA9PWV6gaQUIZ89avtYLdbW4g2M
         JuXb+QDCdhqSokGLK/p9X7lEwZoEeE3gVU4kw53U9n6c9iI2ZqbS+Kfi2UwtFBPMX2LE
         51uefJLAmTBtNsx82XbU4OU4CyAvLT0Z5QFiOf62WGR0t/KCXWSOC7PmUGtbgRat08B/
         nK+A==
X-Gm-Message-State: AOAM532JZrBvLCF6eiKpVs207lOm/zhNclLluqk/Z7d1hdrlKRyDWCga
        P3xMNtPFkb+eYJIQ6kexKu4=
X-Google-Smtp-Source: ABdhPJwTR9ktnrxx9r1NT512vEIn/Zxbh3BEHm1LAu4lpVTnML7UchhX8vn3nE0Z15FKe5T2/JR72g==
X-Received: by 2002:a17:902:b282:b029:da:fd05:7766 with SMTP id u2-20020a170902b282b02900dafd057766mr8132200plr.52.1610003708242;
        Wed, 06 Jan 2021 23:15:08 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id l2sm4362468pjz.27.2021.01.06.23.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 23:15:07 -0800 (PST)
Date:   Thu, 7 Jan 2021 16:15:04 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-um <linux-um@lists.infradead.org>
Subject: Re: kunit stopped working
Message-ID: <X/a0+Cb6xFZOEk7x@jagdpanzerIV.localdomain>
References: <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com>
 <20201221194008.GA4077@smile.fi.intel.com>
 <20201221200332.GB4077@smile.fi.intel.com>
 <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
 <X/SRA1P8t+ONZFKb@alley>
 <X/SYhBZyudfnKY1u@alley>
 <X/U26cwfHTMYJTtU@jagdpanzerIV.localdomain>
 <X/W2sl7RMvfaV4Ru@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/W2sl7RMvfaV4Ru@alley>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On (21/01/06 14:10), Petr Mladek wrote:
> > > 
> > > But I am not completely sure that it is the right solution.
> > 
> > Wow, hmm, puzzled. Why does it help?
> 
> I have been as well. But it seems that I got it, see below.

Thanks!

[..]
> 
> Alternative solution is to ignore ttynull as the fallback console
> in register_console(). I mean the following:

I personally would prefer a very explicit fix (IOW, the patch below),
rather than relying on some initcall trickery (which has already
failed on us)

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ffdd0dc7ec6d..cdb77903b0af 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2816,8 +2816,12 @@ void register_console(struct console *newcon)
>  	 *	See if we want to use this console driver. If we
>  	 *	didn't select a console we take the first one
>  	 *	that registers here.
> +	 *
> +	 *	Ignore ttynull console. It should be used only
> +	 *	when explicitly configured or as an ultimate
> +	 *	fallback when no better console gets registered at all.
>  	 */
> -	if (!has_preferred_console) {
> +	if (!has_preferred_console && strcmp(newcon->name, "ttynull") != 0) {
>  		if (newcon->index < 0)
>  			newcon->index = 0;
>  		if (newcon->setup == NULL ||

So IIUC in case of ttynull fallback (console= ) we still end up setting
CON_CONSDEV on nulltty console, but we do it in try_enable_new_console().

Feel free to add
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
