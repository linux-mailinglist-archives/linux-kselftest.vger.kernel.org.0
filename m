Return-Path: <linux-kselftest+bounces-18993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C7098FB4B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 02:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28AF1F22D75
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 00:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631B41D0E16;
	Fri,  4 Oct 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6qQligl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C591D0DC4;
	Fri,  4 Oct 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000030; cv=none; b=m20+n5sn82iQXhC07FW4EUz49QtOZePeMy9Z/dl2wqB4wsuG5kGE5ezsOjxM+W0GZWj+gja24k6oGdVFNLDvNGOPGw/ckPIbp+NDizeskC/BYJeAanu1ulrziOSnDr6cECzqbxAjyxLa/sNEmZQudcYaPpWQUtXDlY06HJV7Nlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000030; c=relaxed/simple;
	bh=QVP3r+jCflr2FipbOflt+s2SWbRXnGOJWFiEdm0P3bU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IXwiVUfTLK0x70UEAGGvCtzHRw412+5m8pluGEeWJg8pJNLB8QnVXorAZA2iVUaB4Z9OpY1hS4Smm+flmD+vMxR2mBuTWQFjQmQzOz0LByH0STnXJaBKCM9ZJOPSJjQFSan8OJPAlsJFmb0S26UMVsfc2CABfE8cvyb9Ty0JZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6qQligl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE2AC4CED1;
	Fri,  4 Oct 2024 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728000029;
	bh=QVP3r+jCflr2FipbOflt+s2SWbRXnGOJWFiEdm0P3bU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d6qQliglVWOcwOI597XBUVxcyhT7w/D/OHfnsjIsTk7U1aBPFExTm5QWL0L+rxNn9
	 xFJle2xhSRt/knSO6ZgZuTyf4JngA1PXIv8s8g8wZ32fiqnXk7Q9LNwNdeDVyy71+S
	 Wjz6tSsOl2pmohfNZWq8csgVN3sA71QTkGrhFPB7bfhZ80Qh0QQElPh5olkJvBvx3I
	 91asklvXaQEj+pydhmYROVuwwQtHyGgM+yMs3Ak9fO5vCYFm1swASfzVYfxqECQKym
	 Q609O8Ym5mLn8aHwYXx3m/uVfrLPfnSXYfG3CUj5zIU16dlFjsmFegDorgvhP7TWzf
	 70liAPNEoypqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 719913803263;
	Fri,  4 Oct 2024 00:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: mlxsw: rtnetlink: Use devlink_reload()
 API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172800003328.2035955.3929073643835744782.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 00:00:33 +0000
References: <844509e3057b65277a7181a23c95b71ec95e8a56.1727706741.git.petrm@nvidia.com>
In-Reply-To: <844509e3057b65277a7181a23c95b71ec95e8a56.1727706741.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, amcohen@nvidia.com,
 idosch@nvidia.com, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Sep 2024 17:12:50 +0200 you wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> The test runs "devlink reload" explicitly. Instead, it is better to use
> devlink_reload() which waits for udev events to be processed. Do not sleep
> after reload, as devlink_reload() blocks until all the netdevs are renamed.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: mlxsw: rtnetlink: Use devlink_reload() API
    https://git.kernel.org/netdev/net-next/c/be4e32354457

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



