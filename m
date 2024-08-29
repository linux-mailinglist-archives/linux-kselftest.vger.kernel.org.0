Return-Path: <linux-kselftest+bounces-16670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FD1963F54
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 11:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203601C22286
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BDE18CC07;
	Thu, 29 Aug 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1c4bfN9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD699158541;
	Thu, 29 Aug 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922045; cv=none; b=oP2OWuO5CbUTMRM7G77Npu+flg2Z4IikJIZzI3f6ckfkpSCaodK4cLurSOc1hgRWinjof8oUGxIttgaNuB9KSfT+gNKgR6sLIxO1le8Hqq7Eyyy6ThDkY1iQ9fYw+0Ompr7W8X/OuNaHLRCkwjJEBplfXs4zFEUuO5J0MeFwpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922045; c=relaxed/simple;
	bh=6FlULx1l5ZzbnHr7od9Cx8fS3FJKI2YOaUqcI6QMaZk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QKU2PtZu8vwIhTrtCxnBqcQwsbwu7rZR+FfEb+hwX+8Ag/xVqKhAEYdEe/631rccReGerOSGR6/mCu6s7ZTHnTgLHtYBQj0OGP2OqkFzWr/ZBmP8XsinZFlMdw1MqQhPfEx17Lul0WM8l3UY9hME/ESRFfQqkfut3jSPdGdLjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1c4bfN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347D0C4CEC3;
	Thu, 29 Aug 2024 09:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724922045;
	bh=6FlULx1l5ZzbnHr7od9Cx8fS3FJKI2YOaUqcI6QMaZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z1c4bfN9u42xl5To8HSB36ylnLJeSgoSk2Snuc/Iw93J6HrGQNp9LHfERvscNDf5q
	 ZWCDek7aoeLnRrxX2rf/1l1rEL8A0+nsBpDfJrsrVj2qSDaTabEhMTBYq8cmur9S7X
	 2Zj6wkakEOd3tQ5WOnmgHYT+hGBxkgEL1uhB5qMjgn3CyAHeOPtlb6aGVFH/Zc6VLp
	 dWDIusAb2rXlI/WhuVpWInJFVLyWjOrj1T4T5dHQVM8jD5ZHGB2/1EYhA0Uv7cSTNP
	 T8e7RRi0O0Wscgh/IWfw5wTSAVtkCi74skAvtRGQ0jtXhJTOwzq07smhtvBRgw1tT2
	 qER1yxcalTDrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3A03809A80;
	Thu, 29 Aug 2024 09:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 00/15] mptcp: more fixes for the in-kernel PM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172492204527.1873855.649951306821371963.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 09:00:45 +0000
References: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
In-Reply-To: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, arinc.unal@arinc9.com,
 syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 28 Aug 2024 08:14:23 +0200 you wrote:
> Here is a new batch of fixes for the MPTCP in-kernel path-manager:
> 
> Patch 1 ensures the address ID is set to 0 when the path-manager sends
> an ADD_ADDR for the address of the initial subflow. The same fix is
> applied when a new subflow is created re-using this special address. A
> fix for v6.0.
> 
> [...]

Here is the summary with links:
  - [net,v2,01/15] mptcp: pm: reuse ID 0 after delete and re-add
    https://git.kernel.org/netdev/net/c/8b8ed1b429f8
  - [net,v2,02/15] mptcp: pm: fix RM_ADDR ID for the initial subflow
    https://git.kernel.org/netdev/net/c/87b5896f3f78
  - [net,v2,03/15] selftests: mptcp: join: check removing ID 0 endpoint
    https://git.kernel.org/netdev/net/c/5f94b08c0012
  - [net,v2,04/15] mptcp: pm: send ACK on an active subflow
    https://git.kernel.org/netdev/net/c/c07cc3ed895f
  - [net,v2,05/15] mptcp: pm: skip connecting to already established sf
    https://git.kernel.org/netdev/net/c/bc19ff57637f
  - [net,v2,06/15] mptcp: pm: reset MPC endp ID when re-added
    https://git.kernel.org/netdev/net/c/dce1c6d1e925
  - [net,v2,07/15] selftests: mptcp: join: check re-adding init endp with != id
    https://git.kernel.org/netdev/net/c/1c2326fcae4f
  - [net,v2,08/15] selftests: mptcp: join: no extra msg if no counter
    https://git.kernel.org/netdev/net/c/76a2d8394cc1
  - [net,v2,09/15] mptcp: pm: do not remove already closed subflows
    https://git.kernel.org/netdev/net/c/58e1b66b4e4b
  - [net,v2,10/15] mptcp: pm: fix ID 0 endp usage after multiple re-creations
    https://git.kernel.org/netdev/net/c/9366922adc6a
  - [net,v2,11/15] selftests: mptcp: join: check re-re-adding ID 0 endp
    https://git.kernel.org/netdev/net/c/d397d7246c11
  - [net,v2,12/15] mptcp: avoid duplicated SUB_CLOSED events
    https://git.kernel.org/netdev/net/c/d82809b6c5f2
  - [net,v2,13/15] selftests: mptcp: join: validate event numbers
    https://git.kernel.org/netdev/net/c/20ccc7c5f7a3
  - [net,v2,14/15] mptcp: pm: ADD_ADDR 0 is not a new address
    https://git.kernel.org/netdev/net/c/57f86203b41c
  - [net,v2,15/15] selftests: mptcp: join: check re-re-adding ID 0 signal
    https://git.kernel.org/netdev/net/c/f18fa2abf810

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



