Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB14109DA
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 17:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfEAPNW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 11:13:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEAPNW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 11:13:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E9B53082134;
        Wed,  1 May 2019 15:13:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 82881629DB;
        Wed,  1 May 2019 15:13:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  1 May 2019 17:13:19 +0200 (CEST)
Date:   Wed, 1 May 2019 17:13:12 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Tim Murray <timmurray@google.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>, kernel-team@android.com,
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
Message-ID: <20190501151312.GA30235@redhat.com>
References: <20190430162154.61314-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430162154.61314-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 01 May 2019 15:13:21 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/30, Joel Fernandes (Google) wrote:
>
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
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^

Ah, this is not right, we can race with de_thread() which changes the leader,
in particular it does leader->exit_signal = -1 to indicate that this thread is
no longer a group leader, but pid_task() can return the old leader.

We are going to check thread_group_empty() below, it won't be true in this case,
so this race should not make any harm.

Just remove this WARN_ON(). We can't use has_group_leader_pid(), it can return
false if pid_task() returns the new leader.

Otherwise I see no problems.

Oleg.

