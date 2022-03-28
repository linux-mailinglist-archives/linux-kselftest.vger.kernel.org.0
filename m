Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3417A4E9D05
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 19:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244198AbiC1RG4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 13:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbiC1RGz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 13:06:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AD160CFE
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 10:05:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id j15so29985089eje.9
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=njbwY8ik3fUgv8jSTsQUgVzLcyId30Q3o3B5sKqRTl0=;
        b=AA+hqSjvQkRoJ8cZUyqGfd/7yTL9Ik2iGE1JOIkTTZYzr3XuCg/zVabwzZW507ba8T
         S/eph8qRKtHs/I1PLGIZJpvcqbGpniKRZmSnwuaYJkRJfWjN86SjnJQ9zkPo750ROQts
         4uGZzGt6K3N2PzFrCKrDekKLegSEuYxLyrzp166xLQAmLWXvmEC701TcqiJHwNi5IFau
         FPmaKWBW1ZtvWtNVaUmAn/xSQ7sNHEV5MSnF9IFMRFMX+tqc8ig4hkvtKTYqSujUZCHW
         n8A95uLPO33HJA8DK7syVmcBkyNOutnDh0L3/g7aeb1WBPuvNbEzVbAlG4wKCOtPOGkt
         OY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=njbwY8ik3fUgv8jSTsQUgVzLcyId30Q3o3B5sKqRTl0=;
        b=8MzJ44cShgwiELZFGgM/CsUKkuxHVTaIFlj+JteozA973Aq5KA27rmLZjmKEMd5iT4
         UKt/Blu+l2xyY3svKAEAJufTZ3tOp7OuDa2SMMEwwehCS5+4yXEW2jie4hGDkT/ntmhN
         i8P8DqI3wwBWrUyXpK1Sq50hNp/7zYBQZuCuNKgimr4yd/8H0Oi+QuTjSHhVGFNEonDH
         qMEhEzGJ0gDi1wKIyxkkI/WQ0doPMaQxA6K1/vQi1s10siqJILR2otncZWLdi+oh5P8R
         6Y5lOv3fabbbHiGp2WJ6PYwbaoxRKq6vmWQbFYQ3qWAbtymChqNILZ3bxS6JwrynuS6p
         MzPg==
X-Gm-Message-State: AOAM5334qoemLOgQYQp6aPhF77kJkUdk6UvCvlAf/7Dl2cOtkQKJhPKg
        jKH1wSisCzjFMc1xbSW48hsnab1dd3OP42p98tSGWQ==
X-Google-Smtp-Source: ABdhPJy7W6iCOh9206/nHb96S3y7AeNe4K9GNZLAbvmPTxAthIwH3e0WVwMB5MxSxntYqxTMRHH/yYMSRFlIlG5jrKU=
X-Received: by 2002:a17:907:eab:b0:6da:8ec5:d386 with SMTP id
 ho43-20020a1709070eab00b006da8ec5d386mr28578130ejc.668.1648487111704; Mon, 28
 Mar 2022 10:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220310210210.2124637-1-brendanhiggins@google.com>
 <Yirz/hbo4K9zN9Ht@google.com> <CAFmMkTFa9xVt314WEGd0nNx+ovc=aGB_yN1LorP7WrBga9quxw@mail.gmail.com>
 <CAGS_qxqHhGEYS_4C-gTmPt_d3Fm==VOTEzQGggWh6MWppTHtZQ@mail.gmail.com>
 <CAFmMkTEoYXAFuz152SobMqnL3TM3GhQNDtR+_+RrzU=sx-bbRg@mail.gmail.com> <CAGS_qxqBuk1knE3424gV73wVgv5kJS5EGmd--bD2FAfuid5XGg@mail.gmail.com>
