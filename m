Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D563C7A8E1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 23:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjITVBM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 17:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjITVBM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 17:01:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D18D3;
        Wed, 20 Sep 2023 14:01:04 -0700 (PDT)
Received: from notapiano (unknown [185.213.155.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4A88D6607243;
        Wed, 20 Sep 2023 22:01:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695243662;
        bh=Rtz3erKyUOgKqZM9Fh/lnQavTB+Wa5RuboyAzdxYPLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EjtNw7g2/rRrUYorNvkEqpKPwq+RWcONPEdiiyLA/JzNV4qLkpq1ko4v9iaU9EwSz
         UT0TDFmRA07pEn24u2Wyb37LLo2PqvxnpDLaLjhUPoghKY5cKOQtMyogxRe3dDqV0q
         gROtD6w1u4K2iV1be/a2j/ptDKVwQzqhWF30lr1iMR1yvf1SLDLmkyTeLeurVIn+CR
         Tx3ihWbL2GL6Qe5ZQi+LFsKhmcoX4V5WQI9KmRvR5rFWXhUzsUvEOUjorwg/zbrKsh
         Ca5fLcRW/meo/Z5i74tx+xE3mJ37WPHtDwKMzW5gYsOGI6RV1WnzOMihTDT26wnl2o
         2UejAn5V85png==
Date:   Wed, 20 Sep 2023 17:00:56 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        kernelci@lists.linux.dev, kernel@collabora.com,
        Guenter Roeck <groeck@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add a test to catch unprobed Devicetree devices
Message-ID: <368a1fc3-02d7-49f2-a881-f39259f8c186@notapiano>
References: <20230828211424.2964562-1-nfraprado@collabora.com>
 <97c368a1-9c76-490a-848e-eacd6411e810@notapiano>
 <20230920195629.GA2784994-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920195629.GA2784994-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 02:56:29PM -0500, Rob Herring wrote:
> On Wed, Sep 20, 2023 at 10:03:06AM -0400, N�colas F. R. A. Prado wrote:
> > On Mon, Aug 28, 2023 at 05:13:09PM -0400, N�colas F. R. A. Prado wrote:
> > > 
> > > Regressions that cause a device to no longer be probed by a driver can
> > > have a big impact on the platform's functionality, and despite being
> > > relatively common there isn't currently any generic test to detect them.
> > > As an example, bootrr [1] does test for device probe, but it requires
> > > defining the expected probed devices for each platform.
> > > 
> > > Given that the Devicetree already provides a static description of
> > > devices on the system, it is a good basis for building such a test on
> > > top.
> > > 
> > > This series introduces a test to catch regressions that prevent devices
> > > from probing.
> > > 
> > > Patches 1 and 2 extend the existing dt-extract-compatibles to be able to
> > > output only the compatibles that can be expected to match a Devicetree
> > > node to a driver. Patch 2 adds a kselftest that walks over the
> > > Devicetree nodes on the current platform and compares the compatibles to
> > > the ones on the list, and on an ignore list, to point out devices that
> > > failed to be probed.
> > > 
> > > A compatible list is needed because not all compatibles that can show up
> > > in a Devicetree node can be used to match to a driver, for example the
> > > code for that compatible might use "OF_DECLARE" type macros and avoid
> > > the driver framework, or the node might be controlled by a driver that
> > > was bound to a different node.
> > > 
> > > An ignore list is needed for the few cases where it's common for a
> > > driver to match a device but not probe, like for the "simple-mfd"
> > > compatible, where the driver only probes if that compatible is the
> > > node's first compatible.
> > > 
> > > The reason for parsing the kernel source instead of relying on
> > > information exposed by the kernel at runtime (say, looking at modaliases
> > > or introducing some other mechanism), is to be able to catch issues
> > > where a config was renamed or a driver moved across configs, and the
> > > .config used by the kernel not updated accordingly. We need to parse the
> > > source to find all compatibles present in the kernel independent of the
> > > current config being run.
> > > 
> > > [1] https://github.com/kernelci/bootrr
> > > 
> > > Changes in v3:
> > > - Added DT selftest path to MAINTAINERS
> > > - Enabled device probe test for nodes with 'status = "ok"'
> > > - Added pass/fail/skip totals to end of test output
> > > 
> > > Changes in v2:
> > > - Extended dt-extract-compatibles script to be able to extract driver
> > >   matching compatibles, instead of adding a new one in Coccinelle
> > > - Made kselftest output in the KTAP format
> > > 
> > > N�colas F. R. A. Prado (3):
> > >   dt: dt-extract-compatibles: Handle cfile arguments in generator
> > >     function
> > >   dt: dt-extract-compatibles: Add flag for driver matching compatibles
> > >   kselftest: Add new test for detecting unprobed Devicetree devices
> > > 
> > >  MAINTAINERS                                   |  1 +
> > >  scripts/dtc/dt-extract-compatibles            | 74 +++++++++++++----
> > >  tools/testing/selftests/Makefile              |  1 +
> > >  tools/testing/selftests/dt/.gitignore         |  1 +
> > >  tools/testing/selftests/dt/Makefile           | 21 +++++
> > >  .../selftests/dt/compatible_ignore_list       |  1 +
> > >  tools/testing/selftests/dt/ktap_helpers.sh    | 70 ++++++++++++++++
> > >  .../selftests/dt/test_unprobed_devices.sh     | 83 +++++++++++++++++++
> > >  8 files changed, 236 insertions(+), 16 deletions(-)
> > >  create mode 100644 tools/testing/selftests/dt/.gitignore
> > >  create mode 100644 tools/testing/selftests/dt/Makefile
> > >  create mode 100644 tools/testing/selftests/dt/compatible_ignore_list
> > >  create mode 100644 tools/testing/selftests/dt/ktap_helpers.sh
> > >  create mode 100755 tools/testing/selftests/dt/test_unprobed_devices.sh
> > 
> > Hi Rob,
> > 
> > gentle ping on this series.
> > 
> > I take it you'll be merging this through your tree, so I've added Shuah's R-b
> > that she supplied on v2 for the kselftest patch.
> 
> Sorry, now applied.
> 
> If you send something before or in the merge window, it is best to 
> rebase and resend after rc1 comes out.

Ah didn't know about that, will keep it in mind for the future, thanks!

N�colas
