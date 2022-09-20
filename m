Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A095BD8C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 02:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiITAZy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Sep 2022 20:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiITAZx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Sep 2022 20:25:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE7227DC4
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Sep 2022 17:25:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u9so2458025ejy.5
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Sep 2022 17:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=SHdx658d5eJ351SjXpaHoy80sr1PT1pZTwcVFt7b0mg=;
        b=HwAixdnC9CUd2kg5QsHataIn9+QH16TpCdsKCvu0q/lLdxtFdLWarK6r1H0gR6nMiW
         Vh9SEE8QJmiF9y3f+efEC0ftqVFriICksaG48w2bYr2n8LQiLKpbrzpgZMgZsaRQeGnR
         2OBu/WTyX3ob2AgR1lxX4YHzAu6yVClizQeEUfOZWjR5JZR806GfLDZIntU/7apRjnA3
         /VCTcmkX3WTtObbp+9G9hFwHRtup8HsGoaWGpJWgaCb6wjGxRIzCE4FYB9/yX+1y3m9Z
         f0JRuvLYV6NzDJ5rlGAltQgNLzRfDbii1kRw73ZT66FDqJfo8SITlUBzEXmv6OLLde97
         xVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SHdx658d5eJ351SjXpaHoy80sr1PT1pZTwcVFt7b0mg=;
        b=ZUFaWkD/cdss9AYXeyNLx7HoLrJZK1KUP2HMNcFqlH02IkyOmrijQhu4BvLfCl73EZ
         6KrZEggm+j4wNR7hAyYKVcirJXxIrQ8OUuI7P0J97370Rdfri+G8ioJLXq0EOzGNlK9f
         gg/s1t9oMNO6vrhG+22Mze9GKsHdTDwLmnvMHUVqF+p7+PYTPJIeFY36GDCthvTHdqeq
         GXjDwE9WOKhSn0AUMzfM5tLvvJIOWwjMSGsE+jXh/gT2H3CECw3ajHZG4k3a6N9vyeku
         E3+D1/s38QoTcoOyV008gmKQ4VsLGzkzPgc20GQ5PMVCuxFMgDHkyGTryykN0wCdUOWv
         Py8w==
X-Gm-Message-State: ACrzQf2hGhqiDj/ntFeOpe4uN5jzW8uR5hqAdrZ7tILMRaotsLnMImkT
        pdN2xkPteOt63nhKXT2VmOLsHcMJtMKKS0fBOglBpw==
X-Google-Smtp-Source: AMsMyM5LfXWMfPIHyTKPDxqr7169qvp6q0WVgzWsqn3e8lNhyGjlmWBdSWM1D3lwLZUbG04lMEXYvyir96YkW9H2QpE=
X-Received: by 2002:a17:907:94ca:b0:780:12fb:3c7c with SMTP id
 dn10-20020a17090794ca00b0078012fb3c7cmr14487810ejc.650.1663633550030; Mon, 19
 Sep 2022 17:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220829000920.38185-1-isabbasso@riseup.net> <20220829000920.38185-4-isabbasso@riseup.net>
 <CABVgOS=HO9XAf8C5X7ZD6aTW37r06ify==7AW9a8cpKsgLVfFw@mail.gmail.com> <D53B4EB1-1A95-48F1-BF49-8EC0CC7B5418@riseup.net>
In-Reply-To: <D53B4EB1-1A95-48F1-BF49-8EC0CC7B5418@riseup.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 19 Sep 2022 17:25:38 -0700
Message-ID: <CAGS_qxpCPTSRNAyejL0gS0pZAoVNp9SdFwPFkHRyn5yMuPGkLw@mail.gmail.com>
Subject: Re: [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility for KUnit
To:     Isabella Basso <isabbasso@riseup.net>
Cc:     David Gow <davidgow@google.com>, igt-dev@lists.freedesktop.org,
        Magali Lemes <magalilemes00@gmail.com>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        Tales Aparecida <tales.aparecida@gmail.com>,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>,
        Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        daniel@fooishbar.org, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 19, 2022 at 1:43 PM Isabella Basso <isabbasso@riseup.net> wrote=
:
> >> +        * "(K)TAP version XX" should be the first line on all (sub)te=
sts as per
> >> +        * https://www.kernel.org/doc/html/latest/dev-tools/ktap.html#=
version-lines
> >> +        * but actually isn't, as it currently depends on whoever writ=
es the
> >> +        * test to print this info
> >
> > FYI: we're really trying to fix cases of "missing version lines",
> > largely by making the kunit_test_suites() macro work in more
> > circumstances.
> >
> > So while it may be worth still handling the case where this is
> > missing, I don't think there are any tests in the latest versions of
> > the kernel which should have this missing.
>
> I=E2=80=99m not sure if I totally get how these work. Every time I run a =
KUnit test I
> get something like this: https://pastebin.com/7Ff31PMC
>
> As you can see it has been loaded as a module, just like we intend to do =
it
> from IGT, and I see no version lines whatsoever. Am I doing something wro=
ng?

You're doing everything right.

The problem is we only print the version line for the *built-in* tests.
It never gets printed for tests in loadable modules.

Some more details below, if interested.
Specifically, it happens in
https://elixir.bootlin.com/linux/latest/C/ident/kunit_print_tap_header

What David is referring to is we had tests that weren't in modules,
but didn't use the normal built-in code path. Those were also missing
TAP version lines.
But KUnit needs to do better here in the case of modules.

The goal was that you'd be able to parse the result of module based
tests by something like
$ cat /sys/kernel/debug/kunit/*/results | ./tools/testing/kunit/kunit.py pa=
rse
but this doesn't work because of the lack of a version line.

If we add it to each module's test results, then we'll need to update
the parse to allow multiple verison lines, I think.

Daniel
