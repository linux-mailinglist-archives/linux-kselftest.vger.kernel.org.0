Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641A57E4C63
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 00:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjKGXC7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 18:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjKGXC6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 18:02:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F71410C8;
        Tue,  7 Nov 2023 15:02:55 -0800 (PST)
Received: from notapiano (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CFE8366074D8;
        Tue,  7 Nov 2023 23:02:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699398173;
        bh=HNuFXAmcr38Mjsj1EcQwzGsMmMNd5OK9/yCfyVW4N7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nT+oFqWTGc+4wcTmMdloWWi/XInr7UbLO36ivjlKIj541/njlF6/1JmYBN/9SdZXF
         KLSi6IH9AO5SU9we2nGYDD7XiN9ovEDl9BeJPMFKLiX9JF79hgHfT3mn3jDqzlelKx
         crgKKPLIm8Hgju51OfnZ9/R9lVg4TXpWQoa5y7m0WBlD8vrJGg/VlMBG9d4Ubmnz+9
         K+vo2TLj9Q9w6CR/9W1rZsHX+9RnCjHSbodX4wN3Z1FEIdwyEh03iOEuXHdyotN7fw
         U82ZVuC2fE8Wh45D+BNIunm8YuRvMZ477t4NNemoQWYA5ypwIi6kPcjhBXBQHOhwe+
         9LxEOu/MGP6/w==
Date:   Tue, 7 Nov 2023 18:02:47 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Aishwarya TCV <aishwarya.tcv@arm.com>,
        kernelci@lists.linux.dev, kernel@collabora.com,
        Guenter Roeck <groeck@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3 3/3] kselftest: Add new test for detecting unprobed
 Devicetree devices
Message-ID: <59bca032-2657-46a8-9070-7528ffcc3e28@notapiano>
References: <20230828211424.2964562-1-nfraprado@collabora.com>
 <20230828211424.2964562-4-nfraprado@collabora.com>
 <e90cb52f-d55b-d3ba-3933-6cc7b43fcfbc@arm.com>
 <CA+G9fYsbq28w7m-sf6LhMscXHdPs0cGXU7kK6YzjKdUFKuQ+6A@mail.gmail.com>
 <e72e144a-c617-4a9e-adfb-e25ddabeb4c7@sirena.org.uk>
 <CAL_JsqL-3O6omPf4HcPFctgid+br04QW5p81qDx0CPMqh_eXTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL-3O6omPf4HcPFctgid+br04QW5p81qDx0CPMqh_eXTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 06, 2023 at 11:09:44AM -0600, Rob Herring wrote:
> On Thu, Nov 2, 2023 at 12:36 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Thu, Nov 02, 2023 at 07:15:58PM +0530, Naresh Kamboju wrote:
> > > On Thu, 2 Nov 2023 at 17:41, Aishwarya TCV <aishwarya.tcv@arm.com> wrote:
> >
> > > > https://storage.kernelci.org/mainline/master/v6.6-9152-gdeefd5024f07/arm64/defconfig%2Bkselftest/gcc-10/logs/kselftest.log
> >
> > ...
> >
> > > May be due to, A loop of symlinks that are pointing to self / same files ?
> >
> > Right, it does look like something bad is going on with symlinks:
> >
> > > > '/tmp/kci/linux/tools/testing/selftests/../../../build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/build/source/tools/testing/selftests/powerpc/vphn/vphn.c'
> >
> > > Please build by using tuxmake and validate builds are working.
> >
> > Note that tuxmake does an in tree build of kselftest:
> >
> >   make --silent --keep-going --jobs=8 O=/home/tuxbuild/.cache/tuxmake/builds/1/build INSTALL_PATH=/home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest_install ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- 'CC=sccache aarch64-linux-gnu-gcc' 'HOSTCC=sccache gcc' kselftest-install
> >
> > and does it's own tarball build too, whereas kernelci does an out of
> > tree build and uses kselftest-gen_tar:
> >
> >   make KBUILD_BUILD_USER=KernelCI FORMAT=.xz ARCH=arm64 HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- CC="ccache aarch64-linux-gnu-gcc" O=/tmp/kci/linux/build -C/tmp/kci/linux -j10 kselftest-gen_tar
> >
> > and that the error is in the dt-extract-compatibles program which is
> > part of the kernel (well, imported into the kernel from dtc upstream):
> >
> >   File "/tmp/kci/linux/tools/testing/selftests/../../../scripts/dtc/dt-extract-compatibles", line 107, in <module>
> >     compat_ignore_list.extend(parse_compatibles_to_ignore(f))
> >
> > This all suggests that something to do with how the build is set up is
> > resulting in the source symlink that gets created for out of tree builds
> > blowing up, I guess it's not specifically the DT stuff that's blowing it
> > up but rather that it's tripping over an existing bug.  Really does look
> > like a legitimate bug though, the source link is set up by the in tree
> > kernel build infrastructure.
> >
> > I did poke a bit at reproducing outside of the KernelCI scripts but
> > didn't manage to yet.
> 
> I can repro with "make dt_compatible_check". The problem is with an
> 'out of tree' build within the tree. That's my normal setup, but the
> difference is I have ".build" directories. If I use "build" instead,
> then I can repro. The issue is the iglob will recurse into "build" but
> not hidden directories (by default). There's no option to not follow
> symlinks which would solve this (there is an open python issue since
> 2017 to add it). I don't see a simple solution in python other than
> getting a full list with glob(), convert to absolute paths, and remove
> duplicates. I imagine that will be somewhat slow.

Hi, sorry for the delay, I was on vacation last week.

I was able to reproduce the issue the way you described. And I also suspected
an alternative approach would be slower, but after trying it out it ran just as
fast as the current one, even on cold cache, so I sent it out:

https://lore.kernel.org/all/20231107225624.9811-1-nfraprado@collabora.com

Let me know your thoughts there.

Thanks,
Nícolas
