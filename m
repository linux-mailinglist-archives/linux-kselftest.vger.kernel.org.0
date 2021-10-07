Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31AA42568E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhJGPa4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 11:30:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:20942 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhJGPa4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 11:30:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226179253"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="226179253"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 08:28:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="560602099"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 08:28:44 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mYVK3-009ZkW-DK;
        Thu, 07 Oct 2021 18:28:39 +0300
Date:   Thu, 7 Oct 2021 18:28:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v3 2/7] kernel.h: Split out container_of() and
 typeof_member() macros
Message-ID: <YV8SJxgXmyQhhAsg@smile.fi.intel.com>
References: <20211007150339.28910-1-andriy.shevchenko@linux.intel.com>
 <20211007150339.28910-3-andriy.shevchenko@linux.intel.com>
 <YV8NlXMJpVRcH42I@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV8NlXMJpVRcH42I@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 07, 2021 at 05:09:09PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 07, 2021 at 06:03:34PM +0300, Andy Shevchenko wrote:

...

> Why did you touch kobject.h here?

Because it uses it, but indirectly. Now we may include it directly.

> It shouldn't have been needed to change for this commit.

OK. I will split it to a separate change. Would it be okay?

> Anyway, I really don't think this is all worth any more work at all,
>	as
> I'm not going to be the one taking it...

It's fine. There are more people in favour of this change anyway.

Thanks for review!

-- 
With Best Regards,
Andy Shevchenko


