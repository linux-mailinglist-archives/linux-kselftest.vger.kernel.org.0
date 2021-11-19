Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BE9456DDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 11:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhKSLAg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 06:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhKSLAf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 06:00:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C567C061574;
        Fri, 19 Nov 2021 02:57:34 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso8552769pjb.0;
        Fri, 19 Nov 2021 02:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yXWru8Y/zGzIEgDibnYqUEohYi+J5qhkV9k7sQLjDGg=;
        b=MAn8fuJgScM2d464FqGzea1ztZqryKLoRZwXHvcL5s2a6GUY9/z3kCffgCsZkJexRx
         OjKgJq/WaDUyd0PUygJzVear8OlKYYADjqC+l0iij9Oi0zll1gDRWzpvEFmUbotnzh0b
         QYVHnZMzovQAoffnZ8c2C0t/390FwR86knjOdIPKwVbLB9slGrMwjGE3oCV2Abnf5G/w
         kPKBKIh2RC54lMLyNJMC5EijShUMvf9zlFvLHsIBhr2dozCJpaB9tKACbYtfUNMyESk+
         /euhcCbSsSexZKR/64E/wU/mC+WvwrUWpcff2zOaid2kgn0CdGop1yh7ZznS6Gz5PgkH
         naJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yXWru8Y/zGzIEgDibnYqUEohYi+J5qhkV9k7sQLjDGg=;
        b=uAtj/2aVKWS058ju0D4WOTC0r1ZKU0GE24YOLEcPe7Ldr3eUJJ8JHKMBqA9R93UuSj
         9l6BDXr3qLLr27I6mlHtj+bzxtCtH5GuuFAP0ootYYiixyYMf5Mxz1hwXwUtcsJ87+o8
         lztZRJqUOa6OdVzd6Z8I8EggCvYzlKMSnMFaB3Viar2TqM4wAGbjvT5HqIL/3aDdVfez
         /1Zjrjdbpd73dptLA9A0Z+hl0U9ZAZtzYgJmR46WnPliKoSt0FHlT9eaJRkUROsnnkiC
         0LQnwAKKM0I2kzMLXqvzj4B9Fbgkfg5D+a8nL1Q7qEaecdCCYQL/Byr7f9WSHgYGkE8I
         8EeA==
X-Gm-Message-State: AOAM532N6QHcEjeM5F7d+awzDnfX9UHQO2xzxA84P7alEwEwhzh2RcJZ
        Amn1ri4lL86Jl1SYFbxzj30=
X-Google-Smtp-Source: ABdhPJzfcTGRBWEMEEO3v85eKQ5PFI93tR5bdCnOJp5m7pjS9XFna+n2dfQKGf05yTO83wQhvfVa/w==
X-Received: by 2002:a17:90b:1d0e:: with SMTP id on14mr3532603pjb.119.1637319453934;
        Fri, 19 Nov 2021 02:57:33 -0800 (PST)
Received: from sol (14-201-12-235.tpgi.com.au. [14.201.12.235])
        by smtp.gmail.com with ESMTPSA id mq14sm11828624pjb.54.2021.11.19.02.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 02:57:33 -0800 (PST)
Date:   Fri, 19 Nov 2021 18:57:27 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 0/4] gpio-sim: configfs-based GPIO simulator
Message-ID: <20211119105727.GA21048@sol>
References: <20211118145142.14519-1-brgl@bgdev.pl>
 <YZZ1cFWaexGlJL8C@smile.fi.intel.com>
 <CAMRc=MdeEiz+uKhAz5-1MX_KG5fmjshRtDXARPMEx8VwBKfXZQ@mail.gmail.com>
 <YZaGa66iEFb6bJjK@smile.fi.intel.com>
 <CAMRc=MeZrdgxMUxGQ0rFPkSXMto==WrMGPz0Zo8wfdCxM_0+=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeZrdgxMUxGQ0rFPkSXMto==WrMGPz0Zo8wfdCxM_0+=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 19, 2021 at 11:34:59AM +0100, Bartosz Golaszewski wrote:
> On Thu, Nov 18, 2021 at 5:59 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Nov 18, 2021 at 05:37:02PM +0100, Bartosz Golaszewski wrote:
> > > On Thu, Nov 18, 2021 at 4:50 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Thu, Nov 18, 2021 at 03:51:38PM +0100, Bartosz Golaszewski wrote:
> > > > > This is another shot at the gpio-sim testing module. As there was no
> > > > > reasoning with configfs maintainers for many months, this time the whole
> > > > > concept of committable items has been dropped. Instead, each configfs
> > > > > chip item (or rather a group - more on that later) exposes a new
> > > > > attribute called 'live'. Writing 1 to it brings the chip on-line
> > > > > (registers the platform device) and writing 0 tears it down.
> > > > >
> > > > > There are some caveats to that approach - for example: we can't block
> > > > > the user-space from deleting chip items when chips are live but is just
> > > > > handled by silently destroying the chip device in the background.
> > > > >
> > > > > Andy (rightfully) pointed out that parsing of the lists of line names is
> > > > > awkward so in this iteration it's been replaced by a system that is more
> > > > > elegant and will allow to easily extend configuration options for
> > > > > specific GPIO lines. This is achieved by turning the chip's configfs
> > > > > item into a configfs group and allowing the user-space to create
> > > > > additional items inside it. The items must be called line<offset> (e.g.
> > > > > line0, line12 etc.) where the offset part indicates to the module the
> > > > > offset for which given item stores the configuration for. Within each
> > > > > such line item, there are additional attributes that allow specifying
> > > > > configuration for specific lines. Currently we only support the 'name'
> > > > > attribute but I plan to extend that to support GPIO hogging too.
> > > >
> > > > One question here. Since you know how the driver looks like in both cases
> > > > (with and without committable items), would it be possible to modify what
> > > > you proposed here to the former one in case ConfigFS gains the feature?
> > >
> > > This would completely change the user interface unfortunately. We
> > > could extend it but we would need to keep this one too most likely.
> > >
> > > TBH I don't see the committable items merged anytime soon, and this is
> > > GoodEnough®.
> >
> > Fine with me then!
> >
> > Thanks for doing this all, I know it's a bit delayed in terms of getting
> > into upstream.
> >
> > Btw, gpio-mockup testing scripts have an issue that the number of lines to
> > check overflow is hardcoded and since x86_64 switched to 1024 from 512 it
> > reveals the issue. Does gpio-sim solve this in a better way (like telling
> > to user space the ngpios, etc)?
> >
> 
> Yeah the selftests need fixing now.
> 

No, there need to be new selftests added for your gpio-sim.
The existing selftests cover the gpio-mockup itself.

> No, there's no fix for that in gpio-sim - probe() will just fail.
> Which makes me think - maybe we should synchronously wait when writing
> to 'live' for the probe to return (for instance setup a notifier) so
> that we know if the chip probed correctly. Then we can notify the
> user-space about the error destroy the device too.
> 

+1 - need definite feedback to userspace that the change to the test setup
is in place so tests can proceed.  No arbitrary waits or waiting for
events from other subsystems like udev as we have to do with gpio-mockup.

Cheers,
Kent.

