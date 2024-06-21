Return-Path: <linux-kselftest+bounces-12446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C491238B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 13:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28CBEB25C08
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 11:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B008176FB4;
	Fri, 21 Jun 2024 11:26:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC0173336;
	Fri, 21 Jun 2024 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969166; cv=none; b=T39foboPJ0QHjyRqB9Q/hpuBeOx5WXaF8Ex6Ll7x9lPnXHlRuAAKz4GyNl4sr/HOOLw9iewz5tW1I+vaQ6ivRRK3Q1uLvUonTDa8OoMubbPktCQNqJGdyWsnM6ff8Dv74k/PAfF0+GZGx+gvifjwOqkn7PYLbu3nZ0egefa90wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969166; c=relaxed/simple;
	bh=V3B7lVlTltqqQwmYDTOmhjOvpdBEBQlP8Q5IvXhj3nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It0JT3EkHvWx712VO8jjIyZ9pW2HJfiopbn0kfpsms9v928yZkDZkFuLZ7Yh2B5iuX/gtKQ3tdKa+VZSepLRnQiXhb6gEJEfLbXKT5FcOzY9wVPxL1DLWLnU34mwXgeH2kzFRoHRWbM1VU6SR8LqQFWu8UOSRJcZ4odN//wwl1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7E6ADA7;
	Fri, 21 Jun 2024 04:26:27 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 178823F6A8;
	Fri, 21 Jun 2024 04:26:01 -0700 (PDT)
Date: Fri, 21 Jun 2024 12:25:59 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
	lance@osuosl.org
Subject: Re: [PATCH V4] rcutorture: Add CFcommon.arch for the various arch's
 need
Message-ID: <ZnVjR0Z9MjHbdlx6@J2N7QTR9R3>
References: <20240619230658.805185-1-zhouzhouyi@gmail.com>
 <673d737a-cf17-4480-a9e2-7ff1668f4b44@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <673d737a-cf17-4480-a9e2-7ff1668f4b44@paulmck-laptop>

On Thu, Jun 20, 2024 at 10:57:27AM -0700, Paul E. McKenney wrote:
> On Wed, Jun 19, 2024 at 11:06:58PM +0000, Zhouyi Zhou wrote:
> > Add CFcommon.arch for the various arch's need for rcutorture.
> >     
> > In accordance with [1], [2] and [3], move x86 specific kernel option
> > CONFIG_HYPERVISOR_GUEST to CFcommon.arch, also move kernel option
> > CONFIG_KVM_GUEST which only exists on x86 & PowerPC to CFcommon.arch. 
> >     
> > [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
> > [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
> > [3] https://lore.kernel.org/all/ZnBkHosMDhsh4H8g@J2N7QTR9R3/
> >     
> > Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
> >    
> > Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> 
> Thank you!  I have reverted the earlier version to queue this one.
> Please check below to make sure that my usual wordsmithing did not mess
> things up.
> 
> Mark, any suggestions for any needed ARM CFcommon.arch files?  Or does
> moving out the x86/PowerPC-specific Kconfig options take care of things
> for you guys?  (Hey, I can dream, can't I?)

I'm not aware of anything that we specifically need enabled, so pulling
out those bits should be everything -- I've given my Ack below.

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 9d6767c47ce4de2ef817e47a5882748d8008ebe9
> Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Date:   Wed Jun 19 23:06:58 2024 +0000
> 
>     rcutorture: Add CFcommon.arch for arch-specific Kconfig options
>     
>     Add CFcommon.arch for arch-specific Kconfig options.
>     
>     In accordance with [1], [2] and [3], move the x86-specific kernel option
>     CONFIG_HYPERVISOR_GUEST to CFcommon.i686 and CFcommon.x86_64, and also
>     move the x86/PowerPC CONFIG_KVM_GUEST Kconfig option to CFcommon.i686,
>     CFcommon.x86_64, and CFcommon.ppc64le.
>     
>     The "arch" in CFcommon.arch is taken from the "uname -m" command.
>     
>     [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
>     [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
>     [3] https://lore.kernel.org/all/ZnBkHosMDhsh4H8g@J2N7QTR9R3/
>     
>     Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
>     
>     Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
>     Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>     Suggested-by: Mark Rutland <mark.rutland@arm.com>
>     Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.


> 
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> index b33cd87536899..ad79784e552d2 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> @@ -68,6 +68,8 @@ config_override_param "--gdb options" KcList "$TORTURE_KCONFIG_GDB_ARG"
>  config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KASAN_ARG"
>  config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
>  config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
> +config_override_param "$config_dir/CFcommon.$(uname -m)" KcList \
> +		      "`cat $config_dir/CFcommon.$(uname -m) 2> /dev/null`"
>  cp $T/KcList $resdir/ConfigFragment
>  
>  base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> index 0e92d85313aa7..217597e849052 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> @@ -1,7 +1,5 @@
>  CONFIG_RCU_TORTURE_TEST=y
>  CONFIG_PRINTK_TIME=y
> -CONFIG_HYPERVISOR_GUEST=y
>  CONFIG_PARAVIRT=y
> -CONFIG_KVM_GUEST=y
>  CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n
>  CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
> new file mode 100644
> index 0000000000000..d8b2f555686fb
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
> @@ -0,0 +1,2 @@
> +CONFIG_HYPERVISOR_GUEST=y
> +CONFIG_KVM_GUEST=y
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
> new file mode 100644
> index 0000000000000..133da04247ee0
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
> @@ -0,0 +1 @@
> +CONFIG_KVM_GUEST=y
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
> new file mode 100644
> index 0000000000000..d8b2f555686fb
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
> @@ -0,0 +1,2 @@
> +CONFIG_HYPERVISOR_GUEST=y
> +CONFIG_KVM_GUEST=y

