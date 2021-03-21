Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5531D343429
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Mar 2021 19:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCUSqj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Mar 2021 14:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhCUSqC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Mar 2021 14:46:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80665C061763
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Mar 2021 11:46:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t18so7202052pjs.3
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Mar 2021 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I2tsQ4ylBo8/TJz8vm2hQjJ8of8T2dTjrO6yNcNWrkk=;
        b=OiGAyhADXEEH8oYfxOTB6RtF7R38GK31gdHCFhEARbI0QlW+wRSin3pCQJdd1wN8p6
         WFPyTtEr87Ps6MHILvlHUDvk27FJoyHP76HHQ5pjFWsB9nmBRQ2r/DgdHC11QZW4gLXJ
         j/q7TpSgVeNPeLm2BxIWCC7oxG3KmgKN/WRug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I2tsQ4ylBo8/TJz8vm2hQjJ8of8T2dTjrO6yNcNWrkk=;
        b=TvTHQRrusJfY9QfGG/koN08/ZnuWxtKtCb02LAsAuVJiCQ+B2i6GZgGWORunhmfN+K
         wUvvfRv09sc4KXcANkv5jDU2eMo3rjWYQC/QNZghO7aqhxnRyFZ3XQ4wMxrt7PZAkgTd
         L1+O99MRR4PomrE3YNhCuVwk77skN67+IYesYxahEYBjJ6eIlvq9ns+BtdCSnMMogEAM
         xF63YJGfmS1e+jOTeAkK8F7pnx8aa2Z56ArSwv0ldBLwv1vbx0OlXKN98hubS5QgqwTe
         ptaop9oLjFmfPWIH3dk7lc7q7K2A4agGrmDTa1RxqYyHUNcnvUfvBtURM4Wv2cL/ZlDE
         jpvg==
X-Gm-Message-State: AOAM530PRBOiAgO/qP2xIAhOnBxTkZB9Y4YLA1/uT5zl7SyHItced6ej
        CvR3qWRzUwWg6n1n3i8GswhFPA==
X-Google-Smtp-Source: ABdhPJyZFwycnnHM1xKnOtyD0ckDOmNz6J+0nWK8EHwNFXlkVVBtFRZkGaZnKFCIOcC5cp0Iv9lzSA==
X-Received: by 2002:a17:90a:f194:: with SMTP id bv20mr9515969pjb.229.1616352361814;
        Sun, 21 Mar 2021 11:46:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y8sm10652377pjb.11.2021.03.21.11.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 11:46:01 -0700 (PDT)
Date:   Sun, 21 Mar 2021 11:45:59 -0700
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
Subject: Re: [PATCH v6 3/8] securtiy/brute: Detect a brute force attack
Message-ID: <202103211128.B59FEB91F@keescook>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-4-john.wood@gmx.com>
 <202103171902.E6F55172@keescook>
 <20210321150118.GA3403@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321150118.GA3403@ubuntu>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 21, 2021 at 04:01:18PM +0100, John Wood wrote:
