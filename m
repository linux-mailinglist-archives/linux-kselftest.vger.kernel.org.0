Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD131FBD8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 20:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbgFPSHr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 14:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgFPSHq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 14:07:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ECFA2080D;
        Tue, 16 Jun 2020 18:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592330866;
        bh=BZVysaZqnl67vY/M5mVFjgt/xrn3O0skxUj6yV26weo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Pw4W5yFw/l7lO4Jll6CPSzUj625dEi9McWKVnKN0AE2ux5jYWHuLpeeUAVmmdBLUR
         N8WuCD7X9b9yfKgvyxoR0PiILospc5cD5Y6Roz5whsRqzcl6UYLReocT8T2ANW+zqr
         SepWw9KZmDzmQAElI9RKb6/LeALmitipNj+gEbGg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 08F14352264F; Tue, 16 Jun 2020 11:07:46 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:07:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, shuah@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] torture: Pass --kmake-arg to all make invocations
Message-ID: <20200616180745.GG2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200616094924.159539-1-elver@google.com>
 <20200616160524.GW2723@paulmck-ThinkPad-P72>
 <20200616164202.GA208325@google.com>
 <20200616174222.GB2723@paulmck-ThinkPad-P72>
 <20200616175720.GA124701@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616175720.GA124701@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 16, 2020 at 07:57:20PM +0200, Marco Elver wrote:
> On Tue, Jun 16 2020 at 10:42AM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 16, 2020 at 06:42:02PM +0200, Marco Elver wrote:
> > > On Tue, Jun 16 2020 at 09:05AM -0700, Paul E. McKenney wrote:
> > > > On Tue, Jun 16, 2020 at 11:49:24AM +0200, Marco Elver wrote:
> > > > > We need to pass the arguments provided to --kmake-arg to all make
> > > > > invocations. In particular, the make invocations generating the configs
> > > > > need to see the final make arguments, e.g. if config variables depend on
> > > > > particular variables that are passed to make.
> > > > > 
> > > > > For example, when using '--kcsan --kmake-arg CC=clang-11', we would lose
> > > > > CONFIG_KCSAN=y due to 'make oldconfig' not seeing that we want to use a
> > > > > compiler that supports KCSAN.
> > > > > 
> > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > 
> > > > Queued and pushed, thank you!
> > > > 
> > > > Would the following patch make sense, at least until such time
> > > > as some other compiler supports KCSAN?
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > commit 88bcaa730b6d40ddf69b09ed6f0a14803d087d99
> > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > Date:   Tue Jun 16 09:02:34 2020 -0700
> > > > 
> > > >     torture: Make --kcsan default to using Clang 11
> > > >     
> > > >     Currently, Clang 11 is the only compiler that can support KCSAN.
> > > >     Therefore, as a convenience to the KCSAN user, this commit causes
> > > >     --kcsan to specify Clang 11 unless a "CC=" argument was already
> > > >     specified via the --kmake-arg argument.
> > > 
> > > As soon as more compilers support KCSAN (e.g. clang-12, etc...) we run
> > > the risk of actually inconveniencing ourselves more because then we
> > > really need to say '--kmake-arg CC=clang-1X' to not use the old
> > > compiler. Or revert this in time.
> > > 
> > > My command-line looks more like this right now:
> > > 
> > > 	kvm.sh ... --kmake-arg "CC="${HOME}/local/<gcc-or-clang>-11.kcsan/local/bin/<gcc-or-clang>" ...
> > > 
> > > I think the safer alternative would be to error if CONFIG_KCSAN=y is not
> > > in the config, and simply suggest "Did you forget to switch your
> > > compiler with '--kmake-arg CC=<cc-that-supports-kcsan>'?" (of course, a
> > > 'gcc' in $PATH that supports KCSAN would also be fine -- see below).
> > > Eventually, when the default compilers support KCSAN, this will resolve
> > > itself gracefully.
> > > 
> > > Also, I'm going to send a series later this week to re-enable GCC
> > > support. ;-)
> > 
> > OK, sounds like I should leave well enough alone, then.  ;-)
> > 
> > In its current state, specifying "--kcsan" without a KCSAN-capable
> > compiler does get you this:
> > 
> > :CONFIG_KCSAN=y: improperly set
> > :CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
> > :CONFIG_KCSAN_VERBOSE=y: improperly set
> > :CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
> > Clean KCSAN run in /home/git/linux-rcu/tools/testing/selftests/rcutorture/res/2020.06.16-09.53.16
> > 
> > Which admittedly is a bit obtuse, especially that last line.  So how
> > about the following patch, which instead results in this?
> > 
> > :CONFIG_KCSAN=y: improperly set
> > :CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
> > :CONFIG_KCSAN_VERBOSE=y: improperly set
> 
> Noticed that CONFIG_KCSAN_VERBOSE=y warning still appears, because it
> wants CONFIG_PROVE_LOCKING=y.
> 
> > :CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
> > Did you forget to switch your compiler with --kmake-arg CC=<cc-that-supports-kcsan>?
> 
> Sounds good, with another suggestion below, but otherwise
> 
> Acked-by: Marco Elver <elver@google.com>

