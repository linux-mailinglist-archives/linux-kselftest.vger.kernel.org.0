Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9AC2CF96E
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Dec 2020 06:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgLEFFv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Dec 2020 00:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgLEFFv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Dec 2020 00:05:51 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A559C061A4F
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Dec 2020 21:05:04 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 142so8922825ljj.10
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Dec 2020 21:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GPzNiXTeDi+bMPrvuEGLCjoNV1U5qwCjKDFW1FW9/I=;
        b=pbeyE35YhCAkocdBFeyGNPlIeS5QlOZsNLNTliesLneA+kSFVpq1c4pdULRCjXu3Xv
         Y67Y2kDHQmqosl/fQNNYOZ2Kf2OtOGuvzuQmyLWwSwmqZ1ZxWcCkzdRZTGIYSCT8V+nz
         4GSDXlWJbu5JHXf4yUOg/dJwwbGmYMIQHV32AzIyGn8Yxqk9kFRsHtYRa41CB/8a0a+j
         O/iMQTSdpoxw5OduJFBFa9LxMDxD10MMdjnLAhtWWg9exn/NQPUNw2x6KVtqWmcsfpp5
         9EV6X1poBoUuF5LOmpllDkIcv/ijQHlvkMqW9YqaFAg5ABiH0jEee9IAkvFFD2KCxZaK
         XTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GPzNiXTeDi+bMPrvuEGLCjoNV1U5qwCjKDFW1FW9/I=;
        b=anbieCcjyk7JAWTJBvWyTdljvOdFNlX0FuteaW4Kw64WDaNAbsYplVPr4CLSomjC+D
         Zn+Ncxnp+qQWu8lgNMTrA+CuhkC7VSrSxn7NUjx34uUu5zjwnWrUaH6rKzq2h+nFjZAU
         BtGwaQp8pfwGREofwgwylvEKVyLYRTUVMzEZo+pmX+nsmRjFilmXni0IeQ3Uay3GpXuV
         iwemfmGT7i4IGx+BH9H7CGrZngynazAGnID8LDuswJ3YT+GuYT3PVzbEeagCqpBdQljm
         Y9eHEOrZxEm1zXuzDKD8vjgXiIJZvPjGMXMBqx0mQUlmVM5vkmlCGadZNnqjF9S79QFO
         jFMw==
X-Gm-Message-State: AOAM530OHIhjUaa5RfR7aS7QPCbgEamHnBow54BSarbTx67M8pVYR1Mc
        F7nY8YA0rpJNZ/e4smZ4UApp6WP5CCY+4lEpgcBHWA==
X-Google-Smtp-Source: ABdhPJxW10tViFoXPII7m7v1BTnHEAJ92qL38girRJEdYUsUryqce5lCypsOgo6b9UYSubwQGJ59rS6TVPOPprYrhY0=
X-Received: by 2002:a2e:9746:: with SMTP id f6mr4393792ljj.270.1607144702740;
 Fri, 04 Dec 2020 21:05:02 -0800 (PST)
MIME-Version: 1.0
References: <20201203194127.1813731-1-dlatypov@google.com> <20201203194127.1813731-3-dlatypov@google.com>
 <CABVgOS=YfJdqmmU22XR4e84YyHudhksQc8X2rR1mz=6ukN=emA@mail.gmail.com> <CAGS_qxriVvSn5GXtAHdCjh+Y6k8+tNpVJ-Qm=kVOEOEXQJ4ACQ@mail.gmail.com>
