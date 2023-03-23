Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A3C6C6298
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 10:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjCWJC7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 05:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCWJC5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 05:02:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB919C77;
        Thu, 23 Mar 2023 02:02:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31D7062538;
        Thu, 23 Mar 2023 09:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E764C433A1;
        Thu, 23 Mar 2023 09:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679562155;
        bh=zyJpkW5dS5USg5bG9tqn5sX8U9cbNGdvBNNjrS6Bvu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bMJv4zgy6xVHXtXNMdto0sYZVXEsUGRHRP4VGoqVwtXZ7rURmczeXJFg2WHzfJePh
         yZtvJKQrn4YazJEtqYZjvmkasyyJEB/Heuelkm3BnQm9o/IwhGVaunVGtZfeLF438l
         Jj9YHFf8mCGxqYv3+zK277z3dbkbopbEdHEVcxoE=
Date:   Thu, 23 Mar 2023 10:02:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Gow <davidgow@google.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <ZBwVqDgWGmjXS2ij@kroah.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <CABVgOS=KUg+18wJe=O29tgOB0tQghAk030kONEm5fOzJHgKLgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOS=KUg+18wJe=O29tgOB0tQghAk030kONEm5fOzJHgKLgw@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 03:30:34PM +0800, David Gow wrote:
> On Wed, 22 Mar 2023 at 17:06, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >
> > The creation of a dummy device in order to test managed interfaces is a
> > generally useful test feature. The drm test helpers
> > drm_kunit_helper_alloc_device() and drm_kunit_helper_free_device()
> > are doing exactly this. It makes no sense that each and every component
> > which intends to be testing managed interfaces will create similar
> > helpers so stole these for more generic use.
> >
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >
> > ---
> > Changes:
> > v4 => v5:
> > - Add accidentally dropped header and email recipients
> > - do not rename + move helpers from DRM but add temporary dublicates to
> >   simplify merging. (This patch does not touch DRM and can be merged
> >   separately. DRM patch and IIO test patch still depend on this one).
> >
> > Please note that there's something similar ongoing in the CCF:
> > https://lore.kernel.org/all/20230302013822.1808711-1-sboyd@kernel.org/
> >
> > I do like the simplicity of these DRM-originated helpers so I think
> > they're worth. I do equally like the Stephen's idea of having the
> > "dummy platform device" related helpers under drivers/base and the
> > header being in include/kunit/platform_device.h which is similar to real
> > platform device under include/linux/platform_device.h
> > ---
> 
> Thanks for sending this my way.
> 
> It's clear we need some way of creating "fake" devices for KUnit
> tests. Given that there are now (at least) three different drivers
> looking to use this, we'll ultimately need something which works for
> everyone.
> 
> I think the questions we therefore need to answer are:
> - Do we specifically need a platform_device (or, any other specific
> device struct), or would any old struct device work? I can see why we
> would need a platform device for cases where we're testing things like
> device-tree properties (or, in the future, having e.g. USB-specific
> helpers which create usb_device). Most tests just use
> root_device_register() thus far, though.

Any struct device would work, so please do NOT use a platform device.

Use aux devices, or better yet, just a normal virtual device by calling
device_create().

> - What helpers do we need to make creating, using, and cleaning up
> these devices as simple as possible.

Becides what the driver core already provides you?  What exactly are you
wanting to do here?

> I think that in this particular case, we don't actually need a struct
> platform_device. Replacing these helpers with simple calls to
> root_device_register() and root_device_unregister() seems to work fine
> with this patch series for me. (It does break the
> drm_test_managed_run_action test, though.) So I don't think having
> these helpers actually help this series at the moment.

Why abuse root_device_*() for something that really is not a root device
in the system?  Why not use a virtual device?  Or better yet, a kunit
bus with devices on it that are just for testing?  That way you can
properly test the bus and driver and device code fully, which is what
you are implying is needed here.

> That being said, if they used the KUnit resource system to
> automatically clean up the device when the test is finished (or
> otherwise exits), that would seem like a real advantage. The clk and
> drm examples both do this, and I'm hoping to add an API to make it
> even simpler going forward. (With the work-in-progress API described
> here[1], the whole thing should boil down to "struct device *dev =
> root_device_register(name); kunit_defer(root_device_unregister,
> dev);".)
> 
> So, I guess we have three cases we need to look at:
> - A test just needs any old struct device. Tests thus far have
> hardcoded, or had their own wrappers around root_device_register() for
> this.

Again, make a kunit bus and devices, that might be "simplest" overall.

> - A test needs a device attached to a bus (but doesn't care which
> bus). Thus far, people have used struct platform_device for this (see
> the DRM helpers, which use a platform device for managed resource
> tests[2]). Maybe the right solution here is something like a struct
> kunit_device?

Yes.

> - A test needs a device attached to a specific bus. We'll probably
> need some more detailed faking of that bus. This covers cases like
> having fake USB devices, devicetree integration, etc.

Have your own bus.  No need to mess with USB or any real bus UNLESS you
want to actually test those busses, and if so, just create fake USB or
clk or whatever devices so that you can test them.

Or just rely on the testing that some busses have for their devices (USB
has this today and syzbot knows how to test it), as busses for hardware
can be complex and usually require a "real" driver to be written for
them to test things.

thanks,

gre gk-h
