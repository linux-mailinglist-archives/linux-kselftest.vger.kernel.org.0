Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1942598CC
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 18:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbgIAQdP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 12:33:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54450 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgIAQdL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 12:33:11 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kD9DZ-00028h-7Q; Tue, 01 Sep 2020 16:33:09 +0000
Date:   Tue, 1 Sep 2020 18:33:08 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Jens Axboe <axboe@kernel.dk>, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/4] pidfd: support PIDFD_NONBLOCK in pidfd_open()
Message-ID: <20200901163308.mwd334y462fmml6s@wittgenstein>
References: <20200831134551.1599689-1-christian.brauner@ubuntu.com>
 <20200831134551.1599689-2-christian.brauner@ubuntu.com>
 <20200901162309.GB4386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200901162309.GB4386@redhat.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 01, 2020 at 06:23:10PM +0200, Oleg Nesterov wrote:
> On 08/31, Christian Brauner wrote:
> >
> > --- /dev/null
> > +++ b/include/uapi/linux/pidfd.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +
> > +#ifndef _UAPI_LINUX_PIDFD_H
> > +#define _UAPI_LINUX_PIDFD_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/fcntl.h>
> > +
> > +/* Flags for pidfd_open().  */
> > +#define PIDFD_NONBLOCK O_NONBLOCK
> > +
> > +#endif /* _UAPI_LINUX_PIDFD_H */
> 
> Why? Can't we simply use O_NONBLOCK ?

It's the same thing we seem to do for any other (anon inode) fds:

include/linux/eventfd.h:#define		EFD_NONBLOCK O_NONBLOCK
include/uapi/linux/inotify.h:#define	IN_NONBLOCK O_NONBLOCK
include/uapi/linux/signalfd.h:#define	SFD_NONBLOCK O_NONBLOCK
include/uapi/linux/timerfd.h:#define	TFD_NONBLOCK O_NONBLOCK

also for O_CLOEXEC:

include/linux/eventfd.h:#define		EFD_CLOEXEC O_CLOEXEC
include/linux/userfaultfd_k.h:#define	UFFD_CLOEXEC O_CLOEXEC
include/uapi/linux/eventpoll.h:#define	EPOLL_CLOEXEC O_CLOEXEC
include/uapi/linux/mount.h:#define	OPEN_TREE_CLOEXEC    O_CLOEXEC
include/uapi/linux/perf_event.h:#define PERF_FLAG_FD_CLOEXEC (1UL << 3) /* O_CLOEXEC */
include/uapi/linux/signalfd.h:#define	SFD_CLOEXEC O_CLOEXEC
include/uapi/linux/timerfd.h:#define	TFD_CLOEXEC O_CLOEXEC

So I think we should just do the same. A clean flag namespace seems
nicer to me too tbh.

Christian
