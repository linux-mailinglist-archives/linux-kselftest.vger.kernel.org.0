Return-Path: <linux-kselftest+bounces-12156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA9B90D5B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 16:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F521F2017B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEF716DC1D;
	Tue, 18 Jun 2024 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uuj9PezC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14016ABC6;
	Tue, 18 Jun 2024 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721001; cv=none; b=eTCvG+SsII/T5pdzStoDMjDrnnXmUb1eynswHigWxkol8tm61Tg20xURqEQ17J+WCi/yquHQjeHJJOZ9E/T9NaBZepaAvOsZgm5wCMN6JOgYBq0x2tcwMlE737smL9KGwUOZ8YyFlqCtZbH/Pbz+Ze9COEG3S9Kb/+w4sxf0uTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721001; c=relaxed/simple;
	bh=aAUJ4RS80Dus1HHmyBu5Y79cj3kmhTtE0lhAPkwjXdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvCKJYOQsA6sBiWQ20MZfDZOIBQEq7hmCj4PllV1TV7SiOHNKE5f8tm6yNSrAMfAPRlHyGXt9KZ4GLie04Ymk8EX8hIn1SHkOJndORk9vBEMRRE8KnyLJpZESujAvh8SBwhOSyeVz289gygGzyy9UO1tfXkOapTMmZP0D//LfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uuj9PezC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED115C3277B;
	Tue, 18 Jun 2024 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718721001;
	bh=aAUJ4RS80Dus1HHmyBu5Y79cj3kmhTtE0lhAPkwjXdw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Uuj9PezC/ZxGAMrDosUCIHXsmiBrPiQAVgFQ+UzY+2DiHMzAjbUQdBjeCCw+YZVO6
	 ThiOA1ny8FYt3bNQ2SEnrqLxfsYDldgJI72jd7/PGwkrYRB7r7YxZv+JK7d8Mm32aq
	 CoYpUOCOTxo9rPY04Xe11IKaRp7dWf6I1Xy7BtFKIILI80CGftyVoAmE+uoxKF9wlc
	 j9DdMjxZYLZthtHNeHr2fyLC4jYz04CNZ24Gc5sYHSjF42+SVHydc2XAYc4tqbj9PN
	 vXfTKNGW0mLROQnyYyABI7H/sMd+W2Aak8LQ+eY7nnpwkZOH6uXTRURQDDkJ5KESUV
	 h/8QdvYtHVnow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 92409CE04AF; Tue, 18 Jun 2024 07:30:00 -0700 (PDT)
Date: Tue, 18 Jun 2024 07:30:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
	lance@osuosl.org
Subject: Re: [PATCH V3] rcutorture: Add CFcommon.arch for the various arch's
 need
Message-ID: <7150e2fa-c627-435c-97d2-80065d1f1920@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240612013527.1325751-1-zhouzhouyi@gmail.com>
 <def32dd4-b205-45b8-a5ed-e6e28a0ac4f4@paulmck-laptop>
 <ZnBkHosMDhsh4H8g@J2N7QTR9R3>
 <76deed7a-9852-4d21-bbcc-8b14e267fe89@paulmck-laptop>
 <CAABZP2z0-zHTADL5REThay5CYcfSBaHA4mUXO6NYu-JJA7=Xvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABZP2z0-zHTADL5REThay5CYcfSBaHA4mUXO6NYu-JJA7=Xvg@mail.gmail.com>

