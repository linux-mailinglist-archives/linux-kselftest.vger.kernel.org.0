Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1A52A84DB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 18:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKER14 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 12:27:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:14141 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgKER14 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 12:27:56 -0500
IronPort-SDR: OkU5bLfdzA7P1FDf5+gZtVajjYaqlc+JphdC4qQzzA0t0D2Qd6B4mgoPsYXX4ZnnEad7Y5p2En
 7cH2ujFQcaxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="169567221"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="169567221"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 09:27:55 -0800
IronPort-SDR: bkLI8GK9vxugw7LR4llfJHda/CaNsjgfGVYVZzC0VACZPzVOJQ1ZN/FEn7EUGa1Cd/30VICswj
 MbewWr1s2t7w==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="326100328"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 09:27:53 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kaj4B-0047Ag-RG; Thu, 05 Nov 2020 19:28:55 +0200
Date:   Thu, 5 Nov 2020 19:28:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v2 3/3] kunit: Introduce get_file_path() helper
Message-ID: <20201105172855.GB4077@smile.fi.intel.com>
References: <20201026165927.19020-3-andriy.shevchenko@linux.intel.com>
 <20201028092915.8053-1-sjpark@amazon.com>
 <20201103112512.GZ4077@smile.fi.intel.com>
 <CAFd5g44dLoUwfNPsMqavU_KrJ5+xoLgKT0Ec2_-pxVYxjMHiWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g44dLoUwfNPsMqavU_KrJ5+xoLgKT0Ec2_-pxVYxjMHiWA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 05, 2020 at 08:35:16AM -0800, Brendan Higgins wrote:
> On Tue, Nov 3, 2020 at 3:24 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Oct 28, 2020 at 10:29:15AM +0100, SeongJae Park wrote:
> > > On Mon, 26 Oct 2020 18:59:27 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > > Helper allows to derive file names depending on --build_dir argument.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > > > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> > >
> > > Reviewed-by: SeongJae Park <sjpark@amazon.de>
> >
> > Thanks!
> >
> > Brendan, Shuah, can we get this series applied, please?
> 
> I'm not actually sure that this qualifies as a fix. I certainly don't
> mind if this goes in 5.10, in fact, I would prefer it.
> 
> In any case, I added it to Shuah's queue. I will leave it up to Shuah
> whether it goes in as a fix in 5.10, or needs to wait for the next
> merge window.

I'm fine with either. My solely concern is that I would like to get this moved
forward somehow.

-- 
With Best Regards,
Andy Shevchenko


