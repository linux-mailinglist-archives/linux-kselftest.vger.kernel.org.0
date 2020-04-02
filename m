Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F57519C8E8
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbgDBSio (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 14:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388260AbgDBSio (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 14:38:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AAD62064A;
        Thu,  2 Apr 2020 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585852723;
        bh=9Ho6bf+CA7jUz/UlmFQaiIKtvrVOsYK9BEepRPFN6bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVZ/vcYcZCn2d5FTph1Va5WvoCOWcrDi0gweggQuY99ppzucgQyOzEvc4nhyA/Wtb
         mtoDS0BYbNe5+DlNkNPUmrE3mTw0B16o0PqnM+OJPYSEJvmtqlscr4Ju4pYgh49ZRt
         Qlt47Kr/cfelgJ8t5LTGK7zHQL761f3kUSP0EwpQ=
Date:   Thu, 2 Apr 2020 20:38:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     shuah <shuah@kernel.org>, brendanhiggins@google.com,
        frowand.list@gmail.com, linux-kselftest@vger.kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 kunit-next 1/4] kunit: add debugfs
 /sys/kernel/debug/kunit/<suite>/results display
Message-ID: <20200402183839.GB3234477@kroah.com>
References: <1585232710-322-1-git-send-email-alan.maguire@oracle.com>
 <1585232710-322-2-git-send-email-alan.maguire@oracle.com>
 <0d310181-a172-dec9-19aa-337ece9d7380@kernel.org>
 <alpine.LRH.2.21.2004021624400.21551@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2004021624400.21551@localhost>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 02, 2020 at 04:27:35PM +0100, Alan Maguire wrote:
> On Wed, 1 Apr 2020, shuah wrote:
> 
> > Hi Alan,
> > 
> > On 3/26/20 8:25 AM, Alan Maguire wrote:
> > > add debugfs support for displaying kunit test suite results; this is
> > > especially useful for module-loaded tests to allow disentangling of
> > > test result display from other dmesg events.  debugfs support is
> > > provided if CONFIG_KUNIT_DEBUGFS=y.
> > > 
> > > As well as printk()ing messages, we append them to a per-test log.
> > > 
> > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > > Reviewed-by: Frank Rowand <frank.rowand@sony.com>
> > > ---
> > >   include/kunit/test.h   |  54 +++++++++++++++---
> > >   lib/kunit/Kconfig      |   8 +++
> > 
> > Missing defaults for config options?
> > 
> > >   lib/kunit/Makefile     |   4 ++
> > >   lib/kunit/debugfs.c    | 116 ++++++++++++++++++++++++++++++++++++++
> > >   lib/kunit/debugfs.h    |  30 ++++++++++
> > >   lib/kunit/kunit-test.c |   4 +-
> > >   lib/kunit/test.c       | 147
> > >   ++++++++++++++++++++++++++++++++++++++-----------
> > >   7 files changed, 322 insertions(+), 41 deletions(-)
> > >   create mode 100644 lib/kunit/debugfs.c
> > >   create mode 100644 lib/kunit/debugfs.h
> > > 
> > 
> > snip
> > 
> > > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > > index 065aa16..95d12e3 100644
> > > --- a/lib/kunit/Kconfig
> > > +++ b/lib/kunit/Kconfig
> > > @@ -14,6 +14,14 @@ menuconfig KUNIT
> > >   
> > >   if KUNIT
> > >   
> > > +config KUNIT_DEBUGFS
> > > +	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
> > > +	help
> > > +	  Enable debugfs representation for kunit.  Currently this consists
> > > +	  of /sys/kernel/debug/kunit/<test_suite>/results files for each
> > > +	  test suite, which allow users to see results of the last test suite
> > > +	  run that occurred.
> > > +
> > 
> > Any reason why there is default for this option?
> > 
> > Same for all other options. I am sending pull request for now without
> > defaults. Would like to see this fixed for rc2.
> >
> 
> Sure, I'll send a patch shortly. Just wanted to get opinions
> on what those defaults should be; my working assumption is
> 
> - CONFIG_KUNIT should be default n; 

No default means 'n', so there's no need to say that at all.

> - CONFIG_KUNIT_DEBUGFS should be default y (enabled by default
>   if CONFIG_KUNIT is set);

Why?  If it's is 'y', then don't even make it an option at all, just
always have it :)

'y' is almost always reserved for "your machine will not function
properly without this enabled".

> - CONFIG_KUNIT_TEST, CONFIG_KUNIT_EXAMPLE_TEST should be default n

So no need to specify anything, 'n' is the default.

thanks,

greg k-h
