Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D83859C133
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 16:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiHVOAy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 10:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiHVOAw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 10:00:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA9F2DAAA
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 07:00:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p18so9994417plr.8
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=kjJw1lixEQIrNLEOEvpfk899fKXlaGFwMiOH1KRB12M=;
        b=sbS1HvywFSfEMOSLBpwixOVInNvRZMvLa/Kj6cjMDiERtJknENs/JEaFvkLTsox6lW
         HD4cdPRvoxqqXTG5v+ldcmJu09E5vUo4y5L0I/ER8IAiD0ZOxI4Wo+c7YpbRruCkY90x
         TKXI3k0gBBHXJPm3aepPOBUOKMJ4TwA9uWK4eIa18oC/p7cgWdEweLt7eo9ssLSs55Zp
         rRYp8v+TiuKMipQB7gIvSf4UJogx6PjiN9ftTebRgwJBYh6jVgxg7D1cPaVMeW8UwbNo
         vkF4NzQlk+Pg+7XmzLnG1rD36ZCLjlE4iQbIsU+DZTRn0G9PxCoMSpoo8sbxSdOJZ8T3
         1S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=kjJw1lixEQIrNLEOEvpfk899fKXlaGFwMiOH1KRB12M=;
        b=HKhfOOCJUwwGV44qOlIFFJqBY59JheSPk6j5gZADhspjEF6JbVp4iSfgLsfkHUnaVJ
         FpQp4GCICex5QtUCHEGLluJWMKl1xrBTZN1+2clfGSSdfzzlMyz2CJWYfLm0SqnRIesq
         ybRjljd/l+3SPkPF27o76gOuvoHtNI3w/YLtysMvKFKnTQ6Tz1w/86hJcbhtBk7aEBT8
         ZkUDJcDcJ9sW9/Lpx4zVch0wNaAX4Nodb4oL/F56fv7b4/vjb6CFf51KAiEs1641HZje
         qHnyQPx1g1ka7TG4cZMerEiIV/B8zyyBCAMr+mMZxSEd+o2khi3uUNC3zkN2xibfglfh
         RdXw==
X-Gm-Message-State: ACgBeo2CbAAwRb4LdkdcngVg4+73f6NUDNqSBTB066vujKH8WvT81+ux
        kjLO8tqrumYUx716sa8JDY3j+qbLaFcUPKO/AUfYD6TiHnw=
X-Google-Smtp-Source: AA6agR5FvMT6MZWvn7FQCgowa6/lGiwYVOR8wnvEisKJw3867tepZ75KayAqpGFx016KD7WcPU7jnVR//s8gg9qIrRs=
X-Received: by 2002:a17:902:8683:b0:171:3114:7678 with SMTP id
 g3-20020a170902868300b0017131147678mr20494169plo.172.1661176849884; Mon, 22
 Aug 2022 07:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
 <CADYN=9JM1nnjC9LypHqrz7JJjbZLpm8rArDUy4zgYYrajErBnA@mail.gmail.com> <e4843a98-0bde-829c-f77a-56d45ba324d7@digikod.net>
In-Reply-To: <e4843a98-0bde-829c-f77a-56d45ba324d7@digikod.net>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 22 Aug 2022 16:00:37 +0200
Message-ID: <CADYN=9+CFEV9QpNbhi6gKqJr1V5Jc8Q5hGhCD_ESkRXP2X3gbQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/landlock: fix broken include of linux/landlock.h
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Guillaume <guillaume.tucker@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
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

