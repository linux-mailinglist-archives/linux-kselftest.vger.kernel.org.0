Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2577B721087
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 16:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjFCOo0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 10:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjFCOo0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 10:44:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F4C18D;
        Sat,  3 Jun 2023 07:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC7B160B74;
        Sat,  3 Jun 2023 14:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A73C433D2;
        Sat,  3 Jun 2023 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685803464;
        bh=XpApcZx7zdf4mYjesJHskpZ0EplBEmpU50LBQLNxhHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwS3uwHrf56ygqpjewHnbqj3/2i2D2YtgBaglt/loS3TwJorJOCFnbFPeBk3XyQvC
         X4zf0RNKJvAMPpA0CQHXmDTFJ+Hmoy6pbuB5r68ADgq0PGVHjoygjYRcVha7I+35cE
         rORAUtJhhrgsDLMe42Cdsydk4/F6Z+UxKOTkmFnY=
Date:   Sat, 3 Jun 2023 16:44:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drivers: base: Add tests showing devm handling
 inconsistencies
Message-ID: <2023060313-boots-expel-07c9@gregkh>
References: <20230329-kunit-devm-inconsistencies-test-v1-0-c33127048375@cerno.tech>
 <wiej2vps6uhozcpxeye3xfgpnlvxcbaek73px36f4jsef3e77p@ewcsmzrxzhsi>
 <2023053137-leggings-grumbly-a33a@gregkh>
 <aix7tdvpegbkfe3okbrxu6phk7gnzfttrkmomocwofi5kkoaqz@25oaumodlg7j>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aix7tdvpegbkfe3okbrxu6phk7gnzfttrkmomocwofi5kkoaqz@25oaumodlg7j>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 05:27:05PM +0200, Maxime Ripard wrote:
> On Wed, May 31, 2023 at 08:20:13PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Apr 17, 2023 at 06:12:26PM +0200, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > On Wed, Mar 29, 2023 at 08:38:30PM +0100, Maxime Ripard wrote:
> > > > Hi,
> > > > 
> > > > This follows the discussion here:
> > > > https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb@houat/
> > > > 
> > > > This shows a couple of inconsistencies with regard to how device-managed
> > > > resources are cleaned up. Basically, devm resources will only be cleaned up
> > > > if the device is attached to a bus and bound to a driver. Failing any of
> > > > these cases, a call to device_unregister will not end up in the devm
> > > > resources being released.
> > > > 
> > > > We had to work around it in DRM to provide helpers to create a device for
> > > > kunit tests, but the current discussion around creating similar, generic,
> > > > helpers for kunit resumed interest in fixing this.
> > > > 
> > > > This can be tested using the command:
> > > > ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/base/test/
> > > > 
> > > > Let me know what you think,
> > > > Maxime
> > > > 
> > > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > > 
> > > Is there any news on this?
> > 
> > Can you resend, last I saw the kernel test robot had a problem, which
> > causes any patch series like that to be ignored by me.
> 
> Yeah, this was due to .kunitconfig being ignored by .gitignore, which
> triggers a warning for the bot.
> 
> It's now fixed (at least in next), and I just resent the patches

Still triggered the bot :(
