Return-Path: <linux-kselftest+bounces-42516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E49BA57C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 03:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E996274FF
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 01:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EE41E7C12;
	Sat, 27 Sep 2025 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbbPdH4D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200B917B505;
	Sat, 27 Sep 2025 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758936048; cv=none; b=pj6cv19K+XtGZX2BymfIJtWxOHM9hjmMoxHPwBCCSWkZVYHwf/jqTgNx9c43dHTrjBfKS3+S341ffqInNZpkGYt4VWEqywTcZG27a3SDlePwB3DCnTqvCOvZKfUyVWt5kDZwYh07ryPsY2NphaCVe5SUEnjW70UBOXmTNGGPL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758936048; c=relaxed/simple;
	bh=zvPqdywQUeZqytC5OkpE4A2wdCuvkoGS34zQUGAxsTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YC14VNm+XooVH6bLXQFbQi2tjE7qlB9sT+MYisp335HUxC+4Z3Lgt3V4QJbX3mID4iKlWuYvJkepuVkiqu+i3MYJt778pukc3sI+7QWsKIsrJI8z2hPpbCri+ENaCSqo4wmUNPx1MdzOn7tNWtRdzoBDagn8HVXUBhpQgY/0NIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbbPdH4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD85C4CEF4;
	Sat, 27 Sep 2025 01:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758936047;
	bh=zvPqdywQUeZqytC5OkpE4A2wdCuvkoGS34zQUGAxsTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pbbPdH4D24aZNH8kG9S5zUUbTWaZgh7PfBLwtuVT2A+p/+oUkCev4k91jDf2YKW7s
	 GBgczyZYh//6a6YKPdlyd6xFuIUBGHjP+DR3lWLU/tl7Pq8vPqepsrDcUOoHgtcEc2
	 SMavXS9M78/VY8T2sbzYhPUp1DXxWdvlFjO6eNQg6MFaVpbiXSaaWItUV5Xpa/AZRN
	 D2LMJ+UzWSk2IYAbzK7L3p1iznM2gwXDvtXrA9lSHMhs8GN4oqFtuvd31hVdM3omVM
	 p/jehEqrBV3NOKfQdceg9P4c5w27jmSHU71efVv6BE5mzUujw4q037+1s3WahtfsL8
	 hS4+sLtu+Cb/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEAA39D0C3F;
	Sat, 27 Sep 2025 01:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] mptcp: pm: special case for c-flag +
 luminar endp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175893604275.115459.12300335939141121043.git-patchwork-notify@kernel.org>
Date: Sat, 27 Sep 2025 01:20:42 +0000
References: 
 <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
In-Reply-To: 
 <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 12:32:35 +0200 you wrote:
> Here are some patches for the MPTCP PM, including some refactoring that
> I thought it would be best to send at the end of a cycle to avoid
> conflicts between net and net-next that could last a few weeks.
> 
> The most interesting changes are in the first and last patch, the rest
> are patches refactoring the code & tests to validate the modifications.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] mptcp: pm: in-kernel: usable client side with C-flag
    https://git.kernel.org/netdev/net-next/c/4b1ff850e0c1
  - [net-next,02/15] selftests: mptcp: join: validate C-flag + def limit
    https://git.kernel.org/netdev/net-next/c/008385efd05e
  - [net-next,03/15] mptcp: pm: in-kernel: refactor fill_local_addresses_vec
    https://git.kernel.org/netdev/net-next/c/8dc63ade451d
  - [net-next,04/15] mptcp: pm: in-kernel: refactor fill_remote_addresses_vec
    https://git.kernel.org/netdev/net-next/c/a845b2bbf26e
  - [net-next,05/15] mptcp: pm: rename 'subflows' to 'extra_subflows'
    https://git.kernel.org/netdev/net-next/c/c5273f6ca166
  - [net-next,06/15] mptcp: pm: in-kernel: rename 'subflows_max' to 'limit_extra_subflows'
    https://git.kernel.org/netdev/net-next/c/3eb3c9a9596a
  - [net-next,07/15] mptcp: pm: in-kernel: rename 'add_addr_signal_max' to 'endp_signal_max'
    https://git.kernel.org/netdev/net-next/c/45cae570664d
  - [net-next,08/15] mptcp: pm: in-kernel: rename 'add_addr_accept_max' to 'limit_add_addr_accepted'
    https://git.kernel.org/netdev/net-next/c/37712d84dfc2
  - [net-next,09/15] mptcp: pm: in-kernel: rename 'local_addr_max' to 'endp_subflow_max'
    https://git.kernel.org/netdev/net-next/c/e7757b6d3a62
  - [net-next,10/15] mptcp: pm: in-kernel: rename 'local_addr_list' to 'endp_list'
    https://git.kernel.org/netdev/net-next/c/35e71e43a56d
  - [net-next,11/15] mptcp: pm: in-kernel: rename 'addrs' to 'endpoints'
    https://git.kernel.org/netdev/net-next/c/e9aa044f4a1f
  - [net-next,12/15] mptcp: pm: in-kernel: remove stale_loss_cnt
    https://git.kernel.org/netdev/net-next/c/db9a0e3858ba
  - [net-next,13/15] mptcp: pm: in-kernel: reduce pernet struct size
    https://git.kernel.org/netdev/net-next/c/4984fe6254f8
  - [net-next,14/15] mptcp: pm: in-kernel: compare IDs instead of addresses
    https://git.kernel.org/netdev/net-next/c/f596293314b2
  - [net-next,15/15] mptcp: pm: in-kernel: add laminar endpoints
    https://git.kernel.org/netdev/net-next/c/539f6b9de39e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



