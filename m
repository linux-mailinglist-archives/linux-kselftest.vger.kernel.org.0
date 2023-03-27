Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F139E6CA2FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 14:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjC0MBR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 08:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjC0MBP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 08:01:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79F735BB;
        Mon, 27 Mar 2023 05:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72EC9B81148;
        Mon, 27 Mar 2023 12:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E2AC433EF;
        Mon, 27 Mar 2023 12:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679918471;
        bh=WGc0hjU9EXtgJYoWwCb/QMpZOY1aoZ9G/w6FiV/frqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqjwaYgyATxb8Cz0/j+qBqdeHMyfoAaDZRpAmcmwk2Ctl3bx2mfO7KcsRc6VNa4XG
         UYv4g6LlkcbhkahSK/3UK+7k1FxQaqNZfrU6uYS2vF/2+5s32iNBDgJEAdoZfBCEQs
         iEVZvOLJsmnAuGmoSkUVi0gxDpUhEsCmedXWcGDE=
Date:   Mon, 27 Mar 2023 14:01:07 +0200
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
Message-ID: <ZCGFgypeuJXqNwQt@kroah.com>
References: <cover.1679915278.git.mazziesaccount@gmail.com>
 <f2c7f7b04f7e4ee7b9cef73ecba672f5fa40eb73.1679915278.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2c7f7b04f7e4ee7b9cef73ecba672f5fa40eb73.1679915278.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 27, 2023 at 02:34:02PM +0300, Matti Vaittinen wrote:
> A few tests need to have a valid struct device. One such example is
> tests which want to be testing devm-managed interfaces.
> 
> Add kunit wrapper for root_device_[un]register(), which create a root
> device and also add a kunit managed clean-up routine for the device
> destruction upon test exit.

I really do not like this as a "root device" is a horrible hack and
should only be used if you have to hang other devices off of it and you
don't have a real device to tie those devices to.

Here you are abusing it and attempting to treat it as a real device,
which it is not at all, because:

> Special note: In some cases the device reference-count does not reach
> zero and devm-unwinding is not done if device is not sitting on a bus.
> The root_device_[un]register() are dealing with such devices and thus
> this interface may not be usable by all in its current form. More
> information can be found from:
> https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/

See, not a real device, doesn't follow normal "struct device" rules and
lifetimes, don't try to use it for a test as it will only cause problems
and you will be forced to work around that in a test.

Do the right thing here, create a fake bus and add devices to it.

Heck, I'll even write that code if you want it, what's the requirement,
something like:
	struct device *kunit_device_create(struct kunit *test, const char *name);
	void kunit_device_destroy(struct device *dev);
?

Why do you want a "match" function?  You don't provide documentation
here for it so I have no idea.

Anything else needed?

> The use of root-devices in the kunit helpers is intended to be an
> intermediate solution to allow tests which do not require device to sit
> on a bus avoid directly abusing the root_device_[un]register() while
> proper kunit device solution is being worked on. Related discussion can be
> found from:
> https://lore.kernel.org/lkml/CABVgOSmx3A4Vwos2_8xO-XQrQAw5gvY0nc5zLpLmcJ7FtA-dTQ@mail.gmail.com/

Again, no, please let's not get this wrong now and say "we will fix this
later" as that's not how kernel development should work...

thanks,

greg k-h
