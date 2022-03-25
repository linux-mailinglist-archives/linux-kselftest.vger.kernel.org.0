Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4B74E742A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Mar 2022 14:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348764AbiCYN1o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Mar 2022 09:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiCYN1n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Mar 2022 09:27:43 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69931996BC
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 06:26:09 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s8so6428216pfk.12
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 06:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SNiShoUTsbTdEbynQ1uNegfvPshmeYrINm6XNBWcKV0=;
        b=V7XKxRI7Y75sG1Tx6S4YCWy6H0Wv5AueOkEfS2B/Eqd9gF0BPuEYvpuHcjCauDT4ZO
         UUSS6dseK0g67ZsNTKVJWdWXioRuZj1jKHEGdIwEI1GnGft9rAVPhUsbjGGIy/elEhsc
         sGWbflZdRiyG6GwPFvB1c9G9IOTwHLq6Ojvc+m/GF2qt7xBgQTs6B3fH0LhR1uCUEctq
         Qn7JOOtTk2NrqivUWTYr4QNXfhK7QseZeYB4GosBRoBk+1ctjm46LKXE+nnnSLmrw/4W
         02kt+5Ar6N1z2s8LIOsczMsWmYmES0PsHmKVqdMNkSTyG4mp/Y7YhA5sBMjBwMuU7HNl
         zL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SNiShoUTsbTdEbynQ1uNegfvPshmeYrINm6XNBWcKV0=;
        b=X/FdHdKjlfSXHZXk0YCViQ5J2MPlq21NGGgb/xsTWeOfVJ9x0IBnbmXZ2Q6xi6xStc
         p4NEKwTjoTk2UnrVcFRrPfTwzoE3lFdB4Zqr199JPNnBv6kwn68/WxlEE0LKUt/7P6fm
         zPwjaSMNb49+TPzstNfdbzhoZIibYa349av4c/pdAsxjxAwNRfgyuQ9o9cdwgFyYJXab
         vdRsXsQ8D/Tx5ni4+pi9e8UW+FMIJUMecitGugkXM3Mq3hyRyOsUbbmlQd6P7CLL29bp
         kCuIzhztY6mjPDmiYobsc31/D+v1szbTfTgzrBz1Mlk8JCPwOdUx86YggnAGEdvODi92
         rJjA==
X-Gm-Message-State: AOAM532pv8mYDLpWeRquxX1yqg0qKzGEU3NpCxq9DrQlf7y9X8/12/hR
        R/FY+lkGp+KyxheHmfJHim1g+IZgpLYSBZSVYaAnhSzl2Ic=
X-Google-Smtp-Source: ABdhPJzElT5b9dGjMBDmcKlV3SrP9k1NFHrWaTYljoiLF2BZX8ImBBizvuO8IvKzv7i+B/Xgv3s1XY7U+XOwOJT/FS4=
X-Received: by 2002:a63:1b51:0:b0:37f:fc7e:7669 with SMTP id
 b17-20020a631b51000000b0037ffc7e7669mr7994702pgm.244.1648214768945; Fri, 25
 Mar 2022 06:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220310210210.2124637-1-brendanhiggins@google.com>
 <Yirz/hbo4K9zN9Ht@google.com> <CAFmMkTFa9xVt314WEGd0nNx+ovc=aGB_yN1LorP7WrBga9quxw@mail.gmail.com>
 <CAGS_qxqHhGEYS_4C-gTmPt_d3Fm==VOTEzQGggWh6MWppTHtZQ@mail.gmail.com>
In-Reply-To: <CAGS_qxqHhGEYS_4C-gTmPt_d3Fm==VOTEzQGggWh6MWppTHtZQ@mail.gmail.com>
From:   Daniel Gutson <daniel.gutson@eclypsium.com>
Date:   Fri, 25 Mar 2022 10:25:57 -0300
Message-ID: <CAFmMkTEoYXAFuz152SobMqnL3TM3GhQNDtR+_+RrzU=sx-bbRg@mail.gmail.com>
Subject: Re: [RFC v1] kunit: add support for kunit_suites that reference init code
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Richard Hughes <hughsient@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 11, 2022 at 2:56 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, Mar 11, 2022 at 4:14 AM Daniel Gutson
> <daniel.gutson@eclypsium.com> wrote:
> >
> >
> >
> > El vie., 11 mar. 2022 4:02 a. m., David Gow <davidgow@google.com> escri=
bi=C3=B3:
> >>
> >> On Thu, Mar 10, 2022 at 01:02:10PM -0800, Brendan Higgins wrote:
> >> > Add support for a new kind of kunit_suite registration macro called
> >> > kunit_test_init_suite(); this new registration macro allows the
> >> > registration of kunit_suites that reference functions marked __init =
and
> >> > data marked __initdata.
> >> >
> >> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >> > ---
> >> >
> >> > This patch is in response to a KUnit user issue[1] in which the user=
 was
> >> > attempting to test some init functions; although this is a functiona=
l
> >> > solution as long as KUnit tests only run during the init phase, we w=
ill
> >> > need to do more work if we ever allow tests to run after the init ph=
ase
> >> > is over; it is for this reason that this patch adds a new registrati=
on
> >> > macro rather than simply modifying the existing macros.
> >> >
> >> > [1] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVABg=
AJ
> >> >
> >> > ---
> >>
> >> I'm a little concerned that this is just removing the warnings, but do
> >> agree that this is safe enough for the moment. At least the informatio=
n
> >> about which tests need __init is preserved by the use of a different
> >> macro.
> >>
> >> I guess one day we'll need a second list of 'init' tests or something.=
..
> >
> >
> > Hi, could you please detail about this? Why a second list?
> >
>
> I assume this is referring to a future where we want to run tests
> _after_ the init phase.
> In that case, we'd need to be able to separately register tests that
> run during and those that run after.
> (Or we could have one list and just tag each suite as init/post-init.
> If we ever had >2 "phases" where we run tests, this might be the more
> scalable option)
>
> Is it likely we'd have tests run after?
> Not in the near future, I don't think. But it could be asked for.
>
> For context, here's where built-in KUnit tests currently run:
> https://elixir.bootlin.com/linux/v5.17-rc7/source/init/main.c#L1615
> That'd probably become kunit_run_init_tests() and then we'd have
> another kunit_run_post_init_tests() called later, or something.

Hi folks, any update on this? I'm adding Richard Hughes since we
need this for fwupd/LVFS, so he can provide more context.
