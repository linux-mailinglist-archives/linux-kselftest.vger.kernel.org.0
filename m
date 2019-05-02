Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC611C5F
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2019 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfEBPN0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 May 2019 11:13:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40222 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEBPNZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 May 2019 11:13:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id e56so2434188ede.7
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2019 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ttmCfNHKGzwxlnjGzyfTPAX1HPNHfiu4VdFi4O4DyQ=;
        b=Q5+YixOwtcl+4zO8aokgXqzbO7ByEAkjAnbpMDQrK4aspKQdO1tAFLBz+ibAf4JtRP
         MtMrpJw5pe0RFpGVfEop3W90oWWUwX5I0wk5pFmvmyJhFT+I7y4tFJinNoDX7kJTsAlm
         fFqDhTB5HMnuI5k1jOoOv6rvphRB5LLIVVtaAk5LYH9W91mjFL1qq+AE/3j1kGPUh5WV
         0jm4iC+W0StEUWkM1MCPma0j7kQCAWnicl5ebOnigmHSo9cj6Ci/HuMdpbN6nZXZZGdI
         SiMtVGt2MPvc70vSMUouOo/mZ6CKZ8wcQ1cmBpm08QPkRsCmmRkYojOFbsGO5981F6Pc
         7zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ttmCfNHKGzwxlnjGzyfTPAX1HPNHfiu4VdFi4O4DyQ=;
        b=rJ+FUBwV4pYRmiQ4M9WlxwsTI2WiywUQLjAt9/VlJSAq4c/Oyggif2W/Dpq0LJgeGH
         59uegkI4IbnbM4roO2IGyfLDpWZzgLxpmAkRrIUN5ztBQAJoB29/jDZTMmvXQic6e7+5
         DWZ+6krhBXG2qCcnxRAlbS403ShlGBm0U+2mMXjoENtQUw/gMA+RzbCDtmxmS10F9qGC
         gJglg7W7dw/gPR3WlhdhTd4sILrlJSftpcbWeE4qyI57kdvOe2nvhYzlPoj6YL032YZr
         DwbeZl7oZVlA5B9f0zsiPAGTlPxsL5/EyQsl3k517Dvf85UeqVJlPYCfxreOXriM6F25
         vAug==
X-Gm-Message-State: APjAAAWaRYS5ggOX/te6KRBagplh+yks6vnfsvrvQX7fHMXlVqPne/D6
        cYJJw4Bg612mMmfND9+r0Pn3ag==
X-Google-Smtp-Source: APXvYqzbZnPxesYqJUHH3LTOVolsqPtEh2mVGBACgK9pOLdw3TSBtApNqX1UDZ0UjivMgf6LtqPiAg==
X-Received: by 2002:a50:a3dc:: with SMTP id t28mr2892874edb.256.1556810003605;
        Thu, 02 May 2019 08:13:23 -0700 (PDT)
Received: from brauner.io ([178.19.218.101])
        by smtp.gmail.com with ESMTPSA id o47sm65156edc.37.2019.05.02.08.13.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 02 May 2019 08:13:22 -0700 (PDT)
Date:   Thu, 2 May 2019 17:13:21 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Tim Murray <timmurray@google.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v2 1/2] Add polling support to pidfd
Message-ID: <20190502151320.cvc6uc3b4bmww23k@brauner.io>
References: <20190430162154.61314-1-joel@joelfernandes.org>
 <20190501151312.GA30235@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190501151312.GA30235@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 01, 2019 at 05:13:12PM +0200, Oleg Nesterov wrote:
> On 04/30, Joel Fernandes (Google) wrote:
> >
> > +static unsigned int pidfd_poll(struct file *file, struct poll_table_struct *pts)
> > +{
> > +	struct task_struct *task;
> > +	struct pid *pid = file->private_data;
> > +	int poll_flags = 0;
> > +
> > +	poll_wait(file, &pid->wait_pidfd, pts);
> > +
> > +	rcu_read_lock();
> > +	task = pid_task(pid, PIDTYPE_PID);
> > +	WARN_ON_ONCE(task && !thread_group_leader(task));
>                              ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Ah, this is not right, we can race with de_thread() which changes the leader,
> in particular it does leader->exit_signal = -1 to indicate that this thread is
> no longer a group leader, but pid_task() can return the old leader.
> 
> We are going to check thread_group_empty() below, it won't be true in this case,
> so this race should not make any harm.
> 
> Just remove this WARN_ON(). We can't use has_group_leader_pid(), it can return
> false if pid_task() returns the new leader.
> 
> Otherwise I see no problems.

I'll remove the WARN_ON() check when applying this. Can I get your
Acked/Review, Oleg?

Christian
