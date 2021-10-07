Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57D34257F0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 18:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241439AbhJGQ3I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 12:29:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:54385 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233610AbhJGQ3I (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 12:29:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="225069076"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="225069076"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 09:22:10 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="590200956"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 09:22:05 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mYW9h-009aon-8L;
        Thu, 07 Oct 2021 19:22:01 +0300
Date:   Thu, 7 Oct 2021 19:22:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
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
        linux@rasmusvillemoes.dk,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH v4 4/7] list.h: Replace kernel.h with the necessary
 inclusions
Message-ID: <YV8eqTIDrFYu3171@smile.fi.intel.com>
References: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
 <20211007154407.29746-5-andriy.shevchenko@linux.intel.com>
 <20211007171635.2f161739@jic23-huawei>
 <YV8efjUfNXE6nbdy@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV8efjUfNXE6nbdy@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 07, 2021 at 07:21:18PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 07, 2021 at 05:16:35PM +0100, Jonathan Cameron wrote:
> > On Thu,  7 Oct 2021 18:44:04 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> ...
> 
> > Is there a reason you didn't quite sort this into alphabetical order?
> 
> Glad you asked! Yes. Greg and possibly others will come and tell me that
> I mustn't do two things in one change.

Actually I have to avoid moving const.h. I will change this in v5.

-- 
With Best Regards,
Andy Shevchenko


