Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE726779F7B
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 13:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbjHLLHS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Aug 2023 07:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbjHLLHL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Aug 2023 07:07:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61255AF;
        Sat, 12 Aug 2023 04:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F30D463A4F;
        Sat, 12 Aug 2023 11:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0980EC433C8;
        Sat, 12 Aug 2023 11:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691838433;
        bh=PIh5nnK6kOB1HMKbcrDeCFnagp8juSndGPC0D3oJydc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUPbZapArRfdTmYpcstLNsz2wiruIK842FXmF41avM/ehhtZkoDhVFojaHOup1EWZ
         yV8ZTwikgiZAV3Hwx3EgpY7eiA9Ivcx7grp5dQKLWMeQ9yqpUxzmVS2+YV28tc+bvk
         VTWYA38wNWZdBB6jXwk5StekNOfAa3CmVGdWouRM=
Date:   Sat, 12 Aug 2023 13:07:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drivers: base: Add tests showing devm handling
 inconsistencies
Message-ID: <2023081248-uselessly-reckless-1963@gregkh>
References: <20230720-kunit-devm-inconsistencies-test-v3-0-6aa7e074f373@kernel.org>
 <xlb7rwyg5j4hk6afqssxniprn72goxv4avjzjrs3oc3nvfhbsa@fn4amdp6dkx5>
 <2023073131-glimmer-both-05b6@gregkh>
 <2023080416-suspend-cattail-f048@gregkh>
 <ckldghyavb6fj2mxfcw5spsr3v2rlyj2br64tnvwl5waz3i6id@zbxu7ipjtlwd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ckldghyavb6fj2mxfcw5spsr3v2rlyj2br64tnvwl5waz3i6id@zbxu7ipjtlwd>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 07, 2023 at 08:54:08AM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Aug 04, 2023 at 05:01:50PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jul 31, 2023 at 09:28:47AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jul 31, 2023 at 08:34:03AM +0200, Maxime Ripard wrote:
> > > > On Thu, Jul 20, 2023 at 02:45:06PM +0200, Maxime Ripard wrote:
> > > > > Hi,
> > > > > 
> > > > > This follows the discussion here:
> > > > > https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb@houat/
> > > > > 
> > > > > This shows a couple of inconsistencies with regard to how device-managed
> > > > > resources are cleaned up. Basically, devm resources will only be cleaned up
> > > > > if the device is attached to a bus and bound to a driver. Failing any of
> > > > > these cases, a call to device_unregister will not end up in the devm
> > > > > resources being released.
> > > > > 
> > > > > We had to work around it in DRM to provide helpers to create a device for
> > > > > kunit tests, but the current discussion around creating similar, generic,
> > > > > helpers for kunit resumed interest in fixing this.
> > > > > 
> > > > > This can be tested using the command:
> > > > > ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/base/test/
> > > > > 
> > > > > I added the fix David suggested back in that discussion which does fix
> > > > > the tests. The SoB is missing, since David didn't provide it back then.
> > > > > 
> > > > > Let me know what you think,
> > > > > Maxime
> > > > > 
> > > > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > > 
> > > > Ping?
> > > 
> > > It's in my review queue, still trying to catch up...
> > 
> > I didn't make it here this week, sorry.
> 
> np, I just don't want that patch to disappear into the ether :)
> 
> > I kind of worry about encoding the current "odd" functionality in a
> > test as being the correct thing, but will look at it closer next week.
> 
> I don't think I'm doing that? The tests we've added are all how we think
> it should behave, the broken ones being skipped to avoid any failures.
> 
> The last patch drops the kunit_skip() to make sure that it's tested
> going forward.
> 
> So we shouldn't encode the odd behaviour anywhere in this series, unless
> I got you wrong?

No you are correct, I was mis-remembering things.

This looks good, thanks for sticking with it, all now applied to my
tree.

greg k-h
