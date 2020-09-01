Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7E4259ABD
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 18:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgIAQx0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 12:53:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24007 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730001AbgIAQxZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 12:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598979204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avbleNGUb+J89GYGqB+uFJ1WJDboHCvs4T7vUTWniQ8=;
        b=R6uQPZbv2IftuUXHbLoCZMgTt9LB0eEuKHMGwioq5juIbauoa0f1N0UgCp4tQp2jXa3V3/
        OfSLP56BSDz8vb9xIpQA+kjwM2UvYP01i7GhK842qxA9fj0NhpaAIJ5SHJ3e+AbpU/e0i0
        vINKtSnwvA04lWEwPeRaHREYeEvRp/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-Aag7nKneMkuxngkgxQu7uA-1; Tue, 01 Sep 2020 12:53:22 -0400
X-MC-Unique: Aag7nKneMkuxngkgxQu7uA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A8BD10ABDA7;
        Tue,  1 Sep 2020 16:53:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id 283C87C558;
        Tue,  1 Sep 2020 16:53:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  1 Sep 2020 18:53:20 +0200 (CEST)
Date:   Tue, 1 Sep 2020 18:53:16 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
Message-ID: <20200901165315.GD4386@redhat.com>
References: <20200831134551.1599689-1-christian.brauner@ubuntu.com>
 <20200831134551.1599689-2-christian.brauner@ubuntu.com>
 <20200901162309.GB4386@redhat.com>
 <20200901163308.mwd334y462fmml6s@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901163308.mwd334y462fmml6s@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09/01, Christian Brauner wrote:
>
> On Tue, Sep 01, 2020 at 06:23:10PM +0200, Oleg Nesterov wrote:
> > On 08/31, Christian Brauner wrote:
> > >
> > > --- /dev/null
> > > +++ b/include/uapi/linux/pidfd.h
> > > @@ -0,0 +1,12 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +
> > > +#ifndef _UAPI_LINUX_PIDFD_H
> > > +#define _UAPI_LINUX_PIDFD_H
> > > +
> > > +#include <linux/types.h>
> > > +#include <linux/fcntl.h>
> > > +
> > > +/* Flags for pidfd_open().  */
> > > +#define PIDFD_NONBLOCK O_NONBLOCK
> > > +
> > > +#endif /* _UAPI_LINUX_PIDFD_H */
> >
> > Why? Can't we simply use O_NONBLOCK ?
>
> It's the same thing we seem to do for any other (anon inode) fds:
>
> include/linux/eventfd.h:#define		EFD_NONBLOCK O_NONBLOCK
> include/uapi/linux/inotify.h:#define	IN_NONBLOCK O_NONBLOCK
> include/uapi/linux/signalfd.h:#define	SFD_NONBLOCK O_NONBLOCK
> include/uapi/linux/timerfd.h:#define	TFD_NONBLOCK O_NONBLOCK
>
> also for O_CLOEXEC:
>
> include/linux/eventfd.h:#define		EFD_CLOEXEC O_CLOEXEC
> include/linux/userfaultfd_k.h:#define	UFFD_CLOEXEC O_CLOEXEC
> include/uapi/linux/eventpoll.h:#define	EPOLL_CLOEXEC O_CLOEXEC
> include/uapi/linux/mount.h:#define	OPEN_TREE_CLOEXEC    O_CLOEXEC
> include/uapi/linux/perf_event.h:#define PERF_FLAG_FD_CLOEXEC (1UL << 3) /* O_CLOEXEC */
> include/uapi/linux/signalfd.h:#define	SFD_CLOEXEC O_CLOEXEC
> include/uapi/linux/timerfd.h:#define	TFD_CLOEXEC O_CLOEXEC
>
> So I think we should just do the same.

Hmm, OK, then I have to agree.

> A clean flag namespace seems
> nicer to me too tbh.

Disagree but this doesn't matter ;)

Oleg.

