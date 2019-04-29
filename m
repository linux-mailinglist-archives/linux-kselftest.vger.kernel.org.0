Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453CAE7D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 18:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfD2QdE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 12:33:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33415 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfD2QdD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 12:33:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so5414803pgh.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4u5KyvwOshsxhVh+dlKczng4m5MVTpApgn+4OWkgPnE=;
        b=XpxVZxXyLJ0YimBp0vayH2zy8tcGXLzw8w3DDttrwTb+FzX8vh+3MV9hXUdXXJLDhg
         4FqH8wLZdrEIPv1iUeyqQhuXMGdE8y4Xgl99IK6ll8hhxVzO5cKKdGEtHhdVycR5uhI3
         n9zYslxIO+CR236lijdxnF6FS11fye40RInas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4u5KyvwOshsxhVh+dlKczng4m5MVTpApgn+4OWkgPnE=;
        b=qxsoAaXlf3nXpSUovuRl/BdQB8n/FwHP+pxGzESnB4irbGihsr9mRvvo3Dht00gK5d
         +KpnL/4NdgI0+OzxCMD+6RULIdIJZRydpzhL3IChsiWGRnFzohZsL6lKP88NhotbU+CS
         mWDiXSLrA6LwMcTJE8lsiW7L0EI7NUfZpV7q5owqb0ezSMeRQ9QKquX1ZgDKQi2oQEkp
         CY2IlBYMKnfsZlVtAbFggRLFGk4vbuRM+e2QduCT96OBpaCKjqzZ0zh7QKSnB1Bboxf8
         iARrTUaE+wOkn4hqfyb4mIR77zO035GQ2cD2982ZsF5udOhygGTgXU3JOKOqX+i3NRKO
         GKrg==
X-Gm-Message-State: APjAAAW3xS4iVSpI3R8ZPekepecnWL/g5SVkZ1qZ1TlECDmTDE0jLvdp
        Fem90icswsBUTRrppxDrRaCRtw==
X-Google-Smtp-Source: APXvYqxy0NH9DfF52+UZzKWGzifwxVWMDn25CFpma6QnDRG9j+hl4+IMTmxTavl5kmPTpcUkKLTBRQ==
X-Received: by 2002:a65:44cb:: with SMTP id g11mr407421pgs.193.1556555582666;
        Mon, 29 Apr 2019 09:33:02 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z16sm979881pfa.42.2019.04.29.09.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 09:33:01 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:32:59 -0400
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
Message-ID: <20190429163259.GA201155@google.com>
References: <20190425190010.46489-1-joel@joelfernandes.org>
 <20190425222359.sqhboc4x4daznr6r@brauner.io>
 <20190428162405.GA6757@redhat.com>
 <20190429140245.GB233442@google.com>
 <20190429142030.GA17715@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429142030.GA17715@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 04:20:30PM +0200, Oleg Nesterov wrote:
> On 04/29, Joel Fernandes wrote:
> >
> > However, in your code above, it is avoided because we get:
> >
> > Task A (poller)		Task B (exiting task being polled)
> > ------------            ----------------
> > poll() called
> > add_wait_queue()
> > 			exit_state is set to non-zero
> > read exit_state
> > remove_wait_queue()
> > 			wake_up_all()
> 
> just to clarify... No, sys_poll() path doesn't do remove_wait_queue() until
> it returns to user mode, and that is why we can't race with set-exit_code +
> wake_up().

I didn't follow what you mean, the removal from the waitqueue happens in
free_poll_entry() called from poll_freewait() which happens from
do_sys_poll() which is before the syscall returns to user mode. Could you
explain more?

> pidfd_poll() can race with the exiting task, miss exit_code != 0, and return
> zero. However, do_poll() won't block after that and pidfd_poll() will be called
> again.

Here also I didn't follow what you mean. If exit_code is read as 0 in
pidfd_poll(), then in do_poll() the count will be 0 and it will block in
poll_schedule_timeout(). Right? But above you're saying it wont block.
Also if you could show a timing diagram of this different race you're talking
about, that will make things clear. It is a bit hard for me to picture
otherwise.

Also, I will use task_pid() for getting the pid from the task, as you suggest
in the other thread.

thanks,

- Joel

