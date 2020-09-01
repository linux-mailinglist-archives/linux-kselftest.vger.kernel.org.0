Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4BD2597CD
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbgIAQSp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 12:18:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54113 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731974AbgIAQSo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 12:18:44 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kD8zZ-00015R-Fs; Tue, 01 Sep 2020 16:18:41 +0000
Date:   Tue, 1 Sep 2020 18:18:40 +0200
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
        Jens Axboe <axboe@kernel.dk>, linux-api@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/4] exit: support non-blocking pidfds
Message-ID: <20200901161840.e5eo33ctmq7zavak@wittgenstein>
References: <20200831134551.1599689-1-christian.brauner@ubuntu.com>
 <20200831134551.1599689-3-christian.brauner@ubuntu.com>
 <20200901161154.GA4386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200901161154.GA4386@redhat.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 01, 2020 at 06:11:54PM +0200, Oleg Nesterov wrote:
> On 08/31, Christian Brauner wrote:
> >
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -934,6 +934,7 @@ struct wait_opts {
> >  
> >  	wait_queue_entry_t		child_wait;
> >  	int			notask_error;
> > +	int			eagain_error;
> >  };
> >  
> >  static int eligible_pid(struct wait_opts *wo, struct task_struct *p)
> > @@ -1461,6 +1462,8 @@ static long do_wait(struct wait_opts *wo)
> >  
> >  notask:
> >  	retval = wo->notask_error;
> > +	if (!retval)
> > +		retval = wo->eagain_error;
> >  	if (!retval && !(wo->wo_flags & WNOHANG)) {
> >  		retval = -ERESTARTSYS;
> 
> I must have missed something but I don't understand why do we need
> the new ->eagain_error and the change in do_wait().
> 
> > @@ -1544,6 +1551,11 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
> >  	wo.wo_flags	= options;
> >  	wo.wo_info	= infop;
> >  	wo.wo_rusage	= ru;
> > +	wo.eagain_error = 0;
> > +	if (f_flags & O_NONBLOCK) {
> > +		wo.wo_flags	|= WNOHANG;
> > +		wo.eagain_error	= -EAGAIN;
> > +	}
> >  	ret = do_wait(&wo);
> 
> Can't kernel_waitid() simply do
> 
> 	if (f_flags & O_NONBLOCK)
> 		wo.wo_flags |= WNOHANG;
> 	ret = do_wait();
> 	if (!ret & (f_flags & O_NONBLOCK))
> 		ret = -EAGAIN;
> 
> ?

Heh, indeed, that's even a smaller patch. Will change to that!

Thanks for the review, Oleg!
Christia
