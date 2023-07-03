Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB17745F7B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 17:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGCPJH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 11:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjGCPJG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 11:09:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AE5E44;
        Mon,  3 Jul 2023 08:09:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6004960F99;
        Mon,  3 Jul 2023 15:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595B7C433C8;
        Mon,  3 Jul 2023 15:08:59 +0000 (UTC)
Date:   Mon, 3 Jul 2023 11:08:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v3 03/10] eventfs: adding eventfs dir add functions
Message-ID: <20230703110857.2d051af5@rorschach.local.home>
In-Reply-To: <ECB0097D-A323-4CFC-9C9E-D4DA2AA6E662@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
        <1685610013-33478-4-git-send-email-akaher@vmware.com>
        <20230701095417.3de5baab@rorschach.local.home>
        <ECB0097D-A323-4CFC-9C9E-D4DA2AA6E662@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 3 Jul 2023 10:13:22 +0000
Ajay Kaher <akaher@vmware.com> wrote:

> >> +/**
> >> + * eventfs_down_write - acquire write lock function
> >> + * @eventfs_rwsem: a pointer to rw_semaphore
> >> + *
> >> + * helper function to perform write lock on eventfs_rwsem
> >> + */
> >> +static void eventfs_down_write(struct rw_semaphore *eventfs_rwsem)
> >> +{
> >> +     while (!down_write_trylock(eventfs_rwsem))
> >> +             msleep(10);  
> >
> > What's this loop for? Something like that needs a very good explanation
> > in a comment. Loops like these are usually a sign of a workaround for a
> > bug in the design, or worse, simply hides an existing bug.
> >  
> 
> Yes correct, this logic is to solve deadlock:
> 
> Thread 1                             Thread 2
> down_read_nested()                                 - read lock acquired
>                                          down_write()     - waiting for write lock to acquire
> down_read_nested()                                  - deadlock
> 
> Deadlock is because rwlock wouldn’t allow read lock to be acquired if write lock is waiting.
> down_write_trylock() wouldn’t add the write lock in waiting queue, hence helps to prevent
> deadlock scenario.
> 
> I was stuck with this Deadlock, tried few methods and finally borrowed from cifs, as it’s
> upstreamed, tested and working in cifs, please refer:
> https://elixir.bootlin.com/linux/v6.3.1/source/fs/cifs/file.c#L438

I just looked at that code and the commit, and I honestly believe that
is a horrible hack, and very fragile. It's in the smb code, so it was
unlikely reviewed by anyone outside that subsystem. I really do not
want to prolificate that solution around the kernel. We need to come up
with something else.

I also think it's buggy (yes the cifs code is buggy!) because in the
comment above the down_read_nested() it says:

/*
 * nested locking. NOTE: rwsems are not allowed to recurse
 * (which occurs if the same task tries to acquire the same
 * lock instance multiple times), but multiple locks of the
 * same lock class might be taken, if the order of the locks
 * is always the same. This ordering rule can be expressed
 * to lockdep via the _nested() APIs, but enumerating the
 * subclasses that are used. (If the nesting relationship is
 * static then another method for expressing nested locking is
 * the explicit definition of lock class keys and the use of
 * lockdep_set_class() at lock initialization time.
 * See Documentation/locking/lockdep-design.rst for more details.)
 */

So this is NOT a solution (and the cifs code should be fixed too!)

Can you show me the exact backtrace where the reader lock gets taken
again? We will have to come up with a way to not take the same lock
twice.

We can also look to see if we can implement this with RCU. What exactly
is this rwsem protecting?


> 
> Looking further for your input. I will add explanation in v4.
> 
> 
> >> +}
> >> +

[..]

> >> + *
> >> + * This function creates the top of the trace event directory.
> >> + */
> >> +struct dentry *eventfs_create_events_dir(const char *name,
> >> +                                      struct dentry *parent,
> >> +                                      struct rw_semaphore *eventfs_rwsem)  
> >
> > OK, I'm going to have to really look at this. Passing in a lock to the
> > API is just broken. We need to find a way to solve this another way.  
> 
> eventfs_rwsem is a member of struct trace_array, I guess we should
> pass pointer to trace_array.

No, it should not be part of the trace_array. If we can't do this with
RCU, then we need to add a descriptor that contains the dentry that is
returned above, and have the lock held there. The caller of the
eventfs_create_events_dir() should not care about locking. That's an
implementation detail that should *not* be part of the API.

That is, if you need a lock:

struct eventfs_dentry {
	struct dentry		*dentry;
	struct rwsem		*rwsem;
};

And then get to that lock by using the container_of() macro. All
created eventfs dentry's could have this structure, where the rwsem
points to the top one. Again, that's only if we can't do this with RCU.

-- Steve


> 
> 
> > I'm about to board a plane to JFK shortly, I'm hoping to play with this
> > while flying back.
> >  
> 
> I have replied for major concerns. All other minor I will take care in v4.
> 
> Thanks a lot for giving time to eventfs patches.
> 
> - Ajay
> 
