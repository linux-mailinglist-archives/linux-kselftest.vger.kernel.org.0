Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B04C4D4E1B
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2019 09:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfJLHst (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Oct 2019 03:48:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48142 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfJLHst (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Oct 2019 03:48:49 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iJC8p-00051r-DP; Sat, 12 Oct 2019 07:48:43 +0000
Date:   Sat, 12 Oct 2019 09:48:42 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] clone3: add CLONE3_CLEAR_SIGHAND
Message-ID: <20191012074840.4to7lh4zbt4wup74@wittgenstein>
References: <20191010133518.5420-1-christian.brauner@ubuntu.com>
 <CAHO5Pa3V7fDb_+U-v+LB+TeAU0vfJyUMs9mD4ZqUtbLpZcD4nA@mail.gmail.com>
 <20191011221208.5eglbazksfigliob@yavin.dot.cyphar.com>
 <CAKgNAkhgGhGi-hMJt3UxYYDuyOZLx7c-eucpD5V7js+hsyv2CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKgNAkhgGhGi-hMJt3UxYYDuyOZLx7c-eucpD5V7js+hsyv2CQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 12, 2019 at 08:53:34AM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Aleksa,
> 
> On Sat, 12 Oct 2019 at 00:12, Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > On 2019-10-11, Michael Kerrisk <mtk.manpages@gmail.com> wrote:
> > > Why CLONE3_CLEAR_SIGHAND rather than just CLONE_CLEAR_SIGHAND?

I don't care much how we name this apart from the "_CLEAR_SIGHAND"
suffix. But see for a little rationale below.

> >
> > There are no more flag bits left for the classic clone()/clone2() (the
> > last one was used up by CLONE_PIDFD) -- thus this flag is clone3()-only.
> 
> Yes, I understand that. But, I'm not sure that the "3" in the prefix
> is necessary. "CLONE_" still seems better to me.
> 
> Consider this: sometime in the near future we will probably have time
> namespaces. The new flag for those namespaces will only be usable with
> clone3(). It should NOT be called CLONE3_NEWTIME, but rather
> CLONE_NEWTIME (or similar), because that same flag will presumably
> also be used in other APIs such as unshare() and setns(). (Hmm -- I

There are some noteable differences though. CLONE_NEWTIME takes the
CSIGNAL bit which is in the range of a 32bit integer and thus useable by
unshare() too. The same does not hold for CLONE{3}_CLEAR_SIGHAND. You
can't pass it to unshare(). unshare() also just deals with
namespace-relevant stuff so CLONE{3}_CLEAR_SIGHAND doesn't make much
sense there.

> wonder if we are going to need a new unshare2() or some such...)

We still have one 32bit bit left (CLONE_DETACHED) which we can't reuse
with clone()/clone2() but we can reuse with clone3(). We can simply
earmark it for namespace-related stuff and thus still have one bit left
for unshare() before we have to go for unshare2() (If we have to go
there at all since I'm not sure how much more namespaces we can come up
with.).

Christian
