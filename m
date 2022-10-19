Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D878604AAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Oct 2022 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJSPJo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Oct 2022 11:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiJSPIr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Oct 2022 11:08:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4508E0D9;
        Wed, 19 Oct 2022 08:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75E1B61929;
        Wed, 19 Oct 2022 15:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5613EC433C1;
        Wed, 19 Oct 2022 15:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666191655;
        bh=7I7sjR3Gz/WEhc33eidz6uHor5l2/Hm/OLxObdG7yG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sog1tByziDJHCwjc4iNK++1OQnMnVOsC2tejISrPvGOhBEjRrdAKDbuex/sqNU+HN
         6elLnkGOLlGv1O1aIfaJ6lcGouACd/05Y6BEIffQG4aIf1+rehV7ZRaE1C6sG7RGRb
         znSR961sDjRUk3FRLo8+Jokm8Z8lYyfk+P510w/Y=
Date:   Wed, 19 Oct 2022 17:00:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tglx@linutronix.de, akpm@linux-foundation.org, shuah@kernel.org,
        keescook@chromium.org, joe@perches.com, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/2] SPDX: add copyleft-next-0.3.1
Message-ID: <Y1ARJIhR9oldlXr5@kroah.com>
References: <20221003165849.1658170-1-mcgrof@kernel.org>
 <Y0/7FZCk7D+ygf2o@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0/7FZCk7D+ygf2o@bombadil.infradead.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 19, 2022 at 06:26:45AM -0700, Luis Chamberlain wrote:
> On Mon, Oct 03, 2022 at 09:58:47AM -0700, Luis Chamberlain wrote:
> > As suggested by Thomas Gleixner, I'm following up to move on with
> > the SPDX tag needed for copyleft-next-0.3.1. I've split this out
> > from the test_sysfs selftest so to separate review from that.
> > 
> > Changes on this v11:
> >   o Fixed a minor typo on patch #2 as noted by Kees Cook
> >   o Added Reviewed-by tags by Kees Cook
> > 
> > Changes on this v10:
> >   o embraced paragraph from Thomas Gleixner which helps explain why             
> >     the OR operator in the SPDX license name
> >   o dropped the GPL-2.0 and GPL-2.0+ tags as suggested by Thomas Gleixner
> >     as these are outdated (still valid) in the SPDX spec
> >   o trimmed the Cc list to remove the test_sysfs / block layer / fs folks as
> >     the test_sysfs stuff is now dropped from consideration in this series
> > 
> > Prior to this the series was at v9 but it also had the test_sysfs and its
> > changes, its history can be found here:
> > 
> > https://lore.kernel.org/all/20211029184500.2821444-1-mcgrof@kernel.org/
> > 
> > Luis Chamberlain (2):
> >   LICENSES: Add the copyleft-next-0.3.1 license
> >   testing: use the copyleft-next-0.3.1 SPDX tag
> > 
> >  LICENSES/dual/copyleft-next-0.3.1        | 236 +++++++++++++++++++++++
> >  lib/test_kmod.c                          |  12 +-
> >  lib/test_sysctl.c                        |  12 +-
> >  tools/testing/selftests/kmod/kmod.sh     |  13 +-
> >  tools/testing/selftests/sysctl/sysctl.sh |  12 +-
> >  5 files changed, 240 insertions(+), 45 deletions(-)
> >  create mode 100644 LICENSES/dual/copyleft-next-0.3.1
> 
> *poke*

It's been 2 days since the merge window ended.  And my todo queue is:

	$ mdfrm -c todo/
	1410 messages in todo/

Please give me a chance to catch up...

thanks,

greg k-h
