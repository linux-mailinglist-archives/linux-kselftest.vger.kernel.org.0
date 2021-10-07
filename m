Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CD3425864
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 18:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhJGQvL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 12:51:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:51976 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242891AbhJGQvI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 12:51:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="287191133"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="287191133"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 09:47:44 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="713396822"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 09:47:39 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mYWYR-009bL5-Qf;
        Thu, 07 Oct 2021 19:47:35 +0300
Date:   Thu, 7 Oct 2021 19:47:35 +0300
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
Subject: Re: [PATCH v4 2/7] kernel.h: Split out container_of() and
 typeof_member() macros
Message-ID: <YV8kp9Twvqlle/7j@smile.fi.intel.com>
References: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
 <20211007154407.29746-3-andriy.shevchenko@linux.intel.com>
 <86b05929e5aa8fa6e975c59cf523ad84498351b6.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b05929e5aa8fa6e975c59cf523ad84498351b6.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 07, 2021 at 09:27:38AM -0700, Joe Perches wrote:
> On Thu, 2021-10-07 at 18:44 +0300, Andy Shevchenko wrote:
> > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > Here is the attempt cleaning it up by splitting out container_of() and
> > typeof_member() macros.
> > 
> > For time being include new header back to kernel.h to avoid twisted
> > indirected includes for existing users.
> 
> IMO: this new file is missing 2 #include directives.

Thanks, Joe, I'll address this in v5.

-- 
With Best Regards,
Andy Shevchenko


