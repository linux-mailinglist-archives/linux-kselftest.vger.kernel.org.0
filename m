Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56D145EF95
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 15:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbhKZOML (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 09:12:11 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51284 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbhKZOKL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 09:10:11 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7BE081FD38;
        Fri, 26 Nov 2021 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637935617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sJa//bALhDjnLcw9oy0p5+f1aMnGtgYvTAX2/sbsreo=;
        b=VrpzrAqvkXgaWsuCy1q3R2dJ66OyEj/8vUiOovjbL36hCUOWxE9BBio59XlN0W6VQOMMpT
        3fXbhA4JHQJ66f+RaC3+1fMsAPb02bB3yZF6YZeIYfVUN6puAvoy79zi8+a9xTXGRl6GCv
        1g9+msZ+19T4OYmv05W3cDJKdI4T7Yw=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 61A82A3B83;
        Fri, 26 Nov 2021 14:06:57 +0000 (UTC)
Date:   Fri, 26 Nov 2021 15:06:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, joe.lawrence@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/livepatch: Test of the API for specifying
 functions to search for on a stack
Message-ID: <YaDp/uVdBuIAIs71@alley>
References: <20211119090327.12811-1-mbenes@suse.cz>
 <20211119090327.12811-4-mbenes@suse.cz>
 <YZ+gIa4dG2uPvSlY@alley>
 <alpine.LSU.2.21.2111261010010.6268@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2111261010010.6268@pobox.suse.cz>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri 2021-11-26 10:20:54, Miroslav Benes wrote:
> On Thu, 25 Nov 2021, Petr Mladek wrote:
> 
> > On Fri 2021-11-19 10:03:27, Miroslav Benes wrote:
> > > Add a test for the API which allows the user to specify functions which
> > > are then searched for on any tasks's stack during a transition process.
> > > 
> > The approach with debugfs is an interesting trick. Though, I slightly
> > prefer using the scheduled work. The workqueue API looks less tricky
> > to me than sysfs/debugfs API. Also it does not block the module
> > in the init() callback[*]. But I might be biased.
> 
> It seemed to me that debugfs gave us more control over the process than 
> workqueues, but I do not really care. Could you explain the blocking in 
> the init callback? I do not follow.

Good question about the blocking! Please, forget it. I am not sure
why I thought that the module might get blocked in the module_init()
script.


> > Anyway, it might make sense to use the same trick in both situations.
> > It would make it easier to maintain the test modules.
> 
> True. So I will rewrite it to workqueues as you are proposing below.
> 
> > [*] There is actually a race in the workqueue approach. The module
> > init() callback should wait until the work is really scheduled
> > and sleeping. It might be achieved by similar hand-shake like
> > with @block_transition variable. Or completion API might be
> > even more elegant.
> > 
> > 
> > > +	pr_info("%s exit\n", __func__);
> > > +}
> > > +
> > > +static noinline void child2_function(void)
> > > +{
> > > +	pr_info("%s\n", __func__);
> > > +}
> > > +
> > > +static noinline void parent_function(void)
> > > +{
> > > +	pr_info("%s enter\n", __func__);
> > > +	child_function();
> > > +	child2_function();
> > 
> > This would deserve some explanation what we try to simulate here
> > and how it is achieved. It is not easy for me even with the background
> > that I have freshly in my mind.
> > 
> > Also I think about more descriptive names ;-)
> 
> Hey, I thought it was self-explaining :). So, yes, I started with the 
> example given in the .fixup thread, but it is not really tied to .cold 
> section, jumps or whatever. The setup is just used to test a new API. 
> Moreover, the .fixup example is just a one scenario the new API tries to 
> solve.

OK, single child() function should be enough for testing the behavior.
We might sleep/wait in the parent().

I think that I was confused by the two child() functions. It looked
like sleeping in a child function was important. And the "same"
name of the two children did not help much to understand and
distinguish the purpose.

> What you propose below, that is function names and comments, is a bit 
> confusing for me. Especially if I did not know anything about the original 
> issue (which will be the case in a couple of weeks when I forget 
> everything).
> 
> So I think it I will stick to brevity unless you or someone else really 
> insist.

No, I do not resist on the complicated exmaple. When thinking about
it, the easier test case the better. It should be enough to describe
the real-life purpose of the API in the patch that introduces the API.

> I can improve tests description in 
> tools/testing/selftests/livepatch/test-func-stack.sh if it helps anything.

Yes, please. I miss some top-level descriptions of the tested
functionality, something like:

# Tests for "bla bla" feature.
# It allows to block transition of a process when it is running
# parent() function and only the child() function is livepatched.

# This test does not use the feature. The transition finishes even
# before parent() exits.

# In this test case, the livepatch is instructed to check also
# parent() on stack. The transition must not finish before
# parent() exists.

It would be nice to have these high-level descriptions even in
the test modules.

Best Regards,
Petr
