Return-Path: <linux-kselftest+bounces-5828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1557870257
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 14:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB241F21E79
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 13:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05593F8F7;
	Mon,  4 Mar 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCBUGb+6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB93F8E2;
	Mon,  4 Mar 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557829; cv=none; b=uI77y4Hq5txZXQL57mQNaU16xg9t0qEub7fEoMtJ57Te8Vz90jSZtbLIkhJk6Kx2fRwi9pbBNc6r6AXC516+8ahZIvmpCaZn0+Tb/dbmW0Kp+5kyDyLdUnDSiHyav0ilHyOnPjPRBsYXgHu1LseSXtvesMwNDBSDiPjRPp7BLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557829; c=relaxed/simple;
	bh=gho4GcW/2zNAdSd9bIZCOth4JZaD3rPWTtBSvYURc3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kw38r+tS5AuTVx1VicpozQgg20kbSjSUlK3aRcQ/FZfEAUWCwb+fKhO4FUz6OTEpKPdzp7uiK4Y18n9NdlJp+VyaOXqIkp87053Lj7HBXWVBhfKX8+1RXH7FgogQvlXKaNqmWXlb+zYi2BbWltuTq+w74xxZza9a1+QFNIEgPAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCBUGb+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BEB8C433C7;
	Mon,  4 Mar 2024 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709557829;
	bh=gho4GcW/2zNAdSd9bIZCOth4JZaD3rPWTtBSvYURc3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PCBUGb+6QouwuiMrNrOqddkwx/AIc+B/yy8fTBAEz3x/OW73xKA9jO1JZMx5tNGOz
	 yQ/MiRSvXBQJ9379vNOg1/nvSesOgX4yUVAiWemA8RUik+eB+TkjPqo5n77w1NJ236
	 k94B5U2G0b4u+pAQMDW5r2M5xskDPJX1uk6TTMA5g/UyPU6Dhb4NPf0b9pXIJSgqqe
	 n9rGXNNR7N0rmELpg+RJMN2HMcv302WC8nKCKj28A7r2kpy0UbJPc1S4CJwd3A//OE
	 YgRhVRSFc53HrmwyCaa6ZEV++ooaxlxZpPcTCimPTmnlPdhlcCIbgabCDkCSvkhQWn
	 XSVSKeV1PMCXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38831D9A4BB;
	Mon,  4 Mar 2024 13:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] mptcp: userspace pm: 'dump addrs' and 'get
 addr'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170955782922.9155.840057347233727619.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 13:10:29 +0000
References: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, tanggeliang@kylinos.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 01 Mar 2024 19:18:24 +0100 you wrote:
> This series from Geliang adds two new Netlink commands to the userspace
> PM:
> 
> - one to dump all addresses of a specific MPTCP connection:
>   - feature added in patches 3 to 5
>   - test added in patches 7, 8 and 10
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] mptcp: make pm_remove_addrs_and_subflows static
    https://git.kernel.org/netdev/net-next/c/e38b117d7f3b
  - [net-next,02/15] mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
    https://git.kernel.org/netdev/net-next/c/34ca91e15e69
  - [net-next,03/15] mptcp: implement mptcp_userspace_pm_dump_addr
    https://git.kernel.org/netdev/net-next/c/34e74a5cf3b7
  - [net-next,04/15] mptcp: add token for get-addr in yaml
    https://git.kernel.org/netdev/net-next/c/9e6c88e2f05b
  - [net-next,05/15] mptcp: dump addrs in userspace pm list
    https://git.kernel.org/netdev/net-next/c/9ae7846c4b6b
  - [net-next,06/15] mptcp: check userspace pm flags
    https://git.kernel.org/netdev/net-next/c/c19ee3c7e388
  - [net-next,07/15] selftests: mptcp: add userspace pm subflow flag
    https://git.kernel.org/netdev/net-next/c/9963b77e25c6
  - [net-next,08/15] selftests: mptcp: add token for dump_addr
    https://git.kernel.org/netdev/net-next/c/950c332125f6
  - [net-next,09/15] selftests: mptcp: add mptcp_lib_check_output helper
    https://git.kernel.org/netdev/net-next/c/2d0c1d27ea4e
  - [net-next,10/15] selftests: mptcp: dump userspace addrs list
    https://git.kernel.org/netdev/net-next/c/38f027fca1b7
  - [net-next,11/15] mptcp: add userspace_pm_lookup_addr_by_id helper
    https://git.kernel.org/netdev/net-next/c/06afe09091ee
  - [net-next,12/15] mptcp: implement mptcp_userspace_pm_get_addr
    https://git.kernel.org/netdev/net-next/c/d32c8fb1c881
  - [net-next,13/15] mptcp: get addr in userspace pm list
    https://git.kernel.org/netdev/net-next/c/564ae6794ec5
  - [net-next,14/15] selftests: mptcp: add token for get_addr
    https://git.kernel.org/netdev/net-next/c/b055671b3936
  - [net-next,15/15] selftests: mptcp: userspace pm get addr tests
    https://git.kernel.org/netdev/net-next/c/4cc5cc7ca052

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



