Return-Path: <linux-kselftest+bounces-11730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D42790493A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 04:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936AEB20FCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 02:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0074BDF62;
	Wed, 12 Jun 2024 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7X9r7QQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B894A1B;
	Wed, 12 Jun 2024 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161051; cv=none; b=GIB+rUGTEHpiZ+/KD5SmLJHGyqnw5/ySpiRqfwHjLmNrviEqhmGi1SM0eWV9tSgJRel8SGzOdJZDPShnjOEZyQzbThOsQA4j99dhmEHDv4tnm0DuhtEB9/0UVQ5WtJ6JVsbfUo6CcZ2QRoIgs+ox1QNGxIoODxJka9UlW7/+tWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161051; c=relaxed/simple;
	bh=Lx1//KtDjXhN3gOtqkYpZDXLlUXymjn1NFe3pPMA3JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXZvNEkshQ3L/UBZRN0Gzf4kNVWhneg3dJewfgEw6m/hgpxFH94gdQ3pgiaDPZhQ0FY4Z+6vkiuJtMwTAJkvFFChHRiwYh3nUSBj1DqznV+UsLdbLz5jIAZN4kK49I7BmombnT7h1vHxpFjPmteQHvyh8pDtw6w47hI8j2PNpXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7X9r7QQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DCBC2BD10;
	Wed, 12 Jun 2024 02:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718161050;
	bh=Lx1//KtDjXhN3gOtqkYpZDXLlUXymjn1NFe3pPMA3JQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=b7X9r7QQPvMEpHtSYVEHEXtaF9ZCNUKgVw6Bvxx8q6uNxa6N0Giu0UPXGVWXNlcH+
	 Mr5QpelutejxQc9GY0lz8FFPHiBEqbzdDL5lbcs+mnhLPM34fVvJtiSH26y0Nb7Scp
	 3a7cTWe80szAn1LFrIuSc9EGgm+9kTBclYY3cIGnAZWir8iQTpg8UscGHS2E0n0apH
	 OYA7HHyS7Cb6L1W5nZPed6SHtFnF30fM1kEo2F1EJ5fZXE+yVMD79gBXgiwOQZsfM6
	 TJusoauNwVJi9mwkVQFJxs1hHxHA7Wqroc+i0s91vg1Mg/DjXdoUalRx0k4maDuiT3
	 neDpi6F5H8tCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 024F1CE250F; Tue, 11 Jun 2024 19:57:29 -0700 (PDT)
Date: Tue, 11 Jun 2024 19:57:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org, lance@osuosl.org,
	mark.rutland@arm.com
Subject: Re: [PATCH V3] rcutorture: Add CFcommon.arch for the various arch's
 need
Message-ID: <def32dd4-b205-45b8-a5ed-e6e28a0ac4f4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240612013527.1325751-1-zhouzhouyi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612013527.1325751-1-zhouzhouyi@gmail.com>

On Wed, Jun 12, 2024 at 01:35:27AM +0000, Zhouyi Zhou wrote:
> Add CFcommon.arch for the various arch's need for rcutorture.
> 
> According to [1] and [2], this patch
> Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options") by moving
> x86 specific kernel option CONFIG_HYPERVISOR_GUEST to CFcommon.arch
> 
> The patch has been revised and improved under
> Paul E. McKenney's guidance [3].
> 
> [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
> [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
> [3] https://lore.kernel.org/lkml/cd3709dc-2c08-4ac2-a19b-d8edb66195e3@paulmck-laptop/T/
> 
> Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Much better, thank you!

I queued and pushed for review and testing with the usual editing,
so please let me know if I messed anything up.

I added Mark on CC in case he has thoughts from an ARM perspective.

							Thanx, Paul

------------------------------------------------------------------------

commit 29cf4c63d04b9752a32e33d46a57717121353ef7
Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed Jun 12 01:35:27 2024 +0000

    rcutorture: Add CFcommon.arch for the various arch's need
    
    Add CFcommon.arch for the various arch's need for rcutorture.
    
    In accordance with [1] and [2], this patch moves x86 specific kernel
    option CONFIG_HYPERVISOR_GUEST to CFcommon.arch
    
    [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
    [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
    
    Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.
    
    Link: https://lore.kernel.org/lkml/cd3709dc-2c08-4ac2-a19b-d8edb66195e3@paulmck-laptop/T/
    
    Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
    Suggested-by: Paul E. McKenney <paulmck@kernel.org>
    Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
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
index 0e92d85313aa7..cf0387ae53584 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
@@ -1,6 +1,5 @@
 CONFIG_RCU_TORTURE_TEST=y
 CONFIG_PRINTK_TIME=y
-CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
 CONFIG_KVM_GUEST=y
 CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
new file mode 100644
index 0000000000000..2770560d56a0c
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
@@ -0,0 +1 @@
+CONFIG_HYPERVISOR_GUEST=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
new file mode 100644
index 0000000000000..2770560d56a0c
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
@@ -0,0 +1 @@
+CONFIG_HYPERVISOR_GUEST=y

