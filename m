Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A524EAFA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 16:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbiC2OyI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 10:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbiC2OyI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 10:54:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7536552B1C;
        Tue, 29 Mar 2022 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2NzjsLMCWS6kvs1HxWmAi91eVW5hNB/fGRIqXrHzAoU=;
        t=1648565545; x=1649775145; b=ud7R0SyDx8hDXtu3YS+/+02Nuxc7jUYLAPPfAuLOnCpu64l
        RPFwsgOtF3NLDS5I3QyZpFI4mPA7LFRw4PEG3BSDCnK68J6oJS82rGOdkVFCQqdjwN9eEISbUHW5Z
        mskddHNTe0VuGogUifX9kPea0kSwUOnrbTqYhzxH8rQjWLAWp8c9bRhznz/suzwl44SBDmomreHO/
        8Zhbmke2vOTP6/pZHgoZah2GiXtaYAbljZxvu8rqQGxMKLQPKtDvkKo8GSii3I68FqRDHu7O9eLV7
        0i4jO/RWnYtuY6oHVo9FclxuYuR9LifTW7gQb4TperQ3Wm5V44zx3jsv6134YmsA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nZDCi-0021Ja-Bf;
        Tue, 29 Mar 2022 16:52:16 +0200
Message-ID: <10ef3f98ccc8d7c545fec5e8a7a832194797a3d6.camel@sipsolutions.net>
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
Date:   Tue, 29 Mar 2022 16:52:14 +0200
In-Reply-To: <5b39d572e619c812109af7a1b8028bfb8353efda.camel@sipsolutions.net>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
         <20220311162445.346685-8-vincent.whitchurch@axis.com>
         <CAFd5g47O2PbqaUZRoioRROtywTm=6t7cVgHqO7qc0ZGewQk16A@mail.gmail.com>
         <20220318154927.GA32172@axis.com>
         <1e61b0f21794e67fb4e87dc41fab90829d3c7cd6.camel@sipsolutions.net>
         <20220329144319.GA4474@axis.com>
         <5b39d572e619c812109af7a1b8028bfb8353efda.camel@sipsolutions.net>
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

On Tue, 2022-03-29 at 16:50 +0200, Johannes Berg wrote:
> > Or perhaps you are implying that hw/virtio/vhost-user-i2c* in QEMU are
> > not strictly needed?
> 
> I _thought_ that was the case, but honestly, that was just from reading
> about it, not looking at the code. Thinking about it though, I don't
> need special glue in UML, just passing the device ID on the command
> line? So not sure what they need the glue for. Looking at the code, it's
> not really much though? Not sure, I guess you need somebody more
> familiar with qemu here, sorry.
> 

So here
https://www.qemu.org/docs/master/system/devices/vhost-user.html#vhost-user-device

the docs say:

   These are simple stub devices that ensure the VirtIO device is
   visible to the guest. The code is mostly boilerplate although each
   device has a chardev option which specifies the ID of the --chardev
   device that connects via a socket to the vhost-user daemon.

So maybe if the ID were specified via the command line too, you could
have a generic vhost-user stub in qemu?

johannes
