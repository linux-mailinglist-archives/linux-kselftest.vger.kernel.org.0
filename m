Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBCED13B55F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 23:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANWn4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 17:43:56 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54463 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgANWnz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 17:43:55 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 4d21a5c1f3213161; Tue, 14 Jan 2020 23:43:54 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     brendanhiggins@google.com, gregkh@linuxfoundation.org,
        dmitry.torokhov@gmail.com, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] software node: introduce CONFIG_KUNIT_DRIVER_PE_TEST
Date:   Tue, 14 Jan 2020 23:43:53 +0100
Message-ID: <1973062.CA44Rh9njY@kreacher>
In-Reply-To: <51d7d427-2ef6-b0cd-ad23-2fb75b06b763@infradead.org>
References: <1579018183-14879-1-git-send-email-alan.maguire@oracle.com> <alpine.LRH.2.20.2001141639240.15464@dhcp-10-175-171-251.vpn.oracle.com> <51d7d427-2ef6-b0cd-ad23-2fb75b06b763@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tuesday, January 14, 2020 5:45:56 PM CET Randy Dunlap wrote:
> On 1/14/20 8:42 AM, Alan Maguire wrote:
> > On Tue, 14 Jan 2020, Randy Dunlap wrote:
> > 
> >> Hi Alan,
> >>
> >> On 1/14/20 8:09 AM, Alan Maguire wrote:
> >>> currently the property entry kunit tests are built if CONFIG_KUNIT=y.
> >>> This will cause warnings when merged with the kunit tree that now
> >>> supports tristate CONFIG_KUNIT.  While the tests appear to compile
> >>> as a module, we get a warning about missing module license.
> >>>
> >>> It's better to have a per-test suite CONFIG variable so that
> >>> we can do selective building of kunit-based suites, and can
> >>> also avoid merge issues like this.
> >>>
> >>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >>
> >> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >>
> > 
> > Apologies for missing you out here.
> >  
> >>> Fixes: c032ace71c29 ("software node: add basic tests for property entries")
> >>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>> ---
> >>>  drivers/base/test/Kconfig  | 3 +++
> >>>  drivers/base/test/Makefile | 2 +-
> >>>  2 files changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
> >>> index 86e85da..d29ae95 100644
> >>> --- a/drivers/base/test/Kconfig
> >>> +++ b/drivers/base/test/Kconfig
> >>> @@ -8,3 +8,6 @@ config TEST_ASYNC_DRIVER_PROBE
> >>>  	  The module name will be test_async_driver_probe.ko
> >>>  
> >>>  	  If unsure say N.
> >>> +config KUNIT_DRIVER_PE_TEST
> >>> +	bool "KUnit Tests for property entry API"
> >>> +	depends on KUNIT
> >>
> >> Why is this bool instead of tristate?
> >>
> > 
> > The support for building kunit and kunit tests as modules has not merged 
> > into linux-next yet, so if we set the option to tristate the build would
> > fail for allmodconfig builds.   Once it's merged we can revisit though; I 
> > should have mentioned this, thanks for reminding me!
> 
> Oh. I see.  Thanks.

Patch applied, thanks!



