Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB8A466243
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 12:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357305AbhLBL1m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 06:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357304AbhLBL1l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 06:27:41 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56961C061758
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Dec 2021 03:24:19 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o20so113897681eds.10
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 03:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4a+EzbACgig+p7xOkp2ifXjK5uajP6BkkqXsYbKbAE=;
        b=WYTPITKcFaXMyEbEZP4sxRgNwRGOPb/4toN9fL4Hh+IbYOdRUvbOpDQ/s4NHgK8SMt
         P7u+cIt2rYfgYYS1MP5csEJ3uIdbP8aRWPD+JEwc8ohwh0d1Wi/kVVNIy31CUJdEf2oK
         dJeI+n71YHkZMhbMr0mC/oFcHiicCPvdnnkr53GmTFal4aBEgcp35leBaQ/+Z7Gzz8Na
         xUWd6kmwq0XC7yMp2Or8xOBTESYkWsfAqsDagJlJ9I8BYucOzSFYBGnEofkN3b16/yRp
         5SLV2xqnZOcbo8ZO/pbFMUs1miXINNjsn+B13dx7CH1+O7SBHu+w+Pk/1u9nSxq0zTBv
         /5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4a+EzbACgig+p7xOkp2ifXjK5uajP6BkkqXsYbKbAE=;
        b=mseA9QXPrg3RKOWsg+p6HmuKs0mgtNmwziEvpuTjKMHL1JdeoN+jQ+fmZq49l86Vn0
         ztGYQ5GoAvM72AOJNo4wboFLwnPzMtu10I6m8gtGOEQ6WnBgvYJudKcNCNf6JPAsJflg
         KuFPEAGzEoom8mx6n8mZygcqqvpHSjgxS1lQERSc2O6NpXK+PwAln2pB7ZoBCGbkUHss
         E7kS4bpLdsATlfnRYHvo5IylFCEx7vo5yUMU8qkHwv/whyTkAQtMm17eX1ky0MgcXY1z
         HkjLQMdNdmlz0/uRQarrvk0L78va2kRzHwVx2x7oe/nMc1AvwykeEAf7qLJug+p3a6jf
         CkYg==
X-Gm-Message-State: AOAM5307q99djiB2Wfl+qxCTVwIlaBmfd4rXntwbkN6pCdDQqSZLpjbY
        sMx4BXAdoCV8JXi8ZjZAUEcjdVjCprJENcMgvUexMw==
X-Google-Smtp-Source: ABdhPJwliwbdbkdobUtjXvKiMGq95oXvFyQrc25uGLTf9cEdDVqkXxxW5XUCDkzqnG9wdV/p9ePnUKhaSJp79FVouqQ=
X-Received: by 2002:a17:907:75f0:: with SMTP id jz16mr14912881ejc.77.1638444257869;
 Thu, 02 Dec 2021 03:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20211130154127.12272-1-brgl@bgdev.pl> <20211130154127.12272-3-brgl@bgdev.pl>
 <YaZNyMV5gX5cZpar@smile.fi.intel.com> <CAMRc=Mf5d1i34eBez+pOYjjdyfRL9N_ha_==Cn1rANr=2CB9aQ@mail.gmail.com>
 <YaaQp2rq7N71dm1l@smile.fi.intel.com> <CAMRc=Me=Oq_V=+p-AFPcyDjBs-+4Ug3k0AWK9fdEEet2JD3eFw@mail.gmail.com>
 <CAMRc=MdQ+a7UrE7csg3GsiLXYGkzti-wPUwPh5J=7WBj74OVZg@mail.gmail.com> <YaimotqSgHzS2wdA@smile.fi.intel.com>
In-Reply-To: <YaimotqSgHzS2wdA@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 2 Dec 2021 12:24:06 +0100
Message-ID: <CAMRc=Mew8xfPb9kgH-bf=t+yb1xGpRwv3Vn0+b-9pPbp3M3g5Q@mail.gmail.com>
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

On Thu, Dec 2, 2021 at 11:58 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Dec 01, 2021 at 02:11:28PM +0100, Bartosz Golaszewski wrote:
> > On Tue, Nov 30, 2021 at 10:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> ...
>
> > Let me maybe rephrase the problem: currently, for GPIO devices
> > instantiating multiple banks created outside of the OF or ACPI
> > frameworks (e.g. instantiated manually and configured using a
> > hierarchy of software nodes with a single parent swnode and a number
> > of child swnodes representing the children), it is impossible to
> > assign firmware nodes other than the one representing the top GPIO
> > device to the gpiochip child devices.
> >
> > In fact if we want to drop the OF APIs entirely from gpiolib - this
> > would be the right first step as for gpio-sim it actually replaces the
> > gc->of_node = some_of_node; assignment that OF-based drivers do for
> > sub-nodes defining banks and it does work with device-tree (I verified
> > that too) thanks to the fwnode abstraction layer.
>
> In exchange of acknowledgements I confirm that I understood the issue
> you are describing. What I still don't like is this band-aid:ish approach.
> What we really need is to replace of_node by fwnode in GPIO library once
> for all. But it can be done later after your simulation series (or before,
> i.o.w. independently), hence I propose to update TODO and do it separately.
>

But this is what we already do for OF. How would the core gpiolib know
how the firmware nodes represent the banks? It's the driver's job to
tell the framework which node corresponds with what. If anything, we
should start replacing of_nodes with fwnodes in drivers and eventually
we'd drop the of_node pointer from gpio_chip entirely, but we'd keep
the fwnode pointer I added as the driver still needs to assign it
itself.

Again: I may be missing something here but I've been going through
this on and on and can't figure out any other way. Looking at
gpiolib-acpi.c I don't see it correctly assigning fwnodes to
sub-devices either but I don't have any HW to test it.

As for this series: I can't really drop this patch as gpio-sim relies
on swnodes being correctly associated with gpio_chips to identify the
gpiodevs from configfs callbacks.

Bart
