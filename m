Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2B95159ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 04:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbiD3C5g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 22:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiD3C5f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 22:57:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767F6B1AAB
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 19:54:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x18so12960443wrc.0
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 19:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=At5x0vwx+0kNPvKIIZERfAAx8DzudMw2FI8jUD9f4fw=;
        b=afOHB8WfTSVmo1t+0T6XP+znSB29GtGLFCnuGs+mt2nkcNlosx4otYCqwoXBLsgDC2
         QqR4DBAm7zWcL3KiOlME6s9jySPzKxBZOdzkOZv5ZB1kt54x3Wygne733T3cG/uIc2X/
         YYeIrHFsToqqOnhfkeBxRssS/M6ZozFR+aGfWX3kfemIhEqzagiyEI+LHJsXzI1Ce2vW
         jQf0zFLVMtB6Igcy9dOTfvhWO16Ohv4qKlxjwG68pvKzoXmG6NZRnK+JRaOnKSMq25Lc
         xXzSLo52MTmes+WsiPyKggaRRQlO+iRthhScWjWJ0CmSIJwZJe2iQsMhzlrwF9ZTkxt6
         QxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=At5x0vwx+0kNPvKIIZERfAAx8DzudMw2FI8jUD9f4fw=;
        b=T/zSrwZFqpSC65IS1j/e1RqkFQjyNtlXYUghLppQQhxJaKH/Qq+/sD1zO2b2hLCLEU
         /kivKcEzIuGSSvNDPqCZPX/7kRYSu4gKaibAILqPm6LrFPP/qdA1sGme6E4Ahmxg2e62
         tHlNVWevqBlzmhxM9lAnq5TWvdeRWYw3IXKgiahnU0afjnhP1wPnOZAcobTILqsuDlgJ
         YNO8jHsu8E+3s/t6hXsTFgG2+QO4OjcArWVFOwU1o33tSyEYso9vWJuJI4LvYiVgkZDW
         pPpDzFctuoo7AvsXRq5P+ImFeai9llX7ZIZzf92YN6IpgeM+biYFqTx7D4+Nyz2Ox0UC
         K03A==
X-Gm-Message-State: AOAM530OVe59fYMS3Oors4tuVskigjota0hM+6ozv/R0Wx01Gh4sOk/7
        Q1e7Q85NNoB2bfDor8cODW5zPRhYq+L54yF9zxxxXg==
X-Google-Smtp-Source: ABdhPJyeIB2RkdixEXoN25B4RRGZcH4tLs0XeX0TGRPl8SUbZAQ5Pg5Ry/w/sOv+m/oNwrr7ExkT0Psenbv3heh6mhA=
X-Received: by 2002:a5d:4806:0:b0:20a:da03:711b with SMTP id
 l6-20020a5d4806000000b0020ada03711bmr1387927wrq.395.1651287253894; Fri, 29
 Apr 2022 19:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com> <YmuPFGrkzQYACgK0@kroah.com>
In-Reply-To: <YmuPFGrkzQYACgK0@kroah.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 30 Apr 2022 10:54:02 +0800
Message-ID: <CABVgOSmn3fTOr0LB3bUMJOzKTjNd6EMtSEKz5ZRfTfeF7DiE2w@mail.gmail.com>
Subject: Re: [PATCH] kunit: Taint kernel if any tests run
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 29, 2022 at 3:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 29, 2022 at 12:39:14PM +0800, David Gow wrote:
> > KUnit tests are not supposed to run on production systems: they may do
> > deliberately illegal things to trigger errors, and have security
> > implications (assertions will often deliberately leak kernel addresses).
> >
> > Add a new taint type, TAINT_KUNIT to signal that a KUnit test has been
> > run. This will be printed as 'N' (for kuNit, as K, U and T were already
> > taken).
> >
> > This should discourage people from running KUnit tests on production
> > systems, and to make it easier to tell if tests have been run
> > accidentally (by loading the wrong configuration, etc.)
> >
> > Signed-off-by: David Gow <davidgow@google.com>

< snip >

> > +     [ TAINT_KUNIT ]                 = { 'N', ' ', false },
>
> As kunit tests can be in modules, shouldn't this be "true" here?

Ah, good catch. While I tend to use either built-in tests (or modules
which are immediately unloaded), there are definitely some cases where
the tests are part of long-lasting modules.

I'll send out v2 with that changed.

> Overall, I like it, makes sense to me.  The "N" will take some getting
> used to, and I have no idea why "T" was for "struct randomization", that
> would have allowed you to use "T" instead.  Oh well.

Yeah, 'T' would've been nice, but I doubt it'd be worth trying to
change it now. At least we haven't had to resort to emoji...

Adding an actual name as Jani suggested would be a good idea, IMHO,
though obviously best done in a separate patch.


Cheers,
-- David
