Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B159425769
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 18:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhJGQOF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 12:14:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:43753 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhJGQOF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 12:14:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="289792597"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="289792597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 09:08:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="440316846"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 09:08:21 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mYVwJ-009aZx-0L;
        Thu, 07 Oct 2021 19:08:11 +0300
Date:   Thu, 7 Oct 2021 19:08:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH v4 2/7] kernel.h: Split out container_of() and
 typeof_member() macros
Message-ID: <YV8ba+rzdornmMgF@smile.fi.intel.com>
References: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
 <20211007154407.29746-3-andriy.shevchenko@linux.intel.com>
 <CANiq72=pCQgwHe5u2nS_RkGBnRLdcw2v=vk-8eNDeAP9ygO0SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=pCQgwHe5u2nS_RkGBnRLdcw2v=vk-8eNDeAP9ygO0SQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 07, 2021 at 05:54:32PM +0200, Miguel Ojeda wrote:
> On Thu, Oct 7, 2021 at 5:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > +#define typeof_member(T, m)    typeof(((T*)0)->m)
> 
> Is the patch missing the removal from the other place?

Possibly, but I leave it for now for builders to place with the series and
people having chance to comment.

Thanks for review!

Maybe Andrew can fix this when applying?

-- 
With Best Regards,
Andy Shevchenko


