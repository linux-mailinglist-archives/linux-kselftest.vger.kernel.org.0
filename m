Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B7343401
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Mar 2021 19:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhCUSHS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Mar 2021 14:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhCUSG7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Mar 2021 14:06:59 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C79C061762
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Mar 2021 11:06:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 11so9451503pfn.9
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Mar 2021 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GQKgsW9PSdNVPIehSolNc4zFTAKkCmZGwQWUb20126U=;
        b=I0PKXyTMkIEt+LniN9TDiR4PCxmqN6nDda6NF8aRRqORq412FXzDgofgs7FTdzKEph
         vtaZ9FoaIP3Bo4WolyFquZvViXjHm4OBIhWkdNdl9gsNA4/raot78SoLh3nBZ2vRd+Cu
         i8rt+lblIxqxP3fW9eBvzDKw6lp2xA6hNKM3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GQKgsW9PSdNVPIehSolNc4zFTAKkCmZGwQWUb20126U=;
        b=r3yH9R5fd/rBNYj6ceM7l4b3JXUZxv8/FUqxMxoHWBmt2pxAsJynEhUz8Vq73AfUA0
         5bkd2OjuPmQFjdMbiMv6Jlz378jC1Q9ICjN69ON14uWeX8chBU03n9uzFNx3wrZcPYP/
         nZknEGX5Ma9wrUF1yzNrTtn+C8vJ5lFYkr1tPHhM41MYmsoysyxK+/cqBD1n6TouJ5DW
         UeYbMndO1rhe2VXet4QwhpOs3SoU+l2e3PrAcw1agtk+U4uvu2Z09m5Db66bhaH67lD9
         41OhslUIAUZLbmc/mERGrizggh6FkPkrd71PHdE2FvpJV0PVi+ghusBLycv3ifX8EUYc
         +0+A==
X-Gm-Message-State: AOAM532nyPUAviAHkj5nGJYT3wEOCwUDWmZazLAjFQP5RInNFrEi/SnV
        5/YSiI7ndEQRdDsdt62Rp8E6JQ==
X-Google-Smtp-Source: ABdhPJwaCJxQVGsaQYkSzRn4/xLdt/W/sHHH5c87r+rTURI2OY10XACg+Pnz+H2j9RROjlYdd/UVjA==
X-Received: by 2002:a63:4753:: with SMTP id w19mr19247458pgk.394.1616350018234;
        Sun, 21 Mar 2021 11:06:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w189sm11012549pfw.86.2021.03.21.11.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 11:06:57 -0700 (PDT)
Date:   Sun, 21 Mar 2021 11:06:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Wood <john.wood@gmx.com>
Cc:     Jann Horn <jannh@google.com>, Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v6 5/8] security/brute: Mitigate a brute force attack
Message-ID: <202103211101.F3CD3A84@keescook>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-6-john.wood@gmx.com>
 <202103172102.03F172613@keescook>
 <20210320154847.GD3023@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320154847.GD3023@ubuntu>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 20, 2021 at 04:48:47PM +0100, John Wood wrote:
> On Wed, Mar 17, 2021 at 09:04:15PM -0700, Kees Cook wrote:
> > On Sun, Mar 07, 2021 at 12:30:28PM +0100, John Wood wrote:
> > > +/**
> > > + * brute_kill_offending_tasks() - Kill the offending tasks.
> > > + * @attack_type: Brute force attack type.
> > > + * @stats: Statistical data shared by all the fork hierarchy processes.
> > > + *
> > > + * When a brute force attack is detected all the offending tasks involved in the
> > > + * attack must be killed. In other words, it is necessary to kill all the tasks
> > > + * that share the same statistical data. Moreover, if the attack happens through
> > > + * the fork system call, the processes that have the same group_leader that the
> > > + * current task must be avoided since they are in the path to be killed.
> > > + *
> > > + * When the SIGKILL signal is sent to the offending tasks, this function will be
> > > + * called again from the task_fatal_signal hook due to a small crash period. So,
> > > + * to avoid kill again the same tasks due to a recursive call of this function,
> > > + * it is necessary to disable the attack detection for this fork hierarchy.
> >
> > Hah. Interesting. I wonder if there is a better way to handle this. Hmm.
> 
> If your comment is related to disable the detection:
> 
> I think it's no problematic to disable the attack detection for this fork
> hierarchy since all theirs tasks will be removed. Also, I think that the disable
> mark can help in the path to use the wait*() functions to notify userspace that
> a task has been killed by the brute mitigation. Is a work in progress now.
> 
> If your comment is related to kill all the tasks:
> 
> In the previous version I have a useful discussion with Andi Kleen where a
> proposal to block the fork system call during a time was made. He explains me
> the cons of this method and proposes that if the mitigation works as now we can
> use the wait*() functions to notify userspace that the tasks has been killed
> by the brute mitigation. This way other problems related with the supervisors
> and respawned processes could be handled.
> 
> Anyway, new points of view are also welcome.

I was just amused by my realizing that the brute mitigation could
trigger itself. I was just glad you had a comment about the
situation -- I hadn't thought about that case yet. :)

> 
> > > + *
> > > + * The statistical data shared by all the fork hierarchy processes cannot be
> > > + * NULL.
> > > + *
> > > + * It's mandatory to disable interrupts before acquiring the brute_stats::lock
> > > + * since the task_free hook can be called from an IRQ context during the
> > > + * execution of the task_fatal_signal hook.
> > > + *
> > > + * Context: Must be called with interrupts disabled and tasklist_lock and
> > > + *          brute_stats_ptr_lock held.
> > > + */
> > > +static void brute_kill_offending_tasks(enum brute_attack_type attack_type,
> > > +				       struct brute_stats *stats)
> > > +{
> > > +	struct task_struct *p;
> > > +	struct brute_stats **p_stats;
> > > +
> > > +	spin_lock(&stats->lock);
> > > +
> > > +	if (attack_type == BRUTE_ATTACK_TYPE_FORK &&
> > > +	    refcount_read(&stats->refc) == 1) {
> > > +		spin_unlock(&stats->lock);
> > > +		return;
> > > +	}
> >
> > refcount_read() isn't a safe way to check that there is only 1
> > reference. What's this trying to do?
> 
> If a fork brute force attack has been detected is due to a new fatal crash.
> Under this scenario, if there is only one reference of these stats, it is
> not necessary to kill any other tasks since the stats are not shared with
> another process. Moreover, if this task has failed in a fatal way, is in
> the path to be killed. So, no action is required.
> 
> How can I make this check in a safe way?

I think you can just skip the optimization -- killing off threads isn't
going to be a fast path.

-Kees

> 
> > > +
> > > +	brute_disable(stats);
> > > +	spin_unlock(&stats->lock);
> > > +
> > > +	for_each_process(p) {
> > > +		if (attack_type == BRUTE_ATTACK_TYPE_FORK &&
> > > +		    p->group_leader == current->group_leader)
> > > +			continue;
> > > +
> > > +		p_stats = brute_stats_ptr(p);
> > > +		if (*p_stats != stats)
> > > +			continue;
> > > +
> > > +		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_PID);
> > > +		pr_warn_ratelimited("Offending process %d [%s] killed\n",
> > > +				    p->pid, p->comm);
> > > +	}
> > > +}
> 
> Thanks,
> John Wood

-- 
Kees Cook
