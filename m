Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2724D4FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Aug 2020 14:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgHUM3N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Aug 2020 08:29:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:7119 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbgHUM2z (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Aug 2020 08:28:55 -0400
IronPort-SDR: c2gv0V8YEqOXtZQ2yQsCrFTForhBhrUrILwfvC3vqdyyeAm1JWQOEFdMtHprUnGDA8LGS4QCr8
 SWAWK4VvMTqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="217060099"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="217060099"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 05:28:54 -0700
IronPort-SDR: XrWEwKuYz0KCi67K2ashjHljtoVSK06/hUXjxtueO34msSzCeU1kuj1+pRGaf3NL891STiS72d
 AzzjiLroS4zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="327750343"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 05:28:51 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k96A5-00ALOl-9g; Fri, 21 Aug 2020 15:28:49 +0300
Date:   Fri, 21 Aug 2020 15:28:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] lib: Convert test_printf.c to KUnit
Message-ID: <20200821122849.GS1891694@smile.fi.intel.com>
References: <20200817043028.76502-1-98.arpi@gmail.com>
 <f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusvillemoes.dk>
 <20200821113710.GA26290@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821113710.GA26290@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 21, 2020 at 01:37:10PM +0200, Petr Mladek wrote:
> On Mon 2020-08-17 09:06:32, Rasmus Villemoes wrote:
> > On 17/08/2020 06.30, Arpitha Raghunandan wrote:
> > > Converts test lib/test_printf.c to KUnit.
> > > More information about KUnit can be found at
> > > https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> > > KUnit provides a common framework for unit tests in the kernel.
> > 
> > So I can continue to build a kernel with some appropriate CONFIG set to
> > y, boot it under virt-me, run dmesg and see if I broke printf? That's
> > what I do now, and I don't want to have to start using some enterprisy
> > framework.
> 
> I had the same concern. I have tried it.

Which raises an obvious question: did the people who convert this test this
themselves? Looks like a janitor work in the area without understanding the
area good enough.

Probably I will NAK all those patches from now on, until it will be good commit
messages and cover of risen aspects, including reference to before and after
outcome for passed and failed test cases.

Brendan, I guess the ball now on your side to prove this is good activity.

-- 
With Best Regards,
Andy Shevchenko


