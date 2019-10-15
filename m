Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4708BD78F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 16:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbfJOOoD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 10:44:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732636AbfJOOoD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 10:44:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C88DE811DC;
        Tue, 15 Oct 2019 14:44:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2104D5D6A9;
        Tue, 15 Oct 2019 14:43:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 15 Oct 2019 16:44:01 +0200 (CEST)
Date:   Tue, 15 Oct 2019 16:43:57 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
Message-ID: <20191015144356.GA16978@redhat.com>
References: <20191015141332.4055-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015141332.4055-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 15 Oct 2019 14:44:03 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/15, Christian Brauner wrote:
>
> +static inline bool task_alive(struct pid *pid)
> +{
> +	bool alive = true;
> +
> +	rcu_read_lock();
> +	if (!pid_task(pid, PIDTYPE_PID))
> +		alive = false;
> +	rcu_read_unlock();
> +
> +	return alive;
> +}

Well, the usage of rcu_read_lock/unlock looks confusing to me...

I mean, this helper does not need rcu lock at all. Except
rcu_dereference_check() will complain.

	static inline bool task_alive(struct pid *pid)
	{
		bool alive;

		/* shut up rcu_dereference_check() */
		rcu_lock_acquire(&rcu_lock_map);
		alive = !!pid_task(pid, PIDTYPE_PID));
		rcu_lock_release(&rcu_lock_map);

		return alive;
	}

looks more clear imo.

But in fact I'd suggest to simply use !hlist_empty(&pid->tasks[PIDTYPE_PID])
in pidfd_show_fdinfo() and do not add a new helper.

Oleg.

