Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5967B25C53C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Sep 2020 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgICPZh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 11:25:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36697 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbgICPZh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 11:25:37 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kDr7D-0000vI-Hl; Thu, 03 Sep 2020 15:25:31 +0000
Date:   Thu, 3 Sep 2020 17:25:29 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Jens Axboe <axboe@kernel.dk>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/4] pidfd: support PIDFD_NONBLOCK in pidfd_open()
Message-ID: <20200903152529.llgvshvvoymwealz@wittgenstein>
References: <20200902102130.147672-1-christian.brauner@ubuntu.com>
 <20200902102130.147672-2-christian.brauner@ubuntu.com>
 <20200903145808.GK4386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903145808.GK4386@redhat.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 03, 2020 at 04:58:09PM +0200, Oleg Nesterov wrote:
> Christian, off-topic question...
> 
> On 09/02, Christian Brauner wrote:
> >
> > -static int pidfd_create(struct pid *pid)
> > +static int pidfd_create(struct pid *pid, unsigned int flags)
> >  {
> >  	int fd;
> >
> >  	fd = anon_inode_getfd("[pidfd]", &pidfd_fops, get_pid(pid),
> > -			      O_RDWR | O_CLOEXEC);
> > +			      flags | O_RDWR | O_CLOEXEC);
> 
> I just noticed this comment above pidfd_create:
> 
> 	 * Note, that this function can only be called after the fd table has
> 	 * been unshared to avoid leaking the pidfd to the new process.
> 
> what does it mean?
> 
> Of course, if fd table is shared then pidfd can "leak" to another process,
> but this is true for any file and sys_pidfd_open() doesn't do any check?

It's the same comment we added in kernel/fork.c to make callers aware
that they can leak a pidfd to another process unintentionally. Sure,
this is true of any fd but since pidfds were a new type of handle and on
another process at that we felt that this was important to spell out. The
"can only" should've arguably been "should probably".

> 
> 
> 
> In fact I think this helper buys nothing but adds the unnecessary get/put_pid,
> we can kill it and change pidfd_open() to do
> 
> 	SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> 	{
> 		int fd;
> 		struct pid *p;
> 
> 		if (flags & ~PIDFD_NONBLOCK)
> 			return -EINVAL;
> 
> 		if (pid <= 0)
> 			return -EINVAL;
> 
> 		p = find_get_pid(pid);
> 		if (!p)
> 			return -ESRCH;
> 
> 		fd = -EINVAL;
> 		if (pid_has_task(p, PIDTYPE_TGID)) {
> 			fd = anon_inode_getfd("[pidfd]", &pidfd_fops, pid,
> 						flags | O_RDWR | O_CLOEXEC);
> 		}
> 		if (fd < 0)
> 			put_pid(p);
> 		return fd;
> 	}

Sure, I'd totally take a patch like that!

> 
> but this is cosmetic and off-topic too.

No, much appreciated. Good-looking code is important. :)

Christian
