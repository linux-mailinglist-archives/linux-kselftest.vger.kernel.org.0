Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B90519949
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 10:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346037AbiEDINX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 04:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346022AbiEDINV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 04:13:21 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679982250D;
        Wed,  4 May 2022 01:09:46 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h85so713628iof.12;
        Wed, 04 May 2022 01:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lu0+Qy04jOfWQIM0Gy8rraQtjHpXPEO19LjLG52mw9o=;
        b=USH7ZZ1LQxTWexyjMl5Br1eNEI8WY2FaP7ZmbZvKUCSYIzweA/CqteP5DPe//EJjN5
         5Dr+jMlNHozgcGkiYnujYJ4cwtaL0BYYBiAyWJjFHJqE+bk1esuyjR4IEbzz/rSmmPCj
         OEbjnV18sHMNz4e8fYSmBedf1THpyFIRLbgKpY70Pkl1BzyH7yvYfbxMNep1XMEt1V1x
         ahxI+FblPLUydAYyUVYDB6rGf3aYgAhQot0cJNDqNprViM+9uLdD1IJVAPa/1tFSyQwr
         4ykPkTT+a9Wj8LLIOvviFYk+pCNn8fh2TYo2zduaLt5d8pjvIhYrXJ19PIeNGzpDkXZo
         bbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lu0+Qy04jOfWQIM0Gy8rraQtjHpXPEO19LjLG52mw9o=;
        b=Oz40c/M6+E4DUfBy0P9o5+eSp/TCVcJz538R8MBH296iPElrZY/SC9FO7vava6SLUR
         FdqdafpWNupiJsBuIQ+d1oN7OFOatYsuFfQmOnOQ3mUXVPZlFPStI1uB4yKUB2rAIaoU
         GBRvm+jSOAsA6RIMSOEVrqrDAROq2B3Kf9pVyx9VgOEKLUIcXrkFX0AV+BjU/uF9sCtp
         KG4c/lZoI0cin2L+rkmY+GcdmuXiz5YUwJi78320x0AQpqhL/M1ryxTRXBBzTd8cXyjo
         6H81yrfWzAiipEOBxxILWE0d+A8qeTueSO8YNuwClbl1QFnPYO2fWOpT0h4cv5mKhG1X
         ZwmQ==
X-Gm-Message-State: AOAM532BEmEz1wTwhL7kN7KTnlVx8/kVW+f3UoZc0osUjLvjDDrDym4e
        SpVja5OT+SpQ6gQMukGtMDg209Xx0k21tXQC9CrFkHZ3T08=
X-Google-Smtp-Source: ABdhPJzlbXuZcZ7lFZxvsNXNPvutssuzEIO//oGx7vMAwvE2mWagneIY//QqfdB3Ib+6SyZN37tutH53ntzIL2i6qDw=
X-Received: by 2002:a02:c6af:0:b0:32a:f5f6:34bc with SMTP id
 o15-20020a02c6af000000b0032af5f634bcmr8955794jan.186.1651651785880; Wed, 04
 May 2022 01:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220502093625.GA23225@kernel.org> <CAGS_qxoc=AnkzUtaFpJvF08Z_Z15h9sZxYNQT5-S9C7aM4poEg@mail.gmail.com>
In-Reply-To: <CAGS_qxoc=AnkzUtaFpJvF08Z_Z15h9sZxYNQT5-S9C7aM4poEg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 4 May 2022 10:09:34 +0200
Message-ID: <CANiq72m70q+zviHVNSV_AEwOByVBiMuSQL5vyo2UMMpD-vd+_Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: take `kunit_assert` as `const`
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
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

Hi Daniel,

On Mon, May 2, 2022 at 9:44 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>
> Thanks for this, the code definitely should have been this way from the start.
>
> I had wanted to make this change but mistakenly thought the format
> func took it via non-const for some reason.
> I must have misread it once and got it into my head that we were
> leaving the door open for mutable child structs (which sounds like a
> bad idea).

Thanks for reviewing it so quickly! Yeah, I was unsure too if there
was an external reason such as some future plan to use the mutability
as you mention or maybe some out-of-tree user was relying on it
already.

But I thought it would be best to make it stricter until it is
actually needed (if ever); or if there is an actual user for
mutability, it should be documented/noted in-tree.

It also simplifies a tiny bit a Rust-side call to
`kunit_do_failed_assertion` that I am using within generated Rust
documentation tests.

Cheers,
Miguel
