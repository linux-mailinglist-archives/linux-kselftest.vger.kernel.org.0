Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A2510014
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 21:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfD3TH6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 15:07:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43654 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfD3TH6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 15:07:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id j20so13248955edq.10
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2019 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=24AjdVeorZwTFjcHq4izaVEveVUnIHNKgUQspSKXzvI=;
        b=HRw7WojWySMAv4b8YL4a2LOaFT9fYBpKx09Bebq1ppJnm0xY9XE2+fvoFmxFyLBgvs
         cXSHmuyuCo1DZ1DSSgtKhJwb2Q0oHBHL6n5r7g/viMBsT5Ng3qU6CMH6HM5awf844U5J
         VnpuwRI9NyLJ3XPIvuYY5j2H7WDDrlHypMZEanmISO7U9yeqMqkRKlI1+pEEEKL+0rMT
         4myjp6ARtxZ8stXu85b+pDGo2//UBg32SB/qdvPGooFW1RoaBhMwU1Sc5tDnrObEgc/C
         1bAHlqDViUiO0KIVHZHi1idryUSF0YDQI7GJs2wxolSlDcRX4h2ghqqxFKj7lTJbEuup
         CCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=24AjdVeorZwTFjcHq4izaVEveVUnIHNKgUQspSKXzvI=;
        b=Ll6JLZmFwxII9D+uxVlaAFm/jmZJGwg41PI5k4VB4sPtKsKiQn0taBWGXOY1rumR3M
         fNuGF27379mT80K3CxVlspJGkrpJT+wg7knNCXjV9IktyVDzk2aPx3rhWiM2UIR5l4e0
         SZtNTrIy4ytZBxpWW+qawcwAOxSHDp1Q8Nef+0Ual5CKlALd1XMblM7aoHwNVl7oUkGD
         k0K2gfutDwMeWrnVE1YHBvCTUp6EIdyM8QbQzKW/ae/qYjhjMHAR6RBQI5rm4IfM2Ihn
         qh/sE/wl+pLTIqNZk+dUxvZgACn5rnSpkpuZ+YATJb6bMfYNwa2vRY3V7bjoFrQXgUB1
         ku9Q==
X-Gm-Message-State: APjAAAU1IT7iZwRuaQjuHNkP4EUTHsI9YoREndFFLTnaLhfjpu4/j8Lh
        I7Nk+8wJVNdaRd9vm7kFrF6jyQ==
X-Google-Smtp-Source: APXvYqzXZ50xr285y4ircRfLpCQLCoyu7pRVhllBkfGMDPkxzy45F/LNQfiCBNuBHZ3qU7yK6jaV6g==
X-Received: by 2002:a50:ba13:: with SMTP id g19mr4363528edc.236.1556651275646;
        Tue, 30 Apr 2019 12:07:55 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id p12sm4953528ejr.18.2019.04.30.12.07.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Apr 2019 12:07:54 -0700 (PDT)
Date:   Tue, 30 Apr 2019 21:07:53 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Tim Murray <timmurray@google.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v2 1/2] Add polling support to pidfd
Message-ID: <20190430190752.vwtq4kky6wdprm2d@brauner.io>
References: <20190430162154.61314-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190430162154.61314-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 30, 2019 at 12:21:53PM -0400, Joel Fernandes (Google) wrote:
> Android low memory killer (LMK) needs to know when a process dies once
> it is sent the kill signal. It does so by checking for the existence of
> /proc/pid which is both racy and slow. For example, if a PID is reused
> between when LMK sends a kill signal and checks for existence of the
> PID, since the wrong PID is now possibly checked for existence.
> 
> This patch adds polling support to pidfd. Using the polling support, LMK
> will be able to get notified when a process exists in race-free and fast
> way, and allows the LMK to do other things (such as by polling on other
> fds) while awaiting the process being killed to die.
> 
> For notification to polling processes, we follow the same existing
> mechanism in the kernel used when the parent of the task group is to be
> notified of a child's death (do_notify_parent).  This is precisely when
> the tasks waiting on a poll of pidfd are also awakened in this patch.
> 
> We have decided to include the waitqueue in struct pid for the following
> reasons:
> 1. The wait queue has to survive for the lifetime of the poll. Including
> it in task_struct would not be option in this case because the task can
> be reaped and destroyed before the poll returns.
> 
> 2. By including the struct pid for the waitqueue means that during
> de_thread(), the new thread group leader automatically gets the new
> waitqueue/pid even though its task_struct is different.
> 
> Appropriate test cases are added in the second patch to provide coverage
> of all the cases the patch is handling.
> 
> Andy had a similar patch [1] in the past which was a good reference
> however this patch tries to handle different situations properly related
> to thread group existence, and how/where it notifies. And also solves
> other bugs (waitqueue lifetime).  Daniel had a similar patch [2]
> recently which this patch supercedes.
> 
> [1] https://lore.kernel.org/patchwork/patch/345098/
> [2] https://lore.kernel.org/lkml/20181029175322.189042-1-dancol@google.com/
> 
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Daniel Colascione <dancol@google.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Jann Horn <jannh@google.com>
> Cc: Tim Murray <timmurray@google.com>
> Cc: Jonathan Kowalski <bl0pbl33p@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: kernel-team@android.com
> (Oleg improved the code by showing how to avoid tasklist_lock)
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Co-developed-by: Daniel Colascione <dancol@google.com>
> Signed-off-by: Daniel Colascione <dancol@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

