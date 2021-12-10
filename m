Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC36146FA77
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 06:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhLJFfS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 00:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbhLJFfS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 00:35:18 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6ECC0617A2
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 21:31:43 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id i6so14871412uae.6
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Dec 2021 21:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0NSNhFbAC6FtTfpwe02NJ8rlES2tisGIzao8IpuqYzs=;
        b=CThoUzj3So7BHGMlrTEYkm/Rn7xYDoWEhb5eQn7kvU41dfJUtXTnNMd6RyCs1wAm+P
         dYHC5KPtHqOa2tJPKaLS6guTrKhxogEUQ7/+fAwFbaUWc3qan6BxuYofUPKHCC012601
         zBmLXSydRJiUuvLKrXJFUxhCfrSS/R9xymMBmCmTDpDlvv5C3uWGBuGeWZt49FkyxoBQ
         5uVHHCK8QOG+fDKVRxx44ESplutf7Cgh+5C0N2YKxsLLZiUpO2U4lsb1FiKPgy7uvmv6
         noIwRGytRvLS0OwcMy8Y+0o0o1IJaNSUuDvFR5Dp/sy6SeZ/b+OfaEHQ8S9Vm+G2txxK
         Xreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0NSNhFbAC6FtTfpwe02NJ8rlES2tisGIzao8IpuqYzs=;
        b=I6+tQc5Pnaq1JUTpk7rR7gFVNh1NSnJjCj1dzDwDevk2EDY532yYzb3XKGYQtfp2O8
         Qwvuul0AOtXqeWoyMejgblvX4o8hcx7vbWg8QY9CXDttxJLVXkSKj1aI9K+Vsf8D+ucD
         eYf0QwMsZbPmjU5pvM1s1H2smOOn1IeOR9l2bSB20X0YebJ1hMH+DogV5QCoFqa6Ok12
         HFdJ5Mh6XCKTBdbDgDN/Gwm7ZN1rnSORg9l8MgrRGgGzRFyuwuP41m42Fr3wz2aYOSrz
         ehvxJiFruC6XkCW1XZLrnR1QOGbgF3a10BVXE7AE/hu6qNO+fkl1cMR4lJEQWdZxyKQW
         nXtA==
X-Gm-Message-State: AOAM532F84cq+/mV+RbG2Wl5SgSDsw9sBKj1tumdtG6fQrcSIfZtz+b+
        HR9hdX3b5W95cmHBEw5U0MFO3kAb6PL+++tuqyBQpA==
X-Google-Smtp-Source: ABdhPJw6Pnmp0hS1+T6/efrw023zC6xpQqnaN7GQxTlfC35vV6DS5QBcaR0UfXO+tVhlxsZ0dr2QDNZpXKpYAwWs4+Q=
X-Received: by 2002:ab0:3b12:: with SMTP id n18mr26872614uaw.2.1639114302934;
 Thu, 09 Dec 2021 21:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20211207054019.1455054-1-sharinder@google.com>
 <20211207054019.1455054-5-sharinder@google.com> <BYAPR13MB2503F47AA79D51CDE321AB21FD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB2503F47AA79D51CDE321AB21FD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   Harinder Singh <sharinder@google.com>
Date:   Fri, 10 Dec 2021 11:01:32 +0530
Message-ID: <CAHLZCaE5XLcrLrN5xEETfE3eKS8K4p5oQgAWSoqLJWm9WK7XLg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] Documentation: kunit: Reorganize documentation
 related to running tests
To:     tim.bird@sony.com
Cc:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Tim,

Thanks for your comments.

See my comments below.

On Tue, Dec 7, 2021 at 11:03 PM <Tim.Bird@sony.com> wrote:
>
> > -----Original Message-----
> > From: Harinder Singh <sharinder@google.com>
> >
> > Consolidate documentation running tests into two pages: "run tests with
> > kunit_tool" and "run tests without kunit_tool".
> >
> > Signed-off-by: Harinder Singh <sharinder@google.com>
> > ---
> >  Documentation/dev-tools/kunit/index.rst       |   4 +
> >  Documentation/dev-tools/kunit/run_manual.rst  |  57 ++++
> >  Documentation/dev-tools/kunit/run_wrapper.rst | 247 ++++++++++++++++++
> >  Documentation/dev-tools/kunit/start.rst       |   4 +-
> >  4 files changed, 311 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/dev-tools/kunit/run_manual.rst
> >  create mode 100644 Documentation/dev-tools/kunit/run_wrapper.rst
> >
> > diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> > index 75e4ae85adbb..c0d1fd749cd2 100644
> > --- a/Documentation/dev-tools/kunit/index.rst
> > +++ b/Documentation/dev-tools/kunit/index.rst
> > @@ -10,6 +10,8 @@ KUnit - Linux Kernel Unit Testing
> >
> >       start
> >       architecture
> > +     run_wrapper
> > +     run_manual
> >       usage
> >       kunit-tool
> >       api/index
> > @@ -98,6 +100,8 @@ How do I use it?
> >
> >  *   Documentation/dev-tools/kunit/start.rst - for KUnit new users.
> >  *   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
> > +*   Documentation/dev-tools/kunit/run_wrapper.rst - run kunit_tool.
> > +*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit_tool.
> >  *   Documentation/dev-tools/kunit/usage.rst - KUnit features.
> >  *   Documentation/dev-tools/kunit/tips.rst - best practices with
> >      examples.
> > diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentation/dev-tools/kunit/run_manual.rst
> > new file mode 100644
> > index 000000000000..71e6d6623f88
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/run_manual.rst
> > @@ -0,0 +1,57 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +============================
> > +Run Tests without kunit_tool
> > +============================
> > +
> > +If we do not want to use kunit_tool (For example: we want to integrate
> > +with other systems, or run tests on real hardware), we can
> > +include KUnit in any kernel, read out results, and parse manually.
> > +
> > +.. note:: KUnit is not designed for use in a production system. It is
> > +          possible that tests may reduce the stability or security of
> > +          the system.
> > +
> > +Configure the Kernel
> > +====================
> > +
> > +KUnit tests can run without kunit_tool. This can be useful, if:
> > +
> > +- We have an existing kernel configuration to test.
> > +- Need to run on real hardware (or using an emulator/VM kunit_tool
> > +  does not support).
> > +- Wish to integrate with some existing testing systems.
> > +
> > +KUnit is configured with the ``CONFIG_KUNIT`` option, and individual
> > +tests can also be built by enabling their config options in our
> > +``.config``. KUnit tests usually (but don't always) have config options
> > +ending in ``_KUNIT_TEST``. Most tests can either be built as a module,
> > +or be built into the kernel.
> > +
> > +.. note ::
> > +
> > +     We can enable the ``KUNIT_ALL_TESTS`` config option to
> > +     automatically enable all tests with satisfied dependencies. This is
> > +     a good way of quickly testing everything applicable to the current
> > +     config.
> > +
> > +Once we have built our kernel (and/or modules), it is simple to run
> > +the tests. If the tests are built-in, then will run automatically on the
>
> then will run -> they will run
> (or 'then they will run')
>

Done

> > +kernel boot. The results will be written to the kernel log (``dmesg``)
> > +in TAP format.
> > +
>
> The rest looks OK to me.
>
> You can add a 'Reviewed-by' for me if you want.
>  -- Tim
>

Regards,
Harinder Singh
