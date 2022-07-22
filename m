Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048E357D7AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jul 2022 02:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiGVAZI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 20:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiGVAZH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 20:25:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADCB39BBC
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 17:25:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w12so4057280edd.13
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 17:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+jSm49KfUYG5RhGRq72Xx7Q+0SpyncIbR4IwkZUcPE=;
        b=XxZ+xsTfqHc5yjsY1Ryxp5yNP3TbAnty9tQNkC/zAyHdMw9qTL9WknfOc6BYk7CBwr
         Uo5E2gZzdnaIcbdWbi3Gk1TPuPkh0x9RCKMcwGsxwYKQMowSuD3E66Ou10SASq6e2GqF
         DXrjW9tGWfObIxDuxZ+hESxFu+/cb9K2qp+l5uoP7l1rLFwiizuxgBwmZo8yXrBYrjyN
         pNsTC5E0mC0XDiRjridjW023zMNF7ZZuTCTPuDMaVX6blU86/8l/lHvqxH5E6+1ZKQMX
         hoLWS7dlqn0QYTNkvfQrzP6W3uaFpm6VKIiOuQlePW3vjlrHENCmp9eoZPDCEjIHjftL
         mefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+jSm49KfUYG5RhGRq72Xx7Q+0SpyncIbR4IwkZUcPE=;
        b=LGTb+WksoX/+2CmWy5w4V6VqxP3wru9DFF8oNK/rDKNFZhtop44S/jx6NImxCytt0h
         /DHhSEPm0d32OtaB2hY4FAPbdPxjAB1s4unQtIULJZEk4UdeTNdDwiWZI2W/gD2hio16
         oMGQOuLJYKxhRPdW+40tF0ZLnotWLPrDU0Wrv+yj0xoDwEKzk0bwlPH2dCCNpQ5zbOu3
         nSeycjvYnybX1Pu2BK6I/mFiAeC28Y4vE7ohguPxkU68aKuqc2aKrtRpMRioOifhcDDj
         OnmmMtmmwQIGkta0ngb3IX9mkOjWZAjxweox12PqL9G6zYgP9QN8CCGsdqZGP1QYPoWF
         N0qw==
X-Gm-Message-State: AJIora+TPKE8E5xqfRDxayQC4CB12qlzgVlsi+zXY5TlGKxN57YmN30o
        IG4B/IXqf6rfI7ZsgYU6l8V62ehHJtiozArbMQIHPA==
X-Google-Smtp-Source: AGRyM1sEecyNIEXWcjY+YZG5ShpQUpGqjIkWEVj6V5QstDHGZLRFssfV9P9uHVtjrqmKV1UbLeMuPVtGv+VVI7lVfVU=
X-Received: by 2002:a05:6402:2997:b0:43b:247b:89cb with SMTP id
 eq23-20020a056402299700b0043b247b89cbmr905683edb.91.1658449501795; Thu, 21
 Jul 2022 17:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220721081026.1247067-1-sadiyakazi@google.com> <CABVgOS=iOkquTXEPdS1skRj7Bda-H-REDW8mozziEYjn8RnRnw@mail.gmail.com>
In-Reply-To: <CABVgOS=iOkquTXEPdS1skRj7Bda-H-REDW8mozziEYjn8RnRnw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 21 Jul 2022 20:24:50 -0400
Message-ID: <CAFd5g46ssneHhqg8uXSZZ0=GP8DyqYq2xvQp5tK+cuUV2aVbrA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: Add CLI args for kunit_tool
To:     David Gow <davidgow@google.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
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

On Thu, Jul 21, 2022 at 7:54 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Jul 21, 2022 at 4:26 PM Sadiya Kazi <sadiyakazi@google.com> wrote:

[...]

> >  Documentation/dev-tools/kunit/run_wrapper.rst | 60 ++++++++++++++++++-
> >  1 file changed, 59 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
> > index 5e560f2c5fca..600af7ac5f88 100644
> > --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> > +++ b/Documentation/dev-tools/kunit/run_wrapper.rst

[...]

> > @@ -257,3 +257,61 @@ command line arguments:
> >              added or modified. Instead, enable all tests
> >              which have satisfied dependencies by adding
> >              ``CONFIG_KUNIT_ALL_TESTS=y`` to your ``.kunitconfig``.
> > +
> > +- ``--kunitconfig``: Specifies the path or the directory of the ``.kunitconfig``
> > +  file. For example:
> > +
> > +  - ``lib/kunit/.kunitconfig`` can be the path of the file.
> > +
> > +  - ``lib/kunit`` can be the directory in which the file is located.
> > +
> > +  This file is used to build and run with a predefined set of tests
> > +  and their dependencies. For example, to run tests for a given subsystem.
> > +
> > +- ``--kconfig_add``: Specifies additional configuration options to be
> > +  appended to the ``.kunitconfig`` file.
> > +  For example, ``./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y``.
> > +
>
> Just FYI, this example won't work as-is until KASAN for UML is merged.
> It's already sitting in uml/next, so this shouldn't be a problem:
> https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git/commit/?h=next&id=5b301409e8bc5d7fad2ee138be44c5c529dd0874
>
> But if you want to try it on 5.19 or the current kunit branch, you'll
> need to add, e.g., --arch=x86_64
>
> > +- ``--arch``: Runs tests on the specified architecture. The architecture
> > +  specified must match the Kbuild ARCH environment variable.
>
> I'm not quite sold on 'must match the Kbuild ARCH environment
> variable'. That seems to imply to me that you need to set ARCH= _and_
> use --arch. Instead, --arch itself sets ARCH=, so the values use the
> same names.

Agreed, I was just about to reply with a comment to the same effect.

> > +  For example, i386, x86_64, arm, um, etc. Non-UML architectures run on QEMU.
> > +  Default is `um`.
> > +
> > +- ``--cross_compile``: Specifies the Kbuild toolchain. It passes the
> > +  same argument as passed to the ``CROSS_COMPILE`` variable used by
> > +  Kbuild. This will be the prefix for the toolchain
> > +  binaries such as GCC. For example:
> > +
> > +  - ``sparc64-linux-gnu-`` if we have the sparc toolchain installed on
> > +    our system.
> > +
> > +  - ``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux``
> > +    if we have downloaded the microblaze toolchain from the 0-day
> > +    website to a specified path in our home directory called toolchains.
> > +
> > +- ``--qemu_config``: Specifies the path to a file containing a
> > +  custom qemu architecture definition. This should be a python file
> > +  containing a `QemuArchParams` object.
> > +
> > +- ``--qemu_args``: Specifies additional QEMU arguments, for example, "-smp 8".
> > +
> > +- ``--jobs``: Specifies the number of jobs (commands) to run simultaneously.4
> > +  By default, this is set to the number of cores on your system.
> > +
> > +- ``--timeout``: Specifies the maximum number of seconds allowed for all tests to run.
> > +  This does not include the time taken to build the tests.
> > +
> > +- ``--kernel_args``: Specifies additional kernel command-line arguments. Might be repeated.
>
> Nit: maybe "can be repeated"? As it's the reader of this documentation
> who will likely be doing the repeating. Or "may be repeated"?

+1

[...]
