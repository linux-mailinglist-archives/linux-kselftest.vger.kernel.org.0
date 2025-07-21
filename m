Return-Path: <linux-kselftest+bounces-37790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D30D5B0CE69
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 01:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A586C17E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 23:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141BF24DD07;
	Mon, 21 Jul 2025 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeyoojCH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1D23B60A;
	Mon, 21 Jul 2025 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141802; cv=none; b=n+GPc05/8ueE35B/7vfUaWTs3kUi1UGk2Hg/7y1ZOm8tIwKv7VHi5SnwBqceOS1qBLTawHxZrEDR53UMdKbjnhGT633UT54ZOgRMsHmyNz3l+XDtwqgBV0QldCquiVdVVwRBIjpKHQ6OyMJZuqmQ5rDa/gG1FwrkoyPE6rNAIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141802; c=relaxed/simple;
	bh=YA2VfwYJMyeH5E0FExPUt/piBT6gPcxvkso26zEdPSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uenoPugAo8Y9Ugdo9cMxtT20QxKRpOd4csxHBJ97ki0WvxCge95HRNsZONH7FEwDZbsp9MQKJ7B5zBdKGSaV8SB0mNVzl8kiyocNPhScXoLaP2p5aKdMSU44tWe41qMx8kq+BML+2QV3OVyMcerhLv31kXhwyJyiNdV+2VkOEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeyoojCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D48EC4CEF4;
	Mon, 21 Jul 2025 23:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753141801;
	bh=YA2VfwYJMyeH5E0FExPUt/piBT6gPcxvkso26zEdPSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jeyoojCHWvioAkCi3/Y9sf4QXtCZAO14ACXfx4Iwml/+uI4PJFsx6AmfXta0AgbLR
	 91k4fjYglALjie5MRUH0/neXoV4Ti55ou5LKSEXpWVSNRHsfSuSfOoLJT2/adMDbmR
	 GiBkFDruiX0S1jhxaNznj5JD8XAePXDy6fHwmRjpjPWqk1bD9q4QbfbM/KF4jyExEq
	 oJ9u3SVngLEOWVrX0SFrBHcnStCk1leWWRv6GA0fOx/jvYU274tAFdqkW6QKBn3ebz
	 5tYR+KTZfwLAcbb99Gw919qojHNsz3E4yl6lGAGGIAYJSVzcgcOQ585k2RxnMKlbFS
	 JAei0VMgPNtIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B3D383B267;
	Mon, 21 Jul 2025 23:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: tc: Add generic erspan_opts matching
 support for tc-flower
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175314181975.233941.3731379709157721145.git-patchwork-notify@kernel.org>
Date: Mon, 21 Jul 2025 23:50:19 +0000
References: 
 <1f354a1afd60f29bbbf02bd60cb52ecfc0b6bd17.1752848172.git.shuali@redhat.com>
In-Reply-To: 
 <1f354a1afd60f29bbbf02bd60cb52ecfc0b6bd17.1752848172.git.shuali@redhat.com>
To: None <shuali@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org, lucien.xin@gmail.com,
 xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Jul 2025 22:16:12 +0800 you wrote:
> From: Li Shuang <shuali@redhat.com>
> 
> Add test cases to tc_flower.sh to validate generic matching on ERSPAN
> options. Both ERSPAN Type II and Type III are covered.
> 
> Also add check_tc_erspan_support() to verify whether tc supports
> erspan_opts.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: tc: Add generic erspan_opts matching support for tc-flower
    https://git.kernel.org/netdev/net-next/c/ff3fbcdd4724

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



