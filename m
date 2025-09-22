Return-Path: <linux-kselftest+bounces-42084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC0BB92B46
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 21:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8510D3A8E5D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 19:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D873164C5;
	Mon, 22 Sep 2025 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQkU0QSN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CAD19A288;
	Mon, 22 Sep 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758567627; cv=none; b=oX6So9gRZrNjMLw302fRdPZ7dxsbJB8vdFEeqf+WlGM3tiLNvstYRkQWhcJecT/ImzZUCo4XK1/732btNexCdBW+veIgYRdFGh2ssxpiM6DxBV5B3naWynGqfLyGJ9df/FfAuqWgi4/Pt7JcOIgds7msSoKw0Y7pqvI/AJ6SzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758567627; c=relaxed/simple;
	bh=8U5r7MWC4C6QDYlXsPEZHC2SwxespT/dx+lT/gIoY7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=euURpmzmeBIlXK3MxSWhALo1HGz6LBFmgrd/ikP5AjRLjZGbQ5LNd+5Su2JHyUl+J3etqAwcVuYirWqcnrwusBdIe6U6ommRQc+Zxndr119H85PEyRjGZEVf0qZFe98bdAAlTmxiaRr3zXhASFy7JuXoe0ETyZMTkfrmEoKKpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQkU0QSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA46C4CEF0;
	Mon, 22 Sep 2025 19:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758567626;
	bh=8U5r7MWC4C6QDYlXsPEZHC2SwxespT/dx+lT/gIoY7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aQkU0QSNuNyPQOddF8/8SKdXidWzfNKzXYBCKpX3NterDRsdrxxyakEzpejxN6LCm
	 suKZ1LxYsumb/LrjOc50uEmfzZbMq/Oyy4Odkb6ch14PlftgRqiXvmYxmdzOVJ3uzo
	 muIYH68lw8Tg3b2PvvvSzoV+RFYiOwU2GMa93RHShKjMXOy4jEsp+NGd9+kaRjthBU
	 iyrdMqzaZdKw5b+82zCaDb+cjozYE1ZKD6LaGqP4fjokSYDA4/mCaeQ93eYY62TB6q
	 aqYdfQHJIzLUBJhLEf9DSfmNaEtSVY/l3+V/ZsSECsKwAIKPtXsOhjyPKffcg8X3v/
	 qpwqNjxHU/73Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D9D39D0C20;
	Mon, 22 Sep 2025 19:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] mptcp: pm: netlink: announce server-side
 flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175856762426.1122110.4750649388400694679.git-patchwork-notify@kernel.org>
Date: Mon, 22 Sep 2025 19:00:24 +0000
References: 
 <20250919-net-next-mptcp-server-side-flag-v1-0-a97a5d561a8b@kernel.org>
In-Reply-To: 
 <20250919-net-next-mptcp-server-side-flag-v1-0-a97a5d561a8b@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, donald.hunter@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Sep 2025 14:08:57 +0200 you wrote:
> Now that the 'flags' attribute is used, it seems interesting to add one
> flag for 'server-side', a boolean value.
> 
> Here are a few patches related to the 'server-side' attribute:
> 
> - Patch 1: only announce this attribute on the server side.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] mptcp: pm: netlink: only add server-side attr when true
    https://git.kernel.org/netdev/net-next/c/c9809f03c158
  - [net-next,2/6] mptcp: pm: netlink: announce server-side flag
    https://git.kernel.org/netdev/net-next/c/3d7ae91107b8
  - [net-next,3/6] mptcp: pm: netlink: deprecate server-side attribute
    https://git.kernel.org/netdev/net-next/c/c8bc168f5f3d
  - [net-next,4/6] selftests: mptcp: pm: get server-side flag
    https://git.kernel.org/netdev/net-next/c/e6c35529452e
  - [net-next,5/6] mptcp: use _BITUL() instead of (1 << x)
    https://git.kernel.org/netdev/net-next/c/5c967ebb5519
  - [net-next,6/6] mptcp: remove unused returned value of check_data_fin
    https://git.kernel.org/netdev/net-next/c/1be5b82c4585

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



