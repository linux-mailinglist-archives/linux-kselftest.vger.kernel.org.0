Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B163C2981BE
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Oct 2020 14:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416147AbgJYNBF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Oct 2020 09:01:05 -0400
Received: from fgw21-7.mail.saunalahti.fi ([62.142.5.82]:34216 "EHLO
        fgw21-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1416145AbgJYNBF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Oct 2020 09:01:05 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Oct 2020 09:01:04 EDT
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id e49f1d72-16bf-11eb-9eb8-005056bdd08f;
        Sun, 25 Oct 2020 14:44:59 +0200 (EET)
Date:   Sun, 25 Oct 2020 14:44:59 +0200
From:   andy@surfacebook.localdomain
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sjpark@amazon.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] kunit: tool: Mark 'kunittest_config' as constant
 again
Message-ID: <20201025124459.GA1157488@surfacebook.localdomain>
References: <CAFd5g44CxPuXbHund397PJSQPHGhWy1-7ij7JnJNzCO0NF6dCA@mail.gmail.com>
 <20201022063526.12554-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022063526.12554-1-sjpark@amazon.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 22, 2020 at 08:35:26AM +0200, SeongJae Park wrote:
> On Wed, 21 Oct 2020 14:32:52 -0700 Brendan Higgins <brendanhiggins@google.com> wrote:
> 
> > On Mon, Oct 12, 2020 at 3:27 AM SeongJae Park <sjpark@amazon.com> wrote:
> > >
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > 'kunit_kernel.kunittest_config' was constant at first, and therefore it
> > > used UPPER_SNAKE_CASE naming convention that usually means it is
> > > constant in Python world.  But, commit e3212513a8f0 ("kunit: Create
> > > default config in '--build_dir'") made it modifiable to fix a use case
> > > of the tool and thus the naming also changed to lower_snake_case.
> > > However, this resulted in a confusion.  As a result, some successing
> > > changes made the tool unittest fail, and a fix[1] of it again incurred
> > > the '--build_dir' use case failure.
> > >
> > > As the previous commit fixed the '--build_dir' use case without
> > > modifying the variable again, this commit marks the variable as constant
> > > again with UPPER_SNAKE_CASE, to reduce future confusions.
> > >
> > > [1] Commit d43c7fb05765 ("kunit: tool: fix improper treatment of file location")
> > >
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > 
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
> Thanks :)
> 
> > 
> > Thanks for this! This is something I meant to fix a while ago and forgot about.
> > 
> > One minor issue, this patch does not apply on torvalds/master right
> > now. Could you please rebase this?
> 
> Surely of course, I will send next version soon.

May I ask what happened to [1]?
I mean it seems these two are goind to collide.

Brendan?

[1]: https://lore.kernel.org/linux-kselftest/20201015152348.65147-1-andriy.shevchenko@linux.intel.com/


-- 
With Best Regards,
Andy Shevchenko


