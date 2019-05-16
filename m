Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51CE620917
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2019 16:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEPOFS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 May 2019 10:05:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40999 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfEPOFM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 May 2019 10:05:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id m4so5436765edd.8
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2019 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bYyJnADr9ubhW5oaXdh9WlhTHjyzAGu0DQI2eQ+pHaE=;
        b=MhjOHc+12NO1kjqTg26hcfpFarWJK6UO4uKen3mnBZiVvgNz65ljzXS/ZRyK+jjEzc
         /JF15wWLnH7LRgIqtY0MD+nIanFGFyFhIksGgTJWi2bGoTMD18BMjjca67gxxRvxi8+0
         yQTTRxRIh7g2VDxBQ0zKZz1vXg1chuW2SN2qbepgb4FeuGMxhGooqxVI7+7FHAOj9N1M
         FHodeukkhZGpge8teMzG2zc9TJCjzMji+6KCaGF81DZdV6StlcqORhINQ4uQjbmc8vco
         TjK91z8PkXrFbRk1vdkCD5WKK6krFwmTdVA0wTPdFmhQ9BFoHPYiofHEVgNBJZi0CYJz
         Lvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bYyJnADr9ubhW5oaXdh9WlhTHjyzAGu0DQI2eQ+pHaE=;
        b=dqJhzuzABBWaB+ivuUI3EwY9BwPf0YnR+6HmehrTLLBmjkMRHvIXIz4iBySXIY3j9X
         NSBvCQFIIAtwOVhuvij3076HIE0On15l76aC9+Qd0YsxBwPlIPXlMkwjcJgbe/irgp5n
         h3cRCpCXn7w1JnKpb9+SKJ344U/3SWUrIfKhcEixGa1Dk9Oo/a1Vk4wrABwdp02PF1CX
         /BDDS1zwUyIJ/kfHUJJfWzzsHDfrMOh9tgXwDyQpNgzMKPub9Z7T4Pqp+xDMOPLTHFPa
         NCKAPYMRoPCoJ5GpUizKr/I1DqLeQSpyI062OsPhA7ZY3YWP7qFaOwdb+q/piw3u+ZPm
         qHMw==
X-Gm-Message-State: APjAAAXEh8pEqMmB1kq1Xskkr0qVOs80AlVrCoEuTW/dZYieMwmfPeX2
        gBJrh2IZUE6/CVCRm0/m/WhTOw==
X-Google-Smtp-Source: APXvYqy/zkegU6awCybVYKMai3zZjnS7ZHStCqrWAP9elvrkEbm/ZCiD/6p0jcTly9aqPNEwI1KvNw==
X-Received: by 2002:a17:906:65d2:: with SMTP id z18mr20105763ejn.68.1558015510995;
        Thu, 16 May 2019 07:05:10 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id b53sm1120044edd.89.2019.05.16.07.05.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 07:05:10 -0700 (PDT)
Date:   Thu, 16 May 2019 16:05:08 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
Message-ID: <20190516140507.75crjbaulasw6mj6@brauner.io>
References: <20190515100400.3450-1-christian@brauner.io>
 <CAKOZuesPF+ftwqsNDMBy1LpwJgWTNuQm9-E=C90sSTBYEEsDww@mail.gmail.com>
 <20190516130813.i66ujfzftbgpqhnh@brauner.io>
 <CAG48ez05OtBi_yX+071TrrfK3zKOn9h1kFyPr5rttiqQAZ0sEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez05OtBi_yX+071TrrfK3zKOn9h1kFyPr5rttiqQAZ0sEA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 16, 2019 at 04:03:27PM +0200, Jann Horn wrote:
> On Thu, May 16, 2019 at 3:08 PM Christian Brauner <christian@brauner.io> wrote:
> > On Wed, May 15, 2019 at 10:45:06AM -0700, Daniel Colascione wrote:
> > > On Wed, May 15, 2019 at 3:04 AM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > This adds the pidfd_open() syscall. It allows a caller to retrieve pollable
> > > > pidfds for a process which did not get created via CLONE_PIDFD, i.e. for a
> > > > process that is created via traditional fork()/clone() calls that is only
> > > > referenced by a PID:
> [...]
> > > > +/**
> > > > + * pidfd_open() - Open new pid file descriptor.
> > > > + *
> > > > + * @pid:   pid for which to retrieve a pidfd
> > > > + * @flags: flags to pass
> > > > + *
> > > > + * This creates a new pid file descriptor with the O_CLOEXEC flag set for
> > > > + * the process identified by @pid. Currently, the process identified by
> > > > + * @pid must be a thread-group leader. This restriction currently exists
> > > > + * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
> > > > + * be used with CLONE_THREAD) and pidfd polling (only supports thread group
> > > > + * leaders).
> > > > + *
> > > > + * Return: On success, a cloexec pidfd is returned.
> > > > + *         On error, a negative errno number will be returned.
> > > > + */
> > > > +SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> > > > +{
> [...]
> > > > +       if (pid <= 0)
> > > > +               return -EINVAL;
> > >
> > > WDYT of defining pid == 0 to mean "open myself"?
> >
> > I'm torn. It be a nice shortcut of course but pid being 0 is usually an
> > indicator for child processes. So unless the getpid() before
> > pidfd_open() is an issue I'd say let's leave it as is. If you really
> > want the shortcut might -1 be better?
> 
> Joining the bikeshed painting club: Please don't allow either 0 or -1
> as shortcut for "self". James Forshaw found an Android security bug a
> while back (https://bugs.chromium.org/p/project-zero/issues/detail?id=727)
> that passed a PID to getpidcon(), except that the PID was 0
> (placeholder for oneway binder transactions), and then the service
> thought it was talking to itself. You could pick some other number and
> provide a #define for that, but I think pidfd_open(getpid(), ...)
> makes more sense.

Yes, I agree. I left it as is for v1, i.e. no shortcut; getpid() should
do.

Christian
