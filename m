Return-Path: <linux-kselftest+bounces-12073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DDC90B656
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 18:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148E628157F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA2614E2C8;
	Mon, 17 Jun 2024 16:28:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81349847A;
	Mon, 17 Jun 2024 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641704; cv=none; b=g170PkX2Z8EaB3IQKwMqpoj4nDu9b3tC+wauCr1k/CHiaxzbTwvsKGZeReFrR9IUfiJsznauJSjIpTpe7rQidZ5R3qf2p33dTOFDzPc0Tz8TSORO8hESlLm56DgeHKM8qpwLj+OKc4vVziWmHgIciLgPnH3drunPesI8Fi4jk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641704; c=relaxed/simple;
	bh=uHcLS7kwXtHKKhg0768IzJSfiDSCIBNCfhKdJ+TtzH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYWSF2aqIrMRD26dC8EsorOfmNvz9xd5shYnFIvrGvn7odj+tUlOcrNvP/eYws38anBA+dwtvO3AF5hnkWl9doHbZJKY85pAGoKGeK9AQbbNIqlR5/Yj7L2w3Ul/kZq249CiKezpGAvX/axyVmnrnAT7c65wFXsEjMvZvWm7Xfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DB42DA7;
	Mon, 17 Jun 2024 09:28:45 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B25E83F64C;
	Mon, 17 Jun 2024 09:28:19 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:28:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
	lance@osuosl.org
Subject: Re: [PATCH V3] rcutorture: Add CFcommon.arch for the various arch's
 need
Message-ID: <ZnBkHosMDhsh4H8g@J2N7QTR9R3>
References: <20240612013527.1325751-1-zhouzhouyi@gmail.com>
 <def32dd4-b205-45b8-a5ed-e6e28a0ac4f4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def32dd4-b205-45b8-a5ed-e6e28a0ac4f4@paulmck-laptop>

On Tue, Jun 11, 2024 at 07:57:29PM -0700, Paul E. McKenney wrote:
> On Wed, Jun 12, 2024 at 01:35:27AM +0000, Zhouyi Zhou wrote:
> > Add CFcommon.arch for the various arch's need for rcutorture.
> > 
> > According to [1] and [2], this patch
> > Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options") by moving
> > x86 specific kernel option CONFIG_HYPERVISOR_GUEST to CFcommon.arch
> > 
> > The patch has been revised and improved under
> > Paul E. McKenney's guidance [3].
> > 
> > [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
> > [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
> > [3] https://lore.kernel.org/lkml/cd3709dc-2c08-4ac2-a19b-d8edb66195e3@paulmck-laptop/T/
> > 
> > Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
> > 
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> 
> Much better, thank you!
> 
> I queued and pushed for review and testing with the usual editing,
> so please let me know if I messed anything up.
> 
> I added Mark on CC in case he has thoughts from an ARM perspective.

Ah, thanks!

From a quick scan, the only thing I spot is that CONFIG_KVM_GUEST is
also not an arm64 thing, and only exists on x86 & powerpc, so pulling
that out too would be nice.

That aside, this looks good to me; having the infrastructure to do this
per-arch is nice!

Mark.

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 29cf4c63d04b9752a32e33d46a57717121353ef7
> Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Date:   Wed Jun 12 01:35:27 2024 +0000
> 
>     rcutorture: Add CFcommon.arch for the various arch's need
>     
>     Add CFcommon.arch for the various arch's need for rcutorture.
>     
>     In accordance with [1] and [2], this patch moves x86 specific kernel
>     option CONFIG_HYPERVISOR_GUEST to CFcommon.arch
>     
>     [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
>     [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
>     
>     Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
>     
>     Link: https://lore.kernel.org/lkml/cd3709dc-2c08-4ac2-a19b-d8edb66195e3@paulmck-laptop/T/
>     
>     Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
>     Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>     Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
> index 0e92d85313aa7..cf0387ae53584 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> @@ -1,6 +1,5 @@
>  CONFIG_RCU_TORTURE_TEST=y
>  CONFIG_PRINTK_TIME=y
> -CONFIG_HYPERVISOR_GUEST=y
>  CONFIG_PARAVIRT=y
>  CONFIG_KVM_GUEST=y
>  CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
> new file mode 100644
> index 0000000000000..2770560d56a0c
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
> @@ -0,0 +1 @@
> +CONFIG_HYPERVISOR_GUEST=y
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
> new file mode 100644
> index 0000000000000..2770560d56a0c
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
> @@ -0,0 +1 @@
> +CONFIG_HYPERVISOR_GUEST=y

