Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D412423255
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 22:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhJEUuS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 16:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhJEUuS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 16:50:18 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C2DC061749
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Oct 2021 13:48:27 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q205so453569iod.8
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Oct 2021 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JAounyxlXF7n2WVwFJo6n+C9+UfzRHnpBIfBKV5LNQ=;
        b=GJu7JAovro16Z37tagMQT4k19hLAf9ALlk4rf370ABKVo/d1DlVQsvzTliIRa/HUO9
         xqz3AOmca6ryT6L9IevxPcnJCononpXMEDOxrlJ297J7J1MHiCQJOdKFpCKQDiTRqGWg
         0E6RFK7cEtDdu2Z7Deju22n2oaTDSSU1MgA2oTWN6kcVa5+fTKeBkno0GnVPocOJS9qf
         fgM3kOhhcAT22Zi6zylifn6MYk/ufCEzlJJsJpONdWCuPAFImkt8Hfo+7Fyv0MYD+/OC
         T9YWQfNQsxrtSWp/+Dpt2uQA1ehuFT1J39buPJJPvilKxFsICOWo7n5NQ6IWPB1OQAEY
         Akvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JAounyxlXF7n2WVwFJo6n+C9+UfzRHnpBIfBKV5LNQ=;
        b=dBI9qLsg7FpFatgxxD7a6rAe9xQI76JxG5U57O4U9KjIGm4dnXKQcEYjT7NZ33aSro
         2RAJ9ALLYNykfHjdP60MXpLlrZDEn73eFpO/Wc/ZdZMdoGv8W3JOBc89jlLn3zgWpSyq
         Ir7rgOdUQX4FB0am3/QdS9mp4F8v6ZAb6APrgDxt1+5icQX/CI8z99y4mYFzE83TAC/w
         fG4c+oLzsH+kF6JJUYLmsCo73M5JkQr05ggaserWAx6TONXQwF5K1v8l87PmBfQch+n9
         V6jngfMHxHM1OdeWzEYld9L38JJe071zrxOnakVlb54SHeUdQDkWDjuibyF0forLuuM1
         Muiw==
X-Gm-Message-State: AOAM532Q5Vf3kS4YUSSUG5k/VQd/xpz0QQxlb2F3WmWzg7aVoY2am25a
        TFPPe4tLt5/7qheZVo+04BunkkrZO1Nz1jHJKyNd5KyZ9ZGRFg==
X-Google-Smtp-Source: ABdhPJwCJj5+yH7sLM+lpGrG9xVHf2JmvfdPa43mLgOen5lmNeZgLXbdjZ6QUDpA3X1+uEkmVCVN3XQEtCuigHeNbe4=
X-Received: by 2002:a6b:f805:: with SMTP id o5mr3783415ioh.131.1633466906627;
 Tue, 05 Oct 2021 13:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211005053019.26284-1-rdunlap@infradead.org> <CAGS_qxqRQ+1DmKQwyw-=Yud5LTeZ9LzPQfh-ooOrFuQFN1V3Dg@mail.gmail.com>
 <70b0b0c4-47d0-7bb3-3bdd-688a91074bfb@infradead.org>
In-Reply-To: <70b0b0c4-47d0-7bb3-3bdd-688a91074bfb@infradead.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 5 Oct 2021 13:48:15 -0700
Message-ID: <CAGS_qxoK_TMa_34BZR9QnVXjGYpG4i7MA+4N11GgybyJTC_9Tg@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix kernel-doc warnings in doc. build
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 5, 2021 at 11:54 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/5/21 9:21 AM, Daniel Latypov wrote:
> > On Mon, Oct 4, 2021 at 10:30 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> Fix documentation build warnings in <kunit/test.h>:
> >>
> >> ../include/kunit/test.h:616: warning: Function parameter or member 'flags' not described in 'kunit_kmalloc_array'
> >> ../include/kunit/test.h:616: warning: Excess function parameter 'gfp' description in 'kunit_kmalloc_array'
> >> ../include/kunit/test.h:661: warning: Function parameter or member 'flags' not described in 'kunit_kcalloc'
> >> ../include/kunit/test.h:661: warning: Excess function parameter 'gfp' description in 'kunit_kcalloc'
> >>
> >> Fixes: 0a756853586c ("kunit: test: add test resource management API")
> >> Fixes: 7122debb4367 ("kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Brendan Higgins <brendanhiggins@google.com>
> >> Cc: linux-kselftest@vger.kernel.org
> >> Cc: kunit-dev@googlegroups.com
> >> Cc: Daniel Latypov <dlatypov@google.com>
> >> Cc: Shuah Khan <skhan@linuxfoundation.org>
> >> ---
> >>   include/kunit/test.h |    4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> --- lnx-515-rc4.orig/include/kunit/test.h
> >> +++ lnx-515-rc4/include/kunit/test.h
> >> @@ -607,7 +607,7 @@ void kunit_remove_resource(struct kunit
> >>    * @test: The test context object.
> >>    * @n: number of elements.
> >>    * @size: The size in bytes of the desired memory.
> >> - * @gfp: flags passed to underlying kmalloc().
> >> + * @flags: gfp flags passed to underlying kmalloc().
> >
> > Thanks for catching this.
> > But can we instead rename the parameters?
> > I can send out a patch for that if you'd prefer.
> >
> > The other funcs here use `gfp_t gfp`, which is why this copy-pasted
> > comment does too.
> > In test.c, kmalloc_array() actually calls the parameter `gfp` as well.
> >
>
> Sure, go ahead with it, please.

https://lore.kernel.org/linux-kselftest/20211005204632.3132652-1-dlatypov@google.com

Ran `make htmldocs` and I don't see any references to kunit in the
stdout or stderr, so I assume we're good now.

>
> --
> ~Randy
