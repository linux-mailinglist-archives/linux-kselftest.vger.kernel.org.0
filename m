Return-Path: <linux-kselftest+bounces-12351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68985910FE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 20:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9534EB26C2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF3D1BD03E;
	Thu, 20 Jun 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3p4k6OH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E21BD037;
	Thu, 20 Jun 2024 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906248; cv=none; b=r3C3QG2ENlvImXK/FB9vKNKIOLZxW8WMbpd2ODztR2vn55SaMcJH9ojUm/fbBzrGUwg3KyfGBYKl8zn3hRYX4yxN1BC8eRIYwYR5AG8eXilavYdC5oL/oewZQzTeIMDPK4cGptPkC7uLWtE+mqRnSTWKcjuWFWzlPnzXWVkQqS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906248; c=relaxed/simple;
	bh=zTjEYTww94hAqB345kszLTrjaD7eDCq4Pj+zIh3PWy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lruKYAvNruDFNqnE66eKMgnHt+Ts9vlA4LilRsehz+/jNMQB0ZR1Fv/IlrOIkQ/aUc7v4xwIpmp2rXSq1/fZOkpBNGQBDmoN4f9hhFPPj0fjTAFg6zs5i+9E3fMX/nuZeVxIfbIhOWaYrSMOHEz/eHU0OHwXnXfwsOaZvqVRQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3p4k6OH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80580C4AF09;
	Thu, 20 Jun 2024 17:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718906247;
	bh=zTjEYTww94hAqB345kszLTrjaD7eDCq4Pj+zIh3PWy8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=V3p4k6OHFFz9K9HhxlY3PkdGZZm8girsk00C6HSREMA10V2HOdTbWU8HxhdrLihX4
	 Vv7rqgEqJX0dDt8YtxGNJzc5HYlA7EuAzDrW7ewga7U4yyCmv9j0LnxjPVDndi6ZhG
	 0sXEzd8fUFIhHsrgIQNqZVF4bBqdc5EX0ARH8RTKTQxQf1ngqzDic9ztCFR3N00rZi
	 a1Fzrpw7hexdY91LGTZJF6CffxQgqqmULHAunKXrfhzkT2LgIYMo7abrnzyQ/riBfM
	 AkuSfAqHSqYLCJ5JH7fqiDUCJNW+S8tzAMuo4IdNFJtuhuZHaKSBX7r1/YGVGtHsqF
	 yzgEKrsrQJCHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 20A1DCE0B67; Thu, 20 Jun 2024 10:57:27 -0700 (PDT)
Date: Thu, 20 Jun 2024 10:57:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org, lance@osuosl.org,
	mark.rutland@arm.com
Subject: Re: [PATCH V4] rcutorture: Add CFcommon.arch for the various arch's
 need
Message-ID: <673d737a-cf17-4480-a9e2-7ff1668f4b44@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240619230658.805185-1-zhouzhouyi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619230658.805185-1-zhouzhouyi@gmail.com>

On Wed, Jun 19, 2024 at 11:06:58PM +0000, Zhouyi Zhou wrote:
> Add CFcommon.arch for the various arch's need for rcutorture.
>     
> In accordance with [1], [2] and [3], move x86 specific kernel option
> CONFIG_HYPERVISOR_GUEST to CFcommon.arch, also move kernel option
> CONFIG_KVM_GUEST which only exists on x86 & PowerPC to CFcommon.arch. 
>     
> [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
> [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
> [3] https://lore.kernel.org/all/ZnBkHosMDhsh4H8g@J2N7QTR9R3/
>     
> Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
>    
> Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Thank you!  I have reverted the earlier version to queue this one.
Please check below to make sure that my usual wordsmithing did not mess
things up.

Mark, any suggestions for any needed ARM CFcommon.arch files?  Or does
moving out the x86/PowerPC-specific Kconfig options take care of things
for you guys?  (Hey, I can dream, can't I?)

							Thanx, Paul

------------------------------------------------------------------------

commit 9d6767c47ce4de2ef817e47a5882748d8008ebe9
Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed Jun 19 23:06:58 2024 +0000

    rcutorture: Add CFcommon.arch for arch-specific Kconfig options
    
    Add CFcommon.arch for arch-specific Kconfig options.
    
    In accordance with [1], [2] and [3], move the x86-specific kernel option
    CONFIG_HYPERVISOR_GUEST to CFcommon.i686 and CFcommon.x86_64, and also
    move the x86/PowerPC CONFIG_KVM_GUEST Kconfig option to CFcommon.i686,
    CFcommon.x86_64, and CFcommon.ppc64le.
    
    The "arch" in CFcommon.arch is taken from the "uname -m" command.
    
    [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
    [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
    [3] https://lore.kernel.org/all/ZnBkHosMDhsh4H8g@J2N7QTR9R3/
    
    Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
    
    Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
    Suggested-by: Paul E. McKenney <paulmck@kernel.org>
    Suggested-by: Mark Rutland <mark.rutland@arm.com>
    Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index b33cd87536899..ad79784e552d2 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -68,6 +68,8 @@ config_override_param "--gdb options" KcList "$TORTURE_KCONFIG_GDB_ARG"
 config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KASAN_ARG"
 config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
 config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
+config_override_param "$config_dir/CFcommon.$(uname -m)" KcList \
+		      "`cat $config_dir/CFcommon.$(uname -m) 2> /dev/null`"
 cp $T/KcList $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
index 0e92d85313aa7..217597e849052 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
@@ -1,7 +1,5 @@
 CONFIG_RCU_TORTURE_TEST=y
 CONFIG_PRINTK_TIME=y
-CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
-CONFIG_KVM_GUEST=y
 CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n
 CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
new file mode 100644
index 0000000000000..d8b2f555686fb
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
@@ -0,0 +1,2 @@
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_KVM_GUEST=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
new file mode 100644
index 0000000000000..133da04247ee0
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
@@ -0,0 +1 @@
+CONFIG_KVM_GUEST=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
new file mode 100644
index 0000000000000..d8b2f555686fb
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
@@ -0,0 +1,2 @@
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_KVM_GUEST=y

