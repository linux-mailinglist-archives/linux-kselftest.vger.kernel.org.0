Return-Path: <linux-kselftest+bounces-7387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22DF89BDA7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 13:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D8D1C21664
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2196364CF7;
	Mon,  8 Apr 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+cRvinj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720D6025E;
	Mon,  8 Apr 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574035; cv=none; b=rCRWhh/XrcNT4n03oq9TbY0ALlg4y8Afo/rVUxF6IfhBNPMvMa0SwPhlT3kt1wR4fS8kKdR1fpKUnsrI+HkR9VSdlJTJX6SpS1d2Waag0P314atT480KNyJZJv8aq0bqFSBUGJtkG3+tPeL6qmm8oqSJU9aCFRLy8WZfA6Ne4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574035; c=relaxed/simple;
	bh=vM6/mtyUgy39CBRZ+BRnJgNNz4EcuCM7ZMACQHQCzns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NtU9HVHvvkRkKp5nXN3a9QI2cILk1cdBXd3v0Ibi2xMVGJ37S77k6iQGXW7YWc1Tz0kKmhuYDJTiGliyy9ENB/F0BY+qw8Zgmm3etpT3+cQVxbdGVUJt59JeutFMIz64QwM6J+noaFhdQgXkq94ylgYc+ndOC3vCaHu0LZrqiG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+cRvinj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE867C433C7;
	Mon,  8 Apr 2024 11:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712574034;
	bh=vM6/mtyUgy39CBRZ+BRnJgNNz4EcuCM7ZMACQHQCzns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d+cRvinj3pOqjZnzVUzOb3bDqij5jIROFcBjm8JO9KcdNzmYfo6gx7nbA3rpQbU/0
	 xaNshs9elUFMKP6PK00w7sZableMXdRtkcp23z4Bn/Gt1mPlUEXUJZNJEeWSghi2k1
	 RcZMsY9gv2+2XRPxYio27UX4nE762K5DS8L4SG8pQm8SaLtzLgmXWub7A+U1Wygyr9
	 bc4MfP600rG2InBKjA6DWzBq3U6CJU6ezvtgdwwU/lrCuBuC2rUsPkkbcHIkgJhjnr
	 78cWw2ftB5b0zCCOC3r/n6pEU8Gz/bWcYsVAaWSXudKXIY/W73/4hbb3IE+tY5VaYh
	 EhVYVxyuwTxFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A15C6C54BD4;
	Mon,  8 Apr 2024 11:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] selftests: mptcp: cleanups and 'ip mptcp'
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257403465.26748.462026930608140771.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 11:00:34 +0000
References: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
In-Reply-To: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, tanggeliang@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 05 Apr 2024 12:52:04 +0200 you wrote:
> Here are some patches from Geliang, doing different cleanups, and
> supporting 'ip mptcp' in more MPTCP selftests.
> 
> Patch 1 checks that TC is available in selftests requiring it.
> 
> Patch 2 adds 'ms' units in TC commands, to avoid confusions.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] selftests: mptcp: add tc check for check_tools
    https://git.kernel.org/netdev/net-next/c/f30b04cacd85
  - [net-next,02/11] selftests: mptcp: add ms units for tc-netem delay
    https://git.kernel.org/netdev/net-next/c/9109853a388b
  - [net-next,03/11] selftests: mptcp: export ip_mptcp to mptcp_lib
    https://git.kernel.org/netdev/net-next/c/29aa32fee7d0
  - [net-next,04/11] selftests: mptcp: netlink: add 'limits' helpers
    https://git.kernel.org/netdev/net-next/c/3188309c8ceb
  - [net-next,05/11] selftests: mptcp: add {get,format}_endpoint(s) helpers
    https://git.kernel.org/netdev/net-next/c/0d16ed0c2e74
  - [net-next,06/11] selftests: mptcp: netlink: add change_address helper
    https://git.kernel.org/netdev/net-next/c/b79e51c99949
  - [net-next,07/11] selftests: mptcp: join: update endpoint ops
    https://git.kernel.org/netdev/net-next/c/571d79664a4a
  - [net-next,08/11] selftests: mptcp: export pm_nl endpoint ops
    https://git.kernel.org/netdev/net-next/c/441c6be9ae28
  - [net-next,09/11] selftests: mptcp: use pm_nl endpoint ops
    https://git.kernel.org/netdev/net-next/c/c99d57d0007a
  - [net-next,10/11] selftests: mptcp: ip_mptcp option for more scripts
    https://git.kernel.org/netdev/net-next/c/0cef6fcac24d
  - [net-next,11/11] selftests: mptcp: netlink: drop disable=SC2086
    https://git.kernel.org/netdev/net-next/c/6eaeda12dc77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



