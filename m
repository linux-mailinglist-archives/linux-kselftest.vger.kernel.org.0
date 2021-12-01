Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07168464FA9
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 15:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349890AbhLAOc7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 09:32:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:41418 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239486AbhLAOc6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 09:32:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="223344499"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="223344499"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 06:29:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="677276223"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 06:29:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1msQap-0010ho-M4;
        Wed, 01 Dec 2021 16:28:19 +0200
Date:   Wed, 1 Dec 2021 16:28:19 +0200
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
Message-ID: <YaeGg34Log9dExYX@smile.fi.intel.com>
References: <20211130154127.12272-1-brgl@bgdev.pl>
 <20211130154127.12272-3-brgl@bgdev.pl>
 <YaZNyMV5gX5cZpar@smile.fi.intel.com>
 <CAMRc=Mf5d1i34eBez+pOYjjdyfRL9N_ha_==Cn1rANr=2CB9aQ@mail.gmail.com>
 <YaaQp2rq7N71dm1l@smile.fi.intel.com>
 <CAMRc=Me=Oq_V=+p-AFPcyDjBs-+4Ug3k0AWK9fdEEet2JD3eFw@mail.gmail.com>
 <CAMRc=MdQ+a7UrE7csg3GsiLXYGkzti-wPUwPh5J=7WBj74OVZg@mail.gmail.com>
 <Yad7IQwXDc8gS2Ne@smile.fi.intel.com>
 <CAMRc=MeScPA=764xoi9Leu7LayEbhMCuA3u_g5NJjLyc8sJ-vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MeScPA=764xoi9Leu7LayEbhMCuA3u_g5NJjLyc8sJ-vg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 01, 2021 at 02:53:42PM +0100, Bartosz Golaszewski wrote:
> On Wed, Dec 1, 2021 at 2:40 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Dec 01, 2021 at 02:11:28PM +0100, Bartosz Golaszewski wrote:
> > > On Tue, Nov 30, 2021 at 10:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

...

> > > Let me maybe rephrase the problem: currently, for GPIO devices
> > > instantiating multiple banks created outside of the OF or ACPI
> > > frameworks (e.g. instantiated manually and configured using a
> > > hierarchy of software nodes with a single parent swnode and a number
> > > of child swnodes representing the children), it is impossible to
> > > assign firmware nodes other than the one representing the top GPIO
> > > device to the gpiochip child devices.
> > >
> > > In fact if we want to drop the OF APIs entirely from gpiolib - this
> > > would be the right first step as for gpio-sim it actually replaces the
> > > gc->of_node = some_of_node; assignment that OF-based drivers do for
> > > sub-nodes defining banks and it does work with device-tree (I verified
> > > that too) thanks to the fwnode abstraction layer.
> >
> > I still don't see how you set up hierarchy of primary/secondary fwnodes.
> >
> > And I don't like this change. It seems it band-aids some issue with fwnode
> > usage. What the easiest way to reproduce the issue with your series applied
> > (without this change)?
> 
> Drop this patch and drop the line where the fwnode is assigned in
> gpio-sim.c. Then probe the device and print the addresses of the
> parent and child swnodes. See how they are the same and don't match
> the swnode hierarchy we created. You can then apply this patch and see
> how it becomes correct.

Thanks. I will give a spin.

Note, it seems I have to revert your older code first...

-- 
With Best Regards,
Andy Shevchenko


