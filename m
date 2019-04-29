Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0ADE443
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfD2OHq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 10:07:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33450 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbfD2OHq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 10:07:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so69574pfk.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rVfhfQiy4k/gTXiRLKY8pcxpzGE19WyRfB5vYwX1+8s=;
        b=U8Ck1TbjUSL7T33txtHKdEx40f64DhMg0b6UfCIYbhcaob+mwl64qmmKmtIR1GMjcm
         7H+dUkOmjfr02GvlY8b2e206hBGgohLlXfx//2BNG/ZQ96Ie6DGt1oiwutrJHEib2TqM
         TM5CMLULo1jBRYcURqfR7zbPDLtSuLhGqtdUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rVfhfQiy4k/gTXiRLKY8pcxpzGE19WyRfB5vYwX1+8s=;
        b=bgBO8HAi4s4pYgQksjoGSrasJH1riCRxCZpe+niS73EY6uBvE2hia0CTNWiKScnd65
         4duVqvqmBEkyT+5V9FB+9MeYjrzTAm4EwdEEwNKNBinIXU0966WBzVWjYqXAv/VBXCpK
         XiE3KHyZ53sRcRmmRzJzNHR4HXJpjJLjaPGMv86lBjphBndOZRdwGliwxgppuDjBb6wj
         fR59M4GHmOVmrjhwBTA4PBM2TsXAVRlP0UQL4uDd7MNBYSo4IpK/NOBiv3xTh0OM2uuK
         dIl8KldKbyX/q0CQHqEyB/vrQ3GSAvVCUNcYXY0wqW2xlDTJgHTqCvUK2fuWrLuEwhuz
         UBaQ==
X-Gm-Message-State: APjAAAWo/oRKeeU9UbJCQ29oe/97SW5qwcBEKcBj90S9ZkNPmxc+lnN/
        l2aV7FDcFwmCLObEtuLfwysuXg==
X-Google-Smtp-Source: APXvYqzx1BE0CcVj4OJwmwL/GX1uNg3HWoq8XL9akQxqUrC4o0fWEAE4fgtWIdkNuX9GU1q+NUN06w==
X-Received: by 2002:aa7:92c4:: with SMTP id k4mr32352058pfa.183.1556546865597;
        Mon, 29 Apr 2019 07:07:45 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 128sm39979866pgb.47.2019.04.29.07.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 07:07:44 -0700 (PDT)
Date:   Mon, 29 Apr 2019 10:07:43 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        rostedt@goodmis.org, dancol@google.com, sspatil@google.com,
        jannh@google.com, surenb@google.com, timmurray@google.com,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        torvalds@linux-foundation.org, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jann@thejh.net>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, viro@zeniv.linux.org.uk,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Add polling support to pidfd
Message-ID: <20190429140743.GB173743@google.com>
References: <20190425190010.46489-1-joel@joelfernandes.org>
 <20190425222359.sqhboc4x4daznr6r@brauner.io>
 <20190428162405.GA6757@redhat.com>
 <20190429140245.GB233442@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429140245.GB233442@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 10:02:45AM -0400, Joel Fernandes wrote:
> On Sun, Apr 28, 2019 at 06:24:06PM +0200, Oleg Nesterov wrote:
[snip]
> > > > +{
> > > > +	struct pid *pid;
> > > > +
> > > > +	lockdep_assert_held(&tasklist_lock);
> > > > +
> > > > +	pid = get_task_pid(task, PIDTYPE_PID);
> > > > +	wake_up_all(&pid->wait_pidfd);
> > > > +	put_pid(pid);
> > 
> > Why get/put?
> 
> Yes, pid_task() should do it. Will update it. Thanks!

I spoke too soon. We need the task's pid of type PIDTYPE_PID. How else can we
get it? This does an atomic_inc on the pid->count, so we need to put_pid()
after we are done with it. Did I miss something?

thanks,

 - Joel

 
