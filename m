Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F58878107C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 18:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377403AbjHRQio (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 12:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353174AbjHRQif (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 12:38:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA3F2D64;
        Fri, 18 Aug 2023 09:38:33 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 630526607258;
        Fri, 18 Aug 2023 17:38:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692376712;
        bh=wYXWB64vP9MHbA9YsX2sIrZYXtG9eZ1Y78OopvZpXug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PueYigDL2xTwIYAAxEvjHxvQiS7LhuApF2rKDmUDHdBWGxJNHp5liBXT7uTTysach
         XvCFyIV19G3w3cXfeaUFJgPkPzrDxf0bAenfccRtDZYHIAcpTFdnuuoFTDN53k3IMx
         pY77fYp/Dx3R+Vk3K5j37yZWkjaQK8/phH7JeIC0WDxBObx2q9SGzMqA75GOe/Y9PH
         0nLvmpE03DcGNff+FqBBjQdOXGvxeqaBGtxl1uRilB6+KdZLcWy66oh7JnNCDFF3gX
         FN+7o/mMMzvMEod5PubStA+S+2njlsB6VcY4OTf3JfYxKOcqNeN28KspNJuPDWidbs
         nYoQNkm4rv8qw==
Date:   Fri, 18 Aug 2023 12:38:26 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        kernelci@lists.linux.dev, Guenter Roeck <groeck@chromium.org>,
        kernel@collabora.com, Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/3] kselftest: Add new test for detecting unprobed
 Devicetree devices
Message-ID: <12afe9a4-6d5c-4a0f-b5f8-6db346f60d08@notapiano>
References: <20230817233635.2306377-1-nfraprado@collabora.com>
 <20230817233635.2306377-4-nfraprado@collabora.com>
 <CAL_JsqLyimRvcnL_O8sMB8SnezXv3Z431VckMC-26w-aT1nYmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLyimRvcnL_O8sMB8SnezXv3Z431VckMC-26w-aT1nYmQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 18, 2023 at 10:05:00AM -0500, Rob Herring wrote:
> On Thu, Aug 17, 2023 at 6:36 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
[..]
> >  tools/testing/selftests/Makefile              |  1 +
> >  tools/testing/selftests/dt/.gitignore         |  1 +
> >  tools/testing/selftests/dt/Makefile           | 21 +++++
> 
> Please add this path to DT maintainers entry.

OK.

> 
> >  .../selftests/dt/compatible_ignore_list       |  1 +
> >  tools/testing/selftests/dt/ktap_helpers.sh    | 57 +++++++++++++
> 
> As Mark said, looks common.

Yes, I'll move it one folder up.

> 
[..]
> > --- /dev/null
> > +++ b/tools/testing/selftests/dt/.gitignore
> > @@ -0,0 +1 @@
> > +compatible_list
> 
> Not sure on the selftests, but is this enough that it gets cleaned?

I've just double-checked that compatible_list does get removed with make clean.
Not because it is in this gitignore, but because it is listed in TEST_GEN_FILES
in the Makefile.

> 
[..]
> > --- /dev/null
> > +++ b/tools/testing/selftests/dt/test_unprobed_devices.sh
[..]
> > +PDT=/proc/device-tree/
> 
> This is considered the legacy path though we will probably never get
> rid of it. Use the sysfs path instead.

The /sys/firmware/devicetree/* entry in
Documentation/ABI/testing/sysfs-firmware-ofw reads:

Userspace must not use the /sys/firmware/devicetree/base
path directly, but instead should follow /proc/device-tree
symlink. It is possible that the absolute path will change
in the future, but the symlink is the stable ABI.

So is this information outdated?

> 
[..]
> > +nodes_compatible=$(
> > +       for node_compat in $(find ${PDT} -name compatible); do
> > +               node=$(dirname "${node_compat}")
> > +               # Check if node is available
> > +               [[ -e "${node}"/status && $(tr -d '\000' < "${node}"/status) != "okay" ]] && continue
> 
> Note that "ok" is accepted by the kernel and does show up some. But
> for your use, probably okay as is.

Right, good point. Actually I think we should probably check for "ok" here as
well. Even though it's not valid based on the spec and not used in any upstream
Devicetree anymore, it's still supported by the kernel. If this test was to be
run with older or downstream Devicetrees, it should still detect that a node
with 'status = "ok"' is not having its driver probed, rather than ignore it.

Thanks,
Nícolas

> 
[..]
