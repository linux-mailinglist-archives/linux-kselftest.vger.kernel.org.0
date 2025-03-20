Return-Path: <linux-kselftest+bounces-29484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE9FA6A2A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 10:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CB21889F83
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3061F2222B4;
	Thu, 20 Mar 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9O+5vm/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BDD1C1F2F;
	Thu, 20 Mar 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463000; cv=none; b=e34YEo4z62jB3eE/wsi7ZEqky2jAK6/NAzXSN0caa0WrH4qxoR0eC86LqnAm4Y6c6Rt012XLmlyYRZOS+DjZzboB3YbDM0tNiQ5p53p3vRA/ZUtogNCFJJyHGjUDBtrdNOHj9oliLhK8/elK84I/Z9i0khwbgiTelGjnH6P0X0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463000; c=relaxed/simple;
	bh=dw5ASQC8hlhdIlEBxhQ13OH2Na6Ploy5abBdY4RpC7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eSL40Iao3xFrckvNEIyLa4i+10pLZLpbKKxaskIfmgOH9hcbECGv7UrbaDdeyngQPETRAhLRQxK5nniH1NIPXGCifkNFq6W7byQZuvKKoCTwZNPbwwfoexnvB/Q0C1okUF3qtSJpTQYpiJ7qUqjiVU78mXfnoUoYeO5iJOPWcJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9O+5vm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66309C4CEDD;
	Thu, 20 Mar 2025 09:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742462999;
	bh=dw5ASQC8hlhdIlEBxhQ13OH2Na6Ploy5abBdY4RpC7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C9O+5vm/fgxVcGbIa0CSvUZTqO1EN332MFqVP5ms+f5GW2KqPTGsFSpnSbpN4a+ws
	 L5o7bPrdNG6oz+/sn7+qysMoUgojy1ZCMKSPLuY6rCGwGmnLOiyuVgBHPoR7SKLTcm
	 EY3dvujW32ceYa4uw8JBJfp/iRtx7MwwadMEQhaviy8GFMfimMkCUIN7C/wcklG0LX
	 hREaHmkt92sIcuiAILo0Z6Pi3Ao8JQsicWY5CGtwrEfbbglPG0pUjECAUljOpON+AF
	 3QzuDri5cr+3pk/OvRk5C2CYi9ENwiJIuLNZathWMcBaiRCVbg49N+P51rhlJsunUD
	 7B6clqADSgbuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71FC93806654;
	Thu, 20 Mar 2025 09:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] mptcp: pm: prep work for new ops and sysctl
 knobs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174246303526.1366947.13566116463963705037.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 09:30:35 +0000
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Mar 2025 11:20:49 +0100 you wrote:
> Here are a few cleanups, preparation work for the new PM ops, and sysctl
> knobs.
> 
> - Patch 1: reorg: move generic NL code used by all PMs to pm_netlink.c.
> 
> - Patch 2: use kmemdup() instead of kmalloc + copy.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] mptcp: pm: split netlink and in-kernel init
    https://git.kernel.org/netdev/net-next/c/b97d6b682027
  - [net-next,02/12] mptcp: pm: in-kernel: use kmemdup helper
    https://git.kernel.org/netdev/net-next/c/fa123489e7ef
  - [net-next,03/12] mptcp: pm: use pm variable instead of msk->pm
    https://git.kernel.org/netdev/net-next/c/5fff36b69cd4
  - [net-next,04/12] mptcp: pm: only fill id_avail_bitmap for in-kernel pm
    https://git.kernel.org/netdev/net-next/c/98a0a99e81b6
  - [net-next,05/12] mptcp: pm: add struct_group in mptcp_pm_data
    https://git.kernel.org/netdev/net-next/c/eff5b1578e99
  - [net-next,06/12] mptcp: pm: define struct mptcp_pm_ops
    https://git.kernel.org/netdev/net-next/c/1305b0c22eca
  - [net-next,07/12] mptcp: pm: register in-kernel and userspace PM
    https://git.kernel.org/netdev/net-next/c/770170b41810
  - [net-next,08/12] mptcp: sysctl: set path manager by name
    https://git.kernel.org/netdev/net-next/c/595c26d122d1
  - [net-next,09/12] mptcp: sysctl: map path_manager to pm_type
    https://git.kernel.org/netdev/net-next/c/573b653401a8
  - [net-next,10/12] mptcp: sysctl: map pm_type to path_manager
    https://git.kernel.org/netdev/net-next/c/7982ed0edda3
  - [net-next,11/12] mptcp: sysctl: add available_path_managers
    https://git.kernel.org/netdev/net-next/c/fa3ee9dd8067
  - [net-next,12/12] selftests: mptcp: add pm sysctl mapping tests
    https://git.kernel.org/netdev/net-next/c/9cf0128e64ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



