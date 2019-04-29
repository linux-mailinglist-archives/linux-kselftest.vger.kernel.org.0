Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C0AE429
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 16:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfD2OCu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 10:02:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35622 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbfD2OCu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 10:02:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id h1so5217718pgs.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PFu4LcJxharEXgw2klYAWZtX/puZbWdAKMF8s/Hs2eE=;
        b=wf3DswDloG1u4oHlBpxqq8kPCsFCrpGWBM1XhGnys9lN64ZH8ZRWd5NWTO82vMm+H4
         EpHveYtd/isl+i0Q6VrxPxKLUs9PQT1Fpg7dZF7/BoUtVDQ9pxnaifgBsM9+ctApquUi
         Yl5ReFF/YnGSMLvkAJ3fo1dWWpiJS1TWP0pE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PFu4LcJxharEXgw2klYAWZtX/puZbWdAKMF8s/Hs2eE=;
        b=nhCynDsbbP44V26oAGJO8CwglCmzPkcWOo0iVeeSxUyHXVoeXfQ25gsLTnR1rAVpqD
         6GyctwKYI+4C7O4QfYEFIukxUABHepvtp3lfyzB4kIPNy+S7G1cgnpuFLSfsEHebI2Q1
         jWFFTPLD9+SA0M6lJ1w5L9LKRSXty4yRtZdnwNJKHsyRaw7HBv4ABcPifdT0tnq8gG+g
         x9mTBKV9HI83iw9RYgXo4iTGLPBVLEVUy1KFECkKPdzcs/Dl4LZAvm+ZqPnHcaJUGyIj
         EGE0PAUF8KKN3+lpXSCAOwgz416raXa0MjcCsuL21wd0+lZ710cGBtdL8YOJ+WerZjLJ
         OPJg==
X-Gm-Message-State: APjAAAUo7WjahJVpRQbB3E9pcDamRNNfj/fVBtQMNIMrsk0hyuDp83XC
        AmCXkiHEfolcF6NQFxhhkCdvlA==
X-Google-Smtp-Source: APXvYqzeOjZa/OYBZv7q/tl5A0uibW0n1aWmK6abkgawPzyU9qpgOZFhzfeXxqWc5jbvXia2u4bzBg==
X-Received: by 2002:a63:a18:: with SMTP id 24mr57229266pgk.332.1556546568429;
        Mon, 29 Apr 2019 07:02:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j16sm43790261pfi.58.2019.04.29.07.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 07:02:46 -0700 (PDT)
Date:   Mon, 29 Apr 2019 10:02:45 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        rostedt@goodmis.org, dancol@google.com, sspatil@google.com,
        jannh@google.com, surenb@google.com, timmurray@google.com,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        torvalds@linux-foundation.org, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jann@thejh.net>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, viro@zeniv.linux.org.uk,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Add polling support to pidfd
Message-ID: <20190429140245.GB233442@google.com>
References: <20190425190010.46489-1-joel@joelfernandes.org>
 <20190425222359.sqhboc4x4daznr6r@brauner.io>
 <20190428162405.GA6757@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428162405.GA6757@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Apr 28, 2019 at 06:24:06PM +0200, Oleg Nesterov wrote:
> Thanks for cc'ing me...
> 
> On 04/26, Christian Brauner wrote:
> >
> > On Thu, Apr 25, 2019 at 03:00:09PM -0400, Joel Fernandes (Google) wrote:
> > > +static unsigned int pidfd_poll(struct file *file, struct poll_table_struct *pts)
> > > +{
> > > +	struct task_struct *task;
> > > +	struct pid *pid;
> > > +	int poll_flags = 0;
> > > +
> > > +	/*
> > > +	 * tasklist_lock must be held because to avoid racing with
> > > +	 * changes in exit_state and wake up. Basically to avoid:
> > > +	 *
> > > +	 * P0: read exit_state = 0
> > > +	 * P1: write exit_state = EXIT_DEAD
> > > +	 * P1: Do a wake up - wq is empty, so do nothing
> > > +	 * P0: Queue for polling - wait forever.
> > > +	 */
> > > +	read_lock(&tasklist_lock);
> > > +	pid = file->private_data;
> > > +	task = pid_task(pid, PIDTYPE_PID);
> > > +	WARN_ON_ONCE(task && !thread_group_leader(task));
> > > +
> > > +	if (!task || (task->exit_state && thread_group_empty(task)))
> > > +		poll_flags = POLLIN | POLLRDNORM;
> 
> Joel, I still can't understand why do we need tasklist... and I don't really
> understand the comment. The code looks as if you are trying to avoid poll_wait(),
> but this would be strange.
> 
> OK, why can't pidfd_poll() do
> 
> 	poll_wait(file, &pid->wait_pidfd, pts);
> 
> 	rcu_read_lock();
> 	task = pid_task(pid, PIDTYPE_PID);
> 	if (!task || task->exit_state && thread_group_empty(task))
> 		poll_flags = POLLIN | ...;
> 	rcu_read_unlock();
> 
> 	return poll_flags;
> 
> ?

Oh that's much better Oleg, and would avoid the race I had in mind: Basically
I was acquiring the tasklist_lock to avoid a case where a polling task is not
woken up because it was added to the waitqueue too late. The reading of the
exit_state and the conditional adding to the wait queue, needed to be atomic.
Otherwise something like the following may be possible:

Task A (poller)		Task B (exiting task being polled)
------------            ----------------
poll() called
			exit_state is set to non-zero
read exit_state
			wake_up_all()

add_wait_queue()
----------------------------------------------

However, in your code above, it is avoided because we get:

Task A (poller)		Task B (exiting task being polled)
------------            ----------------
poll() called
add_wait_queue()
			exit_state is set to non-zero
read exit_state
remove_wait_queue()
			wake_up_all()

I don't see any other issues with your code above so I can try it out and
update the patches. Thanks.

> > > +static void do_notify_pidfd(struct task_struct *task)
> >
> > Maybe a short command that this helper can only be called when we know
> > that task is a thread-group leader wouldn't hurt so there's no confusion
> > later.
> 
> Not really. If the task is traced, do_notify_parent() (and thus do_notify_pidfd())
> can be called to notify the debugger even if the task is not a leader and/or if
> it is not the last thread. The latter means a spurious wakeup for pidfd_poll().

Seems like you are replying to Christian's point. I agree with you.

> > > +{
> > > +	struct pid *pid;
> > > +
> > > +	lockdep_assert_held(&tasklist_lock);
> > > +
> > > +	pid = get_task_pid(task, PIDTYPE_PID);
> > > +	wake_up_all(&pid->wait_pidfd);
> > > +	put_pid(pid);
> 
> Why get/put?

Yes, pid_task() should do it. Will update it. Thanks!

 - Joel

