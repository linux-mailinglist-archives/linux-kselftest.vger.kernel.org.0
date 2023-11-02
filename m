Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCD07DF43C
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 14:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376610AbjKBNqS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 09:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376666AbjKBNqR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 09:46:17 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AC9185
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Nov 2023 06:46:10 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-457dc26ec2eso447086137.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Nov 2023 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698932770; x=1699537570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJhHm2XHGMd0cXtLzgcvnKoFChgDo5Gjqf+1+H8tOko=;
        b=zMFY9vahLvaORYmKehb5tIIV+Vj0CxaV274MXSF9gCgZj6KCVX5C+vIxNbOTFRG6EX
         mpTZ4x98r4bzgiU+uoiYXZYTiKJfnVX2JeHxs+6OgfJKy86LWO7M9RX3aZe0uahtdG8q
         28DYoyFRLkDMAZday/hA76PchlgPYe/xVD2WswY0D95v5CBfMzp1nGEaOHn2K5IURu2Q
         iXW4+l/sUMSorlK8D9q8plDlVq//6PJvjpobzMEKOthCQXo0nJIaL1YVZY4on3NaeFvP
         AWjRE/YLMwEsBtSq1jlSou4SRqoKIkf2+mQdiUBB1jvwdSrmEQe/Y61gBvVCNOaj9yDl
         TOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932770; x=1699537570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJhHm2XHGMd0cXtLzgcvnKoFChgDo5Gjqf+1+H8tOko=;
        b=vJwRPyFOrkKrTnhw0FKy81geRMqBX97Q76VbtWfWPoLj4FmOvr8hqQTm5vZLrPhUP3
         mAGR75ci0t7ORUJqS1AlFxJSwhjnxMJ+WU/QMDr8BWYgP9Nol7DC43DR0+eOOJXvQ+l8
         4f/6suQLMCAkcPMAkc97uQ+vecjlIcRWL8BKbkqc85usB1Fwlj7RX1u+E5aPM0xWtW9k
         AQ4M62SZYtJ/J8CAkkiPruAC2xY91LKYZ/UEk7iHsMiUHQIrXof2iUk/t9W9dYhQI4IA
         tXuS/LHBQc5vWqVaixuS92/ewlQjWMvJMCMF9IzgVsm+rOMvuOMyXFRsOU/rTyz1Yriu
         SKWA==
X-Gm-Message-State: AOJu0YwwTpF2cpUwyrhziPmpVGS0AthbApkike2x6HlZ/EuNkll2jg7u
        4RvCA6jsPiqcmI8wAypxf9Js85fsu/z6NQixLauAlQ==
X-Google-Smtp-Source: AGHT+IE3+bEozoJdnZ59uxYB6mWfKI1iSnVC64atBxRf2N39zd2ZRJUat2R/g4PSKasOK/8DHc/jAmBDp8E5SnFFvME=
X-Received: by 2002:a67:e092:0:b0:45d:56e0:7178 with SMTP id
 f18-20020a67e092000000b0045d56e07178mr2224367vsl.2.1698932769829; Thu, 02 Nov
 2023 06:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230828211424.2964562-1-nfraprado@collabora.com>
 <20230828211424.2964562-4-nfraprado@collabora.com> <e90cb52f-d55b-d3ba-3933-6cc7b43fcfbc@arm.com>
In-Reply-To: <e90cb52f-d55b-d3ba-3933-6cc7b43fcfbc@arm.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Nov 2023 19:15:58 +0530
Message-ID: <CA+G9fYsbq28w7m-sf6LhMscXHdPs0cGXU7kK6YzjKdUFKuQ+6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kselftest: Add new test for detecting unprobed
 Devicetree devices
To:     Aishwarya TCV <aishwarya.tcv@arm.com>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        kernelci@lists.linux.dev, kernel@collabora.com,
        Guenter Roeck <groeck@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Aishwarya,

