Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D33A5D2D92
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2019 17:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfJJPVy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Oct 2019 11:21:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57805 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJPVy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Oct 2019 11:21:54 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iIaGE-0001BW-Vy; Thu, 10 Oct 2019 15:21:51 +0000
Date:   Thu, 10 Oct 2019 17:21:49 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fweimer@redhat.com>
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
Message-ID: <20191010152148.gdea35mi7s6ivev6@wittgenstein>
References: <20191010133518.5420-1-christian.brauner@ubuntu.com>
 <87d0f4of7j.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d0f4of7j.fsf@oldenburg2.str.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 10, 2019 at 04:19:44PM +0200, Florian Weimer wrote:
> * Christian Brauner:
> 
> > @@ -2567,7 +2572,7 @@ static bool clone3_args_valid(const struct kernel_clone_args *kargs)
> >  	 * All lower bits of the flag word are taken.
> >  	 * Verify that no other unknown flags are passed along.
> >  	 */
> > -	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
> > +	if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE3_CLEAR_SIGHAND))
> >  		return false;
> 
> Does the comment need updating?  I feel it's a bit misleading now.

Yeah, maybe just:

/* Verify that no unknown flags are passed along. */

?

Thanks!
Christian