In-Reply-To: <CAGS_qxriVvSn5GXtAHdCjh+Y6k8+tNpVJ-Qm=kVOEOEXQJ4ACQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 5 Dec 2020 13:04:50 +0800
Message-ID: <CABVgOSnQKGDJSs6V5xeqLS-ZOPRWCoPMxdq9K3DnfD8-nQZbDw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: move kunitconfig parsing into __init__
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Dec 5, 2020 at 2:18 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, Dec 3, 2020 at 7:57 PM David Gow <davidgow@google.com> wrote:
> >
> > On Fri, Dec 4, 2020 at 3:41 AM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > LinuxSourceTree will unceremoniously crash if the user doesn't call
> > > read_kunitconfig() first in a number of functions.
> >
> > This patch seems to partly be reverting the changes here, right:
> > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/tools/testing/kunit?h=kunit&id=fcdb0bc08ced274078f371e1e0fe6421a97fa9f2
> > (That patch moved the reading of kunitconfig out of __init__)
>
> Yes.
>
> >
> > My overall concern is that, really, there are some operations that
> > shouldn't need a kunitconfig (even if they do at the moment), so we'd
> > ideally want at least some of the operations currently under
> > LinuxSourceTree to be able to be run without first reading a
> > kunitconfig. Most notably, it'd be nice if kunit.py exec (and hence
> > LinuxSourceTree::run_kernel()) didn't need a kunitconfig, as the
> > kernel ought to already be built at this point.
> >
> > Now, this is all a little bit hypothetical, as we haven't bothered to
> > make kunit.py exec work without a kunitconfig thus far, but I'm a
> > touch hesitant to make it harder to bypass the kunitconfig reading
> > anyway.
>
> Fair point.
>
> So one alternative to this to make type-checkers happy is to declare
> _config instead of sneakily setting it in some random later method.
> Then in all the places that rely on _config, we'd need to add in
> checks that it's in fact set to give a better error message (so it's
> clear to the user that it's an internal tool bug and has nothing to do
> with them).

This seems plausible, if a bit verbose.

>
> The copy-paste of create+read_kunitconfig() is annoying, which is why
> I went with this.

Personally, the duplication of calls to {create,read}_kunitconfig()
doesn't bother me, but I definitely can see the advantage of having
the type system pick up when we've missed one.

> How about __init__ takes an optional argument that can disable this parsing?

This would be okay: I'm starting to feel that really, the ultimate
solution is either to split LinuxSourceTree up (and have separate
things for configuring, building, and running the kernel), or to pass
the kconfig stuff into just the functions that require it. But that is
a much more serious refactor, which I haven't fully thought through,
and I don't want to let the perfect be the enemy of the good here.
>
> E.g.
>
> def __init__(kconfig = None):
>    if kconfig is not None:
>      self._config = kconfig
>    else:
>      // create and read
>

What would the kconfig argument here be? Just an empty Kconfig()?
I'm not a huge fan of passing a "None" kconfig object when we want to
load a config, and a non-None one when we want an empty one: that
seems confusingly backwards.
Maybe it'd be possible to move the loading of the kunitconfig outside
LinuxSourceTree, and pass that (or an empty one) as needed?


> Or if we don't like the idea of requiring users who don't want a
> kconfig to pass in a dummy,
>
> def __init__(load_kconfig=True):
>    if not load_kconfig:
>      self._config = None
>    ...
>

I slightly prefer this, for the reasons above: True/False makes more
sense than None/Kconfig().

> >
> > >
> > > Adn currently every place we create an instance, the caller also calls
> > > create_kunitconfig() and read_kunitconfig().
> > >
> > > Move these instead into __init__() so they can't be forgotten and to
> > > reduce copy-paste.
> >
> > This seems to now be missing the create_kunitconfig() stuff (see below).
>
> Ah good catch. Completely unintentional.
> I'm sure I had the create_kunitconfig() stuff in __init__() at some
> point but must have inadvertently removed it somehow later on.
>
> > >
> > > The https://github.com/google/pytype type-checker complained that
> > > _config wasn't initialized. With this, kunit_tool now type checks
> > > under both pytype and mypy.
> > >
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > ---

Okay, so it looks like there are a few options with _kconfig:
1. Check for None everywhere (after explicitly setting it in the
constructor). Pros: Nicer error messages, doesn't require other
changes, Cons: verbose, still somewhat prone to error (could forget
{create,read}_kunitconfig())

2. Pass a Kconfig object into the constructor. Pros: a kconfig must
exist, so less error prone, Cons: if we allow passing None to load it,
that's confusing.

3. Pass a bool into the constructor. Pros: similarly less error prone.
Cons: True/False is not very descriptive.

4. Refactor and (e.g.) pass the kconfig only into functions which
require it. Pros: removes a "false dependency" on a kconfig for things
which don't need it. Cons: more work, more verbose.

Of these, I probably like them in this order 4, 2 (without None), 3, 2
(with None), 1. But, to be honest, I'd be happy enough with any of
them.

So, if we can get a v2 that fixes the missing create_kunitconfig(),
and does any of the above things, that sounds good to me.

Cheers,
-- David
