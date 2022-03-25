Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A4B4E7885
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Mar 2022 16:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359447AbiCYQBT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Mar 2022 12:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376380AbiCYQBS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Mar 2022 12:01:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354E656C35
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 08:59:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bi12so16292927ejb.3
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gpN67V582CHPbxBisa52Dy5g6J1ZXtdjpLk4FW2ME/o=;
        b=byDSm1Y9M94+/23XfW4CSXNRNpB3EVQ/hh6wSv97dbsfkupUHpMNs/0fy3COOblPsw
         9jurThzgOfjszJCkEWcujnKotl4/C0LsGBAKrf9PV43QZKcpaVKQuW6elDzogr7tiAct
         y98JiYANAmSLW62nfBYjYwAwT+hcYqG9rNH20MIive+C3A2e49vLhjhmSl9ajqRx/GG7
         lL1CSntp4OL08PTobCrorSEa84QrRGXk5raq0o0S+rkyVB8FJWgz9PeMxEZQbvWoAC3L
         NrsYLdfiGBaPgJZWGg0h67TNUJf5OEUBTX1JY36dOJoeY1sMteP7DMK132fD2fXbRt4k
         Pvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gpN67V582CHPbxBisa52Dy5g6J1ZXtdjpLk4FW2ME/o=;
        b=F47BXjxY1oQYAu12y6GQaQOGjHlRNfQ1L7ua4dbiJfz6kODNGtCOqGHrbhEnURy3fk
         nGzvCqYyPzVur8MATsrUM0ArrjgEu6+/iKMEh9zfdixfnKa2QoT+ShlNkyUysmnHUpm5
         lNqbKlkkm2MciYS6I2vUS7fiGaOTEC7/DJ15PFj/YxOJLc9TK/qLCBYZg8DD39CZ8KtU
         QsvgcUamxHPITphHxwW0QqhBTXnm5yQvLaGH1Uzd7X8ZXJ11+M+zuayxDu/znWzokMcQ
         Rb9buINu+qdpajIsIjDWf8ZFmPfdeaLD8Ftbt9V1RmXMgFSFqhmFmdCxXVR76M3OWby4
         cp3A==
X-Gm-Message-State: AOAM533s6Ck7MSUHfeMWKhHieu7hYVb8FNLOH9tdLtoQDr9yyIn76HeA
        sPcsrjvAD7nBf9/SLFDF20adZf0R0pQRw+4S30JyPA==
X-Google-Smtp-Source: ABdhPJzzFj73nI5shKRcHKXT/1f74YL1Ee3RYYJn+9By9/FdJ29dBT2ccPsJ1teiXOJl4bmoMfWCsjtanD7gU7h/unU=
X-Received: by 2002:a17:907:1c06:b0:6df:b257:cbb3 with SMTP id
 nc6-20020a1709071c0600b006dfb257cbb3mr12064857ejc.631.1648223982439; Fri, 25
 Mar 2022 08:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220310210210.2124637-1-brendanhiggins@google.com>
 <Yirz/hbo4K9zN9Ht@google.com> <CAFmMkTFa9xVt314WEGd0nNx+ovc=aGB_yN1LorP7WrBga9quxw@mail.gmail.com>
 <CAGS_qxqHhGEYS_4C-gTmPt_d3Fm==VOTEzQGggWh6MWppTHtZQ@mail.gmail.com> <CAFmMkTEoYXAFuz152SobMqnL3TM3GhQNDtR+_+RrzU=sx-bbRg@mail.gmail.com>
In-Reply-To: <CAFmMkTEoYXAFuz152SobMqnL3TM3GhQNDtR+_+RrzU=sx-bbRg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 25 Mar 2022 10:59:31 -0500
Message-ID: <CAGS_qxqBuk1knE3424gV73wVgv5kJS5EGmd--bD2FAfuid5XGg@mail.gmail.com>
Subject: Re: [RFC v1] kunit: add support for kunit_suites that reference init code
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 25, 2022 at 8:26 AM Daniel Gutson
<daniel.gutson@eclypsium.com> wrote:
>
> On Fri, Mar 11, 2022 at 2:56 PM Daniel Latypov <dlatypov@google.com> wrot=
e:
> >
> > On Fri, Mar 11, 2022 at 4:14 AM Daniel Gutson
> > <daniel.gutson@eclypsium.com> wrote:
> > >
> > >
> > >
> > > El vie., 11 mar. 2022 4:02 a. m., David Gow <davidgow@google.com> esc=
ribi=C3=B3:
> > >>
> > >> On Thu, Mar 10, 2022 at 01:02:10PM -0800, Brendan Higgins wrote:
> > >> > Add support for a new kind of kunit_suite registration macro calle=
d
> > >> > kunit_test_init_suite(); this new registration macro allows the
> > >> > registration of kunit_suites that reference functions marked __ini=
t and
> > >> > data marked __initdata.
> > >> >
> > >> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > >> > ---
> > >> >
> > >> > This patch is in response to a KUnit user issue[1] in which the us=
er was
> > >> > attempting to test some init functions; although this is a functio=
nal
> > >> > solution as long as KUnit tests only run during the init phase, we=
 will
> > >> > need to do more work if we ever allow tests to run after the init =
phase
> > >> > is over; it is for this reason that this patch adds a new registra=
tion
> > >> > macro rather than simply modifying the existing macros.
> > >> >
> > >> > [1] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVA=
BgAJ
> > >> >
> > >> > ---
> > >>
> > >> I'm a little concerned that this is just removing the warnings, but =
do
> > >> agree that this is safe enough for the moment. At least the informat=
ion
> > >> about which tests need __init is preserved by the use of a different
> > >> macro.
> > >>
> > >> I guess one day we'll need a second list of 'init' tests or somethin=
g...
> > >
> > >
> > > Hi, could you please detail about this? Why a second list?
> > >
> >
> > I assume this is referring to a future where we want to run tests
> > _after_ the init phase.
> > In that case, we'd need to be able to separately register tests that
> > run during and those that run after.
> > (Or we could have one list and just tag each suite as init/post-init.
> > If we ever had >2 "phases" where we run tests, this might be the more
> > scalable option)
> >
> > Is it likely we'd have tests run after?
> > Not in the near future, I don't think. But it could be asked for.
> >
> > For context, here's where built-in KUnit tests currently run:
> > https://elixir.bootlin.com/linux/v5.17-rc7/source/init/main.c#L1615
> > That'd probably become kunit_run_init_tests() and then we'd have
> > another kunit_run_post_init_tests() called later, or something.
>
> Hi folks, any update on this? I'm adding Richard Hughes since we
> need this for fwupd/LVFS, so he can provide more context.

v1 of the patch was posted here:
https://lore.kernel.org/linux-kselftest/20220311072859.2174624-1-brendanhig=
gins@google.com/

It has the requisite Reviewed-by's and no one has complained about it.
So we're now waiting for that to get picked up into Shuah's tree and
into Linus' for 5.18 (possibly) or 5.19.
