Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC71F6EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 13:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfD3Lxt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 07:53:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730755AbfD3Lxn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 07:53:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76888859FB;
        Tue, 30 Apr 2019 11:53:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id A86E22B3B5;
        Tue, 30 Apr 2019 11:53:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Apr 2019 13:53:40 +0200 (CEST)
Date:   Tue, 30 Apr 2019 13:53:33 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20190430115332.GB23020@redhat.com>
References: <20190425190010.46489-1-joel@joelfernandes.org>
 <20190425222359.sqhboc4x4daznr6r@brauner.io>
 <20190428162405.GA6757@redhat.com>
 <20190429140245.GB233442@google.com>
 <20190429142030.GA17715@redhat.com>
 <20190429163259.GA201155@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429163259.GA201155@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 30 Apr 2019 11:53:43 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/29, Joel Fernandes wrote:
>
> On Mon, Apr 29, 2019 at 04:20:30PM +0200, Oleg Nesterov wrote:
> > On 04/29, Joel Fernandes wrote:
> > >
> > > However, in your code above, it is avoided because we get:
> > >
> > > Task A (poller)		Task B (exiting task being polled)
> > > ------------            ----------------
> > > poll() called
> > > add_wait_queue()
> > > 			exit_state is set to non-zero
> > > read exit_state
> > > remove_wait_queue()
> > > 			wake_up_all()
> >
> > just to clarify... No, sys_poll() path doesn't do remove_wait_queue() until
> > it returns to user mode, and that is why we can't race with set-exit_code +
> > wake_up().
>
> I didn't follow what you mean, the removal from the waitqueue happens in
> free_poll_entry() called from poll_freewait() which happens from
> do_sys_poll() which is before the syscall returns to user mode. Could you
> explain more?

Hmm. I do not really understand the question... Sure, do_sys_poll() does
poll_freewait() before sysret or even before return from syscall, but why
does this matter? This is the exit path, it frees the memory, does fput(),
etc, f_op->poll() won't be call after that.

> > pidfd_poll() can race with the exiting task, miss exit_code != 0, and return
> > zero. However, do_poll() won't block after that and pidfd_poll() will be called
> > again.
>
> Here also I didn't follow what you mean. If exit_code is read as 0 in
> pidfd_poll(), then in do_poll() the count will be 0 and it will block in
> poll_schedule_timeout(). Right?

No. Please note the pwq->triggered check and please read __pollwake().

But if you want to understand this you can forget about poll/select. It is
a bit complicated, in particular because it has to do set_current_state()
right  before schedule() and thus it plays games with pwq->triggered. But in
essence this doesn't differ too much from the plain wait_event-like code
(although you can also look at wait_woken/woken_wake_function).

If remove_wait_queue() could happem before wake_up_all() (like in your pseudo-
code above), then pidfd_poll() or any other ->poll() method could miss _both_
the condition and wakeup. But sys_poll() doesn't do this, so it is fine to miss
the condition and rely on wake_up_all() which ensures we won't block and the
next iteration must see condition == T.

Oleg.

