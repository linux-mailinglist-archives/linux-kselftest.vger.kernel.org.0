Return-Path: <linux-kselftest+bounces-11084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205E68D6DEC
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 06:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46ADB222E7
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 04:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96C6AD27;
	Sat,  1 Jun 2024 04:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lft4ePU4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9E6FB9;
	Sat,  1 Jun 2024 04:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717216555; cv=none; b=WvCsycz0PBwxUFS8LCmQtW5kpHkmv1cNiUBVg+7EZLhCpOE960mNMnL1HJ9OmZHpbJ3S8FxsbJbh6fHCmHaO98EUOoIw6Nth8llWjLPvD+bxJD5LH+9lBAg+crre58r9TREZV5SFe0/UiuqfWNESi3YUhe9Wj0Hy1VXqjCXER5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717216555; c=relaxed/simple;
	bh=SI7i+N6/ROMTVTE/LwEP0B+nmSkzIYrf64g/UNbOUsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb3RLXfbp6GYbWC0dtT7/TIW4QT6O1OCnvOq8cNUKe+E9CK0gvxKbKRaS5G/4qfuq0KZCjHQPc2qqpfsUOJmpQgvpfUrCDjrT3K29V5MILI2NTWmynEF2LenGimJ/+KTm/BI82PqNuABzhUfuimRLpWeJcbhJKL/X9CFsdhWvCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lft4ePU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C90C116B1;
	Sat,  1 Jun 2024 04:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717216555;
	bh=SI7i+N6/ROMTVTE/LwEP0B+nmSkzIYrf64g/UNbOUsg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lft4ePU423bhFQdNkXC91TxLpnIOnBV6K/bgwuTFzcyqwscV3OicJT4Mxio2DFD7N
	 6wH0N/sYjV2wrcAz/5e5rjE8U5DlnbMR0wMQK+bW0g+Y0YqVOY/bh5kCge1OAvR//l
	 6TbCVS29nOcKSchVF3T+mNAluZsqo5dMBpCiicSTa5hzI6/bM6mIPoUlDwrqywYceb
	 H3EktM4740vjYRCfHY80OzABANRgY2WwP5ZkJITb93YYt4BgsACbiOp9sWtzY274ir
	 srbj2UFTNPSo9elT2t28xNkGvTnClaoLyJbCvBwj/gcaVN+pdFw/VlmWQyt9himJM8
	 2NilUQaAPFbnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0DB0ECE3ED6; Fri, 31 May 2024 21:35:55 -0700 (PDT)
Date: Fri, 31 May 2024 21:35:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org, lance@osuosl.org
Subject: Re: [PATCH V2] rcutorture: Add CFcommon.arch for the various arch's
 need
Message-ID: <cd3709dc-2c08-4ac2-a19b-d8edb66195e3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240531235347.1118612-1-zhouzhouyi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531235347.1118612-1-zhouzhouyi@gmail.com>

On Fri, May 31, 2024 at 11:53:47PM +0000, Zhouyi Zhou wrote:
> Add CFcommon.arch for the various arch's need for rcutorture.
> 
> According to [1] and [2], this patch
> Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options") by moving
> x86 specific kernel option CONFIG_HYPERVISOR_GUEST to CFcommon.x86
> 
> [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
> [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
> 
> Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
> Hi Paul,
> 
> I tried very hard to find in Linux kernel on how to dig out
> the x86 specific kernel option CONFIG_HYPERVISOR_GUEST before configcheck.sh
> generates ConfigFragment.diags.
> 
> I can only find this functionality in scripts/kconfig/conf which travels
> the Kconfig hierarchy.
> 
> But the output of scripts/kconfig/conf, which is .config
> is also one of the input of configcheck.sh:
> ```
> kvm-recheck.sh:	configcheck.sh $i/.config $i/ConfigFragment > $i/ConfigFragment.diags 2>&1
> ```
> 
> I feel some logic paradox in it ;-)

At least now we can say that you looked.

> So, I pick the simplest way.

Very good, thank you!

> One more thing, recent change in include/linux/bitmap.h cause the make
> of allmodconfig fail because of warning on both x86 platforms, I am
> going to do research on it.

Thank you, looking forward to seeing what you come up with.

One question below.

> Thank your for your guidance
> Zhouyi
> --
>  tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 9 +++++++++
>  tools/testing/selftests/rcutorture/configs/rcu/CFcommon  | 1 -
>  .../selftests/rcutorture/configs/rcu/CFcommon.x86        | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> index b33cd8753689..5332224238ba 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> @@ -62,6 +62,15 @@ config_override_param () {
>  }
>  
>  echo > $T/KcList
> +if uname -m | grep -q 86

Why not just use "uname -m" output itself for the filename extension?
That way, we wouldn't need this "if" statement.  Or are you looking to
map both "i686" and "x86_64" to "x86"?

> +# TODO: add other architecture-specific common configuration when needed
> +then
> +	if test -f $config_dir/CFcommon.x86

Do we really need this inner "if"?  The config_override_param() bash
function already checks for ran empty-string third argument.  Or does
this cause some other problem?

> +	then
> +		config_override_param "$config_dir/CFcommon.x86" KcList\
> +			"`cat $config_dir/CFcommon.x86 2> /dev/null`"
> +	fi
> +fi
>  config_override_param "$config_dir/CFcommon" KcList "`cat $config_dir/CFcommon 2> /dev/null`"

Also, the CFcommon.x86 check shouild follow the CFcommon check.  This
allows architecture-specific values to override the global ones.

							Thanx, Paul

>  config_override_param "$config_template" KcList "`cat $config_template 2> /dev/null`"
>  config_override_param "--gdb options" KcList "$TORTURE_KCONFIG_GDB_ARG"
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> index 0e92d85313aa..cf0387ae5358 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> @@ -1,6 +1,5 @@
>  CONFIG_RCU_TORTURE_TEST=y
>  CONFIG_PRINTK_TIME=y
> -CONFIG_HYPERVISOR_GUEST=y
>  CONFIG_PARAVIRT=y
>  CONFIG_KVM_GUEST=y
>  CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86
> new file mode 100644
> index 000000000000..2770560d56a0
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86
> @@ -0,0 +1 @@
> +CONFIG_HYPERVISOR_GUEST=y
> -- 
> 2.25.1
> 

