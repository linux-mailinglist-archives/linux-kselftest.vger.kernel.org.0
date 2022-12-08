Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74E64778A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 21:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLHU4A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 15:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLHUz7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 15:55:59 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF7D89AF6
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Dec 2022 12:55:57 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r18so2126098pgr.12
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Dec 2022 12:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJg0tjf49GVzZZXYJm/ESQ/vYejcTaVis8L45uiNSHA=;
        b=WGDXl+n8K/dWeZKeldPrcD/v5Zbw4izCFegv/+gHVqJz5fo4i63IakbdgfDk32UOJ0
         K7CA6axewHrdePgh+eO1x8V+20MgZoSmeS/R+OUwnzbSv5HurnxALTfCXtREO7ppxxNa
         U6LdFtKTrAAZMCV9qJ/PEyYe9JUYQMujpcuIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJg0tjf49GVzZZXYJm/ESQ/vYejcTaVis8L45uiNSHA=;
        b=slHZtISuYQwYvIRRZ22KF7Rf4Y6Z7/iwLeDyaMsYlQkWiCeL7FVoF2x4+d6eoT7Zux
         MQYjeTZ5cOGwMKOa4T/TlZuz+HgZciTKzuCHBwlgRp6SyUKZD8vKNGKAHWSPsQ9jb1Az
         mA+I2DeifHe2Zp1MIT2obwV4RnPwZHOTfNZnv2HvQReWA2Dc8U2RBNB83RZ/3Zkgdh3W
         yTR2F8Y39W3Iw8YRrO4mX8+m7xSL9r06/wuPym5R7KDcEGKI5elpTfcHE9XWWyyf30Hc
         IQSMF/IqicvS6DTz9R9TvGNyOvA6+FTKdwiTKN5yNkHz3MZdj1FLq+lU2qp3MOcvuzru
         fEjQ==
X-Gm-Message-State: ANoB5pkUpP4kRajDj+WBVBawP6GziPvEy4B7HOOUHoDeO1DNHMKX56fb
        uSaTEXLxQCkk3PJY2kA3K3qLUQ==
X-Google-Smtp-Source: AA0mqf4zdrgHUuOag7wMXflhe99eH3jKylHoxnM8ECvbLmGYxFdavLPXAx42+E9rBdvD3R4pu3TLog==
X-Received: by 2002:a62:e219:0:b0:577:5678:bc80 with SMTP id a25-20020a62e219000000b005775678bc80mr9602372pfi.62.1670532956522;
        Thu, 08 Dec 2022 12:55:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7-20020aa78e87000000b005764c8f8f07sm12310108pfr.84.2022.12.08.12.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:55:56 -0800 (PST)
Date:   Thu, 8 Dec 2022 12:55:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Xu <jeffxu@google.com>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212081255.22D92C5@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <202212080809.687CC8BC23@keescook>
 <CALmYWFukzdw4e3RHWRsdXvYr1RZs7Bx6NZ3AK91hoArgVy-RxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALmYWFukzdw4e3RHWRsdXvYr1RZs7Bx6NZ3AK91hoArgVy-RxQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 08, 2022 at 10:33:19AM -0800, Jeff Xu wrote:
> On Thu, Dec 8, 2022 at 8:13 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Dec 07, 2022 at 03:49:33PM +0000, jeffxu@chromium.org wrote:
> > > This is V6 version of patch: see [4] [5] [6] [7] for previous versions.
> >
> > When sending a new version, can you include an overview of what changed
> > between this version and the prior version? This helps reviewers who are
> > following along, so it's easier to focus our attention on the
> > differences. Also, it's helpful to version the links:
> >
> > > [4] https://lwn.net/Articles/890096/
> > > [5] https://lore.kernel.org/lkml/20220805222126.142525-1-jeffxu@google.com/
> > > [6] https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
> > > [7] https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/
> >
> > e.g.:
> >
> > v6:
> > - moved foo to bar
> > - improve comments for baz
> > v5: https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/
> > v3: https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
> > v2: ...etc
> >
> Will do!
> Much appreciated for helping me  through the process of my first patch
> in the kernel.

Happy to help! I'm excited to see this gap in memfd security closed. :)

-- 
Kees Cook