Applied and updated as suggested below, so that the output now looks
like this:

:CONFIG_KCSAN=y: improperly set
:CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
:CONFIG_KCSAN_VERBOSE=y: improperly set
:CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
Compiler or architecture does not support KCSAN!
Did you forget to switch your compiler with --kmake-arg CC=<cc-that-supports-kcsan>?

And agreed, much better!

							Thanx, Paul

> Thanks,
> -- Marco
> 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit f571795b1146007407851675a258b6685ea2d589
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Jun 16 10:38:57 2020 -0700
> > 
> >     torture: Improve diagnostic for KCSAN-incapable compilers
> >     
> >     Using --kcsan when the compiler does not support KCSAN results in this:
> >     
> >     :CONFIG_KCSAN=y: improperly set
> >     :CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
> >     :CONFIG_KCSAN_VERBOSE=y: improperly set
> >     :CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
> >     Clean KCSAN run in /home/git/linux-rcu/tools/testing/selftests/rcutorture/res/2020.06.16-09.53.16
> >     
> >     This is a bit obtuse, so this commit adds checks resulting in this:
> >     
> >     :CONFIG_KCSAN=y: improperly set
> >     :CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
> >     :CONFIG_KCSAN_VERBOSE=y: improperly set
> >     :CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
> >     Did you forget to switch your compiler with --kmake-arg CC=<cc-that-supports-kcsan>?
> >     
> >     Suggested-by: Marco Elver <elver@google.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
> > index 357899c..837643a 100755
> > --- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
> > @@ -44,7 +44,8 @@ do
> >  			then
> >  				echo QEMU killed
> >  			fi
> > -			configcheck.sh $i/.config $i/ConfigFragment
> > +			configcheck.sh $i/.config $i/ConfigFragment > $T 2>&1
> > +			cat $T
> >  			if test -r $i/Make.oldconfig.err
> >  			then
> >  				cat $i/Make.oldconfig.err
> > @@ -73,7 +74,10 @@ do
> >  	done
> >  	if test -f "$rd/kcsan.sum"
> >  	then
> > -		if test -s "$rd/kcsan.sum"
> > +		if grep -q CONFIG_KCSAN=y $T
> > +		then
> 
> For completeness, could add this above:
> 
> 	echo "Compiler or architecture does not support KCSAN!"
> 
> Because we might also be on an unsupported architecture.
> 
> > +			echo Did you forget to switch your compiler with '--kmake-arg CC=<cc-that-supports-kcsan>'?
> > +		elif test -s "$rd/kcsan.sum"
> >  		then
> >  			echo KCSAN summary in $rd/kcsan.sum
> >  		else
