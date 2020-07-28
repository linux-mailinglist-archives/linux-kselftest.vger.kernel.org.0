Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D370C230063
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jul 2020 05:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgG1Dy2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jul 2020 23:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgG1Dy1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jul 2020 23:54:27 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D45C061794;
        Mon, 27 Jul 2020 20:54:27 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id y134so4647407yby.2;
        Mon, 27 Jul 2020 20:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r0Ob3USH6EZXFhicv046mK2EZvXGxjgCtpckOHpH4z0=;
        b=HWH0jdlShBg+VmFjWuGKsOI9Lc/YXzv7++WuqpHxe2aPsRHe0DkDVeMAz4Gqq+6HVx
         DxBNQGvj1wSY0dBCgV/Z6lGR4fAeosOkUNEOZohNgEcpTmsofP4rK+ubdpYOzkoHrZMU
         AHhN9Q8ooYUV5n+ClU+ADuqLQxig2lzT04PXs/vXxs8Vxz/e/knu0bOOdL8iU/BRQ+G5
         GWIKcEZAKxf2Lbd4VPngJ08ui45YA01dXQv/ymsGnutgTCUvf5Uo6KDjDQErM3kulBo0
         r2u1N2Mygt8LlHdM8/X0SdI28WDezGRbY1dTz2+fV5ar72OQnghFrGpmAAlv+HOCk1ei
         VqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r0Ob3USH6EZXFhicv046mK2EZvXGxjgCtpckOHpH4z0=;
        b=MUe/FUgNfkzFG+ePNytfflE+iapG1C3OoAEO9xMS/lMMM+MlLBLuLH7ddRGAW83YbP
         FK0Ei0bh5lXoRh2ygOCFEOPk9Ov4HXOVymPBdufpOKirj5BKHXV7M8MN9OYrt6P2Eenf
         Coa5TkT+wSIanBi4MT9a/mVqmOAFO+8szfstgGsOivivUCWIc1UsdMEfIo5PPg343PsC
         tegnuH+eKaEl7D1lUW9TCOFeS+MDhkA4VgCa76iX0DYRamN2P5ZqW42gP3Pa3pStC2Qd
         U7qZ4obWrCs7RCO5Bx9wQNv6nSylpgBLSKyPaTmtdqi8hwUkILXuJ+AaIVbp9b2f9HGC
         A19w==
X-Gm-Message-State: AOAM531TcjpUNMQyqj+zFvGYafdtj+ijkHs+Mwq3NsFtew+Lu4rlkHti
        pNdd4Xyiaw3ZqhuTzRcWLHKFq68nSx8BvcuPfuA=
X-Google-Smtp-Source: ABdhPJykBFadHVlFLRCIySq0Oncq7PZNEdDsLZ1zkTrGJkqqbtI4dszMpcnN75GdJWd5xM0RZ+otjBpc6aZUWEtcv8g=
X-Received: by 2002:a25:9843:: with SMTP id k3mr37697556ybo.292.1595908467016;
 Mon, 27 Jul 2020 20:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAF12kFsOrFOQBrZv6qBbcQ971acEM0XxLWKqBJvEspoQ3UOHUQ@mail.gmail.com>
 <CAFd5g47cQ6tC3cLOqFiHHNO9XjgpTQLNsw=-bBKvsPMs+DGrLg@mail.gmail.com>
In-Reply-To: <CAFd5g47cQ6tC3cLOqFiHHNO9XjgpTQLNsw=-bBKvsPMs+DGrLg@mail.gmail.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Tue, 28 Jul 2020 11:53:51 +0800
Message-ID: <CAF12kFvO6GA7G7soNJN5WS=8x6NnmqCUE-4M43ppP9t3-=OjNQ@mail.gmail.com>
Subject: Re: kunit compile failed on um
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>, zhang.lyra@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Here I found my error rootcause:

My Makefile add a Werror flag, So it wil build waring as error as the
follow code

../arch/um/os-Linux/signal.c: In function
\xe2\x80\x98sig_handler_common\xe2\x80\x99:
../arch/um/os-Linux/signal.c:51:1: error: the frame size of 2960 bytes
is larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
 }
 ^
../arch/um/os-Linux/signal.c: In function
\xe2\x80\x98timer_real_alarm_handler\xe2\x80\x99:
../arch/um/os-Linux/signal.c:95:1: error: the frame size of 2960 bytes
is larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
 }

and I add the CONFIG_FRAME_WARN=3D4096  in arch/um/x86_64_defconfig  so
there was no error when I use make ARCH=3Dum defconfig && make ARCH=3Dum
BUT I found the commit ff7b437f36b026dcd7351f86a90a0424c891dc06 has
changed use  make ARCH=3Dum  kunit_defconfig in kunit.py. So the error
happened.

Further More, I compare the different between use x86_64_defconfig and
kunit_defconfig, there is a big difference.
Can We use kunit_defconfig on the basis of the x86_64_defconfig ?
If the answer is ok=EF=BC=8C I would like to help add this functions

Brendan Higgins <brendanhiggins@google.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=
=8828=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=885:29=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Jul 27, 2020 at 3:01 AM Cixi Geng <gengcixi@gmail.com> wrote:
> >
> > Hi Brendan:
> > When I run kunit test in um , it failed on kernel 5.8-rc* while
> > succeeded  in v5.7 with same configuration. is this a bug?
> >
> > Here is my operation:
> >  gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
> >
> > the kunitconfig:
> > Cixi.Geng:~/git-projects/torvals-linux$ cat .kunitconfig
> > CONFIG_KUNIT=3Dy
> > CONFIG_KUNIT_TEST=3Dy
> > CONFIG_KUNIT_EXAMPLE_TEST=3Dy
> >
> > command:
> > Cixi.Geng:~/git-projects/torvals-linux$ ./tools/testing/kunit/kunit.py =
run
> >
> > the Error log:
> > [17:51:14] Configuring KUnit Kernel ...
> > [17:51:14] Building KUnit Kernel ...
> > ERROR:root:b"make[1]:
> > \xe8\xbf\x9b\xe5\x85\xa5\xe7\x9b\xae\xe5\xbd\x95\xe2\x80\x9c/home/cixi.=
geng1/git-projects/torvals-linux/.kunit\xe2\x80\x9d\n/home/cixi.geng1/git-p=
rojects/torvals-linux/Makefile:551:
> > recipe for target 'outputmakefile' failed\nmake[1]:
> > \xe7\xa6\xbb\xe5\xbc\x80\xe7\x9b\xae\xe5\xbd\x95\xe2\x80\x9c/home/cixi.=
geng1/git-projects/torvals-linux/.kunit\xe2\x80\x9d\nMakefile:185:
> > recipe for target '__sub-make' failed\n"
>
> So we have a fix out for the cryptic error messages:
>
> https://patchwork.kernel.org/patch/11652711/
>
> But I believe it has not been picked up yet.
>
> In the meantime, you should get more information by running
>
> ls .kunit
> make ARCH=3Dum O=3D.kunit
>
> Let us know if you have any additional questions.
