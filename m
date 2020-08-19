Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B642924A8D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Aug 2020 00:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHSWBI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 18:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSWBF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 18:01:05 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19602C061757
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 15:01:05 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id q3so26247ybp.7
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxWg5ULSKL9S4BttK+iZ+9EMWLe/O2QTXo5l/Uqxehk=;
        b=x7F+24zu38tBbxtOe/jdUbHhp9TEGmI/7aREqPGIoV4oOfy6kmqOlnU49TCNpu2Fx4
         DeVfhLmhy6eAAeAPNJH6nQtEo0KsIahLC4b+07g2GTK7nQ7z3+yJxtcSTr8Ap0JceiIB
         E2i1DEd9orfQKhCsv5NGFweNhdns/c+tL6myj1E6HduF0yHiAM3bzsNMEmu8ros5/RBl
         2ZbpZeEc7nr2dfWOhYytsnrD8BKchKQuOr6ed2AEq3fDQ3AuifK2zS23NE6heJyBr2S2
         BIWrnNbFy1gjSmfw2D5A974kHVuzaim/SIuDuFHaysacffNAmX4KuA6YlVe0QGTzMQ6E
         o1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxWg5ULSKL9S4BttK+iZ+9EMWLe/O2QTXo5l/Uqxehk=;
        b=kHk7Yt2M9HsUYlBgZCyklodSp79VE789HusJOkZzs4jp35Y/uP5qehz/W0eSm+N/1d
         h53/9JoObbYFs4qTbIyFZ8cgqD0M4f7W4QBB9X/r5J0pMyjLENBucx6ywCRb+6InNFZG
         OqRV4GGFFzxj2nkzz588DRzo6WHZ55xga/n00pOBkYTBkjFpi2p6Nt+v3nh+LZXnSowu
         DbjH3VaC0Y9CPqASoPhIUaQ9fJnqMBm9JcNhcgfaFDP4qLWsrQvf6q0MFfpIuVKDdwkP
         rIdxMyX2T4MeHWfTpPy+vWGA7wlt1vYvyU+lC6AfnAtG64UKtRQ7yFx7uQ25X1J7EubG
         O2aQ==
X-Gm-Message-State: AOAM530puo7/7G8fOaAd6OPiOhhGUtTRUeBsrhWVYYW9UweLmRlHe8TC
        1I+fLoHf/aWwGt5iq7S7XDEpMzeerWbYX7Uk72Rf5Q==
X-Google-Smtp-Source: ABdhPJzSDcxR/TlY7YF5knK+Fb6IYeSa6yn2DQN/6UBNBmMvGRAXVv5KtpYSdaBwLsbHXemgymi3EmTb5TK1JeUq2mA=
X-Received: by 2002:a5b:a87:: with SMTP id h7mr622296ybq.333.1597874462852;
 Wed, 19 Aug 2020 15:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200819194634.68976-1-vitor@massaru.org> <CAFd5g45AuxZYY_92rOXwtVjmbaGuts+DV6WpqhHNxWYNotxq+g@mail.gmail.com>
 <CADQ6JjU_ppjnPU6=_eOiwjQe-FKn1Rpf-p+WDEA57rXGF80PEQ@mail.gmail.com>
In-Reply-To: <CADQ6JjU_ppjnPU6=_eOiwjQe-FKn1Rpf-p+WDEA57rXGF80PEQ@mail.gmail.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 19 Aug 2020 19:00:26 -0300
Message-ID: <CADQ6JjVx1q+BOnbb-PQ_hYcVmx63bF4zUZSxPkJoOEMNwSyY7w@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix: kunit_binary_assert_format() only prints
 signed int
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Brendan,

Actually https://patchwork.kernel.org/patch/11724995/
solves my problem with unsigned int, since I can customize
the Expected message with this patch.

I think you can ignore this patch :)





On Wed, Aug 19, 2020 at 6:37 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> On Wed, Aug 19, 2020 at 6:30 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Wed, Aug 19, 2020 at 12:46 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
> > >
> > > Some tests, such as overflow_kunit(), uses unsigned int,
> > > But kunit_binary_assert_format() only prints signed int,
> > > this commit also deals with the unsigned int print.
>
> Oops, Thanks!
> I'll fix it.
>
> > >
> > > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > > ---
> > >  lib/kunit/assert.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> > > index 202f9fdeed0e..3ae90c09986a 100644
> > > --- a/lib/kunit/assert.c
> > > +++ b/lib/kunit/assert.c
> > > @@ -104,12 +104,23 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
> > >                                   binary_assert->left_text,
> > >                                   binary_assert->operation,
> > >                                   binary_assert->right_text);
> > > -               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
> > > +
> > > +               if (binary_assert->left_value - 1 < 0) {
> > > +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
> > > +                                 binary_assert->left_text,
> > > +                                 binary_assert->left_value);
> > > +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
> > > +                                 binary_assert->right_text,
> > > +                                 binary_assert->right_value);
> > > +               }
> > > +               else {
> > > +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %llu\n",
> > >                                   binary_assert->left_text,
> > >                                   binary_assert->left_value);
> > > -               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
> > > +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %llu",
> > >                                   binary_assert->right_text,
> > >                                   binary_assert->right_value);
> > > +               }
> >
> > I agree that you found a bug here; however, I disagree that this is
> > the correct fix. Given that the value is stored as a long long; isn't
> > the value always stored as a signed value? So if the value overflows,
> > won't it still not pass the check you have here?
> >
> > >         }
> > >         kunit_assert_print_msg(assert, stream);
> > >  }
> > >
> > > base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
> > > prerequisite-patch-id: bf4b0962b0b955e4e45f5d25fece889562118158
> > > --
> > > 2.26.2
> > >
