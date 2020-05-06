Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C81C6737
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 May 2020 07:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgEFFIo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 May 2020 01:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726660AbgEFFIo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 May 2020 01:08:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DEFC0610D5
        for <linux-kselftest@vger.kernel.org>; Tue,  5 May 2020 22:08:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v8so4016119wma.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 May 2020 22:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SceWBPekDdFRfF48uePY+T85beg2UFKBaFBprKKK2Fs=;
        b=wJPP8upA208Ny+tQsnui6Sto754+QGj6pbO1HMOcOxY9IevB+Y2kWGwCmsphMLAwBQ
         JZYn79elyP3RMcZR5FJtGBFDeTd+33jhRiMJg68J5ODXT/KOt8dZ+3CJAZP9ruC0pZGc
         q+dArPJ1yQdOD1LeSmVKKXcOGGLlUyRkrHKxnOabhaqR+arMfWH60wttfWHMMevee4FX
         JFM+vzw+Vsxotnguy7oXnD56vKGxKLP3veW+dB/zcULcp6nRJUn8S3CUhVE9tTGKK/uW
         ZFM/NA0CswW9mz4xTIS1SHDSxz8KFTlajxCkx4yqkkK31rDm5asI7c13XBmZXOtqxJAJ
         QWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SceWBPekDdFRfF48uePY+T85beg2UFKBaFBprKKK2Fs=;
        b=m06hpgThHBrHxlQaZgEnayfz9Mw5njnEesNsfgOHUKij25cfnbSF9rIMNrq8E4Xb3V
         LMhWpExcS+COqjdY4rSN65NRWEGvwkl481+oUR7Zf7CfHpFRr4zEacX0keTVtBvYaH6B
         DpsNSkbjUlD3sENWWNJiR4ypTEJAVxzyrllBipbDncQ/tbWVUo6OPtYzOZg50LlEnw2B
         E/QiSrDN0f04WDX9MgGrynhAJerYw7gVIU44yXlrEY3el5pp6fLC9ObC6gDnnVCLnniu
         /pwBHEQSILugYRQ2femUyuDdmNfaD6mCmP5zHRU+z6w22J5yl8JJ0rXmiIH1xqnm0XpM
         Bhfg==
X-Gm-Message-State: AGi0PuZGiWUNTQLY4Ccqr+r5mNTb89lJ8zQzzWeTsmM9tykilmNYr25s
        JbHMBD5Rk5mLjrWCPqWQ/HlJ9vc/3Yq5TY4c5se9xQ==
X-Google-Smtp-Source: APiQypJNX4BgVrJFR/RUHwSg0Jle8zGp48NuEq3xnGQEUwVPLzkBzxFXRfnSysvWwLqFKiOdR8JsNgakOQ3SbPsyRaE=
X-Received: by 2002:a1c:a512:: with SMTP id o18mr2258788wme.138.1588741722115;
 Tue, 05 May 2020 22:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200505102700.7912-1-anders.roxell@linaro.org>
In-Reply-To: <20200505102700.7912-1-anders.roxell@linaro.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 6 May 2020 13:08:30 +0800
Message-ID: <CABVgOS=awiwi7APWr5HgU6Eht-VAygWPeQyNsCnAF09OLpR46A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, "Theodore Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 5, 2020 at 6:27 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Make it easier to enable all KUnit fragments.  This is needed for kernel
> test-systems, so its easy to get all KUnit tests enabled and if new gets
> added they will be enabled as well.  Fragments that has to be builtin
> will be missed if CONFIG_KUNIT_RUN_ALL is set as a module.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  lib/kunit/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 95d12e3d6d95..537f37bc8400 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -41,4 +41,10 @@ config KUNIT_EXAMPLE_TEST
>           is intended for curious hackers who would like to understand how to
>           use KUnit for kernel development.
>
> +config KUNIT_RUN_ALL
> +       tristate "KUnit run all test"

I'm not 100% sure about this name and description. It only actually
"runs" the tests if they're builtin (as modules, they'll only run when
loaded).

Would KUNIT_BUILD_ALL or KUNIT_ALL_TESTS or similar be better?

It also, as mentioned, only really runs all available (i.e., with
dependencies met in the current .config) tests (as distinct from the
--alltests flag to kunit.py, which builds UML with allyesconfig), it
might be good to add this to the description or help.

Something like "Enable all KUnit tests" or "Enable all available KUnit
tests" (or even something about "all KUnit tests with satisfied
dependencies") might be clearer.

> +       help
> +         Enables all KUnit tests, if they can be enabled.
> +         That depends on if KUnit is enabled as a module or builtin.
> +
I like the first line here, but the second one could use a bit more
explanation. Maybe copy some of the boilerplate text from other tests,
e.g.:

          KUnit tests run during boot and output the results to the debug log
         in TAP format (http://testanything.org/). Only useful for kernel devs
         running the KUnit test harness, and not intended for inclusion into a
         production build.

         For more information on KUnit and unit tests in general please refer
         to the KUnit documentation in Documentation/dev-tools/kunit/.

         If unsure, say N.

>  endif # KUNIT
> --
> 2.20.1
>

Otherwise, this is looking good. I've done some quick testing, and it
all seems to work for me. As long as it's clear what the difference
between this and other ways of running "all tests" (like the
--alltests kunit.py option), I'm all for including this in.

Cheers,
-- David
