Return-Path: <linux-kselftest+bounces-12448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD1E91254D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 14:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37E9282C6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 12:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F42514E2CC;
	Fri, 21 Jun 2024 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unXpbkxk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117EC219F9;
	Fri, 21 Jun 2024 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973021; cv=none; b=ly9JsRC1QvxS/TAYt22gBo4VeW/0WEOi0xFbJevpF0R2vBmnFGUN7oCthib5xXs+h5a0p3agGB5a+8bLR2+CZc1BntxmJ6H3pOpRiZ+xQG68ScrLbbwQnyRZIIiAHQKV2fS+5wbZ3Ogd10CsPOJNAnD/qrFA2qJOKCjVhcSQOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973021; c=relaxed/simple;
	bh=d8BIEZLavWHUMszYIHJ2D/RcGB1497ngkcDHfH/1lto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBjKzsXn926Q7TW8zdlmpao3uH1eiH3ZPdSyEBET0GY8P9mgcH+Q5rMv3WEtNB7HHmSDzMyHnFddGYdBUgPMkwGEAS0Pp5XRkZJ8NV3GyuLx/73MwGXCBK94yM0m13EZAWyD+Qe5sbgHzjCXH6fF00r2nKiICgdWedicG8LTHCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unXpbkxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F32C2BBFC;
	Fri, 21 Jun 2024 12:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718973020;
	bh=d8BIEZLavWHUMszYIHJ2D/RcGB1497ngkcDHfH/1lto=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=unXpbkxkZLDrFSrnOqxsqvFV0mUZ0aui8YniT5OEligtDcLJkIIPxfR6Hfx7rvuAw
	 J7qc65uORIMsKeesTs2dH30zGk9h93YD6lUW3GnRLuAlhiFyHCzhn0pSutODMnvpn6
	 UkNP+pKNi7IV0s9VLWDZQweW1kbnMWFzYHdN78rMM4OhW8oFZt5zN6Gc0MbL4/+K0d
	 9g4LOaaqnZbaQVvkBlLy5T9Do22N1OcFXkHYyYa8p0F0Et+Y1wzjcEhkJMKWV7rb21
	 2DmOXoqTv2xD0TQzhQxhLKxDDfsBud61TF5MYi8XlZx3M8IlALvAnahEm5XwU9rUsP
	 mgRB+IwmhFRqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4F179CE0D11; Fri, 21 Jun 2024 05:30:20 -0700 (PDT)
Date: Fri, 21 Jun 2024 05:30:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
	lance@osuosl.org
Subject: Re: [PATCH V4] rcutorture: Add CFcommon.arch for the various arch's
 need
Message-ID: <69a993b5-7f02-4013-9d5c-49f615ae6fbb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240619230658.805185-1-zhouzhouyi@gmail.com>
 <673d737a-cf17-4480-a9e2-7ff1668f4b44@paulmck-laptop>
 <ZnVjR0Z9MjHbdlx6@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnVjR0Z9MjHbdlx6@J2N7QTR9R3>

On Fri, Jun 21, 2024 at 12:25:59PM +0100, Mark Rutland wrote:
> On Thu, Jun 20, 2024 at 10:57:27AM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 19, 2024 at 11:06:58PM +0000, Zhouyi Zhou wrote:
> > > Add CFcommon.arch for the various arch's need for rcutorture.
> > >     
> > > In accordance with [1], [2] and [3], move x86 specific kernel option
> > > CONFIG_HYPERVISOR_GUEST to CFcommon.arch, also move kernel option
> > > CONFIG_KVM_GUEST which only exists on x86 & PowerPC to CFcommon.arch. 
> > >     
> > > [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
> > > [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
> > > [3] https://lore.kernel.org/all/ZnBkHosMDhsh4H8g@J2N7QTR9R3/
> > >     
> > > Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
> > >    
> > > Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
> > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > 
> > Thank you!  I have reverted the earlier version to queue this one.
> > Please check below to make sure that my usual wordsmithing did not mess
> > things up.
> > 
> > Mark, any suggestions for any needed ARM CFcommon.arch files?  Or does
> > moving out the x86/PowerPC-specific Kconfig options take care of things
> > for you guys?  (Hey, I can dream, can't I?)
> 
> I'm not aware of anything that we specifically need enabled, so pulling
> out those bits should be everything -- I've given my Ack below.

Sometimes dreams come true?  ;-)

And thank you -- I will apply your ack on my next rebase.

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> > commit 9d6767c47ce4de2ef817e47a5882748d8008ebe9
> > Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > Date:   Wed Jun 19 23:06:58 2024 +0000
> > 
> >     rcutorture: Add CFcommon.arch for arch-specific Kconfig options
> >     
> >     Add CFcommon.arch for arch-specific Kconfig options.
> >     
> >     In accordance with [1], [2] and [3], move the x86-specific kernel option
> >     CONFIG_HYPERVISOR_GUEST to CFcommon.i686 and CFcommon.x86_64, and also
> >     move the x86/PowerPC CONFIG_KVM_GUEST Kconfig option to CFcommon.i686,
> >     CFcommon.x86_64, and CFcommon.ppc64le.
> >     
> >     The "arch" in CFcommon.arch is taken from the "uname -m" command.
> >     
> >     [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
> >     [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
> >     [3] https://lore.kernel.org/all/ZnBkHosMDhsh4H8g@J2N7QTR9R3/
> >     
> >     Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
> >     
> >     Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
> >     Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> >     Suggested-by: Mark Rutland <mark.rutland@arm.com>
> >     Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
> 
> 
> > 
> > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> > index b33cd87536899..ad79784e552d2 100755
> > --- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> > @@ -68,6 +68,8 @@ config_override_param "--gdb options" KcList "$TORTURE_KCONFIG_GDB_ARG"
> >  config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KASAN_ARG"
> >  config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
> >  config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
> > +config_override_param "$config_dir/CFcommon.$(uname -m)" KcList \
> > +		      "`cat $config_dir/CFcommon.$(uname -m) 2> /dev/null`"
> >  cp $T/KcList $resdir/ConfigFragment
> >  
> >  base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> > index 0e92d85313aa7..217597e849052 100644
> > --- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> > @@ -1,7 +1,5 @@
> >  CONFIG_RCU_TORTURE_TEST=y
> >  CONFIG_PRINTK_TIME=y
> > -CONFIG_HYPERVISOR_GUEST=y
> >  CONFIG_PARAVIRT=y
> > -CONFIG_KVM_GUEST=y
> >  CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n
> >  CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
> > new file mode 100644
> > index 0000000000000..d8b2f555686fb
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
> > @@ -0,0 +1,2 @@
> > +CONFIG_HYPERVISOR_GUEST=y
> > +CONFIG_KVM_GUEST=y
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
> > new file mode 100644
> > index 0000000000000..133da04247ee0
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
> > @@ -0,0 +1 @@
> > +CONFIG_KVM_GUEST=y
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
> > new file mode 100644
> > index 0000000000000..d8b2f555686fb
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
> > @@ -0,0 +1,2 @@
> > +CONFIG_HYPERVISOR_GUEST=y
> > +CONFIG_KVM_GUEST=y

