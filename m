Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E774DDBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 21:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjGJTGN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 15:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGJTGN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 15:06:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C3913D;
        Mon, 10 Jul 2023 12:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03024611A5;
        Mon, 10 Jul 2023 19:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C4AC433C7;
        Mon, 10 Jul 2023 19:06:07 +0000 (UTC)
Date:   Mon, 10 Jul 2023 15:06:06 -0400
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
Message-ID: <20230710150606.2c8d2236@gandalf.local.home>
In-Reply-To: <285B9992-4DFB-4343-BD64-DAE9CCEFEE6B@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
        <1685610013-33478-4-git-send-email-akaher@vmware.com>
        <20230701095417.3de5baab@rorschach.local.home>
        <ECB0097D-A323-4CFC-9C9E-D4DA2AA6E662@vmware.com>
        <20230703110857.2d051af5@rorschach.local.home>
        <84CA259A-8A99-471C-B44C-08D289972F43@vmware.com>
        <20230703155226.1ab27bc1@gandalf.local.home>
        <20230709215447.536defa6@rorschach.local.home>
        <285B9992-4DFB-4343-BD64-DAE9CCEFEE6B@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 10 Jul 2023 18:53:53 +0000
Ajay Kaher <akaher@vmware.com> wrote:

> > On 10-Jul-2023, at 7:24 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > !! External Email
> >
> > On Mon, 3 Jul 2023 15:52:26 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >  
> >> On Mon, 3 Jul 2023 18:51:22 +0000
> >> Ajay Kaher <akaher@vmware.com> wrote:
> >>  
> >>>>
> >>>> We can also look to see if we can implement this with RCU. What exactly
> >>>> is this rwsem protecting?
> >>>>  
> >>>
> >>> - struct eventfs_file holds the meta-data for file or dir.
> >>> https://github.com/intel-lab-lkp/linux/blob/dfe0dc15a73261ed83cdc728e43f4b3d4e315aae/include/linux/tracefs.h#L28
> >>> - eventfs_rwsem is supposed to protect the 'link-list which is made of struct eventfs_file
> >>> ' and elements of struct eventfs_file.  
> >>
> >> RCU is usually the perfect solution for protecting link lists though. I'll
> >> take a look at this when I get back to work.
> >>  
> >
> > So I did the below patch on top of this series. If you could fold this
> > into the appropriate patches, it should get us closer to an acceptable
> > solution.
> >
> > What I did was:
> >
> > 1. Moved the struct eventfs_file and eventfs_inode into event_inode.c as it
> >   really should not be exposed to all users.
> >
> > 2. Added a recursion check to eventfs_remove_rec() as it is really
> >   dangerous to have unchecked recursion in the kernel (we do have a fixed
> >   size stack).
> >
> > 3. Removed all the eventfs_rwsem code and replaced it with an srcu lock for
> >   the readers, and a mutex to synchronize the writers of the list.
> >
> > 4. Added a eventfs_mutex that is used for the modifications of the
> >   dentry itself (as well as modifying the list from 3 above).
> >
> > 5. Have the free use srcu callbacks. After the srcu grace periods are done,
> >   it adds the eventfs_file onto a llist (lockless link list) and wakes up a
> >   work queue. Then the work queue does the freeing (this needs to be done in
> >   task/workqueue context, as srcu callbacks are done in softirq context).
> >
> > This appears to pass through some of my instance stress tests as well as
> > the in tree ftrace selftests.
> >  
> 
> Awesome :)
> 
> I have manually applied the patches and ftracetest results are same as v3.
> No more complains from lockdep.
> 
> I will merge this into appropriate patches of v3 and soon send v4.
> 
> You have renamed eventfs_create_dir() to create_dir(), and kept  eventfs_create_dir()
> just a wrapper with lock, same for eventfs_create_file(). However these wrapper no where
> used, I will drop these wrappers.

Ah, I thought that because they started with "eventfs_" that they were used
for some fops pointer. Note, I try to avoid using the "eventfs_" naming for
static functions that are not exported elsewhere.

> 
> I was trying to have independent lock for each instance of events. As common lock
> for every instance of events is not must.

We can find a way to make the lock for the root later. Let's get it working
first before we optimize it. I do not want to expose any locking to the
users of this interface.

> 
> Something was broken in your mail (I guess cc list) and couldn’t reach to lkml or
> ignored by lkml. I just wanted to track the auto test results from linux-kselftest.

Yeah, claws-mail has an issue with some emails with quotes in it (sometimes
drops the second quote). Sad part is, it happens after I hit send, and it
is not part of the email. I'll send this reply now, but I bet it's going to happen again.

Let's see :-/  I checked the To and Cc's and they all have the proper
quotes. Let's see what ends up in my "Sent" folder.

-- Steve

