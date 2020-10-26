Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2801C298A1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 11:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768422AbgJZJsN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 05:48:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:47420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768410AbgJZJsN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 05:48:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603705691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SlRTfCqLtyIBSnFe1uknaKbGad8itHiONy0aNY9FDgo=;
        b=JhFDzd3J++hEnEzoRBaqwNWv2fiLphklER9BPvVbuQwTMEi8uzeaOfKsoLXM2yLuyKcr5X
        I8nZTO8D3hFAHiJvimHHlxm7iJcufndpC0AhaJuxydfSsuznKUmN+cTRDJ0e1AHY6tM+zX
        yYbzVwgKoyxVx+rXolhn++ggmuAvh8A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01CBEB2CB;
        Mon, 26 Oct 2020 09:48:11 +0000 (UTC)
Date:   Mon, 26 Oct 2020 10:48:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>, kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] lib: Convert test_printf.c to KUnit
Message-ID: <20201026094810.GJ32486@alley>
References: <20201022151349.47436-1-98.arpi@gmail.com>
 <20201023173108.GG32486@alley>
 <CAHp75VeEcb3CtQWeZXQz-UFMgqL6ERwDjudPmcCCNJgHesb3pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeEcb3CtQWeZXQz-UFMgqL6ERwDjudPmcCCNJgHesb3pg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun 2020-10-25 14:38:13, Andy Shevchenko wrote:
> On Sat, Oct 24, 2020 at 2:07 AM Petr Mladek <pmladek@suse.com> wrote:
> > On Thu 2020-10-22 20:43:49, Arpitha Raghunandan wrote:
> > > Convert test lib/test_printf.c to KUnit. More information about
> 
> ...
> 
> > > not ok 1 - printf-kunit-test
> >
> > > --- a/lib/test_printf.c
> > > +++ b/lib/printf_kunit.c
> >
> > There is no standard at the moment.
> 
> JFYI: from v5.10-rc1 it is expected to have documentation clarifying
> the naming scheme. Also there is a pending series [1] to move KUnit
> based test cases to the defined schema.
>
> > Please, either unify names of all the above modules or keep test_printf.c
> 
> [1]: https://lore.kernel.org/linux-kselftest/20201016110836.52613-1-andriy.shevchenko@linux.intel.com/

Great, thanks for the pointer. I seems that this patch actually
follows the proposed naming schema. I am fine with it then.

Best Regards,
Petr
