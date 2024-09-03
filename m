Return-Path: <linux-kselftest+bounces-17076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9B696AC35
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 00:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9342839A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 22:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B342818732B;
	Tue,  3 Sep 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVsMSwf2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3D1EC01F;
	Tue,  3 Sep 2024 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725402636; cv=none; b=u278AIZlpLkpRzzR63cFTYk7pHkqugFi4VbSUXMC7yLrl7saFCMSTAnLKLcl9R2RaGtDo3m3aNRzePqSt3sYWb+pXqepdkYWzFD4e7GfYDrfffyst9vHW4cXjfnXYOwERC0THrD/z7vldb+yx3KN56uEqnWUD7f1K2XnK04DfVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725402636; c=relaxed/simple;
	bh=0NXvwQ8nOPQQ9cWalY9pUVsAdxuWo/Cm+R8hAX7RG9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S+CNlNdTB5McAkQLgWv1vhSV43Z9pENWt7SzJNPCsDBM/ffzvmm4aDQeotfNuRFiPi32ycxa/xs7OZYGFUJQ6DK4ZoI5zWnhlk5zvqCao9P2PFxdaldut+I7h1piJQgNDFqspo2dABzf2Amx6MSf4zvHcE3r+F2TLOUME7JA1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVsMSwf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03E8C4CEC5;
	Tue,  3 Sep 2024 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725402635;
	bh=0NXvwQ8nOPQQ9cWalY9pUVsAdxuWo/Cm+R8hAX7RG9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GVsMSwf2zoKcqiwSThVdDpVadtc48cynOH8JvyCaNQ1SuCeK4XqiX3rU2I7OnFrV8
	 UGEJGEj8VrcnXvvRCPQ/ESb90UZ1F15V1aWt7xsYf670iXXFOzDnwOMx2ia3v+PM9m
	 U6eT+3yGMKLLyqS+DHLbe5lstjEqL1lKTKBmgSJ7UUSKDTOGztBHGdIT64H2l+wj6B
	 PgEzKXAzJtl+qYFmj0AOAkrg2ql7+yjySSMhrNzfJR98VoeZbe9raFtUXMs5OC8PEo
	 aRHiCI5iYFaeafPAcMcFjDCtiRrsXMRBGn9TW8pUbYB37qr/exEXes8Wm0b47Ta0mn
	 AshKvLuYlEb/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3733806651;
	Tue,  3 Sep 2024 22:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] mptcp: MIB counters for MPJ TX + misc
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172540263576.468499.15933223216339757413.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 22:30:35 +0000
References: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 02 Sep 2024 12:45:51 +0200 you wrote:
> Recently, a few issues have been discovered around the creation of
> additional subflows. Without these counters, it was difficult to point
> out the reason why some subflows were not created as expected.
> 
> In patch 3, all error paths from __mptcp_subflow_connect() are covered,
> except the one related to the 'fully established mode', because it can
> only happen with the userspace PM, which will propagate the error to the
> userspace in this case (ENOTCONN).
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] mptcp: pm: rename helpers linked to 'flush'
    https://git.kernel.org/netdev/net-next/c/7bcf4d8022f9
  - [net-next,02/11] mptcp: pm: reduce entries iterations on connect
    https://git.kernel.org/netdev/net-next/c/b83fbca1b4c9
  - [net-next,03/11] mptcp: MIB counters for sent MP_JOIN
    https://git.kernel.org/netdev/net-next/c/1bd1788b6cab
  - [net-next,04/11] selftests: mptcp: join: reduce join_nr params
    https://git.kernel.org/netdev/net-next/c/1b2965a8cd8d
  - [net-next,05/11] selftests: mptcp: join: one line for join check
    https://git.kernel.org/netdev/net-next/c/ba8a664004da
  - [net-next,06/11] selftests: mptcp: join: validate MPJ SYN TX MIB counters
    https://git.kernel.org/netdev/net-next/c/004125c251a6
  - [net-next,07/11] selftests: mptcp: join: more explicit check name
    https://git.kernel.org/netdev/net-next/c/6ed495345be8
  - [net-next,08/11] selftests: mptcp: join: specify host being checked
    https://git.kernel.org/netdev/net-next/c/8d328dbcf61b
  - [net-next,09/11] selftests: mptcp: join: mute errors when ran in the background
    https://git.kernel.org/netdev/net-next/c/08eecd7e7fe7
  - [net-next,10/11] selftests: mptcp: join: simplify checksum_tests
    https://git.kernel.org/netdev/net-next/c/0e2b4584d61a
  - [net-next,11/11] selftests: mptcp: pm_nl_ctl: remove re-definition
    https://git.kernel.org/netdev/net-next/c/38dc0708bcc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



