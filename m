Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC754E9F4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 20:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245377AbiC1TAF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 15:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245392AbiC1TAD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 15:00:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843DCE0DE
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 11:58:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z92so18011853ede.13
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y7h2AchlhCAthHYHcLIlHiiUCH1u4tsKGd2lWHTZUlY=;
        b=mzL7CPaM/qH7HTC6bp0faYg2StoSqQkehQG7tEQFBD6MCSe3XcD+kHNFEbCTamS1Pw
         qumiplt3iKPQUj0cqZQ1kw3OIBmh4MtZBIQSgNDRgAclRYsb1/f0hyX6ry0Z4598KQwu
         oKmvQUQq5Y6EgdRP/JknK0Xx+pa9BsiZkYMScUwrUdgADuZbpfdM2YWBWBEJjv2cmp/Q
         YLIIaK9aKIX3ZAtI/NHqT8c0bXXpSU231LBgnUIOiPaogDDWWNt221MuVZWz/ufUeRN0
         bwwAh9f7pWf/yo3yreuykfHUearzuagnk5PqlE74yVTBBbCA8MmNNNEF7nvrlIy9byBd
         Hx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7h2AchlhCAthHYHcLIlHiiUCH1u4tsKGd2lWHTZUlY=;
        b=V333V8qJ7+5sCkn7OqowJIoa4xKTYOqPi0Ativl8Lpp0dF5/eL+w/3auDg+0+8O7/T
         tA6YyrJpQHj7zODv2zSKMrlKzV4Lj8XLofzj0VFtSnyfeu4IYnKGQbDSHtyCB9i++6Iz
         LrLakMjdmpfSy+ojUQNWQlRcaHD/YFItqA7CaVgXyq3D2coFFI0BcK4JdvpGwtrr5oaD
         uVWF3NLZf7R6OVvX6vh86+qBXK5x38FzY+aw0ecRicZsfVYKuq1WFKVUi9T+2UohqCVB
         Rp2o5hP1X/8Qb5qnQXLEX0JC8I3O3/O0wcZFbZ09w9esPTuEHe2iNcG7L14wVSZmf86K
         CyhA==
X-Gm-Message-State: AOAM533Y7WtIMBZtapfZo2IZY4DcCtYJDEmnqCOSdtLEe5joRSvspmG3
        nt4Tj3ijfZ59qTU1zuMXfKJQjzpjJwu1oEESXrCMq9G9t2/Mlg==
X-Google-Smtp-Source: ABdhPJyhJkHcV4gC2iZ87HQT2UlMmP4fn/UBsOPEcsgyAISFagHCmwwoTGCGuHLFwOJv6MS2vb9mQGfOkes3PzUe8Yk=
X-Received: by 2002:a05:6402:4302:b0:419:4be8:6493 with SMTP id
 m2-20020a056402430200b004194be86493mr18086577edc.294.1648493897275; Mon, 28
 Mar 2022 11:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220326003356.487828-1-dlatypov@google.com> <CABVgOSmbQxZmmNtUQLsvMSPkr2FpXB_kdJUUbC=nLrt6xN7e2A@mail.gmail.com>
 <CAGS_qxq_vFtGS4BGieZz8L3QH7rZ7ZN25pGYmjWWoXbTGOKC9A@mail.gmail.com> <CAFd5g45f3X3xF2vz2BkTHRqOC4uW6GZxtUUMaP5mwwbK8uNVtA@mail.gmail.com>
In-Reply-To: <CAFd5g45f3X3xF2vz2BkTHRqOC4uW6GZxtUUMaP5mwwbK8uNVtA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 28 Mar 2022 13:58:06 -0500
Message-ID: <CAGS_qxp604tXbqzSg0nmz=Ws9ZzX47u-XCftNxfcamyM=GrQYw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: update kconfig options needed for
 UML coverage
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>, Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, maxime@cerno.tech
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 28, 2022 at 11:54 AM 'Brendan Higgins' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> On Mon, Mar 28, 2022 at 12:35 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Fri, Mar 25, 2022 at 9:56 PM David Gow <davidgow@google.com> wrote:
> > >
> >
> > <snip>
> >
> > > >         # Append coverage options to the current config
> > > > -       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
> > > > +       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
> > > >         $ ./tools/testing/kunit/kunit.py run
> > >
> > > Would we want to instead use a chain of --kconfig_add arguments? (I
> > > think there are advantages either way...)
> >
> > I've been considering this ever since the --kconfig_add patch was accepted.
> > It's more compatible w/ commands using --kunitconfig, but it also
> > looks very verbose.
> > E.g. it looks like
> >
> > $ tools/testing/kunit/kunit.py run --make_options=CC=/usr/bin/gcc-6
> > --kconfig_add=CONFIG_DEBUG_INFO=y
> > --kconfig_add=CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> > --kconfig_add=CONFIG_GCOV=y
>
> I don't think it's *that* much more verbose, but I see your point. I
> personally prefer this, but not enough to argue about it.

I personally prefer it too, but I'm biased as the person who added
--kconfig_add.
They're both ugly enough I'd figured I'd save the bikeshedding for
another patch.

>
> > Neither looks very appealing to me, so I've just kept it as-is for now.
> >
> > Maybe there's something we can do to make this easier (e.g. allowing
> > --kunitconfig to be repeated and mergable)?
>
> I would like --kunitconfig to be repeadable and mergable.

Ack.
There's some things to consider first.

1. This will conflict w/
https://patchwork.kernel.org/project/linux-kselftest/patch/20220226212325.2984807-1-dlatypov@google.com/,
so I'm going to wait until that gets merged first.

2. some kconfigs can be incompatible (e.g. these options only work on
UML, can't combine w/ a non-UML compatible file)
How do we make this less of a footgun?
We'd talked about how it'd be nice if kconfig/"make olddefconfig"
could print out *why* options get dropped (either they're not visible,
have unmet deps, etc.). If we had that, I'd feel more comfortable w/
repeatable kunitconfig.

3. People have the ability to do this already if they're really sure it's safe
$ cat <files...> | ./tools/testing/kunit/kunit.py run --kunitconfig=/dev/stdin

4. are we committed to supporting a "uml_coverage.kunitconfig" file?
As shown by the existence of this patch, we've let it get broken for a
bit, at least against linux-next (afaik, it was working on
torvalds/master up until the 5.18 window opened and we had some
patches reworking CONFIG_DEBUG_INFO).

These instructions exist so others don't have to try and re-figure out
the steps/workarounds.
But they're not more formally "part of KUnit" since no one has had the
expertise to maintain it (and fix issues like the reliance on gcc-6),
etc.

Creating a kunitconfig file for this will further imply ownership.
