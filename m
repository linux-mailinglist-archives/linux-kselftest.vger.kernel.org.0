Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6D3881D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 23:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352372AbhERVKO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 17:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352353AbhERVKO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 17:10:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C46C061573
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 14:08:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q15so7888004pgg.12
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 14:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=As0TR/yrddFM+orjwRplkKxLfSr+Fk7q/h0XC1AzLtU=;
        b=SvwzTowIitwxvlrfLXr6aaY35NEVx+e4ZfdwpbvQqWQdmZ0XmlFt4r+/OwDLTS3ixV
         4wir8x9ffSORCYmQSTBh35Mr+Qsifb7N41JJ/dIEjnjKdm7XS5Esz/34a9wzjdGcq8rA
         ZOjh9tRx/+ICsSvVjOEyCmN60meCbf9/4nftAwx16J5LtG+nI1MC/8eAr9jValMZ4Ben
         pJy2JPrYvMu5Owg1PZPhSNvgkH8wahfVcXIYvean300D4R8rtqP2JLNUVEIOIIgS6kxy
         LCV5r1bnfaROwMeBA0ubkfoASHAsNeYb1lVwUkuwvlCgdLFi5txlR8QtXguIShxEvhym
         Dtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=As0TR/yrddFM+orjwRplkKxLfSr+Fk7q/h0XC1AzLtU=;
        b=B4H7qBWnT+vlxafDv/8X/pITpZ02Fx5fB76h0jmAirj7GyGFVa7hZBBy6quUXC5kdB
         aoPscNc6+P/YW9UnybTDelqKpU5NECF55FZ2JJIlOhbqsuKJKLs/7v7bqAcWpv61L3Kx
         19z+KkIbVIBOYgfd/mgFUO9wp+h6LrUsCG91MreWXTeq7pDLBEIYBANlvfvBbgB5CQHk
         UmWzjKWYG8ek3w5Dvgk2fGQJVGT0oH8e6u651QSGIgWQGmp2eXnK2U9aNlWqPPz2tUs5
         6NgFSDDbyBiJ7ai4+9IhrGuf1BSdWZgLHHceQ6aPAryXqDb6U6UmVVS2b6UzwG3nSprT
         oUqg==
X-Gm-Message-State: AOAM532CH18ymQqyw4tezU/qvy/5t6W32EPy2VhkQnO+zX5ts4nksCNi
        DKrUzo8m5Hg9qVdD+6/HUJtvdoHgvGDDdyWByUwlV7/pMlg=
X-Google-Smtp-Source: ABdhPJxEv3mBiNJh/sZOxRSO7B98DsBg99cnL4KK2eBVH/QpazNym6OY2FqZTZLs1pbrnb7Nn95OTGD6A7d++rxBq5Q=
X-Received: by 2002:a63:cc11:: with SMTP id x17mr7059732pgf.159.1621372134140;
 Tue, 18 May 2021 14:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210507213110.155492-1-brendanhiggins@google.com>
 <20210507213110.155492-5-brendanhiggins@google.com> <CABVgOSnnb=LB2hQOVqarDd3Tv17f7JHHomvSfWeQaFSsH1PD2g@mail.gmail.com>
In-Reply-To: <CABVgOSnnb=LB2hQOVqarDd3Tv17f7JHHomvSfWeQaFSsH1PD2g@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 18 May 2021 14:08:43 -0700
Message-ID: <CAFd5g47dqGin2QO_RLZKu93rt_j0xv7Dg1KTCrgYi7bVoaEjKg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] Documentation: kunit: document support for QEMU in kunit_tool
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 15, 2021 at 1:01 AM David Gow <davidgow@google.com> wrote:
>
> On Sat, May 8, 2021 at 5:31 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Document QEMU support, what it does, and how to use it in kunit_tool.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
>
> This is a good start, and probably meets the minimum requirements, but
> I do have a number of comments and suggestions below.
>
> Cheers,
> -- David
>
> >  Documentation/dev-tools/kunit/usage.rst | 37 +++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > index 650f99590df57..b74bd7c87cc20 100644
> > --- a/Documentation/dev-tools/kunit/usage.rst
> > +++ b/Documentation/dev-tools/kunit/usage.rst
> > @@ -612,14 +612,39 @@ only things to be aware of when doing so.
> >  The biggest impediment will likely be that certain KUnit features and
> >  infrastructure may not support your target environment. For example, at this
> >  time the KUnit Wrapper (``tools/testing/kunit/kunit.py``) does not work outside
> > -of UML. Unfortunately, there is no way around this. Using UML (or even just a
> > -particular architecture) allows us to make a lot of assumptions that make it
> > -possible to do things which might otherwise be impossible.
> > +of UML and QEMU. Unfortunately, there is no way around this. Using UML and QEMU
> > +(or even just a particular architecture) allows us to make a lot of assumptions
> > +that make it possible to do things which might otherwise be impossible.
>
> This is a bit more awkward now, and I don't think gives quite the
> right impression. Particularly the "Unfortunately, there is no way
> around this." bit: there's no fundamental reason that someone couldn't
> implement support for some other emulator (or even a setup which
> pushed to real hardware and read results over serial), it'd just take
> a bit of work to implement (like this patch series has done for qemu).
>
> Personally, I think it'd be easiest to simplify this section and say
> that kunit_tool currently only fully supports some architectures, via
> UML and QEMU.

Cool, I will fix that in the next revision.

> >
> >  Nevertheless, all core KUnit framework features are fully supported on all
> > -architectures, and using them is straightforward: all you need to do is to take
> > -your kunitconfig, your Kconfig options for the tests you would like to run, and
> > -merge them into whatever config your are using for your platform. That's it!
> > +architectures, and using them is straightforward: Most popular architectures
> > +are supported directly in the KUnit Wrapper via QEMU.  Currently, supported
> > +architectures on QEMU include:
> > +
> > +*   i386
> > +*   x86_64
> > +*   arm
> > +*   arm64
> > +*   alpha
> > +*   powerpc
> > +*   riscv
> > +*   s390
> > +*   sparc
> > +
> > +In order to run KUnit tests on one of these architectures via QEMU with the
> > +KUnit wrapper, all you need to do is specify the flags ``--arch`` and
> > +``--cross_compile`` when invoking the KUnit Wrapper. For example, we could run
> > +the default KUnit tests on ARM in the following manner (assuming we have an ARM
> > +toolchain installed):
> > +
> > +.. code-block:: bash
> > +
> > +       tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --arch=arm --cross_compile=arm-linux-gnueabihf-
> > +
>
> Is it worth also documenting the --qemu_config option here?
> (Particularly given the restriction on its path?) Or is that something
> best added to the kunit_tool page?
>
> That being said, changes to the kunit_tool page are probably worth
> adding as a section in the updated page:
> https://patchwork.kernel.org/project/linux-kselftest/patch/20210417034553.1048895-1-davidgow@google.com/
>
> At the very least, it'd be nice to have the new QEMU-related options
> documented there.

Probably a good idea. However, I will ask Shuah to pick up the
Documentation changes before I document the new options to avoid
conflicts.

> > +Alternatively, if you want to run your tests on real hardware or in some other
> > +emulation environment, all you need to do is to take your kunitconfig, your
> > +Kconfig options for the tests you would like to run, and merge them into
> > +whatever config your are using for your platform. That's it!
> >
> >  For example, let's say you have the following kunitconfig:
> >
> > --
> > 2.31.1.607.g51e8a6a459-goog
> >
