Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870542ED4D2
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Jan 2021 17:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbhAGQyV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Jan 2021 11:54:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:41484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbhAGQyV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Jan 2021 11:54:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610038414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pdu2Y4stVeDASDk2LXn54SiG/OCAKS17/WRR19PCG6Y=;
        b=cZuxRQKeKcDjNzXo7fVYNuoJ3UVoKSS96AVmLCsQ1k7CUVUsHTEjb3eVBCQruNqjgcA4SF
        XTW/TX7L5bmq4qoit3VZD2jqBoAaWd4p77/hZHyKwJmu0wtiLvLCPUxORUQFRF4Jf91RAg
        rfRyAGUqr9+x7h/xKF1c0RUE+ms606U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13BB9AD26;
        Thu,  7 Jan 2021 16:53:34 +0000 (UTC)
Date:   Thu, 7 Jan 2021 17:53:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kunit: tool: Force the use of the 'tty' console for UML
Message-ID: <X/c8jQMyXbsJf85M@alley>
References: <20201222073900.3490607-1-davidgow@google.com>
 <20201222111102.GC4077@smile.fi.intel.com>
 <4ae7779c-15c5-0474-5840-44531dcf1d94@linuxfoundation.org>
 <X/SSJQ+I5zEMaYYJ@alley>
 <3828c7ee-52b0-42f9-5771-74ef9386756c@linuxfoundation.org>
 <20210105185731.GT4077@smile.fi.intel.com>
 <918b2d05-f51b-0866-89b3-19a016abdaa3@linuxfoundation.org>
 <CABVgOS=DZjv4-68fEweZwB1-=KB7Tb71iQEfHKHt46OTVWC94w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOS=DZjv4-68fEweZwB1-=KB7Tb71iQEfHKHt46OTVWC94w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 2021-01-06 12:29:12, David Gow wrote:
> On Wed, Jan 6, 2021 at 3:52 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >
> > On 1/5/21 11:57 AM, Andy Shevchenko wrote:
> > > On Tue, Jan 05, 2021 at 09:34:33AM -0700, Shuah Khan wrote:
> > >> On 1/5/21 9:21 AM, Petr Mladek wrote:
> > >>> On Mon 2021-01-04 09:23:57, Shuah Khan wrote:
> > >>>> On 12/22/20 4:11 AM, Andy Shevchenko wrote:
> > >>>>> On Mon, Dec 21, 2020 at 11:39:00PM -0800, David Gow wrote:
> > >>>>>> kunit_tool relies on the UML console outputting printk() output to the
> > >>>>>> tty in order to get results. Since the default console driver could
> > >>>>>> change, pass 'console=tty' to the kernel.
> > >>>>>>
> > >>>>>> This is triggered by a change[1] to use ttynull as a fallback console
> > >>>>>> driver which -- by chance or by design -- seems to have changed the
> > >>>>>> default console output on UML, breaking kunit_tool. While this may be
> > >>>>>> fixed, we should be less fragile to such changes in the default.
> > >>>>>>
> > >>>>>> [1]:
> > >>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=757055ae8dedf5333af17b3b5b4b70ba9bc9da4e
> > >>>>>
> > >>>>> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >>>>> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >>>>>
> > >>>>
> > >>>> Thank you all. Now in linux-kselftest kunit-fixes branch.
> > >>>>
> > >>>> Will send this up for rc3.
> > >>>>
> > >>>> Sorry for the delay - have been away from the keyboard for a
> > >>>> bit.
> > >>>
> > >>> JFYI, I am not sure that this is the right solution. I am
> > >>> looking into it, see
> > >>> https://lore.kernel.org/linux-kselftest/X%2FSRA1P8t+ONZFKb@alley/
> > >>> for more details.
> > >>>
> > >>
> > >> Thanks Petr. I will hold off on sending the patch up to Linus and
> > >> let you find a the right solution.
> > >
> > > Please. leave it in Linux Next at least. Otherwise kunit will be broken for a
> > > long time which is not good.
> > >
> > >
> >
> > Yes. That is the plan. It will be in there until real fix comes in.

The real fix would be too complicated for 5.11-rc3. Instead, I
proposed to revert the problematic commit, see
https://lore.kernel.org/lkml/20210107164400.17904-2-pmladek@suse.com/
I would like to push it for 5.11-rc3.

> Personally, I think that this patch makes some sense to keep even if
> the underlying issue with ttynull is resolved. Given that kunit.py
> requires the console output, explicitly stating we want console=tty
> set is probably worth doing rather than relying on it being the
> default.

I agree that the patch makes sense on its own. kunit depends on the
particular console. Note that "tty" is actually the UML-specific
stdio console implemented in arch/um/drivers/stdio_console.c.

Best Regards,
Petr
