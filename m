Return-Path: <linux-kselftest+bounces-27823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F81FA48EDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 03:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C67C16CCC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 02:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1434B14B08C;
	Fri, 28 Feb 2025 02:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YymxivtC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B8224D6;
	Fri, 28 Feb 2025 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710999; cv=none; b=jFU2VAiLNGWyb516qRrU7DEwqztc46DMtzksBsAuYx62vQs3A+2fZiiJkz49PCHwHtJ20cPjIQ1pBCQrESGZJy4kvp4+R08JwXdQdYD/SeMsvlAnnzUykwbL52iT96I93kGVOtG06FZ3dec7+I8vFmsTq6nu3ejCSnzHE4fvz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710999; c=relaxed/simple;
	bh=ydxu/skYurmAld4vb7S643yLAKc57hVF7vBSFY1pjPU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hWAW0ZAejwtX5h2lhu88zMUK0LYjrpm50k1IO5SGfofOp5rWXapMIDIUniXSraF4D2xM9KxzTHYRbxS2CpI3HIAJyEBYa5m1LSnHlh0i+pF8dHvJ04dI9yOVNGZD9Z4c39o0U0/QGUy8w3iOUI5TMtOyHfZ5kaRB4NoruymcaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YymxivtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCE3C4CEDD;
	Fri, 28 Feb 2025 02:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740710998;
	bh=ydxu/skYurmAld4vb7S643yLAKc57hVF7vBSFY1pjPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YymxivtCeZTphclh1mW2FSkq66ehF5xMsP6BU2pTHt2fO2EiJkm3VDw7JxUrij8Pq
	 H3Vlt8dkB+TyYkiUElZDSHs7U8RuBRjL2Aco1pOckVRgqO1l1Of/ZJrribb4JQ0T8E
	 cn0yt2ZNdFv00+l8F25OYnRZ2P/dF4OKtYq+ADDBzQp2srVGblT4P0cSKNJHFmixVo
	 bjVtknKh86DAaSLr7hu+ovpdWUab4YbQlkBLbZSVYGAi9FH+i/ZtjSHzlKLdoHAhdj
	 Bx6Qrm0XwEaode9SZkY0FXzViR0k2BQ0zGbBPxEEUs3g44ioPCr3F8D49DZGIi/zMr
	 Ktm7ed+8qgDeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDA8380AACB;
	Fri, 28 Feb 2025 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] selftests/net: deflake GRO tests and fix return value
 and output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174071103050.1664035.10238417641881750067.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 02:50:30 +0000
References: <20250226192725.621969-1-krakauer@google.com>
In-Reply-To: <20250226192725.621969-1-krakauer@google.com>
To: Kevin Krakauer <krakauer@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Feb 2025 11:27:22 -0800 you wrote:
> The GRO selftests can flake and have some confusing behavior. These
> changes make the output and return value of GRO behave as expected, then
> deflake the tests.
> 
> v2:
> - Split into multiple commits.
> - Reduced napi_defer_hard_irqs to 1.
> - Reduced gro_flush_timeout to 100us.
> - Fixed comment that wasn't updated.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] selftests/net: have `gro.sh -t` return a correct exit code
    https://git.kernel.org/netdev/net-next/c/784e6abd99f2
  - [v2,2/3] selftests/net: only print passing message in GRO tests when tests pass
    https://git.kernel.org/netdev/net-next/c/41cda5728470
  - [v2,3/3] selftests/net: deflake GRO tests
    https://git.kernel.org/netdev/net-next/c/51bef03e1a71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



