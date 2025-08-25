Return-Path: <linux-kselftest+bounces-39889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4386CB34DD8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 23:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15A22429DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 21:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47FF288C26;
	Mon, 25 Aug 2025 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpnui3i6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42E2882AA;
	Mon, 25 Aug 2025 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156974; cv=none; b=a3dly9dtQLyZEII1TyK9San9Wk+srjcFMMvvBLBFoRrmtu7onL7eCahfCK9XziVR7FygoKTS1Nb9FJM9VZkNj4UbIs+kUSh4Zwp29JS1bx0EnBbetevKKLdmMXFD19LCasbi9E3XK50xtq6XE6VqCJLIb2sr1ck5puTt0MPvROc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156974; c=relaxed/simple;
	bh=Cy47lc26STJx5l+f9M8q4OZm6Kg3jg1998oIbime1wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu3j5alLyhVgi+PJ3B5IjuU5yarFFVDPzjOb/e/6Ys+fjVerZgT4uCmh2oRp86j1IStwsNGbytlyNapt8YmI3jUakgInlbJVZoYlQIF8eD+Zu+OvP+r/SJz3SEjH57uDqlBUgra2wp9Av0eOpU90mp+TP03Gt8o9M7s1/tei9R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpnui3i6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE42C113D0;
	Mon, 25 Aug 2025 21:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756156974;
	bh=Cy47lc26STJx5l+f9M8q4OZm6Kg3jg1998oIbime1wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpnui3i6ORPp1aarx710P3I2B7R7T80KZucw9Fu1dWEYwdTUay++8eCtXnq1CHIJX
	 jKnj47O4I7IMVPMUz8LIBFyctpaJG79TB8fJtk0cwBKMZmwjYGyOH61d28o4X/yeZW
	 75iYI6sFysSobZfFenAtxJKQkP1jY2OI86rqu/Vx5vZfDI/H1XosYd0mpi01tNH2k/
	 d/EX2UTFL5r4K9ypRfAiiAAE6y0N576mtEIn6cQUAsyHSgKYWuzUsd3zcABnJI2vcS
	 URfZrX/tL1h61c4GHpm9vJ8w1e2DHGiyEllcRzC25gpUC3aVog4W77wyFfc/f+BMuu
	 zwwiX4sE4KGzg==
Date: Mon, 25 Aug 2025 14:22:53 -0700
From: Kees Cook <kees@kernel.org>
To: Ayash-Bera <ayashbera@gmail.com>
Cc: shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: improve clarity of test messages and
 comments
Message-ID: <202508251422.2312EDDAAA@keescook>
References: <20250817064252.40996-1-ayashbera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817064252.40996-1-ayashbera@gmail.com>

On Sun, Aug 17, 2025 at 12:12:52PM +0530, Ayash-Bera wrote:
> Replace ambiguous language in comments and test descriptions to improve
> code readability and make test intentions clearer.

Thanks; these are good clarifications. Can you please use checkpatch.pl
and then wrap the long commit string?

-Kees

> 
> Changes made:
> - Make TODO comment more specific about 64-bit vs 32-bit argument
>   handling test requirements  
> - Clarify comment about task termination during syscall execution
> - Replace vague "bad recv()" with specific "invalid recv() with NULL parameter"
> - Replace informal "bad flags" with "invalid flags" for consistency
> 
> These improvements help maintainers and contributors better understand
> the expected test behavior.
> 
> Signed-off-by: Ayash Bera <ayashbera@gmail.com>
> 
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 61acbd45ffaa..bded07f86a54 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -933,7 +933,7 @@ TEST(KILL_unknown)
>  	ASSERT_EQ(SIGSYS, WTERMSIG(status));
>  }
>  
> -/* TODO(wad) add 64-bit versus 32-bit arg tests. */
> +/* TODO(wad) add tests for 64-bit versus 32-bit argument handling differences. */
>  TEST(arg_out_of_range)
>  {
>  	struct sock_filter filter[] = {
> @@ -3514,7 +3514,7 @@ TEST(user_notification_kill_in_middle)
>  	ASSERT_GE(listener, 0);
>  
>  	/*
> -	 * Check that nothing bad happens when we kill the task in the middle
> +	 * Check that killing the task in the middle of a syscall does not cause crashes or hangs when we kill the task in the middle
>  	 * of a syscall.
>  	 */
>  	pid = fork();
> @@ -3798,7 +3798,7 @@ TEST(user_notification_fault_recv)
>  	if (pid == 0)
>  		exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
>  
> -	/* Do a bad recv() */
> +	/* Test invalid recv() with NULL parameter */
>  	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, NULL), -1);
>  	EXPECT_EQ(errno, EFAULT);
>  
> @@ -4169,13 +4169,13 @@ TEST(user_notification_addfd)
>  	addfd.id = req.id;
>  	addfd.flags = 0x0;
>  
> -	/* Verify bad newfd_flags cannot be set */
> +	/* Verify invalid newfd_flags cannot be set */
>  	addfd.newfd_flags = ~O_CLOEXEC;
>  	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
>  	EXPECT_EQ(errno, EINVAL);
>  	addfd.newfd_flags = O_CLOEXEC;
>  
> -	/* Verify bad flags cannot be set */
> +	/* Verify invalid flags cannot be set */
>  	addfd.flags = 0xff;
>  	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
>  	EXPECT_EQ(errno, EINVAL);
> -- 
> 2.50.1
> 

-- 
Kees Cook