On Thu, 2 Nov 2023 at 17:41, Aishwarya TCV <aishwarya.tcv@arm.com> wrote:
>
>
>
> On 28/08/2023 22:13, N=C3=ADcolas F. R. A. Prado wrote:
> > Introduce a new kselftest to detect devices that were declared in the
> > Devicetree, and are expected to be probed by a driver, but weren't.
> >
> > The test uses two lists: a list of compatibles that can match a
> > Devicetree device to a driver, and a list of compatibles that should be
> > ignored. The first is automatically generated by the
> > dt-extract-compatibles script, and is run as part of building this test=
.
> > The list of compatibles to ignore is a hand-crafted list to capture the
> > few exceptions of compatibles that are expected to match a driver but
> > not be bound to it.
> >
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> >
>
> Hi Nicolas,
>
> Currently when building kselftest against next-master and
> mainline-master the below build error is observed. A bisect (full log
> below) identified this patch as introducing the failure.
>
> Full log from a failure:
>
> https://storage.kernelci.org/mainline/master/v6.6-9152-gdeefd5024f07/arm6=
4/defconfig%2Bkselftest/gcc-10/logs/kselftest.log
>
> make[4]: Entering directory '/tmp/kci/linux/tools/testing/selftests/dt'
> /tmp/kci/linux/tools/testing/selftests/../../../scripts/dtc/dt-extract-co=
mpatibles
> -d /tmp/kci/linux/tools/testing/selftests/../../.. >
> /tmp/kci/linux/build/kselftest/dt/compatible_list
> Traceback (most recent call last):
>   File
> "/tmp/kci/linux/tools/testing/selftests/../../../scripts/dtc/dt-extract-c=
ompatibles",
> line 107, in <module>
>     compat_ignore_list.extend(parse_compatibles_to_ignore(f))
>   File
> "/tmp/kci/linux/tools/testing/selftests/../../../scripts/dtc/dt-extract-c=
ompatibles",
> line 67, in parse_compatibles_to_ignore
>     with open(file, 'r', encoding=3D'utf-8') as f:
> OSError: [Errno 40] Too many levels of symbolic links:

OSError: [Errno 40] Too many levels of symbolic links:
This is not related to selftests/dt tests build.

May be due to, A loop of symlinks that are pointing to self / same files ?

> '/tmp/kci/linux/tools/testing/selftests/../../../build/source/build/sourc=
e/build/source/build/source/build/source/build/source/build/source/build/so=
urce/build/source/build/source/build/source/build/source/build/source/build=
/source/build/source/build/source/build/source/build/source/build/source/bu=
ild/source/build/source/build/source/build/source/build/source/build/source=
/build/source/build/source/build/source/build/source/build/source/build/sou=
rce/build/source/build/source/build/source/build/source/build/source/build/=
source/build/source/build/source/build/source/tools/testing/selftests/power=
pc/vphn/vphn.c'
> make[4]: *** [Makefile:12:
> /tmp/kci/linux/build/kselftest/dt/compatible_list] Error 1
> make[4]: Leaving directory '/tmp/kci/linux/tools/testing/selftests/dt'

Here is the log showing selftests/dt build pass for arm64 build from
Linux next master branch.

Links to the successful build and kselftest.tar file shared below [1].

Build log:
=3D=3D=3D=3D=3D=3D=3D=3D
make[4]: Entering directory 'tools/testing/selftests/dt'
tools/testing/selftests/../../../scripts/dtc/dt-extract-compatibles -d
tools/testing/selftests/../../.. >
/home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/dt/compatible_list
make[4]: Leaving directory 'tools/testing/selftests/dt

Please build by using tuxmake and validate builds are working.

steps to reproduce:
=3D=3D=3D=3D=3D=3D
#!/bin/sh

# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake to your home directory at ~/.local/bin:
# pip3 install -U --user tuxmake
#
# Or install a deb/rpm depending on the running distribution
# See https://tuxmake.org/install-deb/ or
# https://tuxmake.org/install-rpm/
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.
# tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig defconfig --kconfig-add
https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-k=
ernel/linux/files/systemd.config
--kconfig-add CONFIG_BCMGENET=3Dy --kconfig-add
tools/testing/selftests/cgroup/config --kconfig-add
tools/testing/selftests/cpufreq/config --kconfig-add
tools/testing/selftests/efivarfs/config --kconfig-add
tools/testing/selftests/filesystems/binderfs/config --kconfig-add
tools/testing/selftests/filesystems/fat/config --kconfig-add
tools/testing/selftests/firmware/config --kconfig-add
tools/testing/selftests/ftrace/config --kconfig-add
tools/testing/selftests/gpio/config --kconfig-add
tools/testing/selftests/ipc/config --kconfig-add
tools/testing/selftests/memfd/config dtbs dtbs-legacy headers kernel
kselftest modules


tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2XYjd2yxHi=
ay3gVALCGpAch4G8o/config
dtbs dtbs-legacy headers kernel kselftest modules


Build links:
 [1] https://storage.tuxsuite.com/public/linaro/lkft/builds/2XYjd2yxHiay3gV=
ALCGpAch4G8o/

- Naresh
