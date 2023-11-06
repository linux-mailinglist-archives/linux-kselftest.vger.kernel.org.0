Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410507E2AB0
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 18:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjKFRKD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 12:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjKFRKB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 12:10:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9C1D6B;
        Mon,  6 Nov 2023 09:09:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4302DC433CC;
        Mon,  6 Nov 2023 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699290598;
        bh=UFzUofNNLBASgkPIJgDuNdjyCEGP5bQHseuE8TRa7W0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hQaJvupT4KjzsBJdf632gxvpFt08jPP2HUDi32DeJFMsVaQqfn9+Ll6lnsXFhbVsU
         +b+Uav8d70GJwoVLBcWGbauVZbqJyurllHJlodYjkF6SDrEnGz3fnAOCBkBac+VmM2
         phkpuBXi7HP8IMxpaip3rkmLqlZcM7mVARX6ASdBtDbHE+vnJaf+kRheCDZAmVo1ON
         luwtZETkz9Wbr8zxDVN1wz4WWSh0J+fC7LZ4QWtWv/MT1K/1X5AcAZwsLPk40G7sB1
         iEPNu4LejFDtl2mkefC5ZDw8eZsClBKglllw9L+IK68px2zWyh4hNO2BAaNrlk34XZ
         7xZTEWkPoai4w==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50970c2115eso1670521e87.1;
        Mon, 06 Nov 2023 09:09:58 -0800 (PST)
X-Gm-Message-State: AOJu0Yw2IKqAJPS+2Fkxq0EZP056hMXrFq21oAH0ITMOhJQjMEefwdyV
        zs+mm5NpysbD2AMDQorVKJdP8yVbWhLP0ZXjbQ==
X-Google-Smtp-Source: AGHT+IGpMZ2uYxaFKvHqjpiuPBw5ga6h3w246K/OsJC2VAWaxh57/wBNpyznpCnRCwVbLEpl1hL6RVNZkRP/FNRR2yI=
X-Received: by 2002:ac2:53ab:0:b0:507:ce2f:8f0c with SMTP id
 j11-20020ac253ab000000b00507ce2f8f0cmr22254953lfh.35.1699290596382; Mon, 06
 Nov 2023 09:09:56 -0800 (PST)
MIME-Version: 1.0
References: <20230828211424.2964562-1-nfraprado@collabora.com>
 <20230828211424.2964562-4-nfraprado@collabora.com> <e90cb52f-d55b-d3ba-3933-6cc7b43fcfbc@arm.com>
 <CA+G9fYsbq28w7m-sf6LhMscXHdPs0cGXU7kK6YzjKdUFKuQ+6A@mail.gmail.com> <e72e144a-c617-4a9e-adfb-e25ddabeb4c7@sirena.org.uk>
In-Reply-To: <e72e144a-c617-4a9e-adfb-e25ddabeb4c7@sirena.org.uk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Nov 2023 11:09:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL-3O6omPf4HcPFctgid+br04QW5p81qDx0CPMqh_eXTg@mail.gmail.com>
Message-ID: <CAL_JsqL-3O6omPf4HcPFctgid+br04QW5p81qDx0CPMqh_eXTg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kselftest: Add new test for detecting unprobed
 Devicetree devices
To:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Aishwarya TCV <aishwarya.tcv@arm.com>,
        kernelci@lists.linux.dev, kernel@collabora.com,
        Guenter Roeck <groeck@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 2, 2023 at 12:36=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, Nov 02, 2023 at 07:15:58PM +0530, Naresh Kamboju wrote:
> > On Thu, 2 Nov 2023 at 17:41, Aishwarya TCV <aishwarya.tcv@arm.com> wrot=
e:
>
> > > https://storage.kernelci.org/mainline/master/v6.6-9152-gdeefd5024f07/=
arm64/defconfig%2Bkselftest/gcc-10/logs/kselftest.log
>
> ...
>
> > May be due to, A loop of symlinks that are pointing to self / same file=
s ?
>
> Right, it does look like something bad is going on with symlinks:
>
> > > '/tmp/kci/linux/tools/testing/selftests/../../../build/source/build/s=
ource/build/source/build/source/build/source/build/source/build/source/buil=
d/source/build/source/build/source/build/source/build/source/build/source/b=
uild/source/build/source/build/source/build/source/build/source/build/sourc=
e/build/source/build/source/build/source/build/source/build/source/build/so=
urce/build/source/build/source/build/source/build/source/build/source/build=
/source/build/source/build/source/build/source/build/source/build/source/bu=
ild/source/build/source/build/source/build/source/tools/testing/selftests/p=
owerpc/vphn/vphn.c'
>
> > Please build by using tuxmake and validate builds are working.
>
> Note that tuxmake does an in tree build of kselftest:
>
>   make --silent --keep-going --jobs=3D8 O=3D/home/tuxbuild/.cache/tuxmake=
/builds/1/build INSTALL_PATH=3D/home/tuxbuild/.cache/tuxmake/builds/1/build=
/kselftest_install ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- CROSS_CO=
MPILE_COMPAT=3Darm-linux-gnueabihf- 'CC=3Dsccache aarch64-linux-gnu-gcc' 'H=
OSTCC=3Dsccache gcc' kselftest-install
>
> and does it's own tarball build too, whereas kernelci does an out of
> tree build and uses kselftest-gen_tar:
>
>   make KBUILD_BUILD_USER=3DKernelCI FORMAT=3D.xz ARCH=3Darm64 HOSTCC=3Dgc=
c CROSS_COMPILE=3Daarch64-linux-gnu- CROSS_COMPILE_COMPAT=3Darm-linux-gnuea=
bihf- CC=3D"ccache aarch64-linux-gnu-gcc" O=3D/tmp/kci/linux/build -C/tmp/k=
ci/linux -j10 kselftest-gen_tar
>
> and that the error is in the dt-extract-compatibles program which is
> part of the kernel (well, imported into the kernel from dtc upstream):
>
>   File "/tmp/kci/linux/tools/testing/selftests/../../../scripts/dtc/dt-ex=
tract-compatibles", line 107, in <module>
>     compat_ignore_list.extend(parse_compatibles_to_ignore(f))
>
> This all suggests that something to do with how the build is set up is
> resulting in the source symlink that gets created for out of tree builds
> blowing up, I guess it's not specifically the DT stuff that's blowing it
> up but rather that it's tripping over an existing bug.  Really does look
> like a legitimate bug though, the source link is set up by the in tree
> kernel build infrastructure.
>
> I did poke a bit at reproducing outside of the KernelCI scripts but
> didn't manage to yet.

I can repro with "make dt_compatible_check". The problem is with an
'out of tree' build within the tree. That's my normal setup, but the
difference is I have ".build" directories. If I use "build" instead,
then I can repro. The issue is the iglob will recurse into "build" but
not hidden directories (by default). There's no option to not follow
symlinks which would solve this (there is an open python issue since
2017 to add it). I don't see a simple solution in python other than
getting a full list with glob(), convert to absolute paths, and remove
duplicates. I imagine that will be somewhat slow.

A simple solution would be instead of passing the source tree root to
dt-extract-compatibles, pass 'arch', 'drivers', and 'sound' instead.
There shouldn't be compatibles anywhere else.

Rob