> On Wed, Mar 17, 2021 at 07:57:10PM -0700, Kees Cook wrote:
> > On Sun, Mar 07, 2021 at 12:30:26PM +0100, John Wood wrote:
> > > +static u64 brute_update_crash_period(struct brute_stats *stats, u64 now)
> > > +{
> > > +	u64 current_period;
> > > +	u64 last_crash_timestamp;
> > > +
> > > +	spin_lock(&stats->lock);
> > > +	current_period = now - stats->jiffies;
> > > +	last_crash_timestamp = stats->jiffies;
> > > +	stats->jiffies = now;
> > > +
> > > +	stats->period -= brute_mul_by_ema_weight(stats->period);
> > > +	stats->period += brute_mul_by_ema_weight(current_period);
> > > +
> > > +	if (stats->faults < BRUTE_MAX_FAULTS)
> > > +		stats->faults += 1;
> > > +
> > > +	spin_unlock(&stats->lock);
> > > +	return last_crash_timestamp;
> > > +}
> >
> > Now *here* locking makes sense, and it only needs to be per-stat, not
> > global, since multiple processes may be operating on the same stat
> > struct. To make this more no-reader-locking-friendly, I'd also update
> > everything at the end, and use WRITE_ONCE():
> >
> > 	u64 current_period, period;
> > 	u64 last_crash_timestamp;
> > 	u64 faults;
> >
> > 	spin_lock(&stats->lock);
> > 	current_period = now - stats->jiffies;
> > 	last_crash_timestamp = stats->jiffies;
> >
> > 	WRITE_ONCE(stats->period,
> > 		   stats->period - brute_mul_by_ema_weight(stats->period) +
> > 		   brute_mul_by_ema_weight(current_period));
> >
> > 	if (stats->faults < BRUTE_MAX_FAULTS)
> > 		WRITE_ONCE(stats->faults, stats->faults + 1);
> >
> > 	WRITE_ONCE(stats->jiffies, now);
> >
> > 	spin_unlock(&stats->lock);
> > 	return last_crash_timestamp;
> >
> > That way readers can (IIUC) safely use READ_ONCE() on jiffies and faults
> > without needing to hold the &stats->lock (unless they need perfectly matching
> > jiffies, period, and faults).
> 
> Sorry, but I try to understand how to use locking properly without luck.
> 
> I have read (and tried to understand):
>    tools/memory-model/Documentation/simple.txt
>    tools/memory-model/Documentation/ordering.txt
>    tools/memory-model/Documentation/recipes.txt
>    Documentation/memory-barriers.txt
> 
> And I don't find the responses that I need. I'm not saying they aren't
> there but I don't see them. So my questions:
> 
> If in the above function makes sense to use locking, and it is called from
> the brute_task_fatal_signal hook, then, all the functions that are called
> from this hook need locking (more than one process can access stats at the
> same time).
> 
> So, as you point, how it is possible and safe to read jiffies and faults
> (and I think period even though you not mention it) using READ_ONCE() but
> without holding brute_stats::lock? I'm very confused.

There are, I think, 3 considerations:

- is "stats", itself, a valid allocation in kernel memory? This is the
  "lifetime" management of the structure: it will only stay allocated as
  long as there is a task still alive that is attached to it. The use of
  refcount_t on task creation/death should entirely solve this issue, so
  that all the other places where you access "stats", the memory will be
  valid. AFAICT, this one is fine: you're doing all the correct lifetime
  management.

- changing a task's stats pointer: this is related to lifetime
  management, but it, I think, entirely solved by the existing
  refcounting. (And isn't helped by holding stats->lock since this is
  about stats itself being a valid pointer.) Again, I think this is all
  correct already in your existing code (due to the implicit locking of
  "current"). Perhaps I've missed something here, but I guess we'll see!

- are the values in stats getting written by multiple writers, or read
  during a write, etc?

This last one is the core of what I think could be improved here:

To keep the writes serialized, you (correctly) perform locking in the
writers. This is fine.

There is also locking in the readers, which I think is not needed.
AFAICT, READ_ONCE() (with WRITE_ONCE() in the writers) is sufficient for
the readers here.

> IIUC (during the reading of the documentation) READ_ONCE and WRITE_ONCE only
> guarantees that a variable loaded with WRITE_ONCE can be read safely with
> READ_ONCE avoiding tearing, etc. So, I see these functions like a form of
> guarantee atomicity in variables.

Right -- from what I can see about how you're reading the statistics, I
don't see a way to have the values get confused (assuming locked writes
and READ/WRITE_ONCE()).

> Another question. Is it also safe to use WRITE_ONCE without holding the lock?
> Or this is only appliable to read operations?

No -- you'll still want the writer locked since you update multiple fields
in stats during a write, so you could miss increments, or interleave
count vs jiffies writes, etc. But the WRITE_ONCE() makes sure that the
READ_ONCE() readers will see a stable value (as I understand it), and
in the order they were written.

> Any light on this will help me to do the best job in the next patches. If
> somebody can point me to the right direction it would be greatly appreciated.
> 
> Is there any documentation for newbies regarding this theme? I'm stuck.
> I have also read the documentation about spinlocks, semaphores, mutex, etc..
> but nothing clears me the concept expose.
> 
> Apologies if this question has been answered in the past. But the search in
> the mailing list has not been lucky.

It's a complex subject! Here are some other docs that might help:

tools/memory-model/Documentation/explanation.txt
Documentation/core-api/refcount-vs-atomic.rst

or they may melt your brain further! :) I know mine is always mushy
after reading them.

> Thanks for your time and patience.

You're welcome; and thank you for your work on this! I've wanted a robust
brute force mitigation in the kernel for a long time. :)

-Kees

-- 
Kees Cook
