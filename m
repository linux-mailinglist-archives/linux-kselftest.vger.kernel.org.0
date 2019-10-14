Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC1D5FC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 12:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfJNKIf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 06:08:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33409 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730880AbfJNKIf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 06:08:35 -0400
Received: from [212.86.36.32] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iJxH8-000093-VJ; Mon, 14 Oct 2019 10:08:27 +0000
Date:   Mon, 14 Oct 2019 12:08:26 +0200
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
Message-ID: <20191014100824.sc4aqfktbn6go736@wittgenstein>
References: <20191010133518.5420-1-christian.brauner@ubuntu.com>
 <CAHO5Pa3V7fDb_+U-v+LB+TeAU0vfJyUMs9mD4ZqUtbLpZcD4nA@mail.gmail.com>
 <20191011221208.5eglbazksfigliob@yavin.dot.cyphar.com>
 <CAKgNAkhgGhGi-hMJt3UxYYDuyOZLx7c-eucpD5V7js+hsyv2CQ@mail.gmail.com>
 <20191012074840.4to7lh4zbt4wup74@wittgenstein>
 <b3fce4a4-10a8-befe-a438-f16dfa0cdb6b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3fce4a4-10a8-befe-a438-f16dfa0cdb6b@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 12, 2019 at 01:46:54PM +0200, Michael Kerrisk (man-pages) wrote:
> On 10/12/19 9:48 AM, Christian Brauner wrote:
> > On Sat, Oct 12, 2019 at 08:53:34AM +0200, Michael Kerrisk (man-pages) wrote:
> >> Hello Aleksa,
> >>
> >> On Sat, 12 Oct 2019 at 00:12, Aleksa Sarai <cyphar@cyphar.com> wrote:
> >>>
> >>> On 2019-10-11, Michael Kerrisk <mtk.manpages@gmail.com> wrote:
> >>>> Why CLONE3_CLEAR_SIGHAND rather than just CLONE_CLEAR_SIGHAND?
> > 
> > I don't care much how we name this apart from the "_CLEAR_SIGHAND"
> > suffix. But see for a little rationale below.
> > 
> >>>
> >>> There are no more flag bits left for the classic clone()/clone2() (the
> >>> last one was used up by CLONE_PIDFD) -- thus this flag is clone3()-only.
> >>
> >> Yes, I understand that. But, I'm not sure that the "3" in the prefix
> >> is necessary. "CLONE_" still seems better to me.
> >>
> >> Consider this: sometime in the near future we will probably have time
> >> namespaces. The new flag for those namespaces will only be usable with
> >> clone3(). It should NOT be called CLONE3_NEWTIME, but rather
> >> CLONE_NEWTIME (or similar), because that same flag will presumably
> >> also be used in other APIs such as unshare() and setns(). (Hmm -- I
> > 
> > There are some noteable differences though. CLONE_NEWTIME takes the
> > CSIGNAL bit which is in the range of a 32bit integer and thus useable by
> > unshare() too. The same does not hold for CLONE{3}_CLEAR_SIGHAND. You
> > can't pass it to unshare(). unshare() also just deals with
> > namespace-relevant stuff so CLONE{3}_CLEAR_SIGHAND doesn't make much
> > sense there.
> 
> Sure, but going forward there's very likely to be more CLONE flags
> for whatever reason, and some will be usable just in clone3()
> while others will be more widely used (in other APIs such as
> unshare() and setns()). Using two different prefixes for these
> flags (CLONE_/CLONE3_) would be just confusing. AFAICS, the CLONE3_

I do agree with that part. And as I said in my previous mail, I don't
care about the prefix.

> prefix really provides no advantage, but does have the potential to
> cause confusion down the track for the aforementioned reasons.
> (Furthermore... Shudder! What if there's a clone4() one day. I
> know you might say: "won't happen, we got things right this time",
> but API history suggests that "right" now not infrequently becomes
> "oops" later.) I do recommend CLONE_ for all the flags...

I do love your trust in our ability to design syscalls (//Cc Aleksa ;)). :)

> 
> >> wonder if we are going to need a new unshare2() or some such...)
> > 
> > We still have one 32bit bit left (CLONE_DETACHED) which we can't reuse
> > with clone()/clone2() but we can reuse with clone3(). We can simply
> > earmark it for namespace-related stuff and thus still have one bit left
> > for unshare() before we have to go for unshare2() (If we have to go
> > there at all since I'm not sure how much more namespaces we can come up
> > with.).
> 
> I'm sure there'll be more namespaces...

Let's hope not. :) Anyway, no real reason to do unshare2() any time
soon. :)

Christian
