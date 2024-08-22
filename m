Return-Path: <linux-kselftest+bounces-16044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F384B95B361
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 13:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5E01C22EDF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC7C18453C;
	Thu, 22 Aug 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeiVOE6u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E47184534;
	Thu, 22 Aug 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324433; cv=none; b=X6hI6BO1GBfXDWPZAxdEiSX2Np3qi1OSf4sBDcdD6CCoLjjSWg24K15WKSmHVl1/1Xi6tYBWDtV/liXRkQ/D/775uwR/X4jH+0P/cwo/A0Ul8S0vCVm0AyZD5EiEcbuXLpI8z4kbvl8mhwKYsfU0nuzAgHx2Rr6cfKEB9fmPyl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324433; c=relaxed/simple;
	bh=tawUxnnfGvlZBXVHMTt9xU7aBxMLocLfro7ohLRskQA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZptfFSbUtGZFrKbuBR353wA49AHeqc/55gLkfUZJFQh3NBohgytfjQh+DT6h1+LWCuw/onnT6THvP/3RUWwp3hNUjDnyUEqsyhHA/m2QqPvkJgjm1tszjibWU88X3VXVf8AaWyF88YQj+Ed2tAAtQj53LDed/nRT5yR/7bi9Yes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeiVOE6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE1CC32782;
	Thu, 22 Aug 2024 11:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724324433;
	bh=tawUxnnfGvlZBXVHMTt9xU7aBxMLocLfro7ohLRskQA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OeiVOE6upeGE5hfbbEkx51IN8V/tdLXcKpwIKMkLxC4JsWpJ5VrZGF6I1sbCgIqAn
	 IUF8Dxfxn/waqS+lffDrg4vHUchAQGSjnWowIzbsdEfBBnLZdoQbBxy9rfnR2NfPwG
	 bsTYr8GOYwjYIXsx0NBmj8N4YzD7Bb+dWbHAvhTc5NComlT+u0S+SWoQot0rU16UXd
	 WnwoWuAQCbiqvU7P9C745RRTTDWCpiEqVRUQQX93OtbgxVkM+L4EAgAALuYtWa8T6k
	 KPipp7TxTheavRz1GzLKHevz7z47nZaKTzbR0K7E5YZpa6JUS5U9uhZ4zR3TZJakMt
	 6Rk3fjHu6MU3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB35D3809A80;
	Thu, 22 Aug 2024 11:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: net: add helper for checking if
 nettest is available
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172432443248.2287138.10064000046224257189.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 11:00:32 +0000
References: <20240821012227.1398769-1-kuba@kernel.org>
In-Reply-To: <20240821012227.1398769-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, idosch@idosch.org, liuhangbin@gmail.com,
 idosch@nvidia.com, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 Aug 2024 18:22:27 -0700 you wrote:
> A few tests check if nettest exists in the $PATH before adding
> $PWD to $PATH and re-checking. They don't discard stderr on
> the first check (and nettest is built as part of selftests,
> so it's pretty normal for it to not be available in system $PATH).
> This leads to output noise:
> 
>   which: no nettest in (/home/virtme/tools/fs/bin:/home/virtme/tools/fs/sbin:/home/virtme/tools/fs/usr/bin:/home/virtme/tools/fs/usr/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin)
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: net: add helper for checking if nettest is available
    https://git.kernel.org/netdev/net-next/c/bcc3773c49af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



