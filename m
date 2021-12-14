Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC5A474BF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 20:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbhLNTcB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 14:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbhLNTcA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 14:32:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B31C061747
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 11:31:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m6so27043634lfu.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 11:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sharpeleven-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CSsQizS2Alccn09uVVHMhRrxYpQSyu5zyJjpNQE3tlI=;
        b=sf8PduFp6j+NjHLIpIDvQ4RC318EDH6SD3pXBY8xfLup36IkrZVN9oQ+iwUc+uldQE
         XfARii3Mm4ENAJDWhQ2aqollunGkuGZQqDuyEhBie3Qzb4qdcwLZmMc5+0CKeFL3NiRr
         Lm9gGApSYH53GjDTMQcbbMXqwjFAbIQtPHvpL3uo4xNqUgXY6zdIzQIl8iie1hfdPqwZ
         lLgv3NrQA9H1tLpvfl/Ti7SwOb/pzX3wIhn6gZfUmExuxM4eZI/omnNoTvAHKthYywNU
         s8LcP8l8Ye4ax2Vru+5+asaMOfzIr3AXQpo3D2mWkeb6a36bIyJTNPo5LqHk0KI09ETS
         /fMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSsQizS2Alccn09uVVHMhRrxYpQSyu5zyJjpNQE3tlI=;
        b=cTv3yzCr5Kfj9lDNROlpacRhJhPDg36s5KSWXOik7FiUUviyxMQxSup9qkoxM7qJCp
         ZRTfrmhJsl3Wh3k6rJRB4/cdpDFmJZaSiH/2NRbU2evmNML2kFeNIHRuzM9NH30U8j4I
         TyV4WZ5u1ZVhv2gAoWV2MHeajZI0Nij7RVdRfJI2UdWePdw06c66VYZIhuPzWbncYPy5
         9HfhSqPa2hjZqYHR4iK+zlPcViTrOL4HTQ+WSasNZPnBT3YkVHXH2wm8C9ao0UcKXpmB
         Ny5j3ebFBUKUfIaHbLBvgVmuj+/hwGH/pUcVvYxhRvGk7gGBHiAt5RpHpViAdC6wBKdp
         1OXg==
X-Gm-Message-State: AOAM5333G98TNcs2W4Jt9ptKKqqQTzwV5ZNPpIc/j724y2wcdV0DZJIG
        kWuR/EDZq0uLaZWwy+njAd9K1yhVy/gpGZ0otEZXog==
X-Google-Smtp-Source: ABdhPJzLUx4mda4fQ7H0Ga9lBWntpZB7VpWdQX2o1dcRwm3prFV7nNv/EX6mBWmoe0www35mz1g39dVYV3eVfxoc5SQ=
X-Received: by 2002:ac2:5499:: with SMTP id t25mr6633200lfk.674.1639510317616;
 Tue, 14 Dec 2021 11:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20211029184500.2821444-1-mcgrof@kernel.org> <20211029184500.2821444-4-mcgrof@kernel.org>
 <Yao3vtSKBKLyQY1E@kroah.com> <YbFgaSPPw4Y3pJoB@bombadil.infradead.org>
In-Reply-To: <YbFgaSPPw4Y3pJoB@bombadil.infradead.org>
From:   Richard Fontana <fontana@sharpeleven.org>
Date:   Tue, 14 Dec 2021 14:31:46 -0500
Message-ID: <CAGT84B35yEjPxtu=cShoxCNzi8kaYDBbHDsu9-g0UhdFrCS6Lg@mail.gmail.com>
Subject: Re: [copyleft-next] Re: [PATCH v9 3/6] selftests: add tests_sysfs module
To:     Discussion and development of copyleft-next 
        <copyleft-next@lists.fedorahosted.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        jeyu@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, shuah@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-spdx@vger.kernel.org,
        tj@kernel.org, dan.j.williams@intel.com, bvanassche@acm.org,
        linux-kselftest@vger.kernel.org, joe@perches.com,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        minchan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

 On Wed, Dec 8, 2021 at 8:52 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Dec 03, 2021 at 04:29:02PM +0100, Greg KH wrote:
> > On Fri, Oct 29, 2021 at 11:44:57AM -0700, Luis Chamberlain wrote:

> > > diff --git a/lib/test_sysfs.c b/lib/test_sysfs.c
> > > new file mode 100644
> > > index 000000000000..2a6ec072da60
> > > --- /dev/null
> > > +++ b/lib/test_sysfs.c
> > > @@ -0,0 +1,894 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
> >
> > Again, sorry, but no, I am going to object to this license as you are
> > only accessing a GPL-v2-only api.  Any other license on a file that
> > interacts with that, especially for core stuff like testing the
> > functionality of this code, needs to have that same license.  Sorry.
>
> Huh? The license is GPL-v2 compatible, and when used in the kernel the
> GPLv2 applies.
>
> Likewise, are you taking the position that permissively licensed code,
> say BSD or ISC licensed code, cannot use EXPORT_SYMBOL_GPL() symbols?

Just chiming in here, not really because of any association with the
copyleft-next license (or GPLv2 for that matter) but because of
general personal immersion in open source licensing. I would think
that code interacting with a GPLv2-only api could be under any
GPLv2-only-compatible license, such as ISC, GPLv2-or-later, or
copyleft-next. That said, of course kernel maintainers can establish
stricter policies around acceptable forms of licensing.

Richard
