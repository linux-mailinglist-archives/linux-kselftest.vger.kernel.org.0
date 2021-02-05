Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E78310B6E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Feb 2021 13:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhBEMyj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 07:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhBEMwD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 07:52:03 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EF8C061794;
        Fri,  5 Feb 2021 04:51:13 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id lw17so6643011pjb.0;
        Fri, 05 Feb 2021 04:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13fwvpS1xwI8gzdjW+w10UvlAtlMyV6cweEgiobvtzU=;
        b=buUsDEZj63icpM3xzVCBqH5pMnXieyUY28/1EhFsQU+Lt0WM9OlYAYOsucGgx4qCZ5
         S1OZv366GCzNsbbjrgSPn6HpxrkCLuRxtRz13CAc4P827OqlAQ9laCpQF/KW3Zt3Elhv
         Dl6xvDhY7EbPW2Ak/CcitJ9o+z/PJZ9AAW+T9QFc3AeBL0r0fmaKE1bHi/uC0SXo0nXW
         husX/chw8WnFR/jhALaW2KJp/dXg9ZSyyc3invpS85BnQJwwV0VsQZYOFeXh+koTikrF
         op1W8eBmABqdvk9IF4vVZXZry53CcP0cEzdz2YjBQ4IOBYDtfMeB+wzLDKeeNNQ/SgWq
         GFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13fwvpS1xwI8gzdjW+w10UvlAtlMyV6cweEgiobvtzU=;
        b=hzMCyaUceGP+0J7zeXyS4wbHnZnoClbcvryvZkGsogBEIG2MRtB/F6B5fG0Gq63fqK
         jCrfjAN6lTdmhdQMmKnLaKp2w/wc5OR2FBjeYBNIedhP73+VEEvCZJQ54k/PubiJ4QnG
         gmzn8qxcTjdUHP2JhpbHKC72ZMQNwRgP1TnDyByxKHJOOsnRcEx4lztFPgYcMikj94N8
         eZOlrBRHHHXBQE8w1fg2URbfyiS2sAEdYyx6emeDw4Ls92mJjaZujpy34fPQFlsNRIhV
         dnRW1hxmnlm53b6QVQMJdxoBXFMuiq8+XtRe/Rj7+meV1R7FkT/WoUKebhYNtgty3U2N
         uyrQ==
X-Gm-Message-State: AOAM533RT/25fN6S1kZwAtBulyNCnAM05RjCcbt6MOyTLO7jLkLZrpCZ
        ezP3H2tbv90jokQxCrryvV3cn8crwae/EPZVHWo=
X-Google-Smtp-Source: ABdhPJwXtU9vZdkXjHSxFPZU4pLFtzpPe+Rfqg5WPyMwqjE7xYAGpkiZJ5Mv8Z9NXzsRSfetkoorBgpXgJ5038AKgmE=
X-Received: by 2002:a17:90a:644a:: with SMTP id y10mr4192332pjm.129.1612529472380;
 Fri, 05 Feb 2021 04:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20210203165009.6299-1-rf@opensource.cirrus.com>
 <20210203165009.6299-2-rf@opensource.cirrus.com> <YBr9c44Dvq1ZNrEa@smile.fi.intel.com>
 <YBwiQ+l6yqs+g+rr@alley> <5bfefab6-7a1b-6f5f-319c-8897dbb79a5b@opensource.cirrus.com>
In-Reply-To: <5bfefab6-7a1b-6f5f-319c-8897dbb79a5b@opensource.cirrus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Feb 2021 14:50:56 +0200
Message-ID: <CAHp75VcARyR4YvnWoVk1gnR8v7u_YJPnV0x3Mbe7iLMrvpbSAQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] lib: vsprintf: Fix handling of number field widths
 in vsscanf
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shuah Khan <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 5, 2021 at 1:35 PM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
> On 04/02/2021 16:35, Petr Mladek wrote:
> > On Wed 2021-02-03 21:45:55, Andy Shevchenko wrote:
> >> On Wed, Feb 03, 2021 at 04:50:07PM +0000, Richard Fitzgerald wrote:

...

> >>> +   for (; max_chars > 0; max_chars--) {
> >>
> >> Less fragile is to write
> >>
> >>      while (max_chars--)
> >
> > Except that the original was more obvious at least for me.
> > I always prefer more readable code when the compiler might do
> > the optimization easily. But this is my personal taste.
> > I am fine with both variants.

I *slightly* prefer while-loop *in this case* due to less characters
to parse to understand the logic.

> >> This allows max_char to be an unsigned type.
> >>
> >> Moreover...
> >>
> >>> +   return _parse_integer_limit(s, base, p, INT_MAX);
> >>
> >> You have inconsistency with INT_MAX vs, size_t above.
> >
> > Ah, this was on my request. INT_MAX is already used on many other
> > locations in vsnprintf() for this purpose.
>
> I originally had UINT_MAX and changed on Petr's request to be
> consistent with other code. (Sorry Andy - my mistake not including
> you on the earlier review versions).
>
> But 0 < INT_MAX < UINT_MAX, so ok to pass to an unsigned. And as Petr
> said on his original review, INT_MAX is "big enough".

Some code has INT_MAX, some has UINT_MAX, while the parameter is size_t.
I think all of these inconsistencies should have a comment either in
the code, or in the commit message, or in the cover letter (depending
on the importance).
Or being fixed to be more consistent with existing code. Whichever you
consider better.

> I don't mind either way.
>
> > An alternative is to fix all the other locations. We would need to
> > check if it is really safe. Well, I do not want to force Richard
> > to fix this historical mess. He already put a lot lot of effort
> > into fixing this long term issue.

...

> >>> -   unsigned long long result;
> >>> +   const char *cp;
> >>> +   unsigned long long result = 0ULL;
> >>>     unsigned int rv;
> >>>
> >>> -   cp = _parse_integer_fixup_radix(cp, &base);
> >>> -   rv = _parse_integer(cp, base, &result);
> >>
> >>> +   if (max_chars == 0) {
> >>> +           cp = startp;
> >>> +           goto out;
> >>> +   }
> >>
> >> It's redundant if I'm not mistaken.
> >
> > Also this is more obvious and less error prone from my POV.
> > But I agree that it is redundant. I am not sure if this
> > function is used in some fast paths.
> >
> > Again I am fine with both variants.

I think we don't need a (redundant) code, but rather a comment.

> >>> +   cp = _parse_integer_fixup_radix(startp, &base);
> >>> +   if ((cp - startp) >= max_chars) {
> >>> +           cp = startp + max_chars;
> >>> +           goto out;
> >>> +   }
> >>
> >> This will be exactly the same, no?

-- 
With Best Regards,
Andy Shevchenko
