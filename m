Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0315C31156D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Feb 2021 23:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhBEWbs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 17:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhBEOQ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 09:16:29 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47652C061D7E;
        Fri,  5 Feb 2021 07:53:58 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r38so4791802pgk.13;
        Fri, 05 Feb 2021 07:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJ8JRC4RZfaxmRw/0lEclo4P/KAgqGyqHXZ05JIOI3M=;
        b=J8FTKg3oxadh25ZrACs14MQalo3icWehTJnEhLYyWPPcSX/LiPDIalkW/cO4lCrNAT
         4IoFo37RVxXBMgrG1rPQxp3Ctq9cNoLGdD4x9jPkJApNC4r6rQWvv9jFUVvSt4ihd3Fj
         l/ENCvfqKQeTmnd63aSEKiyRQPNW/ISRNqrEwlbuIaUVbLvRATHhuxHKL5GjPCb0GXdE
         +WcZdpw1WMp4zUkv+2BwPl9SndqHi0fpOthVfXVI3ks6IrlAWS1DCuJ12xFptxu6+Afu
         G1upsVSeBFcn/4aI9FscB6CHhepoZU/qclLJ/x8uGCVdUAn3Gu3hEdn1QblJVzQnuFMb
         pmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJ8JRC4RZfaxmRw/0lEclo4P/KAgqGyqHXZ05JIOI3M=;
        b=n+jWdOLlSUslM8szQW2cNvjgiZAnuFl224rFuwCrzSciWSp/8FVJz5vkryRanytfyc
         ZmxinvgGQ+YIAfqJeUOyagePn1/Z/muK3YhwNfgKIIxar996agLTcVtojHT+IMzxPpug
         TyAvJSFQ/gYEC5nXMx+zKCO1vUGninAnPFRCJcm6ygVyazTidEqZ+p3cz7l9A7O3srpq
         gJnziDLr6gre8EjmXdFgNq1ZiMFRwQVns1BL63BtiOSHZVuv4LmcfC3JIElk1Ms1Mgas
         tZmPlcof53VCUEOlYL1z7ISy07IKL82DRT0GnOiyGUdLfiTuxVKL7gYGimrbBjYMOj43
         XIOA==
X-Gm-Message-State: AOAM533vPYoIjyV+0qTS1ZpOC1kzr7LRQp9oesVPitcE+YDClfHFJdDX
        5Z2b5k6Sp/QlZ+Dc7Ac/ePfdxFQOwRudFHvJz9w3pZSQ5I7f9lSZ
X-Google-Smtp-Source: ABdhPJy3LPmeJMIT8h+mAN9cczpdiWaolqfleKmjgkwES8vFca5LztJtvQ4GjKeV5jIgxsSJHVHUm7gCm09yqrJnc+k=
X-Received: by 2002:a62:445:0:b029:19c:162b:bbef with SMTP id
 66-20020a6204450000b029019c162bbbefmr5351712pfe.40.1612540437831; Fri, 05 Feb
 2021 07:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20210203165009.6299-1-rf@opensource.cirrus.com>
 <20210203165009.6299-2-rf@opensource.cirrus.com> <YBr9c44Dvq1ZNrEa@smile.fi.intel.com>
 <YBwiQ+l6yqs+g+rr@alley> <5bfefab6-7a1b-6f5f-319c-8897dbb79a5b@opensource.cirrus.com>
 <CAHp75VcARyR4YvnWoVk1gnR8v7u_YJPnV0x3Mbe7iLMrvpbSAQ@mail.gmail.com> <82696a371fe447c2b201fc812e5a4560@AcuMS.aculab.com>
In-Reply-To: <82696a371fe447c2b201fc812e5a4560@AcuMS.aculab.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Feb 2021 17:53:41 +0200
Message-ID: <CAHp75VcwTg1e=apHuOzCNmpK9c6LuZ_BLDZvq9BpaTC8Rcgguw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] lib: vsprintf: Fix handling of number field widths
 in vsscanf
To:     David Laight <David.Laight@aculab.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shuah Khan <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 5, 2021 at 5:23 PM David Laight <David.Laight@aculab.com> wrote:
> From: Andy Shevchenko
> > Sent: 05 February 2021 12:51
> > On Fri, Feb 5, 2021 at 1:35 PM Richard Fitzgerald
> > <rf@opensource.cirrus.com> wrote:
> > > On 04/02/2021 16:35, Petr Mladek wrote:
> > > > On Wed 2021-02-03 21:45:55, Andy Shevchenko wrote:
> > > >> On Wed, Feb 03, 2021 at 04:50:07PM +0000, Richard Fitzgerald wrote:
> >
> > ...
> >
> > > >>> +   for (; max_chars > 0; max_chars--) {
> > > >>
> > > >> Less fragile is to write
> > > >>
> > > >>      while (max_chars--)
> > > >
> > > > Except that the original was more obvious at least for me.
> > > > I always prefer more readable code when the compiler might do
> > > > the optimization easily. But this is my personal taste.
> > > > I am fine with both variants.
> >
> > I *slightly* prefer while-loop *in this case* due to less characters
> > to parse to understand the logic.
>
> The two loops are also have different values for 'max_chars'
> inside the loop body.

off-by-one to be precise.

> If 'max_chars' is known to be non-zero the do ... while (--max_chars);
> loop will probable generate better code.

What?! while (--x)  and while(x--) are equivalent.

> But there is no accounting for just how odd some decisions gcc
> makes are.

Why should we care about the compiler bugs here?

-- 
With Best Regards,
Andy Shevchenko