This looks good to me. Once Oleg has given his Ack/Review I'm going to
move this into pidfd for-next and as mentioned before schedule it for
5.3 after CLONE_PIDFD has been merged.

Reviewed-by: Christian Brauner <christian@brauner.io>

> 
> ---
> 
> v1 -> v2:
> * Restructure poll code to avoid tasklist_lock (Oleg)
> * use task_pid instead of get_pid_task in notify_pidfd (Oleg)
> * Added comments to code, commit message nits (Christian)
> * Test case nits/improvements (Christian)
> 
> RFC -> v1:
> * Based on CLONE_PIDFD patches: https://lwn.net/Articles/786244/
> * Updated selftests.
> * Renamed poll wake function to do_notify_pidfd.
> * Removed depending on EXIT flags
> * Removed POLLERR flag since semantics are controversial and
>   we don't have usecases for it right now (later we can add if there's
>   a need for it).
> 
>  include/linux/pid.h |  3 +++
>  kernel/fork.c       | 29 +++++++++++++++++++++++++++++
>  kernel/pid.c        |  2 ++
>  kernel/signal.c     | 11 +++++++++++
>  4 files changed, 45 insertions(+)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 3c8ef5a199ca..1484db6ca8d1 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_PID_H
>  
>  #include <linux/rculist.h>
> +#include <linux/wait.h>
>  
>  enum pid_type
>  {
> @@ -60,6 +61,8 @@ struct pid
>  	unsigned int level;
>  	/* lists of tasks that use this pid */
>  	struct hlist_head tasks[PIDTYPE_MAX];
> +	/* wait queue for pidfd notifications */
> +	wait_queue_head_t wait_pidfd;
>  	struct rcu_head rcu;
>  	struct upid numbers[1];
>  };
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 5525837ed80e..721f8c9d2921 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1685,8 +1685,37 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
>  }
>  #endif
>  
> +/*
> + * Poll support for process exit notification.
> + */
> +static unsigned int pidfd_poll(struct file *file, struct poll_table_struct *pts)
> +{
> +	struct task_struct *task;
> +	struct pid *pid = file->private_data;
> +	int poll_flags = 0;
> +
> +	poll_wait(file, &pid->wait_pidfd, pts);
> +
> +	rcu_read_lock();
> +	task = pid_task(pid, PIDTYPE_PID);
> +	WARN_ON_ONCE(task && !thread_group_leader(task));
> +
> +	/*
> +	 * Inform pollers only when the whole thread group exits, if thread
> +	 * group leader exits before all other threads in the group, then
> +	 * poll(2) should block, similar to the wait(2) family.
> +	 */
> +	if (!task || (task->exit_state && thread_group_empty(task)))
> +		poll_flags = POLLIN | POLLRDNORM;
> +	rcu_read_unlock();
> +
> +	return poll_flags;
> +}
> +
> +
>  const struct file_operations pidfd_fops = {
>  	.release = pidfd_release,
> +	.poll = pidfd_poll,
>  #ifdef CONFIG_PROC_FS
>  	.show_fdinfo = pidfd_show_fdinfo,
>  #endif
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 20881598bdfa..5c90c239242f 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -214,6 +214,8 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>  	for (type = 0; type < PIDTYPE_MAX; ++type)
>  		INIT_HLIST_HEAD(&pid->tasks[type]);
>  
> +	init_waitqueue_head(&pid->wait_pidfd);
> +
>  	upid = pid->numbers + ns->level;
>  	spin_lock_irq(&pidmap_lock);
>  	if (!(ns->pid_allocated & PIDNS_ADDING))
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 1581140f2d99..a17fff073c3d 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1800,6 +1800,14 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>  	return ret;
>  }
>  
> +static void do_notify_pidfd(struct task_struct *task)
> +{
> +	struct pid *pid;
> +
> +	pid = task_pid(task);
> +	wake_up_all(&pid->wait_pidfd);
> +}
> +
>  /*
>   * Let a parent know about the death of a child.
>   * For a stopped/continued status change, use do_notify_parent_cldstop instead.
> @@ -1823,6 +1831,9 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  	BUG_ON(!tsk->ptrace &&
>  	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
>  
> +	/* Wake up all pidfd waiters */
> +	do_notify_pidfd(tsk);
> +
>  	if (sig != SIGCHLD) {
>  		/*
>  		 * This is only possible if parent == real_parent.
> -- 
> 2.21.0.593.g511ec345e18-goog
