Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9318E4B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfD2O0E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 10:26:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23907 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbfD2O0E (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 10:26:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62C5B3199389;
        Mon, 29 Apr 2019 14:26:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 385555C205;
        Mon, 29 Apr 2019 14:25:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 Apr 2019 16:26:02 +0200 (CEST)
Date:   Mon, 29 Apr 2019 16:25:55 +0200
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
Message-ID: <20190429142555.GB17715@redhat.com>
References: <20190425190010.46489-1-joel@joelfernandes.org>
 <20190425222359.sqhboc4x4daznr6r@brauner.io>
 <20190428162405.GA6757@redhat.com>
 <20190429140245.GB233442@google.com>
 <20190429140743.GB173743@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429140743.GB173743@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 29 Apr 2019 14:26:04 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/29, Joel Fernandes wrote:
>
> On Mon, Apr 29, 2019 at 10:02:45AM -0400, Joel Fernandes wrote:
> > On Sun, Apr 28, 2019 at 06:24:06PM +0200, Oleg Nesterov wrote:
> [snip]
> > > > > +{
> > > > > +	struct pid *pid;
> > > > > +
> > > > > +	lockdep_assert_held(&tasklist_lock);
> > > > > +
> > > > > +	pid = get_task_pid(task, PIDTYPE_PID);
> > > > > +	wake_up_all(&pid->wait_pidfd);
> > > > > +	put_pid(pid);
> > >
> > > Why get/put?
> >
> > Yes, pid_task() should do it. Will update it. Thanks!
>
> I spoke too soon. We need the task's pid of type PIDTYPE_PID. How else can we
> get it? This does an atomic_inc on the pid->count, so we need to put_pid()
> after we are done with it. Did I miss something?

Just use task_pid(task);

Oleg.

