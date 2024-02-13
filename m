Return-Path: <linux-kselftest+bounces-4572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7230D8539C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 19:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07408B21400
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB63605BF;
	Tue, 13 Feb 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLY/AV9I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2B5FBB3;
	Tue, 13 Feb 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848428; cv=none; b=GOclrq52o41HCRKP025womeYB0axNFdm2nHH5nF5n+yFmqE7hJ+9xO9OtsMNdcufsi0wDFp49drEbk6eeA+iaUD/3NvOwa7pDwqdNH8wYr8R+jc6IhEO2mApwSjhzOa62gFzAoH8xHvfZg1nQSq1NLkRcG56zF+Il9g+2NE9EAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848428; c=relaxed/simple;
	bh=mePoQ3pSobk0RitQM7iyZCk3GHE+CYs0EY5WhOPY/Ww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NdpTUTtv4UxwFnYo2xl6UGB98HPvhiYuu4swL+2ov+7SHpzbOaRw4gdT1tCv06I1/BJLJyHB4hdo5U5gf/yXFMjxxFLE3BLT3RSmjHl401tl7am3a5bUnah1GtRJQG2JHOFA+yLajK+TTPLU7McTEaSPdQUeYcqXx0wKoXsDVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLY/AV9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29444C43399;
	Tue, 13 Feb 2024 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707848428;
	bh=mePoQ3pSobk0RitQM7iyZCk3GHE+CYs0EY5WhOPY/Ww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BLY/AV9IMjZHzp0tlPm3pTUgP8tpz1WkNR4YKznekY2IO2WQRJdHAq4kMCN2rZmfD
	 3M6+z9Q+z+dELRL0y0ic/bldX4nxIFqScbUAQwmWsE+Ijy+B5zScfrwStawbLpKqkC
	 eNX4sVTqO1qMxc/l+UFircp2Xm7LZSLGyhrTQM3k0M4Za6ivf2LFVjmoTlIdm+OTNo
	 mhMwvmB1pmsTl/XTz4qYPZOAFa5nhkVhe4dT04/DiW/NDePUGStyDvQ5mL7aj3yjdF
	 NLQ8wcqYV5BqwE9D6zUcIsCRQYaoTiOCVxKpyODxDHvgB7zOh1t6J1a0r7ctcf0bqw
	 qruUvRRhemeMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DE83D84BCD;
	Tue, 13 Feb 2024 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: cope with slow env in so_txtime.sh test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170784842805.32476.7805933357774588785.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 18:20:28 +0000
References: <2142d9ed4b5c5aa07dd1b455779625d91b175373.1707730902.git.pabeni@redhat.com>
In-Reply-To: <2142d9ed4b5c5aa07dd1b455779625d91b175373.1707730902.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, shuah@kernel.org, vinicius.gomes@intel.com,
 willemb@google.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Feb 2024 10:43:31 +0100 you wrote:
> The mentioned test is failing in slow environments:
> 
>   # SO_TXTIME ipv4 clock monotonic
>   # ./so_txtime: recv: timeout: Resource temporarily unavailable
>   not ok 1 selftests: net: so_txtime.sh # exit=1
> 
> Tuning the tolerance in the test binary is error-prone and doomed
> to failures is slow-enough environment.
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: cope with slow env in so_txtime.sh test
    https://git.kernel.org/netdev/net/c/a7ee79b9c455

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



