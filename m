Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E28D7703C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjHDPB4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 11:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjHDPBz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 11:01:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D1649C3;
        Fri,  4 Aug 2023 08:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8426062054;
        Fri,  4 Aug 2023 15:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D386C433C8;
        Fri,  4 Aug 2023 15:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691161312;
        bh=XzhhEA7oTzXvKetJnMrwnsbo18Deetnq4E9+kiTDjdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QklkaIhP947uicRPaLPusl7/4oVfcZGcnu0Dia0iDsosHXdRgTxIEs21geeHfyacL
         C6tsdb1r65ftfCJNSlawG8DijUivrepiUxJhLj5Lxysmvo8BT2vjDVnz12Z7tne5u4
         Q02w4it9AwFF2KnoZESfM6RysuwbJ61btJV48pFQ=
Date:   Fri, 4 Aug 2023 17:01:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drivers: base: Add tests showing devm handling
 inconsistencies
Message-ID: <2023080416-suspend-cattail-f048@gregkh>
References: <20230720-kunit-devm-inconsistencies-test-v3-0-6aa7e074f373@kernel.org>
 <xlb7rwyg5j4hk6afqssxniprn72goxv4avjzjrs3oc3nvfhbsa@fn4amdp6dkx5>
 <2023073131-glimmer-both-05b6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023073131-glimmer-both-05b6@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 09:28:47AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 31, 2023 at 08:34:03AM +0200, Maxime Ripard wrote:
> > On Thu, Jul 20, 2023 at 02:45:06PM +0200, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > This follows the discussion here:
> > > https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb@houat/
> > > 
> > > This shows a couple of inconsistencies with regard to how device-managed
> > > resources are cleaned up. Basically, devm resources will only be cleaned up
> > > if the device is attached to a bus and bound to a driver. Failing any of
> > > these cases, a call to device_unregister will not end up in the devm
> > > resources being released.
> > > 
> > > We had to work around it in DRM to provide helpers to create a device for
> > > kunit tests, but the current discussion around creating similar, generic,
> > > helpers for kunit resumed interest in fixing this.
> > > 
> > > This can be tested using the command:
> > > ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/base/test/
> > > 
> > > I added the fix David suggested back in that discussion which does fix
> > > the tests. The SoB is missing, since David didn't provide it back then.
> > > 
> > > Let me know what you think,
> > > Maxime
> > > 
> > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > 
> > Ping?
> 
> It's in my review queue, still trying to catch up...

I didn't make it here this week, sorry.  I kind of worry about encoding
the current "odd" functionality in a test as being the correct thing,
but will look at it closer next week.

thanks,

greg k-h
