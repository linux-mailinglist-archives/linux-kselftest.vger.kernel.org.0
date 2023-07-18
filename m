Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6EE757991
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGRKux (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 06:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjGRKuw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 06:50:52 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76023E69;
        Tue, 18 Jul 2023 03:50:51 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-579efc32377so51128097b3.1;
        Tue, 18 Jul 2023 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689677450; x=1692269450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1QDt0Sf7l7pQV8orH0tWzg0eiS7P4OmFAqlO08Oj7A=;
        b=OwEuP7K0L6BBLEOoRWNgc13+QZSqASstXZdoqrCVLhfxwQx+f8AtBu0wLOadrkZwWF
         dSbXadM46AKh+Jkifu77ufI5Ul+C6u0Db1lGML54C4Pow0W0QSX/upPygTmQhJXMolRH
         7bp9XlsKFhbpUPK5TgMaFIcx3tdBF8j0YyYxHnpCHAAxI2KQjZNCQreecd2OFYzJuR3T
         KyDdKON0f0Dn8v4vCo47CXbYE8h2MmWcprU8kBn1Y7Ivd3zGOfXNIOif2eMeG5gkU9dj
         fdHxozKZFkl+0huY8jaG5V4pSJ7iO3C/gttf0ydiApMaLiWb1LO41KfA7sC846XgDfpZ
         opLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689677450; x=1692269450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1QDt0Sf7l7pQV8orH0tWzg0eiS7P4OmFAqlO08Oj7A=;
        b=eLeFiLrG+XyOvB9iXZWP5gFr7hbbqCDhr0cA547RAaWdsHICCk8JMqOTJHQqAG9aeb
         EaszY7GHb/MtMJWsx6x+xnBB2K1xu8o0QoWtBfIwLwkxBYaxun6QTqMICYD6E39bqyBb
         EgTUa+5BAZOiNfX/bLCsdN23lmmB1xzsxktEBhDfW1DCchoNwBctp/k46hZ/dXqW2Qq7
         hxNqIIOvptuCrQT4xoJgJogeihLh6ZwR/AJ0YtMhzzhPENo3N6FAappsTbsdEuK/7mi0
         xtlfhFVTTsISjZwyw9PnSfhY6Am1mNIy2bVz6C5FVDlWLwiIM5+XK4V99f+zAZZO1Prb
         G/sQ==
X-Gm-Message-State: ABy/qLYkLHd6FKJ7knozMo7ULN6He+wObV7yI17tb5o1bH2/pAYcX2i8
        pDomZrcVmyk+K1W3K5VmbFcQPBgDjVr2SaCGSv4=
X-Google-Smtp-Source: APBJJlEEHZSBU905UJoBlQ0tbX9EIC+PNtKEcVq973I/wi35dpixqOtiOfiXL+/VGe6/40ITgyhg8C5o3fny82zoAC4=
X-Received: by 2002:a0d:ce07:0:b0:577:cd0:681f with SMTP id
 q7-20020a0dce07000000b005770cd0681fmr12915048ywd.26.1689677450701; Tue, 18
 Jul 2023 03:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230718052752.1045248-1-ojeda@kernel.org> <CABVgOSk+YOdmpnBpLcx2sC3NN7amdpLf-C35EpvYmzq3SWHAqA@mail.gmail.com>
In-Reply-To: <CABVgOSk+YOdmpnBpLcx2sC3NN7amdpLf-C35EpvYmzq3SWHAqA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 18 Jul 2023 12:50:39 +0200
Message-ID: <CANiq72=7X7nooVnoS6JxXBwwFGGGJU5eNVNUu=g33-YQjR9vnQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] KUnit integration for Rust doctests
To:     David Gow <davidgow@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 18, 2023 at 10:38=E2=80=AFAM David Gow <davidgow@google.com> wr=
ote:
>
> I like "location" better, personally. The attributes work is still
> ongoing, and while there's some benefit to having "file" and "line"
> separate (it could potentially simplify some implementation on the C
> side), we'll cross that bridge when we come to it.

Yeah, I felt it looked a bit better, but if later on it ends up making
things too hard, then yeah, we can definitely simplify it.

> This seems to be working well on the existing cases under kunit.py
> here. I'll continue to play with it, but no worries on my end thus
> far.

Thanks for trying it out!

> Thanks: while we're still arguing a bit about exactly what the format
> of these will look like in the KUnit/KTAP attributes spec/patches,
> what you've used matches what we've been proposing so far.
>
> Let's stick with <test name>.location for now, and change it if needed
> when the attributes spec is finalised.

Sounds good.

> These are all (still) looking pretty good to me. If there are no
> objections, I'd like to take these into kselftest/kunit as-is and if
> we need to change anything (e.g. for consistency with attributes when
> they land), do that as a follow-up.
>
> Thanks again, Miguel, for all the work getting this going!

My pleasure -- and thanks for reviewing it so quickly and all your feedback=
!

Cheers,
Miguel
