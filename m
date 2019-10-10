Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9DCD2D96
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2019 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfJJPWl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Oct 2019 11:22:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfJJPWl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Oct 2019 11:22:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF41110C0936;
        Thu, 10 Oct 2019 15:22:40 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-200.str.redhat.com [10.33.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBD731001B36;
        Thu, 10 Oct 2019 15:22:31 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        libc-alpha@sourceware.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] clone3: add CLONE3_CLEAR_SIGHAND
References: <20191010133518.5420-1-christian.brauner@ubuntu.com>
        <87d0f4of7j.fsf@oldenburg2.str.redhat.com>
        <20191010152148.gdea35mi7s6ivev6@wittgenstein>
Date:   Thu, 10 Oct 2019 17:22:30 +0200
In-Reply-To: <20191010152148.gdea35mi7s6ivev6@wittgenstein> (Christian
        Brauner's message of "Thu, 10 Oct 2019 17:21:49 +0200")
Message-ID: <87tv8gmxqh.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 10 Oct 2019 15:22:41 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Christian Brauner:

> On Thu, Oct 10, 2019 at 04:19:44PM +0200, Florian Weimer wrote:
>> * Christian Brauner:
>> 
>> > @@ -2567,7 +2572,7 @@ static bool clone3_args_valid(const struct kernel_clone_args *kargs)
>> >  	 * All lower bits of the flag word are taken.
>> >  	 * Verify that no other unknown flags are passed along.
>> >  	 */
>> > -	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
>> > +	if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE3_CLEAR_SIGHAND))
>> >  		return false;
>> 
>> Does the comment need updating?  I feel it's a bit misleading now.
>
> Yeah, maybe just:
>
> /* Verify that no unknown flags are passed along. */
>
> ?

Sure, looks fine to me.

Thanks,
Florian
