Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28B4F63D2
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiDFPt6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Apr 2022 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbiDFPse (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Apr 2022 11:48:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37754282532;
        Wed,  6 Apr 2022 06:08:32 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KYPrK32NKz67xGv;
        Wed,  6 Apr 2022 21:05:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 15:08:18 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 14:08:17 +0100
Date:   Wed, 6 Apr 2022 14:08:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [RFC v1 08/10] iio: light: vcnl4000: add roadtest
Message-ID: <20220406140816.000038ce@Huawei.com>
In-Reply-To: <20220405134805.GA28574@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
        <20220311162445.346685-9-vincent.whitchurch@axis.com>
        <20220320170253.5b946c84@jic23-huawei>
        <20220405134805.GA28574@axis.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 5 Apr 2022 15:48:05 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> On Sun, Mar 20, 2022 at 06:02:53PM +0100, Jonathan Cameron wrote:
> > Very interesting bit of work. My current approach for similar testing
> > is to write a qemu model for the hardware, but that currently
> > requires carefully crafted tests. Most of the time I'm only doing
> > that to verify refactoring of existing drivers.   
> 
> Thank you for taking a look!
> 
> > One thing that makes me nervous here is the python element though
> > as I've not written significant python in about 20 years.
> > That is going to be a burden for kernel developers and maintainers...
> > Nothing quite like badly written tests to make for a mess in the long run
> > and I suspect my python for example would be very very badly written :)  
> 
> There's a bunch of static checkers to ensure that the code follows some
> basic guidelines, and CI can check that the tests work consistently, and
> also calculate metrics such as test execution time and code coverage, so
> even non-idiomatic Python in the tests wouldn't be entirely broken.
> 
> And unlike driver code, if the tests for a particular driver later do
> turn out to be bad (in what way?), we could just throw those particular
> tests out without breaking anybody's system.

True.  Though CI test triage folk may disagree ;)

> 
> > Cut and paste will of course get us a long way...  
> 
> Isn't some amount of copy/paste followed by modification to be expected
> even if the framework is written in say C (just as there's already
> copy/paste + modification involved when writing drivers)?
> 
> As for the core logic of individual driver tests excluding the framework
> bits, I have a hard time imagining what Python syntax looks like to
> someone with no knowledge of Python, so yes, I guess it's going to be
> harder to review.

I messed around the other day with writing tests for
drivers/staging/iio/cdc/ad7746.c and wasn't "too bad" and was useful for
verifying some refactoring (and identified a possible precision problem
in some integer approximation of floating point calcs)
I'll try and find time to flesh that test set out more in the near future and
post it so you can see how bad my python is. It amused my wife if nothing
else :)

However a future project is to see if I can use this to hook up the SPDM
attestation stack via mctp over i2c - just because I like to live dangerously :)

For IIO use more generally we need a sensible path to SPI (and also platform
drivers).  For my day job I'd like to mess around with doing PCI devices
as well.  The PCI DOE support for example would be nice to run against a
test set that doesn't involve spinning up QEMU.
DOE driver support:
https://lore.kernel.org/all/20220330235920.2800929-1-ira.weiny@intel.com/

Effort wise, it's similar effort to hacking equivalent in QEMU but with the
obvious advantage of being in tree and simpler for CI systems etc to use.

It would be nice to only have to use QEMU for complex system CI tests
like the ones we are doing for CXL.

> 
> > I dream of a world where every driver is testable by people with out hardware
> > but I fear it may be a while yet.  Hopefully this will get us a little
> > closer!
> > 
> > I more or less follow what is going on here (good docs btw in the earlier
> > patch definitely helped).
> > 
> > So far I'm thoroughly in favour of road test subject to actually being
> > able to review the tests or getting sufficient support to do so.
> > It's a 'how to scale it' question really...  
> 
> Would rewriting the framework in C and forcing tests to be written in
> that language mean that maintainers would be able to review tests
> without external support?

I was wondering that.  If we stayed in python I think we'd definitely want
someone to be the 'roadtester/tests' maintainer (or group of maintainers) 
and their Ack to be expected for all tests we upstream.  Idea being they'd
sanity check correct use of framework and just how bad the python code
us C developers are writing is ;)

However, we'd still need a good chunk of that 'framework' use review even
if doing this in C.

Anyhow, very promising bit of work.

Thanks,

Jonathan




