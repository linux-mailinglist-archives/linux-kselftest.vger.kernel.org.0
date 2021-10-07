Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76B9425989
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 19:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbhJGReT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 13:34:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:4228 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235301AbhJGReS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 13:34:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="312511028"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="312511028"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 10:32:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="568716098"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 10:32:17 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mYXFd-009cFj-35;
        Thu, 07 Oct 2021 20:32:13 +0300
Date:   Thu, 7 Oct 2021 20:32:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        jic23@kernel.org, linux@rasmusvillemoes.dk,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH v4 6/7] plist: Replace kernel.h with the necessary
 inclusions
Message-ID: <YV8vHZg0Xcs0DbPV@smile.fi.intel.com>
References: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
 <20211007154407.29746-7-andriy.shevchenko@linux.intel.com>
 <1ec405c5a8fd24de9066277ce855d7e39f93e691.camel@perches.com>
 <YV8sPjLn1jqLOm2H@smile.fi.intel.com>
 <04ebb29ccb707bc37df2d3ddd684781114a1a62e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ebb29ccb707bc37df2d3ddd684781114a1a62e.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 07, 2021 at 10:26:05AM -0700, Joe Perches wrote:
> On Thu, 2021-10-07 at 20:19 +0300, Andy Shevchenko wrote:
> > On Thu, Oct 07, 2021 at 10:12:56AM -0700, Joe Perches wrote:
> > > On Thu, 2021-10-07 at 18:44 +0300, Andy Shevchenko wrote:
> > > > When kernel.h is used in the headers it adds a lot into dependency hell,
> > > > especially when there are circular dependencies are involved.
> > > > 
> > > > Replace kernel.h inclusion with the list of what is really being used.
> > > []
> > > > diff --git a/include/linux/plist.h b/include/linux/plist.h
> > > []
> > > > @@ -73,8 +73,11 @@
> > > []
> > > > +#include <asm/bug.h>
> > > 
> > > why asm/bug.h and not linux/bug.h ?
> > 
> > The direct inclusion is from that one. Why linux/bug?
> 
> A general guideline is to avoid asm includes.

It's fine when it has any useful background. Doing cargo cult is not always
a good idea. I plead for common sense.

-- 
With Best Regards,
Andy Shevchenko


