Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7E84EAF9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbiC2OwR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbiC2OwQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 10:52:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CB84DF4F;
        Tue, 29 Mar 2022 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=S+Tu0Dayg2CTLGhBbl0yg+lgxmDq6qIFjiz7b1KSHxM=;
        t=1648565433; x=1649775033; b=luoiZwb+tWrBpkhXN5hEJMnMh+15TqG7ksUZ7LkStX5WoCY
        OzpGNC7aRxwKABLZRLR5knBVrisB7NumgCrGs1tpZzvyAYciERjW9oBwNjZXT/pfNEjlkOHtDlzI9
        5UwGYhOwnQNZSseP0Fl65/swtIn2wrp3s0Ro6KCw1tRXVDTqaob7uT8nrzhuNRffxKUPUhPe/XxMC
        hRvShE/5O7LXMjBnedWOMZecqsLcN44n8jiLllpNJeMpuDOT97AlXhzPJcOCdQcLHOE/LQoKHzXdu
        Pqq5j+SJ+9IhRu6D79kUK3Sy86K1OUzRB3tVgBDqPMIkm3oq3IamSf4lpRozjloA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nZDAg-0021FO-OZ;
        Tue, 29 Mar 2022 16:50:10 +0200
Message-ID: <5b39d572e619c812109af7a1b8028bfb8353efda.camel@sipsolutions.net>
Subject: Re: [RFC v1 07/10] iio: light: opt3001: add roadtest
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Date:   Tue, 29 Mar 2022 16:50:09 +0200
In-Reply-To: <20220329144319.GA4474@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
         <20220311162445.346685-8-vincent.whitchurch@axis.com>
         <CAFd5g47O2PbqaUZRoioRROtywTm=6t7cVgHqO7qc0ZGewQk16A@mail.gmail.com>
         <20220318154927.GA32172@axis.com>
         <1e61b0f21794e67fb4e87dc41fab90829d3c7cd6.camel@sipsolutions.net>
         <20220329144319.GA4474@axis.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-03-29 at 16:43 +0200, Vincent Whitchurch wrote:
> 
> I'm aware of vhost-user, but AFAICS QEMU needs glue for each device type
> to be able to actually hook up vhost-user implementations to the devices
> it exposes to the guest via the virtio PCI device.  See e.g.
> hw/virtio/vhost-user-i2c-pci.c and hw/virtio/vhost-user-i2c.c in QEMU.

Oh, I wasn't aware of that.

> That is what I meant was missing for virtio-gpio, there seems to be an
> in-progress patch set for that here though:
>  https://lore.kernel.org/all/cover.1641987128.git.viresh.kumar@linaro.org/
> 
> Similarly, glue for something like arch/um/drivers/virt-pci.c does not
> exist in QEMU.
> 
> Or perhaps you are implying that hw/virtio/vhost-user-i2c* in QEMU are
> not strictly needed?

I _thought_ that was the case, but honestly, that was just from reading
about it, not looking at the code. Thinking about it though, I don't
need special glue in UML, just passing the device ID on the command
line? So not sure what they need the glue for. Looking at the code, it's
not really much though? Not sure, I guess you need somebody more
familiar with qemu here, sorry.

> > Wohoo! This makes me very happy, finally somebody else who uses it :-)
> 
> Yes, thanks for that feature, it works well to speed up tests and also
> has a knack for triggering race conditions (the RTC use-after-free for
> example).
> 
> Time travel however sometimes triggers some WARN_ONs from the core
> timekeeping code. I haven't seen them when running the test suites, but
> they show up if the system under UML is idle for several (wall time)
> seconds.  I haven't had a chance to investigate it further though, but I
> can dig up the splats if you are interested.

Oh, I haven't seen that, and I'm pretty sure I've had systems idle for
very long periods of time passing inside (think weeks) ...

So yeah, if you have some splats (ideally with corresponding kernel
configs), I'd be interested.

johannes
