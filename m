Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6045EA45
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 10:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhKZJ0J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 04:26:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56396 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhKZJYI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 04:24:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D413221B42;
        Fri, 26 Nov 2021 09:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637918454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zBpWvf+kAMMymE7jwLR0q+Urs4XEYr931dgHxUeZGE=;
        b=Vz91wepC3CRNit4j/+OwNcQ79IxEVR2ZgchUcmsK16W5dZVJk0Qp9BuW5/AuMWUfqY13yb
        DSoLHfko5/lshJlj/m4dMV+AVOQ99Kf813DWMpCeDPrxTSgFA1g0fubRaR883vjkTeiWuM
        7EtgYTWuop14eZIqPV/iu3c5sVdUaCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637918454;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zBpWvf+kAMMymE7jwLR0q+Urs4XEYr931dgHxUeZGE=;
        b=dqAIm0YG+mOiUnxqz4bKEilXa+H3FsV6vO3epi6uMlWgiU3YDyshgcgurrLXGF+tFJvP4I
        nwRneqKKweA9tbCQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B9994A3B81;
        Fri, 26 Nov 2021 09:20:54 +0000 (UTC)
Date:   Fri, 26 Nov 2021 10:20:54 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     jpoimboe@redhat.com, jikos@kernel.org, joe.lawrence@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/livepatch: Test of the API for specifying
 functions to search for on a stack
In-Reply-To: <YZ+gIa4dG2uPvSlY@alley>
Message-ID: <alpine.LSU.2.21.2111261010010.6268@pobox.suse.cz>
References: <20211119090327.12811-1-mbenes@suse.cz> <20211119090327.12811-4-mbenes@suse.cz> <YZ+gIa4dG2uPvSlY@alley>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 25 Nov 2021, Petr Mladek wrote:

> On Fri 2021-11-19 10:03:27, Miroslav Benes wrote:
> > Add a test for the API which allows the user to specify functions which
> > are then searched for on any tasks's stack during a transition process.
> > 
> > --- /dev/null
> > +++ b/lib/livepatch/test_klp_funcstack_mod.c
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2021 Miroslav Benes <mbenes@suse.cz>
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/delay.h>
> > +
> > +static int sleep_length = 10000;
> > +module_param(sleep_length, int, 0644);
> > +MODULE_PARM_DESC(sleep_length, "length of sleep in seconds (default=10)");
> > +
> > +static noinline void child_function(void)
> > +{
> > +	pr_info("%s enter\n", __func__);
> > +	msleep(sleep_length);
> 
> The hardcoded sleep is not ideal. It might be too low or non-necessary high.

It is not.
 
> If I get it correctly, we are trying to achieve here the same as
> busymod_work_func() in test_klp_callbacks_busy.c.

Yes.

> The approach with debugfs is an interesting trick. Though, I slightly
> prefer using the scheduled work. The workqueue API looks less tricky
> to me than sysfs/debugfs API. Also it does not block the module
> in the init() callback[*]. But I might be biased.

It seemed to me that debugfs gave us more control over the process than 
workqueues, but I do not really care. Could you explain the blocking in 
the init callback? I do not follow.

> Anyway, it might make sense to use the same trick in both situations.
> It would make it easier to maintain the test modules.

True. So I will rewrite it to workqueues as you are proposing below.

> [*] There is actually a race in the workqueue approach. The module
> init() callback should wait until the work is really scheduled
> and sleeping. It might be achieved by similar hand-shake like
> with @block_transition variable. Or completion API might be
> even more elegant.
> 
> 
> > +	pr_info("%s exit\n", __func__);
> > +}
> > +
> > +static noinline void child2_function(void)
> > +{
> > +	pr_info("%s\n", __func__);
> > +}
> > +
> > +static noinline void parent_function(void)
> > +{
> > +	pr_info("%s enter\n", __func__);
> > +	child_function();
> > +	child2_function();
> 
> This would deserve some explanation what we try to simulate here
> and how it is achieved. It is not easy for me even with the background
> that I have freshly in my mind.
> 
> Also I think about more descriptive names ;-)

Hey, I thought it was self-explaining :). So, yes, I started with the 
example given in the .fixup thread, but it is not really tied to .cold 
section, jumps or whatever. The setup is just used to test a new API. 
Moreover, the .fixup example is just a one scenario the new API tries to 
solve.

What you propose below, that is function names and comments, is a bit 
confusing for me. Especially if I did not know anything about the original 
issue (which will be the case in a couple of weeks when I forget 
everything).

So I think it I will stick to brevity unless you or someone else really 
insist.

I can improve tests description in 
tools/testing/selftests/livepatch/test-func-stack.sh if it helps anything.

Miroslav

> What about something like this (using workqueue work and completion):
> 
> /*
>  * Simulate part of the caller code that is in another .elf section
>  * and is reached via jump. It this was really the case then the stack
>  * unwinder might not be able to detect that the process is sleeping
>  * in the caller.
>  */
> static void simulate_jump_part(void)
> {
> 	pr_info("%s enter\n", __func__);
> 
> 	/* Stay in the jump part unless told to leave. */
> 	wait_for_completion(finish_jump);
> 
> 	pr_info("%s exit\n", __func__);
> }
> 
> /*
>  * Simulate modified part of the caller code. It should never get
>  * livepatched when the caller is sleeping in the just_part().
>  */
> static void simulate_modified_part(void)
> {
> 	pr_info("%s\n", __func__);
> }
> 
> static void test_not_on_stack_func_work(struct work_struct *work)
> {
> 	pr_info("%s enter\n", __func__);
> 
> 	/* Simulation ready */
> 	complete(work_started);
> 
> 	simulate_jump_part();
> 	simulate_modified_part();
> 
> 	pr_info("%s exit\n", __func__);
> }
> 
> static int test_klp_no_on_stack_init(void)
> {
> 	pr_info("%s\n", __func__);
> 
> 	schedule_work(&work);
> 	wait_for_completion(&work_started);
> 
> 	return 0;
> }
> 
> static void test_not_on_stack_exit(void)
> {
> 	complete(&finish_jump);
> 	flush_work(&work);
> 	pr_info("%s\n", __func__);
> }
> 
> module_init(test_klp_not_on_stack_init);
> module_exit(test_klp_not_on_stack_exit);
> 
> > +	pr_info("%s exit\n", __func__);
> > +}
> > +