On Sat, 13 Aug 2022 at 14:31, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wr=
ote:
>
>
> On 13/08/2022 12:01, Anders Roxell wrote:
> > On Wed, 3 Aug 2022 at 22:14, Guillaume Tucker
> > <guillaume.tucker@collabora.com> wrote:
> >>
> >> Revert part of the earlier changes to fix the kselftest build when
> >> using a sub-directory from the top of the tree as this broke the
> >> landlock test build as a side-effect when building with "make -C
> >> tools/testing/selftests/landlock".
> >>
> >> Reported-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> >> Fixes: a917dd94b832 ("selftests/landlock: drop deprecated headers depe=
ndency")
> >> Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
> >> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> >
> > Building with this patch doesn't work, it gives this output:
> > make[3]: Entering directory
> > '/home/anders/src/kernel/next/tools/testing/selftests/landlock'
> > make[3]: Leaving directory
> > '/home/anders/src/kernel/next/tools/testing/selftests/landlock'
> > make[3]: *** No rule to make target
> > '/home/anders/.cache/tuxmake/builds/78/build/kselftest/landlock/base_te=
st',
> > needed by 'all'.  Stop.
> >
> > I'm building like this:
> > tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-12
> > --kconfig defconfig kselftest
> >
> > which translates into this make command:
> > make --silent --keep-going --jobs=3D32
> > O=3D/home/anders/.cache/tuxmake/builds/78/build
> > INSTALL_PATH=3D/home/anders/.cache/tuxmake/builds/78/build/kselftest_in=
stall
> > ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- kselftest-install
>
> This works well for me.

Interesting

> Which commit is checkout?

I used the latest next tag, I tried to on todays tag as well
next-20220822 and I see
the same issue.
building without 'O=3D...' I can build the landlock tests...

>
>
> >
> > building without this patch works, see below:
> >
> > make[3]: Entering directory
> > '/home/anders/src/kernel/next/tools/testing/selftests/landlock'
> > x86_64-linux-gnu-gcc -Wall -O2 -isystem
> > /home/anders/.cache/tuxmake/builds/77/build/usr/include    base_test.c
> >   -o /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/bas=
e_test
> > -lcap
> > x86_64-linux-gnu-gcc -Wall -O2 -isystem
> > /home/anders/.cache/tuxmake/builds/77/build/usr/include    fs_test.c
> > -o /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/fs_te=
st
> > -lcap
> > x86_64-linux-gnu-gcc -Wall -O2 -isystem
> > /home/anders/.cache/tuxmake/builds/77/build/usr/include
> > ptrace_test.c  -o
> > /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/ptrace_t=
est
> > -lcap
> > x86_64-linux-gnu-gcc -Wall -O2 -isystem
> > /home/anders/.cache/tuxmake/builds/77/build/usr/include    true.c  -o
> > /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/true
> > -static
> > make[3]: Leaving directory
> > '/home/anders/src/kernel/next/tools/testing/selftests/landlock'
> Does this work if you revert this patch, commit a917dd94b832
> ("selftests/landlock: drop deprecated headers dependency") and commit
> f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")?
>
> This patch mainly revert commit a917dd94b832, so I don't see the issue.
>
>
> >
> > Cheers,
> > Anders
> >
> >> ---
> >>   tools/testing/selftests/landlock/Makefile | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing=
/selftests/landlock/Makefile
> >> index a6959df28eb0..02868ac3bc71 100644
> >> --- a/tools/testing/selftests/landlock/Makefile
> >> +++ b/tools/testing/selftests/landlock/Makefile
> >> @@ -9,10 +9,13 @@ TEST_GEN_PROGS :=3D $(src_test:.c=3D)
> >>   TEST_GEN_PROGS_EXTENDED :=3D true
> >>
> >>   OVERRIDE_TARGETS :=3D 1
> >> +top_srcdir :=3D ../../../..
> >>   include ../lib.mk
> >>
> >> +khdr_dir =3D $(top_srcdir)/usr/include
> >> +
> >>   $(OUTPUT)/true: true.c
> >>          $(LINK.c) $< $(LDLIBS) -o $@ -static
> >>
> >> -$(OUTPUT)/%_test: %_test.c ../kselftest_harness.h common.h
> >> -       $(LINK.c) $< $(LDLIBS) -o $@ -lcap
> >> +$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_=
harness.h common.h
> >> +       $(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)
> >> --
> >> 2.30.2
> >>
