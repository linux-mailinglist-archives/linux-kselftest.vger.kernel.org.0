Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22594E6B7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Mar 2022 01:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357031AbiCYAK0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Mar 2022 20:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357046AbiCYAKU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Mar 2022 20:10:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C52C1D33A
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Mar 2022 17:08:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id p15so12310253ejc.7
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Mar 2022 17:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7wMnxNk+tFQvni2rBWt4t7AH2KkYUciRkPUXBc+4o4=;
        b=f9A+eMl7EIu4/AUZVRTIHt1/Jclk2w65EZD4M1fVInUFYkMY62B9XCbYLOQ9lelSOq
         WX6/E9XvZjmW9v+So29/74XblXh0K+g9/0bgaA3jGgXqvFZPmi+MZR6QFoUSR0cpuIOH
         YCpEtVljNca9GODUpUNJpxT8LtBZOXCG716+ML1A+1gHLTC/otq8ajFrX9uAaUD1dPBK
         gzlULoVQgRZ1IEHRJ+vihgFeKF4meKGqHI3L1JlDijLbOlo5E3ecMydLHUGbBIYKXzXH
         kbqZq7c/SwJr0HudXd/ooG8Prjs8LX0IXbAXTLZ7K3iKxIh4jpOmx23DM6ZnnHdr6J1a
         FMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7wMnxNk+tFQvni2rBWt4t7AH2KkYUciRkPUXBc+4o4=;
        b=mHZ1U1hLJC6fazOk3wLRyaH2k2Ojn/rmZZSe/xrsTiwOMPYsJVT1KjwZw0X1G/fBDX
         mtp5kagDybgPLF9p9x9cQJgw8pb9QROQhxrNoIlnaaLTZARkaAT18jvW5htNSIjrx6/4
         5K90DNl7G7X9vNWNTAknX3VJc+SeOXvBuvlU9IAwrF1cqJF5ibdlqQqpbKrLk5on4Spp
         RYBD2ThjhspxPygAqnpWGQxMsx9E7lYj9CDb+eOJuD4+68tLEGBIQgUBYVaVUhzIOFA3
         s9oSwEq6BcPxO0PH8wmVua4R9A469FbkyakOi+/0/Fti9f0vjXsXAFZqS/WX1qaZ7BX5
         1MHw==
X-Gm-Message-State: AOAM530hi21qOPI55IeGn1snVJLm8yBzjbYuAxx1vuD0+PkYsTcwTRKM
        eXE0G4Nk2Ra3fPU5bpe9joBr59SyvelVs1RYYovDGw==
X-Google-Smtp-Source: ABdhPJwOqL0/px4nT//CIWu4d9IwswpkLRJw00d9Z2tKOIp2ubo1jTlzaXKnFSAQBUGcr6u2xzSDR/uocFsYUrUSOJw=
X-Received: by 2002:a17:906:c282:b0:6ce:369d:3d5 with SMTP id
 r2-20020a170906c28200b006ce369d03d5mr8781565ejz.425.1648166924426; Thu, 24
 Mar 2022 17:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220316024432.1454366-1-dlatypov@google.com> <CABVgOSkvmuiHfG11VRsQhigOLw_-5HYWjJrQrA4Vy18MvUpW9w@mail.gmail.com>
 <CAGS_qxpCoyr0_xpRVpjMwAALn49iShGAs-MuBrYHwrEJhKcZUA@mail.gmail.com> <CAFd5g46N6kbcknJxAug3nkEqe5Q+UuqYAfh8AhPkfPzeQFX8PA@mail.gmail.com>
In-Reply-To: <CAFd5g46N6kbcknJxAug3nkEqe5Q+UuqYAfh8AhPkfPzeQFX8PA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 24 Mar 2022 19:08:33 -0500
Message-ID: <CAGS_qxrHQvYfe0qimYxrqmbszWASwHVokDTS3+4X6Ehqpa1Nhg@mail.gmail.com>
Subject: Re: [PATCH] kunit: split resource API from test.h into new resource.h
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
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

On Wed, Mar 23, 2022 at 6:51 PM Brendan Higgins
<brendanhiggins@google.com> wrote:

<snip>

>
> Another alternative workaround is to split even more stuff out into
> other header files.
>
> Personally I would prefer not to wrap the lock/unlock functions; I
> like seeing the kind of locking that's happening. Plus, such a helper
> would be pretty gross:
>
> void kunit_lock(struct kunit *test, unsigned long* flags) {...}

That's exactly why I didn't bother to try and wrap it, yeah.

>
> It wouldn't actually clean up the call site, just facilitate breaking
> out code into a header.
>
> > > making users include this separately is probably the right thing to
> > > do, as nesting the headers like this is a bit ugly, but I won't lose
> > > sleep over leaving it till later.
> >
> > Ack, I can add a TODO to indicate we want to clean this up?
>
> I am fine with this.

To clarify, are you saying you're fine w/ the nested header as-is, or
fine with it + a TODO?

>
> > It's a bit annoying right now, but it'll only get more annoying in the future.
> >
> > >
> > > >
> > > > Now the first big comment in test.h is about kunit_case, which is a lot
> > > > more relevant to what a new user wants to know.
> > > >
> > > > A side effect of this is git blame won't properly track history by
> > > > default, users need to run
> > > > $ git blame -L ,1 -C17 include/kunit/resource.h
> > >
> > > This is a pain, but is probably worth it. Thanks for including the
> > > command in the commit message, which should mitigate it slightly.
> > >
> > > >
> > > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > > ---
> > >
> > > This was starting to annoy me, too, as it was a pain to read through
> > > everything in test.h. It'll be a bit of short-term pain,
> > > merge-conflict wise if we have other changes to the resource system
> > > (which I fear is likely), but is worth it.
> > >
> > > Reviewed-by: David Gow <davidgow@google.com>
> > >
> > > -- David
> > >
> > > >
> > > > NOTE: this file doesn't split out code from test.c to a new resource.c
> > > > file.
> > > > I'm primarily concerned with users trying to read the headers, so I
> > > > didn't think messing up git blame (w/ default settings) was worth it.
> > > > But I can make that change if it feels appropriate (it might also be
> > > > messier).
> > >
> > > Personally, I think it's probably worth splitting this out as well.
> > > And the sooner we do it, the less history we'll obscure. :-)
> >
> > Yeah, that was my thought.
> > But if you think this would help users, then I think we have a case to
> > make this change.
> >
> > Should I send a v2 with resource.c split out?
> > Brendan (and any others who have an opinion), what's your preference?
>
> I personally don't think test.c is so huge that it is a problem to
> understand, but I can see it getting there.
>
> If it's going to happen, sooner is probably better.

Ack.
I can work on adding a second patch on to this series that splits out
resource.c?

That causes more churn for the other in-flight patches, but we already
have some since David has some changes in test.h.
