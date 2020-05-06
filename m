Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8C11C6E6B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 May 2020 12:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgEFKdy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 May 2020 06:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728927AbgEFKdx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 May 2020 06:33:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA95C0610D5
        for <linux-kselftest@vger.kernel.org>; Wed,  6 May 2020 03:33:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b2so1793609ljp.4
        for <linux-kselftest@vger.kernel.org>; Wed, 06 May 2020 03:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rTt6LxaW/pHMjJunZzywGj8yOmnvtXY/IpJZLrkwj0=;
        b=t4a2X1xZecTMAZKKfKloaMIBbKbLsi4VpQyqIWN1xF0DyDh1wVaRehTCJaZg2McT5O
         HYJ0KfuCC6DXv3aXeqD5Vwy4k8q21/pCVGbunFsDZb2nIlgaBmr4apqE/EQpy/vLDkd8
         MDFvBTOGgHO+TxmSLQWuOwNy0c8/4coKHUTxu7E6HNd55tCXva9mj7uHD+mT51/KMFJY
         r7xAp6VJy25G+mWIQlCsDnFPYbpy6PL53rJ6yRT3lmIiGyDyh2o3xfoVaOFXKwrLUCK4
         UjpCSUmfaix/bg0gfEkdJxZbbPdK2P6v5+JGizRJ0BjnVRzmyAAhWA6MkzD4YvrXtSEb
         j/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rTt6LxaW/pHMjJunZzywGj8yOmnvtXY/IpJZLrkwj0=;
        b=ajLsoKUfTB9GU8Bd7UGR2lpey4H2mBq02l4t6ieekeM3yd4OeJ+vJF1w7dTV2ZfSEg
         3dzqMDB3RmW+tj2rRWsn0xkgQ6PN9wKvja0nSekVL2myFxL91IwwCnM4mizeeMGqQ2Rj
         EPW8DvXchwsoB9C1GLZ3o/gwmB/1LgxH5y+3d8xb+o+Fdydn6whcXVZHAhX/JHF24ugd
         dBA/9XMDuc6VenyVkT3Zc6z207CIjN+v1zia+P82KY5sHVlXPhx/3dRulRxwbUOKi22+
         tmNdcHpYjtwdSHfPVRJR22IrxyXKEhSTSGg8pEuB+gbMKQ/ZfhSkFbQeQjYZBQevc7ZY
         mWUw==
X-Gm-Message-State: AGi0PuY4mcb/oidejTVoFwss6vOcpHszijEed7FEJzBluC2O47t/QL0i
        YPLDpALLNMpUiKA9CDMrPO6qtrNJJD4/45yMt31fO7CGVXOE0A==
X-Google-Smtp-Source: APiQypJ2iFf2i42ytFK2XNMo32cD+nb2gyVuT/JFrTqbobcbJ/UpsVR9eFZeVYgFYeicoDgdzICiyNX3uSgZYLIIfJ8=
X-Received: by 2002:a2e:9842:: with SMTP id e2mr4512086ljj.273.1588761230232;
 Wed, 06 May 2020 03:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200505102700.7912-1-anders.roxell@linaro.org> <CABVgOS=awiwi7APWr5HgU6Eht-VAygWPeQyNsCnAF09OLpR46A@mail.gmail.com>
In-Reply-To: <CABVgOS=awiwi7APWr5HgU6Eht-VAygWPeQyNsCnAF09OLpR46A@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 6 May 2020 12:33:38 +0200
Message-ID: <CADYN=9Jdwd=3Rh=wyzO7eOxtyTSm+JqjF385iQjfMocpz1A3YA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

Thank you for the review.

On Wed, 6 May 2020 at 07:08, David Gow <davidgow@google.com> wrote:
>
> On Tue, May 5, 2020 at 6:27 PM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > Make it easier to enable all KUnit fragments.  This is needed for kernel
> > test-systems, so its easy to get all KUnit tests enabled and if new gets
> > added they will be enabled as well.  Fragments that has to be builtin
> > will be missed if CONFIG_KUNIT_RUN_ALL is set as a module.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  lib/kunit/Kconfig | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > index 95d12e3d6d95..537f37bc8400 100644
> > --- a/lib/kunit/Kconfig
> > +++ b/lib/kunit/Kconfig
> > @@ -41,4 +41,10 @@ config KUNIT_EXAMPLE_TEST
> >           is intended for curious hackers who would like to understand how to
> >           use KUnit for kernel development.
> >
> > +config KUNIT_RUN_ALL
> > +       tristate "KUnit run all test"
>
> I'm not 100% sure about this name and description. It only actually
> "runs" the tests if they're builtin (as modules, they'll only run when
> loaded).
>
> Would KUNIT_BUILD_ALL or KUNIT_ALL_TESTS

I would like to go with KUNIT_ALL_TESTS if no one objects.

> or similar be better?
>
> It also, as mentioned, only really runs all available (i.e., with
> dependencies met in the current .config) tests (as distinct from the
> --alltests flag to kunit.py, which builds UML with allyesconfig), it
> might be good to add this to the description or help.
>
> Something like "Enable all KUnit tests" or "Enable all available KUnit
> tests" (or even something about "all KUnit tests with satisfied
> dependencies") might be clearer.

I like "All KUnit tests with satisfied dependencies".

>
> > +       help
> > +         Enables all KUnit tests, if they can be enabled.
> > +         That depends on if KUnit is enabled as a module or builtin.
> > +
> I like the first line here, but the second one could use a bit more
> explanation. Maybe copy some of the boilerplate text from other tests,
> e.g.:
>
>           KUnit tests run during boot and output the results to the debug log
>          in TAP format (http://testanything.org/). Only useful for kernel devs
>          running the KUnit test harness, and not intended for inclusion into a
>          production build.
>
>          For more information on KUnit and unit tests in general please refer
>          to the KUnit documentation in Documentation/dev-tools/kunit/.
>
>          If unsure, say N.

Makes much more sense, thanks.

>
> >  endif # KUNIT
> > --
> > 2.20.1
> >
>
> Otherwise, this is looking good. I've done some quick testing, and it
> all seems to work for me. As long as it's clear what the difference
> between this and other ways of running "all tests" (like the
> --alltests kunit.py option),

Do you think it should be made clearer in some way?

> I'm all for including this in.
>

Cheers,
Anders
