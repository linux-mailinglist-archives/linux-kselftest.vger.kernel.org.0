Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB042DF62D
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfJUTm6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 15:42:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43961 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfJUTm5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 15:42:57 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iMdZu-0005fY-TS; Mon, 21 Oct 2019 19:42:54 +0000
Date:   Mon, 21 Oct 2019 21:42:53 +0200
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
Message-ID: <20191021194252.kycuedo2k2rrqfqd@wittgenstein>
References: <20191014104538.3096-1-christian.brauner@ubuntu.com>
 <20191021144633.GA2720@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191021144633.GA2720@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 21, 2019 at 04:46:33PM +0200, Oleg Nesterov wrote:
> On 10/14, Christian Brauner wrote:
> >
> > The child helper process on Linux posix_spawn must ensure that no signal
> > handlers are enabled, so the signal disposition must be either SIG_DFL
> > or SIG_IGN. However, it requires a sigprocmask to obtain the current
> > signal mask and at least _NSIG sigaction calls to reset the signal
> > handlers for each posix_spawn call
> 
> Plus the caller has to block/unblock all signals around clone(VM|VFORK).
> 
> Can this justify the new CLONE_ flag? Honestly, I have no idea. But the
> patch is simple and looks technically correct to me. FWIW,
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

The problem is not just the number of syscalls but also that the
sigaction logic is already quite complicated and would need to be even
more complicated without this flag. That's covered mostly in the glibc
thread though. Even just the ability to avoid potentially _NSIG syscalls
is enough justification especially since were not scarce on flags.

Thanks! I'll pick this up for 5.5.
Christian
