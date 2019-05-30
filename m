Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9AE30283
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2019 21:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfE3TAo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 May 2019 15:00:44 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37831 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfE3TAo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 May 2019 15:00:44 -0400
Received: by mail-it1-f193.google.com with SMTP id s16so11177405ita.2
        for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2019 12:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g0Bpz5g3wFYP+gFqu/rKlcFZijNC01hWKfryp13lVZg=;
        b=Ky6dub8QT52Rk0/nNqKV5C0hm/w/refBURtacKKAHngq2xoZ7WwVxHRdeC64kDIFdZ
         iquNVWvagd8VLvpGxnwIuugblubUXipLgChUYQn06i62bdbrWXM7Jq3kDNBMVE5qJvNP
         dF/U/SUceJpCYhXyAejmqRczACmE6f+Wx5S15Jl30pJUkLqFuh9iYUMLMDOeohZCw5kX
         e0ugIo2TT2lql+JHsJ/9c9WFHic9OcpLCqLjt2cAW7KAEaYXgBKnpxCCCSXJeivoE7g9
         +6LLI7mRZF7WLo3E5q5xz3XHZEo63zFta0tlRxmuiGhEjd5YiJ7T1TyzrwReBAOyLCsV
         VRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g0Bpz5g3wFYP+gFqu/rKlcFZijNC01hWKfryp13lVZg=;
        b=b9wdr5Jdfsxu+J2tvIo39lS1KgEGruwAFsQTnUYY5vou/J66at19lhKn9a06rz8xIL
         m/Is5ZMoKjR12Je/TWxQNjGGlA6cFxUiFhF8SlcrXTGN6aev12Ip+ffOBJudIPHvmUi1
         MFemjUD4oEIXk/4lzPtTy7FazJq8d0Y3gGbFz7nVCTPCDDdhaEOxIRw6LWfAHq+7vIJb
         SrI8c4pJUBcpfsVKIhlJIBS97RlinTQsFyjcX6x2z1PyUIH6aeL82JPjfnb1mEYzshpN
         t0wbykUam1IeyWuXPWMYgZvkA4BAr3U4g7HHH4suTTDLhj/3M8z4V1jmsy0jS4pjvFoa
         BN0w==
X-Gm-Message-State: APjAAAXvPHx2H42tMyS4UjiopEj6634tHxaIZW/oTuarPsVdk1p0YycA
        z0Wp/2XsIJk6/nTBIAKhWM9XbQ==
X-Google-Smtp-Source: APXvYqyKXl2q2RSNBQnP6EwLTaHXV0/ufh3qXiNoV187B71OoVq7DmrXop5Gem4wTHVd/C4cxsGYMw==
X-Received: by 2002:a24:c8c2:: with SMTP id w185mr3850842itf.149.1559242843573;
        Thu, 30 May 2019 12:00:43 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id x20sm1146240ioa.40.2019.05.30.12.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 12:00:42 -0700 (PDT)
Date:   Thu, 30 May 2019 14:00:41 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: teach kselftest-merge to find nested config files
Message-ID: <20190530190041.m6535ihflbgr2q3m@xps.therub.org>
References: <20190520151614.19188-1-dan.rue@linaro.org>
 <20190520175641.GA14339@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520175641.GA14339@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 20, 2019 at 07:56:41PM +0200, Greg KH wrote:
> On Mon, May 20, 2019 at 10:16:14AM -0500, Dan Rue wrote:
> > Current implementation of kselftest-merge only finds config files that
> > are one level deep using `$(srctree)/tools/testing/selftests/*/config`.
> > 
> > Often, config files are added in nested directories, and do not get
> > picked up by kselftest-merge.
> > 
> > Use `find` to catch all config files under
> > `$(srctree)/tools/testing/selftests` instead.
> > 
> > Signed-off-by: Dan Rue <dan.rue@linaro.org>
> > ---
> >  Makefile | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> To be more specific here, the binderfs test is not catching the config
> entry, so it would be nice to get this into the stable trees as well :)
> 
> > diff --git a/Makefile b/Makefile
> > index a45f84a7e811..e99e7f9484af 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1228,9 +1228,8 @@ kselftest-clean:
> >  PHONY += kselftest-merge
> >  kselftest-merge:
> >  	$(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
> > -	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
> > -		-m $(objtree)/.config \
> > -		$(srctree)/tools/testing/selftests/*/config
> > +	$(Q)find $(srctree)/tools/testing/selftests -name config | \
> > +		xargs $(srctree)/scripts/kconfig/merge_config.sh -m $(objtree)/.config
> >  	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> >  
> >  # ---------------------------------------------------------------------------
> 
> is find run with $(Q)?  It isn't with other instances in the Makefile.

I'm not entirely sure all the ways that $(Q) is used (it looks like it
just gets set to @), but if i run 'KBUILD_VERBOSE=1 make
kselftest-merge' I do see the find command printed before running:

    find ./tools/testing/selftests -name config | \
          xargs ./scripts/kconfig/merge_config.sh -m ./.config

I noticed find used inconsistently (sometimes with @, sometimes with
$(Q), sometimes with neither), so I picked the usage that seemed most
correct to me.

Dan

> 
> thanks,
> 
> greg k-h

-- 
Linaro - Kernel Validation
