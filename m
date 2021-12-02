Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750DA4664C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 14:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358363AbhLBN4f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 08:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358366AbhLBN4c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 08:56:32 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B446C06174A
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Dec 2021 05:53:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r11so116218535edd.9
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 05:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1sTxIp0a41bkXoV8cHR5rlVl6XXZGn9tZNWmb4OGT8=;
        b=O/w8IFDO8lBP7ZX/okkfDxwt6a0o5j/mp0wNN64tjiRVQDUVAXihonXsyYwAfzUx1Y
         +s1aSfSfJyrhn+zri/+Wm091DSUpEUREWpZCESWe+PxEg0E4P++6qPFRTJY4KDtHytJd
         e32ertQv+qww7UC5/aJjUxOglx7FMJaAYAWD6CxDRbtkcwtQ7/ZhVrKh1YHEcnf1aNTW
         Lqi99upT615hXVDpzvrzYL8bpidWaKItWAR9K3/sCUHasB4XxQ7+urnDL++vRdvc2O2L
         EaQrat63iIFHnaIr8rQfpla7JTCvIEtVQDTQZaSzm9aBXTiTZnHhzWuc4wHP9ZWpbgBE
         isKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1sTxIp0a41bkXoV8cHR5rlVl6XXZGn9tZNWmb4OGT8=;
        b=io3VED3WblzrHvpPt9l3CkfxodtF18H8d9C8qj6a4obWFC+dG3bIk1YoDLEawcrpYf
         SKdOC+ejaM0s3m/Z8qRuj0Go09HGrqQKiTDxQDn3deMvsMJIc/+wTksYi5JbQV88LKJa
         oFBIRLPSxciyFnFpsJRYdbPernm5DtIK2VExHrIjNyxF1xVg0otvko4RmvTO5d/Ttncl
         w9OYO7GEPN/rLmmGrcIrXEzwOfvItUmKOryJmyuuGI3XU/yw0w8PyqOM1cua3Ci2x5x1
         YgVYmbIfnHHWNqlPUozksfZksfpJsAdazd3Wdo77/Ucp178SzGvzqOI5fwdYb8GOAn26
         pcpg==
X-Gm-Message-State: AOAM533OTwpfIBTpjnTeMhwasFZEz9fYdhqLCyNUENSLWt6cHAW54Ap1
        XOiOHvUtGzKGJgC6Bpu96dBRBEIU0cYioXAwcBvuwwMBZAr+yQ==
X-Google-Smtp-Source: ABdhPJy4sGiccW5Z5uUlfqdD2w/ANfk1HfjdWqg4WUNhAZwOB99TwjqmEpjnwErcYNUtPF2f3yGEIyX6tJ1JIaaT4KI=
X-Received: by 2002:a17:906:7b53:: with SMTP id n19mr15634326ejo.538.1638453186230;
 Thu, 02 Dec 2021 05:53:06 -0800 (PST)
MIME-Version: 1.0
References: <YaZNyMV5gX5cZpar@smile.fi.intel.com> <CAMRc=Mf5d1i34eBez+pOYjjdyfRL9N_ha_==Cn1rANr=2CB9aQ@mail.gmail.com>
 <YaaQp2rq7N71dm1l@smile.fi.intel.com> <CAMRc=Me=Oq_V=+p-AFPcyDjBs-+4Ug3k0AWK9fdEEet2JD3eFw@mail.gmail.com>
 <CAMRc=MdQ+a7UrE7csg3GsiLXYGkzti-wPUwPh5J=7WBj74OVZg@mail.gmail.com>
 <YaimotqSgHzS2wdA@smile.fi.intel.com> <CAMRc=Mew8xfPb9kgH-bf=t+yb1xGpRwv3Vn0+b-9pPbp3M3g5Q@mail.gmail.com>
 <YaivZe6Qo9LMoywi@smile.fi.intel.com> <Yaiv470uDhTbPD1A@smile.fi.intel.com>
 <CAMRc=Mdz=pihuTamENmTiWRGeUU=tb_PuxvsarS+oXFpyq4p=g@mail.gmail.com> <YajNsrKmEEBr5zWs@smile.fi.intel.com>
