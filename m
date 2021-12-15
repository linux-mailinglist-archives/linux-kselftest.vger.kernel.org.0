Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6A5475A0C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 14:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbhLON5Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 08:57:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:7483 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237608AbhLON5X (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 08:57:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="236766359"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="236766359"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:57:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="614708573"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:57:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mxUlc-006ciu-8l;
        Wed, 15 Dec 2021 15:56:24 +0200
Date:   Wed, 15 Dec 2021 15:56:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/1] kunit: Replace kernel.h with the necessary
 inclusions
Message-ID: <Ybn0CMscKc/jBSSC@smile.fi.intel.com>
References: <20211213204441.56204-1-andriy.shevchenko@linux.intel.com>
 <CAFd5g47FXzwtnxOH_Qc3VsWnS2RBNEreVAepWPizboZTo4KRfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47FXzwtnxOH_Qc3VsWnS2RBNEreVAepWPizboZTo4KRfw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 14, 2021 at 04:56:21PM -0500, Brendan Higgins wrote:
> On Mon, Dec 13, 2021 at 3:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> >
> > Replace kernel.h inclusion with the list of what is really being used.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!

> > Andrew, please take it through your tree since KUnit maintainer is non-responsive
> > by unknown (to me) reasons.
> 
> Sorry, I did not see the previous version of this patch.

Maybe you need to check your email settings and your domain MTA?
https://lore.kernel.org/linux-kselftest/20211110103552.60181-1-andriy.shevchenko@linux.intel.com/T/#u

> But this
> looks fine, and does not appear to break any tests.

-- 
With Best Regards,
Andy Shevchenko


