Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0361F6DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2019 16:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfEOOtc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 May 2019 10:49:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40882 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfEOOtc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 May 2019 10:49:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id j12so195444eds.7
        for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2019 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oKULkZSRwqaiQxP7TL4UYPkN+uTDZlr88Vcbz3QuA1I=;
        b=gbthNhordMIYVnTy317gMGg6f/dfC5iQgBxjq6Pg3jScMLdLI0Vq4OcwB79UHvgEgC
         U1AgURPKc8JVgJXOo0PlK1NBODmUH4LG0c3iQOkHAxHOhxIV3lZFFgtryVL471yH2yaW
         C3klxUr1MKghIvHXbdcitmAziIPiCtbEw5zo2mlbo+BrqzIdRMNr8g8Hd8yvC+RFkoND
         3U7iWRnczi1gGSuo/hShIfYUEndn7uxrlNKw8BfZPzT5nVaY90n0JScdqCfYtxsar1cX
         tdmjNXgvyrjanexmF/91CzUGx8XsXtV3i+hqAVIqFgPvc7YR3o00EzVeVZB9N4qN/XJl
         yDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oKULkZSRwqaiQxP7TL4UYPkN+uTDZlr88Vcbz3QuA1I=;
        b=NmtZJK81Y+ahRGj47C0FCx1ZcOY6tcNHNzVTMKRzCfzp9OBgYU+oOsWPfRvLfXlATb
         cExW2tCmS1ynE2CJ/ZLlzvgWqvYqrmh6IJNuX3wP1JNF8via1pVyeTMUNOyoGWgouwWs
         EijC4ox68RDP2qvA/ZlMc3gQNFhALp6XOEKygsZ4uBC4bQGx2fpXqqoRpwUy7zKW4cBc
         T7IobzCnvrm8TjDdDxUEw4VfCMyM/BcsBAbwm0EmgRxkg+4jWcW6hj1j8oIrlKGfcYJc
         uEhTKHK6vTHv0uls+KImOQyJHJPWJW5CPoQ9hODxYXh58O0pWLZDY7sULh4lnQNOqPsE
         t3ig==
X-Gm-Message-State: APjAAAUxivUOLXqWj2qLr6fiB41WGYYJmHeEs7CsJr46V1Eoo6yQUwqe
        ss7KcOQV1M6/9soYCDy54udWmQ==
X-Google-Smtp-Source: APXvYqwtuLZTJzieEZtQQr5tQJZGg6NHI/b45QGiYK/CmzqPYIKTHEi4eYHx8oYap2x4c/tmYGlpdA==
X-Received: by 2002:a50:8eb6:: with SMTP id w51mr43141017edw.34.1557931770356;
        Wed, 15 May 2019 07:49:30 -0700 (PDT)
Received: from brauner.io ([178.19.218.101])
        by smtp.gmail.com with ESMTPSA id a32sm873557ede.76.2019.05.15.07.49.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 07:49:29 -0700 (PDT)
Date:   Wed, 15 May 2019 16:49:28 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     jannh@google.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, dhowells@redhat.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, ebiederm@xmission.com,
        elena.reshetova@intel.com, keescook@chromium.org,
        luto@amacapital.net, luto@kernel.org, tglx@linutronix.de,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
Message-ID: <20190515144927.f2yxyi6w6lhn3xx7@brauner.io>
References: <20190515100400.3450-1-christian@brauner.io>
 <20190515143857.GB18892@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515143857.GB18892@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 15, 2019 at 04:38:58PM +0200, Oleg Nesterov wrote:
> On 05/15, Christian Brauner wrote:
> >
> > +SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> > +{
> > +	int fd, ret;
> > +	struct pid *p;
> > +	struct task_struct *tsk;
> > +
> > +	if (flags)
> > +		return -EINVAL;
> > +
> > +	if (pid <= 0)
> > +		return -EINVAL;
> > +
> > +	p = find_get_pid(pid);
> > +	if (!p)
> > +		return -ESRCH;
> > +
> > +	rcu_read_lock();
> > +	tsk = pid_task(p, PIDTYPE_PID);
> 
> You do not need find_get_pid() before rcu_lock and put_pid() at the end.
> You can just do find_vpid() under rcu_read_lock().

Will do.

> 
> > +	if (!tsk)
> > +		ret = -ESRCH;
> > +	else if (unlikely(!thread_group_leader(tsk)))
> > +		ret = -EINVAL;
> 
> it seems that you can do a single check
> 
> 	tsk = pid_task(p, PIDTYPE_TGID);
> 	if (!tsk)
> 		ret = -ESRCH;
> 
> this even looks more correct if we race with exec changing the leader.

The logic here being that you can only reach the thread_group leader
from struct pid if PIDTYPE_PID == PIDTYPE_TGID for this struct pid?

Thanks, Oleg.
Christian
