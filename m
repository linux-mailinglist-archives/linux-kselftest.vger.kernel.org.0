Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB3129A539
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 08:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507306AbgJ0HHw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 03:07:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:65353 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505885AbgJ0HHw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 03:07:52 -0400
IronPort-SDR: vyTdgkf3u2IPZkD9SH3BB9uJKsYl4xzB1c0bs1+RpUYmxXmcIHJDGd9Ia3LsyY1TqdhRNqTRqb
 nG3TKpVWzf3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="164537062"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="164537062"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 00:07:51 -0700
IronPort-SDR: A5IXsCcNEXQXEcg/oDhntuvq+fWDgRPE+ldHDsUxyxBUCd/F6AsJTG2smijql50iqT70s1/Kgh
 K0bYXPlZ5eAw==
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="468194512"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 00:07:50 -0700
Date:   Tue, 27 Oct 2020 00:07:50 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 06/10] x86/entry: Move nmi entry/exit into common code
Message-ID: <20201027070750.GM534324@iweiny-DESK2.sc.intel.com>
References: <20201022222701.887660-1-ira.weiny@intel.com>
 <20201022222701.887660-7-ira.weiny@intel.com>
 <874kmk6298.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kmk6298.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 23, 2020 at 11:50:11PM +0200, Thomas Gleixner wrote:
> On Thu, Oct 22 2020 at 15:26, ira weiny wrote:
> 
> > From: Thomas Gleixner <tglx@linutronix.de>
> >
> > Lockdep state handling on NMI enter and exit is nothing specific to X86. It's
> > not any different on other architectures. Also the extra state type is not
> > necessary, irqentry_state_t can carry the necessary information as well.
> >
> > Move it to common code and extend irqentry_state_t to carry lockdep
> > state.
> 
> This lacks something like:
> 
>  [ Ira: Made the states a union as they are mutually exclusive and added
>         the missing kernel doc ]

Fair enough.  done.

> 
> Hrm.
>  
> >  #ifndef irqentry_state
> >  typedef struct irqentry_state {
> > -	bool	exit_rcu;
> > +	union {
> > +		bool	exit_rcu;
> > +		bool	lockdep;
> > +	};
> >  } irqentry_state_t;
> >  #endif
> 
>   -E_NO_KERNELDOC

Adding: Paul McKenney

I'm happy to write something but I'm very unfamiliar with this code.  So I'm
getting confused what exactly exit_rcu is flagging.

I can see that exit_rcu is a bad name for the state used in
irqentry_nmi_[enter|exit]().  Furthermore, I see why 'lockdep' is a better
name.  But similar lockdep handling is used in irqentry_exit() if exit_rcu is
true...


Given my limited knowledge; here is my proposed text:

/**
 * struct irqentry_state - Opaque object for exception state storage
 * @exit_rcu: Used exclusively in the irqentry_*() calls; tracks if the
 *            exception hit the idle task which requires special handling,
 *            including calling rcu_irq_exit(), when the exception exits.
 * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures lockdep
 *           tracking is maintained if hardirqs were already enabled
 *
 * This opaque object is filled in by the irqentry_*_enter() functions and
 * should be passed back into the corresponding irqentry_*_exit() functions
 * when the exception is complete.
 *
 * Callers of irqentry_*_[enter|exit]() should consider this structure opaque
 * and all members private.  Descriptions of the members are provided to aid in
 * the maintenance of the irqentry_*() functions.
 */


Perhaps Paul can enlighten me on how exit_rcu is used beyond just flagging a
call to rcu_irq_exit()?

Why do we call lockdep_hardirqs_off() only when in the idle task?  That implies
that regs_irqs_disabled() can only be false if we were in the idle task to
match up the lockdep on/off calls.  This does not make sense to me because why
do we need the extra check for exit_rcu?  I'm still trying to understand when
regs_irqs_disabled() is false.


        } else if (!regs_irqs_disabled(regs)) {
...
        } else {
                /*
                 * IRQ flags state is correct already. Just tell RCU if it
                 * was not watching on entry.
                 */
                if (state.exit_rcu)
                        rcu_irq_exit();
        }

Also, the comment in irqentry_enter() refers to irq_enter_from_user_mode() which
does not seem to exist anymore.  So I'm not sure what careful sequence it is
referring to.

        /*
         * If RCU is not watching then the same careful
         * sequence vs. lockdep and tracing is required
         * as in irq_enter_from_user_mode().
         */

?

Ira
