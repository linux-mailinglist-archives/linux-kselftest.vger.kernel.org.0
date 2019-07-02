Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF95CE9A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2019 13:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfGBLkf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jul 2019 07:40:35 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39699 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfGBLke (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jul 2019 07:40:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id i125so13623965qkd.6
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2019 04:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d76+rBrIQU/StBU8cagTKv7l2BvLzcU1f3o2NLAUyms=;
        b=cIGkhZFvDLliFso7QWmxHW9042AROXayE+sWsH7mIqA3lSlte5wY0A033Gz4nKLlWx
         Hx/pl/r4pbHt2T0oVdSIEyu+Uma9Ug1HqKRsH/azxx+VTcRyh3KHihu+Q0LQ/kvDocKL
         LueRxh2AwkA+lsRP4c7rTZD6VWZrhUYM4U1/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d76+rBrIQU/StBU8cagTKv7l2BvLzcU1f3o2NLAUyms=;
        b=NmhJgD+suJRE7qoTqjxF+EgAG9MUtQXveroR8ByeJWfl9bvldwYF5DdQB82I36W7CG
         RwqqNvKyscsdAB5rEHPAmZzZB4A7dnIOb5sv8I+J/Aifvzm/AH8FOZBKeIPrMWf1LIkZ
         YQCX49lazp9Ki4Mg0+WJ+bl7r8Q8A4jxxzaoRYh5k+KN6m+8TFui82EoJnt0oBtVqE+s
         0bzmHTKLMCv7mH9R0GmPjj3HJV6l1gAJ6IOraCjKwce77eoo40pq8DkOUPy6Um5G5XWb
         yXRweN2WSH++FD85fGrE0Brso5C5Tn/BHBkmHT6M0VexHYQGv/vG3zCAxGYbT4dAbGBs
         blZw==
X-Gm-Message-State: APjAAAVrnKUvdbYMqDLu9sC8+rNDfg4VsHqRbrOsrqHzO9N20lT9k1Ob
        PpLeWgEsq+tzVfy1lAmoTemgKtxz9Y8=
X-Google-Smtp-Source: APXvYqy6oDQ53DK9Bb+d0Z5bMhOn790lQmOVX5Wgnb6SgVmP7KjBq+ACmgSlzcTevyjdX/7RwcE8vQ==
X-Received: by 2002:a37:b843:: with SMTP id i64mr24028603qkf.77.1562067632950;
        Tue, 02 Jul 2019 04:40:32 -0700 (PDT)
Received: from localhost (c-73-216-90-110.hsd1.va.comcast.net. [73.216.90.110])
        by smtp.gmail.com with ESMTPSA id s44sm7882269qtc.8.2019.07.02.04.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 04:40:32 -0700 (PDT)
Date:   Tue, 2 Jul 2019 11:40:30 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 1/3] rcu: Expedite the rcu quiescent state reporting if
 help needed
Message-ID: <20190702114030.GA5429@localhost>
References: <20190701040415.219001-1-joel@joelfernandes.org>
 <20190702034730.GI26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702034730.GI26519@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 01, 2019 at 08:47:30PM -0700, Paul E. McKenney wrote:
> On Mon, Jul 01, 2019 at 12:04:13AM -0400, Joel Fernandes (Google) wrote:
> > The t->rcu_read_unlock_special union's need_qs bit can be set by the
> > scheduler tick (in rcu_flavor_sched_clock_irq) to indicate that help is
> > needed from the rcu_read_unlock path. When this help arrives however, we
> > can do better to speed up the quiescent state reporting which if
> > rcu_read_unlock_special::need_qs is set might be quite urgent. Make use
> > of this information in deciding when to do heavy-weight softirq raising
> > where possible.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Cute thought, but I am going to have to pass on this one.  The reason
> is that by the time that ->rcu_read_unlock_special.b.need_qs gets set,
> the grace period is already one full second old.  At that point, the
> extra tick of waiting is down in the noise.
> 
> Right now, we do the extra work if we really are blocking an expedited
> grace period (the first two lines of the original condition) or we are
> running on a nohz_full CPU (which might never execute a scheduling clock
> tick, thus potentially delaying forever).  And expedited grace periods
> are supposed to complete in tens or maybe hundreds of microseconds,
> assuming the RCU readers are being cooperative, which is a whole
> different level of urgent.

Makes sense, I agree the patch may not be that helpful right now. I mixed up
the different levels or urgencies. No problem dropping it.

> 
> Nevertheless, thank you for looking into this!

My pleasure! Will keep them coming.

 - Joel

> 
> 							Thanx, Paul
> 
> > ---
> >  kernel/rcu/tree_plugin.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index c588ef98efd3..bff6410fac06 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -622,7 +622,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
> >  		t->rcu_read_unlock_special.b.exp_hint = false;
> >  		exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
> >  		      (rdp->grpmask & rnp->expmask) ||
> > -		      tick_nohz_full_cpu(rdp->cpu);
> > +		      tick_nohz_full_cpu(rdp->cpu)  ||
> > +		      t->rcu_read_unlock_special.b.need_qs;
> >  		// Need to defer quiescent state until everything is enabled.
> >  		if (irqs_were_disabled && use_softirq &&
> >  		    (in_interrupt() ||
> > -- 
> > 2.22.0.410.gd8fdbe21b5-goog
> > 
> 
