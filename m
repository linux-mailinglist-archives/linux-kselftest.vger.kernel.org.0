Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C3D46509D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 15:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350110AbhLAO7m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 09:59:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:15254 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243151AbhLAO7l (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 09:59:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236699415"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="236699415"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 06:56:03 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="609585890"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 06:56:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1msR0b-0011Jp-9B;
        Wed, 01 Dec 2021 16:54:57 +0200
Date:   Wed, 1 Dec 2021 16:54:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 2/6] gpiolib: allow to specify the firmware node in
 struct gpio_chip
Message-ID: <YaeMwP3XocWjrZBv@smile.fi.intel.com>
References: <YaZNyMV5gX5cZpar@smile.fi.intel.com>
 <CAMRc=Mf5d1i34eBez+pOYjjdyfRL9N_ha_==Cn1rANr=2CB9aQ@mail.gmail.com>
 <YaaQp2rq7N71dm1l@smile.fi.intel.com>
 <CAMRc=Me=Oq_V=+p-AFPcyDjBs-+4Ug3k0AWK9fdEEet2JD3eFw@mail.gmail.com>
 <CAMRc=MdQ+a7UrE7csg3GsiLXYGkzti-wPUwPh5J=7WBj74OVZg@mail.gmail.com>
 <Yad7IQwXDc8gS2Ne@smile.fi.intel.com>
 <CAMRc=MeScPA=764xoi9Leu7LayEbhMCuA3u_g5NJjLyc8sJ-vg@mail.gmail.com>
 <YaeGg34Log9dExYX@smile.fi.intel.com>
 <YaeHtzyqe3XwgWw/@smile.fi.intel.com>
 <CAMRc=McuGvUUPt9VMARqdNttbXyau5ib-MgR_EYskxqJtUxcsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McuGvUUPt9VMARqdNttbXyau5ib-MgR_EYskxqJtUxcsQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 01, 2021 at 03:36:29PM +0100, Bartosz Golaszewski wrote:
> On Wed, Dec 1, 2021 at 3:34 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Dec 01, 2021 at 04:28:19PM +0200, Andy Shevchenko wrote:
> > > On Wed, Dec 01, 2021 at 02:53:42PM +0100, Bartosz Golaszewski wrote:
> > > > On Wed, Dec 1, 2021 at 2:40 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Wed, Dec 01, 2021 at 02:11:28PM +0100, Bartosz Golaszewski wrote:
> > > > > > On Tue, Nov 30, 2021 at 10:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> > > > Drop this patch and drop the line where the fwnode is assigned in
> > > > gpio-sim.c. Then probe the device and print the addresses of the
> > > > parent and child swnodes. See how they are the same and don't match
> > > > the swnode hierarchy we created. You can then apply this patch and see
> > > > how it becomes correct.
> > >
> > > Thanks. I will give a spin.
> > >
> > > Note, it seems I have to revert your older code first...
> >
> > Okay, I have to postpone because simple revert doesn't work for me.
> > Can you clean up the next, please and I can use it starting from tomorrow?
> >
> >
> > $ git tag --contains 5065e08e4ef3
> > DONT-USE-next-20211105
> > next-20211101
> > next-20211102
> > next-20211103
> > next-20211104
> > next-20211105
> > next-20211106
> > next-20211108
> > next-20211109
> > next-20211110
> > next-20211111
> > next-20211112
> > next-20211115
> > next-20211116
> > next-20211117
> > next-20211118
> > next-20211123
> > next-20211124
> > next-20211125
> > next-20211126
> > next-20211129
> > next-20211130
> > next-20211201

> None of this is in next, please use:
> https://github.com/brgl/linux/tree/topic/gpio-sim-v12 if you want a
> branch.

It the old version that prevents me to apply (my branches based on next).

> I just thought you were going to simply apply these patches.

That's correct, but see above.

Anyway, I'm already switched tasks for today. Maybe I will have some time
later on.

-- 
With Best Regards,
Andy Shevchenko


