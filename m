Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C9E51A1C1
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 16:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351188AbiEDOJs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 10:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351103AbiEDOIq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 10:08:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E7728998
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 07:05:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k126so933654wme.2
        for <linux-kselftest@vger.kernel.org>; Wed, 04 May 2022 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7s8Dkq+WYTUvt1eMI+UndBL7YVh+xKQ8rqnLmZXLwkY=;
        b=OyGdp78bqxqrVMr3zdt1uaD/Ac3z6RgQidnw+5ULB1bz2kwC5QjwLR4rSRoFkSTM47
         50juL7UMKQsOV4WPjGDT5GGOLdyvS2YnnaPx0yPDhjoadetCqTUGgcPxI5D6ZMYGOND4
         0XNkHMMApj3HLIC+7ebffNsggdfjA7Sg/nbTNuWO2U7IqLyjyTzOeYFwmYI81uRe7pes
         ybW/4+E5QLmlj8OZtVek7tuz2VOVX9dGqBmHibaKp/vlmzT/ngytIkDTPO1HzjlEOfjr
         Us3SRmbZxBjfofrJnBdGg0tIMBs9TOUD4pH7i+0qcuTyfcP1u613zaJAjN4gEjI56Ti4
         /kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7s8Dkq+WYTUvt1eMI+UndBL7YVh+xKQ8rqnLmZXLwkY=;
        b=5/H9ewSABGj1/5mOeHzmobIXfsvqucVVH5ITKk5yk/rlWLrae87zjqrK/W/ufcG3pP
         2jmRJph1eXpM7rDgj0JH7dxLh14YZfJ4LmcSIMGX9nXg77gZ2tMaXGzWgI1rAY7oyaWy
         wT+M5BF912ki2loRuG4CMGd5yVDwb7PiDDtqZQz300ZxJXXViBkAsy6qm5bEpLmzQXGd
         TReR46QUuxnQfFiPDBcx0ZXpIfoT2gMJL/b0CLq2EKBQcI5YBCi6/kCZL1j7NvTjpl2q
         0+2KYegXiiafuvui/6YkBvyzYkqIKvgoNcN0HbsMAP2pdvznJQkR6AGaVQesNTsySLed
         bbPQ==
X-Gm-Message-State: AOAM533J3UilLQbTCFwHTmWLi0/RPAPPlKcM5hmGivkTgRAw8qTdjYpZ
        Wqap1Xjr883F+4CTaEuDWLrFslCU+sX3XoshgmxPlg==
X-Google-Smtp-Source: ABdhPJwesySbY7sxWm7bS8V76ogaDlP3y1cXaV9nKVEpoS86jfm3nssObDn4imqrfpLorf5VEV2g7f46iPEMnjnXzBY=
X-Received: by 2002:a05:600c:264e:b0:394:2c56:eeb5 with SMTP id
 14-20020a05600c264e00b003942c56eeb5mr8098997wmy.6.1651673108864; Wed, 04 May
 2022 07:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220502093625.GA23225@kernel.org> <CAGS_qxoc=AnkzUtaFpJvF08Z_Z15h9sZxYNQT5-S9C7aM4poEg@mail.gmail.com>
 <CANiq72m70q+zviHVNSV_AEwOByVBiMuSQL5vyo2UMMpD-vd+_Q@mail.gmail.com>
In-Reply-To: <CANiq72m70q+zviHVNSV_AEwOByVBiMuSQL5vyo2UMMpD-vd+_Q@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 4 May 2022 22:04:57 +0800
Message-ID: <CABVgOSmkZ9EXijBRx_pvS=Opizb1z2632B5rVsd1WRNOL5o8GA@mail.gmail.com>
Subject: Re: [PATCH] kunit: take `kunit_assert` as `const`
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, May 4, 2022 at 4:09 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Daniel,
>
> On Mon, May 2, 2022 at 9:44 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Reviewed-by: Daniel Latypov <dlatypov@google.com>
> >
> > Thanks for this, the code definitely should have been this way from the start.
> >
> > I had wanted to make this change but mistakenly thought the format
> > func took it via non-const for some reason.
> > I must have misread it once and got it into my head that we were
> > leaving the door open for mutable child structs (which sounds like a
> > bad idea).
>
> Thanks for reviewing it so quickly! Yeah, I was unsure too if there
> was an external reason such as some future plan to use the mutability
> as you mention or maybe some out-of-tree user was relying on it
> already.
>
> But I thought it would be best to make it stricter until it is
> actually needed (if ever); or if there is an actual user for
> mutability, it should be documented/noted in-tree.

I definitely agree here -- I can't recall any particular plan that
would require this to be non-const, and we can always change it back
if we really need to.

> It also simplifies a tiny bit a Rust-side call to
> `kunit_do_failed_assertion` that I am using within generated Rust
> documentation tests.

Very exciting! I assume that's the PR here:
https://github.com/Rust-for-Linux/linux/pull/757

Cheers,
-- David
