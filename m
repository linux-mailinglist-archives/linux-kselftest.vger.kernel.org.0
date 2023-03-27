Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8F6CA435
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 14:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjC0MiV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 08:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjC0MiU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 08:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BECAF;
        Mon, 27 Mar 2023 05:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF5B861206;
        Mon, 27 Mar 2023 12:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916B3C433D2;
        Mon, 27 Mar 2023 12:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679920697;
        bh=KxbO7jAho7Gxlmbj4qdAOWGx1lnUEAI6qIGD0FU9SII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cad8Xbf1NAyZ5Rbhr2WBgcGtsvzvKx+StVK+y4x0TGIEQIcbR4YnaZPA5jcRVMgXN
         PXDjBbg94fIVx75JUxTqYvUpWs+oa0kfL1aJzpjDBKSBcyxtnUYm9ASAWFuIt/bZDh
         SDNHWnFLsw8Nzjtd8DXgbL4pIjjoHc1p33GUkb9E=
Date:   Mon, 27 Mar 2023 14:38:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 3/7] kunit: Add kunit wrappers for (root) device
 creation
Message-ID: <ZCGONl0mC8oyBj-0@kroah.com>
References: <cover.1679915278.git.mazziesaccount@gmail.com>
 <f2c7f7b04f7e4ee7b9cef73ecba672f5fa40eb73.1679915278.git.mazziesaccount@gmail.com>
 <ZCGFgypeuJXqNwQt@kroah.com>
 <e027fc0c-83e0-be6f-d62b-dac00ce9b761@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e027fc0c-83e0-be6f-d62b-dac00ce9b761@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 27, 2023 at 03:20:06PM +0300, Matti Vaittinen wrote:
> On 3/27/23 15:01, Greg Kroah-Hartman wrote:
> > On Mon, Mar 27, 2023 at 02:34:02PM +0300, Matti Vaittinen wrote:
> > > A few tests need to have a valid struct device. One such example is
> > > tests which want to be testing devm-managed interfaces.
> > > 
> > > Add kunit wrapper for root_device_[un]register(), which create a root
> > > device and also add a kunit managed clean-up routine for the device
> > > destruction upon test exit.
> > 
> > I really do not like this as a "root device" is a horrible hack and
> > should only be used if you have to hang other devices off of it and you
> > don't have a real device to tie those devices to.
> > 
> > Here you are abusing it and attempting to treat it as a real device,
> > which it is not at all, because:
> > 
> > > Special note: In some cases the device reference-count does not reach
> > > zero and devm-unwinding is not done if device is not sitting on a bus.
> > > The root_device_[un]register() are dealing with such devices and thus
> > > this interface may not be usable by all in its current form. More
> > > information can be found from:
> > > https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/
> > 
> > See, not a real device, doesn't follow normal "struct device" rules and
> > lifetimes, don't try to use it for a test as it will only cause problems
> > and you will be forced to work around that in a test.
> 
> Ok. I understood using the root-device has been a work-around in some other
> tests. Thus continuing use it for tests where we don't need the bus until we
> have a proper alternative was suggested by David.
> 
> > Do the right thing here, create a fake bus and add devices to it.
> > 
> > Heck, I'll even write that code if you want it, what's the requirement,
> > something like:
> > 	struct device *kunit_device_create(struct kunit *test, const char *name);
> > 	void kunit_device_destroy(struct device *dev);
> 
> Thanks for the offer Greg. This, however, is being already worked on by
> David. I don't want to step on his toes by writing the same thing, nor do I
> think I should be pushing him to rush on his work.

Ok, David, my offer stands, if you want me to write this I will be glad
to do so.

thanks,

greg k-h
