Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 762F7D7949
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfJOO4w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 10:56:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41284 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbfJOO4v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 10:56:51 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKOFk-0007df-Fh; Tue, 15 Oct 2019 14:56:48 +0000
Date:   Tue, 15 Oct 2019 16:56:47 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Christian Kellner <christian@kellner.me>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org, Jann Horn <jannh@google.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] pidfd: verify task is alive when printing fdinfo
Message-ID: <20191015145646.72eqrw6j52ehvfn2@wittgenstein>
References: <20191015141332.4055-1-christian.brauner@ubuntu.com>
 <20191015144356.GA16978@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191015144356.GA16978@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 15, 2019 at 04:43:57PM +0200, Oleg Nesterov wrote:
> On 10/15, Christian Brauner wrote:
> >
> > +static inline bool task_alive(struct pid *pid)
> > +{
> > +	bool alive = true;
> > +
> > +	rcu_read_lock();
> > +	if (!pid_task(pid, PIDTYPE_PID))
> > +		alive = false;
> > +	rcu_read_unlock();
> > +
> > +	return alive;
> > +}
> 
> Well, the usage of rcu_read_lock/unlock looks confusing to me...
> 
> I mean, this helper does not need rcu lock at all. Except
> rcu_dereference_check() will complain.

Yep, I think we have another codepath were the rcu locks might be purely
cosmetic so I thought it's not a big deal (see below).

> 
> 	static inline bool task_alive(struct pid *pid)
> 	{
> 		bool alive;
> 
> 		/* shut up rcu_dereference_check() */
> 		rcu_lock_acquire(&rcu_lock_map);
> 		alive = !!pid_task(pid, PIDTYPE_PID));
> 		rcu_lock_release(&rcu_lock_map);
> 
> 		return alive;
> 	}
> 
> looks more clear imo.
> 
> But in fact I'd suggest to simply use !hlist_empty(&pid->tasks[PIDTYPE_PID])
> in pidfd_show_fdinfo() and do not add a new helper.

Sounds good to me. But can't we then just do something similar just with
!hlist_empty(&pid->tasks[PIDTYPE_TGID])

in v5.4-rc3:kernel/pid.c:pidfd_open():514-517 ?

or would this be problematic because of de_thread()?

Thanks!
Christian