In-Reply-To: <CAGS_qxqBuk1knE3424gV73wVgv5kJS5EGmd--bD2FAfuid5XGg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Mar 2022 13:04:59 -0400
Message-ID: <CAFd5g45bd3qG99D8KG=qHS0hQGoD=umTDuUnzoQ7t2BUOR=Evw@mail.gmail.com>
Subject: Re: [RFC v1] kunit: add support for kunit_suites that reference init code
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        David Gow <davidgow@google.com>, shuah@kernel.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Richard Hughes <hughsient@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 25, 2022 at 11:59 AM Daniel Latypov <dlatypov@google.com> wrote=
:
>
> On Fri, Mar 25, 2022 at 8:26 AM Daniel Gutson
> <daniel.gutson@eclypsium.com> wrote:
> >
> > On Fri, Mar 11, 2022 at 2:56 PM Daniel Latypov <dlatypov@google.com> wr=
ote:
> > >
> > > On Fri, Mar 11, 2022 at 4:14 AM Daniel Gutson
> > > <daniel.gutson@eclypsium.com> wrote:
> > > >
> > > >
> > > >
> > > > El vie., 11 mar. 2022 4:02 a. m., David Gow <davidgow@google.com> e=
scribi=C3=B3:
> > > >>
> > > >> On Thu, Mar 10, 2022 at 01:02:10PM -0800, Brendan Higgins wrote:
> > > >> > Add support for a new kind of kunit_suite registration macro cal=
led
> > > >> > kunit_test_init_suite(); this new registration macro allows the
> > > >> > registration of kunit_suites that reference functions marked __i=
nit and
> > > >> > data marked __initdata.
> > > >> >
> > > >> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > >> > ---
> > > >> >
> > > >> > This patch is in response to a KUnit user issue[1] in which the =
user was
> > > >> > attempting to test some init functions; although this is a funct=
ional
> > > >> > solution as long as KUnit tests only run during the init phase, =
we will
> > > >> > need to do more work if we ever allow tests to run after the ini=
t phase
> > > >> > is over; it is for this reason that this patch adds a new regist=
ration
> > > >> > macro rather than simply modifying the existing macros.
> > > >> >
> > > >> > [1] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCw=
VABgAJ
> > > >> >
> > > >> > ---
> > > >>
> > > >> I'm a little concerned that this is just removing the warnings, bu=
t do
> > > >> agree that this is safe enough for the moment. At least the inform=
ation
> > > >> about which tests need __init is preserved by the use of a differe=
nt
> > > >> macro.
> > > >>
> > > >> I guess one day we'll need a second list of 'init' tests or someth=
ing...
> > > >
> > > >
> > > > Hi, could you please detail about this? Why a second list?
> > > >
> > >
> > > I assume this is referring to a future where we want to run tests
> > > _after_ the init phase.
> > > In that case, we'd need to be able to separately register tests that
> > > run during and those that run after.
> > > (Or we could have one list and just tag each suite as init/post-init.
> > > If we ever had >2 "phases" where we run tests, this might be the more
> > > scalable option)
> > >
> > > Is it likely we'd have tests run after?
> > > Not in the near future, I don't think. But it could be asked for.
> > >
> > > For context, here's where built-in KUnit tests currently run:
> > > https://elixir.bootlin.com/linux/v5.17-rc7/source/init/main.c#L1615
> > > That'd probably become kunit_run_init_tests() and then we'd have
> > > another kunit_run_post_init_tests() called later, or something.
> >
> > Hi folks, any update on this? I'm adding Richard Hughes since we
> > need this for fwupd/LVFS, so he can provide more context.
>
> v1 of the patch was posted here:
> https://lore.kernel.org/linux-kselftest/20220311072859.2174624-1-brendanh=
iggins@google.com/
>
> It has the requisite Reviewed-by's and no one has complained about it.
> So we're now waiting for that to get picked up into Shuah's tree and
> into Linus' for 5.18 (possibly) or 5.19.

It'll probably be 5.19, but it should be applied to Shuah's kunit-next
branch end of this week begining of next and then you can use that as
a base if you wish.
