Return-Path: <linux-kselftest+bounces-19078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E5A9912E9
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 01:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E37C2828FD
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 23:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA02154BFB;
	Fri,  4 Oct 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om3FG4NA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D917B14EC71;
	Fri,  4 Oct 2024 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084035; cv=none; b=bzAzoJIjZtIL8LUSFlPgZ96talfG6oSKGNIPE+o28FXWHsWWzarYuE7tSCt3sZnDfRVoOa/wOKEZOXCwByJZfFd3jQqzpIH4X1NDVeH4V0458Kc9VkDJxgh4+r7QVVbKs3fOWUPqf0FN6tpA9wThAMUxdHbFZD7bSIPQlcE6IXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084035; c=relaxed/simple;
	bh=kkACx0BM3cqn1S9bMKRcoczAv/BLyjqb14slhs8Cf/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W8OEtYL9H4voMIriClPGfyCRIH7C5adoskrlrFNX8YuAODZ2XfTBwau+rSTxkUMmoBeS7nezHYvlcAAVwovHfh6PhLGfXIJ6CNVzSByOV2S4g3PhvjkoIb8Ltm4jMxOUK9lGnE1EX8AxL31YVyPRM75dzkHxaUFp4hExs3XCQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om3FG4NA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0B0C4CEC6;
	Fri,  4 Oct 2024 23:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084035;
	bh=kkACx0BM3cqn1S9bMKRcoczAv/BLyjqb14slhs8Cf/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=om3FG4NAm38c1bETXOnGvTnAxWPl1zIpcYkThneZm62wIN36uK3gPFEy1dLoHt4fS
	 5VyBawAjFOGe+NXlHCPzi+RAAKt7TXj6kgZT9r1ybczo2BqlK8WjwvJhGzEBl3fVbS
	 Q2MkBq9NotJhllnMywlDg9vujPRVBQn1jjrMrL0eCQFVCbDvu7k2WLKSqADq81Ef3o
	 Q2t73yHohJy9YIl/w4zXH40nFS3kf/CKP1HeLdOgMBXk0QmX/T6o/yRs3l41TuK6vV
	 R7BF/Xs1b9kHT8imQHsKeUIyN54Zl+FMSq8aOdmifhJFnmIYFsL086poJ2h4Kwa7Lc
	 FcaCfsN+blzRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DB639F76FF;
	Fri,  4 Oct 2024 23:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftest/ptp: update ptp selftest to exercise the
 gettimex options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172808403874.2772330.8746190595919420418.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 23:20:38 +0000
References: <20241003101506.769418-1-maheshb@google.com>
In-Reply-To: <20241003101506.769418-1-maheshb@google.com>
To: Mahesh Bandewar <maheshb@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mahesh@bandewar.net, shuah@kernel.org, richardcochran@gmail.com,
 davem@davemloft.net, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Oct 2024 03:15:06 -0700 you wrote:
> With the inclusion of commit c259acab839e ("ptp/ioctl: support
> MONOTONIC{,_RAW} timestamps for PTP_SYS_OFFSET_EXTENDED") clock_gettime()
> now allows retrieval of pre/post timestamps for CLOCK_MONOTONIC and
> CLOCK_MONOTONIC_RAW timebases along with the previously supported
> CLOCK_REALTIME.
> 
> This patch adds a command line option 'y' to the testptp program to
> choose one of the allowed timebases [realtime aka system, monotonic,
> and monotonic-raw).
> 
> [...]

Here is the summary with links:
  - [net-next] selftest/ptp: update ptp selftest to exercise the gettimex options
    https://git.kernel.org/netdev/net-next/c/3d07b691ee70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



