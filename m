Return-Path: <linux-kselftest+bounces-3909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3F7844DF9
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 01:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBEE7B28CED
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 00:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986753D69;
	Thu,  1 Feb 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhZfxw75"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659EE440E;
	Thu,  1 Feb 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748028; cv=none; b=bEZdcAwJjdrDGwlOwP6UujXxgimjnYL1cNQLzb8D+rKzaMnDnnaqozJNcVFnDQTCvZhzTJhM5CW8nzdbLz0A61IwtUAosfEbD0wN64pzK5fZf4UXRBIS54MmvGn8bhT6VTEtgKjICV2Ngu4gw8uQjWbxb3/8MWJbDDYxPQamnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748028; c=relaxed/simple;
	bh=nofY1lOSiF2B7ZWZ3/IYSLR+DA4zE1nAkRgohb9+Brw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bgCwgALwL5BT6L2FC530JmDnakMo7HUKa+pZsEZB39r/Mw6d4ZBsjA7dYItcMvliBsrPsgY5UDHJmoHEvOoo0ajSh0M2aby0ROseuxUOJAuE9dN6K4nWE35BX3Yt1/UZNcRTQ4sDrf+PCkUQ1fuWnYp8NESg6WZDIpeKnL5gzqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhZfxw75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9429C433C7;
	Thu,  1 Feb 2024 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706748027;
	bh=nofY1lOSiF2B7ZWZ3/IYSLR+DA4zE1nAkRgohb9+Brw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mhZfxw75tSs1ZVbnw94K+z2rizaUprQlzYl09MuJ7b2gL9HlqXbmhcEIchisC/ITI
	 Pstahxpb5Nw1NBt42KPNhU9W3mN5Pf/w9uEPzRJW152v91qyOz342E0waRtopx2Duf
	 erjq1zbCHI0GGa9hO7gqzHncP3u27wZIAIQOw7FdyWPX8eo/JAfiZVnqgUCN3rA2SV
	 1C6KvqfFuDbvxkBoUX8UpkfqFgAo+FIVJPhS7aZQD8GLJhZilIDh28hV4QyfPDFA8j
	 8rww7dJMdHuyxHUR1AeRJ2AZISazRHQvedenPHsiWExxBtyAYorav8Gw1XtxCp1l6t
	 rKCKq8WVi7HnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DFF6C4166F;
	Thu,  1 Feb 2024 00:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] selftests/net: A couple of typos fixes in
 key-management/rst tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170674802764.22140.10834403284022952373.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 00:40:27 +0000
References: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
In-Reply-To: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
To: Dmitry Safonov <dima@arista.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, 0x7f454c46@gmail.com,
 mnassiri@ciena.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jan 2024 03:51:51 +0000 you wrote:
> Changes in v2:
> - Dropped "selftests/net: Clean-up double assignment", going to send it
>   to net-next with other changes (Simon)
> - Added a patch to rectify RST selftests.
> - Link to v1: https://lore.kernel.org/r/20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com
> 
> Two typo fixes, noticed by Mohammad's review.
> And a fix for an issue that got uncovered.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] selftests/net: Argument value mismatch when calling verify_counters()
    https://git.kernel.org/netdev/net/c/d8f5df1fcea5
  - [v2,2/3] selftests/net: Rectify key counters checks
    https://git.kernel.org/netdev/net/c/384aa16d3776
  - [v2,3/3] selftests/net: Repair RST passive reset selftest
    https://git.kernel.org/netdev/net/c/6caf3adcc877

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



