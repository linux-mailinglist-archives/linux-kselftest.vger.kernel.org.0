Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DF51DDD2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 04:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgEVCd3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 May 2020 22:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgEVCd3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 May 2020 22:33:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C98C061A0E
        for <linux-kselftest@vger.kernel.org>; Thu, 21 May 2020 19:33:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l17so8681767wrr.4
        for <linux-kselftest@vger.kernel.org>; Thu, 21 May 2020 19:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+ZKAAePgPoXfbKo5Hozq85B0HeLeRkkBPDS2D4udVpc=;
        b=U5rKi5+3b38hjHIJKu+gpjy5NbVKvBuNhdyO1YiS62lkC8o0APSGrw/2d/ESwNSdPw
         s9B/Dl3NByey3vVhU+FMjqEvUqjCHq5EkKcY1itM3NVXU1wUK9AZXH0Oz9+Cb2xvHbku
         irpH5zPa6YHLiypPJG9R6eXctt1AS59W9gty24CnxXuUnRfGw622tcBUW1la+qV2og7g
         7pePPMoIukf6y6g8+y4urDp19j2NE3SA11iLy9w/ClC+BRhC/xWwHK4m87lyaTzOlg80
         phulmQ5vX8167+1AdRSsz8oTvIopH7wnKDSc1exl+FsbmvIRfLsvNFPC1psgey9nfMqP
         8bwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+ZKAAePgPoXfbKo5Hozq85B0HeLeRkkBPDS2D4udVpc=;
        b=k8cQwfO36ZtPtGUbWenppmps/TLlT9Vj1V2C38FMwfdT346zukKqiKfE5BJRGmrjPl
         h4BsBZt2z/XAGI1H1/lmjOxrz+JVpQchIP5Q4nDKAmMHca2yDCH3YtZleaKLz+ODyHwy
         s4gHAW/FKwzHJuZZYelvYLdZVjNTbCYjAcANk+G6kny/T8ibJQ+bvNK1Oe4af8HWK0n/
         9MMmK+rrRWvtw12Ioq9b4Xm/irUuZdfWMuYJClIxEa+IhiYez1W6OAPVGdp1USc6gmsA
         8j7iJlIRwaX8JsoL7RBnTXcB/lsR+9Ed+mGymoWWz40crTABBSK5Fnn0WARnbQ+45Wpp
         3ZtQ==
X-Gm-Message-State: AOAM532h6qe1AwsWSAfvb/CnAaZo71AUkQdakqqIYMYvkWQJ+ANrMBrE
        i/slHG3gsQUpdcr+5Fkhb9nfC5+vxENOaC69/lp/fg==
X-Google-Smtp-Source: ABdhPJxKSqtyl0o+pvbmKf+fb+exvUTdFnWUExhEucKQctuvn9gWtRum1R6QxOlJfzhIwKgMaYwPOvGjRtTq/GguPHc=
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr1364137wrt.249.1590114805419;
 Thu, 21 May 2020 19:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <ef994ce9-ccd8-e9c9-9838-049a62a3a561@intel.com>
In-Reply-To: <ef994ce9-ccd8-e9c9-9838-049a62a3a561@intel.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 May 2020 10:33:13 +0800
Message-ID: <CABVgOSnj6H5UXNGktT2NAHPF1KxAu5=Mg0hyuBu+NpjAdh+Q4A@mail.gmail.com>
Subject: Re: Kunit get 0 tests when run defconfig in Debian9
To:     kernel test robot <yidingx.liu@intel.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks for checking KUnit out =E2=80=94 it's a shame it hasn't worked
out-of-the-box here.

I'm not sure off the top of my head what could be wrong here: as you
note, there are no obvious errors. My suspicion is that it's either
some strange incompatibility with UML, or something is not quite right
with the config being generated and used.

A few questions/suggestions:
- Are there any test results visible when running
./tools/testing/kunit/kunit.py run --raw_output  (older versions of
the KUnit parser may not work well if the kernel log is decorated,
e.g. with timestamps, etc =E2=80=94 this should be largely fixed for 5.7).
- If not, does running the built UML kernel manually work, and if so
does it print any test results? This should be as simple as running
"./vmlinux". On some older host kernels, UML may not boot if built
statically and KASLR is in its strictest mode. This shouldn't be the
case here, but running "setarch `uname -m` -R ./vmlinux" may help if
some weirder issues show up.
- Does the .config actually have CONFIG_KUNIT_TEST=3Dy and
CONFIG_KUNIT_EXAMPLE_TEST=3Dy? kunit.py will keep its .config around, so
you can check it after running kunit.py run. It'll also preserve any
config changes you make that don't conflict with the .kunitconfig, so
you could try (for example), also enabling CONFIG_LIST_KUNIT_TEST to
see if it's a problem specific to those tests.
- Finally, running 'make ARCH=3Dum defconfig' before running kunit.py
run may help clean up any residual config that could be causing
problems.
- Otherwise, I'm not sure what could be going wrong. Are you running
on x86_64? UML doesn't support non-x86 architectures, and while the
32-bit stuff worked last I checked, it's not tested as regularly at
present.

Of course, it's also possible to run tests without UML or the kunit.py
script as well, by either building them into a kernel, and reading the
results from the log on startup, or building the tests as modules,
modprobing them, and reading the results from
/sys/kernel/debug/kunit/<test-suite>/results. That's obviously a bit
less convenient than the script, but may fit better into existing test
infrastructure, and can sidestep any UML issues.

Hope that helps!

Cheers,
-- David

On Thu, May 21, 2020 at 1:57 PM kernel test robot <yidingx.liu@intel.com> w=
rote:
>
> Hi, all.
>
>
> I met a strange problem that kunit run 0 tests in Debian9.
>
>
> Env:
>
> ```
>
> root@lkp-hsw-ep4 ~/linus# head /etc/os-release
> PRETTY_NAME=3D"Debian GNU/Linux 9 (stretch)"
> NAME=3D"Debian GNU/Linux"
> VERSION_ID=3D"9"
> VERSION=3D"9 (stretch)"
> ID=3Ddebian
>
> root@lkp-hsw-ep4 ~/linus# uname -r
> 5.6.0
>
> ```
>
>
> Reproduce: Just run `./tools/testing/kunit/kunit.py run --defconfig`
>
> ```
>
> root@lkp-hsw-ep4 ~/linus# ./tools/testing/kunit/kunit.py run --defconfig
> [13:41:30] Building KUnit Kernel ...
> [13:41:33] Starting KUnit Kernel ...
> [13:41:33] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [13:41:33] Testing complete. 0 tests run. 0 failed. 0 crashed.
> [13:41:33] Elapsed time: 2.619s total, 0.002s configuring, 2.610s
> building, 0.007s running
>
> root@lkp-hsw-ep4 ~/linus# cat .kunitconfig
> CONFIG_KUNIT=3Dy
> CONFIG_KUNIT_TEST=3Dy
> CONFIG_KUNIT_EXAMPLE_TEST=3Dy
>
> ```
>
>
> As doc said, looks like everything worked correctly.  But kunit run 0 tes=
ts.
>
> ```
>
> If everything worked correctly, you should see the following:
>
> Generating .config ...
> Building KUnit Kernel ...
> Starting KUnit Kernel ...
>
> ```
>
>
>
> --
> Best regards.
> Liu Yiding
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/ef994ce9-ccd8-e9c9-9838-049a62a3a561%40intel.com.
