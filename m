Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7370768EC5
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 09:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjGaHbB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 03:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjGaHaq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 03:30:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F133E1721;
        Mon, 31 Jul 2023 00:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B7FD60F30;
        Mon, 31 Jul 2023 07:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1D5C433C8;
        Mon, 31 Jul 2023 07:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690788529;
        bh=6GGbsN0sJXdYdrU+plkrnflkAMfnLWnegDm8za4xDdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHSq0B+A2kqlF3HaePnxvailk1b2jqaGfAhUJd6riESzp6+c8BoHgrekW1GtVd0q2
         9PMKvsh4wNIUas7OIcrrsofbLg/Sn0D98x/XuWOZ1K6ji1z7wzGxN3Rf0SQCVHp3ES
         AfT6R6c+IvlyZeqpn7Dl3ARu9KQsVeZE7nJ89W+c=
Date:   Mon, 31 Jul 2023 09:28:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drivers: base: Add tests showing devm handling
 inconsistencies
Message-ID: <2023073131-glimmer-both-05b6@gregkh>
References: <20230720-kunit-devm-inconsistencies-test-v3-0-6aa7e074f373@kernel.org>
 <xlb7rwyg5j4hk6afqssxniprn72goxv4avjzjrs3oc3nvfhbsa@fn4amdp6dkx5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xlb7rwyg5j4hk6afqssxniprn72goxv4avjzjrs3oc3nvfhbsa@fn4amdp6dkx5>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 08:34:03AM +0200, Maxime Ripard wrote:
> On Thu, Jul 20, 2023 at 02:45:06PM +0200, Maxime Ripard wrote:
> > Hi,
> > 
> > This follows the discussion here:
> > https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb@houat/
> > 
> > This shows a couple of inconsistencies with regard to how device-managed
> > resources are cleaned up. Basically, devm resources will only be cleaned up
> > if the device is attached to a bus and bound to a driver. Failing any of
> > these cases, a call to device_unregister will not end up in the devm
> > resources being released.
> > 
> > We had to work around it in DRM to provide helpers to create a device for
> > kunit tests, but the current discussion around creating similar, generic,
> > helpers for kunit resumed interest in fixing this.
> > 
> > This can be tested using the command:
> > ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/base/test/
> > 
> > I added the fix David suggested back in that discussion which does fix
> > the tests. The SoB is missing, since David didn't provide it back then.
> > 
> > Let me know what you think,
> > Maxime
> > 
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> 
> Ping?

It's in my review queue, still trying to catch up...
