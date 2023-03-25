Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E716C8BB6
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 07:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjCYG2S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Mar 2023 02:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCYG2R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Mar 2023 02:28:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF8112F0E;
        Fri, 24 Mar 2023 23:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E8386092A;
        Sat, 25 Mar 2023 06:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81894C433EF;
        Sat, 25 Mar 2023 06:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679725695;
        bh=AID5p0dG053yTqXLpCwTEFwzg93U5EvidE5/+N37y6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHf8LbYFfIzDN0p/DPyZ9hR6ptR/XNwwsVSTTGnmLRLOltg76NQfoEg+qgPn1AO0z
         a75UZ3Rmv0/OCQf9oCbR9oT2AVyQ0UFWfW2MpfBtQoJoZdM+Bm4NZq3nxwTbFOfnaI
         DyioCmda9cDflHX0JqGRffkqRGwCGp6b2xk+aHU0=
Date:   Sat, 25 Mar 2023 07:28:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Gow <davidgow@google.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [RFC PATCH 2/2] kunit: Add APIs for managing devices
Message-ID: <ZB6UfBMtntqrLlKz@kroah.com>
References: <20230325043104.3761770-1-davidgow@google.com>
 <20230325043104.3761770-3-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325043104.3761770-3-davidgow@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 25, 2023 at 12:31:04PM +0800, David Gow wrote:
> Tests for drivers often require a struct device to pass to other
> functions. While it's possible to create these with
> root_device_register(), or to use something like a platform device, this
> is both a misuse of those APIs, and can be difficult to clean up after,
> for example, a failed assertion.
> 
> Add two KUnit-specific functions for registering and unregistering a
> struct device:
> - kunit_device_register()
> - kunit_device_unregister()
> 
> These behave similarly to root_device_register() and
> root_device_unregister() except:
> - They take a struct kunit pointer with a test context.
> - They do not create a root device directory in sysfs.

But they show up in the root directory in sysfs, in /sys/devices/ which
is not a good place to be.  Why not make them part of a class, perhaps
called 'kunit', so that they will be in a contained place?

thanks,

greg k-h
