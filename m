Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 437B5FD2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfD3Pt0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 11:49:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38385 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfD3PtZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 11:49:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so7265788pfo.5
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2019 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ah7OC5skPsoE6RCcUpTOKboXwH/ADgkzZH3P4SrcC1Y=;
        b=obZOjzk6FnDYA2dTzwPkHb/HsAn/gL3Be7hzAQGlgvdW0rEL+GY/aeYTLr7fUtru1F
         DEb76d4ClMFrmM0dAcMwzKbb3H541DhXuqRkSeyYrmpVLlZWJRM2A5H6TIE8nzgn1BUB
         8BAnZpwEtxn2OOicE1LlRcEc5v4ylz/c7fCTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ah7OC5skPsoE6RCcUpTOKboXwH/ADgkzZH3P4SrcC1Y=;
        b=BWbK673DgdGCZfUb0y2Z1WAlv/fCDjdFW/PvwQfVfnVL5zQR8K6+DSSkzgS+KbCK1m
         L29MBblm1pItRZX7c8407aDZ+XI6x1GiNSsn0u9ThAiSWpiigYLW8Ztf8UmOybz5zMcn
         c+ViMPsis1ncK5484nJF+h7UhKca5ZTnb3U2fQ3EdWpbuAh7j+ox27f7GNlJYNkPFsBU
         2zELy5QzD3UViL3BUIChKS3YGWY2wlqqknx2urcqU8bNiblD/f0s49s27LMxXFPOcRbP
         +1PNnzRXr5qcChMn4L7dkZHhDDrQad6Notwd0eux6nYUO8AvvZUspYjF3jh04Yx5CJ6T
         D4OQ==
X-Gm-Message-State: APjAAAWaPBNyocfxLylW4P4FzfK3+rbftiNBFk3Pn3hwv7k7Uqg1SdZH
        pws/9s4Sz+0GLme30PnBXU+yVQ==
X-Google-Smtp-Source: APXvYqyTV7uct7zm+TXCL/AlMhz+vIwHlNrqHVuIog9kEr1nZ/RnMmXN5o1PGgzF3dEsXmSMCFsU9g==
X-Received: by 2002:a63:541d:: with SMTP id i29mr38553959pgb.174.1556639364354;
        Tue, 30 Apr 2019 08:49:24 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d38sm43687027pgd.40.2019.04.30.08.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 08:49:23 -0700 (PDT)
Date:   Tue, 30 Apr 2019 11:49:21 -0400
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
Message-ID: <20190430154507.GA792@google.com>
References: <20190425190010.46489-1-joel@joelfernandes.org>
 <20190425222359.sqhboc4x4daznr6r@brauner.io>
 <20190428162405.GA6757@redhat.com>
 <20190429140245.GB233442@google.com>
 <20190429142030.GA17715@redhat.com>
 <20190429163259.GA201155@google.com>
 <20190430115332.GB23020@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430115332.GB23020@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 30, 2019 at 01:53:33PM +0200, Oleg Nesterov wrote:
> On 04/29, Joel Fernandes wrote:
> >
> > On Mon, Apr 29, 2019 at 04:20:30PM +0200, Oleg Nesterov wrote:
> > > On 04/29, Joel Fernandes wrote:
> > > >
> > > > However, in your code above, it is avoided because we get:
> > > >
> > > > Task A (poller)		Task B (exiting task being polled)
> > > > ------------            ----------------
> > > > poll() called
> > > > add_wait_queue()
> > > > 			exit_state is set to non-zero
> > > > read exit_state
> > > > remove_wait_queue()
> > > > 			wake_up_all()
> > >
> > > just to clarify... No, sys_poll() path doesn't do remove_wait_queue() until
> > > it returns to user mode, and that is why we can't race with set-exit_code +
> > > wake_up().
> >
> > I didn't follow what you mean, the removal from the waitqueue happens in
> > free_poll_entry() called from poll_freewait() which happens from
> > do_sys_poll() which is before the syscall returns to user mode. Could you
> > explain more?
> 
> Hmm. I do not really understand the question... Sure, do_sys_poll() does
> poll_freewait() before sysret or even before return from syscall, but why
> does this matter? This is the exit path, it frees the memory, does fput(),
> etc, f_op->poll() won't be call after that.

Ok, we are on the same page on this.

> > > pidfd_poll() can race with the exiting task, miss exit_code != 0, and return
> > > zero. However, do_poll() won't block after that and pidfd_poll() will be called
> > > again.
> >
> > Here also I didn't follow what you mean. If exit_code is read as 0 in
> > pidfd_poll(), then in do_poll() the count will be 0 and it will block in
> > poll_schedule_timeout(). Right?
> 
> No. Please note the pwq->triggered check and please read __pollwake().
> 
> But if you want to understand this you can forget about poll/select. It is
> a bit complicated, in particular because it has to do set_current_state()
> right  before schedule() and thus it plays games with pwq->triggered. But in
> essence this doesn't differ too much from the plain wait_event-like code
> (although you can also look at wait_woken/woken_wake_function).
> 
> If remove_wait_queue() could happem before wake_up_all() (like in your pseudo-
> code above), then pidfd_poll() or any other ->poll() method could miss _both_
> the condition and wakeup. But sys_poll() doesn't do this, so it is fine to miss
> the condition and rely on wake_up_all() which ensures we won't block and the
> next iteration must see condition == T.

Agreed. In my pseudo-code above, I meant removal from waitqueue only once we
are not going to be blocking in poll and returning to userspace. I may have
messed the sequence of events, but my point was to show the race I had in
mind (missing a wake up due to adding to the waitqueue too late inside
pidfd_poll()).  Anyway, I will repost with your suggested change and send it
soon. Thanks for the discussions.

thanks,

 - Joel

