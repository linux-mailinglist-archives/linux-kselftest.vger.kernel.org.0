Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3987309AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 23:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbjFNVRK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 17:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbjFNVRJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 17:17:09 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2361BEC
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 14:17:07 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75f07dee22cso245573285a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686777427; x=1689369427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrLCxGP3h4zlnPwsi/7+4fkOnHUcAp0hewA5gzf9FKk=;
        b=s88NVQV+0voSmP3DMArDzRi0rYMzK3wgn+fEX4GUrwdG6Roc/+Juh2V+CN2sy8ywdx
         Wh1wjvOgCN+gjqlk/3N+zdYEuHzR5zKttvOevT+HIuiEBfYBNfwRwTpommo39cNdBBT4
         GAOQQJO9vIiIDEtV6msrkWUeEBpZW3VXjVpStO0bHqmMEtuoUwqQ7+WmGLM5hjwkzyq3
         VBEnsNr8WMIg8v2spjXSjjAxbvoNUKMjAK6FJLtliS57ZjotEo6tlfgfzfHhZ8l8Uthr
         wott04zj+hh2z2GwYm9Pt8EpVJIksclDinqrxa9buccQTAYdgJBMMh45Qg7x8b4CTbpI
         meYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686777427; x=1689369427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrLCxGP3h4zlnPwsi/7+4fkOnHUcAp0hewA5gzf9FKk=;
        b=XM+UlKlmEj1uVLyiVhosxM6HsEn6PAheAcF31KElX8XDYGhXTtsNMGJ0RAFd8A5TKb
         cNWn5Bk3vDM/PLXQwV6NNwfVOBw/z4VIM7gSm1ISimFzUO231BGigP1pD4XrS96MMcPD
         epVlgMEfJUGTu7Z5zOgD8SlfNVSoJ7To92DKvp3oy/uKUODdO27lOHE8Zgs87RH8s8k6
         fUbE9fDY6AukQai+ITyr6E/sxz+JtKtnKgWxFppx2AWX15YxLwETZbMUBig6249dP2Ny
         ajzv1TWxSiRC9xHX/ZXblfvIW9J6N7UEYUqtbJ3J4tBYKGWfKNdSFpKdx9UCLcEuudNL
         MDrA==
X-Gm-Message-State: AC+VfDySQwniyGcMJfykDfH+9wgeto+22TCzOk3TCp7J1t86rKb9yp83
        iolA0T6ji82ZD6mJmOQbIsoJKDmECUHOjvV3Sn1Mz4Tvel1Rgy+VAqI=
X-Google-Smtp-Source: ACHHUZ7Z18A4KGrcwUHwViGaJHZwDogEDaPqj1WdmOZqiDG5itgrHPS6ctGVoN1GjhurXWvxhC6FKcW7e3zEyR+L5+o=
X-Received: by 2002:a05:6214:300a:b0:5af:9276:b59d with SMTP id
 ke10-20020a056214300a00b005af9276b59dmr18797042qvb.18.1686777427098; Wed, 14
 Jun 2023 14:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230613074931.666966-1-anders.roxell@linaro.org> <928ad485-2dc2-2e02-98a2-fa203441f463@nvidia.com>
In-Reply-To: <928ad485-2dc2-2e02-98a2-fa203441f463@nvidia.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 14 Jun 2023 23:16:56 +0200
Message-ID: <CADYN=9KtYe6jo+MDm+3NVwfNFzsOgoRRKxu_hSJeEPMuLRGgeg@mail.gmail.com>
Subject: Re: [PATCH] selftests: lib.mk: fix out-of-tree builds
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, usama.anjum@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 14 Jun 2023 at 04:23, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 6/13/23 00:49, Anders Roxell wrote:
> > Since commit ("selftests: error out if kernel header files are not yet
> > built") got merged, the kselftest build correctly because the
> > KBUILD_OUTPUT isn't set when building out-of-tree and specifying 'O=3D'
> > This is the error message that pops up.
> >
> > make --silent --keep-going --jobs=3D32 O=3D/home/anders/.cache/tuxmake/=
builds/1482/build INSTALL_PATH=3D/home/anders/.cache/tuxmake/builds/1482/bu=
ild/kselftest_install ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- V=3D1=
 CROSS_COMPILE_COMPAT=3Darm-linux-gnueabihf- kselftest-install
> > make[3]: Entering directory '/home/anders/src/kernel/next/tools/testing=
/selftests/alsa'
> >
> > -e  [1;31merror [0m: missing kernel header files.
> > Please run this and try again:
> >
> >      cd /home/anders/src/kernel/next/tools/testing/selftests/../../..
> >      make headers
> >
> > make[3]: Leaving directory '/home/anders/src/kernel/next/tools/testing/=
selftests/alsa'
> > make[3]: *** [../lib.mk:77: kernel_header_files] Error 1
> >
> > Fixing the issue by assigning KBUILD_OUTPUT the same way how its done i=
n
> > kselftest's Makefile. By adding 'KBUILD_OUTPUT :=3D $(O)' 'if $(origin =
O)'
> > is set to 'command line'. This will set the the BUILD dir to
> > KBUILD_OUTPUT/kselftest when doing out-of-tree builds which makes them
> > in its own separete output directory.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >   tools/testing/selftests/lib.mk | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/l=
ib.mk
> > index b8ea03b9a015..d17854285f2b 100644
> > --- a/tools/testing/selftests/lib.mk
> > +++ b/tools/testing/selftests/lib.mk
> > @@ -44,6 +44,10 @@ endif
> >   selfdir =3D $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
> >   top_srcdir =3D $(selfdir)/../../..
> >
> > +ifeq ("$(origin O)", "command line")
> > +  KBUILD_OUTPUT :=3D $(O)
> > +endif
> > +
>
> Thanks for fixing this up! This looks correct.
>
> (It's too bad that we have all this duplication between the Makefile
> and lib.mk.)

I agree, also the duplication of get_sys_includes in bpf, hid and net Makef=
ile's
Do you have any idea how we can remove the duplication?

Cheers,
Anders

>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> >   ifneq ($(KBUILD_OUTPUT),)
> >     # Make's built-in functions such as $(abspath ...), $(realpath ...)=
 cannot
> >     # expand a shell special character '~'. We use a somewhat tedious w=
ay here.
>
>