On Tue, Jun 18, 2024 at 06:41:22AM +0800, Zhouyi Zhou wrote:
> On Tue, Jun 18, 2024 at 12:47 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Jun 17, 2024 at 05:28:14PM +0100, Mark Rutland wrote:
> > > On Tue, Jun 11, 2024 at 07:57:29PM -0700, Paul E. McKenney wrote:
> > > > On Wed, Jun 12, 2024 at 01:35:27AM +0000, Zhouyi Zhou wrote:
> > > > > Add CFcommon.arch for the various arch's need for rcutorture.
> > > > >
> > > > > According to [1] and [2], this patch
> > > > > Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options") by moving
> > > > > x86 specific kernel option CONFIG_HYPERVISOR_GUEST to CFcommon.arch
> > > > >
> > > > > The patch has been revised and improved under
> > > > > Paul E. McKenney's guidance [3].
> > > > >
> > > > > [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
> > > > > [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
> > > > > [3] https://lore.kernel.org/lkml/cd3709dc-2c08-4ac2-a19b-d8edb66195e3@paulmck-laptop/T/
> > > > >
> > > > > Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
> > > > >
> > > > > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > >
> > > > Much better, thank you!
> > > >
> > > > I queued and pushed for review and testing with the usual editing,
> > > > so please let me know if I messed anything up.
> > > >
> > > > I added Mark on CC in case he has thoughts from an ARM perspective.
> > >
> > > Ah, thanks!
> > >
> > > >From a quick scan, the only thing I spot is that CONFIG_KVM_GUEST is
> > > also not an arm64 thing, and only exists on x86 & powerpc, so pulling
> > > that out too would be nice.
> yes, CONFIG_KVM_GUEST exists in powerpc & x86, which makes me think it
> is global.
> >
> > Thank you for looking this over!
> >
> > Zhouyi, would you be willing to add this change, either as a new version
> > of this patch or as a new patch on top of it?  (Your choice.)
> Thanks to Paul and Mark's guidance, I achieved a lot during this process ;-)
> 
> I am going to create a new version of the patch, and test is both on
> X86 and PowerPC

Very good, looking forward to it!

							Thanx, Paul

> Cheers
> Zhouyi
> >
> > > That aside, this looks good to me; having the infrastructure to do this
> > > per-arch is nice!
> >
> > Glad you like it!  May we have your ack?
> Very happy that Mark likes it ;-)
> >
> >                                                         Thanx, Paul
> >
> > > Mark.
> > >
> > > >
> > > >                                                     Thanx, Paul
> > > >
> > > > ------------------------------------------------------------------------
> > > >
> > > > commit 29cf4c63d04b9752a32e33d46a57717121353ef7
> > > > Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > > Date:   Wed Jun 12 01:35:27 2024 +0000
> > > >
> > > >     rcutorture: Add CFcommon.arch for the various arch's need
> > > >
> > > >     Add CFcommon.arch for the various arch's need for rcutorture.
> > > >
> > > >     In accordance with [1] and [2], this patch moves x86 specific kernel
> > > >     option CONFIG_HYPERVISOR_GUEST to CFcommon.arch
> > > >
> > > >     [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
> > > >     [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
> > > >
> > > >     Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
> > > >
> > > >     Link: https://lore.kernel.org/lkml/cd3709dc-2c08-4ac2-a19b-d8edb66195e3@paulmck-laptop/T/
> > > >
> > > >     Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
> > > >     Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > >     Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > >     Cc: Mark Rutland <mark.rutland@arm.com>
> > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > >
> > > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> > > > index b33cd87536899..ad79784e552d2 100755
> > > > --- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> > > > +++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> > > > @@ -68,6 +68,8 @@ config_override_param "--gdb options" KcList "$TORTURE_KCONFIG_GDB_ARG"
> > > >  config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KASAN_ARG"
> > > >  config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
> > > >  config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
> > > > +config_override_param "$config_dir/CFcommon.$(uname -m)" KcList \
> > > > +                 "`cat $config_dir/CFcommon.$(uname -m) 2> /dev/null`"
> > > >  cp $T/KcList $resdir/ConfigFragment
> > > >
> > > >  base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
> > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> > > > index 0e92d85313aa7..cf0387ae53584 100644
> > > > --- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> > > > @@ -1,6 +1,5 @@
> > > >  CONFIG_RCU_TORTURE_TEST=y
> > > >  CONFIG_PRINTK_TIME=y
> > > > -CONFIG_HYPERVISOR_GUEST=y
> > > >  CONFIG_PARAVIRT=y
> > > >  CONFIG_KVM_GUEST=y
> > > >  CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n
> > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
> > > > new file mode 100644
> > > > index 0000000000000..2770560d56a0c
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
> > > > @@ -0,0 +1 @@
> > > > +CONFIG_HYPERVISOR_GUEST=y
> > > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
> > > > new file mode 100644
> > > > index 0000000000000..2770560d56a0c
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
> > > > @@ -0,0 +1 @@
> > > > +CONFIG_HYPERVISOR_GUEST=y

