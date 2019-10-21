Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080E1DF62A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 21:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfJUTlF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 15:41:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43933 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfJUTlF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 15:41:05 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iMdY4-0005aw-QX; Mon, 21 Oct 2019 19:41:00 +0000
Date:   Mon, 21 Oct 2019 21:40:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, libc-alpha@sourceware.org,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
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
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 1/2] clone3: add CLONE_CLEAR_SIGHAND
Message-ID: <20191021194058.pwgiyu4za2srdfau@wittgenstein>
References: <20191014104538.3096-1-christian.brauner@ubuntu.com>
 <20191021144633.GA2720@redhat.com>
 <20191021151255.GA3459@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191021151255.GA3459@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 21, 2019 at 05:12:55PM +0200, Oleg Nesterov wrote:
> On 10/21, Oleg Nesterov wrote:
> >
> > On 10/14, Christian Brauner wrote:
> > >
> > > The child helper process on Linux posix_spawn must ensure that no signal
> > > handlers are enabled, so the signal disposition must be either SIG_DFL
> > > or SIG_IGN. However, it requires a sigprocmask to obtain the current
> > > signal mask and at least _NSIG sigaction calls to reset the signal
> > > handlers for each posix_spawn call
> >
> > Plus the caller has to block/unblock all signals around clone(VM|VFORK).
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> just in case... I meant that posix_spawn() has to block/unblock, not its
> caller.

Yeah, I think that is what's currently happening.

Christian
