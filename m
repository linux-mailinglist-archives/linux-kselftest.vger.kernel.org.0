Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488A32CB95C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 10:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbgLBJnv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 04:43:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:51489 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388226AbgLBJnv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 04:43:51 -0500
IronPort-SDR: 6VtFn2QjPXAA5Hzr+ubgtWbZqgmgvaFSMUM5AmL9UzcuoI6I5FOHrcFqljQIUwGW70QUjcxWKs
 f1RIIl8TKv7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="160758355"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="160758355"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 01:43:08 -0800
IronPort-SDR: PUay8JE6CyCYGQ6OEqTbAITVx1PocfHXw7Y+ZE7N83/IJBWZY2mgXSVQMEs3J47Ae/ZqgTCjZT
 PE1macl5QL+Q==
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="316040233"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 01:43:06 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kkOgC-00BToQ-4M; Wed, 02 Dec 2020 11:44:08 +0200
Date:   Wed, 2 Dec 2020 11:44:08 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] lib: Convert test_hexdump.c to KUnit
Message-ID: <20201202094408.GW4077@smile.fi.intel.com>
References: <20201201071632.68471-1-98.arpi@gmail.com>
 <CAHp75VfV60sRAKkzvbEKW7UEZSiDmNVfd_kB-OOKZRk5MNMeDQ@mail.gmail.com>
 <e10ef8d3-f22b-db10-3784-c94ee425af46@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e10ef8d3-f22b-db10-3784-c94ee425af46@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 02, 2020 at 09:51:19AM +0530, Arpitha Raghunandan wrote:
> On 01/12/20 4:36 pm, Andy Shevchenko wrote:
> > On Tue, Dec 1, 2020 at 9:21 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:

...

> >> I ran both the original and converted tests as is to produce the
> >> output for success of the test in the two cases. I also ran these
> >> tests with a small modification to show the difference in the output
> >> for failure of the test in both cases. The modification I made is:
> >>  static const char * const test_data_4_le[] __initconst = {
> >> -       "7bdb32be", "b293180a", "24c4ba70", "9b34837d",
> >> +       "7bdb32be", "b293180a", "24c4ba70", "9b3483d",
> >>
> >> The difference in outputs can be seen here:
> >> https://gist.github.com/arpi-r/38f53a3c65692bf684a6bf3453884b6e
> > 
> > Looks pretty much good, what I'm sad to see is the absence of the test
> > statistics. Any ideas if we can get it back?
> > 
> 
> I could again include variable total_tests as was in the original test.
> Would that be fine?

What I;m talking about is the output. How it will be implemented (using the
same variable or differently) is up to you. So the point is I want to see the
statistics of success/total at the end.

I think this should be done in KUNIT rather than in the individual test cases.

-- 
With Best Regards,
Andy Shevchenko


