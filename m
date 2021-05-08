Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F6E376FE4
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 May 2021 07:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhEHF6H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 May 2021 01:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhEHF6H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 May 2021 01:58:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797EDC061761
        for <linux-kselftest@vger.kernel.org>; Fri,  7 May 2021 22:57:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a4so11277524wrr.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 May 2021 22:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vosraxFkn00s8YK0Ok8yeIjfxvEi7SrAy1o6wfrSSnU=;
        b=nAW/nrD06ohhWs8zI0KsLLNcIpeVty0/9GEIig5WDBi4rrd0p0X3mInaOSV0zXIcrG
         K9dbja5C6Lx3QXIT9oH0H2FMmIAlWyjFEX4qD+d6LCISNAC51p4vuoyTtU8lT0d/Z7h5
         krPTTMy8zml1kdXqnQWQzV3CQvNhg5ibSkr+2fJ0WSAH1Eaeh0sFOyqCFFEUQL1plWKB
         QK/X5ZAm9n1ZFnOJCdbRYT3NgnZsr+0yInot8xT5q0zGvll57nLBPn1Al+SV7F4a29VZ
         m26kM5D86/u74/mQuf1TrZMz2QWP4iogT/vcD78s4HelLZ1a8q58hZQwXWSb5BjJoXAD
         1oUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vosraxFkn00s8YK0Ok8yeIjfxvEi7SrAy1o6wfrSSnU=;
        b=am+2Ykbr2+nKQ0k5/pxeCKn829BvghsbDJEgZIMhTVWCNn0B/8cT99u3BS5Ppx63qY
         ADo26tym+M9vdvecO0AycfDY5Nm4/xTtrM4bNj5lawy30mnsa+xASuAaZRa+XH78jLWV
         461Gbxw2BKxV7Z9tUgcHPNNnML2egVn75oiHB00hxQc+CylaZmbY2+ENA8fU2xVppaJk
         BrkIeOnAlCulxIOwMDXqqJmy4mO6RClscKabaKfLYy6KJ4Wm0BfCSUR8b7pk05MZ4tgE
         hzReSV91EoGvLdkoOD5tRkr9dr9m/fTlqpfbinVgR0NLgHWrHSVMbTLpJFQwRbsStAvq
         eyEw==
X-Gm-Message-State: AOAM530MDbi28nTyK3G+6OaGSd1V8h0e+u+z1O7ThEdS9K2EwXOf/pon
        gfZ8/BGOFiE2s56XeqDg4LXGbyr3TLwA0f3aOphDNg==
X-Google-Smtp-Source: ABdhPJw1sm3eSZALh4c0ZqcmKFgKLX+1a6hLOFAC/EixbZFOyNLgbw899NRDtJ8wjjcMUmHxbz85UOQihwvU+6yRd00=
X-Received: by 2002:a5d:500d:: with SMTP id e13mr17131455wrt.39.1620453423849;
 Fri, 07 May 2021 22:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210507050908.1008686-1-davidgow@google.com> <CAFd5g44bot7S-Ya7s7QxnKfXHcy8WxUcNPsZuw_qWMaAQbqLCg@mail.gmail.com>
In-Reply-To: <CAFd5g44bot7S-Ya7s7QxnKfXHcy8WxUcNPsZuw_qWMaAQbqLCg@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 8 May 2021 13:56:52 +0800
Message-ID: <CABVgOSn6pUE1XaeG_==VdaNQ3BopEtFdtw1jPDfKFK9iPeXk5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: Do not typecheck binary assertions
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 8, 2021 at 4:05 AM 'Brendan Higgins' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Thu, May 6, 2021 at 10:09 PM David Gow <davidgow@google.com> wrote:
> >
> > The use of typecheck() in KUNIT_EXPECT_EQ() and friends is causing more
> > problems than I think it's worth. Things like enums need to have their
> > values explicitly cast, and literals all need to be very precisely typed
> > for the code to compile.
>
> nit: I have not had the typecheck() call prevent any code from
> compiling, just generating warnings. I guess you can have a build set
> to cause any warning to be promoted to an error; still, I think this
> statement is misleading.
>

Whoops -- it was the issue in patch 2 that was causing the error. This
is indeed just a warning.

I'll send out a second version with a more accurate description next
week, assuming no further issues appear.

> > While typechecking does have its uses, the additional overhead of having
> > lots of needless casts -- combined with the awkward error messages which
> > don't mention which types are involved -- makes tests less readable and
> > more difficult to write.
> >
> > By removing the typecheck() call, the two arguments still need to be of
> > compatible types, but don't need to be of exactly the same time, which
> > seems a less confusing and more useful compromise.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Looks good to me.
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> > ---
> >
> > I appreciate that this is probably a bit controversial (and, indeed, I
> > was a bit hesitant about sending it out myself), but after sitting on it
> > for a few days, I still think this is probably an improvement overall.
> >
> > The second patch does fix what I think is an actual bug, though, so even
> > if this isn't determined to be a good idea, it (or some equivalent)
> > should probably go through.
>
> I don't remember being a huge fan of the typecheck when it was asked
> for either. I think I am a little bit more indifferent than you;
> nevertheless, I support this change.
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/CAFd5g44bot7S-Ya7s7QxnKfXHcy8WxUcNPsZuw_qWMaAQbqLCg%40mail.gmail.com.
