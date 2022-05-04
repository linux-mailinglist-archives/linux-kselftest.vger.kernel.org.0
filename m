Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03B851ADC0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 21:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356267AbiEDTaK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 15:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357259AbiEDTaH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 15:30:07 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE7A4A90C;
        Wed,  4 May 2022 12:26:30 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h11so1504054ila.5;
        Wed, 04 May 2022 12:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faKNM+qwcArkJmPdQKZUatJOcPW6asWisYRgltgA+bM=;
        b=VrLn4DXjigrD/Rraqf7CcvlUwmR7BblTWy83YVocIBLYRtnQrXbss03vXrg9mQL2JW
         JheLYxPbVecLLCpGdrFWJ32cImulwZiUJy/UhNWxROYuDL2Th2jbPXLSVX3EZapQ846X
         1yoFSHf/bA+P9hUV6to0Q30YZUdUDaLV/iyc7O9JEj3F2xOnh1b1zyV1gQFTAorEuUvj
         lYS/Y3xdAQh7TtWahQLT5kNe/ISqAEUt5EqSCtmU4MG3cGa5oLweRn5ihIBVeUWcUy5V
         TVpjBmLGHnx9vXtXGATV6pgXuOfCRGsOJdpYUGEhZ3PoJDO4P4qHU2/80bxp+heODJKA
         0hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faKNM+qwcArkJmPdQKZUatJOcPW6asWisYRgltgA+bM=;
        b=T+CjMSgOsCsvykI4hwQMblazD+ZMcWlXazaOp/Qebnze3LbyeY7Lz0122qgpsXSP0B
         B/LFjYFoC/g88OT/b1A8JIXwaH9BsS3oQN89hh/2CTQoHhmsQF3BFqc1GuHfL6C3HScO
         SUlTNT704nqU1oAI5QbscY1yVSEHB+pibes9ueS92Ba8nZZHpIO3sOLhntbnvzLqzC/p
         SmqLixgD2PTmakG4hdMKZ7st+SonwClmXkcdZcFY1h+ejaz7KDURy6nCFJiTL9U9OXEi
         GmKWSZ5iJNIZtSiDQP6LgSnb/E/Jx6/ygJXErWMjiKdgv6S5enknUa9gqJBBq6LIEXVy
         KsVg==
X-Gm-Message-State: AOAM533zgZG1KsrnC/dp303VGx3aqwjBDEhXLjB+8/6DseNaVYWw0F6+
        TozY2uL2nO4IN8wz6GfaftSSOIPIPk6Rdj1EXeADrnli
X-Google-Smtp-Source: ABdhPJxcGyP+rY6OJv8/guQBy29cEHbepRX/c2vT1PL3ijrS75hLlWsBEBXK+gtOF0Y7BZqR/JBiiuSjyM8cN6sKhhU=
X-Received: by 2002:a92:7309:0:b0:2ca:8c9c:752d with SMTP id
 o9-20020a927309000000b002ca8c9c752dmr9144096ilc.151.1651692390336; Wed, 04
 May 2022 12:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220502093625.GA23225@kernel.org> <CAGS_qxoc=AnkzUtaFpJvF08Z_Z15h9sZxYNQT5-S9C7aM4poEg@mail.gmail.com>
 <CANiq72m70q+zviHVNSV_AEwOByVBiMuSQL5vyo2UMMpD-vd+_Q@mail.gmail.com> <CABVgOSmkZ9EXijBRx_pvS=Opizb1z2632B5rVsd1WRNOL5o8GA@mail.gmail.com>
In-Reply-To: <CABVgOSmkZ9EXijBRx_pvS=Opizb1z2632B5rVsd1WRNOL5o8GA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 4 May 2022 21:26:19 +0200
Message-ID: <CANiq72kVLzOu_3UjoUiSp5y+H0tA+SQYNQ=fsuhtg=i6MQe=Fg@mail.gmail.com>
Subject: Re: [PATCH] kunit: take `kunit_assert` as `const`
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On Wed, May 4, 2022 at 4:05 PM David Gow <davidgow@google.com> wrote:
>
> I definitely agree here -- I can't recall any particular plan that
> would require this to be non-const, and we can always change it back
> if we really need to.

That is good to know, thanks! Out-of-tree users can always be a surprise... :)

> Very exciting! I assume that's the PR here:
> https://github.com/Rust-for-Linux/linux/pull/757

Indeed! I hope you like it -- we are taking the documentation tests in
Rust (which are a very lightweight way of writing examples which
double as tests) and generating KUnit test cases on the fly. For the
moment it is just for the `kernel` crate, but the idea is to
generalize it for modules etc.

By the way, since you saw the PR... do you know if KUnit relies (or
will rely) on "stack-dumping" functions like `longjmp`?

Cheers,
Miguel
