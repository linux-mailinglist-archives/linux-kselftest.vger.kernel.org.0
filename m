Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170964C242F
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 07:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiBXGqw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 01:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiBXGqv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 01:46:51 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6292E26A3AF
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 22:46:22 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id m11so894065pls.5
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 22:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BNrrQeR6NLfEy9loV4cRdfklZCJsQsZ1Ot62w9IVtWc=;
        b=FC6WwKcl8bcpZH6rSRW+egDrnBFtM3/+Wz8W+smEyyK8YkHUvCqHkLVFsbIzKgtIkZ
         rpJQYoPf92HL8Ol2sa/r8myerAxpRTYyvXhTy3eMvROo9vuXKaMmnwMwAwIW0RqdRIhC
         sCT8nHeSsD0KGOEbF+WJ88qUpgbSAyDK377p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BNrrQeR6NLfEy9loV4cRdfklZCJsQsZ1Ot62w9IVtWc=;
        b=UmssKgqXci8ZuDDVaxFDcvXS7UePeyrqcK7AzwdJRjn2HCJ72puf0AN523/eOb+Q98
         ADcnSnV1b5Z8jX1JtQk43yAdJv6BexRzHQvjRW/soh7dfYoXXT8ksBnrudSX74joiGFW
         nmKmirDGDp4wB/Z+lGztfjTTSqCCcWWrz0A8i97gw4gQIVyOwRs9Ej0DRcwK8dNHQjFT
         nStlgCQQHMUQXw4c84f/yEEnDERgCbW/epmXBosh9KWrAsd+0mAGYXzA01ne3FOGjG+v
         nuRjoHz8WYLoJtWlOkQnifTag8ENYRvcjp/V4NcSK70cxN7hUQJVh6GsjVXsBGvCkwdU
         Y3rg==
X-Gm-Message-State: AOAM531Ghd9pkA/+c8PdAygdJvpEU1OHhghcmgCvMJZG3ZCfOC4clPLP
        d2j2BhXtLc9W7luHbW79raedToRPg9WGzQ==
X-Google-Smtp-Source: ABdhPJxPMmxj82io+/WpZ92rz6mdpLfWg+7yYFn+HEFTUTwqoTzzIKGNd9B5t41jrbqTU+7RMRhLuA==
X-Received: by 2002:a17:90a:ab89:b0:1bc:71a7:f93a with SMTP id n9-20020a17090aab8900b001bc71a7f93amr1341755pjq.111.1645685181936;
        Wed, 23 Feb 2022 22:46:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f7sm1866845pfc.0.2022.02.23.22.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 22:46:21 -0800 (PST)
Date:   Wed, 23 Feb 2022 22:46:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kunit: tool: Do not colorize output when redirected
Message-ID: <202202232245.BD69919F@keescook>
References: <20220224055350.1854078-1-keescook@chromium.org>
 <CABVgOS=pFN4T5HjYpJPW4KOzXRFr-SUTm09xymxBmyidg0h=WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOS=pFN4T5HjYpJPW4KOzXRFr-SUTm09xymxBmyidg0h=WA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 24, 2022 at 02:43:53PM +0800, David Gow wrote:
> On Thu, Feb 24, 2022 at 1:53 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Filling log files with color codes makes diffs and other comparisons
> > difficult. Only emit vt100 codes when the stdout is a TTY.
> >
> > Cc: Brendan Higgins <brendanhiggins@google.com>
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: kunit-dev@googlegroups.com
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> Ah, you can tell a tool has "made it" when people are redirecting its output!

Heheh. Indeed! I have some more patches coming where I put a diff of
output in the commit log. ;)

> This works fine here.
> 
> Reviewed-by: David Gow <davidgow@google.com>

Thanks!

-Kees

> 
> Thanks,
> -- David
> 
> >  tools/testing/kunit/kunit_parser.py | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > index 05ff334761dd..807ed2bd6832 100644
> > --- a/tools/testing/kunit/kunit_parser.py
> > +++ b/tools/testing/kunit/kunit_parser.py
> > @@ -11,6 +11,7 @@
> >
> >  from __future__ import annotations
> >  import re
> > +import sys
> >
> >  import datetime
> >  from enum import Enum, auto
> > @@ -503,14 +504,20 @@ RESET = '\033[0;0m'
> >
> >  def red(text: str) -> str:
> >         """Returns inputted string with red color code."""
> > +       if not sys.stdout.isatty():
> > +               return text
> >         return '\033[1;31m' + text + RESET
> >
> >  def yellow(text: str) -> str:
> >         """Returns inputted string with yellow color code."""
> > +       if not sys.stdout.isatty():
> > +               return text
> >         return '\033[1;33m' + text + RESET
> >
> >  def green(text: str) -> str:
> >         """Returns inputted string with green color code."""
> > +       if not sys.stdout.isatty():
> > +               return text
> >         return '\033[1;32m' + text + RESET
> >
> >  ANSI_LEN = len(red(''))
> > --
> > 2.30.2
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220224055350.1854078-1-keescook%40chromium.org.



-- 
Kees Cook
