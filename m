Return-Path: <linux-kselftest+bounces-44030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BE1C0884B
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 03:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47F4F4E6523
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 01:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7079B2222B6;
	Sat, 25 Oct 2025 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnGbJHdf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41668BA3D;
	Sat, 25 Oct 2025 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761357026; cv=none; b=uSHAy5pQnmpKvirtPysQGH7n3AI6k2KEKpd4VcPTBFt1gKyuzMV6le0hdgkibvm7O9YvXETdFAC9pUi4p4RH4NFekGWF3P72UPDs6Qm+5WNNJugRjU6TJjEyh8cHkNTqTR1+KLGAl/0peI8wrn68A551wwyMp79Faqa6Emv+S8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761357026; c=relaxed/simple;
	bh=vDo5LA9CkF6xpV/wyURtOk0XWAkO9GGATe6x82X0Mlc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XLR2k2btPl+rtqawzG/hZ7nKitaQqqTGAYi5ZRvLk3oBPvVUPXVxeFZLuajIa00ta+ZMiI/QYrhZb3Gz4H23mYcKFbWjsHlhfodACWbGwAcL4Rdn3osCOKUH77oFYH/Qqi8N+acVx0juldkPLPSz3YX7jtHn89UdviNcvQPsGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnGbJHdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13986C4CEF1;
	Sat, 25 Oct 2025 01:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761357026;
	bh=vDo5LA9CkF6xpV/wyURtOk0XWAkO9GGATe6x82X0Mlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MnGbJHdfUtLaedZ3+Nc6JJSUKEwEao12phSRxfk2Y0WbT4c95+RhO8GgUxp3eH1EA
	 u41blMyuGMRdObbagkKajkO3RZP8IXUgCe4nyhqBeUGONMMxXHTikK11hKILP9NIRH
	 gHlfgvAb9k4YSHLtiuhOnCwZa7TisSSdFEcU/BVs/2muNsyHeUeNR9RhKLY00M9nOV
	 It9yA/pNeAbepeIjEQQocT+wMpHyOoE89+NP0mIycaWHcsJRHUN5+NoxPj0G3jJe9g
	 uf+OdC50LVB3hmv1WtdgsJKDpvJPgJLH5cKMSfFi7dTemtC92CGhxRh0BCmPgVyeIz
	 chXvTfgOg7KCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB062380AA59;
	Sat, 25 Oct 2025 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftest: net: prevent use of uninitialized variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176135700577.4120655.10364267359762972985.git-patchwork-notify@kernel.org>
Date: Sat, 25 Oct 2025 01:50:05 +0000
References: <20251023205354.28249-1-alessandro.zanni87@gmail.com>
In-Reply-To: <20251023205354.28249-1-alessandro.zanni87@gmail.com>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 22:53:52 +0200 you wrote:
> Fix to avoid the usage of the `ret` variable uninitialized in the
> following macro expansions.
> 
> It solves the following warning:
> 
> In file included from netlink-dumps.c:21:
> netlink-dumps.c: In function ‘dump_extack’:
> ../kselftest_harness.h:788:35: warning: ‘ret’ may be used uninitialized [-Wmaybe-uninitialized]
>   788 |                         intmax_t  __exp_print = (intmax_t)__exp; \
>       |                                   ^~~~~~~~~~~
> ../kselftest_harness.h:631:9: note: in expansion of macro ‘__EXPECT’
>   631 |         __EXPECT(expected, #expected, seen, #seen, ==, 0)
>       |         ^~~~~~~~
> netlink-dumps.c:169:9: note: in expansion of macro ‘EXPECT_EQ’
>   169 |         EXPECT_EQ(ret, FOUND_EXTACK);
>       |         ^~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [v2] selftest: net: prevent use of uninitialized variable
    https://git.kernel.org/netdev/net-next/c/13cb6ac5b506

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



