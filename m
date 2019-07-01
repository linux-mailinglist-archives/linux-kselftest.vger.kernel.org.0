Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 477435C507
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2019 23:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfGAVdb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jul 2019 17:33:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40619 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAVdb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jul 2019 17:33:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so7173507pfp.7
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Jul 2019 14:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZjbWLDI6nXThBqRB/S2/hSyyBD8D6vrJjBHnlB2gGNc=;
        b=aE0R6xJjp/PaW2ot393kYDCrw6urx7t93vPj/Kpg/DIZP+goxEpU89qjMVqp6LIoXj
         rin3PfbllQyJG/ARDuy7kYU7eYI7K5uI/J+apINGd/1EZ3ai0ppUpYcV6ZZZvZQP2qNL
         IgvrYEu6QiFl095zbzAbwh34M7Y/QDIlpIhnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZjbWLDI6nXThBqRB/S2/hSyyBD8D6vrJjBHnlB2gGNc=;
        b=haRL2zwQ2I0LFp1toJ4pkUqv+GuqOZXqbILI6ITHCnqRqlJsf4UQ++B3sjEJhviUfj
         eRCq/KP8qCKb3HT44BSaBgCuAPj/gbYsQvfr87CYasRpMACyCiCNy/AKy0XOcfmVnrqh
         q1qu8Y8EcZJrDFOHm7ZsIPIPv1byz1foU5+vlnM0Z3ToX9l32VZVNk6LK4vqi3Q91d8F
         7bIYvH8Y4YrvwQg0Ydfe2jXTEPcitotBzkbJ7KYeW9JUW/Ux4gqp9E/wpkkZbh4XHB0i
         Ob5cXgeN3rt+9dVvsTKG4ppk3fmklX0se10kFyiNMe4fzk6JeuYNFXt2vPe7/8Rd59au
         Om0Q==
X-Gm-Message-State: APjAAAXcE3FPzf/UOboJBijje/2fNTOo55sIjT6p8lkHxL47w9/EGLTq
        oTs8lIuQQxZDRUi9vPbHEPVWUQ==
X-Google-Smtp-Source: APXvYqzpbmLBC01/wbXINSWLJkPDtkL0TxX7CNzkmV6hmfuJT9xSSeDmkfJvVQfZLjWTcp+Ecx5tcQ==
X-Received: by 2002:a63:f957:: with SMTP id q23mr27272143pgk.326.1562016810339;
        Mon, 01 Jul 2019 14:33:30 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q13sm12096234pgq.90.2019.07.01.14.33.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:33:29 -0700 (PDT)
Date:   Mon, 1 Jul 2019 17:33:28 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 2/3] rcu: Simplify rcu_note_context_switch exit from
 critical section
Message-ID: <20190701213328.GB240327@google.com>
References: <20190701040415.219001-1-joel@joelfernandes.org>
 <20190701040415.219001-2-joel@joelfernandes.org>
 <20190701200310.GP26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701200310.GP26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 01, 2019 at 01:03:10PM -0700, Paul E. McKenney wrote:
> On Mon, Jul 01, 2019 at 12:04:14AM -0400, Joel Fernandes (Google) wrote:
> > The rcu_preempt_note_context_switch() tries to handle cases where
> > __rcu_read_unlock() got preempted and then the context switch path does
> > the reporting of the quiscent state along with clearing any bits in the
> > rcu_read_unlock_special union.
> > 
> > This can be handled by just calling rcu_deferred_qs() which was added
> > during the RCU consolidation work and already does these checks.
> > 
> > Tested RCU config TREE03 for an hour which succeeds.
> > 
> > Cc: rcu@vger.kernel.org
> > Cc: kernel-team@android.com
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> My first reaction was "that cannot possibly work", but after a bit of
> digging, it really does appear to work just fine.  I therefore expanded
> the commit log a bit, so please check it to catch any messups on my part.
> 
> Very cool, thank you very much!  ;-)

Awesome! Thanks. I am glad you agree with the change and I agree with your
changes to the commit log.

thanks,

 - Joel


> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit ce547cb41ed7662f70d0b07d4c7f7555ba130c61
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Mon Jul 1 00:04:14 2019 -0400
> 
>     rcu: Simplify rcu_note_context_switch exit from critical section
>     
>     Because __rcu_read_unlock() can be preempted just before the call to
>     rcu_read_unlock_special(), it is possible for a task to be preempted just
>     before it would have fully exited its RCU read-side critical section.
>     This would result in a needless extension of that critical section until
>     that task was resumed, which might in turn result in a needlessly
>     long grace period, needless RCU priority boosting, and needless
>     force-quiescent-state actions.  Therefore, rcu_note_context_switch()
>     invokes __rcu_read_unlock() followed by rcu_preempt_deferred_qs() when
>     it detects this situation.  This action by rcu_note_context_switch()
>     ends the RCU read-side critical section immediately.
>     
>     Of course, once the task resumes, it will invoke rcu_read_unlock_special()
>     redundantly.  This is harmless because the fact that a preemption
>     happened means that interrupts, preemption, and softirqs cannot
>     have been disabled, so there would be no deferred quiescent state.
>     While ->rcu_read_lock_nesting remains less than zero, none of the
>     ->rcu_read_unlock_special.b bits can be set, and they were all zeroed by
>     the call to rcu_note_context_switch() at task-preemption time.  Therefore,
>     setting ->rcu_read_unlock_special.b.exp_hint to false has no effect.
>     
>     Therefore, the extra call to rcu_preempt_deferred_qs_irqrestore()
>     would return immediately.  With one possible exception, which is
>     if an expedited grace period started just as the task was being
>     resumed, which could leave ->exp_deferred_qs set.  This will cause
>     rcu_preempt_deferred_qs_irqrestore() to invoke rcu_report_exp_rdp(),
>     reporting the quiescent state, just as it should.  (Such an expedited
>     grace period won't affect the preemption code path due to interrupts
>     having already been disabled.)
>     
>     But when rcu_note_context_switch() invokes __rcu_read_unlock(), it
>     is doing so with preemption disabled, hence __rcu_read_unlock() will
>     unconditionally defer the quiescent state, only to immediately invoke
>     rcu_preempt_deferred_qs(), thus immediately reporting the deferred
>     quiescent state.  It turns out to be safe (and faster) to instead
>     just invoke rcu_preempt_deferred_qs() without the __rcu_read_unlock()
>     middleman.
>     
>     Because this is the invocation during the preemption (as opposed to
>     the invocation just after the resume), at least one of the bits in
>     ->rcu_read_unlock_special.b must be set and ->rcu_read_lock_nesting
>     must be negative.  This means that rcu_preempt_need_deferred_qs() must
>     return true, avoiding the early exit from rcu_preempt_deferred_qs().
>     Thus, rcu_preempt_deferred_qs_irqrestore() will be invoked immediately,
>     as required.
>     
>     This commit therefore simplifies the CONFIG_PREEMPT=y version of
>     rcu_note_context_switch() by removing the "else if" branch of its
>     "if" statement.  This change means that all callers that would have
>     invoked rcu_read_unlock_special() followed by rcu_preempt_deferred_qs()
>     will now simply invoke rcu_preempt_deferred_qs(), thus avoiding the
>     rcu_read_unlock_special() middleman when __rcu_read_unlock() is preempted.
>     
>     Cc: rcu@vger.kernel.org
>     Cc: kernel-team@android.com
>     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 187dc076c497..214e4689c29d 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -313,15 +313,6 @@ void rcu_note_context_switch(bool preempt)
>  				       ? rnp->gp_seq
>  				       : rcu_seq_snap(&rnp->gp_seq));
>  		rcu_preempt_ctxt_queue(rnp, rdp);
> -	} else if (t->rcu_read_lock_nesting < 0 &&
> -		   t->rcu_read_unlock_special.s) {
> -
> -		/*
> -		 * Complete exit from RCU read-side critical section on
> -		 * behalf of preempted instance of __rcu_read_unlock().
> -		 */
> -		rcu_read_unlock_special(t);
> -		rcu_preempt_deferred_qs(t);
>  	} else {
>  		rcu_preempt_deferred_qs(t);
>  	}
> 
