Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE407412B89
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Sep 2021 04:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347086AbhIUCTg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Sep 2021 22:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbhIUBuE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:04 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44470C06AB0C
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Sep 2021 14:55:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h3so18761277pgb.7
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Sep 2021 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amBkTo8paIO6KKoyr0sD3I13KXEgBWAgALAI9bRUOrY=;
        b=XL3OFLcRkLeLa9eXRmHa7cKmBwEZybbc9mdJnrjPUsNmyhIp9vj8F3iNcHNSqXTb1K
         L9OEBMzu/TTeVT/s4PldqIkTZ0HgtlJEgIwwbfok6X1NLdtuYuyvrzXuuS1QyCQHhDf3
         FY2aphwijxMkpTX43r3twUk5IdFvYJi1wu5sZUQ0IQCbDLg80wgE3Q0dm575Bea3zf1f
         JfQJ5ifnA2ISAORhBlZA82ZPIyQ2zFi5MELZoyko92jJrrmD7LWhkltsG8XSY3PQ3mqC
         YdMiNP+ggNC5rUbR8bzVM/xfxgJFK13EPKdACqQQqNx9Bpea47bYvjeXMJ6UV3MCOnZ/
         JrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amBkTo8paIO6KKoyr0sD3I13KXEgBWAgALAI9bRUOrY=;
        b=3mcG/yr1zdHeTHOJgbl2zZ0WVlboafZ/6hfo//2pUg4s0b7n5OO0MiCv0A1iLNmoN4
         crrkmz2FbWpxep2EpuymVoXtaZeWncPxlnYN2CYuOroVCHVq1M5AojDhJVCcokXs6OjM
         Cmoc5TnT8PFvjUNhNbO2L81rPeKBmQ17I/3Ayfr564AY5lQPsDbehoZeQRbKcqE93fn2
         sbNoDK2IHR89ZMTlz/70w6M9imItg61serfq2IeMzV3eOxGTS+JFCQqYciNEt9iq08R3
         OIc7V5xncQLdis5kPdFdCEXT9Aa2i6AZzKd+xeznLGMNgU8hmkw34/NzJ8PUaZmkhjVO
         37EQ==
X-Gm-Message-State: AOAM532AV8vbwZJkbNcksXRazjrQi2xSkxVhUQ1si/K158tFcZFbMlnE
        AUNTspnzHJ8XJlrzcK+XXl/jVn+J7BKRSuY0bcmgdg==
X-Google-Smtp-Source: ABdhPJwBWi/pa4o5rVuzlrO7QoclxHzSHljmGejbBs+BPyI0/4Ad8yRwI26n/BXik+g+dmpD6uwLMi2rTRHApy0oOl0=
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr25231633pge.5.1632174921576;
 Mon, 20 Sep 2021 14:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210918050430.3671227-1-mcgrof@kernel.org> <20210918050430.3671227-10-mcgrof@kernel.org>
 <CAPcyv4i0xEwMQ5kSK-xGroV7aZr3j1YNrGMVLiLMr3U8nFCMKA@mail.gmail.com> <YUj6TrGbqlNI0OGC@bombadil.infradead.org>
In-Reply-To: <YUj6TrGbqlNI0OGC@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 Sep 2021 14:55:10 -0700
Message-ID: <CAPcyv4jFaNTfpKq6hQsFrWXTwHz-wG+5K4m-hmsPeteLX4p5AQ@mail.gmail.com>
Subject: Re: [PATCH v7 09/12] sysfs: fix deadlock race with module removal
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, jeyu@kernel.org,
        shuah <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, yzaikin@google.com,
        Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        vitor@massaru.org, elver@google.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        rf@opensource.cirrus.com,
        Stephen Hemminger <stephen@networkplumber.org>,
        David Laight <David.Laight@aculab.com>, bvanassche@acm.org,
        jolsa@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        trishalfonso@google.com, andreyknvl@gmail.com,
        Jiri Kosina <jikos@kernel.org>, mbenes@suse.com,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, lizefan.x@bytedance.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        senozhatsky@chromium.org, Christoph Hellwig <hch@lst.de>,
        Joe Perches <joe@perches.com>, hkallweit1@gmail.com,
        Jens Axboe <axboe@kernel.dk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-spdx@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        copyleft-next@lists.fedorahosted.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 20, 2021 at 2:17 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Sep 20, 2021 at 01:52:21PM -0700, Dan Williams wrote:
> > On Fri, Sep 17, 2021 at 10:05 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > This deadlock was first reported with the zram driver, however the live
> > > patching folks have acknowledged they have observed this as well with
> > > live patching, when a live patch is removed. I was then able to
> > > reproduce easily by creating a dedicated selftests.
> > >
> > > A sketch of how this can happen follows:
> > >
> > > CPU A                              CPU B
> > >                                    whatever_store()
> > > module_unload
> > >   mutex_lock(foo)
> > >                                    mutex_lock(foo)
> > >    del_gendisk(zram->disk);
> > >      device_del()
> > >        device_remove_groups()
> >
> > This flow seems possible to trigger with:
> >
> >    echo $dev > /sys/bus/$bus/drivers/$driver/unbind
> >
> > I am missing why module pinning
>
> The aspect of try_module_get() which comes to value to prevent the
> deadlock is it ensures kernfs ops do not run once exit is on the way.
>
> > is part of the solution when it's the
> > device_del() path that is racing?
>
> But its not, the device_del() path will yield until the kernfs op
> completes. It is fine to wait there.
>
> The deadlock happens if a module exit routine uses a lock which is
> also used on a sysfs op. If the lock was first held by module exit,
> and module exit is waiting for the kernfs op to complete, and the
> kernfs op is waiting to hold the same lock then the exit will wait
> forever.
>
> > Module removal is just a more coarse
> > grained way to trigger unbind => device_del().
>
> Right, but the device_del() path is not sharing a lock with the sysfs op.

The deadlock in the example comes from holding a lock over
device_del() that is also taken in a kernfs op.  For example, the code
above looks like something that runs from driver.remove(), not
exclusively module_exit(). Yes, module_exit() may trigger
driver.remove() via driver_unregister(), but there's other ways to
trigger driver.remove() that do not involve module_exit().

> > Isn't the above a bug
> > in the driver, not missing synchronization in kernfs?
>
> We can certainly take the position as an alternative:
>
>   "thou shalt not use a lock on exit which is also used on a syfs op"
>
> However that seems counter intuitive, specially if we can resolve the
> issue easily with a try_module_get().

Again, I don't see how try_module_get() can affect the ABBA failure
case of holding a lock over device_del() that is also held inside
sysfs op. I agree that the problem is subtle. Does lockdep not
complain about this case? If it's going to be avoided in the core it
seems try_module_get() does not completely cover the hole that
unsuspecting driver writers might fall into.