In-Reply-To: <YajNsrKmEEBr5zWs@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 2 Dec 2021 14:52:55 +0100
Message-ID: <CAMRc=MeMhyV1kZ7zvkqrk0okh6shxvB_LapusCFzg6UBh-bU-A@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] gpiolib: allow to specify the firmware node in
 struct gpio_chip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 2, 2021 at 2:45 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 02, 2021 at 02:06:57PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Dec 2, 2021 at 12:38 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Thu, Dec 02, 2021 at 01:35:01PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Dec 02, 2021 at 12:24:06PM +0100, Bartosz Golaszewski wrote:
> > > > > On Thu, Dec 2, 2021 at 11:58 AM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > >
> > > > > > On Wed, Dec 01, 2021 at 02:11:28PM +0100, Bartosz Golaszewski wrote:
> > > > > > > On Tue, Nov 30, 2021 at 10:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > Let me maybe rephrase the problem: currently, for GPIO devices
> > > > > > > instantiating multiple banks created outside of the OF or ACPI
> > > > > > > frameworks (e.g. instantiated manually and configured using a
> > > > > > > hierarchy of software nodes with a single parent swnode and a number
> > > > > > > of child swnodes representing the children), it is impossible to
> > > > > > > assign firmware nodes other than the one representing the top GPIO
> > > > > > > device to the gpiochip child devices.
> > > > > > >
> > > > > > > In fact if we want to drop the OF APIs entirely from gpiolib - this
> > > > > > > would be the right first step as for gpio-sim it actually replaces the
> > > > > > > gc->of_node = some_of_node; assignment that OF-based drivers do for
> > > > > > > sub-nodes defining banks and it does work with device-tree (I verified
> > > > > > > that too) thanks to the fwnode abstraction layer.
> > > > > >
> > > > > > In exchange of acknowledgements I confirm that I understood the issue
> > > > > > you are describing. What I still don't like is this band-aid:ish approach.
> > > > > > What we really need is to replace of_node by fwnode in GPIO library once
> > > > > > for all. But it can be done later after your simulation series (or before,
> > > > > > i.o.w. independently), hence I propose to update TODO and do it separately.
> > > > > >
> > > > >
> > > > > But this is what we already do for OF. How would the core gpiolib know
> > > > > how the firmware nodes represent the banks? It's the driver's job to
> > > > > tell the framework which node corresponds with what. If anything, we
> > > > > should start replacing of_nodes with fwnodes in drivers and eventually
> > > > > we'd drop the of_node pointer from gpio_chip entirely, but we'd keep
> > > > > the fwnode pointer I added as the driver still needs to assign it
> > > > > itself.
> > > > >
> > > > > Again: I may be missing something here but I've been going through
> > > > > this on and on and can't figure out any other way. Looking at
> > > > > gpiolib-acpi.c I don't see it correctly assigning fwnodes to
> > > > > sub-devices either but I don't have any HW to test it.
> > > > >
> > > > > As for this series: I can't really drop this patch as gpio-sim relies
> > > > > on swnodes being correctly associated with gpio_chips to identify the
> > > > > gpiodevs from configfs callbacks.
> > > >
> > > > Then we need to replace of_node by fwnode as a first step. I have looked
> > > > briefly into the list of drivers that may have been cleaned up and it doesn't
> > > > look too long.
> > >
> > > Let me kick this off by sending couple of patches.
> >
> > Are you fine with merging this in the meantime to get gpio-sim into mainline?
>
> gpio-sim, yes, (though I may bikeshed about naming of the configfs attributes,
> etc) but not this patch.
>

There's no way around it though AFAIK. First - the 'gpio-line-names'
property will not work for banks. 'ngpios' will only work because we
read it manually in probe() to figure out the number of sysfs groups.
And also configfs callbacks will not be able to associate bank devices
with configfs groups. I would really like to hear an alternative -
even if it's just an idea and not actual implementation.

I'm really curious to see how you'll remove the of_node pointer and
not introduce the corresponding fwnode pointer actually.

Bart
